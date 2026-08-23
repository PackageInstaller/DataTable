local RichmanTurnCardGameLeftCell = class("RichmanTurnCardGameLeftCell", require("app.fairyGUI.richman.UI_RichmanTurnCardGameLeftCell"))

function RichmanTurnCardGameLeftCell:ctor()
	self._rewardArray = nil

	self.m_iconList:setItemRenderer(handler(self, self._onRenderIconList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function RichmanTurnCardGameLeftCell:updateLeftCell(arg_2_1, arg_2_2)
	self._rewardArray = arg_2_1
	self._index = arg_2_2

	self.m_iconList:setNumItems(3)
	self.m_rewardList:setNumItems(#self._rewardArray)
end

function RichmanTurnCardGameLeftCell:_onRenderRewardList(arg_3_1, arg_3_2)
	arg_3_2:updateRewardCell(self._rewardArray[arg_3_1 + 1])
end

function RichmanTurnCardGameLeftCell:_onRenderIconList(arg_4_1, arg_4_2)
	arg_4_2:setCtrlState("type", {
		index = self._index - 1
	})
	arg_4_2:setCtrlState("isActivated", {
		index = 0
	})
end

function RichmanTurnCardGameLeftCell:updateCellStatus(arg_5_1, arg_5_2)
	local var_5_0 = self.m_iconList:itemIndexToChildIndex(arg_5_1)

	if var_5_0 >= 0 and var_5_0 < self.m_iconList:numChildren() then
		local var_5_1 = self.m_iconList:getChildAt(var_5_0)

		var_5_1:setCtrlState("isActivated", {
			index = 1
		})
		var_5_1:getTransition("click"):play()

		if arg_5_2 == 1 then
			-- block empty
		end

		local var_5_4 = var_5_1:getChild("eff")

		var_5_4:removeAllEffect()
		var_5_4:addEffectSpine({
			anim = "play",
			name = "eff_ui_richman_activate",
			remove = true,
			isLoop = false
		})

		if arg_5_2 == 1 then
			self:_playIconAnim(arg_5_1)
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_CardLight)
	end
end

function RichmanTurnCardGameLeftCell:playFinishAnim(arg_6_1, arg_6_2)
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_richman_get",
		isLoop = false,
		remove = true,
		eventHandler = arg_6_2
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Gem_LightUp)
end

function RichmanTurnCardGameLeftCell:_playIconAnim(arg_7_1)
	local var_7_0 = self.m_iconList:getChildAt((self.m_iconList:itemIndexToChildIndex(arg_7_1))):getChild("loop")

	var_7_0:removeAllEffect()
	var_7_0:addEffectSpine({
		anim = "play",
		name = "eff_ui_richman_light",
		scale = 0.8,
		isLoop = true
	})
end

return RichmanTurnCardGameLeftCell
