local AncientsActiveAwardCell = class("AncientsActiveAwardCell", require("app.fairyGUI.ancients.UI_AncientsActiveAwardCell"))

function var_0_0:ctor()
	self._dotEffect = nil
	self._iconEffect = nil

	self.m_Comp_touch:addClickListener(handler(self, self._onClick))
end

function var_0_0:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._cfg = arg_2_1

	local var_2_0 = 0

	if g.core.model.User.ancientsData:isActiveAwarded(arg_2_1.id) then
		var_2_0 = 2
	elseif g.core.model.User.ancientsData:getActiveCount() >= arg_2_1.num then
		var_2_0 = 1
	end

	self.m_stateController:setSelectedIndex(var_2_0)
	self.m_Comp_icon:updateIcon({
		type = arg_2_1.reward_type,
		value = arg_2_1.reward_value,
		size = arg_2_1.reward_size
	})
	self.m_Comp_effect:setVisible(var_2_0 == 1)
	self.m_Txt_score:setText(arg_2_1.num)

	if var_2_0 == 1 then
		self._dotEffect = self._dotEffect or self.m_dotEffect:addEffectSpine({
			anim = "dot",
			name = "eff_ui_activityWake_totalglow",
			isLoop = true
		})
		self._iconEffect = self._iconEffect or self.m_iconEffect:addEffectSpine({
			anim = "play_0",
			scale = 0.65,
			name = "eff_ui_common_iconget",
			isLoop = true
		})
	else
		if self._dotEffect then
			self._dotEffect:setVisible(false)
		end

		if self._iconEffect then
			self._iconEffect:setVisible(false)
		end
	end
end

function var_0_0:_onClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Click_Small_01)

	if self.m_stateController:getSelectedIndex() == 1 then
		g.core.network.GameNetProxy:send_C2S_Ancient_ActiveAward({
			ids = {
				self._cfg.id
			}
		})
	else
		g.core.common.GlobalFunc.pushInfoPop({
			type = self._cfg.reward_type,
			value = self._cfg.reward_value,
			size = self._cfg.reward_size,
			iconComp = self.m_Comp_icon
		})
	end
end

return var_0_0
