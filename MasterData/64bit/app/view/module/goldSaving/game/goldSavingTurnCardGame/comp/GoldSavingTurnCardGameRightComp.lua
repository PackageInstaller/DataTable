local var_0_0 = g.core.model.User.goldSavingData
local GoldSavingTurnCardGameRightComp = class("GoldSavingTurnCardGameRightComp", require("app.fairyGUI.goldSaving.UI_GoldSavingTurnCardGameRightComp"))

function GoldSavingTurnCardGameRightComp:ctor()
	self._curTurnIndex = 1

	self:_initView()
end

function GoldSavingTurnCardGameRightComp:_initView()
	for iter_2_0 = 1, 12 do
		self["m_card" .. iter_2_0]:setCtrlState("isSelected", {
			index = 0
		})
		self["m_card" .. iter_2_0]:addClickListener(handler(self, self._onClickCard))
	end
end

function GoldSavingTurnCardGameRightComp:_onClickCard(arg_3_1)
	local var_3_0 = arg_3_1:getSender()

	if var_3_0:getController("isSelected"):getSelectedIndex() == 1 then
		return
	end

	if self._curTurnIndex > #self._cardSequence then
		return
	end

	local var_3_1 = self._cardSequence[self._curTurnIndex]

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_CardPush)

	local var_3_2 = var_3_0:getChild("eff2")

	var_3_2:removeAllEffect()
	var_3_2:addEffectSpine({
		name = "eff_ui_specialSlotMachineIcon_card",
		isLoop = false,
		anim = "play"
	})
	self:newScheduleOnce(function()
		if var_3_1 == 1 then
			local var_4_0 = var_3_0:getChild("eff")

			var_3_0:getTransition("fade"):play()
			var_4_0:removeAllEffect()
			var_4_0:addEffectSpine({
				name = "eff_ui_specialSlotMachineIcon_click",
				isLoop = true,
				anim = "play4"
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

function GoldSavingTurnCardGameRightComp:onLoad()
	self._cardSequence = var_0_0:getCardSequence()
end

return GoldSavingTurnCardGameRightComp
