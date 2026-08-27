local DynEpEntChoiceData = class("DynEpEntChoiceData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynEpEntChoiceData.CreateChoiceData(idx, msgData)
  local data = DynEpEntChoiceData.New()
  data:InitDynEpEnChoiceData(idx, msgData)
  return data
end

function DynEpEntChoiceData:ctor()
end

function DynEpEntChoiceData:InitDynEpEnChoiceData(idx, msgData)
  self.idx = idx
  self.choiceId = msgData.id
  self.isRandom = msgData.random
  self.catId = msgData.cat
  self.isUesed = msgData.isUesed
  self.isAble = false
  self.cfg = self:_GetChoiceCfg(msgData.cat)
  self.displayNewData = self:_AnalysisChoiceGetNew(self.cfg)
end

function DynEpEntChoiceData:_GetChoiceCfg(catId)
  local cfg
  if catId == ExplorationEnum.eEventRoomChoiceType.Normal then
    cfg = ConfigData.event_choice[self.choiceId]
    if cfg == nil then
      error("Can`t find choiceCfg id:" .. tostring(self.choiceId))
      return
    end
  elseif catId == ExplorationEnum.eEventRoomChoiceType.Upgrade then
    cfg = ConfigData.event_upgrade[self.choiceId]
  elseif catId == ExplorationEnum.eEventRoomChoiceType.Jump then
    cfg = ConfigData.event_jump[self.choiceId]
  elseif catId == ExplorationEnum.eEventRoomChoiceType.Assist then
    cfg = ConfigData.event_assist[self.choiceId]
  elseif catId == ExplorationEnum.eEventRoomChoiceType.AssistEx then
    cfg = ConfigData.event_assist_ex[self.choiceId]
  else
    error("Unsupported eEventRoomChoiceType, id = " .. tostring(self.choiceId))
    return
  end
  return cfg
end

function DynEpEntChoiceData:_AnalysisChoiceGetNew(cfg)
  local displayNewData
  if cfg.ignore_onboard then
    return nil
  end
  local getItems = cfg.choiceGetNew
  if getItems ~= nil and 0 < #getItems then
    for _, v in ipairs(getItems) do
      if v.dataType == eEpEvtChoiceGetNewType.item then
        if ConfigData:GetItemType(v.dataId) == ConfigData:GetItemType(v.dataId) then
          displayNewData = {}
          displayNewData.type = v.dataType
          displayNewData.dataId = v.dataId
          displayNewData.dataNum = v.dataNum
          return displayNewData
        end
      elseif v.dataType == eEpEvtChoiceGetNewType.expBuff then
        local buffCfg = ConfigData.exploration_buff[v.dataId]
        if buffCfg == nil then
          error("找不到对应的探索buff配置,id:" .. v.dataId)
        end
        if buffCfg.is_onboard then
          displayNewData = {}
          displayNewData.type = v.dataType
          displayNewData.dataId = v.dataId
          return displayNewData
        end
      end
    end
  end
  return displayNewData
end

function DynEpEntChoiceData:SetIsAble(bIsAble)
  if self.isUesed then
    self.isAble = false
  else
    self.isAble = bIsAble
  end
end

return DynEpEntChoiceData
