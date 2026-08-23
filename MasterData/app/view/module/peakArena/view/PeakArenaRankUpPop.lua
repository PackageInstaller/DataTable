local var_0_0 = g.core.const.ConstMgr.PeakArenaConst.DanGradingChangeType
local var_0_1 = 8
local var_0_2 = 2
local var_0_3 = -6
local var_0_4 = g.core.model.User.peakArenaData
local var_0_5 = g.core.common.Path
local PeakArenaRankUpPop = class("PeakArenaRankUpPop", require("app.fairyGUI.peakArena.UI_PeakArenaRankUpPop"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaRankUpPop",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaRankUpPop:ctor(arg_2_1)
	self._changeType = arg_2_1.changeType
	self._score = arg_2_1.score
	self._oldScore = arg_2_1.oldScore

	self.m_changeTypeController:setSelectedIndex(self._changeType)
	self:addClickListener(handler(self, self._onCloseSelf))
end

function PeakArenaRankUpPop:onLoad()
	self:setTouchable(false)

	local var_3_0 = var_0_4:getPALevelInfo(self._score)

	if self._changeType == var_0_0.SMALL_UP then
		local var_3_1 = var_0_4:getPALevelInfo(self._oldScore)

		self.m_danGradingLoader:setURL((var_0_5:getPeakArenaDanGradingPic(var_3_0.pic)))
		self.m_starComp:initStar({
			index = var_0_1,
			style = var_0_2,
			gap = var_0_3,
			max = var_0_4:getMaxStarNum(var_3_1.pic),
			num = var_3_1.star
		})
		self:_playSmallUpAni(var_3_1.star, var_3_0.star)
	elseif self._changeType == var_0_0.LARGE_UP then
		self.m_danGradingLoader:setURL((var_0_5:getPeakArenaDanGradingPic(var_0_4:getPALevelInfo(self._oldScore).pic)))
		self.m_starComp:initStar({
			num = 0,
			index = var_0_1,
			style = var_0_2,
			gap = var_0_3,
			max = var_0_4:getMaxStarNum(var_3_0.pic)
		})
		self:_playLargeUpAni(var_3_0.star, var_3_0.pic)
	else
		self.m_danGradingLoader:setURL((var_0_5:getPeakArenaDanGradingPic(var_3_0.pic)))
		self.m_starComp:initStar({
			index = var_0_1,
			style = var_0_2,
			gap = var_0_3,
			max = var_0_4:getMaxStarNum(var_3_0.pic),
			num = var_3_0.star
		})

		if self._changeType == var_0_0.DOWN then
			self:_playDanGradingDownAni()
		elseif self._changeType == var_0_0.INHERIT then
			self:_playInheritAni()
		end
	end
end

function PeakArenaRankUpPop:_playSmallUpAni(arg_4_1, arg_4_2)
	local var_4_0 = self:getView():getTransition("enterA")

	var_4_0:setHook("playStar", handler(self, function()
		self.m_starComp:addEffectToStars(arg_4_1 + 1, arg_4_2, {
			anim = "play",
			name = "eff_ui_peakArena_star",
			remove = true,
			isLoop = false
		})
	end))
	var_4_0:play(handler(self, self._onAniEnd))
	self.m_rankUpBgComp:getChild("effPopBg"):addEffectSpine({
		anim = "play",
		name = "eff_ui_peakArena_popBg",
		remove = true,
		isLoop = false
	})
end

function PeakArenaRankUpPop:_playLargeUpAni(arg_6_1, arg_6_2)
	self.m_rankUpBgComp:getChild("effPopBg"):addEffectSpine({
		anim = "play2",
		name = "eff_ui_peakArena_popBg",
		remove = true,
		isLoop = false
	})

	local var_6_0 = self:getView():getTransition("enterB")

	var_6_0:setHook("switch", handler(self, function()
		self.m_danGradingLoader:setURL((var_0_5:getPeakArenaDanGradingPic(arg_6_2)))
	end))
	var_6_0:setHook("playStar", handler(self, function()
		self.m_starComp:addEffectToStars(1, arg_6_1, {
			anim = "play",
			name = "eff_ui_peakArena_star",
			remove = false,
			isLoop = false
		})
	end))
	var_6_0:setHook("playUp", handler(self, function()
		self.m_effLevelUp:addEffectSpine({
			anim = "play",
			name = "eff_ui_peakArena_levelUp",
			remove = true,
			isLoop = false
		})
	end))
	var_6_0:play(handler(self, self._onAniEnd))
end

function PeakArenaRankUpPop:_playDanGradingDownAni()
	self.m_rankUpBgComp:getChild("effPopBg"):addEffectSpine({
		anim = "play3",
		name = "eff_ui_peakArena_popBg",
		remove = true,
		isLoop = false
	})
	self:getView():getTransition("enterC"):play(handler(self, self._onAniEnd))
end

function PeakArenaRankUpPop:_playInheritAni()
	self:getView():getTransition("enterD"):play(handler(self, self._onAniEnd))
end

function PeakArenaRankUpPop:_onAniEnd()
	self:setTouchable(true)
end

function PeakArenaRankUpPop:_onCloseSelf()
	g.core.module.ModuleManager:popModule()
end

return PeakArenaRankUpPop
