-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/CustomCharacterView.lua

module("logic.extensions.hacktool.view.CustomCharacterView", package.seeall)

local M = class("CustomCharacterView", ViewComponent)
local panelType = {
	echo = 2,
	think = 3,
	equip = 1,
	skill = 4
}

function M:buildUI()
	self._txtName = self:getText("custom_character_-797743348")
	self._txtQuality = self:getText("custom_character_-532600751")
	self._txtCareer = self:getText("custom_character_2002736140")
	self._inputLevel = self:getInput("custom_character_-1902803225")
	self._dpDownTemplate = self:getUIComponent("custom_character_-1840002404", UIComponentType.DropdownApapter)
	self._dpDownPowerNode1 = self:getUIComponent("custom_character_1178719370", UIComponentType.DropdownApapter)
	self._dpDownPowerNode2 = self:getUIComponent("custom_character_1559892760", UIComponentType.DropdownApapter)
	self._dpDownHeroBreak = self:getUIComponent("custom_character_-1045715435", UIComponentType.DropdownApapter)
	self._dpDownWakeUp = self:getUIComponent("custom_character_1990068598", UIComponentType.DropdownApapter)
	self._inputThink = self:getInput("custom_character_-1481139576")
	self._inputSkill = self:getInput("custom_character_-2070316041")
	self._inputEcho = self:getInput("custom_character_-441915633")
	self._inputEquip = self:getInput("custom_character_-220610311")
	self._dpDownEchoBreak = self:getUIComponent("custom_character_-1644600094", UIComponentType.DropdownApapter)
	self._dpDownEquipQua = self:getUIComponent("custom_character_535386393", UIComponentType.DropdownApapter)
	self._inputEquipLv = self:getInput("custom_character_1309538772")
	self._input = {
		self._inputEquip,
		self._inputEcho,
		self._inputThink,
		self._inputSkill
	}
	self._filterName = self:getInput("custom_character_595339089")
	self._dpDownFilterCareer = self:getUIComponent("custom_character_1857434703", UIComponentType.DropdownApapter)
	self._dpDownFilterQuality = self:getUIComponent("custom_character_-860280231", UIComponentType.DropdownApapter)
	self._dpDownFilterOnline = self:getUIComponent("custom_character_-453130543", UIComponentType.DropdownApapter)
	self._txtMaxLv = self:getText("custom_character_-1196614705")
	self._viewPanel = {
		self:getGo("custom_character_-1662967821"),
		self:getGo("custom_character_-437154616"),
		self:getGo("custom_character_-1000281709"),
		self:getGo("custom_character_-86434647")
	}
	self._btnClose = {
		self:getBtn("custom_character_576975335"),
		self:getBtn("custom_character_1160712165"),
		self:getBtn("custom_character_-1278061661"),
		self:getBtn("custom_character_-500162548")
	}
	self._btnAdd = {
		self:getBtn("custom_character_-989460277"),
		self:getBtn("custom_character_-1578081798"),
		self:getBtn("custom_character_-259373435"),
		self:getBtn("custom_character_1484137317")
	}
	self._btnFull = self:getBtn("custom_character_1194611255")
	self._btnGet = self:getBtn("custom_character_606314744")
	self._heroCell = self:getGo("2&rewards_detail_item_2141037416")
	self._scroll = self:getUIComponent("custom_character_-1778307405", UIComponentType.ScrollRect)
	self._loopLst = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopLst:InitGridView(0, self._updateGrid, self)

	self._heroData = {}
	self._view = {}
	self._selectData = {}
	self._filterData = {}
end

function M:onEnter()
	ViewMgr.instance:close(ViewName.HackToolView)

	local data = CharacterConfig.instance:getCharacterDataList()

	for _, item in pairs(data) do
		item.name = PastInfoConfig.instance:getCharacterInfo(item.id).name

		table.insert(self._heroData, item)
	end

	for idx, item in ipairs(self._viewPanel) do
		self._view[idx] = Astral.LuaComponentContainer.Add(item, CustomPanelView)

		local viewData = self:_getViewData(idx)

		self._view[idx]:refreshData(viewData, idx)
		self._view[idx]:setPresentor(self)
	end

	self._hero = Astral.LuaComponentContainer.Add(self._heroCell, AddItemItemCell)

	self:init()
	self:_onChangeFilter()
end

function M:onExit()
	ViewMgr.instance:open(ViewName.HackToolView)

	self._heroData = {}
	self._filterData = {}
	self._selectData = {}
	self._view = {}
end

function M:bindEvents()
	for i, item in ipairs(self._btnAdd) do
		item:AddClickListener(function()
			self:_setPanelVisiable(i, true)
		end, self)
	end

	for i, item in ipairs(self._btnClose) do
		item:AddClickListener(function()
			self:_setPanelVisiable(i, false)
		end, self)
	end

	self._btnFull:AddClickListener(self._getFull, self)
	self._btnGet:AddClickListener(self._getCustom, self)
	self._dpDownTemplate:AddListener(self._onChangeTemplate, self)
	self._dpDownFilterCareer:AddListener(self._onChangeFilter, self)
	self._dpDownFilterQuality:AddListener(self._onChangeFilter, self)
	self._dpDownFilterOnline:AddListener(self._onChangeFilter, self)
	self._filterName:AddOnValueChanged(self._onChangeFilter, self)
	self._inputLevel:AddOnEndEdit(self._checkLevel, self)
	self._inputEquipLv:AddOnEndEdit(self._checkEquipLevel, self)
end

function M:unbindEvents()
	for i, item in ipairs(self._btnAdd) do
		item:RemoveClickListener()
	end

	for _, item in ipairs(self._btnClose) do
		item:RemoveClickListener()
	end

	self._btnFull:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._dpDownTemplate:RemoveClickListener()
	self._dpDownFilterCareer:RemoveClickListener()
	self._dpDownFilterQuality:RemoveClickListener()
	self._dpDownFilterOnline:RemoveClickListener()
	self._filterName:RemoveOnValueChanged()
	self._inputLevel:RemoveOnEndEdit()
	self._inputEquipLv:RemoveOnEndEdit()
end

function M:_templateDropdownInit(quality)
	self._dpDownTemplate.dropdown:ClearOptions()

	local template = CustomTemplate.getTemplate(6 - quality)
	local levelList = {}

	for level, _ in pairs(template) do
		table.insert(levelList, level)
	end

	table.sort(levelList)

	for _, level in ipairs(levelList) do
		local t = UnityEngine.UI.Dropdown.OptionData.New(level .. "级")

		self._dpDownTemplate.dropdown.options:Add(t)
	end
end

function M:_onChangeTemplate()
	local level = self._dpDownTemplate.dropdown.options[self._dpDownTemplate.dropdown.value].text

	level = string.sub(level, 1, -4)

	self:_setTemplateLevel(tonumber(level))
end

function M:_setPanelVisiable(idx, status)
	if not self:getSelectHero() then
		FloatWordMgr.instance:show("请先选择角色")

		return
	end

	if idx == panelType.skill and not self._selectData[panelType.think] then
		FloatWordMgr.instance:show("请先选择思维")

		return
	end

	goutil.setActive(self._viewPanel[idx], status)

	if idx == panelType.echo then
		self._view[idx] = Astral.LuaComponentContainer.Get(self._viewPanel[idx], CustomPanelView)

		self._view[idx]:refreshFilter()
	end
end

function M:_onClickCell(cell)
	local data = cell:getData()

	self._txtName.text = "角色名： " .. data:getName()
	self._txtQuality.text = "品质： " .. CommEnum.Quality2Name[data:getQuality()]
	self._txtCareer.text = "职业： " .. CommEnum.Career2Name[data:getItemInfo().career]

	self._hero:updateData(data)

	self._txtMaxLv.text = "/" .. (data:getQuality() == 5 and 90 or 80)

	self:init()
	self:_templateDropdownInit(data:getQuality())
end

function M:_updateGrid(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopLst:NewListViewItem("item")
	local component = Astral.LuaComponentContainer.Add(item.transform:GetChild(0).gameObject, AddItemItemCell)
	local data = ItemUtil.createItemData({
		count = 1,
		itemId = self._filterData[curIndex].id
	})

	component:getComponent("normal"):setClickListener(self._onClickCell, self)
	component:updateData(data)

	return item
end

function M:_getViewData(idx)
	local itemData = {}

	if idx == panelType.equip then
		local equipSuitList = EquipmentConfig.instance:getConfigList(ConfigName.EquipmentSuit)

		for i, equipCo in ipairs(equipSuitList) do
			equipCo.quality = 1
			equipCo.iconTyp = IconType.ItemIcon

			table.insert(itemData, equipCo)
		end

		return itemData
	elseif idx == panelType.echo then
		local echoList = BackpackConfig.instance:getConfigList(ConfigName.EchoItem)

		for i, echoCo in ipairs(echoList) do
			echoCo.iconTyp = IconType.EchoItemIcon

			table.insert(itemData, echoCo)
		end

		return itemData
	elseif idx == panelType.think then
		local thinkList = ThinkingConfig.instance:getThinkingCfg()

		for i, thinkCo in ipairs(thinkList) do
			thinkCo.iconTyp = IconType.Thought
			thinkCo.quality = 1

			table.insert(itemData, thinkCo)
		end

		return itemData
	elseif idx == panelType.skill and self._selectData[panelType.think] then
		local cfgThought = ThinkingConfig.instance:getThinkingCO(self._selectData[panelType.think].id)
		local skillIds = cfgThought.skills

		skillIds = skillIds or {}

		for _, skillId in ipairs(skillIds) do
			local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

			if skillCOWrapper then
				local skillCO = skillCOWrapper:getSkillCO()

				skillCO.icon = ActiveSkillCOUtil.getSkillIcon(skillCO)
				skillCO.quality = 1
				skillCO.iconTyp = IconType.SkillIcon
				skillCO.id = skillCO.code

				table.insert(itemData, skillCO)
			end
		end

		return itemData
	end

	return {}
end

function M:setSelect(type, data)
	self._selectData[type] = data

	if type == panelType.think then
		local viewData = self:_getViewData(panelType.skill)

		self._view[panelType.skill]:refreshData(viewData, panelType.skill)
	end

	self:_refresh()
end

function M:_getFull()
	self:_setTemplateLevel(100)
	self:_getCustom()
end

function M:_getCustom()
	if not self:_checkIllegal() then
		return
	end

	local selectHero = self._hero:getData()
	local data = {
		cmd = GameEnum.GMCmdEnum.AddHeroAbsolute,
		value = {}
	}

	data.value = {
		echoId = 0,
		equipmentLv = 0,
		echoLv = 0,
		thinkingSkill = 0,
		thinking = 0,
		tacit = 0,
		equipmentSuitId = 0,
		equipmentQuality = 0,
		heroMark = selectHero:getItemId(),
		level = tonumber(self._inputLevel:GetText()),
		breakLv = self._dpDownHeroBreak.dropdown.value,
		wakeup = self._dpDownWakeUp.dropdown.value == 0 and true or false,
		powerNodeId = self._dpDownPowerNode1.dropdown.value * 5 + self._dpDownPowerNode2.dropdown.value + 1
	}

	if self._selectData[panelType.equip] then
		data.value.equipmentSuitId = self._selectData[panelType.equip].id
		data.value.equipmentQuality = self._dpDownEquipQua.dropdown.value + 1
		data.value.equipmentLv = tonumber(self._inputEquipLv:GetText())
	end

	if self._selectData[panelType.echo] then
		data.value.echoId = self._selectData[panelType.echo].id
		data.value.echoLv = self._dpDownEchoBreak.dropdown.value + 1
	end

	if self._selectData[panelType.think] then
		data.value.thinking = self._selectData[panelType.think].id
	end

	if self._selectData[panelType.skill] then
		data.value.thinkingSkill = self._selectData[panelType.skill].id
	end

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_setTemplateLevel(level)
	if level == 0 then
		return
	end

	local data = self._hero:getData()

	if not data then
		FloatWordMgr.instance:show("请先选择角色")

		return
	end

	self:init()

	local info = CustomTemplate.getLvTemplateByQua(6 - data:getQuality(), level)

	self._dpDownPowerNode1.dropdown.value = (info.powerNodeId - 1) / 5
	self._dpDownPowerNode2.dropdown.value = (info.powerNodeId - 1) % 5
	self._dpDownHeroBreak.dropdown.value = info.breakLv
	self._dpDownWakeUp.dropdown.value = info.wakeup == true and 0 or 1
	self._dpDownEchoBreak.dropdown.value = info.echoLv
	self._dpDownEquipQua.dropdown.value = info.equipmentQua

	self._inputEquipLv:SetText(info.equipmentLv)

	local heroLvMax = data:getQuality() == 5 and 90 or 80
	local trueLv = level < heroLvMax and level or heroLvMax

	self._inputLevel:SetText(trueLv)

	local heroEquip = CustomTemplate.getHeroEquipTemplate(data:getItemId())

	if heroEquip then
		local echo = self:_getViewData(panelType.echo)

		for _, item in ipairs(echo) do
			if item.id == heroEquip.echoId then
				self:setSelect(panelType.echo, item)
			end
		end

		if info.equipmentQua == 0 then
			return
		end

		local equip = self:_getViewData(panelType.equip)

		for _, item in ipairs(equip) do
			if item.id == heroEquip.suitId then
				self:setSelect(panelType.equip, item)
			end
		end
	end
end

function M:init()
	self._selectData = {}

	self._inputLevel:SetText("")

	self._dpDownPowerNode1.dropdown.value = 0
	self._dpDownPowerNode2.dropdown.value = 0
	self._dpDownHeroBreak.dropdown.value = 0
	self._dpDownWakeUp.dropdown.value = 0

	self._inputThink:SetText("")
	self._inputSkill:SetText("")
	self._inputEcho:SetText("")
	self._inputEquip:SetText("")

	self._dpDownEchoBreak.dropdown.value = 0
	self._dpDownEquipQua.dropdown.value = 0

	self._inputEquipLv:SetText("")
end

function M:_refresh()
	for i = 1, 4 do
		if self._selectData[i] then
			self._input[i]:SetText(self._selectData[i].name)
		end
	end
end

function M:getSelectHero()
	return self._hero:getData()
end

function M:_onChangeFilter()
	local filterName = self._filterName:GetText()
	local filterCareer = self._dpDownFilterCareer.dropdown.value
	local filterOnline = 1 - self._dpDownFilterOnline.dropdown.value
	local filterQuality = self._dpDownFilterQuality.dropdown.value

	if filterQuality > 0 then
		filterQuality = filterQuality + 2
	end

	self._filterData = {}

	for _, item in ipairs(self._heroData) do
		if string.find(item.name, filterName) and (filterCareer == 0 or filterCareer == item.career) and (filterOnline == -1 or filterOnline == item.isOnline) and (filterQuality == 0 or filterQuality == item.quality) then
			table.insert(self._filterData, item)
		end
	end

	self._loopLst:SetListItemCount(#self._filterData)
	self._loopLst:RefreshAllShownItem()
end

function M:_checkLevel(level)
	level = tonumber(level)
	level = level or 0

	local heroLvMax = self._hero:getData():getQuality() == 5 and 90 or 80

	if heroLvMax < level then
		level = heroLvMax
	elseif level < 0 then
		level = 0
	end

	self._inputLevel:SetText(level)
end

function M:_checkEquipLevel(level)
	level = tonumber(level)
	level = level or 0

	if level > 30 then
		level = 30
	elseif level < 0 then
		level = 0
	end

	self._inputEquipLv:SetText(level)
end

function M:_checkIllegal()
	local selectHero = self._hero:getData()

	if not selectHero then
		FloatWordMgr.instance:show("请先选择角色")

		return false
	end

	if self._inputLevel:GetText() == "" then
		FloatWordMgr.instance:show("请填写角色等级")

		return false
	end

	return true
end

return M
