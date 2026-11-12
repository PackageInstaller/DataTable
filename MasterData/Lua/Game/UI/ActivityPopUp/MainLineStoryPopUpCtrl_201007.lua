local MainLineStoryPopUpCtrl_201007 = class("MainLineStoryPopUpCtrl_201007", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local ClientManager = CS.ClientManager.Instance
MainLineStoryPopUpCtrl_201007._mapNodeConfig = {
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_MainLine_Goto"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtActTime = {sComponentName = "TMP_Text"},
  btnDontShow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_DontShowAgain"
  },
  imgDontShow1 = {},
  imgDontShow2 = {},
  txtDontShow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_DontShow_PopUp_Again"
  }
}
MainLineStoryPopUpCtrl_201007._mapEventConfig = {}

function MainLineStoryPopUpCtrl_201007:ShowPopUp(actId, callback, index)
  self.popUpIndex = index
  self.dontShowAgain = false
  self.nCurActId = actId
  self.callback = callback
  self.mapPopUpCfg = ConfigTable.GetData("PopUp", self.nCurActId)
  if self.mapPopUpCfg ~= nil then
    local nStartTime = ClientManager:ISO8601StrToTimeStamp(self.mapPopUpCfg.StartTime)
    local sStartTime = os.date("%Y/%m/%d", nStartTime)
    NovaAPI.SetTMPText(self._mapNode.txtActTime, string.format("%s %s", sStartTime, ConfigTable.GetUIText("Activity_MainLine_Story_Open")))
  end
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function MainLineStoryPopUpCtrl_201007:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function MainLineStoryPopUpCtrl_201007:ClosePopUp(callback)
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

function MainLineStoryPopUpCtrl_201007:OnBtnClick_DontShowAgain()
  self.dontShowAgain = not self.dontShowAgain
  self._mapNode.imgDontShow1:SetActive(not self.dontShowAgain)
  self._mapNode.imgDontShow2:SetActive(self.dontShowAgain)
  LocalData.SetPlayerLocalData("Act_PopUp_DontShow" .. self.nCurActId, self.dontShowAgain)
end

function MainLineStoryPopUpCtrl_201007:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function MainLineStoryPopUpCtrl_201007:OnBtnClick_Goto()
  local function callback()
    if nil ~= self.nCurActId then
      PopUpManager.InterruptPopUp(self.popUpIndex)
      
      EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
      if self.mapPopUpCfg ~= nil then
        local jumpToId = self.mapPopUpCfg.JumpToParams
        JumpUtil.JumpTo(jumpToId)
      end
    end
  end
  
  self:ClosePopUp(callback)
end

return MainLineStoryPopUpCtrl_201007
