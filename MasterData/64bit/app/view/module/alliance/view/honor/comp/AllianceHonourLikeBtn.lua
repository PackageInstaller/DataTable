local AllianceHonourLikeBtn = class("AllianceHonourLikeBtn", require("app.fairyGUI.alliance.UI_AllianceHonourLikeBtn"))

function AllianceHonourLikeBtn:ctor()
	self._loopEffect = nil
	self._awards = nil
	self._curCount = 0
	self._maxCount = 0
	self._honourTypeData = nil

	self:addClickListener(handler(self, self._onClickLike))
end

function AllianceHonourLikeBtn:_onClickLike()
	if self._curCount < self._maxCount then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_HonourSendLike({
			target_uid = self._honourTypeData.honourData.uid,
			tp = self._honourTypeData.tp
		})
	end

	self:dispatchCompEvent("click_like_btn")
end

function AllianceHonourLikeBtn:updateComp(arg_3_1, arg_3_2)
	self._honourTypeData = arg_3_1

	self:setMax(arg_3_2.like_num)

	self._maxCount = arg_3_2.like_num
	self._curCount = arg_3_1.honourData.self_like

	self:setValue(self._curCount)

	if self._curCount > 0 then
		self.m_likeStateController:setSelectedIndex(1)
	else
		self.m_likeStateController:setSelectedIndex(0)
	end

	self.m_likeNum:setText(arg_3_1.honourData.num)
	self:setTouchable(self._curCount < self._maxCount)

	if self._curCount >= self._maxCount then
		if self._loopEffect then
			self._loopEffect:setVisible(false)
		end
	else
		self._loopEffect = self._loopEffect or self.m_effectNode:addEffectSpine({
			anim = "loop",
			name = "eff_ui_alliance_like",
			isLoop = true,
			remove = false
		})

		self._loopEffect:setVisible(true)
		self.m_loopTransition:play()
	end
end

function AllianceHonourLikeBtn:playEffect(arg_4_1, arg_4_2)
	local var_4_0 = self._curCount + 1

	self.m_effectNode:addEffectSpine({
		name = "eff_ui_alliance_like",
		remove = true,
		isLoop = false,
		anim = arg_4_1,
		eventHandler = function()
			self:checkLikeMax(var_4_0)
		end
	})
end

function AllianceHonourLikeBtn:playBubbleEffect()
	self.m_eff:addEffectSpine({
		name = "eff_ui_alliance_barrage",
		anim = "play",
		remove = true,
		isLoop = false,
		eventHandler = function()
			self:dispatchCompEvent("need_add_bubble")
		end
	})
end

function AllianceHonourLikeBtn:clearBubbleEff()
	self.m_eff:removeAllEffect()
end

function AllianceHonourLikeBtn:checkLikeMax(arg_9_1)
	if (arg_9_1 or self._curCount) >= self._maxCount then
		self:dispatchCompEvent("show_honour_next")
	end
end

return AllianceHonourLikeBtn
