local LocalData = require("GameCore.Data.LocalData")
local PopUpCooperation = class("PopUpCooperation", BaseCtrl)
PopUpCooperation._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnDontShow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DontShowAgain"
  },
  imgDontShow1 = {},
  imgDontShow2 = {}
}
PopUpCooperation._mapEventConfig = {}
PopUpCooperation._mapRedDotConfig = {}

function PopUpCooperation:ShowPopUp(id, callback, index)
  self.dontShowAgain = false
  self.popUpIndex = index
  self.nCurId = id
  self.callback = callback
  self.mapCfg = ConfigTable.GetData("PopUp", self.nCurId)
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.StartTime)
  if self.mapCfg.EndType == GameEnum.PopUpEndType.Date then
    self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.EndTime)
  elseif self.mapCfg.EndType == GameEnum.activityEndType.TimeLimit then
    self.nEndTime = self.nOpenTime + self.mapCfg.EndDuration * 86400
  end
  self:SetImgDontShow()
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function PopUpCooperation:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function PopUpCooperation:ClosePopUp(callback)
  if self.anim ~= nil then
    self.anim:Play("close", 0, 0)
    self:AddTimer(1, 0.1, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  elseif callback ~= nil then
    callback()
  end
end

function PopUpCooperation:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function PopUpCooperation:OnBtnClick_DontShowAgain()
  self.dontShowAgain = not self.dontShowAgain
  self:SetImgDontShow()
  LocalData.SetPlayerLocalData("Act_PopUp_DontShow" .. self.nCurId, self.dontShowAgain)
end

function PopUpCooperation:SetImgDontShow()
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
end

return PopUpCooperation
