local var_0_0 = g.core.config.guild_alliance_box_info
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.allianceData
local AllianceBoxScoreComp = class("AllianceBoxScoreComp", require("app.fairyGUI.alliance.UI_AllianceBoxScoreComp"))

function AllianceBoxScoreComp:ctor()
	self._fullEff = nil

	self:initView()
end

function AllianceBoxScoreComp:initView()
	self:addClickListener(handler(self, self._onClickGetBtn))
end

function AllianceBoxScoreComp:_onClickGetBtn()
	local var_3_0 = var_0_2:getBoxData():getCurInfo()

	if not var_3_0 or var_0_2:getBoxData():getCurScore() < var_3_0.need then
		g.core.module.ModuleManager:tip(g.core.lang:get(428513))

		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_box_switch_small)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ExchangeBoxAward({})
end

function AllianceBoxScoreComp:updateView()
	local var_4_0 = var_0_2:getBoxData():getCurScore()
	local var_4_1 = var_0_2:getBoxData():getCurInfo()

	if not var_4_1 then
		return
	end

	self:setMax(var_4_1.need)
	self:setValue(var_4_0)
	self.m_icon:setURL(var_0_1:getAllianceBox128(var_0_0.get(var_4_1.box_id).box_pic))

	if var_4_0 >= var_4_1.need then
		self._fullEff = self._fullEff or self.m_effLoop:addEffectSpine({
			name = "eff_ui_alliance_fullLoop",
			anim = "play",
			remove = false,
			isLoop = true
		})

		self.m_effLoop:setVisible(true)
	else
		self.m_effLoop:setVisible(false)
	end
end

function AllianceBoxScoreComp:showFullUpEff()
	self.m_effUp:addEffectSpine({
		name = "eff_ui_alliance_fullUp",
		anim = "play",
		remove = true,
		isLoop = false
	})
end

return AllianceBoxScoreComp
