local var_0_0 = g.core.model.User.fogNightmareData
local var_0_1 = g.core.lang
local var_0_2 = g.core.model.User.preciousData
local var_0_3 = g.core.module.ModuleManager
local CommonLineUpPreciousSuitPop = require("app.view.base.infoPop.lineup.CommonLineUpPreciousSuitPop")
local var_0_5 = g.core.const.ConstMgr.PreciousConst
local var_0_6 = g.core.const.ConstMgr.LineUpConst
local var_0_7 = g.core.model.User.mulFormationData
local var_0_8 = g.core.model.User.formationData
local var_0_9 = g.core.model.User.gveDataMgr
local var_0_10 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_11 = g.core.const.ConstMgr.FormationConst
local BasePreciousSuitBtn = class("BasePreciousSuitBtn", require("app.fairyGUI.base_new.UI_BasePreciousSuitBtn"))

function BasePreciousSuitBtn:ctor()
	self._formationStruct = nil
	self._specialFormationStruct = nil
	self._isMain = false
	self._formationType = var_0_6.MulTeamType.MAIN
	self._preType = 0
	self._clickStationPos = 0
	self._suitStartDragStationPos = 0
	self._isTouched = false
	self._touchIndex = 0
	self._selectedComp = nil
	self._moveComp = nil
	self._movePos = nil
	self._touchStep = 0
	self._updateStep = 0
	self._isOther = false
	self._otherSuitList = {}

	self:initView()
end

function BasePreciousSuitBtn:initView()
	self:addClickListener(handler(self, self._onClickSelf))
	print("name is : " .. self:getName())
	self.m_preciousSuitList:setVirtual()
	self.m_preciousSuitList:setItemRenderer(handler(self, self._onRenderSuitList))
	self.m_preciousSuitList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickIcon))
	self.m_preciousSuitList:setScrollEnabled(false)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function BasePreciousSuitBtn:_onTouchBegin(arg_3_1)
	arg_3_1:stopPropagation()
	arg_3_1:captureTouch()

	if self._isTouched or self._isOther then
		return
	end

	local var_3_0 = arg_3_1:getInput():getTouch()
	local var_3_1 = self:_checkPosInComp(var_3_0:getLocation(), false)

	if var_3_0 and var_3_1:getId() > 0 then
		self._selectedComp = var_3_1
		self._moveComp = fgui.UIPackage:createObject("base_new", "BasePreciousSuitIcon")

		self._moveComp:becomeTo(var_3_1)
		self._moveComp:setTouchable(false)
		self._moveComp:setVisible(false)
		self:addChild(self._moveComp, 1)

		local var_3_2 = self.m_preciousSuitList:getPosition()
		local var_3_3 = self._selectedComp:getPosition()

		var_3_2.x = var_3_2.x + var_3_3.x
		var_3_2.y = var_3_2.y + var_3_3.y

		self._moveComp:setPosition(var_3_2)

		self._movePos = var_3_2

		arg_3_1:captureTouch()
	end
end

function BasePreciousSuitBtn:_onTouchMove(arg_4_1)
	if not self._selectedComp then
		return
	end

	self._touchStep = self._touchStep + 1

	if self._touchStep > 6 and not self._isTouched then
		self._isTouched = true
		self._touchStep = 0

		self._selectedComp:setTouchable(false)

		self._suitStartDragStationPos = self._selectedComp:getStationPos()
		self._clickId = self._selectedComp:getId()

		self._selectedComp:updateSuitIcon(self._suitStartDragStationPos, 0)
		self._moveComp:setVisible(true)
	end

	local var_4_0 = arg_4_1:getInput():getTouch():getDelta()

	self._movePos.x = self._movePos.x + var_4_0.x
	self._movePos.y = self._movePos.y - var_4_0.y

	self._moveComp:setPosition(self._movePos)
end

function BasePreciousSuitBtn:_onTouchEnd(arg_5_1)
	self._touchStep = 0
	self._isTouched = false

	if self._selectedComp then
		self._selectedComp:setTouchable(true)

		if self._suitStartDragStationPos > 0 then
			self._moveComp:removeFromParent()

			self._moveComp = nil

			local var_5_0 = arg_5_1:getInput():getTouch()

			if var_5_0 then
				local var_5_1 = self:_checkPosInComp(var_5_0:getLocation(), true):getStationPos()

				if var_5_1 ~= self._suitStartDragStationPos then
					if self._isMain then
						g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
							tp = g.core.network.proto.TYPE_PRECIOUS_SUIT,
							pos = var_5_1,
							id = self._clickId
						})
					elseif self._formationType == var_0_6.MulTeamType.FOG_NIGHTMARE then
						self._specialFormationStruct:lineupPreciousSuit(var_5_1, self._clickId)
					else
						self._formationStruct:lineupPreciousSuit(var_5_1, self._clickId)
					end
				end

				self:updateSuitComp()
			elseif self._isMain then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					pos = 0,
					tp = g.core.network.proto.TYPE_PRECIOUS_SUIT,
					id = self._clickId
				})
			elseif self._formationType == var_0_6.MulTeamType.FOG_NIGHTMARE then
				self._specialFormationStruct:lineupPreciousSuit(self._suitStartDragStationPos, 0)
			else
				self._formationStruct:lineupPreciousSuit(self._suitStartDragStationPos, 0)
			end
		else
			self._clickStationPos = self._selectedComp:getStationPos()

			self:_pushLineUp()
		end

		self._suitStartDragStationPos = 0
		self._clickId = 0
	end

	self._selectedComp = nil
end

function BasePreciousSuitBtn:_checkPosInComp(arg_6_1, arg_6_2)
	for iter_6_0 = 1, var_0_5.LINEUP_MAX do
		local var_6_0 = self.m_preciousSuitList:getChildAt(iter_6_0 - 1)

		if var_6_0 and (arg_6_2 or var_6_0:getId() > 0) and var_6_0:containPoint(arg_6_1) then
			return var_6_0
		end
	end

	return nil
end

function BasePreciousSuitBtn:setBtnFormationData(arg_7_1, arg_7_2, arg_7_3)
	self._isOther = false
	self._formationType = arg_7_1
	self._preType = arg_7_3
	self._isMain = arg_7_1 == var_0_6.MulTeamType.MAIN

	if arg_7_1 == var_0_6.MulTeamType.PRE_FORMATION then
		self._formationStruct = arg_7_3 == var_0_11.PRESET_FORMATION_TYPE.MAIN and var_0_8:getPreFormation(arg_7_2) or var_0_9:getGveFormationData():getPresetFormationStruct(arg_7_2)
	elseif arg_7_1 == var_0_6.MulTeamType.FOG_NIGHTMARE then
		self._specialFormationStruct = var_0_0:getFormationData():getLineUpFormation(arg_7_2)
	elseif not self._isMain then
		self._formationStruct = var_0_7:getFormationStruct(arg_7_1, arg_7_2)
	end

	self:updateSuitComp()

	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_showStateController:setSelectedIndex(1)
	else
		self.m_showStateController:setSelectedIndex(0)
	end
end

function BasePreciousSuitBtn:onLoad()
	local var_8_0 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_10.PRECIOUS)

	if var_8_0 then
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self.updateSuitComp), self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_ERROR_SAVE, handler(self, self.updateSuitComp), self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self.updateSuitComp), self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_SAVE, handler(self, self.updateSuitComp), self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRESET_FORMATION_SAVE, handler(self, self.updateSuitComp), self)
	end

	self:setVisible(var_8_0)
end

function BasePreciousSuitBtn:updateSuitComp()
	self.m_preciousSuitList:setNumItems(var_0_5.LINEUP_MAX)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			hasRed = self._isMain == true
		}
	})
end

function BasePreciousSuitBtn:_onRenderSuitList(arg_10_1, arg_10_2)
	if self._isOther then
		arg_10_2:updateOtherSuitIcon(self._otherSuitList[arg_10_1 + 1])
	elseif self._isMain then
		arg_10_2:updateSuitIcon(arg_10_1 + 1, var_0_8:getPreciousSuitId(arg_10_1 + 1), true)
	elseif self._formationType == var_0_6.MulTeamType.FOG_NIGHTMARE then
		arg_10_2:updateSuitIcon(arg_10_1 + 1, self._specialFormationStruct:getPreciousSuitId(arg_10_1 + 1))
	else
		arg_10_2:updateSuitIcon(arg_10_1 + 1, self._formationStruct:getPreciousSuitSid(arg_10_1 + 1))
	end
end

function BasePreciousSuitBtn:_onClickIcon(arg_11_1)
	if self._isTouched then
		return
	end

	if self._isOther then
		local var_11_0 = self._otherSuitList[arg_11_1:getDataValue() + 1]

		if not var_11_0 then
			return
		end

		local var_11_1 = var_11_0:getMaxPassiveSkillList()
		local var_11_2 = {}

		for iter_11_0 = 1, #var_11_1 do
			table.insert(var_11_2, {
				state = var_11_0:getStar() >= var_11_1[iter_11_0].star and 0 or 1,
				title = g.core.lang:get(421210, {
					lv = var_11_1[iter_11_0].lv,
					star = var_11_1[iter_11_0].star
				}),
				desc = var_11_1[iter_11_0].desc
			})
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonSkillPop").new({
			isPassive = true,
			skillId = var_11_0:getCfg().passive_skill_id,
			descList = var_11_2,
			tipsText = g.core.lang:get(421209)
		}), {
			touchDisappear = true
		})

		return
	else
		self._clickStationPos = arg_11_1:getDataValue() + 1

		self:_pushLineUp()
	end
end

function BasePreciousSuitBtn:_pushLineUp()
	self._popView = var_0_3:pushPopup(CommonLineUpPreciousSuitPop.new({
		itemUrl = "ui://infoPop/CommonLineUpPreciousSuitCell",
		isFilter = true,
		allList = var_0_2:getAllActiveSuitList(),
		isLineUpCall = handler(self, self._isLineup),
		clickCheckFunc = handler(self, self._onClickLineupPopItem),
		cellParam = {
			formationType = self._formationType
		}
	}), {
		blackOpacity = 0.5,
		ignoreTouch = false,
		touchDisappear = false
	})
end

function BasePreciousSuitBtn:_isLineup(arg_13_1)
	if self._isMain then
		return var_0_8:getPreciousSuitStationPos(arg_13_1:getSuitGroup()) > 0
	elseif self._formationType == var_0_6.MulTeamType.PRE_FORMATION then
		return self._formationStruct:isPreciousSuitLineUp(arg_13_1:getSuitGroup())
	elseif self._formationType == var_0_6.MulTeamType.FOG_NIGHTMARE then
		return var_0_0:getFormationData():isPreciousSuitLineup(arg_13_1:getSuitGroup())
	else
		return var_0_7:isPreciousSuitLineup(self._formationType, arg_13_1:getSuitGroup())
	end
end

function BasePreciousSuitBtn:_onClickLineupPopItem(arg_14_1)
	local var_14_0 = arg_14_1:getSuitGroup()

	if self._isMain then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = g.core.network.proto.TYPE_PRECIOUS_SUIT,
			pos = self._clickStationPos,
			id = var_14_0
		})

		return true
	elseif self._formationType == var_0_6.MulTeamType.PRE_FORMATION then
		self._formationStruct:lineupPreciousSuit(self._clickStationPos, var_14_0)
		self:updateSuitComp()

		return true
	elseif self._formationType == var_0_6.MulTeamType.FOG_NIGHTMARE then
		if self._specialFormationStruct:isPreciousSuitLineUp(arg_14_1:getSuitGroup()) then
			if var_14_0 == self._specialFormationStruct:getPreciousSuitId(self._clickStationPos) then
				var_0_3:tip(var_0_1:get(200048))

				return false
			else
				self._specialFormationStruct:lineupPreciousSuit(self._clickStationPos, var_14_0)
				self:updateSuitComp()

				return true
			end
		elseif var_0_0:getFormationData():isPreciousSuitLineup(var_14_0) then
			local var_14_1 = var_0_0:getFormationData():getFormationStructPreciousSuitLineup(var_14_0)
			local var_14_2, var_14_3

			if var_0_0:getFormationData():isUsedFormation(var_14_1:getFormationIdx()) then
				var_0_3:tip(var_0_1:get(200049))

				do return false end

				var_14_2 = {
					groupId = var_14_0
				}
				var_14_3 = {}
			end

			var_14_3.num = var_14_1:getFormationIdx()
			var_14_2.teamName = var_0_1:get(200027, var_14_3)

			var_0_3:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
				isPreciousSuit = true,
				desc = var_0_1:get(200028, {
					name = var_0_1:get(201071),
					num = self._specialFormationStruct:getFormationIdx()
				}),
				itemDataArr = {
					var_14_2
				},
				onConfirm = handler(self, function(arg_15_0)
					var_14_1:takeOffPreciousSuit(var_14_0)
					arg_15_0._specialFormationStruct:lineupPreciousSuit(arg_15_0._clickStationPos, var_14_0)
					arg_15_0:updateSuitComp()
					var_0_3:onlyPopSelfByDisplay(arg_15_0._popView)

					arg_15_0._popView = nil
				end)
			}))

			return false
		else
			self._specialFormationStruct:lineupPreciousSuit(self._clickStationPos, var_14_0)
			self:updateSuitComp()

			return true
		end
	elseif self._formationStruct:isPreciousSuitLineUp(var_14_0) then
		if var_14_0 == self._formationStruct:getPreciousSuitSid(self._clickStationPos) then
			var_0_3:tip(var_0_1:get(200048))

			return false
		else
			self._formationStruct:lineupPreciousSuit(self._clickStationPos, var_14_0)
			self:updateSuitComp()

			return true
		end
	elseif var_0_7:isPreciousSuitLineup(self._formationType, var_14_0) then
		local var_14_4 = var_0_7:getFormationStructPreciousSuitLineup(self._formationType, var_14_0)

		var_0_3:pushPopup(require("app.view.base.infoPop.MulTeamFormationChangeConfirmPop").new({
			isPreciousSuit = true,
			desc = var_0_1:get(200028, {
				name = var_0_1:get(201071),
				num = self._formationStruct:getFormationIdx()
			}),
			itemDataArr = {
				{
					groupId = var_14_0,
					teamName = var_0_1:get(200027, {
						num = var_14_4:getFormationIdx()
					})
				}
			},
			onConfirm = handler(self, function(arg_16_0)
				var_14_4:takeOffPreciousSuit(var_14_0)
				arg_16_0._formationStruct:lineupPreciousSuit(arg_16_0._clickStationPos, var_14_0)
				arg_16_0:updateSuitComp()
				var_0_3:onlyPopSelfByDisplay(arg_16_0._popView)

				arg_16_0._popView = nil
			end)
		}))

		return false
	else
		self._formationStruct:lineupPreciousSuit(self._clickStationPos, var_14_0)
		self:updateSuitComp()

		return true
	end
end

function BasePreciousSuitBtn:_onClickSelf()
	if self.m_IsExpandController:getSelectedIndex() == 1 then
		self.m_IsExpandController:setSelectedIndex(0)
		self.m_preciousSuitList:setTouchable(false)
	else
		self.m_IsExpandController:setSelectedIndex(1)
		self.m_preciousSuitList:setTouchable(true)
	end
end

function BasePreciousSuitBtn:setOtherUserData(arg_18_1)
	self._isOther = true
	self._otherSuitList = arg_18_1 or {}

	self:updateSuitComp()

	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_showStateController:setSelectedIndex(1)
	else
		self.m_showStateController:setSelectedIndex(0)
	end
end

return BasePreciousSuitBtn
