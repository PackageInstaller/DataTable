local ParticleSystem = CS.UnityEngine.ParticleSystem
local DBGTeamChooseAwakerItem, Super = System.NewComponent("DBGTeamChooseAwakerItem")

function DBGTeamChooseAwakerItem:ctor(res, dbgTeamBuildModel, awakerData, clickCb, type)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_ListResource(res)
  self.model = dbgTeamBuildModel
  self.awakerData = awakerData
  self.clickCb = clickCb
  self.type = type
end

function DBGTeamChooseAwakerItem:OnBind(binder)
  self.ui.Particle_Click:SetActive(false)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Image_AttrBonus, function()
    if self.model.stageGroupType ~= CommonDefine.StageGroupType.DailyChallenge then
      return false
    end
    local strongAwakerTidList = DailyChallengeDataUtils.GetStrongAwakers()
    return strongAwakerTidList and table.contains(strongAwakerTidList, self.awakerData.tid)
  end)
  binder:BindToText(self.ui.Text_AttrBonus, function()
    do return LT.Text end
    return LT.Text, "DailyChallengeAttrBonus"
  end)
  binder:BindToVisible(self.ui.Image_wrong, function()
    return self:IsWrongCareer() or self:IsNoFight() or self.model:IsBanTid(self.awakerData.tid)
  end)
  binder:BindToText(self.ui.Text_Wrong, function()
    if self:IsWrongCareer() then
      do return LT.Text end
      return LT.Text, "Formation_SelectRole_DifferentOccupation_String", nil
    elseif self:IsNoFight() or self.model:IsBanTid(self.awakerData.tid) then
      do return LT.Text end
      return LT.Text, "Formation_SelectRole_NotBattle_String", self.awakerData.tid
    end
  end)
  binder:BindToVisible(self.ui.Image_NOFight, function()
    if self.model:IsSpecialTeamAssignBan(self.awakerData.tid) then
      return false
    end
    do return self.HasTheSameAwaker end
    return self.HasTheSameAwaker, self, self.awakerData.tid
  end)
  binder:BindToVisible(self.ui.Image_Disable, function()
    do return self.model.IsSpecialTeamAssignBan, self.model end
    return self.model.IsSpecialTeamAssignBan, self.model, self.awakerData.tid
  end)
  binder:BindToVisible(self.ui.Group_None, function()
    do return self.model.IsSpecialTeamAssignBan, self.model end
    return self.model.IsSpecialTeamAssignBan, self.model, self.awakerData.tid
  end)
  binder:BindToText(self.ui.Text_Fight, function()
    do return LT.Text end
    return LT.Text, "Formation_SelectRole_NotBattle_String"
  end)
  binder:BindToImage(self.ui.Image_Career_Icon, function()
    local awakerTid = self:GetAbsTid()
    local awakerConfig = self.model:GetAwakerConfig(awakerTid)
    local iconPath = self.model:GetSchoolIcon(awakerConfig.School)
    return iconPath
  end)
  binder:BindToVisible(self.ui.Image_Collect, function()
    return self.awakerData.isCollect
  end)
  binder:BindToVisible(self.ui.Image_IconHelp, function()
    if self.type == self.model.BuildTeamType.ChooseBuild then
      do return self.model.InTeamAndNotCurSelect, self.model end
      return self.model.InTeamAndNotCurSelect, self.model, self.awakerData.tid
    else
      return false
    end
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    if self.type == self.model.BuildTeamType.ChooseBuild then
      return self.model.curBuildingAwakerTeam[self.model.curAwakerSlot] == self.awakerData.tid
    end
    return false
  end)
  binder:BindToVisible(self.ui.Image_Select_Bg, function()
    if self:IsWrongCareer() then
      return false
    end
    if self.type == self.model.BuildTeamType.QuickBuild then
      do return self.model.QuickBuildCanSelect, self.model end
      return self.model.QuickBuildCanSelect, self.model, self.awakerData.tid
    end
    return false
  end)
  binder:BindToVisible(self.ui.Image_OwnedAwaker, System.fn(self, self.GetOnwedAwakerTypeStr))
  binder:BindToText(self.ui.Text_OwnedAwaker, System.fn(self, self.GetOnwedAwakerTypeStr))
  binder:BindToText(self.ui.Text_Level, function()
    local level = self.model.teamType == CommonDefine.TeamType.Daily and 1 or nil
    local showText = self.model:GetSortTypeTagContent(self.model.sortType, table.deepclone(self.awakerData), level)
    return showText
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return AwakerDataUtils.GetAwakerBust, self:GetAbsTid() end
    return AwakerDataUtils.GetAwakerBust, self:GetAbsTid()
  end)
  binder:BindToImage(self.ui.Image_D_Quality_Color, function()
    do return AwakerDataUtils.GetAwakerQualityColor, self:GetAbsTid() end
    return AwakerDataUtils.GetAwakerQualityColor, self:GetAbsTid()
  end)
  self:_BindPotencyShow(binder)
  self:_BindAwakerFavor(binder)
end

function DBGTeamChooseAwakerItem:GetOnwedAwakerTypeStr()
  if self.awakerData.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker then
    do return LT.Text end
    return LT.Text, "SpecialTeamPreset"
  end
  if self.awakerData.IsOwnedAwaker == cd.TeamAssignAwaker.Trail then
    do return LT.Text end
    return LT.Text, "SpecialTeamTryOut"
  end
end

function DBGTeamChooseAwakerItem:OnClick()
  if not self.awakerData or not self.clickCb then
    return
  end
  self.clickCb()
  self:PlayCLickParticle()
end

function DBGTeamChooseAwakerItem:PlayCLickParticle()
  self.ui.Particle_Click:SetActive(true)
  local particleObj = self.ui.Particle_Click:GetComponent(typeof(ParticleSystem))
  particleObj:Stop()
  particleObj:Play()
end

function DBGTeamChooseAwakerItem:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potencyLevel = potency}))
  end, function()
    return {
      self:GetAbsTid(),
      self:GetPotency()
    }
  end)
end

function DBGTeamChooseAwakerItem:_BindAwakerFavor(binder)
  if not self.ui.Image_AwakerFavor then
    return
  end
  binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, (self:GetAbsTid()) end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, self:GetAbsTid(), self.awakerData
  end)
end

function DBGTeamChooseAwakerItem:HasTheSameAwaker()
  if self.type == self.model.BuildTeamType.ChooseBuild then
    do return self.model.CheckChangerFormAwaker, self.model, table.clone(self.model.teamAwakerTids), self.model.curAwakerSlot, self:GetAbsTid() end
    return self.model.CheckChangerFormAwaker, self.model, table.clone(self.model.teamAwakerTids), self.model.curAwakerSlot, self:GetAbsTid()
  end
  return false
end

function DBGTeamChooseAwakerItem:GetPotency()
  local awakerData = self.awakerData
  if not awakerData or not table.next(awakerData) then
    return 0
  end
  if awakerData.potencyLevel then
    return awakerData.potencyLevel
  end
  if awakerData.potency then
    do return AwakerDataUtils.GetAwakerPotencyIndex, (math.abs(awakerData.tid)) end
    return AwakerDataUtils.GetAwakerPotencyIndex, math.abs(awakerData.tid), awakerData.potency
  end
  return 0
end

function DBGTeamChooseAwakerItem:IsWrongCareer()
  local validSchoolMap = self.model:GetValidSchoolMap()
  local schoolId = DT.AwakerConfig[self:GetAbsTid()].School
  local result = not validSchoolMap[schoolId]
  return result
end

function DBGTeamChooseAwakerItem:IsNoFight()
  do return self.model.IsForbidden, self.model end
  return self.model.IsForbidden, self.model, self.awakerData.tid
end

function DBGTeamChooseAwakerItem:GetAbsTid()
  do return math.abs end
  return math.abs, self.awakerData.tid
end

return DBGTeamChooseAwakerItem
