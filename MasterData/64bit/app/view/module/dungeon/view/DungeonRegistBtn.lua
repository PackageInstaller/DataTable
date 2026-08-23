local var_0_0 = g.core.model.User.dungeonData
local var_0_1 = g.core.const.ConstMgr.DungeonConst
local DungeonRegistBtn = class("DungeonRegistBtn", require("app.fairyGUI.dungeon.UI_DungeonRegistBtn"))

function DungeonRegistBtn:ctor()
	self._touchcomp = nil
end

function DungeonRegistBtn:updateRegistBtn()
	self:setVisible(var_0_0:isShowPreRegistration())

	local var_2_0 = var_0_0:getLastPassedChapter()

	self:setTitle(var_2_0 .. "/" .. var_0_1.OPEN_REGISTRATION_CHAPTER)

	local var_2_1 = var_2_0 >= var_0_1.OPEN_REGISTRATION_CHAPTER

	self.m_isPassController:setSelectedIndex(var_2_0 >= var_0_1.OPEN_REGISTRATION_CHAPTER and 1 or 0)
	self.m_eff:removeAllEffect()

	if var_2_1 then
		self.m_eff:addEffectSpine({
			name = "registration_idle",
			isLoop = true
		})
		self:addTouchComp()
	end
end

function DungeonRegistBtn:addTouchComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "REGIST_SHOW",
		targetBtn = self
	})
end

return DungeonRegistBtn
