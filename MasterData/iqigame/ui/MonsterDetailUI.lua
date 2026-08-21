-- chunkname: @IQIGame\\UI\\MonsterDetailUI.lua

local MonsterDetailUI = {
	MonsterTeamCell = {},
	MonsterSkillCell = {}
}

MonsterDetailUI = Base:Extend("MonsterDetailUI", "IQIGame.Onigao.UI.MonsterDetailUI", MonsterDetailUI)

local monsterTeamCell = require("IQIGame.UI.Formation.MonsterInfo.MonsterTeamCell")

function MonsterDetailUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.Mould:SetActive(false)
	self.SkillItemMould:SetActive(false)

	function self.DelegateOnClickbtnHelp()
		self:OnClickbtnHelp()
	end

	function self.DelegateOnSelectMonster(monsterCid)
		self:OnClickMonster(monsterCid)
	end

	self.skillIntoContentRect = self.skillInfoContent:GetComponent("RectTransform")
end

function MonsterDetailUI:GetPreloadAssetPaths()
	return nil
end

function MonsterDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterDetailUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterDetailUI:GetBGM(userData)
	return nil
end

function MonsterDetailUI:OnOpen(userData)
	self.selectedMonster = nil

	for i, v in pairs(self.MonsterTeamCell) do
		v.gameObject:SetActive(false)
	end

	local totalCount = table.len(userData.MonsterTeam)

	for i, v in pairs(userData.MonsterTeam) do
		local cell = self.MonsterTeamCell[i]

		if not cell then
			local gameObject = UnityEngine.Object.Instantiate(self.Mould, self.monsterInfoContent.transform)

			cell = monsterTeamCell.New(gameObject, self)
			self.MonsterTeamCell[i] = cell
		end

		cell:Refresh(i, totalCount, v)
	end

	self.commonReturnBtn:SetHomeBtnState(userData.IsActiveHomeBtn == nil and true or userData.IsActiveHomeBtn)
end

function MonsterDetailUI:OnClose(userData)
	return
end

function MonsterDetailUI:OnAddListeners()
	self.btnHelp:GetComponent("Button").onClick:AddListener(self.DelegateOnClickbtnHelp)
	EventDispatcher.AddEventListener(EventID.FormationSelectMonsterChangeEvent, self.DelegateOnSelectMonster)
end

function MonsterDetailUI:OnRemoveListeners()
	self.btnHelp:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickbtnHelp)
	EventDispatcher.RemoveEventListener(EventID.FormationSelectMonsterChangeEvent, self.DelegateOnSelectMonster)
end

function MonsterDetailUI:OnPause()
	return
end

function MonsterDetailUI:OnResume()
	return
end

function MonsterDetailUI:OnCover()
	return
end

function MonsterDetailUI:OnReveal()
	return
end

function MonsterDetailUI:OnRefocus(userData)
	return
end

function MonsterDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterDetailUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function MonsterDetailUI:OnClickbtnHelp()
	EventDispatcher.Dispatch(EventID.FormationHelpEvent)
end

function MonsterDetailUI:OnClickMonster(monsterCid)
	local monsterConfig = CfgMonsterTable[monsterCid]

	LuaUtility.SetText(self.monsterNameText, monsterConfig.Name)
	LuaUtility.SetText(self.levelNumText, monsterConfig.Level)
	AssetUtil.LoadImage(self, BattleApi:GetMonsterHeadIconPath(monsterConfig.HeadIcon), self.monsterHeadIcon:GetComponent("Image"))

	if monsterConfig.MonsterType == 4 then
		self.Type.gameObject:SetActive(true)
	else
		self.Type.gameObject:SetActive(false)
	end

	local skills = Clone(monsterConfig.SkillShow)

	for i, v in pairs(self.MonsterSkillCell) do
		v.gameObject:SetActive(false)
	end

	table.sort(skills, function(a, b)
		local tempA = CfgSkillTable[a].SkillType == Constant.SkillType.TYPE_ULTIMATE and 1 or 0
		local tempB = CfgSkillTable[b].SkillType == Constant.SkillType.TYPE_ULTIMATE and 1 or 0

		return tempB < tempA
	end)

	for i, v in pairs(skills) do
		local cell = self.MonsterSkillCell[i]

		if not cell then
			cell = {}

			local gameObject = UnityEngine.Object.Instantiate(self.SkillItemMould, self.skillInfoContent.transform)

			cell.gameObject = gameObject

			LuaCodeInterface.BindOutlet(gameObject, cell)

			self.MonsterSkillCell[i] = cell
		end

		cell.gameObject:SetActive(true)

		local skillCfg = CfgSkillTable[v]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), cell.SkillIcon:GetComponent("Image"))
		LuaUtility.SetText(cell.effctContentText, skillCfg.EffectText)
		LuaUtility.SetText(cell.SkillTypeText, skillCfg.Name)
	end

	UIUtil.ReBuilderLayout(self.skillIntoContentRect)
end

return MonsterDetailUI
