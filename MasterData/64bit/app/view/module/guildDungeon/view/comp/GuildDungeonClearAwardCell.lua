local GuildDungeonClearAwardCell = class("GuildDungeonClearAwardCell", require("app.fairyGUI.guildDungeon.UI_GuildDungeonClearAwardCell"))
local var_0_1 = g.core.model.User.guildDungeonData
local var_0_2 = g.core.const.ConstMgr

function GuildDungeonClearAwardCell:ctor()
	self._chapterId = 0
	self._chapterInfo = {}
	self._awardList = nil
	self._stateData = {}
	self._rewardRatio = 0

	self:_initUI()
end

function GuildDungeonClearAwardCell:_initUI()
	self.m_receiveBtn:addClickListener(handler(self, self._onClickReceive))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function GuildDungeonClearAwardCell:_onAwardItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = self._chapterInfo["week_clear_type_" .. arg_3_1 + 1],
		value = self._chapterInfo["week_clear_value_" .. arg_3_1 + 1],
		size = math.floor(self._chapterInfo["week_clear_size_" .. arg_3_1 + 1])
	})
end

function GuildDungeonClearAwardCell:updateCell(arg_4_1)
	if arg_4_1 then
		self._stateData = arg_4_1.data or {}
	end

	self._chapterId = self._stateData.id

	local var_4_0 = var_0_1:getChapterById(self._chapterId)
	local var_4_1 = var_0_1:getCurChapterId()
	local var_4_2 = var_4_0:getCurrentHp()

	self._chapterInfo = var_4_0:getCfg()

	self.m_stateController:setSelectedIndex(self._stateData.state)

	if var_4_1 >= self._chapterId and math.uint64_equal((var_4_1 > self._chapterId or nil) and 0, 0) and self._stateData.state ~= 2 then
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_indexTxt:setText(self._chapterInfo.title)
	self.m_needTxt:setText(g.core.lang:get(306010, {
		chapter = self._chapterId
	}))
	self.m_awardList:setNumItems(var_0_2.GuildDungeonConst.CLEAR_AWARD_NUM)
end

function GuildDungeonClearAwardCell:_onClickReceive()
	g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetFinishAward({
		chapter_id = self._chapterId
	})
end

return GuildDungeonClearAwardCell
