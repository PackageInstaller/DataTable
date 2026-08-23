local ActivityRerunBallComp = class("ActivityRerunBallComp", require("app.fairyGUI.activityReturn.UI_ActivityRerunBallComp"))

function ActivityRerunBallComp:initSpine(arg_1_1)
	self._animName = arg_1_1.anim
	arg_1_1.eventHandler = arg_1_1.eventHandler or handler(self, self._onSpineEventHandle)
	self._animCalBackMap = {}
	self._spine = self.m_spineNode:addEffectSpine(arg_1_1)
end

function ActivityRerunBallComp:onLoad()
	return
end

function ActivityRerunBallComp:setAnim(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._animCalBackMap[arg_3_2] = arg_3_4
	self._animName = arg_3_2
	arg_3_1 = arg_3_1 or 0

	self._spine:setAnimation(arg_3_1, self._animName, arg_3_3)
end

function ActivityRerunBallComp:_onSpineEventHandle(arg_4_1, arg_4_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_4_1.type then
		if self._animCalBackMap[self._animName] then
			self._animCalBackMap[self._animName](arg_4_2)
		end

		self._animCalBackMap[self._animName] = nil
	end
end

return ActivityRerunBallComp
