local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.network.proto
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = g.core.const.ConstMgr.PetConst
local var_0_5 = g.core.const.ConstMgr.SuccubaConst
local var_0_6 = g.core.const.ConstMgr.FormationConst
local var_0_7 = g.core.model.User.petsData
local var_0_8 = g.core.model.User.knightsData
local var_0_9 = g.core.model.User.uniteTokenData
local var_0_10 = g.core.model.User.succubaData
local var_0_11 = g.core.module.ModuleManager
local var_0_12 = g.core.common.ModuleUnlock
local var_0_13 = g.core.const.ConstMgr.KNIGHT_CONST
local FormationMainBottomComp = class("FormationMainBottomComp", require("app.fairyGUI.formation.UI_FormationMainBottomComp"))

function FormationMainBottomComp:ctor()
	self._startPos = 0
	self._dragUniteComp = nil
	self._dragPetComp = nil
	self._isOther = false
	self._otherData = {}
	self._guideComp = nil

	self:_initComp()
end

function FormationMainBottomComp:_initComp()
	for iter_2_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		if var_0_12:isModuleUnlock(var_0_0["UNITE_TOKEN_LINE_UP_" .. iter_2_0]) then
			self["m_uniteBtn" .. iter_2_0]:setSkillPos(iter_2_0)
			self["m_uniteBtn" .. iter_2_0]:setDraggable(true)
			self["m_uniteBtn" .. iter_2_0]:setClickAddCall(handler(self, self._callAddUnitePop))
			self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSkill))
			self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSkill))
		else
			self["m_uniteBtn" .. iter_2_0]:updateFormatUnlock((g.core.common.ModuleUnlock:getModuleUnlockLevel(var_0_0["UNITE_TOKEN_LINE_UP_" .. iter_2_0])))
		end
	end

	for iter_2_1 = 1, var_0_4.LINEUP_MAX do
		if var_0_12:isModuleUnlock(var_0_0["PET_LINE_UP_" .. iter_2_1]) then
			self["m_petComp" .. iter_2_1]:setPetPos(iter_2_1)
			self["m_petComp" .. iter_2_1]:setDraggable(true)
			self["m_petComp" .. iter_2_1]:setClickAddCall(handler(self, self._callAddPetPop))
			self["m_petComp" .. iter_2_1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupPet))
			self["m_petComp" .. iter_2_1]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupPet))
			self["m_petComp" .. iter_2_1].m_redPointComp:setVisible(true)
		else
			local var_2_0, var_2_1 = var_0_12:getModuleUnlockLevelAndComment(var_0_0["PET_LINE_UP_" .. iter_2_1])

			self["m_petComp" .. iter_2_1]:setIsLock(true, var_2_0, var_2_1)
		end
	end

	for iter_2_2 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		if true then
			self["m_succubaComp" .. iter_2_2]:setSuccubaPos(iter_2_2)
			self["m_succubaComp" .. iter_2_2]:setDraggable(true)
			self["m_succubaComp" .. iter_2_2]:setClickAddCall(handler(self, self._callAddSuccubaPop))
			self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSuccuba))
			self["m_succubaComp" .. iter_2_2]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSuccuba))
		end
	end

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onPartnerKnightRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_showTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self.m_knightList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._dragKnight))
end

function FormationMainBottomComp:_onTabChanged(arg_3_1)
	if self.m_showTabController:getSelectedIndex() == 2 then
		self:newScheduleOnce(function()
			self:_checkTickWeakGuide()
		end, 0)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	end
end

function FormationMainBottomComp:_dragKnight()
	if not self._dragPopEvent then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

		self._dragPopEvent = true
	end
end

function FormationMainBottomComp:onLoad()
	for iter_6_0 = 1, var_0_4.LINEUP_MAX do
		if var_0_12:isModuleUnlock(var_0_0["PET_LINE_UP_" .. iter_6_0]) then
			self["m_petComp" .. iter_6_0]:checkRedPoint()
		end
	end

	local var_6_0 = -1

	local function var_6_1(arg_7_0, arg_7_1)
		local var_7_0 = var_0_12:isModuleUnlock(arg_7_1)

		if arg_7_1 == var_0_0.SUCCUBA then
			var_7_0 = var_7_0 and not self._hideSuccuba
		end

		self["m_tabBtn" .. arg_7_0 + 1]:setVisible(var_7_0)

		if var_7_0 then
			local var_7_1 = self["m_tabBtn" .. arg_7_0 + 1]:getChild("redPointComp")

			var_7_1:setVisible(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = var_7_1
			})

			if arg_7_1 == var_0_0.KNIGHT_PARTNER_1 then
				self._guideComp = self["m_tabBtn" .. arg_7_0 + 1]
			end
		end

		if var_7_0 and var_6_0 == -1 then
			var_6_0 = arg_7_0
		end
	end

	var_6_1(var_0_6.TAB_INDEX.UNITE, var_0_0.UNITE_TOKEN)
	var_6_1(var_0_6.TAB_INDEX.PET, var_0_0.PET)
	var_6_1(var_0_6.TAB_INDEX.HELPER, var_0_0.KNIGHT_PARTNER_1)
	var_6_1(var_0_6.TAB_INDEX.SUCCUBA, var_0_0.SUCCUBA)

	if -1 >= 0 then
		self:setVisible(true)
		self.m_showTabController:setSelectedIndex(-1)
	else
		self:setVisible(false)
	end

	self:newScheduleOnce(function()
		self:_checkTickWeakGuide()
	end, 0.5)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self.updateComp), self)
end

function FormationMainBottomComp:_checkTickWeakGuide()
	if self._isOther then
		return
	end

	if #g.core.model.User.knightsData:getOwnerAllList() >= 7 and g.core.common.ModuleUnlock:isModuleUnlock(200) and g.core.model.User.knightsData:getLineupKnightCount() == g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX then
		local var_9_0 = self.m_showTabController:getSelectedIndex()

		if var_9_0 ~= 2 then
			local var_9_1 = g.core.model.User.knightsData:getFormationKnights()
			local var_9_2 = false

			for iter_9_0 = 1, var_0_13.SHOW_PARTNER_NUM do
				if var_9_1[var_0_13.LINEUP_MAX + iter_9_0] ~= 0 then
					var_9_2 = true

					break
				end
			end

			if not var_9_2 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "FATE_STEP_1",
					targetBtn = self._guideComp
				})
			end
		elseif var_9_0 == 2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "FATE_STEP_2",
				targetBtn = self.m_knightList:getChildAt(0)
			})
		end
	end
end

function FormationMainBottomComp:_onPartnerKnightRenderer(arg_10_1, arg_10_2)
	if self._isOther then
		arg_10_2:updatePartnerFormatIconByKnightStruct(self._otherData.otherKnightStructTab[arg_10_1 + 1 + var_0_3.LINEUP_MAX])
	else
		arg_10_2:updateCell(arg_10_1 + 1, var_0_8:getFormationKnights()[arg_10_1 + 1 + var_0_3.LINEUP_MAX])
	end
end

function FormationMainBottomComp:_onClickCell(arg_11_1)
	local var_11_0 = self.m_knightList:getSelectedIndex() + 1

	if self._isOther then
		if self._otherData.otherKnightStructTab[var_11_0 + var_0_3.LINEUP_MAX] then
			var_0_11:pushPopup((require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				isOthers = true,
				knightStruct = self._otherData.otherKnightStructTab[var_11_0 + var_0_3.LINEUP_MAX],
				matchInfos = self._otherData.matchInfos
			})))
		end

		return
	end

	local var_11_1 = var_0_0["KNIGHT_PARTNER_" .. var_11_0]

	if var_0_12:isModuleUnlock(var_0_0["KNIGHT_PARTNER_" .. var_11_0]) then
		local var_11_2

		if var_0_8:getLineupKnightCount() ~= var_0_3.LINEUP_MAX then
			var_0_11:tip(g.core.lang:get(200029))

			do return end

			var_11_2 = {
				isHelper = true,
				index = var_11_0 + var_0_3.LINEUP_MAX
			}
		end

		var_11_2.knightSid = var_0_8:getFormationKnights()[var_11_0 + var_0_3.LINEUP_MAX]

		var_0_11:pushModule(g.view.entrance.LINE_UP_CHOOSE, var_11_2)
	else
		local var_11_3, var_11_4 = var_0_12:getModuleUnlockLevelAndComment(var_11_1)

		var_0_11:tip(var_11_4)
	end
end

function FormationMainBottomComp:_onTouchBegin(arg_12_1)
	arg_12_1:captureTouch()
end

function FormationMainBottomComp:_callAddUnitePop(arg_13_1)
	var_0_11:pushPopup((require("app.view.module.formation.view.FormationUniteTokenPop").new({
		pos = arg_13_1
	})))
end

function FormationMainBottomComp:_callAddPetPop(arg_14_1, arg_14_2)
	var_0_11:pushModule(g.view.entrance.LINE_UP_CHOOSE_PET, {
		pos = arg_14_1,
		petSid = arg_14_2
	})
end

function FormationMainBottomComp:_callAddSuccubaPop(arg_15_1)
	self._clickPos = arg_15_1

	var_0_11:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		isFilter = true,
		allList = var_0_10:getSuccubaList(),
		isLineUpCall = handler(self, self._isLineupSuccubaCall),
		clickCheckFunc = handler(self, self._clickLineupSuccuba),
		filterStr = g.core.lang:get(200040),
		cellParam = {
			formationType = g.core.const.ConstMgr.LineUpConst.MulTeamType.MAIN
		}
	}), {
		touchDisappear = false,
		blackOpacity = 0.5,
		ignoreTouch = false
	})
end

function FormationMainBottomComp:_isLineupSuccubaCall(arg_16_1)
	return arg_16_1:getPosition() > 0
end

function FormationMainBottomComp:_clickLineupSuccuba(arg_17_1)
	if self._clickPos > 0 then
		if arg_17_1:getPosition() <= 0 then
			var_0_11:tip(g.core.lang:get(200038))
		else
			var_0_11:tip(g.core.lang:get(200008))
		end

		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = var_0_1.TYPE_SUCCUBA,
			pos = self._clickPos,
			id = arg_17_1:getSid()
		})
	end

	self._clickPos = 0

	return true
end

function FormationMainBottomComp:setIsShare(arg_18_1)
	if arg_18_1 then
		self.m_isShareController:setSelectedIndex(1)

		local var_18_0 = var_0_8:getFormationKnights()
		local var_18_1 = {}

		for iter_18_0 = 1, var_0_3.SHOW_PARTNER_NUM do
			table.insert(var_18_1, {
				pos = iter_18_0,
				sid = var_18_0[var_0_3.LINEUP_MAX + iter_18_0]
			})
		end

		self.m_shareComp:updateShareComp(var_18_1, self.m_knightList:getScrollPane():getPosX())
	else
		self.m_isShareController:setSelectedIndex(0)
	end
end

function FormationMainBottomComp:_dragLineupSkill(arg_19_1)
	arg_19_1:preventDefault()

	local var_19_0 = arg_19_1:getSender()
	local var_19_1 = var_19_0:getSkillPos()

	if self._uniteList[var_19_1] and next(self._uniteList[var_19_1]) then
		self._startPos = var_19_1

		fgui.DragDropManager:getInstance():startDrag(var_19_0.m_skillIcon:getIcon(), self._uniteList[var_19_1]:getAdvanceId(), (arg_19_1:getInput():getTouchId()))

		self._dragUniteComp = var_19_0

		self._dragUniteComp:onDragStart()
	end
end

function FormationMainBottomComp:_dropLineupSkill(arg_20_1)
	local var_20_0 = arg_20_1:getSender():getSkillPos()
	local var_20_1 = arg_20_1:getDataValue() or 0

	if var_20_0 <= var_0_2.FORMAT_UNITE_NUM_MAX and var_20_1 ~= 0 then
		local var_20_2 = var_0_9:getTokenByAdvId(var_20_1)

		if var_20_2 and var_20_2:getPos() ~= var_20_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = var_0_1.TYPE_UNITE_TOKEN,
				pos = var_20_0,
				id = var_20_1
			})
		end

		self._startPos = 0
	end

	self:updateComp()
end

function FormationMainBottomComp:_dragLineupPet(arg_21_1)
	arg_21_1:preventDefault()

	local var_21_0 = arg_21_1:getSender()
	local var_21_1 = var_21_0:getPetPos()
	local var_21_2 = var_0_7:getPetByPos(var_21_1)

	if var_21_2 then
		fgui.DragDropManager:getInstance():startDrag("ui://formation/FormationPrePetIcon", var_21_2:getSid(), (arg_21_1:getInput():getTouchId()))

		local var_21_3 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_21_3 then
			fgui.UIPackage.iterObject(var_21_3)
			fgui.UIPackage.bindUIComponent(var_21_3, "app.view.module.formation.pre.comp.FormationPrePetIcon", var_21_3:getParent())
			var_21_3:updatePetFormatIcon(var_21_2)
		end

		self._dragPetComp = var_21_0
		self._startPos = var_21_1

		self._dragPetComp:onDragStart()
	end
end

function FormationMainBottomComp:_dropLineupPet(arg_22_1)
	local var_22_0 = arg_22_1:getSender():getPetPos()
	local var_22_1 = arg_22_1:getDataValue() or 0

	if var_22_0 <= var_0_4.LINEUP_MAX and var_22_0 ~= self._startPos then
		local var_22_2 = var_0_7:getPetBySid(var_22_1)

		if var_22_2 and var_22_2:getLineupPos() ~= var_22_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = var_0_1.TYPE_PET,
				pos = var_22_0,
				id = var_22_1
			})
		end

		self._startPos = 0
	end

	self:updateComp()
end

function FormationMainBottomComp:_dragLineupSuccuba(arg_23_1)
	arg_23_1:preventDefault()

	local var_23_0 = arg_23_1:getSender()
	local var_23_1 = var_23_0:getSuccubaPos()
	local var_23_2 = var_0_10:getLineUpSuccuba(var_23_1)

	if var_23_2 then
		fgui.DragDropManager:getInstance():startDrag("ui://formation/FormationSuccubaIconComp", var_23_2:getSid(), (arg_23_1:getInput():getTouchId()))

		local var_23_3 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_23_3 then
			fgui.UIPackage.iterObject(var_23_3)
			fgui.UIPackage.bindUIComponent(var_23_3, "app.view.module.formation.pre.comp.FormationSuccubaIconComp", var_23_3:getParent())
			var_23_3:updateSuccubaIcon(var_23_2)
		end

		self._dragSuccubaComp = var_23_0
		self._startPos = var_23_1

		self._dragSuccubaComp:onDragStart()
	end
end

function FormationMainBottomComp:_dropLineupSuccuba(arg_24_1)
	local var_24_0 = arg_24_1:getSender():getSuccubaPos()
	local var_24_1 = arg_24_1:getDataValue() or 0

	if var_24_0 <= var_0_5.FORMAT_SUCCUBA_NUM_MAX and var_24_0 ~= self._startPos then
		local var_24_2 = var_0_10:getSuccubaBySid(var_24_1)

		if var_24_2 and var_24_2:getPosition() ~= var_24_0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = var_0_1.TYPE_SUCCUBA,
				pos = var_24_0,
				id = var_24_1
			})
		end

		self._startPos = 0
	end

	self:updateComp()
end

function FormationMainBottomComp:updateComp()
	self:updateUniteView()
	self:updatePetView()
	self:updateSuccubaView()
	self:updatePartnerView()

	if self._hideSuccuba then
		self.m_tabBtn4:setVisible(false)
	end
end

function FormationMainBottomComp:updatePartnerView()
	self.m_knightList:setNumItems(var_0_3.SHOW_PARTNER_NUM)
end

function FormationMainBottomComp:updateUniteView()
	local var_27_0 = var_0_9:getLineupTokenList()

	self._uniteList = var_27_0

	for iter_27_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_27_0]:updateTokenFormatIcon(var_27_0[iter_27_0])
	end
end

function FormationMainBottomComp:updatePetView()
	for iter_28_0 = 1, var_0_4.LINEUP_MAX do
		self["m_petComp" .. iter_28_0]:updatePetFormatIcon((var_0_7:getPetByPos(iter_28_0)))
	end
end

function FormationMainBottomComp:updateSuccubaView()
	self._succubaList = var_0_10:getLineUpSuccubaList()

	for iter_29_0 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_29_0]:updateSuccubaIcon(self._succubaList[iter_29_0], true)
	end
end

function FormationMainBottomComp:_onTouchEnd(arg_30_1)
	local var_30_0 = arg_30_1 and arg_30_1:getInput():getTouch()

	if var_30_0 and self._startPos > 0 then
		local var_30_1 = var_30_0:getLocation()
		local var_30_2 = self.m_showTabController:getSelectedIndex()

		if var_30_2 == var_0_6.TAB_INDEX.UNITE then
			if self["m_uniteBtn" .. self._startPos] and not self["m_uniteBtn" .. self._startPos]:containPoint(var_30_1) then
				if self._uniteList[self._startPos] and next(self._uniteList[self._startPos]) then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						pos = 0,
						tp = var_0_1.TYPE_UNITE_TOKEN,
						id = self._uniteList[self._startPos]:getAdvanceId()
					})
				end
			end
		elseif var_30_2 == var_0_6.TAB_INDEX.PET then
			-- block empty
		elseif var_30_2 == var_0_6.TAB_INDEX.SUCCUBA and self["m_succubaComp" .. self._startPos] and not self["m_succubaComp" .. self._startPos]:containPoint(var_30_1) then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				pos = 0,
				tp = var_0_1.TYPE_SUCCUBA,
				id = self._succubaList[self._startPos]:getSid()
			})
		end

		self._startPos = 0
	end

	if self._dragUniteComp then
		self._dragUniteComp:onDragEnd()

		self._dragUniteComp = nil
	end

	if self._dragPetComp then
		self._dragPetComp:onDragEnd()

		self._dragPetComp = nil
	end

	if self._dragSuccubaComp then
		self._dragSuccubaComp:onDragEnd()

		self._dragSuccubaComp = nil
	end
end

function FormationMainBottomComp:updateOther(arg_31_1)
	self._isOther = true
	self._otherData = arg_31_1

	for iter_31_0 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_31_0]:setDraggable(false)
		self["m_uniteBtn" .. iter_31_0]:updateTokenFormatIcon(arg_31_1.unitTokenData[iter_31_0])
		self["m_uniteBtn" .. iter_31_0]:setIsOtherStyle()
	end

	for iter_31_1 = 1, var_0_4.LINEUP_MAX do
		self["m_petComp" .. iter_31_1]:updatePetFormatIcon(arg_31_1.pets[iter_31_1])
		self["m_petComp" .. iter_31_1]:setIsOtherStyle(true)
		self["m_petComp" .. iter_31_1]:setIsLock(false)
	end

	for iter_31_2 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_31_2]:updateSuccubaIcon(arg_31_1.succubaList[iter_31_2])
		self["m_succubaComp" .. iter_31_2]:setIsOtherStyle(true)
		self["m_succubaComp" .. iter_31_2]:setVisible(true)
		self["m_succubaComp" .. iter_31_2]:setIsLock(false)
		self["m_succubaComp" .. iter_31_2]:setDraggable(false)
	end

	self.m_knightList:setNumItems(var_0_3.SHOW_PARTNER_NUM)
	self.m_oneKeyBtn:setVisible(false)

	local function var_31_0(arg_32_0)
		self["m_tabBtn" .. arg_32_0 + 1]:setVisible(true)
		self["m_tabBtn" .. arg_32_0 + 1]:getChild("redPointComp"):setVisible(false)
	end

	var_31_0(var_0_6.TAB_INDEX.UNITE)
	var_31_0(var_0_6.TAB_INDEX.PET)
	var_31_0(var_0_6.TAB_INDEX.HELPER)
	var_31_0(var_0_6.TAB_INDEX.SUCCUBA)
	self:setVisible(true)
end

function FormationMainBottomComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FormationMainBottomComp:setSuccubaHide(arg_34_1)
	self._hideSuccuba = arg_34_1
end

return FormationMainBottomComp
