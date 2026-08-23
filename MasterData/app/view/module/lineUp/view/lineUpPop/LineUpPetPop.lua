local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.BASE_CONST
local var_0_4 = g.core.model.User.petsData
local var_0_5 = g.core.model.User.formationData
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.module.ModuleManager
local var_0_8 = g.core.const.ConstMgr.QUALITY_TYPE
local LineUpPetPop = class("LineUpPetPop", require("app.fairyGUI.lineUp.UI_LineUpPetPop"), function()
	return fgui.GComponent:create({
		resName = "LineUpPetPop",
		pkgPath = "ui/lineUp/lineUp",
		isFullScreen = true,
		pkgName = "lineUp"
	})
end)

function LineUpPetPop:ctor(arg_2_1)
	self._pos = arg_2_1.pos
	self._petSid = arg_2_1.petSid or 0
	self._selectedGroupIdxCpp = 0
	self._isOnClose = false
	self._showPetArr = {}
	self._ownPetArr = var_0_4:getOwnPetArr()
	self._tabQualitys = var_0_8.TabQuality[var_0_8.NEW_QUALITY_CTRL.PET]

	self.m_groupList:setVirtual()
	self.m_groupList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickGroupListItem))
	self.m_groupList:setNumItems(table.nums(self._tabQualitys))
	self.m_groupList:setSelectedIndex(self._selectedGroupIdxCpp)
	self.m_petList:setVirtual()
	self.m_petList:setItemRenderer(handler(self, self._onPetListRenderer))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickPetListItem))
	self.m_checkBtn:setSelected(var_0_5:isHideLineupPet())
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_recruitBtn:addClickListener(handler(self, self._onClickRecruitBtn))

	self.m_enterTransition = self:getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	self.m_enterTransition:setHook("listEnter", handler(self, self._updateView))

	self.m_backTransition = self:getSharedTrans("back", "CommonRightPanelAnim", self.m_content)
end

function LineUpPetPop:onLoad()
	var_0_6:addEventListener(var_0_0.EVENT_CLICK_FINISH, self._onClickFinish, self)
	var_0_6:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onClose, self)
	var_0_6:addEventListener(var_0_0.EVENT_NET_S2C_PET_INHERITFORMATION, self._onClose, self)
	self.m_enterTransition:play()
end

function LineUpPetPop:_onPetListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._showPetArr[arg_4_1 + 1], self._pos)
end

function LineUpPetPop:_onCheckBtnClick()
	var_0_5:setHideLineupPet((self.m_checkBtn:isSelected()))
	self:_updateView()
end

function LineUpPetPop:_onClickGroupListItem(arg_6_1)
	local var_6_0 = self.m_groupList:getSelectedIndex()

	if var_6_0 ~= self._selectedGroupIdxCpp then
		self._selectedGroupIdxCpp = var_6_0

		self:_updateView()
	end
end

function LineUpPetPop:_onTabListItemRender(arg_7_1, arg_7_2)
	arg_7_2:setTitle(self._tabQualitys[arg_7_1].name or 0)
end

function LineUpPetPop:_onClickPetListItem(arg_8_1)
	local var_8_0 = self._showPetArr[arg_8_1:getDataValue() + 1]

	if var_0_3.HAS_PUT_CHECK and not var_8_0:isPut() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1159))

		return
	end

	local var_8_1 = var_8_0:getSid()
	local var_8_2 = var_0_4:getPetByPos(self._pos)

	if var_8_2 then
		if var_8_1 == var_8_2:getSid() then
			var_0_7:tip(g.core.lang:get(200016))
		elseif var_8_2:getLevel() > 1 or var_8_2:getBigSmallStage() > 0 then
			var_0_7:pushPopup((require("app.view.base.infoPop.InheritFormationPop").new({
				pos = self._pos,
				id = var_8_1,
				type = var_0_1.InfoConst.InheritType.PET
			})))
		else
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = g.core.network.proto.TYPE_PET,
				pos = self._pos,
				id = var_8_1
			})
			self:_onClose()
		end
	elseif var_8_0:isLineup() then
		var_0_7:tip(g.core.lang:get(200015))
	else
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = g.core.network.proto.TYPE_PET,
			pos = self._pos,
			id = var_8_1
		})
		self:_onClose()
	end
end

function LineUpPetPop:_onClickFinish(arg_9_1, arg_9_2)
	if self._isOnClose then
		return
	end

	if not self.m_bgPanel:containPoint((arg_9_2:getInput():getTouch():getLocation())) then
		self:_onClose()
	end
end

function LineUpPetPop:_onClose()
	if self._isOnClose then
		return
	end

	self._isOnClose = true

	self:setTouchable(false)
	self.m_backTransition:play(handler(self, function()
		self._isOnClose = false

		var_0_7:onlyPopSelfByDisplay(self)
	end))
end

function LineUpPetPop:_onClickRecruitBtn()
	var_0_7:pushModule(g.view.entrance.RECRUIT, {
		route1 = var_0_1.RecruitConst.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE,
		route2 = var_0_1.RecruitConst.RECRUIT_TYPE.PET_BASE
	})
	self:_onClose()
end

function LineUpPetPop:_updateView()
	self._showPetArr = self:_getShowPetArr(self.m_checkBtn:isSelected(), (self:_getSelectedQuality()))

	if #self._showPetArr == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_petList:setNumItems(#self._showPetArr)
		self.m_petList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function LineUpPetPop:_getShowPetArr(arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self._ownPetArr) do
		if self:_isShowByHideLineup(iter_14_1, arg_14_1) and self:_isShowByQuality(iter_14_1, arg_14_2) then
			table.insert(var_14_0, iter_14_1)
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0:getQuality() > arg_15_1:getQuality()
	end)

	return var_14_0
end

function LineUpPetPop:_isShowByHideLineup(arg_16_1, arg_16_2)
	return not arg_16_2 or not arg_16_1:isLineup()
end

function LineUpPetPop:_isShowByQuality(arg_17_1, arg_17_2)
	if arg_17_2 > var_0_1.QUALITY_TYPE.NONE then
		return arg_17_1:getCfg().quality == arg_17_2
	end

	return true
end

function LineUpPetPop:_getSelectedQuality()
	return self._tabQualitys[self._selectedGroupIdxCpp].quality or 0
end

return LineUpPetPop
