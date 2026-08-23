local KnightSoulRewardLayerItem = class("KnightSoulRewardLayerItem", require("app.fairyGUI.recruitKnightSoul.UI_KnightSoulRewardLayerItem"))

function KnightSoulRewardLayerItem:ctor()
	self._info = nil
	self._cfg = nil
	self._idx = -1
	self._newIndex = 0
	self._fragIndex = 0
end

function KnightSoulRewardLayerItem:playShareTrans(arg_2_1)
	return
end

function KnightSoulRewardLayerItem:updateItem(arg_3_1, arg_3_2)
	self._idx = arg_3_2
	self._info = arg_3_1
	self._cfg = g.core.config.ksoul_info.get(self._info.value)

	self.m_icon:updateCard({
		num = 1,
		kSoulId = self._cfg.id
	})
	self.m_bgLoader:setURL("ui://recruit/pic_zm_mx_pinzhi" .. self._cfg.quality)
	self.m_bgLoader:setVisible(self._cfg.quality > g.core.const.ConstMgr.QUALITY_TYPE.SR)

	self._newIndex = self._info.isNew and 1 or 0

	self.m_isNewController:setSelectedIndex(self._newIndex)
end

function KnightSoulRewardLayerItem:playEnterAction(arg_4_1, arg_4_2)
	self._actionCallBack = arg_4_1

	self.m_enterTransition:play(handler(self, self._enterActionPlayEnd))
	self.m_enterTransition:setTimeScale(arg_4_2 or 1)

	local var_4_0 = ""
	local var_4_1

	if self._cfg.quality == g.core.const.ConstMgr.QUALITY_TYPE.R then
		var_4_0 = "eff_ui_knightSoul_Reward_2"
		var_4_1 = self.m_ssrEffReward
	elseif self._cfg.quality == g.core.const.ConstMgr.QUALITY_TYPE.SR then
		var_4_0 = "eff_ui_knightSoul_Reward_3"
		var_4_1 = self.m_ssrEffReward
	elseif self._cfg.quality == g.core.const.ConstMgr.QUALITY_TYPE.SSR then
		var_4_0 = "eff_ui_knightSoul_Reward_4"
		var_4_1 = self.m_ssrEffReward

		local var_4_2 = {
			isLoop = true,
			anim = "idle"
		}

		var_4_2.name = "eff_ui_knightSoul_Reward_4"

		self.m_ssrIdleEffReward:addEffectSpine(var_4_2)
	elseif self._cfg.quality == g.core.const.ConstMgr.QUALITY_TYPE.UR then
		var_4_0 = "eff_ui_knightSoul_Reward_5"
		var_4_1 = self.m_ssrEffReward

		local var_4_3 = {
			isLoop = true,
			anim = "idle"
		}

		var_4_3.name = "eff_ui_knightSoul_Reward_5"

		self.m_ssrIdleEffReward:addEffectSpine(var_4_3)
	end

	var_4_1:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = var_4_0
	}):setTimeScale(arg_4_2 or 1)
end

function KnightSoulRewardLayerItem:_enterActionPlayEnd()
	if self._actionCallBack then
		self._actionCallBack(self._idx)
	end
end

function KnightSoulRewardLayerItem:setCtrlIndex(arg_6_1, arg_6_2)
	self.m_isNewController:setSelectedIndex(arg_6_1)
	self.m_bgLoader:setOpacity(255)
end

function KnightSoulRewardLayerItem:resetState()
	self.m_isNewController:setSelectedIndex(self._newIndex)
	self.m_bgLoader:setOpacity(self._fragIndex ~= 1 and 255 or 0)
end

return KnightSoulRewardLayerItem
