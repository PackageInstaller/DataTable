local TeamBattleTurnCardGameLeftCell = class("TeamBattleTurnCardGameLeftCell", require("app.fairyGUI.teamBattle.UI_TeamBattleTurnCardGameLeftCell"))

function TeamBattleTurnCardGameLeftCell:ctor()
	self._rewardArray = nil

	self.m_iconList:setItemRenderer(handler(self, self._onRenderIconList))
end

function TeamBattleTurnCardGameLeftCell:updateLeftCell(arg_2_1, arg_2_2)
	self._rewardArray = arg_2_1
	self._index = arg_2_2

	self:_initRewardList()
	self.m_iconList:setNumItems(3)
end

function TeamBattleTurnCardGameLeftCell:_initRewardList()
	for iter_3_0 = 1, 3 do
		self["m_reward" .. iter_3_0]:updateRewardCell(self._rewardArray[iter_3_0])
	end
end

function TeamBattleTurnCardGameLeftCell:_onRenderIconList(arg_4_1, arg_4_2)
	arg_4_2:setCtrlState("type", {
		index = self._index - 1
	})
	arg_4_2:setCtrlState("isActivated", {
		index = 0
	})
end

function TeamBattleTurnCardGameLeftCell:updateCellStatus(arg_5_1, arg_5_2)
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
			remove = true,
			anim = "play",
			isLoop = false,
			name = "eff_ui_teamBattle_activate"
		})

		if arg_5_2 == 1 then
			self:_playIconAnim(arg_5_1)
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_CardLight)
	end
end

function TeamBattleTurnCardGameLeftCell:playFinishAnim(arg_6_1, arg_6_2)
	self.m_eff:removeAllEffect()
	self.m_eff:addEffectSpine({
		isLoop = false,
		anim = "play",
		remove = true,
		name = "eff_ui_teamBattle_get",
		eventHandler = arg_6_2
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Gem_LightUp)
end

function TeamBattleTurnCardGameLeftCell:_playIconAnim(arg_7_1)
	local var_7_0 = self.m_iconList:getChildAt((self.m_iconList:itemIndexToChildIndex(arg_7_1))):getChild("loop")

	var_7_0:removeAllEffect()
	var_7_0:addEffectSpine({
		anim = "play",
		scale = 0.8,
		isLoop = true,
		name = "eff_ui_teamBattle_diamond"
	})
end

return TeamBattleTurnCardGameLeftCell
