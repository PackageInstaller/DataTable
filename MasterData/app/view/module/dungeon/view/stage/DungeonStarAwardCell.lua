local var_0_0 = g.core.const.ConstMgr.DungeonConst
local var_0_1 = g.core.config.dungeon_chest_info
local var_0_2 = g.core.model.User.dungeonData
local DungeonStarAwardCell = class("DungeonStarAwardCell", require("app.fairyGUI.dungeon.UI_DungeonStarAwardCell"))

function DungeonStarAwardCell:ctor()
	self._rewardData = {}

	self.m_getBtn:addClickListener(handler(self, self.onRewardClick))
	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
end

function DungeonStarAwardCell:updateItem(arg_2_1, arg_2_2, arg_2_3)
	self._chapterId = arg_2_1.chapterId
	self._chestInfo = arg_2_1.chestInfo
	self._chestId = arg_2_1.chestInfo.id
	self._index = arg_2_2 + 1
	self._rewardData = var_0_2:getStarAwardsData(self._chestId)

	self.m_rewardList:setNumItems(#self._rewardData)
	self.m_starTxt:setText(arg_2_1.chestInfo.unlock)
	self.m_rewardTitle:setText(g.core.lang:get(300024, {
		num = g.core.utils.Number.toChineseNumber(self._index)
	}))
	self.m_starNum:setText("[color=#e52e2e]" .. arg_2_3 .. "[/color]" .. "/" .. arg_2_1.chestInfo.unlock)
	self.m_rewardStateController:setSelectedIndex((self:_getAwardsState()))
end

function DungeonStarAwardCell:_getAwardsState()
	local var_3_0 = 0
	local var_3_2 = var_0_2:getChapter(self._chapterId)

	if var_3_2 then
		local var_3_3 = var_3_2:canOpenStarChest(self._index)

		var_3_0 = var_3_3 and var_0_0.STAR_AWARDS_CTRL.UNGET or 0
		var_3_0 = var_3_3 and (not var_3_2:isStarChestOpened(self._index) and var_0_0.STAR_AWARDS_CTRL.CANGET or var_0_0.STAR_AWARDS_CTRL.GET) or var_0_0.STAR_AWARDS_CTRL.UNGET
	end

	return var_3_0
end

function DungeonStarAwardCell:_onListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewardData[arg_4_1 + 1])
end

function DungeonStarAwardCell:onRewardClick()
	g.core.network.GameNetProxy:send_C2S_Dungeon_GetChapterChestAward({
		id = self._chapterId,
		tp = var_0_1.get(self._chestId).chest_type,
		pos = self._index
	})
end

return DungeonStarAwardCell
