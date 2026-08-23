local var_0_0 = g.core.model.User.elderBossData
local ElderBossGroupComp = class("ElderBossGroupComp", require("app.fairyGUI.elderBoss.UI_ElderBossGroupComp"))

function ElderBossGroupComp:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function ElderBossGroupComp:updateGroupInfo(arg_2_1)
	self._buffInfo = arg_2_1

	self.m_nameTxt:setText(arg_2_1.name)
	self.m_nameShadowTxt:setText(arg_2_1.name)
	self.m_descTxt:setText(arg_2_1.description)
	self:setIcon(g.core.common.Path:getElderBossBuffById(arg_2_1.id))

	self._rankMap = var_0_0:getElderBossResultRankMap()

	if self._rankMap[arg_2_1.id] then
		self.m_hasHonnorController:setSelectedIndex(1)
		self.m_honorTxt:setText(self._rankMap[arg_2_1.id].max_honor)
	else
		self.m_hasHonnorController:setSelectedIndex(0)
	end
end

function ElderBossGroupComp:playShowTransition(arg_3_1)
	self.m_showTransition:play()
	self.m_effShow:removeAllEffect()
	self.m_effShow:addEffectSpine({
		isLoop = false,
		name = "eff_ui_elderBoss_elementalshow",
		anim = "play"
	})
	self.m_effLoop:removeAllEffect()
	self.m_effLoop:addEffectSpine({
		isLoop = true,
		name = "eff_ui_elderBoss_elementalglow",
		anim = "play_" .. arg_3_1
	})
end

function ElderBossGroupComp:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderBossJoinBuffPop").new({
		buff = self._buffInfo.id,
		desc = g.core.lang:get(432503, {
			buffName = self._buffInfo.name,
			num = self._buffInfo.ratio
		}),
		onConfirm = handler(self, function()
			g.core.network.GameNetProxy:send_C2S_ElderBoss_ChooseBuff({
				buff = self._buffInfo.id
			})
		end)
	}), {
		touchDisappear = true
	})
end

return ElderBossGroupComp
