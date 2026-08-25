local MaxTeamAwakerCount = 4
local MaxTeamWeaponCount = 4
local MaxTeamKeeperSkillCount = 2
local UICompPvpDraftPlayerTeam, Super = NewViewComponent("UICompPvpDraftPlayerTeam")

function UICompPvpDraftPlayerTeam:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_PVP_Item_RotationTeamInfoResource(uiNode)
  self._showCollectionTid = nil
end

function UICompPvpDraftPlayerTeam:OnBuildComponent()
end

function UICompPvpDraftPlayerTeam:OnEnterComponent()
  self:LoadAllLangFont(self.ui.Text_Player_Name)
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpDraftPlayerTeam:_UpdateViewData()
end

function UICompPvpDraftPlayerTeam:_GetPlayerData()
  do return PvpDraftModel.Instance.GetMyPlayerData end
  return PvpDraftModel.Instance.GetMyPlayerData, PvpDraftModel.Instance
end

function UICompPvpDraftPlayerTeam:_RefreshView()
  self:_RefreshPlayerBaseInfo()
  self:RefreshPlayerTeamByCollectList()
end

function UICompPvpDraftPlayerTeam:_RefreshPlayerBaseInfo()
  local playerData = self:_GetPlayerData()
  self:SetText(self.ui.Text_Player_Name, playerData.playerName)
  self:SetImage(self.ui.Image_Head, ItemDataUtils.GetAvatarIcon(playerData.icon))
  local isFirstHand = PvpDraftModel.Instance:IsPlayerFirstHand(playerData.uid)
  self:SetActive(self.ui.Group_Attack, isFirstHand)
  self:SetActive(self.ui.Group_Defend, not isFirstHand)
end

function UICompPvpDraftPlayerTeam:RefreshPlayerTeamByCollectList()
  local playerData = self:_GetPlayerData()
  local collectList = playerData.collectList
  if not collectList then
    return
  end
  local awakerList = {}
  local weaponList = {}
  local keeperSkillList = {}
  for _, tid in ipairs(collectList) do
    local collectionType = PvpCollectCfgUtils.GetCollectionType(tid)
    if collectionType == CommonDefine.PVPCollectionType.Awaker then
      table.insert(awakerList, tid)
    elseif collectionType == CommonDefine.PVPCollectionType.Weapon then
      table.insert(weaponList, tid)
    elseif collectionType == CommonDefine.PVPCollectionType.KeeperSkill then
      table.insert(keeperSkillList, tid)
    end
  end
  self:_RefreshViewComponent(awakerList, weaponList, keeperSkillList)
end

function UICompPvpDraftPlayerTeam:RefreshPlayerTeamByTeamData()
  local playerData = self:_GetPlayerData()
  local playerTeamData = playerData.teamData
  local awakerList = {}
  local weaponList = {}
  local keeperSkillList = {}
  for _, awakerInfo in ipairs(playerTeamData.awakerList or {}) do
    table.insert(awakerList, awakerInfo.tid)
  end
  for _, weaponInfo in ipairs(playerTeamData.weaponList or {}) do
    table.insert(weaponList, weaponInfo.tid)
  end
  for _, keeperSkillInfo in ipairs(playerTeamData.keeperSkillList or {}) do
    table.insert(keeperSkillList, keeperSkillInfo.tid)
  end
  self:_RefreshViewComponent(awakerList, weaponList, keeperSkillList)
end

function UICompPvpDraftPlayerTeam:_RefreshViewComponent(awakerList, weaponList, keeperSkillList)
  for i = 1, MaxTeamAwakerCount do
    local obj = self.ui["Item_Team_" .. i]
    local collectionTid = awakerList[i]
    self:AddViewComponentOnce(obj, UICompPvpDraftTeamItemAwaker, collectionTid, self:_GetPlayerData())
  end
  for i = 1, MaxTeamWeaponCount do
    local obj = self.ui["Item_Skill_" .. i]
    local collectionTid = weaponList[i]
    self:AddViewComponentOnce(obj, UICompPvpDraftTeamItemWeapon, collectionTid, self:_GetPlayerData())
  end
  for i = 1, MaxTeamKeeperSkillCount do
    local obj = self.ui["Item_KeyToken_" .. i]
    local collectionTid = keeperSkillList[i]
    self:AddViewComponentOnce(obj, UICompPvpDraftTeamItemKeeperSkill, collectionTid, self:_GetPlayerData())
  end
end

return UICompPvpDraftPlayerTeam
