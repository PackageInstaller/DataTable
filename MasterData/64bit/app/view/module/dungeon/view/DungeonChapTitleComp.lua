local DungeonChapTitleComp = class("DungeonChapTitleComp", require("app.fairyGUI.dungeon.UI_DungeonChapTitleComp"))
local var_0_1 = g.core.model.User.dungeonData

function DungeonChapTitleComp:ctor()
	self._chapterInfo = nil
end

function DungeonChapTitleComp:update(arg_2_1)
	self._chapterInfo = arg_2_1 and arg_2_1.chapterInfo
	self._ctrlIndex = var_0_1:getChapterPassedState(self._chapterInfo.id)

	self.m_passStateController:setSelectedIndex((math.min(3, math.max(0, self._ctrlIndex))))
	self.m_chapterNameTxt:setText(self._chapterInfo.id .. "." .. self._chapterInfo.name)
	self.m_starNumTxt:setText(var_0_1:getChapterStar(self._chapterInfo.id) .. "/" .. #var_0_1:getStageIds(self._chapterInfo.id) * 3)
end

function DungeonChapTitleComp:playPassSpineEffect(arg_3_1)
	if self._ctrlIndex ~= g.core.const.ConstMgr.DungeonConst.CHAPTER_STATE.MAXSTAR then
		self.m_passOpenTransition:play()
		self.m_passOpenTransition:setHook("effPass", handler(self, function()
			self.m_effPass:addEffectSpine({
				name = "eff_ui_dungeon_pass",
				remove = true,
				isLoop = false,
				eventHandler = arg_3_1
			})
		end))
	else
		self.m_perfectOpenTransition:play()
		self.m_perfectOpenTransition:setHook("effPerfect", handler(self, function()
			self.m_effPerfect:addEffectSpine({
				name = "eff_ui_dungeon_perfect",
				remove = true,
				isLoop = false,
				eventHandler = arg_3_1
			})
		end))
	end

	self.m_finishImg:setVisible(true)
end

function DungeonChapTitleComp:hideFinishImg()
	self.m_finishImg:setVisible(false)
end

return DungeonChapTitleComp
