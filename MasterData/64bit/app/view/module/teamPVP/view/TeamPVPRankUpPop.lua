local var_0_0 = g.core.model.User.teamPvpData
local var_0_2 = g.core.common.Path
local TeamPVPRankUpPop = class("TeamPVPRankUpPop", require("app.fairyGUI.teamPVP.UI_TeamPVPRankUpPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPRankUpPop",
		pkgPath = "ui/teamPVP/teamPVP",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPRankUpPop:ctor(arg_2_1)
	self:showAtCenter()

	self._oldTitle = arg_2_1.oldTitleId
	self._curTitle = arg_2_1.curTitleId

	self:addClickListener(handler(self, self._onCloseSelf))
end

function TeamPVPRankUpPop:onLoad()
	self:setTouchable(false)

	local var_3_0 = var_0_0:getTitleInfoByBaseId(self._oldTitle)

	if var_3_0 then
		self.m_rankLoader:setURL((var_0_2:getTeamPVPBadge300(var_3_0.title_res)))
	end

	self:_playUpgradeAnim()
end

function TeamPVPRankUpPop:_playUpgradeAnim()
	self.m_rankUpBgComp:getChild("effPopBg"):addEffectSpine({
		anim = "play2",
		remove = false,
		name = "eff_ui_peakArena_popBg",
		isLoop = false
	})

	local var_4_0 = self:getView():getTransition("enterB")

	var_4_0:setHook("switch", handler(self, function(arg_5_0)
		local var_5_0 = var_0_0:getTitleInfoByBaseId(arg_5_0._curTitle)

		if var_5_0 then
			arg_5_0.m_rankLoader:setURL((var_0_2:getTeamPVPBadge300(var_5_0.title_res)))
		end
	end))
	var_4_0:setHook("playUp", handler(self, function(arg_6_0)
		arg_6_0.m_effLevelUp:addEffectSpine({
			anim = "play",
			remove = false,
			name = "eff_ui_peakArena_levelUp",
			isLoop = false
		})
	end))
	var_4_0:play(handler(self, self._onAniEnd))
end

function TeamPVPRankUpPop:_onAniEnd()
	self:setTouchable(true)
end

function TeamPVPRankUpPop:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return TeamPVPRankUpPop
