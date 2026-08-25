local PvpTeamImportView, Super = NewClass("PvpTeamImportView", BaseView)
PvpTeamImportView.uiResCls = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_Popup_ImportTeam.prefab"

function PvpTeamImportView:ctor(awakerTids, weaponTids, keeperSkillTids)
  Super.ctor(self)
  self.awakerTids = self:ConvertToTidList(awakerTids)
  self.weaponTids = self:ConvertToTidList(weaponTids)
  self.keeperSkillTids = self:ConvertToTidList(keeperSkillTids)
end

function PvpTeamImportView:OnBuildView()
end

function PvpTeamImportView:OnEnterView()
  self:_UpdateViewData()
end

function PvpTeamImportView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnConfirm))
end

function PvpTeamImportView:_UpdateViewData()
  self:SetAwakers(self.awakerTids)
  self:SetWeapons(self.weaponTids)
  self:SetKeeperSkills(self.keeperSkillTids)
end

function PvpTeamImportView:OnConfirm()
  local teamIdx = PvpModel.Instance:GetCurTeamIdx()
  PvPTeamBuildDataUtils.ReqUpdateTeam(teamIdx, self.awakerTids, self.weaponTids, self.keeperSkillTids, function()
    EventMgr.Instance.PVPTeamUpdate:Dispatch()
    self:Close()
  end)
end

function PvpTeamImportView:ConvertToTidList(tidDataList)
  if tidDataList[1] and type(tidDataList[1]) == "table" and tidDataList[1].tid then
    local tidList = {}
    for _, tidData in ipairs(tidDataList) do
      table.insert(tidList, tidData.tid)
    end
    return tidList
  end
  return tidDataList
end

function PvpTeamImportView:SetAwakers(awakerTids)
  for awakerIndex = 1, CommonDefine.PvpTeamImportAwakerCount do
    local gameObject = self.ui["Item_Team_" .. awakerIndex]
    local awakerTid = awakerTids[awakerIndex] or 0
    if 0 ~= awakerTid then
      self:AddViewComponentOnce(gameObject, PvpTeamImportComp, awakerTid)
    end
  end
end

function PvpTeamImportView:SetWeapons(weaponTids)
  for weaponIndex = 1, CommonDefine.PvpTeamImportWeaponCount do
    local gameObject = self.ui["Item_Skill_" .. weaponIndex]
    local weaponTid = weaponTids[weaponIndex] or 0
    if 0 ~= weaponTid then
      self:AddViewComponentOnce(gameObject, PvpTeamImportComp, weaponTid)
    end
  end
end

function PvpTeamImportView:SetKeeperSkills(keeperSkillTids)
  for keeperSkillIndex = 1, CommonDefine.PVPTeamKeeperSkillCount do
    local gameObject = self.ui["Item_KeyToken_" .. keeperSkillIndex]
    local keeperSkillTid = keeperSkillTids[keeperSkillIndex] or 0
    if 0 ~= keeperSkillTid then
      self:AddViewComponentOnce(gameObject, PvpTeamImportComp, keeperSkillTid)
    end
  end
end

return PvpTeamImportView
