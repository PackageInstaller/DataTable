local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = "common/icon/box/pic_baoxiang_jin_ying.png"
local var_0_4 = g.core.model.User.dungeonData
local var_0_5 = g.core.common.Path
local DungeonStageChestComp = class("DungeonStageChestComp", require("app.fairyGUI.dungeon.UI_DungeonStageChestComp"))

function DungeonStageChestComp:ctor()
	self.m_shadowImg:setURL(var_0_3)
	self.m_effectComp:addEffectSpine({
		name = "eff_ui_dungeon_boxscene",
		scale = 0.6,
		isLoop = true
	})
	self:addClickListener(handler(self, self._onClick))
end

function DungeonStageChestComp:_onClick()
	var_0_2:pushPopup(require("app.view.module.dungeon.view.stage.DungeonRewardPop").new({
		chapterId = self._chapterId,
		chestId = self._chestId,
		index = self._index
	}))
end

function DungeonStageChestComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, handler(self, self._onGetChapterChestAward), self)
end

function DungeonStageChestComp:update(arg_4_1, arg_4_2, arg_4_3)
	self._index = arg_4_3
	self._chapterId = arg_4_1
	self._chestId = arg_4_2.id
	self._chestInfo = arg_4_2

	local var_4_0 = 0
	local var_4_2 = var_0_4:getChapter(self._chapterId)

	if var_4_2 then
		local var_4_3 = var_0_4:canOpenStageChest(self._chapterId, self._index)

		var_4_0 = var_4_3 and 2 or 1

		if var_4_3 then
			var_4_0 = var_4_2:isStageChestOpen(self._index) and 3 or 2
		end
	end

	if var_4_0 == 2 then
		self:_playBoxEffect()
	else
		self:_removeBoxEffect()
	end

	self:setIcon((var_0_5:getChestByLevelAndState(1, var_4_0)))
end

function DungeonStageChestComp:_playBoxEffect()
	self.m_effectComp:setVisible(true)
end

function DungeonStageChestComp:_removeBoxEffect()
	self.m_effectComp:setVisible(false)
end

function DungeonStageChestComp:_onGetChapterChestAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.pos == self._index then
		self:update(self._chapterId, self._chestInfo, self._index)
	end
end

return DungeonStageChestComp
