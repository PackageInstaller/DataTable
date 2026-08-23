local var_0_0 = g.core.model.User.themeData
local var_0_2 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local SummerThemeStarAwardCell = class("SummerThemeStarAwardCell", require("app.fairyGUI.summerTheme.UI_SummerThemeStarAwardCell"))

function SummerThemeStarAwardCell:ctor()
	self._awards = {}
	self._chapterId = 0
	self._activeThemeValue = nil

	self.m_getBtn:addClickListener(handler(self, self.onRewardClick))
	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
end

function SummerThemeStarAwardCell:updateItem(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._activeThemeValue = arg_2_5
	self._dungeonData = var_0_0:getThemeData(self._activeThemeValue):getDungeonData()
	self._boxInfo = arg_2_1
	self._dropId = self._boxInfo.dropId
	self._index = arg_2_2 + 1
	self._chapterId = arg_2_4

	self.m_rewardTitle:setText(g.core.lang:get(300024, {
		num = g.core.utils.Number.toChineseNumber(self._index)
	}))
	self.m_starTxt:setText(self._boxInfo.unlock)

	self._awards = g.core.common.Drops:getGoodsArray(self._dropId)

	self.m_rewardList:setNumItems(#self._awards)

	local var_2_1 = 0

	if self._dungeonData then
		var_2_1 = arg_2_3 >= self._boxInfo.unlock and 1 or 0

		if arg_2_3 >= self._boxInfo.unlock then
			var_2_1 = not self._dungeonData:isStarBoxOpened(self._chapterId, self._index) and 2 or 3
		else
			var_2_1 = 1

			self.m_starNum:setText("[color=#e52e2e]" .. arg_2_3 .. "[/color]" .. "/" .. self._boxInfo.unlock)
		end
	end

	self.m_rewardStateController:setSelectedIndex(var_2_1)
end

function SummerThemeStarAwardCell:_onListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function SummerThemeStarAwardCell:onRewardClick()
	local var_4_0 = self._dungeonData:getDungeonActivitySourceType()
	local var_4_1 = var_4_0 == var_0_2.CONFIG_TABLE and 1 or 0

	if not var_4_0 or not self._activeThemeValue then
		return
	end

	g.core.network.GameNetProxy:send_C2S_ThemeDungeon_GetChapterBox({
		recruit_type = var_4_1,
		act_id = self._activeThemeValue,
		chapter_id = self._chapterId,
		index = self._index
	})
end

return SummerThemeStarAwardCell
