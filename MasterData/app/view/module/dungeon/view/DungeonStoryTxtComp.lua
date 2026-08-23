local var_0_0 = g.core.common.Path
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local DungeonStoryTxtComp = class("DungeonStoryTxtComp", require("app.fairyGUI.dungeon.UI_DungeonStoryTxtComp"))

function DungeonStoryTxtComp:ctor()
	self._readyPush = false
end

function DungeonStoryTxtComp:updateTxt(arg_2_1)
	self.m_bgImg:setURL(var_0_0:getGroupPicById(arg_2_1.chapterInfo.group))
	self.m_titleTxt:setText(g.core.lang:get(300035, {
		chapterId = arg_2_1.chapterInfo.id,
		name = arg_2_1.name
	}))
end

function DungeonStoryTxtComp:playBackTransition()
	self.m_chapterOpen:addEffectSpine({
		remove = true,
		name = "eff_ui_dungeon_chapterOpen",
		scale = 1,
		isLoop = false
	})
	self.m_enterTransition:play(function()
		g.core.module.ModuleManager:popComponent()

		self._readyPush = true

		var_0_1:dispatchEvent(var_0_2.EVENT_GUIDE_READY_SURE_OK)
	end)
end

function DungeonStoryTxtComp:onUnload()
	if not self._readyPush then
		var_0_1:dispatchEvent(var_0_2.EVENT_GUIDE_READY_SURE_OK)

		self._readyPush = true
	end
end

return DungeonStoryTxtComp
