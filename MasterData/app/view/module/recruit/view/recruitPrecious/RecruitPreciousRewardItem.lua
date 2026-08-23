local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = cc.c3b(242, 242, 242)
local var_0_3 = {
	cc.c3b(50, 151, 255),
	cc.c3b(180, 103, 238),
	(cc.c3b(255, 168, 0))
}
local RecruitPreciousRewardItem = class("RecruitPreciousRewardItem", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousRewardItem"))

function RecruitPreciousRewardItem:ctor()
	self:_addTranslationHook()
end

function RecruitPreciousRewardItem:_addTranslationHook()
	self.m_enterTransition:setHook("play", handler(self, self.playEnterAction))
	self.m_enterTransition:setHook("loop", handler(self, self._onShowLoopAction))
	self.m_enterTransition:setHook("finish", handler(self, self._enterActionPlayEnd))
	self.m_switchTransition:setHook("loop", handler(self, self._turnToFragUIAndPlayFragLoopAction))
end

function RecruitPreciousRewardItem:updateItem(arg_3_1, arg_3_2)
	self._idx = arg_3_2

	local var_3_0
	local var_3_1
	local var_3_2 = 1

	if arg_3_1.type == var_0_0.TYPE_PRECIOUS then
		self._cfg = g.core.config.precious_info.get(arg_3_1.value)
		var_3_0 = g.core.common.Path:getPreciousIconByResId(self._cfg.res_id)
		var_3_2 = arg_3_1.isNew and 1 or self._cfg.return_fragment_num

		self.m_isFragController:setSelectedIndex(0)

		var_3_1 = "ui://base_new/pic_zm_gzp_yuan_chou_" .. math.max(self._cfg.quality, 1) + 1
	end

	self.m_numText:setText("X" .. var_3_2)
	self.m_icon:setURL(var_3_0)
	self.m_bgLoader:setURL(var_3_1)
	self.m_nameTxt:setText(self._cfg.name)

	self._newIndex = arg_3_1.isNew and 1 or 0

	self.m_isNewController:setSelectedIndex(self._newIndex)

	self._data = arg_3_1
end

function RecruitPreciousRewardItem:setActionCallback(arg_4_1)
	self._actionCallBack = arg_4_1
end

function RecruitPreciousRewardItem:_getQualityName(arg_5_1)
	local var_5_0 = "r"

	if arg_5_1 == var_0_1.SR then
		var_5_0 = "sr"
	elseif arg_5_1 == var_0_1.SSR then
		var_5_0 = "ssr"
	end

	return var_5_0
end

function RecruitPreciousRewardItem:playEnterAction()
	if not self._data then
		return
	end

	if self._data.type == var_0_0.TYPE_PRECIOUS then
		self:_playPreciousEnterAction()
	elseif self._data.type == var_0_0.TYPE_FRAGMENT then
		self:_playFragEnterAction()
	end
end

function RecruitPreciousRewardItem:_playPreciousEnterAction()
	self.m_rewardEff:addEffectSpine({
		name = "eff_ui_precious_reward",
		remove = true,
		isLoop = false,
		anim = "play_" .. self._cfg.quality + 1
	})

	self._fragIndex = 0
end

function RecruitPreciousRewardItem:_enterActionPlayEnd()
	if not self._data then
		return
	end

	if self._actionCallBack then
		self._actionCallBack(self._idx)
	end

	if self._data.type == var_0_0.TYPE_PRECIOUS and not self._data.isNew then
		self:_playSwitchAction()
	end
end

function RecruitPreciousRewardItem:_playFragEnterAction()
	self.m_rewardEff:addEffectSpine({
		name = "eff_ui_precious_reward",
		remove = true,
		isLoop = false,
		anim = "play_frag_" .. self._cfg.quality + 1
	})

	self._fragIndex = 1
end

function RecruitPreciousRewardItem:_onShowLoopAction()
	if not self._data then
		return
	end

	if self._data.type == var_0_0.TYPE_PRECIOUS then
		self:_playLoopAction()
	else
		self:_playFragLoopAction()
	end
end

function RecruitPreciousRewardItem:_playLoopAction()
	self.m_rewardEff:addEffectSpine({
		name = "eff_ui_precious_reward",
		remove = false,
		isLoop = true,
		anim = "loop_" .. self._cfg.quality + 1
	})
end

function RecruitPreciousRewardItem:_turnToFragUIAndPlayFragLoopAction()
	local var_12_0 = {
		type = var_0_0.TYPE_FRAGMENT,
		value = self._cfg.fragment_id,
		size = self._cfg.return_fragment_num
	}
	local var_12_1 = var_0_0:convert(var_12_0)

	self.m_isFragController:setSelectedIndex(1)
	self.m_numText:setText("X" .. var_12_0.size)
	self.m_fragLoader:setURL("ui://base_new/pic_zm_gzp_yuan_sui_" .. math.max(var_12_1.quality, 1) + 1)
	self.m_nameTxt:setText(var_12_1.name)
	self:_playFragLoopAction()
end

function RecruitPreciousRewardItem:_playFragLoopAction()
	self.m_rewardEff:addEffectSpine({
		name = "eff_ui_precious_reward",
		remove = false,
		isLoop = true,
		anim = "loop_frag_" .. self._cfg.quality + 1
	})
end

function RecruitPreciousRewardItem:_playSwitchAction()
	self.m_rewardEff:removeAllEffect()
	self.m_switchTransition:play()
	self:_playFragEnterAction()
end

function RecruitPreciousRewardItem:setCtrlIndex(arg_15_1)
	self.m_isNewController:setSelectedIndex(arg_15_1)
	self.m_typeController:setSelectedIndex(self._fragIndex)
end

function RecruitPreciousRewardItem:resetState()
	self.m_isNewController:setSelectedIndex(self._newIndex)
	self.m_typeController:setSelectedIndex(self._fragIndex)
end

return RecruitPreciousRewardItem
