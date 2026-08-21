-- chunkname: @IQIGame\\UI\\FormationAgentSkillSelectUI.lua

local FormationAgentSkillSelectUI = Base:Extend("FormationAgentSkillSelectUI", "IQIGame.Onigao.UI.FormationAgentSkillSelectUI", {
	agentSkillCellList = {},
	agentGridCellList = {}
})
local FormationAgentSkillSelectCell = require("IQIGame.UI.Formation.ItemCell.FormationAgentSkillSelectCell")
local FormationAgentSkillCell = require("IQIGame.UI.Formation.ItemCell.FormationAgentSkillCell")

function FormationAgentSkillSelectUI:OnInit()
	self:InitComponent()
	self:InitDelegation()
end

function FormationAgentSkillSelectUI:InitComponent()
	self.ChargeBtn = self.ChargeButton:GetComponent("Button")
	self.DischargeBtn = self.DischargeButton:GetComponent("Button")
end

function FormationAgentSkillSelectUI:InitDelegation()
	function self.DelegateOnClickCloseBtn()
		self:Hide()
	end

	function self.DelegateOnSelectSkill(cell)
		self:OnSelectSkill(cell)
	end

	function self.DelegateOnSelectGrid(cell)
		self:OnSelectGrid(cell)
	end

	function self.DelegateChargeAgentSkill()
		self:ChargeAgentSkill()
	end

	function self.DelegateDischargeAgentSkill()
		self:DischargeAgentSkill()
	end

	function self.DelegateRefresh()
		self:Refresh()
		self:RefreshAgentSkillDesc(self.skillData)
		self:OnSelectGrid(self.selectedGrid)
		self:OnSelectSkill(self.selectedSkill)
	end
end

function FormationAgentSkillSelectUI:OnDestroy()
	self:OnRemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil

	for i, v in ipairs(self.agentSkillCellList) do
		v:Dispose()
	end

	for i, v in ipairs(self.agentGridCellList) do
		v:Dispose()
	end
end

function FormationAgentSkillSelectUI:OnOpen()
	self.selectedGrid = nil
	self.selectedSkill = nil

	self:Refresh()
	self.gameObject:SetActive(true)
end

function FormationAgentSkillSelectUI:Refresh()
	self.agentSkillDataList = FormationModule.GetChargedAgentSkillDataList()

	local unlockConditionIDs = CfgFormationTable[FormationModule.TeamIndex].UnlockCondition

	for i, v in pairs(unlockConditionIDs) do
		local cell = self.agentGridCellList[i]

		if not cell then
			local gameObject = UnityEngine.Object.Instantiate(self.AgentSkillPrefab, self.AgentSkillGrid.transform)

			cell = FormationAgentSkillCell.New(gameObject, self, 2, i)
			self.agentGridCellList[i] = cell
		end

		cell:Refresh(self.agentSkillDataList[i])

		if not self.selectedGrid then
			self:OnSelectGrid(cell)
		end
	end

	for i, v in ipairs(self.agentSkillCellList) do
		v.gameObject:SetActive(false)
	end

	local type = CfgMonsterTeamTable[FormationModule.CfgDupStageOrStoryBattleCfg.MonsterTeam[1]].Type
	local agentSkillDataList = WarehouseModule.GetAgentSkillDataListByType(type)

	for i, skillData in pairs(agentSkillDataList) do
		local cell = self.agentSkillCellList[i]

		if not cell then
			local gameObject = UnityEngine.Object.Instantiate(self.agentSkillSelectItem, self.agentSkillSelectContent.transform)

			cell = FormationAgentSkillSelectCell.New(gameObject, self)
			self.agentSkillCellList[i] = cell
		end

		cell:Refresh(skillData)
		cell.gameObject:SetActive(true)

		if not self.selectedSkill then
			self:OnSelectSkill(cell)
		end
	end
end

function FormationAgentSkillSelectUI:OnClose(userData)
	return
end

function FormationAgentSkillSelectUI:OnAddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ChargeBtn.onClick:AddListener(self.DelegateChargeAgentSkill)
	self.DischargeBtn.onClick:AddListener(self.DelegateDischargeAgentSkill)
	EventDispatcher.AddEventListener(EventID.GoIntoBattleSuccessEvent, self.DelegateRefresh)
end

function FormationAgentSkillSelectUI:OnRemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ChargeBtn.onClick:RemoveListener(self.DelegateChargeAgentSkill)
	self.DischargeBtn.onClick:RemoveListener(self.DelegateDischargeAgentSkill)
	EventDispatcher.RemoveEventListener(EventID.GoIntoBattleSuccessEvent, self.DelegateRefresh)
end

function FormationAgentSkillSelectUI:OnSelectGrid(cell)
	if self.selectedGrid then
		self.selectedGrid:SetSelect(false)
	end

	self.selectedGrid = cell

	self.selectedGrid:SetSelect(true)

	if self.selectedGrid.skillData then
		self:RefreshAgentSkillDesc(self.selectedGrid.skillData)
	end
end

function FormationAgentSkillSelectUI:OnSelectSkill(cell)
	if self.selectedSkill then
		self.selectedSkill:SetSelect(false)
	end

	self.selectedSkill = cell

	self.selectedSkill:SetSelect(true)

	if self.selectedSkill.skillData then
		self:RefreshAgentSkillDesc(self.selectedSkill.skillData)
	end
end

function FormationAgentSkillSelectUI:Hide()
	UIModule.CloseSelf(self)
end

function FormationAgentSkillSelectUI:ShowAgentSkillDetail(skillData)
	self:RefreshAgentSkillDesc(skillData)
end

function FormationAgentSkillSelectUI:RefreshAgentSkillDesc(skillData)
	self.skillData = skillData

	local skillLevelCfg = CfgUtil.GetCfgSkillLevelDataWithID(skillData.skillCid)
	local currentLevelSkillCfg = skillLevelCfg[skillData.lv]

	LuaUtility.SetText(self.skillLevelText, skillData.lv)
	LuaUtility.SetText(self.skillTitleText, skillData:GetCfg().Name)
	LuaUtility.SetText(self.roleSkillDetailText, currentLevelSkillCfg.SkillTips)
	LuaUtility.SetText(self.roleSkillBackStoryText, currentLevelSkillCfg.SkillStory)

	if FormationModule.IsAgentSkillCharged(skillData.id) then
		self.ChargeButton:SetActive(false)
		self.DischargeButton:SetActive(true)
	else
		self.ChargeButton:SetActive(true)
		self.DischargeButton:SetActive(false)
	end
end

function FormationAgentSkillSelectUI:GetPreloadAssetPaths()
	return nil
end

function FormationAgentSkillSelectUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FormationAgentSkillSelectUI:IsManualShowOnOpen(userData)
	return false
end

function FormationAgentSkillSelectUI:GetBGM(userData)
	return nil
end

function FormationAgentSkillSelectUI:OnPause()
	return
end

function FormationAgentSkillSelectUI:OnResume()
	return
end

function FormationAgentSkillSelectUI:OnCover()
	return
end

function FormationAgentSkillSelectUI:OnReveal()
	return
end

function FormationAgentSkillSelectUI:OnRefocus(userData)
	return
end

function FormationAgentSkillSelectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FormationAgentSkillSelectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormationAgentSkillSelectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormationAgentSkillSelectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormationAgentSkillSelectUI:ChargeAgentSkill()
	self.agentSkillDataList[self.selectedGrid.tableIndex] = self.selectedSkill.skillData

	local agentSkill = {}

	for index, skill in pairs(self.agentSkillDataList) do
		agentSkill[skill.id] = index
	end

	FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill = agentSkill

	FormationModule.NotifyFormationChange()
end

function FormationAgentSkillSelectUI:DischargeAgentSkill()
	local agentSkill = {}

	for index, skill in pairs(self.agentSkillDataList) do
		if skill.id == self.selectedSkill.skillData.id then
			self.agentSkillDataList[index] = nil
		else
			agentSkill[skill.id] = index
		end
	end

	FormationModule.FormationDataList[FormationModule.TeamIndex].agentSkill = agentSkill

	FormationModule.NotifyFormationChange()
end

return FormationAgentSkillSelectUI
