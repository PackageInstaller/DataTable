local var_0_0 = {
	CHOOSE_PRODUCT = 1,
	CHOOSE_KNIGHT = 2,
	NORMAL = 0
}
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.furnitureData
local var_0_3 = g.core.model.User.hlTrainData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.module.ModuleManager
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local HLTrainOneKeyDispatchPop = class("HLTrainOneKeyDispatchPop", require("app.fairyGUI.homeLandTrain.UI_HLTrainOneKeyDispatchPop"), function()
	return fgui.GComponent:create({
		resName = "HLTrainOneKeyDispatchPop",
		pkgPath = "ui/homeLandTrain/homeLandTrain",
		isFullScreen = true,
		pkgName = "homeLandTrain"
	}, ...)
end)

function HLTrainOneKeyDispatchPop:ctor()
	self._choseRoomIdx = 0
	self._isOneKeyDispatch = false
	self._advIdArr = self:_getAllAdvIds()

	self.m_closePanel:addClickListener(handler(self, self._onClickBlankArea))
	self.m_bgLoader:addClickListener(handler(self, self._onClickBlankArea))
	self.m_roomList:setVirtual(self)
	self.m_roomList:setItemRenderer(handler(self, self._onRoomItemRenderer))

	local var_2_0 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HL_TRAIN_ONE_KEY_RELEASE, nil, true)

	self.m_releaseBtn:setVisible(var_2_0)
	self.m_releaseStatusController:setSelectedIndex(var_2_0 and 1 or 0)
	self.m_openOneKeyController:setSelectedIndex(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HL_TRAIN_ONEKEY_WORK) and 1 or 0)
	self.m_releaseBtn:addClickListener(handler(self, self._onClickReleaseBtn))
	self.m_releaseBtn1:addClickListener(handler(self, self._onClickReleaseBtn))
	self.m_oneKeyWorkBtn:addClickListener(handler(self, self._onClickOneKeyWorkBtn))
end

function HLTrainOneKeyDispatchPop:onLoad()
	var_0_5:addEventListener(var_0_1.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._onS2CHLTrainGetInfo, self)
	var_0_5:addEventListener(var_0_1.EVENT_NET_S2C_HOME_LAND_TRAIN_PRODUCT, self._onS2CSetProductSuccess, self)
	var_0_5:addEventListener(var_0_1.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH, self._onS2CDispatchSuccess, self)
	self.m_roomList:setNumItems(#self._advIdArr)
	self.m_stateController:setSelectedIndex(var_0_0.NORMAL)
	self:getSharedTrans("enter", "CommonRightPanelAnim", self.m_roomGroup):play()
end

function HLTrainOneKeyDispatchPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "event_confirm_selected_product" then
		self:_onConfirmSetProduct(arg_4_2.indexLua)
	elseif arg_4_1 == "event_change_chose_knight" then
		self:_updateRoomChoseKnights((self.m_selectKnightComp:getChoseKnightIdArr()))
	elseif arg_4_1 == "event_click_product_icon" then
		self:_onClickProductIcon(arg_4_2.indexLua)
	elseif arg_4_1 == "event_click_knight_icon" then
		self:_onClickChoseKnight(arg_4_2.indexLua, arg_4_2.knightId)
	elseif arg_4_1 == "event_click_room_blank_area" then
		self:_onClickRoomBlankArea(arg_4_2.indexLua)
	elseif arg_4_1 == "event_click_dispatch_btn" then
		self:_onClickDispatchBtn()
	elseif arg_4_1 == "event_click_clear_chose_btn" then
		self:_updateRoomChoseKnights((self.m_selectKnightComp:getChoseKnightIdArr()))
	end
end

function HLTrainOneKeyDispatchPop:_onS2CHLTrainGetInfo(arg_5_1, arg_5_2)
	for iter_5_0 = 0, self:_2CppIdx((self.m_roomList:numChildren())) do
		self.m_roomList:getChildAt(iter_5_0):updateKnightsMobility()
	end

	if self.m_stateController:getSelectedIndex() == var_0_0.CHOOSE_KNIGHT then
		self.m_selectKnightComp:updateKnightsMobility()
	end
end

function HLTrainOneKeyDispatchPop:_onS2CSetProductSuccess(arg_6_1, arg_6_2)
	self.m_roomList:setNumItems(#self._advIdArr)
end

function HLTrainOneKeyDispatchPop:_onS2CDispatchSuccess(arg_7_1, arg_7_2)
	self:_initSelectKnightComp()
	self.m_roomList:setNumItems(#self._advIdArr)

	if self._isOneKeyDispatch then
		var_0_6:tip(g.core.lang:get(111025))
	end

	self._isOneKeyDispatch = false
end

function HLTrainOneKeyDispatchPop:_onRoomItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(arg_8_1 + 1, self._advIdArr[arg_8_1 + 1], self._choseRoomIdx == arg_8_1 + 1)
end

function HLTrainOneKeyDispatchPop:_onConfirmSetProduct(arg_9_1)
	local var_9_0 = self:_getCurAdvId()

	if var_9_0 then
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Product({
			product = {
				adv_id = var_9_0,
				product = self.m_selectProductComp:getSelectedProductId(arg_9_1)
			}
		})
	end

	self.m_stateController:setSelectedIndex(var_0_0.NORMAL)
end

function HLTrainOneKeyDispatchPop:_onClickBlankArea()
	local var_10_0 = self.m_stateController:getSelectedIndex()

	if var_10_0 == var_0_0.NORMAL then
		self:_closeSelf()
	elseif var_10_0 == var_0_0.CHOOSE_PRODUCT then
		self:_setChoseRoomIdx(0)
		self.m_stateController:setSelectedIndex(var_0_0.NORMAL)
	elseif var_10_0 == var_0_0.CHOOSE_KNIGHT then
		self:_onClickDispatchBtn()
		self:_setChoseRoomIdx(0)
		self.m_stateController:setSelectedIndex(var_0_0.NORMAL)
	end
end

function HLTrainOneKeyDispatchPop:_onClickProductIcon(arg_11_1)
	local var_11_0 = self.m_stateController:getSelectedIndex()

	if var_11_0 == var_0_0.NORMAL then
		self:_setChoseRoomIdx(arg_11_1)
		self:_initSelectProductComp()
		self.m_stateController:setSelectedIndex(var_0_0.CHOOSE_PRODUCT)
	elseif var_11_0 == var_0_0.CHOOSE_PRODUCT then
		if arg_11_1 == self._choseRoomIdx then
			-- block empty
		else
			self:_setChoseRoomIdx(arg_11_1)
			self:_initSelectProductComp()
		end
	elseif var_11_0 == var_0_0.CHOOSE_KNIGHT then
		self:_onClickDispatchBtn()
		self:_setChoseRoomIdx(arg_11_1)
		self:_initSelectProductComp()
		self.m_stateController:setSelectedIndex(var_0_0.CHOOSE_PRODUCT)
	end
end

function HLTrainOneKeyDispatchPop:_onClickChoseKnight(arg_12_1, arg_12_2)
	if self.m_stateController:getSelectedIndex() == var_0_0.CHOOSE_KNIGHT then
		if arg_12_1 == self._choseRoomIdx then
			if arg_12_2 and arg_12_2 > 0 then
				self.m_selectKnightComp:uncheckKnight(arg_12_2)
			end
		else
			self:_onClickDispatchBtn()
			self:_setChoseRoomIdx(arg_12_1)
			self:_initSelectKnightComp()
			self.m_stateController:setSelectedIndex(var_0_0.CHOOSE_KNIGHT)
		end
	else
		self:_setChoseRoomIdx(arg_12_1)
		self:_initSelectKnightComp()
		self.m_stateController:setSelectedIndex(var_0_0.CHOOSE_KNIGHT)
	end
end

function HLTrainOneKeyDispatchPop:_onClickRoomBlankArea(arg_13_1)
	if var_0_3:getRoomStruct(self._advIdArr[arg_13_1]):isUnlocked() then
		self:_onClickChoseKnight(arg_13_1)
	else
		self:_onClickBlankArea()
	end
end

function HLTrainOneKeyDispatchPop:_onClickDispatchBtn()
	local var_14_0 = self:_getCurAdvId()
	local var_14_1

	if not var_14_0 then
		do return false end

		var_14_1 = self.m_selectKnightComp:getChoseKnightIdArr()
	end

	if var_0_3:getRoomStruct(var_14_0).productId == 0 then
		var_0_6:tip(g.core.lang:get(111038))

		return false
	elseif var_0_3:isChangeDispatchKnights(var_14_0, var_14_1) then
		local var_14_2 = self:_getDispatchSendDataList(var_14_1)

		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
			dispatch = var_14_2
		})
		self.m_stateController:setSelectedIndex(var_0_0.NORMAL)
		self:_playWorkSound(var_14_2)

		return true
	else
		self.m_stateController:setSelectedIndex(var_0_0.NORMAL)

		return false
	end
end

function HLTrainOneKeyDispatchPop:_onClickReleaseBtn()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs((var_0_3:getAllRoomAdvIds())) do
		if var_0_3:isRoomUnlocked(iter_15_1) then
			table.insert(var_15_0, {
				adv_id = iter_15_1,
				knight_ids = {}
			})
		end
	end

	var_0_6:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(111057),
		desc = g.core.lang:get(111058),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
				dispatch = var_15_0
			})
		end
	}), {
		touchDisappear = true
	})
end

function HLTrainOneKeyDispatchPop:_playWorkSound(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		if iter_17_1.knight_ids then
			for iter_17_2, iter_17_3 in pairs(iter_17_1.knight_ids) do
				table.insert(var_17_0, iter_17_3)
			end
		end
	end

	if #var_17_0 > 0 then
		KnightVoiceCommon.playVoice({
			voiceType = "work_sound",
			knight = var_0_4:getKnight({
				id = var_17_0[math.random(1, #var_17_0)]
			})
		})
	end
end

function HLTrainOneKeyDispatchPop:_getDispatchSendDataList(arg_18_1)
	local var_18_0 = self:_getCurAdvId()

	if not var_18_0 then
		return
	end

	local var_18_1 = {}
	local var_18_2 = var_0_3:getDispatchedKnightIdMap()

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if var_18_2[iter_18_1] and var_18_2[iter_18_1] ~= var_18_0 then
			var_18_1[var_18_2[iter_18_1]] = var_18_1[var_18_2[iter_18_1]] or clone(var_0_3:getRoomStruct(var_18_2[iter_18_1]).knightIdArr)

			table.removebyvalue(var_18_1[var_18_2[iter_18_1]], iter_18_1)
		end
	end

	local var_18_3 = {
		{
			adv_id = var_18_0,
			knight_ids = clone(arg_18_1)
		}
	}

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		table.insert(var_18_3, {
			adv_id = iter_18_2,
			knight_ids = iter_18_3
		})
	end

	return var_18_3
end

function HLTrainOneKeyDispatchPop:_getAllAdvIds()
	local var_19_0 = clone((var_0_3:getAllRoomAdvIds()))

	if HLTrainConst.NEED_BLOCK then
		local var_19_1 = {}

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if not HLTrainConst.BLOCK_ADVANCE_ID[iter_19_1] then
				table.insert(var_19_1, iter_19_1)
			end
		end

		var_19_0 = var_19_1
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		local var_20_0 = var_0_3:isRoomUnlocked(arg_20_0)

		if var_20_0 ~= var_0_3:isRoomUnlocked(arg_20_1) then
			return var_20_0
		end

		local var_20_1 = var_0_3:isRoomCanUnlock(arg_20_0)

		if var_20_1 ~= var_0_3:isRoomCanUnlock(arg_20_1) then
			return var_20_1
		end

		return arg_20_1 < arg_20_0
	end)

	return var_19_0
end

function HLTrainOneKeyDispatchPop:_getCurAdvId()
	if self._choseRoomIdx == 0 then
		return
	else
		return self._advIdArr[self._choseRoomIdx]
	end
end

function HLTrainOneKeyDispatchPop:_updateRoomChoseKnights(arg_22_1)
	local var_22_0 = self:_getRoomCell(self._choseRoomIdx)

	if var_22_0 then
		var_22_0:setChoseKnights(arg_22_1)
	end
end

function HLTrainOneKeyDispatchPop:_initSelectProductComp()
	local var_23_0 = self:_getCurAdvId()

	if var_23_0 then
		self.m_selectProductComp:initComp((var_0_3:getRoomStruct(var_23_0)))
	end
end

function HLTrainOneKeyDispatchPop:_initSelectKnightComp()
	local var_24_0 = self:_getCurAdvId()

	if var_24_0 then
		self.m_selectKnightComp:initComp((var_0_3:getRoomStruct(var_24_0)))
	end
end

function HLTrainOneKeyDispatchPop:_setChoseRoomIdx(arg_25_1)
	if self._choseRoomIdx ~= arg_25_1 then
		local var_25_0 = self:_getRoomCell(self._choseRoomIdx)

		if var_25_0 then
			var_25_0:setChose(false)
		end

		local var_25_1 = self:_getRoomCell(arg_25_1)

		if var_25_1 then
			var_25_1:setChose(true)
		end

		self._choseRoomIdx = arg_25_1
	end
end

function HLTrainOneKeyDispatchPop:_getRoomCell(arg_26_1)
	if arg_26_1 > 0 then
		local var_26_0 = self.m_roomList:itemIndexToChildIndex((self:_2CppIdx(arg_26_1)))

		if var_26_0 >= 0 and var_26_0 < self.m_roomList:numChildren() then
			return self.m_roomList:getChildAt(var_26_0)
		end
	end
end

function HLTrainOneKeyDispatchPop:_closeSelf()
	self:setTouchable(false)

	local var_27_0 = self:getSharedTrans("back", "CommonRightPanelAnim", self.m_roomGroup)

	if var_27_0 then
		var_27_0:play(function()
			var_0_6:popModule()
		end)
	else
		var_0_6:popModule()
	end
end

function HLTrainOneKeyDispatchPop:_2LuaIdx(arg_29_1)
	return arg_29_1 + 1
end

function HLTrainOneKeyDispatchPop:_2CppIdx(arg_30_1)
	return arg_30_1 - 1
end

function HLTrainOneKeyDispatchPop:_onClickOneKeyWorkBtn()
	local var_31_0 = {}
	local var_31_1 = var_0_3:getUnlockedRoomStructArr()

	table.sort(var_31_1, function(arg_32_0, arg_32_1)
		return arg_32_0:getBaseInfo().advance_id < arg_32_1:getBaseInfo().advance_id
	end)

	local var_31_2 = false

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		local var_31_3 = #iter_31_1:getKnightArr()
		local var_31_4 = iter_31_1:getDispatchPlaceLimit()

		var_31_0[iter_31_0] = {
			advId = iter_31_1:getBaseInfo().advance_id,
			num = var_31_4 - var_31_3
		}
		var_31_2 = var_31_2 or var_31_4 - var_31_3 > 0
	end

	if not var_31_2 then
		var_0_6:tip(g.core.lang:get(111059))

		return
	end

	local var_31_5 = var_0_4:getSpList(function(arg_33_0)
		local var_33_0 = arg_33_0:getServerId()

		if arg_33_0:isCanBeDispatched() and not var_0_3:isKnightDispatched(var_33_0) then
			if var_0_2:isKnightCheckIn(var_33_0) then
				return arg_33_0:getMobilityVal() >= arg_33_0:getMaxMobility()
			else
				return arg_33_0:getMobilityVal() > 0
			end
		end
	end, nil, true)

	if #var_31_5 == 0 then
		var_0_6:tip(g.core.lang:get(111060))

		return
	end

	table.sort(var_31_5, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:getHomeLandTalent()
		local var_34_1 = arg_34_1:getHomeLandTalent()

		if var_34_0 ~= var_34_1 then
			return var_34_0 < var_34_1
		end

		local var_34_2 = arg_34_0:getMobilityVal()
		local var_34_3 = arg_34_1:getMobilityVal()

		if var_34_2 ~= var_34_3 then
			return var_34_2 < var_34_3
		end

		return arg_34_0:getBaseId() < arg_34_1:getBaseId()
	end)

	local var_31_6 = {}
	local var_31_7 = {}
	local var_31_8 = #var_31_5

	for iter_31_2, iter_31_3 in ipairs(var_31_0) do
		if iter_31_3.num > 0 then
			local var_31_9 = clone(var_0_3:getRoomStruct(iter_31_3.advId):getKnightArr())

			for iter_31_4 = 1, iter_31_3.num do
				local var_31_10 = var_31_5[var_31_8]:getServerId()

				if var_0_2:isKnightCheckIn(var_31_10) then
					table.insert(var_31_7, var_31_10)
				end

				table.insert(var_31_9, var_31_10)

				var_31_8 = var_31_8 - 1

				if var_31_8 <= 0 then
					break
				end
			end

			table.insert(var_31_6, {
				adv_id = iter_31_3.advId,
				knight_ids = var_31_9
			})
		end

		if var_31_8 <= 0 then
			break
		end
	end

	if next(var_31_7) then
		var_0_6:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(111061),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
					dispatch = var_31_6
				})

				self._isOneKeyDispatch = true
			end
		}), {
			touchDisappear = true
		})
	else
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
			dispatch = var_31_6
		})

		self._isOneKeyDispatch = true
	end
end

return HLTrainOneKeyDispatchPop
