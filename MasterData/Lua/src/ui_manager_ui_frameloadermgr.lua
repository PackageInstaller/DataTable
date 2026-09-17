local cls = class("frameLoaderMgr", G_EventManagerBase)
local OneFrameMaxCount = 10

function cls:ctor()
end

function cls:initialize()
  self.lowLoaders = {}
  self.mediumLoaders = {}
  self.highLoaders = {}
  self:stopTimer()
  self.timer = Timer.new(handler(self, self.update), 0.03, -1, false)
  self.timer:start()
end

function cls:dispose()
  self:stopTimer()
  self.lowLoaders = {}
  self.mediumLoaders = {}
  self.highLoaders = {}
end

function cls:stopTimer()
  if self.timer ~= nil then
    self.timer:stop()
    self.timer = nil
  end
end

function cls:addLoaderBetween(loader_func, target_obj, frameLoadCount, datas, startPos, endPos, priority, key)
  local t = {
    datas = datas,
    frameLoadCount = frameLoadCount,
    loader = loader_func,
    target_obj = target_obj,
    startPos = math.min(startPos or 1, #datas),
    endPos = endPos and math.min(endPos, #datas) or #datas
  }
  local key = self:getKey(loader_func, target_obj, key)
  priority = priority or L_Const.FrameLoadPriority.Medium
  if priority == L_Const.FrameLoadPriority.Low then
    self.lowLoaders[key] = t
  elseif priority == L_Const.FrameLoadPriority.High then
    self.highLoaders[key] = t
  elseif priority == L_Const.FrameLoadPriority.Medium then
    self.mediumLoaders[key] = t
  else
    C_MJLog.LogError("FrameLoaderMgr:AddLoader priority error")
  end
end

function cls:addLoader(loader_func, target_obj, frameLoadCount, datas, priority, key)
  if table.count(datas) == 0 then
    return nil
  end
  self:addLoaderBetween(loader_func, target_obj, frameLoadCount, datas, nil, nil, priority, key)
end

function cls:getKey(loader_func, target_obj, key)
  return (target_obj.name or target_obj.__name or target_obj.__cname) .. "\t" .. tostring(loader_func) .. "\t" .. (key or "")
end

function cls:removeLoader(loader_func, target_obj, priority, key)
  local key = self:getKey(loader_func, target_obj, key)
  priority = priority or L_Const.FrameLoadPriority.Medium
  if priority == L_Const.FrameLoadPriority.Low then
    self.lowLoaders[key] = nil
  elseif priority == L_Const.FrameLoadPriority.High then
    self.highLoaders[key] = nil
  elseif priority == L_Const.FrameLoadPriority.Medium then
    self.mediumLoaders[key] = nil
  else
    C_MJLog.LogError("FrameLoaderMgr:RemoveLoader priority error")
  end
end

function cls:update()
  local UpdateCount = OneFrameMaxCount
  for k, v in pairs(self.highLoaders) do
    if UpdateCount <= 0 then
      return
    end
    if v.startPos > v.endPos then
      self.highLoaders[k] = nil
    end
    local frameLoadCount = v.frameLoadCount
    while v.startPos <= v.endPos and 0 < frameLoadCount and 0 < UpdateCount do
      local state = v.loader(v.target_obj, v.datas, v.startPos)
      if state == nil then
        C_MJLog.LogError(k .. "FrameLoaderMgr:Update loader return nil")
      end
      if state == L_Const.FrameLoadState.Break then
        self.highLoaders[k] = nil
      elseif state == L_Const.FrameLoadState.Clone then
        frameLoadCount = frameLoadCount - 1
        UpdateCount = UpdateCount - 1
      elseif state == L_Const.FrameLoadState.FromPool then
      end
      v.startPos = v.startPos + 1
    end
  end
  for k, v in pairs(self.mediumLoaders) do
    if UpdateCount <= 0 then
      return
    end
    if v.startPos > v.endPos then
      self.mediumLoaders[k] = nil
    end
    local frameLoadCount = v.frameLoadCount
    while v.startPos <= v.endPos and 0 < frameLoadCount and 0 < UpdateCount do
      local state = v.loader(v.target_obj, v.datas, v.startPos)
      if state == L_Const.FrameLoadState.Break then
        self.mediumLoaders[k] = nil
      elseif state == L_Const.FrameLoadState.Clone then
        frameLoadCount = frameLoadCount - 1
        UpdateCount = UpdateCount - 1
      elseif state == L_Const.FrameLoadState.FromPool then
      end
      v.startPos = v.startPos + 1
    end
  end
  for k, v in pairs(self.lowLoaders) do
    if UpdateCount <= 0 then
      return
    end
    if v.startPos > v.endPos then
      self.lowLoaders[k] = nil
    end
    local frameLoadCount = v.frameLoadCount
    while v.startPos <= v.endPos and 0 < frameLoadCount and 0 < UpdateCount do
      local state = v.loader(v.target_obj, v.datas, v.startPos)
      if state == L_Const.FrameLoadState.Break then
        self.lowLoaders[k] = nil
      elseif state == L_Const.FrameLoadState.Clone then
        frameLoadCount = frameLoadCount - 1
        UpdateCount = UpdateCount - 1
      elseif state == L_Const.FrameLoadState.FromPool then
      end
      v.startPos = v.startPos + 1
    end
  end
end

return cls
