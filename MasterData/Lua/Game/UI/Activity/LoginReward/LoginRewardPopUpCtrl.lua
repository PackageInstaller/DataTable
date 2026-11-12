local LoginRewardPopUpCtrl = class("LoginRewardPopUpCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
LoginRewardPopUpCtrl._mapNodeConfig = {
  imgBlurredBg = {},
  imgBlurMask = {},
  rtContent = {
    sNodeName = "---Content---",
    sComponentName = "RectTransform"
  }
}
LoginRewardPopUpCtrl._mapEventConfig = {
  RefreshLoginRewardPanel = "OnEvent_RefreshLoginRewardPanel"
}
LoginRewardPopUpCtrl._mapRedDotConfig = {}
local sPrefabFolder = "UI_Activity/%s.prefab"

function LoginRewardPopUpCtrl:ShowLoginReward()
  if self.tbActivityList == nil or #self.tbActivityList == 0 then
    EventManager.Hit(EventId.ClosePanel, PanelId.LoginRewardPopUp)
    if nil ~= self.callback then
      self.callback()
    end
    return
  end
  local actData = table.remove(self.tbActivityList, 1)
  self._panel.nActId = actData:GetActId()
  self._panel.actData = PlayerData.Activity:GetActivityDataById(self._panel.nActId)
  if nil ~= self._panel.actData and self._panel.actData:CheckCanReceive() then
    self:RefreshActContent()
  else
    self:ShowLoginReward()
  end
end

function LoginRewardPopUpCtrl:RefreshActContent()
  self:ResetActContent()
  local mapActCfg = ConfigTable.GetData("LoginRewardControl", self._panel.nActId)
  if mapActCfg ~= nil then
    local sPrefabPath = string.format(sPrefabFolder, mapActCfg.PopUpUIAssets)
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
    local sCtrlPath = string.format("Game.UI.Activity.LoginReward.%s.LoginRewardPopUpCtrl_01", "_" .. self._panel.nActId)
    self.curPopUpCtrl = self:BindCtrlByNode(goObj, sCtrlPath)
    self.curPopUpCtrl:RefreshActData()
  end
end

function LoginRewardPopUpCtrl:ResetActContent()
  if nil ~= self.curPopUpCtrl then
    destroy(self.curPopUpCtrl.gameObject)
    self:UnbindCtrlByNode(self.curPopUpCtrl)
  end
  self.curPopUpCtrl = nil
end

function LoginRewardPopUpCtrl:Awake()
  self:ResetActContent()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.tbActivityList = tbParam[1]
    self.callback = tbParam[2]
  end
end

function LoginRewardPopUpCtrl:OnEnable()
  self._mapNode.rtContent.gameObject:SetActive(false)
  self._mapNode.imgBlurMask.gameObject:SetActive(false)
  self._mapNode.imgBlurredBg.gameObject:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.imgBlurMask.gameObject:SetActive(true)
    self._mapNode.rtContent.gameObject:SetActive(true)
    self:ShowLoginReward()
  end
  
  cs_coroutine.start(wait)
end

function LoginRewardPopUpCtrl:OnDisable()
end

function LoginRewardPopUpCtrl:OnDestroy()
end

function LoginRewardPopUpCtrl:OnEvent_RefreshLoginRewardPanel()
  if self.curPopUpCtrl == nil then
    self:ShowLoginReward()
  else
    self._panel.actData = PlayerData.Activity:GetActivityDataById(self._panel.nActId)
    self.curPopUpCtrl:RefreshActData()
    local nAnimTime = self.curPopUpCtrl:PlayOutAnim()
    if 0 < nAnimTime then
      self:AddTimer(1, nAnimTime, "ShowLoginReward", true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
    else
      self:ShowLoginReward()
    end
  end
end

return LoginRewardPopUpCtrl
