-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillPreviewView.lua

local HeadItem = {
	battleUnitID = 0
}

function HeadItem.New(view)
	local obj = Clone(HeadItem)

	obj:__Init(view)

	return obj
end

function HeadItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnHeadClick()
		self:__OnHeadClick()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnHeadClick)
end

function HeadItem:Show(battleUnitData)
	self.gameObject:SetActive(true)

	self.battleUnitID = battleUnitData.battleUnitID

	local headIconPath = BattleModule.GetBattleUnitHeadIcon(self.battleUnitID)

	AssetUtil.LoadImage(self, headIconPath, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))
	self:RefreshSelectState(false)
end

function HeadItem:__OnHeadClick()
	BattleTeamActionModule.SetManualMoverID(self.battleUnitID)
end

function HeadItem:RefreshSelectState(isSelect)
	self.selectTarget.gameObject:SetActive(isSelect)
	self.selectBottomRoot.gameObject:SetActive(isSelect)
end

function HeadItem:Hide()
	self.battleUnitID = 0

	self.gameObject:SetActive(false)
end

function HeadItem:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnHeadClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local View = {
	skillDetail = {},
	enemyHeads = {}
}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	LuaCodeInterface.BindOutlet(self.skillDetailView, self.skillDetail)
	ForTransformChild(self.enemyRoot.transform, function(_trans, _index)
		local item = HeadItem.New(_trans.gameObject)

		table.insert(self.enemyHeads, item)
	end)

	function self.__delegateOnRefreshBattleSkillTargetRolePreview()
		self:__OnRefreshBattleSkillTargetRolePreview()
	end

	function self.__delegateOnHideBattleSkillTopTipsView()
		self.skillDetailView.gameObject:SetActive(false)
	end
end

function View:Show()
	self.gameObject:SetActive(true)

	local tempIndex = 1

	BattleModule.ForeachBattleUnits(function(_unitId, _unitData)
		if _unitData.troopType ~= BattleModule.defineBattleTroopType then
			return
		end

		if _unitData:IsDead() then
			return
		end

		local headItem = self.enemyHeads[tempIndex]

		if headItem == nil then
			return
		end

		headItem:Show(_unitData)

		tempIndex = tempIndex + 1
	end)
	ForArray(self.enemyHeads, function(_index, _headItem)
		if _index < tempIndex then
			return
		end

		_headItem:Hide()
	end)
	EventDispatcher.AddEventListener(EventID.RefreshBattleSkillTargetRolePreview, self.__delegateOnRefreshBattleSkillTargetRolePreview)
	EventDispatcher.AddEventListener(EventID.HideBattleSkillTopTipsView, self.__delegateOnHideBattleSkillTopTipsView)
end

function View:RefreshSkillSelect(battleSkillData)
	self.skillDetailView.gameObject:SetActive(true)

	local skillConfig = CfgSkillTable[battleSkillData.configID]
	local iconPath = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, iconPath, self.skillDetail.skillIcon:GetComponent(typeof(UnityEngine.UI.Image)))

	self.skillDetail.skillNameText.gameObject:GetComponent("Text").text = skillConfig.Name
	self.skillDetail.energyNumText.gameObject:GetComponent("Text").text = battleSkillData.apCost
	self.skillDetail.cdText.gameObject:GetComponent("Text").text = battleSkillData.sustainCD
	self.skillDetail.skillDetailText.gameObject:GetComponent("Text").text = self:__GetSkillTips(battleSkillData)

	if LuaUtility.StrIsNullOrEmpty(battleSkillData.searchTargetData.SkillRangeImg) then
		self.skillDetail.rangeImage.gameObject:SetActive(false)
	else
		self.skillDetail.rangeImage.gameObject:SetActive(true)

		local path = UIGlobalApi.GetImagePath(battleSkillData.searchTargetData.SkillRangeImg)

		AssetUtil.LoadImage(self, path, self.skillDetail.rangeImage.gameObject:GetComponent("Image"))
	end
end

function View:__GetSkillTips(skillData)
	local exist, skillLevelConfig = RoleDevelopmentModule.GetSkillCfgByIDAndLv(skillData.configID, skillData.level - 1)

	if not exist then
		return ""
	end

	return UIGlobalApi.GetDescribeMatchTable(skillLevelConfig.SkillTips, function(_index, _formatType)
		local str = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, skillLevelConfig.UpGradeOldValue[_index])

		return RoleDevelopmentApi:GetPromoteStrNotIncludNext(str)
	end)
end

function View:__OnRefreshBattleSkillTargetRolePreview()
	local manualOperateMoverID = BattleTeamActionModule.GetManualOperateID()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(manualOperateMoverID)

	ForArray(self.enemyHeads, function(k, _headItem)
		local isSelect = _headItem.battleUnitID == manualOperateMoverID

		_headItem:RefreshSelectState(isSelect)
	end)

	if battleUnitData.previewSkillData == nil then
		self.skillDetailView.gameObject:SetActive(false)

		return
	end

	if battleUnitData.previewSkillData.skillCid == 0 then
		self.skillDetailView.gameObject:SetActive(false)

		return
	end

	local skillData = battleUnitData:GetSkillData(battleUnitData.previewSkillData.skillCid)

	self:RefreshSkillSelect(skillData)
end

function View:Hide()
	EventDispatcher.RemoveEventListener(EventID.RefreshBattleSkillTargetRolePreview, self.__delegateOnRefreshBattleSkillTargetRolePreview)
	EventDispatcher.RemoveEventListener(EventID.HideBattleSkillTopTipsView, self.__delegateOnHideBattleSkillTopTipsView)
	self.gameObject:SetActive(false)
end

function View:Dispose()
	EventDispatcher.RemoveEventListener(EventID.RefreshBattleSkillTargetRolePreview, self.__delegateOnRefreshBattleSkillTargetRolePreview)
	EventDispatcher.RemoveEventListener(EventID.HideBattleSkillTopTipsView, self.__delegateOnHideBattleSkillTopTipsView)
	ForPairs(self.enemyHeads, function(_, _headItem)
		_headItem:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.skillDetailView, self.skillDetail)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return View
