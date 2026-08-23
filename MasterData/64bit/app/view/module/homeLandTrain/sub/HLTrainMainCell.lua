local var_0_0 = g.core.config.homeland_train_product_info
local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_2 = {
	UNLOCKED = 2,
	CAN_UNLOCK = 1,
	CAN_NOT_UNLOCK = 0,
	CAN_RCV_AWARD = 3
}
local var_0_3 = g.core.model.User.hlTrainData
local HLTrainBuildConfirmPop = require("app.view.module.homeLandTrain.view.HLTrainBuildConfirmPop")
local HLTrainMainCell = class("HLTrainMainCell", require("app.fairyGUI.homeLandTrain.UI_HLTrainMainCell1"))

function HLTrainMainCell:ctor(arg_1_1)
	self._roomStruct = nil

	self:addClickListener(handler(self, self._onClick))
end

function HLTrainMainCell:refreshCell(arg_2_1)
	if HLTrainConst.NEED_BLOCK and HLTrainConst.BLOCK_ADVANCE_ID[arg_2_1] then
		self:setVisible(false)

		return
	end

	local var_2_0 = var_0_3:getRoomStruct(arg_2_1)

	self._roomStruct = var_2_0

	local var_2_1 = self:_getRoomState()

	self.m_openStateController:setSelectedIndex(var_2_1)

	if var_2_1 == var_0_2.CAN_RCV_AWARD then
		local var_2_2 = var_0_0.get(var_2_0.productId)

		self.m_trainProcessComp:updateAward(var_2_2.product_type, var_2_2.product_value, var_2_0.isLuck)
		self.m_trainProcessComp:updateProgress(var_2_0.productNum, var_2_2.product_storage)
	elseif var_2_1 == var_0_2.CAN_UNLOCK then
		self.m_canUnlockComp:setResEnough((var_0_3:isEnoughResToUnlockRoom(arg_2_1)))
	end

	self.m_workStateComp:updateComp(arg_2_1)
	self:onRefreshRoomRole(arg_2_1)
	self:setVisible(true)
end

function HLTrainMainCell:onRefreshRoomRole(arg_3_1)
	if HLTrainConst.NEED_BLOCK and HLTrainConst.BLOCK_ADVANCE_ID[arg_3_1] then
		return
	end

	self.m_stateComp:updateComp(arg_3_1)
end

function HLTrainMainCell:_onClick()
	local var_4_0 = self:_getRoomState()

	if var_4_0 == var_0_2.CAN_UNLOCK then
		g.core.module.ModuleManager:pushPopup((HLTrainBuildConfirmPop.new(self._roomStruct.advanceId)))
	elseif var_4_0 == var_0_2.CAN_NOT_UNLOCK then
		g.core.module.ModuleManager:tip((g.core.lang:get(111049, {
			num = self._roomStruct.refCfgBaseInfo.unlock_value_1,
			level = self._roomStruct.refCfgBaseInfo.unlock_value_2
		})))
	elseif var_4_0 == var_0_2.CAN_RCV_AWARD then
		var_0_3:reqGetRoomAward(self._roomStruct.advanceId)
	else
		self:dispatchCompEvent("UI_OPEN_TRAIN_TOOM", self._roomStruct.advanceId)
	end
end

function HLTrainMainCell:_getRoomState()
	if self._roomStruct:isUnlocked() then
		if self._roomStruct:isExistAward() then
			return var_0_2.CAN_RCV_AWARD
		else
			return var_0_2.UNLOCKED
		end
	elseif var_0_3:isRoomCanUnlock(self._roomStruct.advanceId) then
		return var_0_2.CAN_UNLOCK
	else
		return var_0_2.CAN_NOT_UNLOCK
	end
end

function HLTrainMainCell:checkUpgradeEff()
	if not self._roomStruct then
		return
	end

	if self._roomStruct.curLevel == 1 then
		self.m_unLockEffComp:addEffectSpine({
			anim = "play",
			isLoop = false,
			remove = true,
			name = "eff_ui_homelandtrain_unlock0" .. g.core.config.homeland_train_base_info.get(self._roomStruct.advanceId).sign
		})
	end
end

return HLTrainMainCell
