-- chunkname: @IQIGame\\UI\\BattleDetails\\BattleDetailElement.lua

local UITabList = require("IQIGame/UI/Common/UITabList")
local BuffItem = {}

function BuffItem.New(view)
	local obj = Clone(BuffItem)

	obj:__Init(view)

	return obj
end

function BuffItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function BuffItem:Show(battleBuffData)
	self.gameObject:SetActive(true)

	local buffConfig = CfgBuffTable[battleBuffData.cid]

	if not LuaUtility.StrIsNullOrEmpty(buffConfig.Icon) then
		self.Icon.gameObject:SetActive(true)

		local iconPath = BattleApi:GetAttributeIconUrl(buffConfig.Icon)

		AssetUtil.LoadImage(self, iconPath, self.Icon:GetComponent(typeof(UnityEngine.UI.Image)))
	else
		self.Icon.gameObject:SetActive(false)
	end

	self.nameText:GetComponent("Text").text = buffConfig.Name
	self.descText:GetComponent("Text").text = battleBuffData:GetTipsText()

	if battleBuffData.stack > 0 then
		if buffConfig.StackMaxNumber > 1 then
			self.stackText.gameObject:SetActive(true)

			self.stackText:GetComponent("Text").text = battleBuffData.stack
		else
			self.stackText.gameObject:SetActive(false)
		end
	else
		self.stackText.gameObject:SetActive(false)
	end

	if battleBuffData.leftCount > 0 then
		self.timeRoot.gameObject:SetActive(true)

		self.timeText:GetComponent("Text").text = BattleUIApi:GetBuffLeftCountText(battleBuffData.leftCount)
	else
		self.timeRoot.gameObject:SetActive(false)
	end
end

function BuffItem:Hide()
	self.gameObject:SetActive(false)
end

function BuffItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillItem = {}

function SkillItem.New(view)
	local obj = Clone(SkillItem)

	obj:__Init(view)

	return obj
end

function SkillItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SkillItem:Show(battleSkillData)
	self.gameObject:SetActive(true)

	local skillConfig = CfgSkillTable[battleSkillData.skillCid]
	local path = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, path, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))

	self.nameText:GetComponent("Text").text = skillConfig.Name
	self.apCostText:GetComponent("Text").text = battleSkillData.apCost
	self.coolDownText:GetComponent("Text").text = battleSkillData.sustainCD

	if LuaUtility.StrIsNullOrEmpty(battleSkillData.searchTargetData.SkillRangeImg) then
		self.skillRangeIcon.gameObject:SetActive(false)
	else
		self.skillRangeIcon.gameObject:SetActive(true)

		local rangeIconPath = UIGlobalApi.GetImagePath(battleSkillData.searchTargetData.SkillRangeImg)

		AssetUtil.LoadImage(self, rangeIconPath, self.skillRangeIcon.gameObject:GetComponent("Image"))
	end

	self.skillDetailText:GetComponent("Text").text = self:__GetSkillTips(battleSkillData)
end

function SkillItem:__GetSkillTips(skillData)
	local exist, skillLevelConfig = RoleDevelopmentModule.GetSkillCfgByIDAndLv(skillData.configID, skillData.level - 1)

	if not exist then
		return ""
	end

	return UIGlobalApi.GetDescribeMatchTable(skillLevelConfig.SkillTips, function(_index, _formatType)
		local str = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, skillLevelConfig.UpGradeOldValue[_index])

		return RoleDevelopmentApi:GetPromoteStrNotIncludNext(str)
	end)
end

function SkillItem:Hide()
	self.gameObject:SetActive(false)
end

function SkillItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RightContent = {
	buffDataList = {},
	buffItemList = {},
	skillDataList = {},
	skillItemList = {}
}

function RightContent.New(view)
	local obj = Clone(RightContent)

	obj:__Init(view)

	return obj
end

function RightContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.buffScrollAreaList = self.buffScrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.buffScrollAreaList.onRenderCell(_cell)
		self:__OnRenderBuffItemCell(_cell)
	end

	self.skillScrollAreaList = self.skillScrollAreaListRoot:GetComponent("ScrollAreaList")

	function self.skillScrollAreaList.onRenderCell(_cell)
		self:__OnRenderSkillItemCell(_cell)
	end

	self.tabList = UITabList.Create()

	self.tabList:AddTableItem(self.buffToggle, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowBuff()
	end)
	self.tabList:AddTableItem(self.skillToggle, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowSkill()
	end)
end

function RightContent:Show(battleUnitData)
	self.battleUnitData = battleUnitData

	self.gameObject:SetActive(true)
	self.tabList:ChangeSelectIndex(1)

	local monsterData = CfgMonsterTable[battleUnitData.monsterConfigID]
	local elementPath = WarlockApi:GetElementIconPath(monsterData.Elements)

	if not LuaUtility.StrIsNullOrEmpty(elementPath) then
		self.elementIcon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, elementPath, self.elementIcon:GetComponent("Image"))
	else
		self.elementIcon.gameObject:SetActive(false)
	end

	local professionPath = WarlockApi:GetProfessionIconPath(monsterData.Profession)

	if not LuaUtility.StrIsNullOrEmpty(professionPath) then
		self.professionIcon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, professionPath, self.professionIcon:GetComponent("Image"))
	else
		self.professionIcon.gameObject:SetActive(false)
	end

	local nameTextCom = self.nameText:GetComponent("Text")

	nameTextCom.text = monsterData.Name
	self.hpText:GetComponent("Text").text = string.format("%s/%s", battleUnitData.hp, battleUnitData.maxHp)

	UGUIUtil.SetText(self.levelText, "Lv." .. battleUnitData.level)

	local hpSliderRoot = self.playerHP.gameObject

	if battleUnitData.troopType == BattleModule.attackBattleTroopType then
		self.monsterHp.gameObject:SetActive(false)
	else
		self.playerHP.gameObject:SetActive(false)

		hpSliderRoot = self.monsterHp.gameObject
	end

	hpSliderRoot:SetActive(true)

	local sliderCom = hpSliderRoot:GetComponent("Slider")

	sliderCom.wholeNumbers = true
	sliderCom.maxValue = battleUnitData.maxHp
	sliderCom.value = battleUnitData.hp
end

function RightContent:__ShowBuff()
	self.skillScrollAreaListRoot.gameObject.transform.parent.gameObject:SetActive(false)
	self.buffScrollAreaListRoot.gameObject.transform.parent.gameObject:SetActive(true)

	self.buffDataList = {}

	ForPairs(self.battleUnitData.buffsData, function(_, _buffData)
		local buffConfig = CfgBuffTable[_buffData.cid]

		if not buffConfig.IsTipsVisible then
			return
		end

		table.insert(self.buffDataList, _buffData)
	end)
	self.buffScrollAreaList:Refresh(#self.buffDataList)
end

function RightContent:__OnRenderBuffItemCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local buffItem = self.buffItemList[instanceID]

	if buffItem == nil then
		buffItem = BuffItem.New(cell.gameObject)
		self.buffItemList[instanceID] = buffItem
	end

	local buffData = self.buffDataList[cell.index + 1]

	buffItem:Show(buffData)
end

function RightContent:__DisposeBuffView()
	self.buffScrollAreaList.onRenderCell = nil
	self.buffScrollAreaList = nil

	ForPairs(self.buffItemList, function(_, _buffItem)
		_buffItem:Dispose()
	end)
end

function RightContent:__ShowSkill()
	self.buffScrollAreaListRoot.gameObject.transform.parent.gameObject:SetActive(false)
	self.skillScrollAreaListRoot.gameObject.transform.parent.gameObject:SetActive(true)

	self.skillDataList = {}

	ForPairs(self.battleUnitData.skillsData, function(_, _skillData)
		if _skillData.disableManual then
			return
		end

		table.insert(self.skillDataList, _skillData)
	end)
	self.skillScrollAreaList:Refresh(#self.skillDataList)
end

function RightContent:__OnRenderSkillItemCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local skillItem = self.skillItemList[instanceID]

	if skillItem == nil then
		skillItem = SkillItem.New(cell.gameObject)
		self.skillItemList[instanceID] = skillItem
	end

	local skillData = self.skillDataList[cell.index + 1]

	skillItem:Show(skillData)
end

function RightContent:__DisposeSkillView()
	self.skillScrollAreaList.onRenderCell = nil
	self.skillScrollAreaList = nil

	ForPairs(self.skillItemList, function(_, _buffItem)
		_buffItem:Dispose()
	end)
end

function RightContent:Hide()
	self.gameObject:SetActive(false)
end

function RightContent:Dispose()
	self:__DisposeBuffView()
	self:__DisposeSkillView()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local HeadItem = {}

function HeadItem.New(view)
	local obj = Clone(HeadItem)

	obj:__Init(view)

	return obj
end

function HeadItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function HeadItem:Show(battleUnitData)
	self.battleUnitData = battleUnitData

	self.gameObject:SetActive(true)

	local headIconPath = BattleModule.GetBattleUnitHeadIcon(battleUnitData.battleUnitID)

	AssetUtil.LoadImage(self, headIconPath, self.headIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function HeadItem:ShowSelect(isSelect)
	local selectRoot = self.monsterSelectRoot

	if self.battleUnitData.troopType == BattleModule.attackBattleTroopType then
		self.monsterSelectRoot.gameObject:SetActive(false)

		selectRoot = self.playerSelectRoot
	else
		self.playerSelectRoot.gameObject:SetActive(false)
	end

	selectRoot.gameObject:SetActive(isSelect)
end

function HeadItem:Hide()
	self.gameObject:SetActive(false)
end

function HeadItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	battleUnitDataList = {},
	headItemList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.rightContent = RightContent.New(self.rightContentRoot)
	self.headScrollAreaList = self.headScrollAreaListGo:GetComponent("ScrollAreaList")

	function self.headScrollAreaList.onRenderCell(_cell)
		self:__OnRenderHeadItemCell(_cell)
	end

	function self.headScrollAreaList.onSelectedCell(_cell)
		self:__OnHeadItemCellSelected(_cell)
	end

	self.teamTabList = UITabList.Create()

	self.teamTabList:AddTableItem(self.monsterToggle, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__RefreshShowTeam(BattleModule.defineBattleTroopType)
	end)
	self.teamTabList:AddTableItem(self.playerToggle, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__RefreshShowTeam(BattleModule.attackBattleTroopType)
	end)
end

function Element:Show()
	self.gameObject:SetActive(true)
	self.teamTabList:ChangeSelectIndex(1)
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	self.rightContent:Dispose()
	self.teamTabList:Dispose()

	self.headScrollAreaList.onRenderCell = nil
	self.headScrollAreaList.onSelectedCell = nil
	self.headScrollAreaList = nil

	ForPairs(self.headItemList, function(_, _item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function Element:__RefreshShowTeam(troopType)
	self.battleUnitDataList = self:__GetShowDataByTroopType(troopType)

	self.headScrollAreaList:Refresh(#self.battleUnitDataList)
end

function Element:__GetShowDataByTroopType(battleTroopType)
	local result = {}

	BattleModule.ForeachBattleUnits(function(_unitId, _unitData)
		if _unitData.isTroopData then
			return
		end

		if _unitData:IsDead() then
			return
		end

		if _unitData.troopType ~= battleTroopType then
			return
		end

		if not _unitData.joinBattle then
			return
		end

		local data = Clone(_unitData)

		table.insert(result, data)
	end)

	return result
end

function Element:__OnRenderHeadItemCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local headItem = self.headItemList[instanceID]

	if headItem == nil then
		headItem = HeadItem.New(cell.gameObject)
		self.headItemList[instanceID] = headItem
	end

	local unitData = self.battleUnitDataList[cell.index + 1]

	headItem:Show(unitData)

	local isSelect = cell.index == 0

	headItem:ShowSelect(isSelect)

	if isSelect then
		self:__OnHeadItemSelected(unitData)
	end
end

function Element:__OnHeadItemCellSelected(cell)
	local instanceID = cell.gameObject:GetInstanceID()

	ForPairs(self.headItemList, function(_insID, _headItem)
		local isSelect = instanceID == _insID

		_headItem:ShowSelect(isSelect)

		if isSelect then
			self:__OnHeadItemSelected(_headItem.battleUnitData)
		end
	end)
end

function Element:__OnHeadItemSelected(battleUnitData)
	self.rightContent:Show(battleUnitData)
end

return Element
