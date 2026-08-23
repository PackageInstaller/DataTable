local DungeonAchievementAwardIcon = class("DungeonAchievementAwardIcon", require("app.fairyGUI.dungeon.UI_DungeonAchievementAwardIcon"))

function DungeonAchievementAwardIcon:ctor()
	self._goods = nil
	self._curState = 0

	self:_initBtn()
end

function DungeonAchievementAwardIcon:_initBtn()
	self:addClickListener(handler(self, self._onSkillPreviewClick))
end

function DungeonAchievementAwardIcon:updateCell(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		return
	end

	self._goods = arg_3_1
	self._achieveId = arg_3_2
	self._index = arg_3_3

	self.m_iconLoader:setURL(arg_3_1.icon)
	self.m_numText:setText(arg_3_1.size)

	self._curState = g.core.model.User.dungeonData:getAchieveState(arg_3_2, arg_3_3)

	self.m_isDoneController:setSelectedIndex(self._curState == 2 and 1 or 0)

	if self._curState == 1 and not self._downEffect then
		self._downEffect = self.m_downEffectHolder:addEffectSpine({
			name = "eff_ui_dungeon_getDown",
			isLoop = true,
			anim = arg_3_3 == 6 and "play" or "play2"
		})
		self._upEffect = self.m_upEffectHolder:addEffectSpine({
			name = "eff_ui_dungeon_getUp",
			isLoop = true,
			anim = arg_3_3 == 6 and "play" or "play2"
		})
		self._upEffect2 = self.m_upEffectHolder:addEffectSpine({
			anim = "play_0",
			name = "eff_ui_common_iconget",
			isLoop = true,
			scale = arg_3_3 == 6 and 0.85 or 0.6
		})

		self._upEffect2:setScaleY(arg_3_3 == 6 and 1.15 or 0.6)
	elseif self._downEffect then
		self._downEffect:setVisible(self._curState == 1)
		self._upEffect:setVisible(self._curState == 1)
		self._upEffect2:setVisible(self._curState == 1)
	end
end

function DungeonAchievementAwardIcon:onAutoClick()
	self:_onSkillPreviewClick()
end

function DungeonAchievementAwardIcon:_onSkillPreviewClick()
	if self._curState == 1 then
		g.core.module.ModuleManager:showLoading(true)
		self._downEffect:setVisible(false)
		self._upEffect:setVisible(false)
		self._upEffect2:setVisible(false)
		self.m_isDoneController:setSelectedIndex(1)
		self.m_getTransition:play(handler(self, self.getAchieveAward))
	elseif self._goods then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._goods.type,
			value = self._goods.value,
			size = g.core.model.User.bagData:getOwnNum(self._goods.type, self._goods.value)
		})
	end
end

function DungeonAchievementAwardIcon:getAchieveAward()
	g.core.module.ModuleManager:showLoading(false)
	g.core.network.GameNetProxy:send_C2S_Dungeon_FinishAchievement({
		id = self._achieveId,
		index = self._index
	})
end

return DungeonAchievementAwardIcon
