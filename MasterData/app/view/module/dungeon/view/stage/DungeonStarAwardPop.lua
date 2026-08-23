local DungeonStarAwardPop = class("DungeonStarAwardPop", require("app.fairyGUI.dungeon.UI_DungeonStarAwardPop"), function()
	return fgui.GComponent:create({
		resName = "DungeonStarAwardPop",
		pkgPath = "ui/dungeon/dungeon",
		pkgName = "dungeon"
	}, ...)
end)
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.common.Scheduler
local var_0_4 = g.core.const.ConstMgr.DungeonConst
local var_0_5 = g.core.config.dungeon_chest_info
local var_0_6 = g.core.model.User.dungeonData

function DungeonStarAwardPop:ctor(arg_2_1)
	self._info = arg_2_1.chapterInfo
	self.rewardData = {}

	self:showAtCenter()
	var_0_2:dispatchEvent(var_0_1.EVENT_GUIDE_WAIT)
	var_0_3:newScheduleOnce(function()
		var_0_2:dispatchEvent(var_0_1.EVENT_GUIDE_READY)
	end, 0.2)
	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRendererAsync1(handler(self, self._onListRenderer), 0.02, false)
	self:_updateView()
end

function DungeonStarAwardPop:onLoad()
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_DUNGEON_GETCHAPTERCHESTAWARD, handler(self, self._onGetChapterChestAward), self)
end

function DungeonStarAwardPop:_updateRewardData()
	self.rewardData = {}

	for iter_5_0 = 1, var_0_4.MAX_STAR_CHEST_COUNT do
		if self._info["star_chest_" .. iter_5_0] > 0 then
			table.insert(self.rewardData, {
				chapterId = self._info.id,
				chestInfo = var_0_5.get(self._info["star_chest_" .. iter_5_0])
			})
		end
	end
end

function DungeonStarAwardPop:_updateView()
	self:_updateRewardData()

	local var_6_0 = var_0_6:getChapterStar(self._info.id)

	self._ownStarNum = var_6_0 or 0

	self.m_starTxt:setText(var_6_0)
	self.m_rewardList:setNumItems(#self.rewardData)
end

function DungeonStarAwardPop:_onListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateItem(self.rewardData[arg_7_1 + 1], arg_7_1, self._ownStarNum)
end

function DungeonStarAwardPop:_onGetChapterChestAward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:_updateView()
end

return DungeonStarAwardPop
