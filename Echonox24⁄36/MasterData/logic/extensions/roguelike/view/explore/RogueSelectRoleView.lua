-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueSelectRoleView.lua

module("logic.extensions.roguelike.view.explore.RogueSelectRoleView", package.seeall)

local M = class("RogueSelectRoleView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardSelectRoleItems = {}
	self._cardRoleListItems = {}
	self._selectRoleIds = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._traSelectRoleParent = self:getGo("run_group_select_charater_view_-875782417").transform
	self._goSelectRoleItem = self:getGo("run_group_select_charater_view_1213299146")
	self._txtHint = self:getText("run_group_select_charater_view_1244518461")
	self._imgEquipIcon = self:getImage("run_group_select_charater_view_1467169208")
	self._btnEquip = self:getBtn("run_group_select_charater_view_1895349012")
	self._heroScroll = self:getGo("run_group_select_charater_view_-1858677967")
	self._traHeroScroll = self:getGo("run_group_select_charater_view_-202852009").transform
	self._goRoleCardItem = self:getGo("run_group_select_charater_view_-1519870294")
	self._btnFilter = self:getBtn("run_group_select_charater_view_-1406539009")
	self._btnExplore = self:getBtn("run_group_select_charater_view_-1308285604")
	self._heroData = HeroDepotModel.instance:getHeroDepotData()
	self._showHeroData = self._heroData:getShowDataList()
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnExplore:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:setEvent(true)
	self:_updateHeroData()

	for k, v in pairs(self._cardSelectRoleItems) do
		v:bindEvents()
	end

	self:updateRecommend()
	self:updateSelectCard()
	self:updateEquipment()
	self:_onEquipRefresh()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:addEventListener(EventType.FILTER_ROGUELIKE_DATA, self._updateHeroData, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.FILTER_ROGUELIKE_DATA, self._updateHeroData, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	end
end

function M:updateRecommend()
	local recommend = ""
	local co = self:getOpenParam()[2]
	local props = {}

	for idx, prop in pairs(props) do
		local map = RoguelikeConst.PROP_LANG_MAP[prop]

		recommend = recommend .. map.name .. " "
	end

	self._txtHint.text = string.format(lang("tip_r_script_prop_usefull"), recommend)
end

function M:updateEquipment()
	local hadEquip = #RoguelikeModel.instance:getEquipMOS() > 0

	goutil.setActive(self._btnEquip.gameObject, hadEquip)
end

function M:_updateHeroData()
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()

	self._heroMoList = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Roguelike, _tmpHeroList:getMoList())

	local allRoleCo = {}

	for k, v in pairs(self._heroMoList) do
		local roleCo = CharacterConfig.instance:getCharacterItemInfo(v:getId())

		if roleCo ~= nil then
			table.insert(allRoleCo, roleCo)
		end
	end

	if #allRoleCo == 0 then
		allRoleCo = CharacterConfig.instance:getAllOnlineCharacterConfig()
	end

	local tempRoles = {}

	for k, v in pairs(allRoleCo) do
		local isSelect = self:checkIsSelect(v.id)

		if not isSelect then
			table.insert(tempRoles, v)
		end
	end

	allRoleCo = tempRoles
	self._allRoleCo = allRoleCo

	for i = #allRoleCo + 1, #self._cardRoleListItems do
		goutil.setActive(self._cardRoleListItems[i]._go)
	end

	for i = 1, #allRoleCo do
		local item = self._cardRoleListItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goRoleCardItem, self._traHeroScroll, nil)

			item = RogueRoleCardItem.New(go)

			item:bindEvents()

			self._cardRoleListItems[i] = item
		end

		local data = {}

		data.roleId = allRoleCo[i].id
		data.index = i
		data.useHeadIcon = true

		local index = i

		function data.callback()
			self:onCardClickCallback(index)
		end

		item:updateData(data)
	end
end

function M:onCardClickCallback(index)
	local roleCo = self._allRoleCo[index]
	local roleId = roleCo.id
	local isSelect = self:checkIsSelect(roleId)

	if isSelect then
		for i = 1, #self._selectRoleIds do
			if roleId == self._selectRoleIds[i] then
				table.remove(self._selectRoleIds, i)
				self:updateSelectCard()
				self:_updateHeroData()

				return
			end
		end
	elseif #self._selectRoleIds < 4 then
		table.insert(self._selectRoleIds, roleId)
		self:updateSelectCard()
		self:_updateHeroData()
	else
		FloatWordMgr.instance:show(lang("tip_r_role_select_max"))
	end
end

function M:updateSelectCard()
	for i = 0, self._traSelectRoleParent.childCount - 1 do
		goutil.setActive(self._traSelectRoleParent:GetChild(i).gameObject, false)
	end

	for i = 1, 4 do
		local item = self._cardSelectRoleItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goSelectRoleItem, self._traSelectRoleParent, nil)

			item = RogueRoleCardItem.New(go)
			self._cardSelectRoleItems[i] = item
		end

		local data = {}

		data.roleId = self._selectRoleIds[i] ~= nil and self._selectRoleIds[i] or 0
		data.index = i

		local index = i

		function data.callback()
			if self._selectRoleIds[index] == nil then
				return
			end

			self:onSelectCardClickCallback(index)
		end

		item:updateData(data)
	end
end

function M:onSelectCardClickCallback(index)
	table.remove(self._selectRoleIds, index)
	self:updateSelectCard()
	self:_updateHeroData()
end

function M:checkIsSelect(roleId)
	for k, v in pairs(self._selectRoleIds) do
		if roleId == v then
			return true
		end
	end

	return false
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

	for k, v in pairs(self._cardRoleListItems) do
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
	FloatWordMgr.instance:show(lang("tip_r_role_select_finish"))
end

function M:_onClickClose()
	self:close()
end

function M:_onClickFilter()
	ViewMgr.instance:open(ViewName.HeroFilterTipsView, {
		moduleType = CommEnum.HeroFilter.Roguelike,
		data = self._heroMoList,
		confirmEvent = EventType.FILTER_ROGUELIKE_DATA
	})
end

function M:_onClickExplore()
	if #self._selectRoleIds ~= 4 then
		FloatWordMgr.instance:show(lang("tip_r_role_not_enough"))

		return
	end

	RoguelikeAgent.instance:sendTeamUpRequest(self._selectRoleIds)
end

function M:_onClickEquip()
	local equips = RoguelikeModel.instance:getEquipMOS() or {}

	if #equips == 0 then
		FloatWordMgr.instance:show(lang("tip_r_not_equip"))

		return
	end

	ViewMgr.instance:open(ViewName.RogueEquipMain, {})
end

function M:_onEquipRefresh()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}
	local curEquip = equips[1]
	local hadEquip = curEquip ~= nil and curEquip:getId() ~= 0

	goutil.setActive(self._imgEquipIcon.gameObject, hadEquip)
	goutil.setActive(self._btnEquip.gameObject, not hadEquip)

	if hadEquip then
		IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, curEquip:getIcon())
	end
end

return M
