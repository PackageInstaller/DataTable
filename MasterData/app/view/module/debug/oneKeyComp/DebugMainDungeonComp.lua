local var_0_0 = g.core.model.User.dungeonData
local DebugMainDungeonComp = class("DebugMainDungeonComp", require("app.fairyGUI.debug.UI_DebugMainDungeonComp"))
local var_0_2 = {
	dungeon = 1,
	star = 2,
	none = 0
}

function DebugMainDungeonComp:ctor()
	self._stageList = nil
	self._curStyle = var_0_2.none
	self._starNotFullStageList = {}
	self._curStarIndex = 0
	self._stepStr = "."

	self:_init()
end

function DebugMainDungeonComp:_init()
	self.m_btn_challenge:addClickListener(handler(self, self._goDungeon))
	self.m_btn_starFull:addClickListener(handler(self, self._goStarFullDungeon))
end

function DebugMainDungeonComp:_goStarFullDungeon()
	if self._curStyle ~= var_0_2.none then
		return
	end

	self._curStyle = var_0_2.star
	self._starNotFullStageList = {}

	for iter_3_0, iter_3_1 in pairs(var_0_0._stages) do
		if iter_3_1:getStar() < 3 then
			table.insert(self._starNotFullStageList, iter_3_1)
		end
	end

	g.core.battle.BattleShowResult:disableAll()

	self._curStarIndex = 0

	self:_fightStarFull()
end

function DebugMainDungeonComp:_fightStarFull()
	if g.core.model.User.resourceData:getVit() < 5 then
		if g.core.model.User.bagData:getCountById(3, 1) <= 0 then
			self:showLog("体力不足!!!!!")

			return
		end

		g.core.network.GameNetProxy:send_C2S_Item_Use({
			id = 1,
			num = 1
		})

		self._curStyle = var_0_2.none

		return
	end

	self._curStarIndex = self._curStarIndex + 1

	if not self._starNotFullStageList[self._curStarIndex] then
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 1)
		self:showLog("扫荡完成")

		self._starNotFullStageList = {}
		self._curStyle = var_0_2.none

		return
	end

	g.core.network.GameNetProxy:send_C2S_Dungeon_ChallengeStageBegin({
		id = self._starNotFullStageList[self._curStarIndex]:getId()
	})
end

function DebugMainDungeonComp:_goDungeon()
	if self._curStyle ~= var_0_2.none then
		return
	end

	self._curStyle = var_0_2.dungeon

	local var_6_0 = g.core.config.dungeon_chapter_info.getLength()
	local var_6_1 = {}

	for iter_6_0 = 1, math.min(tonumber(self.m_challenge_input:getText()) or var_6_0, var_6_0) do
		local var_6_2 = g.core.config.dungeon_chapter_info.indexOf(iter_6_0)

		for iter_6_1 = 1, 10 do
			if var_6_2["stage_" .. iter_6_1] > 0 and not g.core.model.User.dungeonData:isStagePassed(var_6_2["stage_" .. iter_6_1]) then
				var_6_1[#var_6_1 + 1] = var_6_2["stage_" .. iter_6_1]
			end
		end
	end

	self._stageList = var_6_1
	self._fightIndex = 0

	g.core.battle.BattleShowResult:disableAll()
	self:_fightDungeon()
end

function DebugMainDungeonComp:_fightDungeon()
	if g.core.model.User.resourceData:getVit() < 5 then
		if g.core.model.User.bagData:getCountById(3, 1) <= 0 then
			self:showLog("体力不足!!!!!")

			return
		end

		g.core.network.GameNetProxy:send_C2S_Item_Use({
			id = 1,
			num = 1
		})

		self._curStyle = var_0_2.none

		return
	end

	self._fightIndex = self._fightIndex + 1

	if not self._stageList[self._fightIndex] then
		self:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
		end, 2)
		self:showLog("扫荡完成")

		self._stageList = nil
		self._curStyle = var_0_2.none

		return
	end

	self:showProgress(g.core.config.dungeon_stage_info.get(self._stageList[self._fightIndex]).chapter_id)
	g.core.network.GameNetProxy:send_C2S_Dungeon_ChallengeStageBegin({
		id = self._stageList[self._fightIndex]
	})
	self:showLog("挑战中 stageId = " .. self._stageList[self._fightIndex] .. " " .. self._stepStr)

	self._stepStr = self._stepStr .. "."

	if string.len(self._stepStr) >= 3 then
		self._stepStr = "."
	end
end

function DebugMainDungeonComp:showProgress(arg_9_1)
	self.m_challenge_progress:setText(arg_9_1)
end

function DebugMainDungeonComp:showLog(arg_10_1)
	self.m_challenge_log:setText(arg_10_1)
end

function DebugMainDungeonComp:BattleBegin(arg_11_1, arg_11_2, arg_11_3)
	g.core.battle.BattleProxy:fastBattle(arg_11_3.battle_id)
end

function DebugMainDungeonComp:BattleFinish(arg_12_1, arg_12_2, arg_12_3)
	if self._curStyle == var_0_2.dungeon then
		if arg_12_3.is_win then
			self:newScheduleOnce(function()
				self:_fightDungeon()
			end, 0.3)
		else
			self:showLog("打不过了！！！！")

			self._stageList = nil
			self._curStyle = var_0_2.none

			self:newScheduleOnce(function()
				g.core.battle.BattleShowResult:enableAll()
			end, 0.5)
		end
	elseif self._curStyle == var_0_2.star then
		if arg_12_3.is_win then
			self:newScheduleOnce(function()
				self:_fightStarFull()
			end, 0.3)
		else
			self:showLog("你竟然打输了！！！")

			self._starNotFullStageList = {}
			self._curStyle = var_0_2.none

			self:newScheduleOnce(function()
				g.core.battle.BattleShowResult:enableAll()
			end, 0.5)
		end
	else
		self:showLog("挑战终止")
	end
end

function DebugMainDungeonComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEBEGIN, self.BattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_CHALLENGESTAGEFINISH, self.BattleFinish, self)
end

function DebugMainDungeonComp:onShow()
	self:setVisible(true)
end

function DebugMainDungeonComp:onHide()
	if self._stageList and #self._stageList then
		self._stageList = {}
	end

	self:setVisible(false)
end

return DebugMainDungeonComp
