local NewSlgTeamSelectItemPop = class("NewSlgTeamSelectItemPop", require("app.fairyGUI.newSlg.UI_NewSlgTeamSelectItemPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgTeamSelectItemPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgTeamSelectItemPop:ctor(arg_2_1)
	self:showAtCenter()

	self._btnOk = self:getChild("Btn_ok")

	self._btnOk:addClickListener(handler(self, self._onClickBtnOk))

	self._btnKnight = self:getChild("Btn_knight")
	self._btnUniteToken = self:getChild("Btn_uniteToken")
	self._btnPet = self:getChild("Btn_pet")
	self._tabMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			btn = self._btnKnight,
			max = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_KNIGHT_MAX,
			title = g.core.lang:get(429000)
		},
		[g.core.common.Goods.TYPE_UNITETOKEN] = {
			btn = self._btnUniteToken,
			max = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_UNITETOKEN_MAX,
			title = g.core.lang:get(429001)
		},
		[g.core.common.Goods.TYPE_PET] = {
			btn = self._btnPet,
			max = g.core.const.ConstMgr.NewSlgConst.TEAM_UP_PET_MAX,
			title = g.core.lang:get(429002)
		}
	}
	self._listItem = self:getChild("List_item")

	self._listItem:setVirtual(self)
	self._listItem:setItemRenderer(handler(self, self._onRenderListItemCell))

	self._itemTypeCtrl = self:getController("item_type")

	self._itemTypeCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onItemTypeChanged))

	self._isEmptyCtrl = self:getController("is_empty")
	self._itemCtrlType = {
		[g.core.common.Goods.TYPE_KNIGHT] = 0,
		[g.core.common.Goods.TYPE_UNITETOKEN] = 1,
		[g.core.common.Goods.TYPE_PET] = 2
	}

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))

	self._itemType = arg_2_1.itemType
	self._teamMap = arg_2_1.teamMap
	self._selectSortMap = {}
	self._teamCharacterMap = {}

	self:_initItemStatus()

	self._teamIndex = arg_2_1.teamIndex
	self._team = self._teamMap[self._teamIndex]
	self._tempCharacters = clone(self._team.characters or {})
	self._structArr = {}
end

function NewSlgTeamSelectItemPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_EDITUSERTEAM, handler(self, self._onSaveTeamSucc), self)
	self.m_enterTransition:play()
	self:_updateView()
end

function NewSlgTeamSelectItemPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgTeamSelectItemPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgTeamSelectItemPop:_updateTab()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._tempCharacters) do
		if var_6_0[iter_6_1.tp] == nil then
			var_6_0[iter_6_1.tp] = {}
		end

		table.insert(var_6_0[iter_6_1.tp], iter_6_1)
	end

	for iter_6_2, iter_6_3 in pairs(self._tabMap) do
		if iter_6_3.max == 0 then
			iter_6_3.btn:setVisible(false)
		else
			local var_6_1 = iter_6_3.btn

			iter_6_3.btn:setVisible(true)

			local var_6_3 = {}

			if var_6_0[iter_6_2] then
				var_6_3.num1 = #var_6_0[iter_6_2] or 0
			end

			var_6_3.num2 = iter_6_3.max

			var_6_1:setTitle(iter_6_3.title .. g.core.lang:get(428988, var_6_3))
		end
	end
end

function NewSlgTeamSelectItemPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "NewSlgTeamSelectIcon_refresh_tab" then
		self:_updateTab()
	end
end

function NewSlgTeamSelectItemPop:_updateView()
	self:_updateTab()
	self._itemTypeCtrl:setSelectedIndex(self._itemCtrlType[self._itemType])

	self._structArr = g.core.model.User.newSlgData:geTeamItemList(self._itemType, self._selectSortMap)

	self._listItem:setNumItems(#self._structArr)
	self._isEmptyCtrl:setSelectedIndex(#self._structArr <= 0 and 1 or 0)
end

function NewSlgTeamSelectItemPop:_onClickBtnOk()
	self._team.characters = self._tempCharacters

	self:_saveTeam()
end

function NewSlgTeamSelectItemPop:_saveTeam()
	self._tempTeams = {}

	for iter_10_0, iter_10_1 in pairs(self._teamMap) do
		if g.core.model.User.newSlgData:isTeamIdle(iter_10_1) then
			g.core.model.User.newSlgData:correctTeamTroopLevel(iter_10_1)
			g.core.model.User.newSlgData:formatTeamCharactersByTeam(iter_10_1)
			table.insert(self._tempTeams, iter_10_1)
		end
	end

	if self._tempTeams and #self._tempTeams > 0 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_EditUserTeam({
			teams = self._tempTeams
		})
	end
end

function NewSlgTeamSelectItemPop:_onSaveTeamSucc()
	g.core.model.User.newSlgData:updateMyTeamData(self._tempTeams)
	g.core.module.ModuleManager:popComponent()
end

function NewSlgTeamSelectItemPop:_onRenderListItemCell(arg_12_1, arg_12_2)
	arg_12_2:updateCell({
		itemType = self._itemType,
		teamIndex = self._teamIndex,
		struct = self._structArr[arg_12_1 + 1].struct,
		teamCharacterMap = self._teamCharacterMap,
		characters = self._tempCharacters,
		authority = self._structArr[arg_12_1 + 1].authority
	})
end

function NewSlgTeamSelectItemPop:_onItemTypeChanged()
	local var_13_0 = self._itemTypeCtrl:getSelectedIndex()

	if var_13_0 == 0 then
		self._itemType = g.core.common.Goods.TYPE_KNIGHT
	elseif var_13_0 == 1 then
		self._itemType = g.core.common.Goods.TYPE_UNITETOKEN
	elseif var_13_0 == 2 then
		self._itemType = g.core.common.Goods.TYPE_PET
	end

	self:_updateView()
end

function NewSlgTeamSelectItemPop:_initItemStatus()
	for iter_14_0, iter_14_1 in pairs(self._teamMap) do
		if self._teamCharacterMap[iter_14_1.index] == nil then
			self._teamCharacterMap[iter_14_1.index] = {}
		end

		local var_14_0 = iter_14_1.characters

		if iter_14_1.characters and #var_14_0 > 0 then
			for iter_14_2, iter_14_3 in ipairs(var_14_0) do
				if self._teamCharacterMap[iter_14_1.index][iter_14_3.tp] == nil then
					self._teamCharacterMap[iter_14_1.index][iter_14_3.tp] = {}
				end

				self._teamCharacterMap[iter_14_1.index][iter_14_3.tp][iter_14_3.id] = true
				self._selectSortMap[iter_14_3.id] = iter_14_1.index
			end
		end
	end
end

return NewSlgTeamSelectItemPop
