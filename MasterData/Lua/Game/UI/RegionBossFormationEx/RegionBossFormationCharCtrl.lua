local RegionBossFormationCharCtrl = class("RegionBossFormationCharCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local typeof = _ENV.typeof
RegionBossFormationCharCtrl._mapNodeConfig = {
  trParent = {sComponentName = "Transform"},
  rtInfo = {
    sCtrlName = "Game.UI.TemplateEx.TemplateCharInfoCtrl"
  },
  btnSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  Animator = {sNodeName = "rtInfo", sComponentName = "Animator"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Formation_Btn_Info"
  },
  txtBtnEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainlineFormationDisc_HintEmpty"
  },
  txtLeader = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSub = {sComponentName = "TMP_Text", sLanguageId = "Build_Sub"}
}
RegionBossFormationCharCtrl._mapEventConfig = {}

function RegionBossFormationCharCtrl:OnRender(tbTeamMemberId, index, nBuildSource)
  self._bLimitedTrialBuild = nBuildSource == AllEnum.BuildSource.LimitedTrial
  self:RefreshDetailVisible()
  self._bCanViewDetail = false
  self._mapNode.btnDetail.interactable = false
  if tbTeamMemberId[index] == nil then
    self._mapNode.btnAdd.gameObject:SetActive(false)
    self._mapNode.rtInfo.gameObject:SetActive(false)
    return
  end
  self.mIndex = index
  self.nCharId = tbTeamMemberId[index].nTid
  self._mapNode.btnAdd.gameObject:SetActive(self.nCharId <= 0)
  self._mapNode.rtInfo.gameObject:SetActive(self.nCharId > 0)
  if self.nCharId > 0 then
    local tbTeamId = {}
    for _, v in pairs(tbTeamMemberId) do
      table.insert(tbTeamId, v.nTid)
    end
    self.tbTeamId = tbTeamId
    local mapCharData = PlayerData.Char:GetCharDataByTid(self.nCharId)
    self._bCanViewDetail = nBuildSource ~= AllEnum.BuildSource.LimitedTrial and nBuildSource ~= AllEnum.BuildSource.Trial and mapCharData ~= nil
    self._mapNode.btnDetail.interactable = self._bCanViewDetail
    local mapCharCfgData = ConfigTable.GetData_Character(self.nCharId)
    local nTrialId = tbTeamMemberId[index].nTrialId
    local mapTrailCfg
    if nTrialId then
      mapTrailCfg = ConfigTable.GetData("TrialCharacter", nTrialId)
    end
    self._mapNode.rtInfo:Refresh(mapCharData, mapCharCfgData, mapTrailCfg)
    self._mapNode.Animator:Play("rtInfo_up")
  end
end

function RegionBossFormationCharCtrl:ShowRawImage(nCharId)
  local mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(nCharId))
  if not mapSkin then
    self.mData = nil
    return
  else
    self.mData = mapSkin
  end
  
  local function callback(obj)
    if not self.mActive then
      return
    end
    self:showModel(obj)
  end
  
  local sFullPath = string.format("%s.prefab", GameResourceLoader.RootPath, mapSkin.Model)
  self:LoadAssetAsync(sFullPath, typeof(GameObject), callback)
end

function RegionBossFormationCharCtrl:OnEnable()
  self.mActive = true
end

function RegionBossFormationCharCtrl:OnDisable()
  self.mActive = false
end

function RegionBossFormationCharCtrl:OnBtnClick_Select(btn)
  local sTip = ConfigTable.GetUIText("RegionBoss_Member_CannotBeChanged")
  EventManager.Hit(EventId.OpenMessageBox, sTip)
end

function RegionBossFormationCharCtrl:RefreshDetailVisible(bStoryTrial)
  if bStoryTrial ~= nil then
    self._bStoryTrial = bStoryTrial
  end
  self._mapNode.btnDetail.gameObject:SetActive(not self._bLimitedTrialBuild and not self._bStoryTrial)
end

function RegionBossFormationCharCtrl:OnBtnClick_Detail(btn)
  if not self._bCanViewDetail or PlayerData.Char:GetCharDataByTid(self.nCharId) == nil then
    return
  end
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self.tbTeamId ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, self.nCharId, self.tbTeamId, false)
  end
end

return RegionBossFormationCharCtrl
