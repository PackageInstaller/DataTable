local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.common.Path
local ActivityWishpoolRewardComp = class("ActivityWishpoolRewardComp", require("app.fairyGUI.activity.UI_ActivityWishpoolRewardComp"))

function ActivityWishpoolRewardComp:ctor()
	self._good = nil
	self._isItem = false
	self._isFragment = false
end

function ActivityWishpoolRewardComp:updateRewardComp(arg_2_1)
	self._good = arg_2_1

	local var_2_0 = arg_2_1.quality or 1

	self.m_bgItemLoader:setURL("pic/base_new/quality/pic_zm_shilian_tongyong_" .. var_2_0 + 1)
	self.m_bgItemFrag:setURL("pic/base_new/quality/pic_zm_suipian_tongyong_" .. var_2_0 + 1)
	self.m_bgLoader:setURL("pic/base_new/quality/pic_zm_pinzhiwp_" .. var_2_0 + 1)
	self.m_nameTxt:setText(arg_2_1.name)
	self.m_hasLinkController:setSelectedIndex(0)

	if arg_2_1.type == var_0_0.TYPE_KNIGHT then
		self.m_itemIcon:setIcon(var_0_2:getKnightPicRes(arg_2_1.info.res_id))
		self.m_itemIcon:getController("showType"):setSelectedIndex(0)
	elseif arg_2_1.type == var_0_0.TYPE_UNITETOKEN then
		self.m_itemIcon:setIcon(var_0_2:getUniteTokenSkillMidPicById(arg_2_1.info.res_id))
		self.m_itemIcon:getController("showType"):setSelectedIndex(2)
	elseif arg_2_1.type == var_0_0.TYPE_ARTIFACT then
		self.m_itemIcon:setIcon(var_0_2:getArtifactRebornImg(arg_2_1.info.res_id))
		self.m_itemIcon:getController("showType"):setSelectedIndex(1)
		self.m_hasLinkController:setSelectedIndex(1)
		self.m_linkComp:updateItemByInfo(arg_2_1)
	elseif arg_2_1.type == var_0_0.TYPE_PET then
		self.m_itemIcon:setIcon(var_0_2:getPetPictorialBook(arg_2_1.info.resource))
		self.m_itemIcon:getController("showType"):setSelectedIndex(4)
		self.m_hasLinkController:setSelectedIndex(1)
		self.m_linkComp:updateItemByInfo(arg_2_1)
	elseif arg_2_1.type == var_0_0.TYPE_FRAGMENT then
		self._isFragment = true

		self.m_itemIcon:setIcon(arg_2_1.icon)
		self.m_itemIcon:getController("showType"):setSelectedIndex(3)
	else
		self.m_itemIcon:setIcon(arg_2_1.icon)
		self.m_itemIcon:getController("showType"):setSelectedIndex(3)

		self._isItem = true
	end

	if self._isItem then
		self.m_sizeText:setText("x" .. arg_2_1.size)
		self.m_showTypeController:setSelectedIndex(0)
	elseif self._isFragment then
		self:updateRewardCompFragment()
		self.m_showTypeController:setSelectedIndex(1)
	else
		self.m_isNewController:setSelectedIndex(arg_2_1.isNew and 1 or 0)
		self.m_showTypeController:setSelectedIndex(self._isFragment and 1 or 2)
	end
end

function ActivityWishpoolRewardComp:addItemEffect()
	if self._good.quality >= var_0_1.SR then
		self.m_effDown:addEffectSpine({
			anim = "play",
			isLoop = true,
			name = "eff_ui_recruitUniteToken_frag_" .. self._good.quality + 1
		})
	end
end

function ActivityWishpoolRewardComp:addCompleteEffect()
	local var_4_0 = "play_" .. tostring(self._good.quality + 1)

	self.m_effUp:addEffectSpine({
		name = "eff_ui_dailyRecruitReward_enterIntact",
		remove = true,
		isLoop = false,
		anim = var_4_0
	})

	if self._good.isNew then
		self.m_effDownIdle:addEffectSpine({
			name = "eff_ui_dailyRecruitReward_idleIntact",
			isLoop = true,
			anim = var_4_0
		})
	end
end

function ActivityWishpoolRewardComp:addFragmentEffect()
	local var_5_0 = "play_" .. tostring(self._good.quality + 1)

	self.m_effUp:addEffectSpine({
		name = "eff_ui_dailyRecruitReward_enterFrag",
		remove = true,
		isLoop = false,
		anim = var_5_0
	})
	self.m_effIdle:addEffectSpine({
		name = "eff_ui_dailyRecruitReward_idleFrag",
		isLoop = true,
		anim = var_5_0
	})
end

function ActivityWishpoolRewardComp:playEnterTran()
	if self._isItem then
		self:addItemEffect()
	elseif self._isFragment then
		self:addFragmentEffect()
	else
		self:onEnter2TranEnd()
		self:addCompleteEffect()
	end
end

function ActivityWishpoolRewardComp:onEnter2TranEnd()
	if not self._good.isNew then
		self:updateRewardCompFragment()
		self.m_showTypeController:setSelectedIndex(1)
		self.m_switchTransition:play()
		self.m_switchTransition:setHook("eff", handler(self, self.onSwitchTranHook))
		self.m_effUp:addEffectSpine({
			name = "eff_ui_dailyRecruitReward_switch",
			remove = true,
			isLoop = false,
			anim = "play_" .. tostring(self._good.quality + 1)
		})
	end
end

function ActivityWishpoolRewardComp:onSwitchTranHook()
	local var_8_0 = "play_" .. tostring(self._good.quality + 1)

	self.m_effUp:addEffectSpine({
		name = "eff_ui_dailyRecruitReward_enterFrag",
		remove = true,
		isLoop = false,
		anim = var_8_0
	})
	self.m_effIdle:addEffectSpine({
		name = "eff_ui_dailyRecruitReward_idleFrag",
		isLoop = true,
		anim = var_8_0
	})
end

function ActivityWishpoolRewardComp:updateRewardCompFragment()
	local var_9_0 = self._good.size

	if self._good.type == var_0_0.TYPE_KNIGHT then
		var_9_0 = var_9_0 * self._good.info.return_fragment_num

		self.m_miniIcon:setURL(var_0_2:getKnightFragmentIconById(self._good.info.res_id))
	elseif self._good.type == var_0_0.TYPE_UNITETOKEN then
		var_9_0 = var_9_0 * self._good.info.return_fragment_num

		self.m_miniIcon:setURL(self._good.icon)
	elseif self._good.type == var_0_0.TYPE_ARTIFACT then
		var_9_0 = var_9_0 * self._good.info.return_fragment_num

		self.m_miniIcon:setURL(self._good.icon)
	elseif self._good.type == var_0_0.TYPE_PET then
		var_9_0 = var_9_0 * self._good.info.return_fragment_num

		self.m_miniIcon:setURL(var_0_2:getPetFragment(self._good.info.resource))
	elseif self._good.type == var_0_0.TYPE_FRAGMENT then
		self.m_miniIcon:setURL(var_0_2:getIconByTypeValue(self._good.type, self._good.value, true))
	end

	self.m_sizeText:setText("x" .. var_9_0)
end

return ActivityWishpoolRewardComp
