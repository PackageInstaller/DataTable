local var_0_0 = g.core.config.dungeon_chapter_info
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.dungeonData
local EasterEggLeftComp = class("EasterEggLeftComp", require("app.fairyGUI.gameEntertainment.UI_EasterEggLeftComp"))

function EasterEggLeftComp:ctor()
	self._maskIcon = self.m_picMask:getChild("picLoader")
	self._interactionId = 0
	self._eggId = 0

	self.m_goToBtn:addClickListener(handler(self, self._onGoToBtnClick))
end

function EasterEggLeftComp:updateGameInfo(arg_2_1)
	if arg_2_1 then
		if not arg_2_1.isUnlock then
			self.m_gameStateController:setSelectedIndex(1)
		else
			self.m_gameStateController:setSelectedIndex(0)
		end

		local var_2_0 = arg_2_1.cfg

		self._interactionId = arg_2_1.cfg.interaction_id

		self._maskIcon:setURL((var_0_1:getEasterEggPlotReplayImage(var_2_0.interaction_id)))
		self.m_gameNameTxt:setText(var_2_0.title)
		self.m_eggImage:setURL(var_0_1:getEasterEggImage(var_2_0.icon))
	end
end

function EasterEggLeftComp:_onGoToBtnClick()
	if self._interactionId == 0 then
		return
	end

	local var_3_0 = var_0_2:getChapterIdByInteractionId(self._interactionId)

	if not var_3_0 then
		return
	end

	local var_3_1 = var_3_0.id

	if g.core.model.User:getLevel() < var_3_0.condition_level and var_0_0.get((var_0_2:getLastUnlockChapter())).next_id == var_3_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(300008, {
			level = var_3_0.condition_level
		}))
	elseif not var_0_2:isChapterUnlocked(var_3_0.id) then
		local var_3_2 = var_0_0.get(var_3_1 - 1)

		g.core.module.ModuleManager:tip(g.core.lang:get(300043, {
			chapter = var_3_2.land_id,
			stage = var_0_2:getChapterIndex(var_3_2.id)
		}))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON_STAGE, {
			chapterId = var_3_1
		})
	end
end

return EasterEggLeftComp
