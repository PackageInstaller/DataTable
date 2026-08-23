local var_0_0 = g.core.model.User.redCliffData
local RedCliffBattleFinishPop = class("RedCliffBattleFinishPop", require("app.fairyGUI.redCliff.UI_RedCliffBattleFinishPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffBattleFinishPop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	}, ...)
end)

function RedCliffBattleFinishPop:ctor()
	self:showAtCenter()

	self._result = nil

	self.m_closeBg:setVisible(false)
	self.m_closeBg:addClickListener(handler(self, self._onClose))
	self:_updateView()
end

function RedCliffBattleFinishPop:_updateView()
	local var_3_0, var_3_1 = var_0_0:getMyMatchRankAndScore()

	self.m_rank:setText(var_3_0)
	self.m_score:setText(g.core.lang:get(421124, {
		num = var_0_0:calDeltaScoreAfterMatch(var_3_0, var_3_1)
	}))
end

function RedCliffBattleFinishPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RedCliffBattleFinishPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onEnterFinish))
	self.m_finishEffect:addEffectSpine({
		name = "eff_ui_redCliff_finish",
		anim = "play",
		isLoop = false,
		remove = true
	})
end

function RedCliffBattleFinishPop:_onEnterFinish()
	self.m_closeBg:setVisible(true)
end

function RedCliffBattleFinishPop:onUnload()
	self.m_backTransition:play()
	self:dispatchCompEvent("open_final_match_user_list")
end

return RedCliffBattleFinishPop
