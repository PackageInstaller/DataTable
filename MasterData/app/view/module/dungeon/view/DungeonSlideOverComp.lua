local var_0_0 = g.core.common.ModuleUnlock
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.const.ConstMgr
local DungeonSlideOverComp = class("DungeonSlideOverComp", require("app.fairyGUI.dungeon.UI_DungeonSlideOverComp"))

function DungeonSlideOverComp:ctor()
	self._inWaitState = false

	self:_initUiListener()
end

function DungeonSlideOverComp:_initUiListener()
	self.m_funcBtn1 = self.m_btnComp:getChild("funcBtn1")
	self.m_unknowBtn = self.m_btnComp:getChild("unknowBtn")

	self.m_touchComp:addClickListener(handler(self, self._onClick))
	self.m_funcBtn1:addClickListener(handler(self, self._onClickFuncBtn1))
	self.m_unknowBtn:addClickListener(handler(self, self._onClickUnKnowBtn))
	self.m_funcBtn1:getChild("redPointComp"):setId(172)
	self.m_styleController:setSelectedIndex(0)

	self._backTransition = self.m_back2Transition
	self._enterTransition = self.m_enter2Transition
end

function DungeonSlideOverComp:onLoad()
	var_0_1:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_funcBtn1
	})
	var_0_1:dispatchEvent(var_0_2.EVENT_GUIDE_WAIT)

	self._inWaitState = true

	local var_3_0 = g.core.model.User.bioData:isBioChapterNew()

	self.m_newBioBubbleComp:setVisible(var_3_0)

	if var_3_0 then
		self.m_newBioBubbleComp:getTransition("enter"):play()

		local var_3_1 = self.m_newBioBubbleComp:getChild("eff")

		var_3_1:removeAllEffect()

		self._spine = var_3_1:addEffectSpine({
			anim = "play",
			name = "eff_ui_baseNew_bubble",
			isLoop = false,
			eventHandler = handler(self, self._onSpineEnd)
		})
	end

	self._enterTransition:play(handler(self, self.onAnimEnd))
end

function DungeonSlideOverComp:_onSpineEnd(arg_4_1, arg_4_2)
	if arg_4_1.type == "complete" and self._spine then
		self._spine:setAnimation(0, "play2", true)
	end
end

function DungeonSlideOverComp:onAnimEnd()
	if self._inWaitState then
		self._inWaitState = false

		var_0_1:dispatchEvent(var_0_2.EVENT_GUIDE_READY)
		self:checkSpeWeakGuide()
	end
end

function DungeonSlideOverComp:onUnload()
	if self._inWaitState then
		self._inWaitState = false

		var_0_1:dispatchEvent(var_0_2.EVENT_GUIDE_READY)
	end
end

function DungeonSlideOverComp:_onClick()
	if self.m_stateController:getSelectedIndex() == 0 then
		self.m_stateController:setSelectedIndex(1)
		self._backTransition:play()
	else
		self.m_stateController:setSelectedIndex(0)
		self._enterTransition:play()
	end
end

function DungeonSlideOverComp:_onClickFuncBtn1()
	if var_0_0:isModuleUnlock(var_0_3.FUNCTION_TYPE.BIO_MAIN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_MAIN)
	end
end

function DungeonSlideOverComp:_onClickUnKnowBtn()
	g.core.module.ModuleManager:tip(g.core.lang:get(300034))
end

function DungeonSlideOverComp:checkSpeWeakGuide()
	if self.m_styleController:getSelectedIndex() == 0 then
		if g.core.model.User.bioData:isBioChapterNew() and (g.core.model.User.bioData:getMaxChapterId() or 0) <= 3 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "DUNGEON_BIO_ENTRANCE_GUIDE",
				targetBtn = self.m_funcBtn1
			})
		end
	end
end

return DungeonSlideOverComp
