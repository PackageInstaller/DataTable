local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleTurnCardGameRightComp = class("TeamBattleTurnCardGameRightComp", require("app.fairyGUI.teamBattle.UI_TeamBattleTurnCardGameRightComp"))

function TeamBattleTurnCardGameRightComp:ctor()
	self._curTurnIndex = 1

	self:_initView()
end

function TeamBattleTurnCardGameRightComp:_initView()
	for iter_2_0 = 1, 12 do
		self["m_card" .. iter_2_0]:setCtrlState("isSelected", {
			index = 0
		})
		self["m_card" .. iter_2_0]:addClickListener(handler(self, self._onClickCard))
	end
end

function TeamBattleTurnCardGameRightComp:_onClickCard(arg_3_1)
	local var_3_0 = arg_3_1:getSender()

	if var_3_0:getController("isSelected"):getSelectedIndex() == 1 then
		return
	end

	if self._curTurnIndex > #self._cardSequence then
		return
	end

	local var_3_1 = self._cardSequence[self._curTurnIndex]

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Gem_Click)

	local var_3_2 = var_3_0:getChild("eff2")

	var_3_2:removeAllEffect()
	var_3_2:addEffectSpine({
		anim = "play",
		name = "eff_ui_exploration_card",
		isLoop = false
	})
	self:newScheduleOnce(function()
		if var_3_1 == 1 then
			local var_4_0 = var_3_0:getChild("eff")

			var_3_0:getTransition("fade"):play()
			var_4_0:removeAllEffect()
			var_4_0:addEffectSpine({
				anim = "play",
				name = "eff_ui_teamBattle_diamond",
				isLoop = true
			})
		end
	end, 0.5)

	self._curTurnIndex = self._curTurnIndex + 1

	var_3_0:setCtrlState("type", {
		index = var_3_1 - 1
	})
	var_3_0:setCtrlState("isSelected", {
		index = 1
	})
	self:dispatchCompEvent("turn_card", {
		index = self._curTurnIndex - 1
	})
end

function TeamBattleTurnCardGameRightComp:onLoad()
	self._cardSequence = var_0_0:getGameData():getCardSequence()
end

return TeamBattleTurnCardGameRightComp
