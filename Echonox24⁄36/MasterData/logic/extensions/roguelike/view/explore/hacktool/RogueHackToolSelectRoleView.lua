-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolSelectRoleView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolSelectRoleView", package.seeall)

local GMCmdEnum = GameEnum.GMCmdEnum
local PropItem = class("PropItem")

function PropItem:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "Image")
	self._txtContent = goutil.findChildTextComponent(go, "txt")
end

function PropItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function PropItem:updateData(data)
	self._txtContent.text = data.content

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(data.pattern)))
	self:setActive(true)
end

local M = class("RogueHackToolSelectRoleView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardSelectRoleItems = {}
	self._selectRoleIds = {}
	self._propItems = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._traSelectRoleParent = self:getGo("run_group_select_charater_view_-875782417").transform
	self._txtHint = self:getText("run_group_select_charater_view_1244518461")
	self._goPropItem = self:getGo("run_group_select_charater_view_copy_389845447")
	self._traPropItemParent = self._goPropItem.transform.parent
	self._goEquipItem = self:getGo("run_group_select_charater_view_copy_-297337357")
	self._goEquipCell = goutil.findChild(self._goEquipItem, "cell")
	self._imgEquipIcon = goutil.findChildImageComponent(self._goEquipCell, "backpack_item/imgIcon")
	self._imgEquipQuality = goutil.findChildImageComponent(self._goEquipCell, "backpack_item/imgQuality")
	self._btnEquip = self:getBtn("run_group_select_charater_view_1895349012")
	self._btnExplore = self:getBtn("run_group_select_charater_view_-1308285604")
	self._goCamp = self:getGo("run_group_select_charater_view_copy_1692548201")
	self._imgCamp = self:getImage("run_group_select_charater_view_copy_-1888101423")
	self._goTopHint = self:getGo("run_group_select_charater_view_copy_-1225150245")
	self._goHackTool = self:getGo("run_group_select_charater_view_copy_313283199")
	self._goEquip = self:getGo("run_group_select_charater_view_copy_-297337357")
	self._btnSimulation = self:getBtn("run_group_select_charater_view_copy_-1796826178")
	self._toggleCamp = self:getUIComponent("run_group_select_charater_view_copy_1116969042", UIComponentType.SpaceXToggle)
	self._dropdownDiff = self:getUIComponent("run_group_select_charater_view_copy_-1238961735", UIComponentType.DropdownApapter)
	self._dropdownScript = self:getUIComponent("run_group_select_charater_view_copy_1344854628", UIComponentType.DropdownApapter)
	self._btnEquip2 = self:getBtn("run_group_select_charater_view_copy_1388661201")
	self._imgEquip2 = self:getImage("run_group_select_charater_view_copy_516963730")
	self._heroData = HeroDepotModel.instance:getHeroDepotData()
	self._showHeroData = self._heroData:getShowDataList()

	goutil.setActive(self._goPropItem, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnSimulation:AddClickListener(self._onClickSimulation, self)
	self._dropdownDiff:AddListener(self._dealDropDownDiff, self)
	self._dropdownScript:AddListener(self._dealDropDownScript, self)
	self._toggleCamp:AddListener(self._onToggleCamp, self)
	self._btnEquip2:AddClickListener(self._onClickEquip2, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnExplore:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnSimulation:RemoveClickListener()
	self._dropdownDiff:RemoveClickListener()
	self._dropdownScript:RemoveClickListener()
	self._toggleCamp:RemoveListener()
	self._btnEquip2:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:setEvent(true)

	for k, v in pairs(self._cardSelectRoleItems) do
		v:bindEvents()
	end

	self:updateSelectCard()
	self:updateEquipment()
	self:_onEquipRefresh()
	self:setGoActive()
end

function M:setGoActive()
	goutil.setActive(self._goTopHint, false)
	goutil.setActive(self._goEquip, false)
	goutil.setActive(self._goCamp, false)
	goutil.setActive(self._goHackTool, true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:addEventListener(EventType.GM_REPLY, self._onGMReply, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.GM_REPLY, self._onGMReply, self)
	end
end

function M:updateEquipment()
	local hadEquip = #RoguelikeModel.instance:getEquipMOS() > 0

	goutil.setActive(self._btnEquip.transform:GetChild(0).gameObject, hadEquip)
end

function M:updateSelectCard()
	for i = 0, self._traSelectRoleParent.childCount - 1 do
		goutil.setActive(self._traSelectRoleParent:GetChild(i).gameObject, false)
	end

	for i = 1, 4 do
		local item = self._cardSelectRoleItems[i]

		if not item then
			local go = self._traSelectRoleParent:GetChild(i - 1).gameObject

			item = RogueRoleLiPaiItem.New(go)
			self._cardSelectRoleItems[i] = item
		end

		local data = {}

		data.roleId = self._selectRoleIds[i] ~= nil and self._selectRoleIds[i] or 0
		data.index = i
		data.isAllowEmptyClick = true

		local index = i

		data.showAddBtn = true

		function data.callback()
			self:onSelectCardClickCallback(index)
		end

		item:updateData(data)
	end

	self:checkShowCampEffect()
end

function M:onSelectCardClickCallback(index)
	ViewMgr.instance:open(ViewName.RogueHackToolRoleList, function(selectRoleIds, selectRoleLevels, selectRoleNoSkills)
		self._selectRoleIds = selectRoleIds
		self._selectRoleLevels = selectRoleLevels
		self._selectRoleNoSkills = selectRoleNoSkills

		for k, v in pairs(selectRoleLevels) do
			print("选择等级", v)
		end

		self:updateSelectCard()
	end)
end

function M:checkIsSelect(roleId)
	for k, v in pairs(self._selectRoleIds) do
		if roleId == v then
			return true
		end
	end

	return false
end

function M:checkShowCampEffect()
	return
end

function M:_refreshHeroDepotData()
	if self._heroListBinderView then
		self._heroListBinderView:refreshView()
	end
end

function M:onExit()
	self:setEvent(false)

	for k, v in pairs(self._cardSelectRoleItems) do
		v:unbindEvents()
	end

	for i = 0, self._traSelectRoleParent.childCount - 1 do
		goutil.setActive(self._traSelectRoleParent:GetChild(i).gameObject, false)
	end

	self._selectRoleIds = {}
end

function M:_onTeamUpSuccess()
	local callback = self:getFirstParam()

	if callback then
		callback()
	end

	self:initRogue()
	self:close()
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState == nil then
		print("组队完成但是没角色")

		return
	end

	for k, v in pairs(allRoleState) do
		table.insert(tb.roleIds, v.code)
	end

	RogueMgr.instance:enter(tb)
	FloatWordMgr.instance:show("选择角色完成")
end

function M:_onClickClose()
	self:close()
end

function M:_onClickExplore()
	if #self._selectRoleIds ~= 4 then
		FloatWordMgr.instance:show("没有选择足够出战角色")

		return
	end

	RoguelikeAgent.instance:sendTeamUpRequest(self._selectRoleIds)
end

function M:_onClickEquip()
	local equips = RoguelikeModel.instance:getEquipMOS() or {}

	if #equips == 0 then
		FloatWordMgr.instance:show("当前没有装备")

		return
	end

	ViewMgr.instance:open(ViewName.RogueEquipMain, {})
end

function M:_onClickSimulation()
	if #self._selectRoleIds ~= 4 then
		FloatWordMgr.instance:show("没有选择足够出战角色")

		return
	end

	local info = {}

	info.cmd = GameEnum.GMCmdEnum.RoguelikeMockIn
	info.value = {}

	local team = {}

	for k, v in pairs(self._selectRoleIds) do
		local teamData = {}

		teamData.id = v
		teamData.lv = self._selectRoleLevels[k]
		teamData.noSkill = self._selectRoleNoSkills[k] == 0 and true or false

		table.insert(team, teamData)
	end

	info.value.team = team
	info.value.campOpen = self._toggleCamp.IsOn
	info.value.script = self._curSelectScriptId or 100
	info.value.d = self._curSelectDiff or 0

	if self._curEquipMo ~= nil then
		local equip = {}

		equip.id = self._curEquipMo:getId()
		equip.lv = self._curEquipMo:getLevel()
		info.value.equip = equip
	end

	HackToolAgent.instance:sendGmRequest(info)
end

function M:_onGMReply(sender, data)
	local cmd = data.cmd

	if cmd == GMCmdEnum.RoguelikeMockIn then
		self:initRogue()
		ViewMgr.instance:open(ViewName.RogueHackToolMap, function()
			return
		end)
		self:close()
	end
end

function M:_dealDropDownDiff(idx)
	print("难度选择", idx)

	local diff = idx > 0 and idx or 1

	self._curSelectDiff = idx
end

function M:_dealDropDownScript(idx)
	print("剧本选择", idx)

	local scriptIds = {
		100,
		101,
		999
	}

	self._curSelectScriptId = scriptIds[idx] or 100
end

function M:_onToggleCamp(toggle, isOn)
	if isOn then
		-- block empty
	end
end

function M:_onClickEquip2()
	ViewMgr.instance:open(ViewName.RogueHackToolEquip, function(equipMo)
		print("选择装备", equipMo:getId(), equipMo:getLevel())

		self._curEquipMo = equipMo

		local hadEquip = true

		goutil.setActive(self._imgEquip2.gameObject, true)

		if hadEquip then
			IconLoader.setSprite(self._imgEquip2, IconType.ItemIcon, equipMo:getIcon())
		end
	end)
end

function M:_onEquipRefresh()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}
	local curEquip = equips[1]
	local hadEquip = curEquip ~= nil and curEquip:getId() ~= 0

	goutil.setActive(self._goEquipCell, hadEquip)
	goutil.setActive(self._btnEquip.transform:GetChild(0).gameObject, not hadEquip)

	if hadEquip then
		IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, curEquip:getIcon())
		IconLoader.setSprite(self._imgEquipQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(curEquip:getQuality()))
	end
end

return M
