local BdConvertBuildDetailCtrl = class("BdConvertBuildDetailCtrl", BaseCtrl)
BdConvertBuildDetailCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  TMPBuildSaveTime = {sComponentName = "TMP_Text"},
  btnRename = {},
  btn_Preference = {},
  txtBuildLock = {sComponentName = "TMP_Text"},
  btn_Lock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  btn_LockIcon = {sComponentName = "Button"},
  btnDelete = {},
  ani_root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  BuildDetail = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildDetailItemCtrl"
  },
  ContentList = {
    sCtrlName = "Game.UI.StarTower.Build.StarTowerBuildContentCtrl"
  }
}
BdConvertBuildDetailCtrl._mapEventConfig = {}

function BdConvertBuildDetailCtrl:InitPanel()
  self._mapNode.btnRename:SetActive(false)
  self._mapNode.btn_Preference:SetActive(false)
  self._mapNode.btnDelete:SetActive(false)
  if not self.mapBuild.bDetail then
    print("build数据错误 无详细数据")
    return
  end
  self._mapNode.BuildDetail:Refresh(self.mapBuild)
  self._mapNode.ContentList:Refresh(self.mapBuild)
  self._mapNode.btn_LockIcon.interactable = self.mapBuild.bLock
  NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.mapBuild.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
  NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.mapBuild.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
  NovaAPI.SetTMPText(self._mapNode.TMPBuildSaveTime, string.format("<color=#5e89b4>保存时间：</color>%s", os.date("%Y/%m/%d %H:%M", math.floor(self.mapBuild.nBuildId / 1.0E9))))
end

function BdConvertBuildDetailCtrl:OpenConfirmHint()
end

function BdConvertBuildDetailCtrl:Awake()
  self.tbCoinRate = ConfigTable.GetConfigArray("StarTowerBuildTransformParas")
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapBuild = tbParam[1]
    self.actData = tbParam[2]
  end
end

function BdConvertBuildDetailCtrl:OnEnable()
  self:InitPanel()
end

function BdConvertBuildDetailCtrl:OnDisable()
end

function BdConvertBuildDetailCtrl:OnDestroy()
end

function BdConvertBuildDetailCtrl:OnRelease()
end

function BdConvertBuildDetailCtrl:OnBtnClick_Preference(btn)
  local tbPreferenceCheckIn = {}
  local tbPreferenceCheckOut = {}
  
  local function callback()
    self._mapNode.btn_PreferenceIcon.interactable = self.mapBuild.bPreference
    NovaAPI.SetTMPColor(self._mapNode.txtLike, self.mapBuild.bPreference and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
  end
  
  if self.mapBuild.bPreference then
    table.insert(tbPreferenceCheckOut, self.mapBuild.nBuildId)
  else
    table.insert(tbPreferenceCheckIn, self.mapBuild.nBuildId)
  end
  PlayerData.Build:SetBuildPreference(tbPreferenceCheckIn, tbPreferenceCheckOut, callback)
end

function BdConvertBuildDetailCtrl:OnBtnClick_Lock(btn)
  local function callback()
    self._mapNode.btn_LockIcon.interactable = self.mapBuild.bLock
    
    NovaAPI.SetTMPText(self._mapNode.txtBuildLock, self.mapBuild.bLock and ConfigTable.GetUIText("RoguelikeBuild_Save_Lock") or ConfigTable.GetUIText("RoguelikeBuild_Save_Unlock"))
    NovaAPI.SetTMPColor(self._mapNode.txtBuildLock, self.mapBuild.bLock and Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764) or Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882))
  end
  
  self.actData:ChangeBuildLock(self.mapBuild.nBuildId, not self.mapBuild.bLock, callback)
end

function BdConvertBuildDetailCtrl:OnBtnClick_DeleteBuild(btn)
end

function BdConvertBuildDetailCtrl:OnBtnClick_Rename(btn)
end

function BdConvertBuildDetailCtrl:OnBtnClick_CharInfo(btn, nIndex)
  local nCharTid = self.mapBuild.tbChar[nIndex].nTid
  local tbChar = {
    self.mapBuild.tbChar[1].nTid,
    self.mapBuild.tbChar[2].nTid,
    self.mapBuild.tbChar[3].nTid
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, nCharTid, tbChar)
end

return BdConvertBuildDetailCtrl
