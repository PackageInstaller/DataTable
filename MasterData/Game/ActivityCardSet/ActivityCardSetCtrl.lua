local ActivityCardSetCtrl = class("ActivityCardSetCtrl", ControllerBase)
local ActivityCardSetData = require("Game.ActivityCardSet.ActivityCardSetData")
local CardSetCtrl = require("Game.CardSet.CardSetCtrl")

function ActivityCardSetCtrl:OnInit()
  self._dataDic = {}
  self._cardSetCtrl = nil
end

function ActivityCardSetCtrl:InitActCardSetData(msgs)
  for i, msg in ipairs(msgs) do
    self:InitActCardSet(msg)
  end
end

function ActivityCardSetCtrl:InitActCardSet(msg)
  if msg == nil then
    return
  end
  if self._dataDic[msg.actId] ~= nil then
    self._dataDic[msg.actId]:UpdateCardSetData(msg)
    MsgCenter:Broadcast(eMsgEventId.OnCardSetRefresh)
  else
    local data = ActivityCardSetData.New()
    data:InitActCardSetData(msg)
    self._dataDic[msg.actId] = data
  end
end

function ActivityCardSetCtrl:OnCardSetActEnd(actId)
  self._dataDic[actId] = nil
  if table.IsEmptyTable(self._dataDic) then
    ControllerManager:DeleteController(ControllerTypeId.ActivityCardSet)
  end
end

function ActivityCardSetCtrl:GetCdStActData(actId)
  return self._dataDic[actId]
end

function ActivityCardSetCtrl:GetOneActCardSetData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityCardSetCtrl:GetCardSetPlayCtrl()
  if self._cardSetCtrl == nil then
    local cardSetCtrl = CardSetCtrl.New()
    cardSetCtrl:OnInit()
    self._cardSetCtrl = cardSetCtrl
  end
  return self._cardSetCtrl
end

function ActivityCardSetCtrl:ForceActCardSetNextIsReturn()
  self._forceNextIsReturn = true
end

function ActivityCardSetCtrl:OpenActCardSetUI(isReturn, formActData, closeFunc, battleReturnFunc)
  if self._forceNextIsReturn then
    isReturn = true
  end
  self._forceNextIsReturn = nil
  local actData = self:GetOneActCardSetData()
  local cardSetCtrl = self:GetCardSetPlayCtrl()
  cardSetCtrl:InitCardSetPlayMode(actData)
  cardSetCtrl:OpenCardEntranceUI(isReturn, formActData, closeFunc, battleReturnFunc)
end

function ActivityCardSetCtrl:ReSetReddotRoot(reddotNode, actId)
  local actData
  if actId ~= nil then
    actData = self:GetCdStActData(actId)
  else
    actData = self:GetOneActCardSetData()
  end
  if actData ~= nil then
    actData:ReSetActivityReddotRoot(reddotNode)
  end
end

function ActivityCardSetCtrl:OnDelete()
  if self._cardSetCtrl then
    self._cardSetCtrl:Delete()
    self._cardSetCtrl = nil
  end
  self._dataDic = nil
end

return ActivityCardSetCtrl
