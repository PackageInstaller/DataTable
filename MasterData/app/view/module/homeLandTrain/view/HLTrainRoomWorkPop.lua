local var_0_0 = g.core.config.homeland_train_product_info
local var_0_1 = {
	CHOOSE_PRODUCT = 1,
	CHOOSE_KNIGHT = 2,
	NORMAL = 0
}
local var_0_2 = {
	YES = 1,
	NO = 0
}
local var_0_3 = 0.1
local var_0_4 = 1
local var_0_5 = g.core.common.Scheduler
local var_0_6 = g.core.model.User.hlTrainData
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.event.enum
local var_0_9 = g.core.model.User
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local HLTrainRoomWorkPop = class("HLTrainRoomWorkPop", require("app.fairyGUI.homeLandTrain.UI_HLTrainRoomWorkPop"), function()
	return fgui.GComponent:create({
		resName = "HLTrainRoomWorkPop",
		pkgPath = "ui/homeLandTrain/homeLandTrain",
		pkgName = "homeLandTrain"
	})
end)

function HLTrainRoomWorkPop:ctor(arg_2_1)
	self._timerCloseSelf = nil

	local var_2_0 = var_0_6:getRoomStruct(arg_2_1)

	self._limitDispatch = var_2_0.refCfgInfo.limit_dispatch
	self._roomStruct = var_2_0
	self.m_choseKnightCompArr = {
		self.m_choseKnightComp_1,
		self.m_choseKnightComp_2,
		self.m_choseKnightComp_3
	}

	self:_initView()
end

function HLTrainRoomWorkPop:_initView()
	self.m_nameTxt:setText(self._roomStruct.refCfgBaseInfo.task_name)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self.m_closePanel:addClickListener(handler(self, self._onClickBlankArea))
	self.m_bgLoader:addClickListener(handler(self, self._onClickBlankArea))
	self.m_productIconComp:addClickListener(handler(self, self._onClickProductIcon))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))

	for iter_3_0, iter_3_1 in ipairs(self.m_choseKnightCompArr) do
		iter_3_1:setIndex(iter_3_0)
		iter_3_1:addClickListener(handler(self, self._onClickChoseKnight))
	end
end

function HLTrainRoomWorkPop:onLoad()
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._onS2CHLTrainGetInfo, self)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCHAWARD, self._onS2CDispatchAward, self)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_HOME_LAND_TRAIN_PRODUCT, self._onS2CSetProductSuccess, self)
	var_0_7:addEventListener(var_0_8.EVENT_NET_S2C_HOME_LAND_TRAIN_DISPATCH, self._onS2CDispatchSuccess, self)
	self:_updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self:getSharedTrans("enter", "CommonRightPanelAnim", self.m_baseGroup):play(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end)
end

function HLTrainRoomWorkPop:onUnload()
	if self._timerCloseSelf then
		var_0_5:cancelSchedule(self._timerCloseSelf)

		self._timerCloseSelf = nil
	end
end

function HLTrainRoomWorkPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "event_confirm_selected_product" then
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Product({
			product = {
				adv_id = self._roomStruct.advanceId,
				product = self.m_selectProductComp:getSelectedProductId(arg_7_2.indexLua)
			}
		})
		self.m_stateController:setSelectedIndex(var_0_1.NORMAL)
	elseif arg_7_1 == "event_change_chose_knight" then
		self:_updateChoseKnights((self.m_selectKnightComp:getChoseKnightIdArr()))
	elseif arg_7_1 == "event_click_dispatch_btn" then
		self:_onClickDispatchBtn()
	elseif arg_7_1 == "event_click_clear_chose_btn" then
		self:_updateChoseKnights((self.m_selectKnightComp:getChoseKnightIdArr()))
	end
end

function HLTrainRoomWorkPop:_onS2CSetProductSuccess(arg_8_1, arg_8_2)
	self:_updateProductionForecast()
	self:_updateTimeRemaining()
	self:_updateMobility()
	self:_updateProductProgress()
	self.m_productIconComp:updateIcon(self._roomStruct.productId)

	if self.m_workingController:getSelectedIndex() == var_0_2.NO then
		self.m_workingController:setSelectedIndex(var_0_2.YES)
	end
end

function HLTrainRoomWorkPop:_onS2CDispatchSuccess(arg_9_1, arg_9_2)
	self:_updateProductionForecast()
	self:_updateTimeRemaining()
	self:_updateChoseKnights(self._roomStruct.knightIdArr)

	if self._timerCloseSelf then
		var_0_5:cancelSchedule(self._timerCloseSelf)
	end

	self._timerCloseSelf = var_0_5:newScheduleOnce(handler(self, self._closeSelf), var_0_4)
end

function HLTrainRoomWorkPop:_onS2CHLTrainGetInfo()
	self:_updateProductProgress()
	self:_updateTimeRemaining()
	self:_updateChoseKnights((self.m_selectKnightComp:getChoseKnightIdArr()))

	if self.m_stateController:getSelectedIndex() == var_0_1.CHOOSE_KNIGHT then
		self.m_selectKnightComp:updateKnightsMobility()
	end
end

function HLTrainRoomWorkPop:_onS2CDispatchAward(arg_11_1, arg_11_2, arg_11_3)
	self:_updateProductProgress()
	g.core.module.ModuleManager:awardSummary(arg_11_3.awards, true)
end

function HLTrainRoomWorkPop:_onClickBlankArea()
	local var_12_0 = self.m_stateController:getSelectedIndex()

	if var_12_0 == var_0_1.NORMAL then
		self:_closeSelf()
	elseif var_12_0 == var_0_1.CHOOSE_KNIGHT then
		self:_onClickDispatchBtn()
	else
		self.m_stateController:setSelectedIndex(var_0_1.NORMAL)
	end
end

function HLTrainRoomWorkPop:_onClickProductIcon()
	local var_13_0 = self.m_stateController:getSelectedIndex()

	if var_13_0 == var_0_1.CHOOSE_PRODUCT then
		return
	elseif var_13_0 == var_0_1.CHOOSE_KNIGHT and self:_onClickDispatchBtn() then
		return
	end

	self.m_stateController:setSelectedIndex(var_0_1.CHOOSE_PRODUCT)
	self.m_selectProductComp:initComp(self._roomStruct)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	var_0_5:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, var_0_3)
end

function HLTrainRoomWorkPop:_onClickChoseKnight(arg_15_1)
	local var_15_0 = arg_15_1:getSender()
	local var_15_1 = var_15_0:getIndex()

	if self:_isDispatchPlaceLocked(var_15_1) then
		g.core.module.ModuleManager:tip((g.core.lang:get(111036, {
			name = self._roomStruct.refCfgBaseInfo.name,
			level = self._roomStruct:getDispatchPlaceUnlockLv(var_15_1)
		})))
	elseif self.m_stateController:getSelectedIndex() == var_0_1.CHOOSE_KNIGHT then
		if not var_15_0:isEmpty() then
			self.m_selectKnightComp:uncheckKnight((var_15_0:getKnightId()))
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		var_0_5:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, var_0_3)
		self.m_selectKnightComp:initComp(self._roomStruct)
		self.m_stateController:setSelectedIndex(var_0_1.CHOOSE_KNIGHT)
	end
end

function HLTrainRoomWorkPop:_onClickGetAwardBtn()
	if self._roomStruct.productNum == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111037))
	else
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_DispatchAward({
			adv_id = {
				self._roomStruct.advanceId
			}
		})
	end
end

function HLTrainRoomWorkPop:_onClickDispatchBtn()
	if self._roomStruct.productId == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111038))

		return false
	elseif var_0_6:isChangeDispatchKnights(self._roomStruct.advanceId, (self.m_selectKnightComp:getChoseKnightIdArr())) then
		self:setTouchable(false)

		local var_18_0 = self:_getDispatchSendDataList()

		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_Dispatch({
			dispatch = var_18_0
		})
		self.m_stateController:setSelectedIndex(var_0_1.NORMAL)
		self:_playWorkSound(var_18_0)

		return true
	else
		self.m_stateController:setSelectedIndex(var_0_1.NORMAL)

		return false
	end
end

function HLTrainRoomWorkPop:_closeSelf()
	if self._timerCloseSelf then
		var_0_5:cancelSchedule(self._timerCloseSelf)

		self._timerCloseSelf = nil
	end

	self:setTouchable(false)

	local var_19_0 = self:getSharedTrans("back", "CommonRightPanelAnim", self.m_baseGroup)

	if var_19_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		var_19_0:play(function()
			g.core.module.ModuleManager:popModule()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end)
	else
		g.core.module.ModuleManager:popModule()
	end
end

function HLTrainRoomWorkPop:_playWorkSound(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1.knight_ids then
			for iter_21_2, iter_21_3 in pairs(iter_21_1.knight_ids) do
				table.insert(var_21_0, iter_21_3)
			end
		end
	end

	if #var_21_0 > 0 then
		local var_21_1 = var_21_0[1]
		local var_21_2

		if #var_21_0 > 1 then
			var_21_1 = var_21_0[math.random(1, #var_21_0)]
			var_21_2 = {
				voiceType = "work_sound"
			}
		end

		var_21_2.knight = var_0_9.knightsData:getKnight({
			id = var_21_1
		})

		KnightVoiceCommon.playVoice(var_21_2)
	end
end

function HLTrainRoomWorkPop:_updateProductionForecast()
	local var_22_0 = g.core.lang:get(111033)

	self.m_yieldTxt:setText(string.format(var_22_0, (var_0_6:getBaseProductionPerHour(self._roomStruct.productId))))
	self.m_yieldAddTxt:setText(string.format(var_22_0, (var_0_6:getAddProductionPerHour(self._roomStruct.productId, self._roomStruct.knightIdArr))))
end

function HLTrainRoomWorkPop:_updateTimeRemaining()
	if self._roomStruct.productId > 0 then
		local var_23_0 = var_0_6:getTimeRemaining(self._roomStruct.productId, self._roomStruct.productNum, self._roomStruct.knightIdArr)

		if self._roomStruct:isWorking() then
			self.m_cdLabel:resetCooldownTs(var_23_0)
		else
			self.m_cdLabel:stopScheduleCD()
			self.m_cdLabel:setTitle((g.core.common.ServerTime:secondToHMSString(var_23_0)))
		end
	else
		self.m_cdLabel:resetCooldownTs(0)
	end
end

function HLTrainRoomWorkPop:_updateMobility()
	self.m_actCostTxt:setText((self._roomStruct:getMobilityBaseCostPerHour(self._roomStruct.productId)))

	local var_24_0 = var_0_6:getMobilityCostReductionPerHour()

	if var_24_0 > 0 then
		self.m_actCostLessTxt:setText(g.core.lang:get(111034, {
			num = var_24_0
		}))
	else
		self.m_actCostLessTxt:setText("")
	end
end

function HLTrainRoomWorkPop:_updateProductProgress()
	if self._roomStruct.productId == 0 then
		return
	end

	local var_25_0 = var_0_0.get(self._roomStruct.productId)

	self.m_yieldProcess:setValue(self._roomStruct.progress)
	self.m_yieldProcess:setMax(var_25_0.product_time)
	self.m_yieldProcessTxt:setText(g.core.lang:get(111035, {
		num = self._roomStruct.productNum,
		max = var_25_0.product_storage
	}))
end

function HLTrainRoomWorkPop:_updateView()
	if self._roomStruct.productId > 0 then
		self:_updateProductionForecast()
		self:_updateMobility()
		self.m_workingController:setSelectedIndex(var_0_2.YES)
	else
		self.m_workingController:setSelectedIndex(var_0_2.NO)
	end

	self:_updateTimeRemaining()
	self:_updateProductProgress()
	self.m_productIconComp:updateIcon(self._roomStruct.productId)
	self:_updateChoseKnights(self._roomStruct.knightIdArr)
end

function HLTrainRoomWorkPop:_updateChoseKnights(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(self.m_choseKnightCompArr) do
		iter_27_1:updateComp(self:_isDispatchPlaceLocked(iter_27_0), arg_27_1[iter_27_0])
	end
end

function HLTrainRoomWorkPop:_isDispatchPlaceLocked(arg_28_1)
	return arg_28_1 > self._limitDispatch
end

function HLTrainRoomWorkPop:_getDispatchSendDataList()
	local var_29_0 = {}
	local var_29_1 = var_0_6:getDispatchedKnightIdMap()

	for iter_29_0, iter_29_1 in pairs((self.m_selectKnightComp:getChoseKnightIdArr())) do
		if var_29_1[iter_29_1] and var_29_1[iter_29_1] ~= self._roomStruct.advanceId then
			var_29_0[var_29_1[iter_29_1]] = var_29_0[var_29_1[iter_29_1]] or clone(var_0_6:getRoomStruct(var_29_1[iter_29_1]).knightIdArr)

			table.removebyvalue(var_29_0[var_29_1[iter_29_1]], iter_29_1)
		end
	end

	local var_29_2 = {
		{
			adv_id = self._roomStruct.advanceId,
			knight_ids = self.m_selectKnightComp:getChoseKnightIdArr()
		}
	}

	for iter_29_2, iter_29_3 in pairs(var_29_0) do
		table.insert(var_29_2, {
			adv_id = iter_29_2,
			knight_ids = iter_29_3
		})
	end

	return var_29_2
end

return HLTrainRoomWorkPop
