local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local DungeonChapterFinishComp = class("DungeonChapterFinishComp", require("app.fairyGUI.dungeon.UI_DungeonChapterFinishComp"))

function DungeonChapterFinishComp:ctor()
	self.m_bgLoader:setURL("bg/dungeon/bg_zhangjiejieshu.jpg")

	local var_1_0 = self.m_bgLoader:getSize()

	if display.width / var_1_0.width > 1 or display.height / var_1_0.height > 1 then
		self.m_bgLoader:setScale((math.max(display.width / var_1_0.width, display.height / var_1_0.height)))
	end
end

function DungeonChapterFinishComp:onLoad()
	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_TOUCH_START)
end

function DungeonChapterFinishComp:update(arg_3_1)
	self.m_enterTransition:stop()
	self.m_enterTransition:play(handler(self, function()
		self:setTouchable(false)
	end))

	if not arg_3_1 then
		return
	end

	self.m_descComp:getChild("chapterTxt"):setText(g.core.lang:get(300022, {
		num = arg_3_1.id,
		name = arg_3_1.name
	}))
	self.m_descComp:getChild("finishDescTxt"):setText(arg_3_1.chapter_clear)
end

function DungeonChapterFinishComp:onUnload()
	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_TOUCH_END)
end

return DungeonChapterFinishComp
