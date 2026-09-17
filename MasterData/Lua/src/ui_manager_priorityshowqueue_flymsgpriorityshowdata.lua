local this = class("flyMsgPriorityShowData", require("ui.manager.priorityShowQueue.priorityShowData"))
local _uiViewTpl = L_GameTpl:getUiViewTpl()

function this:ctor(data)
  this.super.ctor(self, data)
  local uuid = data.uuid
  self.flyMsgType = data.flyMsgType
  local params = data.params
  local popup = params[1]
  local tpl = _uiViewTpl:getTplByName(self.flyMsgType)
  if tpl then
    self._priorityDataType = _uiViewTpl:getPanelType(tpl)
    self._priority = _uiViewTpl:getQueue(tpl)
    self._checkShowFunc = _uiViewTpl:getCheckshowfun(tpl)
    self._blockType = _uiViewTpl:getBlockIgnore(tpl)
  else
    printf("priorityShowQueueManager", "flyMsgType not in flyMsgPriorityMap ", self.flyMsgType)
    self._priorityDataType = L_ShowQueueConst.priorityDataType.flyMsg
    self._priority = L_ShowQueueConst.showQueueEnum.tip
  end
  self.uuid = uuid
  self.params = popup
end

function this:getDesc()
  local uuid = self.uuid or "nil"
  local flyMsgType = self.flyMsgType or "nil"
  local desc = "flyMsgType " .. flyMsgType .. " uuid " .. uuid .. this.super.getDesc(self)
  return desc
end

function this:playsound()
  L_AudioUtil.playSound("Play_SFX_System_HUD_General_Hint_L")
end

function this:doShow()
  this.super.doShow(self)
end

function this:doHide()
  this.super.doHide(self)
end

function this:checkStopGuide()
  local tpl = _uiViewTpl:getTplByName(self.flyMsgType)
  return _uiViewTpl:checkStopGuide(tpl)
end

function this:checkIsCurDataInter(flyMsgType, uuid)
  return self.uuid == uuid
end

return this
