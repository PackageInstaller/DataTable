local DungeonEffectPop = class("DungeonEffectPop", require("app.fairyGUI.dungeon.UI_DungeonEffectPop"), function()
	return fgui.GComponent:create({
		resName = "DungeonEffectPop",
		pkgName = "dungeon"
	})
end)
local var_0_1 = g.core.config.dungeon_chapter_info
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.config.item_info

DungeonEffectPop.PASS_CHIP_ID = 24

function DungeonEffectPop:ctor()
	self._name = ""
	self._chapterId = 0
end

function DungeonEffectPop:update(arg_3_1)
	if arg_3_1 then
		self._name = arg_3_1.name or ""
	end

	if arg_3_1 then
		self._chapterId = arg_3_1.chapterId or nil
	end

	if arg_3_1 then
		self._landId = arg_3_1.landId or 0
	end

	local var_3_0

	if self._chapterId then
		var_3_0 = var_0_1.get(self._chapterId)
	end

	if self._name == "finish" then
		self:_playFinishEffect(var_3_0)
	elseif self._name == "open" then
		self:_playOpenEffect(var_3_0)
	end
end

function DungeonEffectPop:_playOpenEffect(arg_4_1)
	local var_4_0 = fgui.UIPackage:createObject("dungeon", "DungeonStoryTxtComp")

	var_4_0:updateTxt({
		chapterInfo = arg_4_1,
		name = arg_4_1.name
	})
	self:addChild(var_4_0)
	var_4_0:setPosition(display.width / 2, display.height / 2)
	var_4_0:setWidth(display.width)
	var_4_0:playBackTransition()
end

function DungeonEffectPop:_playFinishEffect(arg_5_1)
	if ((self._chapterId == 1 and g.core.guide.GuideProxy:isGuideRunning() or nil) and 0) > 0 then
		self:_addScrollEffect()
	else
		self:_addChapterFinishComp()
	end
end

function DungeonEffectPop:_addScrollEffect()
	local var_6_0 = var_0_5.get(DungeonEffectPop.PASS_CHIP_ID)

	g.core.module.ModuleManager:showFeedBackTipsPop({
		title = g.core.lang:get(300021),
		showComp = fgui.UIPackage:createObject("base_new", "BasePassChipAwardNode"),
		iconUrl = var_0_4:getMiddleItemIconById(var_6_0.icon),
		name = var_6_0.name,
		func = handler(self, self._addChapterFinishComp)
	})
end

function DungeonEffectPop:_addChapterFinishComp()
	local var_7_0 = fgui.UIPackage:createObject("dungeon", "DungeonChapterFinishComp")

	var_7_0:setPosition(cc.p(display.cx, display.cy))
	var_7_0:setSize(display.width, display.height)
	self:addChild(var_7_0)
	var_7_0:setTouchable(true)
	var_7_0:update((var_0_1.get(self._chapterId)))
end

function DungeonEffectPop:doAutoAction()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function DungeonEffectPop:onUnload()
	if self._name == "finish" then
		self:dispatchCompEvent("effect_exit")
	end

	var_0_2:dispatchEvent(var_0_3.EVENT_GUIDE_WAIT)
	var_0_2:dispatchEvent(var_0_3.EVENT_GUIDE_READY)
end

return DungeonEffectPop
