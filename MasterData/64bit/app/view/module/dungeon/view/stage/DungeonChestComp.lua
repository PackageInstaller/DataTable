local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.dungeonData
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.module.ModuleManager
local DungeonChestComp = class("DungeonChestComp", require("app.fairyGUI.dungeon.UI_DungeonChestComp"))

function DungeonChestComp:ctor()
	self._state = 0
	self._boxEffect = nil

	self.m_effectComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_boxui_up",
		scale = 0.6
	})
	self.m_effectComp1:addEffectSpine({
		isLoop = true,
		name = "eff_ui_dungeon_boxui_down",
		scale = 0.6
	})
	self:addClickListener(handler(self, self._onClick))
end

function DungeonChestComp:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, handler(self, self._onGetChapterChestAward), self)
end

function DungeonChestComp:updateChest(arg_3_1, arg_3_2, arg_3_3)
	self._chapterId = arg_3_1
	self._chestId = arg_3_2.id
	self._index = arg_3_3
	self._chestInfo = arg_3_2
	self._state = 0

	local var_3_1 = var_0_2:getChapter(self._chapterId)

	if var_3_1 then
		local var_3_2 = var_3_1:canOpenStarChest(self._index)

		self._state = var_3_2 and 1 or 0

		if var_3_2 then
			local var_3_3 = var_3_1:isStarChestOpened(self._index)

			if not var_3_3 then
				self:_playBoxEffect()
			else
				self:_removeBoxEffect()
			end

			self._state = var_3_3 and 2 or 1
		else
			self:_removeBoxEffect()
		end
	end

	self:setIcon((var_0_3:getProgressBoxIcon(arg_3_3, self._state + 1)))
end

function DungeonChestComp:_playBoxEffect()
	self.m_effectComp:setVisible(true)
	self.m_effectComp1:setVisible(true)
end

function DungeonChestComp:_removeBoxEffect()
	self.m_effectComp:setVisible(false)
	self.m_effectComp1:setVisible(false)
end

function DungeonChestComp:_onClick()
	if self._state == 1 then
		g.core.network.GameNetProxy:send_C2S_Dungeon_GetChapterChestAward({
			id = self._chapterId,
			tp = self._chestInfo.chest_type,
			pos = self._index
		})
	else
		var_0_4:pushPopup(require("app.view.module.dungeon.view.stage.DungeonRewardPop").new({
			chapterId = self._chapterId,
			chestId = self._chestId,
			index = self._index
		}))
	end
end

function DungeonChestComp:_onGetChapterChestAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.pos == self._index then
		self:updateChest(self._chapterId, self._chestInfo, self._index)
	end
end

return DungeonChestComp
