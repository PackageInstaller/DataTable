local ActivityPopUpCtrl = class("ActivityPopUpCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
ActivityPopUpCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  goContent = {
    sNodeName = "---Content---"
  },
  imgActivity = {sComponentName = "Image"},
  btnGoto = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGoto = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_PopUp_Goto"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  PopUpRoot = {
    sNodeName = "---PopUpRoot---",
    sComponentName = "RectTransform"
  }
}
ActivityPopUpCtrl._mapEventConfig = {}

function ActivityPopUpCtrl:ShowPopUp()
  if self.tbPopUpAct == nil or #self.tbPopUpAct <= 0 then
    EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
    if self.callback ~= nil then
      self.callback()
    end
    return
  end
  self.popUpIndex = self.popUpIndex + 1
  self.nCurActId = table.remove(self.tbPopUpAct, 1)
  local popUpCfg = PlayerData.PopUp:GetPopUpConfigData(self.nCurActId)
  if popUpCfg == nil then
    self:ShowPopUp()
    return
  end
  self.curType = popUpCfg.PopUpType
  if self.tbPopUpCtrlObj ~= nil then
    if self.tbPopUpCtrlObj.go ~= nil then
      destroy(self.tbPopUpCtrlObj.go)
    end
    if self.tbPopUpCtrlObj.ctrl ~= nil then
      self:UnbindCtrlByNode(self.tbPopUpCtrlObj.ctrl)
    end
    self.tbPopUpCtrlObj = {}
  end
  local sPrefabPath = string.format("%s.prefab", popUpCfg.PopUpRes)
  local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.PopUpRoot)
  local ctrlName = popUpCfg.ScriptName
  local sCtrlPath = string.format("Game.UI.%s", ctrlName)
  local popupCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
  
  local function callback()
    self:OnBtnClick_Close()
  end
  
  popupCtrl:ShowPopUp(self.nCurActId, callback, self.popUpIndex)
  self.tbPopUpCtrlObj = {go = goObj, ctrl = popupCtrl}
  local saveTime = CS.ClientManager.Instance.serverTimeStamp
  if popUpCfg.PopRefreshType == GameEnum.PopRefreshType.WeeklyFirst then
    saveTime = GetNextWeekRefreshTime()
  end
  LocalData.SetPlayerLocalData("Act_PopUp" .. self.nCurActId, saveTime)
  self._mapNode.btnGoto.gameObject:SetActive(popUpCfg.PopJumpType ~= GameEnum.PopJumpType.None)
  PlayerData.PopUp:ReleaseCachedPopUpData(popUpCfg.Id)
end

function ActivityPopUpCtrl:IsPopUpType()
  return self.curType == GameEnum.PopUpType.ActivityGroup or self.curType == GameEnum.PopUpType.Activity or self.curType == GameEnum.PopUpType.OwnPopUP
end

function ActivityPopUpCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbPopUpAct = tbParam[1]
    self.callback = tbParam[2]
  end
  self.popUpIndex = 0
end

function ActivityPopUpCtrl:OnEnable()
  self._mapNode.goContent.gameObject:SetActive(false)
  self._mapNode.PopUpRoot.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    self._mapNode.PopUpRoot.gameObject:SetActive(self:IsPopUpType())
    if self.tbPopUpCtrlObj ~= nil and self.tbPopUpCtrlObj.ctrl ~= nil and self.tbPopUpCtrlObj.ctrl.PlayOpenAnim ~= nil then
      self.tbPopUpCtrlObj.ctrl:PlayOpenAnim()
    end
  end
  
  cs_coroutine.start(wait)
  self:ShowPopUp()
end

function ActivityPopUpCtrl:OnDisable()
end

function ActivityPopUpCtrl:OnDestroy()
end

function ActivityPopUpCtrl:OnRelease()
end

function ActivityPopUpCtrl:OnBtnClick_Close()
  self:ShowPopUp()
end

function ActivityPopUpCtrl:OnBtnClick_Goto()
  if nil ~= self.nCurActId then
    PopUpManager.InterruptPopUp(self.popUpIndex)
    EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
    local popUpCfg = PlayerData.PopUp:GetPopUpConfigData(self.nCurActId)
    if nil ~= popUpCfg then
      if popUpCfg.PopJumpType == GameEnum.PopJumpType.ActivityJump then
        if popUpCfg.PopUpType == GameEnum.PopUpType.Activity then
          PlayerData.Activity:OpenActivityPanel(self.nCurActId)
        end
      elseif popUpCfg.PopJumpType == GameEnum.PopJumpType.NormalJump then
      end
    end
  end
end

return ActivityPopUpCtrl
