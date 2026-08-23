local var_0_0 = g.core.config.knight_association_info
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.UniteTokenConst
local var_0_4 = g.core.const.ConstMgr.PetConst
local var_0_5 = g.core.const.ConstMgr.SuccubaConst
local var_0_6 = g.core.const.ConstMgr.FormationConst
local var_0_7 = g.core.const.ConstMgr.BASE_CONST
local var_0_8 = g.core.model.User.petsData
local var_0_9 = g.core.model.User.uniteTokenData
local var_0_10 = g.core.model.User.succubaData
local var_0_11 = g.core.model.User.knightsData
local var_0_12 = g.core.module.ModuleManager
local var_0_13 = g.core.common.ModuleUnlock
local FormationPreBottomComp = class("FormationPreBottomComp", require("app.fairyGUI.formation.UI_FormationPreBottomComp"))
local var_0_15 = 100000

function FormationPreBottomComp:ctor()
	self._startPos = 0
	self._formationPreStruct = nil
	self._dragUniteComp = nil
	self._dragPetComp = nil

	self:_initComp()
end

function FormationPreBottomComp:_initComp()
	for iter_2_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		if var_0_13:isModuleUnlock(var_0_2["UNITE_TOKEN_LINE_UP_" .. iter_2_0]) then
			self["m_uniteBtn" .. iter_2_0]:setSkillPos(iter_2_0)
			self["m_uniteBtn" .. iter_2_0]:setDraggable(true)
			self["m_uniteBtn" .. iter_2_0]:setClickAddCall(handler(self, self._callAddUnitePop))
			self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupSkill))
			self["m_uniteBtn" .. iter_2_0]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupSkill))
		else
			self["m_uniteBtn" .. iter_2_0]:updateFormatUnlock((var_0_13:getModuleUnlockLevel(var_0_2["UNITE_TOKEN_LINE_UP_" .. iter_2_0])))
		end
	end

	for iter_2_1 = 1, var_0_4.LINEUP_MAX do
		if var_0_13:isModuleUnlock(var_0_2["PET_LINE_UP_" .. iter_2_1]) then
			self["m_petComp" .. iter_2_1]:setPetPos(iter_2_1)
			self["m_petComp" .. iter_2_1]:setDraggable(true)
			self["m_petComp" .. iter_2_1]:setClickAddCall(handler(self, self._callAddPetPop))
			self["m_petComp" .. iter_2_1]:addEventListener(fgui.UIEventType.DragStart, handler(self, self._dragLineupPet))
			self["m_petComp" .. iter_2_1]:addEventListener(fgui.UIEventType.Drop, handler(self, self._dropLineupPet))
			self["m_petComp" .. iter_2_1].m_redPointComp:setVisible(false)
		else
			local var_2_0, var_2_1 = var_0_13:getModuleUnlockLevelAndComment(var_0_2["PET_LINE_UP_" .. iter_2_1])

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
	self.m_oneKeyBtn:addClickListener(handler(self, self._onClickOneKeyBtn))

	local var_2_2 = -1

	local function var_2_3(arg_3_0, arg_3_1)
		local var_3_0 = var_0_13:isModuleUnlock(arg_3_1)

		if arg_3_1 == var_0_2.SUCCUBA then
			var_3_0 = var_3_0 and not self._hideSuccuba
		end

		self["m_tabBtn" .. arg_3_0 + 1]:setVisible(var_3_0)

		if var_3_0 and var_2_2 == -1 then
			var_2_2 = arg_3_0
		end
	end

	var_2_3(var_0_6.TAB_INDEX.UNITE, var_0_2.UNITE_TOKEN)
	var_2_3(var_0_6.TAB_INDEX.PET, var_0_2.PET)
	var_2_3(var_0_6.TAB_INDEX.HELPER, var_0_2.KNIGHT_PARTNER_1)
	var_2_3(var_0_6.TAB_INDEX.SUCCUBA, var_0_2.SUCCUBA)

	if -1 >= 0 then
		self:setVisible(true)
		self.m_showTabController:setSelectedIndex(-1)
	else
		self:setVisible(false)
	end
end

function FormationPreBottomComp:_onClickOneKeyBtn()
	local var_4_0 = self.m_showTabController:getSelectedIndex()

	if var_4_0 == var_0_6.TAB_INDEX.UNITE then
		for iter_4_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
			self._formationPreStruct:lineupUniteToken(iter_4_0, 0)
		end

		local var_4_1 = var_0_9:getOwnTokenList()

		table.sort(var_4_1, function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_0:getQuality()
			local var_5_1 = arg_5_1:getQuality()

			if var_5_0 ~= var_5_1 then
				return var_5_1 < var_5_0
			end

			local var_5_2 = arg_5_0:getStarLevel()
			local var_5_3 = arg_5_1:getStarLevel()

			if var_5_2 ~= var_5_3 then
				return var_5_3 < var_5_2
			end

			local var_5_4 = arg_5_0:getLevel()
			local var_5_5 = arg_5_1:getLevel()

			if var_5_4 ~= var_5_5 then
				return var_5_5 < var_5_4
			end

			return arg_5_0:getBaseId() > arg_5_1:getBaseId()
		end)

		for iter_4_1 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
			if not var_0_13:isModuleUnlock(var_0_2["UNITE_TOKEN_LINE_UP_" .. iter_4_1]) then
				break
			end

			self._formationPreStruct:lineupUniteToken(iter_4_1, var_4_1[iter_4_1] and var_4_1[iter_4_1]:getAdvanceId() or 0)
		end

		self:updateUniteView()
	elseif var_4_0 == var_0_6.TAB_INDEX.PET then
		for iter_4_2 = 1, var_0_4.LINEUP_MAX do
			self._formationPreStruct:lineupPet(iter_4_2, 0)
		end

		local var_4_2 = {}

		var_4_2 = var_0_7.HAS_PUT_CHECK and var_0_8:getOwnPetArrByFilter(function(arg_6_0)
			return arg_6_0:isPut()
		end) or var_0_8:getOwnPetArr()

		table.sort(var_4_2, function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_0:getQuality()
			local var_7_1 = arg_7_1:getQuality()

			if var_7_0 ~= var_7_1 then
				return var_7_1 < var_7_0
			end

			local var_7_2 = arg_7_0:getStarNum()
			local var_7_3 = arg_7_1:getStarNum()

			if var_7_2 ~= var_7_3 then
				return var_7_3 < var_7_2
			end

			local var_7_4 = arg_7_0:getLevel()
			local var_7_5 = arg_7_1:getLevel()

			if var_7_4 ~= var_7_5 then
				return var_7_5 < var_7_4
			end

			return arg_7_0:getAdvanceId() > arg_7_1:getAdvanceId()
		end)

		if #var_4_2 == 0 then
			var_0_12:tip(g.core.lang:get(200035))

			return
		end

		for iter_4_3 = 1, var_0_4.LINEUP_MAX do
			if not var_0_13:isModuleUnlock(var_0_2["PET_LINE_UP_" .. iter_4_3]) then
				break
			end

			self._formationPreStruct:lineupPet(iter_4_3, var_4_2[iter_4_3] and var_4_2[iter_4_3]:getSid() or 0)
		end

		self:updatePetView()
	elseif var_4_0 == var_0_6.TAB_INDEX.SUCCUBA then
		for iter_4_4 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
			self._formationPreStruct:lineupSuccuba(iter_4_4, 0)
		end

		local var_4_3 = var_0_10:getSuccubaList()

		table.sort(var_4_3, function(arg_8_0, arg_8_1)
			local var_8_0 = arg_8_0:getQuality()
			local var_8_1 = arg_8_1:getQuality()

			if var_8_0 ~= var_8_1 then
				return var_8_1 < var_8_0
			end

			local var_8_2 = arg_8_0:getStar()
			local var_8_3 = arg_8_1:getStar()

			if var_8_2 ~= var_8_3 then
				return var_8_3 < var_8_2
			end

			local var_8_4 = arg_8_0:getLevel()
			local var_8_5 = arg_8_1:getLevel()

			if var_8_4 ~= var_8_5 then
				return var_8_5 < var_8_4
			end

			return arg_8_0:getAdvanceId() > arg_8_1:getAdvanceId()
		end)

		if #var_4_3 == 0 then
			var_0_12:tip(g.core.lang:get(200050))

			return
		end

		for iter_4_5 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
			if not var_0_13:isModuleUnlock(var_0_2.SUCCUBA) then
				break
			end

			self._formationPreStruct:lineupSuccuba(iter_4_5, var_4_3[iter_4_5] and var_4_3[iter_4_5]:getSid() or 0)
		end

		self:updateSuccubaView()
	elseif var_4_0 == var_0_6.TAB_INDEX.HELPER then
		local var_4_4 = false

		for iter_4_6 = 1, var_0_1.LINEUP_MAX do
			if self._formationPreStruct:getKnightSid(iter_4_6) > 0 then
				var_4_4 = true

				break
			end
		end

		if not var_4_4 then
			var_0_12:tip(g.core.lang:get(200026))

			return
		end

		local var_4_5 = 0

		for iter_4_7 = 1, var_0_1.SHOW_PARTNER_NUM do
			if var_0_13:isModuleUnlock(var_0_2["KNIGHT_PARTNER_" .. iter_4_7]) then
				var_4_5 = var_4_5 + 1
			end

			self._formationPreStruct:lineupPartner(iter_4_7, 0)
		end

		self:_autoAddPartner(1, var_4_5)
		self:updatePartnerView()
		self:dispatchCompEvent("FormationBottomComp_PartnerUpdate")
	end

	var_0_12:tip(g.core.lang:get(200034))
end

function FormationPreBottomComp:_autoAddPartner(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = 0

	for iter_9_0 = 1, var_0_1.LINEUP_MAX do
		local var_9_3 = self._formationPreStruct:getKnightSid(iter_9_0)

		if var_9_3 > 0 then
			local var_9_4 = var_0_11:getKnightById(var_9_3):getBaseInfo()

			for iter_9_1 = 1, var_0_1.ASSCT_MAX do
				if var_9_4["association_" .. iter_9_1] > 0 then
					local var_9_5 = var_0_0.get(var_9_4["association_" .. iter_9_1])

					if var_9_5.type == 1 then
						local var_9_6 = {}

						for iter_9_2 = 1, var_0_1.ASS_COND_MAX do
							if var_9_5["value_" .. iter_9_2] > 0 then
								local var_9_7 = var_0_11:getKnight({
									advance_id = var_9_5["value_" .. iter_9_2]
								})
								local var_9_8 = var_9_7:getServerId()

								if var_9_7:isOwn() then
									if not self._formationPreStruct:isKnightLineUp(var_9_8) and not self._formationPreStruct:isPartnerLineUp(var_9_8) then
										table.insert(var_9_6, var_9_7)
									end
								else
									var_9_6 = {}

									break
								end
							end
						end

						if #var_9_6 > 0 then
							local var_9_10 = var_0_15 / #var_9_6 + ((var_0_15 / #var_9_6 >= var_0_15 or nil) and 100)

							for iter_9_3, iter_9_4 in ipairs(var_9_6) do
								local var_9_11 = iter_9_4:getServerId()

								var_9_10 = var_9_10 + iter_9_4:getQuality()

								if var_9_0[var_9_11] then
									var_9_0[var_9_11] = var_9_0[var_9_11] + var_9_10
								else
									var_9_2 = var_9_2 + 1

									table.insert(var_9_1, var_9_11)

									var_9_0[var_9_11] = var_9_10
								end
							end
						end
					end
				end
			end
		end
	end

	if var_9_2 == 0 then
		return
	end

	local var_9_12 = arg_9_2 - arg_9_1 + 1

	if var_9_2 <= arg_9_2 - arg_9_1 + 1 then
		for iter_9_5, iter_9_6 in pairs(var_9_0) do
			self._formationPreStruct:lineupPartner(arg_9_1, iter_9_5)

			arg_9_1 = arg_9_1 + 1
		end
	else
		table.sort(var_9_1, function(arg_10_0, arg_10_1)
			return var_9_0[arg_10_0] > var_9_0[arg_10_1]
		end)

		if var_9_0[var_9_1[1]] >= var_0_15 then
			for iter_9_7, iter_9_8 in ipairs(var_9_1) do
				if var_9_0[iter_9_8] >= var_0_15 then
					self._formationPreStruct:lineupPartner(arg_9_1, iter_9_8)

					arg_9_1 = arg_9_1 + 1

					if arg_9_2 < arg_9_1 then
						return
					end
				end
			end

			if arg_9_1 <= arg_9_2 then
				self:_autoAddPartner(arg_9_1, arg_9_2)
			end
		elseif var_9_0[var_9_1[1]] * var_9_12 > var_0_15 then
			self._formationPreStruct:lineupPartner(arg_9_1, var_9_1[1])

			arg_9_1 = arg_9_1 + 1

			self:_autoAddPartner(arg_9_1, arg_9_2)
		end
	end
end

function FormationPreBottomComp:_onClickCell(arg_11_1)
	local var_11_0 = self.m_knightList:getSelectedIndex() + 1

	if self._isOtherUser then
		local var_11_1 = self._formationPreStruct:getOtherPartnerStruct(var_11_0)

		if var_11_1 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
				isOthers = true,
				knightStruct = var_11_1,
				matchInfos = self._formationPreStruct:getOtherMatchInfos()
			})))
		end

		return
	end

	local var_11_2 = var_0_2["KNIGHT_PARTNER_" .. var_11_0]

	if var_0_13:isModuleUnlock(var_0_2["KNIGHT_PARTNER_" .. var_11_0]) then
		self._clickPos = var_11_0

		var_0_12:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpKnightPop").new({
			isFilter = true,
			itemUrl = "ui://formation/FormationPreLineupKnightCell",
			allList = var_0_11:getOwnerAllList(),
			isLineUpCall = handler(self, self._isLineupPartnerCall),
			clickCheckFunc = handler(self, self._clickLineupPartner),
			sortFunc = handler(self, self.sortFunc),
			filterStr = g.core.lang:get(200037),
			cellParam = {
				isLineupPos = false,
				formationStruct = self._formationPreStruct,
				clickPos = var_11_0
			}
		}), {
			touchDisappear = false,
			blackOpacity = 0.5,
			ignoreTouch = false
		})
	else
		local var_11_3, var_11_4 = var_0_13:getModuleUnlockLevelAndComment(var_11_2)

		var_0_12:tip(var_11_4)
	end
end

function FormationPreBottomComp:sortFunc(arg_12_1, arg_12_2)
	local var_12_0 = self._formationPreStruct:getPartnerSid(self._clickPos)
	local var_12_1 = arg_12_1:getServerId()
	local var_12_2 = arg_12_2:getServerId()

	if var_12_0 ~= var_12_1 and var_12_0 == var_12_2 then
		return false
	end

	local var_12_3 = self._formationPreStruct:isKnightLineUp(var_12_1)

	if var_12_3 ~= self._formationPreStruct:isKnightLineUp(var_12_2) then
		return var_12_3
	end

	local var_12_4 = self._formationPreStruct:isPartnerLineUp(var_12_1)

	if var_12_4 ~= self._formationPreStruct:isPartnerLineUp(var_12_2) then
		return var_12_4
	end

	local var_12_5 = arg_12_1:getQuality()
	local var_12_6 = arg_12_2:getQuality()

	if var_12_5 ~= var_12_6 then
		return var_12_6 < var_12_5
	end

	local var_12_7 = self._formationPreStruct:getKnightAssCount(var_12_1, self._clickPos, false, false)
	local var_12_8 = self._formationPreStruct:getKnightAssCount(var_12_2, self._clickPos, false, false)

	if var_12_7 ~= var_12_8 then
		return var_12_8 < var_12_7
	end

	local var_12_9 = arg_12_1:getStarLv()
	local var_12_10 = arg_12_2:getStarLv()

	if var_12_9 ~= var_12_10 then
		return var_12_10 < var_12_9
	end

	return arg_12_1:getBaseId() > arg_12_2:getBaseId()
end

function FormationPreBottomComp:_isLineupPartnerCall(arg_13_1)
	if self._formationPreStruct:getPartnerSid(self._clickPos) == arg_13_1:getServerId() then
		return false
	end

	return self._formationPreStruct:isKnightLineUp(arg_13_1:getServerId()) or self._formationPreStruct:isPartnerLineUp(arg_13_1:getServerId())
end

function FormationPreBottomComp:_clickLineupPartner(arg_14_1)
	if self._clickPos > 0 then
		self._formationPreStruct:lineupPartner(self._clickPos, arg_14_1:getServerId())

		if self._formationPreStruct:isPartnerLineUp(arg_14_1:getServerId()) then
			var_0_12:tip(g.core.lang:get(200010))
		else
			var_0_12:tip(g.core.lang:get(200008))
		end
	end

	self._clickPos = 0

	self:updatePartnerView()
	self:dispatchCompEvent("FormationBottomComp_PartnerUpdate")

	return true
end

function FormationPreBottomComp:_onPartnerKnightRenderer(arg_15_1, arg_15_2)
	arg_15_2:setHasRedPoint(false)

	if self._isOtherUser then
		arg_15_2:updatePartnerFormatIconByKnightStruct(self._formationPreStruct:getOtherPartnerStruct(arg_15_1 + 1))
	else
		arg_15_2:updateCell(arg_15_1 + 1, self._formationPreStruct:getPartnerSid(arg_15_1 + 1))
	end
end

function FormationPreBottomComp:_callAddUnitePop(arg_16_1)
	self._clickPos = arg_16_1

	var_0_12:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpUnitePop").new({
		itemUrl = "ui://formation/FormationPreLineupUniteCell",
		isFilter = true,
		allList = var_0_9:getOwnTokenList(),
		isLineUpCall = handler(self, self._isLineupUniteCall),
		clickCheckFunc = handler(self, self._clickLineupUnite),
		filterStr = g.core.lang:get(200040),
		cellParam = {
			formationStruct = self._formationPreStruct
		}
	}), {
		touchDisappear = false,
		blackOpacity = 0.5,
		ignoreTouch = false
	})
end

function FormationPreBottomComp:_isLineupUniteCall(arg_17_1)
	return self._formationPreStruct:isUniteTokenLineUp(arg_17_1:getAdvanceId())
end

function FormationPreBottomComp:_clickLineupUnite(arg_18_1)
	if self._clickPos > 0 then
		self._formationPreStruct:lineupUniteToken(self._clickPos, arg_18_1:getAdvanceId())

		if self._formationPreStruct:isUniteTokenLineUp(arg_18_1:getAdvanceId()) then
			var_0_12:tip(g.core.lang:get(200038))
		else
			var_0_12:tip(g.core.lang:get(200008))
		end
	end

	self._clickPos = 0

	self:updateUniteView()

	return true
end

function FormationPreBottomComp:_callAddPetPop(arg_19_1, arg_19_2)
	self._clickPos = arg_19_1

	var_0_12:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpPetPop").new({
		isFilter = true,
		itemUrl = "ui://formation/FormationPreLineupPetCell",
		allList = var_0_8:getOwnPetArr(),
		isLineUpCall = handler(self, self._isLineupPetCall),
		clickCheckFunc = handler(self, self._clickLineupPet),
		filterStr = g.core.lang:get(200039),
		cellParam = {
			formationStruct = self._formationPreStruct
		}
	}), {
		touchDisappear = false,
		blackOpacity = 0.5,
		ignoreTouch = false
	})
end

function FormationPreBottomComp:_isLineupPetCall(arg_20_1)
	return self._formationPreStruct:isPetLineUp(arg_20_1:getSid())
end

function FormationPreBottomComp:_clickLineupPet(arg_21_1)
	if self._clickPos > 0 then
		self._formationPreStruct:lineupPet(self._clickPos, arg_21_1:getSid())

		if self._formationPreStruct:isPetLineUp(arg_21_1:getSid()) then
			var_0_12:tip(g.core.lang:get(200038))
		else
			var_0_12:tip(g.core.lang:get(200008))
		end
	end

	self._clickPos = 0

	self:updatePetView()

	return true
end

function FormationPreBottomComp:_callAddSuccubaPop(arg_22_1)
	self._clickPos = arg_22_1

	var_0_12:pushPopup(require("app.view.base.infoPop.lineup.CommonLineUpSuccubaPop").new({
		itemUrl = "ui://infoPop/CommonLineUpSuccubaCell",
		isFilter = true,
		allList = var_0_10:getSuccubaList(),
		isLineUpCall = handler(self, self._isLineupSuccubaCall),
		clickCheckFunc = handler(self, self._clickLineupSuccuba),
		filterStr = g.core.lang:get(200040),
		cellParam = {
			formationStruct = self._formationPreStruct
		}
	}), {
		touchDisappear = false,
		blackOpacity = 0.5,
		ignoreTouch = false
	})
end

function FormationPreBottomComp:_isLineupSuccubaCall(arg_23_1)
	return self._formationPreStruct:isSuccubaLineUp(arg_23_1:getSid())
end

function FormationPreBottomComp:_clickLineupSuccuba(arg_24_1)
	if self._clickPos > 0 then
		self._formationPreStruct:lineupSuccuba(self._clickPos, arg_24_1:getSid())

		if self._formationPreStruct:isSuccubaLineUp(arg_24_1:getSid()) then
			var_0_12:tip(g.core.lang:get(200038))
		else
			var_0_12:tip(g.core.lang:get(200008))
		end
	end

	self._clickPos = 0

	self:updateSuccubaView()

	return true
end

function FormationPreBottomComp:_onTouchBegin(arg_25_1)
	arg_25_1:captureTouch()
end

function FormationPreBottomComp:_onTouchEnd(arg_26_1)
	local var_26_0 = arg_26_1 and arg_26_1:getInput():getTouch()

	if var_26_0 and self._startPos > 0 then
		local var_26_1 = var_26_0:getLocation()
		local var_26_2 = self.m_showTabController:getSelectedIndex()

		if var_26_2 == var_0_6.TAB_INDEX.UNITE then
			if self["m_uniteBtn" .. self._startPos] and not self["m_uniteBtn" .. self._startPos]:containPoint(var_26_1) then
				self._formationPreStruct:lineupUniteToken(self._startPos, 0)
				var_0_12:tip(g.core.lang:get(200008))
				self:updateUniteView()
			end
		elseif var_26_2 == var_0_6.TAB_INDEX.PET and (not self["m_petComp" .. self._startPos] or self["m_petComp" .. self._startPos]:containPoint(var_26_1) or true) then
			-- block empty
		elseif var_26_2 == var_0_6.TAB_INDEX.SUCCUBA and self["m_succubaComp" .. self._startPos] and not self["m_succubaComp" .. self._startPos]:containPoint(var_26_1) then
			self._formationPreStruct:lineupSuccuba(self._startPos, 0)
			var_0_12:tip(g.core.lang:get(200008))
			self:updateSuccubaView()
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

function FormationPreBottomComp:_dragLineupSkill(arg_27_1)
	arg_27_1:preventDefault()

	local var_27_0 = arg_27_1:getSender()
	local var_27_1 = var_27_0:getSkillPos()
	local var_27_2 = self._formationPreStruct:getUniteTokenSid(var_27_1)

	if var_27_2 and var_27_2 > 0 then
		self._startPos = var_27_1

		fgui.DragDropManager:getInstance():startDrag(var_27_0.m_skillIcon:getIcon(), var_27_2, (arg_27_1:getInput():getTouchId()))

		self._dragUniteComp = var_27_0

		self._dragUniteComp:onDragStart()
	end
end

function FormationPreBottomComp:_dropLineupSkill(arg_28_1)
	local var_28_0 = arg_28_1:getSender():getSkillPos()

	if var_28_0 <= var_0_3.FORMAT_UNITE_NUM_MAX and var_28_0 ~= self._startPos then
		self._formationPreStruct:lineupUniteToken(var_28_0, self._formationPreStruct:getUniteTokenSid(self._startPos))
		var_0_12:tip(g.core.lang:get(200006))

		self._startPos = 0
	end

	self:updateUniteView()
end

function FormationPreBottomComp:_dragLineupPet(arg_29_1)
	arg_29_1:preventDefault()

	local var_29_0 = arg_29_1:getSender()
	local var_29_1 = var_29_0:getPetPos()
	local var_29_2 = self._formationPreStruct:getPetSid(var_29_1)

	if var_29_2 and var_29_2 > 0 then
		self._startPos = var_29_1

		fgui.DragDropManager:getInstance():startDrag("ui://formation/FormationPrePetIcon", var_29_2, (arg_29_1:getInput():getTouchId()))

		local var_29_3 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_29_3 then
			fgui.UIPackage.iterObject(var_29_3)
			fgui.UIPackage.bindUIComponent(var_29_3, "app.view.module.formation.pre.comp.FormationPrePetIcon", var_29_3:getParent())
			var_29_3:updatePetFormatIcon(var_0_8:getPetBySid(var_29_2))
		end

		self._dragPetComp = var_29_0

		self._dragPetComp:onDragStart()
	end
end

function FormationPreBottomComp:_dropLineupPet(arg_30_1)
	local var_30_0 = arg_30_1:getSender():getPetPos()

	if var_30_0 <= var_0_4.LINEUP_MAX and var_30_0 ~= self._startPos then
		self._formationPreStruct:lineupPet(var_30_0, self._formationPreStruct:getPetSid(self._startPos))
		var_0_12:tip(g.core.lang:get(200006))

		self._startPos = 0
	end

	self:updatePetView()
end

function FormationPreBottomComp:_dragLineupSuccuba(arg_31_1)
	arg_31_1:preventDefault()

	local var_31_0 = arg_31_1:getSender()
	local var_31_1 = var_31_0:getSuccubaPos()
	local var_31_2 = self._formationPreStruct:getSuccubaSid(var_31_1)

	if var_31_2 ~= 0 then
		local var_31_3 = var_0_10:getSuccubaBySid(var_31_2)

		self._startPos = var_31_1

		fgui.DragDropManager:getInstance():startDrag("ui://formation/FormationSuccubaIconComp", var_31_3:getSid(), (arg_31_1:getInput():getTouchId()))

		local var_31_4 = fgui.DragDropManager:getInstance():getAgent():getComponent()

		if var_31_4 then
			fgui.UIPackage.iterObject(var_31_4)
			fgui.UIPackage.bindUIComponent(var_31_4, "app.view.module.formation.pre.comp.FormationSuccubaIconComp", var_31_4:getParent())
			var_31_4:updateSuccubaIcon(var_31_3)
		end

		self._dragSuccubaComp = var_31_0

		self._dragSuccubaComp:onDragStart()
	end
end

function FormationPreBottomComp:_dropLineupSuccuba(arg_32_1)
	local var_32_0 = arg_32_1:getSender():getSuccubaPos()

	if var_32_0 <= var_0_5.FORMAT_SUCCUBA_NUM_MAX and var_32_0 ~= self._startPos then
		self._formationPreStruct:lineupSuccuba(var_32_0, self._formationPreStruct:getSuccubaSid(self._startPos))
		var_0_12:tip(g.core.lang:get(200006))

		self._startPos = 0
	end

	self:updateSuccubaView()
end

function FormationPreBottomComp:updateComp(arg_33_1)
	self._formationPreStruct = arg_33_1

	self:updateUniteView()
	self:updatePetView()
	self:updateSuccubaView()
	self:updatePartnerView()

	if self._hideSuccuba then
		self.m_tabBtn4:setVisible(false)
	end
end

function FormationPreBottomComp:updatePartnerView()
	self.m_knightList:setNumItems(var_0_1.SHOW_PARTNER_NUM)
end

function FormationPreBottomComp:updateUniteView()
	for iter_35_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_35_0]:updateTokenFormatIcon(var_0_9:getTokenByAdvId((self._formationPreStruct:getUniteTokenSid(iter_35_0))), true)
	end
end

function FormationPreBottomComp:updatePetView()
	for iter_36_0 = 1, var_0_4.LINEUP_MAX do
		self["m_petComp" .. iter_36_0]:updatePetFormatIcon(var_0_8:getPetBySid((self._formationPreStruct:getPetSid(iter_36_0))))
	end
end

function FormationPreBottomComp:updateSuccubaView()
	for iter_37_0 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_37_0]:updateSuccubaIcon(var_0_10:getSuccubaBySid((self._formationPreStruct:getSuccubaSid(iter_37_0))), true)
	end
end

function FormationPreBottomComp:setIsShare(arg_38_1)
	if arg_38_1 then
		self.m_isShareController:setSelectedIndex(1)

		local var_38_0 = {}

		for iter_38_0 = 1, var_0_1.SHOW_PARTNER_NUM do
			table.insert(var_38_0, {
				pos = iter_38_0,
				sid = self._formationPreStruct:getPartnerSid(iter_38_0)
			})
		end

		self.m_shareComp:updateShareComp(var_38_0, self.m_knightList:getScrollPane():getPosX())
	else
		self.m_isShareController:setSelectedIndex(0)
	end
end

function FormationPreBottomComp:updateOther(arg_39_1)
	self._isOtherUser = true
	self._formationPreStruct = arg_39_1

	for iter_39_0 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		self["m_uniteBtn" .. iter_39_0]:setDraggable(false)
		self["m_uniteBtn" .. iter_39_0]:updateTokenFormatIcon(arg_39_1:getOtherUniteStruct(iter_39_0))
		self["m_uniteBtn" .. iter_39_0]:setIsOtherStyle()
	end

	for iter_39_1 = 1, var_0_4.LINEUP_MAX do
		self["m_petComp" .. iter_39_1]:updatePetFormatIcon(arg_39_1:getOtherPetStruct(iter_39_1))
		self["m_petComp" .. iter_39_1]:setIsOtherStyle(true)
		self["m_petComp" .. iter_39_1]:setVisible(true)
		self["m_petComp" .. iter_39_1]:setIsLock(false)
	end

	for iter_39_2 = 1, var_0_5.FORMAT_SUCCUBA_NUM_MAX do
		self["m_succubaComp" .. iter_39_2]:updateSuccubaIcon(arg_39_1:getOtherSuccubaStruct(iter_39_2))
		self["m_succubaComp" .. iter_39_2]:setIsOtherStyle(true)
		self["m_succubaComp" .. iter_39_2]:setVisible(true)
		self["m_succubaComp" .. iter_39_2]:setIsLock(false)
		self["m_succubaComp" .. iter_39_2]:setDraggable(false)
	end

	self.m_knightList:setNumItems(var_0_1.SHOW_PARTNER_NUM)
	self.m_oneKeyBtn:setVisible(false)

	local function var_39_0(arg_40_0)
		self["m_tabBtn" .. arg_40_0 + 1]:setVisible(true)
	end

	var_39_0(var_0_6.TAB_INDEX.UNITE)
	var_39_0(var_0_6.TAB_INDEX.PET)
	var_39_0(var_0_6.TAB_INDEX.SUCCUBA)
	var_39_0(var_0_6.TAB_INDEX.HELPER)
	self:setVisible(true)
end

function FormationPreBottomComp:setSuccubaHide(arg_41_1)
	self._hideSuccuba = arg_41_1
end

return FormationPreBottomComp
