local var_0_0 = 5
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX
local var_0_3 = g.core.const.ConstMgr.BASE_CONST
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.model.User.formationData
local var_0_6 = g.core.model.User.artifactData
local LineUpKnightPop = class("LineUpKnightPop", require("app.fairyGUI.lineUp.UI_LineUpKnightPop"), function()
	return fgui.GComponent:create({
		resName = "LineUpKnightPop",
		pkgPath = "ui/lineUp/lineUp",
		isFullScreen = true,
		pkgName = "lineUp"
	})
end)

function LineUpKnightPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CLEAR_COUNT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	self._waitState = true
	self._knightId = arg_2_1.knightSid or 0
	self._knightAdvId = 0

	if self._knightId > 0 then
		self._knightAdvId = var_0_4:getKnightById(self._knightId):getAdvanceId()
	end

	if arg_2_1 then
		self._pos = arg_2_1.index or 1
	end

	self._isHelper = arg_2_1.isHelper or false
	self._groupSelectedIndex = 0
	self._knightCards = {}
	self._clickPosIndex = nil
	self._tabProfession = 0
	self._tabDamageType = 0
	self._tabElement = 0

	self.m_cancelScreenBg:setVisible(false)
	self:_init()
	self:_addListeners()
	self.m_checkBtn:setSelected(var_0_5:isHideLineupKnight())
	self.m_screenComp:setVisible(false)
	self.m_screenBtn:setSelected(false)

	local var_2_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_2_0:setHook("listEnter", handler(self, self._updateView))

	if var_2_0 then
		var_2_0:play(function()
			g.core.common.Scheduler:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

				self._waitState = false

				if not self._isOnClose then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
				end
			end, 0.2)
		end)
	end
end

function LineUpKnightPop:_init()
	self.m_groupList:setSelectedIndex(self._groupSelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_groupList
	})
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onCardItemRenderer))
end

function LineUpKnightPop:_onCardItemRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > #self._knightCards then
		return
	end

	arg_6_2:updateView(self._knightCards[arg_6_1 + 1], self._pos, self._isHelper)
end

function LineUpKnightPop:_addListeners()
	self.m_checkBtn:addClickListener(handler(self, self._onCheckBtnClick))
	self.m_recruitBtn:addClickListener(handler(self, self._onGotoRecruit))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupListClickItem))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCardListItem))
	self.m_screenBtn:addClickListener(handler(self, self._onClickScreenBtn))
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
	self.m_cancelScreenBg:addClickListener(handler(self, self._onCancelScreenClick))
end

function LineUpKnightPop:_onCancelScreenClick()
	self.m_screenBtn:setSelected(false)
	self.m_screenComp:setVisible(false)
	self.m_cancelScreenBg:setVisible(false)
end

function LineUpKnightPop:_onClickScreenBtn()
	local var_9_0 = self.m_screenBtn:isSelected()

	self.m_screenComp:setVisible(var_9_0)
	self.m_cancelScreenBg:setVisible(var_9_0)
end

function LineUpKnightPop:_onCheckBtnClick()
	var_0_5:setHideLineupKnight((self.m_checkBtn:isSelected()))
	self:_updateView()
end

function LineUpKnightPop:_onGroupListClickItem(arg_11_1)
	local var_11_0 = self.m_groupList:getSelectedIndex()

	if var_11_0 == self._groupSelectedIndex then
		return
	end

	self._groupSelectedIndex = var_11_0

	self:_updateView()
end

function LineUpKnightPop:_onClickCardListItem(arg_12_1)
	local var_12_0 = arg_12_1:getDataValue()

	if var_0_3.HAS_PUT_CHECK and not self._knightCards[var_12_0 + 1]:isPut() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1159))

		return
	end

	if self._knightCards[var_12_0 + 1]:isElementLeader() then
		local var_12_1 = self._knightCards[var_12_0 + 1]:isLineup() and self._knightCards[var_12_0 + 1]:getFormationPos() or 0

		for iter_12_0 = 1, var_0_2 do
			if iter_12_0 ~= self._pos and iter_12_0 ~= var_12_1 then
				local var_12_2 = var_0_4:getKnightByFormationIndex(iter_12_0)

				if var_12_2 and var_12_2:isElementLeader() then
					g.core.module.ModuleManager:tip(g.core.lang:get(200051))

					return
				end
			end
		end
	end

	if not var_0_4:getKnightByFormationIndex(self._pos) and self._knightCards[var_12_0 + 1]:isLineup() then
		return
	end

	self._clickPosIndex = var_12_0

	local var_12_3, var_12_4, var_12_5, var_12_6 = self:checkArtifactDown()

	if var_12_3 and not var_0_6:isNotifyState() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(200044),
			desc = g.core.lang:get(200043, {
				names = var_12_5,
				artifactNames = var_12_6
			}),
			onConfirm = handler(self, self.checkKnightChange),
			tip = {
				txt = g.core.lang:get(108045),
				isChecked = var_0_6:isNotifyState()
			},
			onCheck = function(arg_13_0)
				var_0_6:setNotifyState(arg_13_0)
			end
		}), {
			touchDisappear = true
		})
	else
		self:checkKnightChange()
	end
end

function LineUpKnightPop:checkArtifactDown()
	if not self._clickPosIndex then
		return false
	end

	local var_14_0 = {}
	local var_14_1 = ""
	local var_14_2 = ""

	local function var_14_3(arg_15_0)
		var_14_1 = var_14_1 == "" and arg_15_0 or var_14_1 .. "," .. arg_15_0
	end

	local function var_14_4(arg_16_0)
		var_14_2 = var_14_2 == "" and arg_16_0 or var_14_2 .. "," .. arg_16_0
	end

	local var_14_5 = var_0_4:getKnightByFormationIndex(self._pos)

	if var_14_5 and var_14_5:isLineup() then
		local var_14_6 = var_0_6:getArtifactByFormationIndex(var_14_5:getFormationPos())

		if var_14_6 and var_14_6:checkIsOnlyKnight() then
			table.insert(var_14_0, var_14_6)
			var_14_3(var_14_5:getName())
			var_14_4(var_14_6:getArtifactName())
		end
	end

	local var_14_7 = var_0_6:getArtifactByFormationIndex(self._knightCards[self._clickPosIndex + 1]:getFormationPos())

	if var_14_7 and var_14_7:checkIsOnlyKnight() then
		table.insert(var_14_0, var_14_7)
		var_14_3(self._knightCards[self._clickPosIndex + 1]:getName())
		var_14_4(var_14_7:getArtifactName())
	end

	return next(var_14_0), var_14_0, "", ""
end

function LineUpKnightPop:checkKnightChange()
	if not self._clickPosIndex then
		return
	end

	local var_17_0 = self._knightCards[self._clickPosIndex + 1]
	local var_17_1 = var_0_4:getKnightByFormationIndex(self._pos)
	local var_17_2 = self._knightCards[self._clickPosIndex + 1]:getServerId()

	if var_17_1 then
		if var_17_2 == var_17_1:getServerId() then
			if self._isHelper then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					pos = 0,
					tp = g.core.network.proto.TYPE_KNIGHT,
					id = var_17_2
				})
				self:_onClose()
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(200004))
			end
		elseif self._pos <= var_0_2 and (var_17_1:getLevel() > 1 or var_17_1:getAdvanceLevel() > 0) then
			g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.InheritFormationPop").new({
				pos = self._pos,
				id = var_17_2
			})))
		else
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = g.core.network.proto.TYPE_KNIGHT,
				pos = self._pos,
				id = var_17_2
			})
			self:_onClose()
		end
	elseif var_17_0:isLineup() then
		g.core.module.ModuleManager:tip(g.core.lang:get(self._isHelper and 200011 or 200003))
	else
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = g.core.network.proto.TYPE_KNIGHT,
			pos = self._pos,
			id = var_17_2
		})
		self:_onClose()
	end

	self._clickPosIndex = nil
end

function LineUpKnightPop:_onClose(arg_18_1)
	if self._isOnClose then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CLEAR_GUIDE_COMP)

	if (arg_18_1 or nil) and not self.m_bgPanel:containPoint((arg_18_1:getInput():getTouch():getLocation())) then
		self.m_cardList:setTouchable(false)

		self._isOnClose = true

		local var_18_1 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_18_1 then
			var_18_1:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function LineUpKnightPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onLineUpEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_INHERITFORMATION, self._onLineUpEnd, self)
	self.m_groupList:setNumItems(var_0_0)
	self.m_groupList:resizeToFit(var_0_0)
	self.m_groupList:setSelectedIndex(0)
end

function LineUpKnightPop:_updateView()
	local var_21_0 = {
		group = self._groupSelectedIndex,
		profession = self._tabProfession,
		damage = self._tabDamageType,
		element = self._tabElement
	}

	self._knightCards = self.m_checkBtn:isSelected() and var_0_4:getLineupAvailListByParams(self._knightAdvId, var_21_0, self._pos, false) or var_0_4:getLineupAvailListByParams(self._knightAdvId, var_21_0, self._pos, true)

	local var_21_1 = #self._knightCards

	if #self._knightCards == 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(var_21_1)
		self.m_cardList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end

	self:_checkTickWeakGuide()
end

function LineUpKnightPop:_onGotoRecruit()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, {
		type = var_0_1.RecruitConst.RECRUIT_TYPE.PREMIUM
	})
	self:_onClose()
end

function LineUpKnightPop:_checkTickWeakGuide()
	if #self._knightCards == 0 then
		local var_23_0 = var_0_4:getFormationKnights()

		for iter_23_0 = 1, 6 do
			if var_23_0[iter_23_0] == 0 then
				local var_23_1 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_ADVANCE_RECRUIT_ITEM)

				if var_23_1 > 0 or (var_23_1 == 0 or nil) and g.core.model.User:getFreeGold() >= g.core.model.User.recruitData:getFuncNeedInfoByRecruitInfo(2, 1).priceInfo.size then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
						key = "GOTO_RECRUIT_KNIGHT",
						targetBtn = self.m_recruitBtn
					})
				end
			end
		end
	end
end

function LineUpKnightPop:_onLineUpEnd()
	self:_onClose()
end

function LineUpKnightPop:onUnload()
	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

		self._waitState = false
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function LineUpKnightPop:receiveCompEvent(arg_26_1, arg_26_2)
	if arg_26_1 == "changeProfession" then
		self._tabProfession = arg_26_2.index

		self:_updateView()
	elseif arg_26_1 == "changeDamageType" then
		self._tabDamageType = arg_26_2.index

		self:_updateView()
	elseif arg_26_1 == "changeElement" then
		self._tabElement = arg_26_2.index

		self:_updateView()
	end
end

return LineUpKnightPop
