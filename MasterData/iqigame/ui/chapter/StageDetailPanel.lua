-- chunkname: @IQIGame\\UI\\Chapter\\StageDetailPanel.lua

local StageDetailPanel = {}
local TabList = require("IQIGame.UI.Common.TabList")
local MonsterDetailsView = require("IQIGame.UI.Chapter.MonsterDetailView_new")
local TerrainDetailView = require("IQIGame.UI.Chapter.TerrainDetailView_new")

function StageDetailPanel.New(gameObject)
	local tbl = Clone(StageDetailPanel)

	tbl:OnInit(gameObject)

	return tbl
end

function StageDetailPanel:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.monsterDetailsView = MonsterDetailsView.New(self.MonsterDetailsPanel)
	self.terrainDetailView = TerrainDetailView.New(self.TerrainDetailPanel)
	self.tabList = TabList.New(self.gameObject)

	self.tabList:AddItem(self.MonsterDetailToggle, self.monsterDetailsView)
	self.tabList:AddItem(self.TerrainDetailToggle, self.terrainDetailView)

	function self.delegateClose()
		self:OnClose()
	end

	self:OnAddListeners()
end

function StageDetailPanel:OnOpen(monsterTeamID)
	self.gameObject:SetActive(true)
	self.monsterDetailsView:SetData(monsterTeamID)

	local monsterTeamData = CfgMonsterTeamTable[monsterTeamID]

	self.terrainDetailView:SetData(monsterTeamData.MapIdFriendly, monsterTeamData.MapIdEnemy)

	self.MonsterDetailToggle:GetComponent("Toggle").isOn = true
end

function StageDetailPanel:OnClose(userData)
	self.gameObject:SetActive(false)
end

function StageDetailPanel:OnDestroy(userData)
	logDebug("StageDetailPanel:OnDestroy")
	self.tabList:RemoveAllItems()
	self.tabList:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function StageDetailPanel:OnAddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.delegateClose)
end

function StageDetailPanel:OnRemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.delegateClose)
end

return StageDetailPanel
