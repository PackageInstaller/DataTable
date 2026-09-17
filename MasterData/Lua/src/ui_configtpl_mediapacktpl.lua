local this = class("mediaPackTpl")

function this:init(config)
  self.data = {}
  self.oldData = {}
  for i, v in pairs(config) do
    self.data[v.mediaPackName] = v
  end
end

function this:getTplByKey(key)
  local tpl = self.data[key]
  if tpl then
    return tpl
  end
  tpl = self.oldData[key]
  if tpl then
    C_MJLog.LogWarning(string.format("***使用了旧版MediaPackName: %s，请修改!!!***", tostring(key)), C_ELogModule.Config)
    return tpl
  end
  return nil
end

function this:getPath(tpl)
  return tpl.vfxPrefab
end

function this:getLastTime(tpl)
  return tpl.vfxTime
end

function this:getSfxName(tpl)
  return tpl.sfxName
end

return this
