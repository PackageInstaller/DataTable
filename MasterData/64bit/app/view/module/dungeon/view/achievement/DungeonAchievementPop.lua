local var_0_0 = g.core.config.dungeon_achievement_info
local var_0_1 = g.core.model.User.dungeonData
local DungeonAchievementPop = class("DungeonAchievementPop", require("app.fairyGUI.dungeon.UI_DungeonAchievementPop"), function()
	return fgui.GComponent:create({
		pkgName = "dungeon",
		resName = "DungeonAchievementPop"
	})
end)

function DungeonAchievementPop:ctor()
	self:showAtCenter()

	self._achieveId = var_0_1:getCurStarAchieveId()
	self._achieveInfo = var_0_0.get(self._achieveId)
	self._allAward = {}

	self:_initStarView()
	self:_updateStarView()
end

function DungeonAchievementPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FINISHACHIEVEMENT, self._onRcvFinishAchieve, self)
end

function DungeonAchievementPop:_initStarView()
	self.m_effectHolder:addEffectSpine({
		name = "eff_ui_dungeon_enter",
		anim = "play2",
		isLoop = false
	})
	self.m_enterTransition:play()
end

function DungeonAchievementPop:_updateStarView()
	local var_5_0 = var_0_1:getTotalStars()

	self.m_curStarText:setText(var_5_0 .. "/")
	self.m_maxStarText:setText(self._achieveInfo.star_6)

	local var_5_1 = 568
	local var_5_2 = {
		0,
		40,
		145,
		250,
		356,
		462,
		568
	}

	for iter_5_0 = 1, 6 do
		local var_5_3

		if iter_5_0 == 1 then
			var_5_3 = self._achieveInfo.star_start or self._achieveInfo["star_" .. iter_5_0 - 1]
		end

		local var_5_4 = self._achieveInfo["star_" .. iter_5_0]

		if var_5_3 <= var_5_0 and var_5_0 <= var_5_4 then
			var_5_1 = var_5_2[iter_5_0] + math.floor((var_5_2[iter_5_0 + 1] - var_5_2[iter_5_0]) * ((var_5_0 - var_5_3) / (var_5_4 - var_5_3)))

			break
		end
	end

	self.m_progressImg:setSize(var_5_1, 8)

	local var_5_5 = g.core.common.Goods:convert({
		type = self._achieveInfo.type_6,
		value = self._achieveInfo.value_6,
		size = self._achieveInfo.size_6
	})

	self.m_nextStarText:setText(math.max(0, self._achieveInfo.star_6 - var_5_0))
	self.m_maxAwardText:setText(var_5_5.size .. var_5_5.name)

	for iter_5_1 = 1, 6 do
		self["m_awardIcon" .. iter_5_1]:updateCell(g.core.common.Goods:convert({
			type = self._achieveInfo["type_" .. iter_5_1],
			value = self._achieveInfo["value_" .. iter_5_1],
			size = self._achieveInfo["size_" .. iter_5_1]
		}), self._achieveId, iter_5_1)
		self["m_starNum" .. iter_5_1]:setText(self._achieveInfo["star_" .. iter_5_1])
	end
end

function DungeonAchievementPop:_onRcvFinishAchieve(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = var_0_1:getAllCanGetAward(arg_6_3.id)

	for iter_6_0, iter_6_1 in ipairs(arg_6_3.awards) do
		table.insert(self._allAward, iter_6_1)
	end

	if #var_6_0 > 0 then
		self["m_awardIcon" .. var_6_0[1]]:onAutoClick()
	else
		self._allAward = {}

		g.core.module.ModuleManager:awardSummary((g.core.common.GlobalFunc.mergeAwards(self._allAward)))

		local var_6_1 = var_0_1:getCurStarAchieveId()

		if var_6_1 > 0 then
			self._achieveId = var_6_1
			self._achieveInfo = var_0_0.get(self._achieveId)
		end

		self:_updateStarView()
	end
end

return DungeonAchievementPop
