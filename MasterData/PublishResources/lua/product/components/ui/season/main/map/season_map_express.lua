_class("SeasonMapExpress", Object)
SeasonMapExpress = SeasonMapExpress

function SeasonMapExpress:Constructor(eventPoint, expressCount, triggerType, expressArr)
  self._eventPoint = eventPoint
  self._count = expressCount
  self._triggerType = triggerType
  self._expressList = {}
  self._isLevel = false
  self._curExpressIndex = 0
  self._curExpress = nil
  self:_CreateExpress(expressArr)
end

function SeasonMapExpress:Update(deltaTime)
  if self._curExpress then
    self._curExpress:Update(deltaTime)
  end
end

function SeasonMapExpress:Dispose()
  for _, express in pairs(self._expressList) do
    express:Dispose()
  end
  table.clear(self._expressList)
end

function SeasonMapExpress:_CreateExpress(expressArr)
  for i = 1, #expressArr do
    local expressCfg = Cfg.cfg_season_map_express[expressArr[i]]
    if expressCfg then
      local express = SeasonMapExpressFactory:GetInstance():CreateMapExpress(self._eventPoint, expressCfg.ExpressType, expressCfg)
      if express then
        if express:ExpressType() == SeasonExpressType.Level then
          self._isLevel = true
        end
        table.insert(self._expressList, express)
      end
    end
  end
end

function SeasonMapExpress:TriggerType()
  return self._triggerType
end

function SeasonMapExpress:IsLevel()
  return self._isLevel
end

function SeasonMapExpress:Count()
  return self._count
end

function SeasonMapExpress:NeedCount()
  return self._count ~= nil and self._count > 0
end

function SeasonMapExpress:CurExpressIndex()
  return self._curExpressIndex
end

function SeasonMapExpress:PlayNext(param)
  if self._curExpressIndex >= #self._expressList then
    return true
  end
  self._curExpressIndex = self._curExpressIndex + 1
  self._curExpress = self._expressList[self._curExpressIndex]
  if self._curExpress then
    Log.info("SeasonMapExpress PlayNext ", self._eventPoint:GetID(), " progress = ", self._eventPoint:CurProgress(), " index = ", self._curExpressIndex)
    self._curExpress:Play(param)
  end
end

function SeasonMapExpress:ContainExpress(expressType)
  for index, express in pairs(self._expressList) do
    if express:ExpressType() == expressType then
      return true, express:Content(), index
    end
  end
  return false, nil, nil
end

function SeasonMapExpress:GetExpresses(expressType)
  local t
  for index, express in pairs(self._expressList) do
    if express:ExpressType() == expressType then
      t = t or {}
      table.insert(t, express)
    end
  end
  return t
end

function SeasonMapExpress:Reset()
  self._curExpress = nil
  self._curExpressIndex = 0
  for _, express in pairs(self._expressList) do
    express:Reset()
  end
end

function SeasonMapExpress:ResumePlay(expressIndex, param)
  if expressIndex > #self._expressList then
    Log.error("SeasonMapExpress ResumePlay fail. expressIndex error!", expressIndex, #self._expressList)
    return
  end
  self._curExpressIndex = expressIndex
  self._curExpress = self._expressList[self._curExpressIndex]
  if self._curExpress then
    self._curExpress:Play(param)
  end
end

function SeasonMapExpress:IsPlaying()
  for _, express in pairs(self._expressList) do
    if express:State() == SeasonExpressState.Playing then
      return true
    end
  end
  return false
end
