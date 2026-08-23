local var_0_0 = g.core.common.Goods
local BioConst = require("app.view.module.biography.const.BioConst")
local var_0_2 = g.core.model.User.shopData
local var_0_3 = {
	2038,
	2039,
	2084,
	2303,
	2331
}
local BioData = class("BioData", require("app.core.model.BaseData"))

function BioData:ctor()
	self:initData()
end

function BioData:initData()
	BioData.super.ctor(self)

	self._lands = {}
	self._chapters = {}
	self._chains = {}
	self._missions = {}
	self._campaigns = {}
	self._initedInfo = false
	self._missionConditions = {}
	self._chapterNew = true
	self._newAdvanture = {}
	self._newBranches = {}
	self._newFastLevel = nil
	self._chapterAwarded = {}
	self._campaignFinishInfo = nil
	self._team = {
		id = 0
	}
	self._inited = false
	self._friendCd = {}
	self._invitedInfo = {}
	self._invitedPass = {}
	self._unlockChapters = {}
	self._bossInfo = nil
	self._bossAwards = nil
	self._maxChapterId = nil
	self._mainMissionId = nil
	self._finishNewMission = false
	self._inviteTeamData = {
		{},
		{}
	}
	self._joinTeamData = {}
	self._isEnterBattle = false
	self._attackTimeDict = {}
	self._inviteeListConnectTime = 0
	self._roomTimeMap = {}
	self._displayVersion = 1
	self._fastData = require("app.view.module.biography.model.BioFastData").new()
end

function BioData:initInfo()
	if self._initedInfo then
		return
	end

	self._initedInfo = true

	for iter_3_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_3_0 = g.core.config.biography_team_info.indexOf(iter_3_0).toObject()

		var_3_0.finish = false
		var_3_0.fighting = false
		self._campaigns[var_3_0.id] = var_3_0
	end

	local function var_3_1(arg_4_0, arg_4_1)
		if arg_4_1 == "unlock" then
			local var_4_0 = self:getMission(arg_4_0.preset)
			local var_4_1 = self:getChain(arg_4_0.chain)

			if (var_4_1.type == 1 or var_4_1.type == 2 and var_4_1.if_order == 1) and var_4_0 and not var_4_0.finish then
				return false
			end

			if not self:checkUnlock(arg_4_0.preset_type_1, arg_4_0.preset_value_1) then
				return false, 1
			end

			if not self:checkUnlock(arg_4_0.preset_type_2, arg_4_0.preset_value_2) then
				return false, 2
			end

			if not self:checkUnlock(arg_4_0.preset_type_3, arg_4_0.preset_value_3) then
				return false, 3
			end

			if not self:checkUnlock(arg_4_0.preset_type_4, arg_4_0.preset_value_4) then
				return false, 4
			end

			if not self:checkUnlock(arg_4_0.preset_type_5, arg_4_0.preset_value_5) then
				return false, 5
			end

			return true
		elseif arg_4_1 == "unlockType" then
			if not arg_4_0.unlock then
				local var_4_2 = self:getMission(arg_4_0.preset)
				local var_4_3 = self:getChain(arg_4_0.chain)

				if (var_4_3.type == 1 or var_4_3.type == 2 and var_4_3.if_order == 1) and var_4_2 and not var_4_2.finish then
					return 0
				end

				if not self:checkUnlock(arg_4_0.preset_type_1, arg_4_0.preset_value_1) then
					return 1
				end

				if not self:checkUnlock(arg_4_0.preset_type_2, arg_4_0.preset_value_2) then
					return 2
				end

				if not self:checkUnlock(arg_4_0.preset_type_3, arg_4_0.preset_value_3) then
					return 3
				end

				if not self:checkUnlock(arg_4_0.preset_type_4, arg_4_0.preset_value_4) then
					return 4
				end

				if not self:checkUnlock(arg_4_0.preset_type_5, arg_4_0.preset_value_5) then
					return 5
				end
			end

			return 0
		elseif arg_4_1 == "canShow" then
			return (not arg_4_0.finish or nil) and (self:checkUnlock(arg_4_0.unlock_seen_type, arg_4_0.unlock_seen_value) or arg_4_0.finish and arg_4_0.conceal == 0)
		elseif arg_4_1 == "canTrigger" then
			return arg_4_0.unlock and (not arg_4_0.finish or arg_4_0.repeatable == 1)
		end
	end

	for iter_3_1 = 1, g.core.config.biography_mission_info.getLength() do
		local var_3_2 = g.core.config.biography_mission_info.indexOf(iter_3_1).toObject()

		var_3_2.finish = false
		var_3_2.fighting = false
		var_3_2.next = 0
		var_3_2.preset = 0
		var_3_2.chain = 0
		var_3_2.index = 0
		var_3_2.isLast = false
		var_3_2.isFirst = false
		var_3_2.attack_count = 0
		var_3_2.reset_count = 0
		var_3_2.max = 1
		var_3_2.value = 0
		self._missions[var_3_2.id] = var_3_2

		setmetatable(var_3_2, {
			__index = var_3_1
		})
	end

	for iter_3_2 = 1, g.core.config.biography_mission_chain_info.getLength() do
		local var_3_3 = g.core.config.biography_mission_chain_info.indexOf(iter_3_2).toObject()

		var_3_3.finish = false
		var_3_3.fighting = false
		var_3_3.current = 1
		var_3_3.chapter = 0
		var_3_3.missions = {}

		local var_3_4 = 0

		for iter_3_3 = 1, 20 do
			if var_3_3["mission_" .. iter_3_3] and var_3_3["mission_" .. iter_3_3] > 0 then
				var_3_3.missions[iter_3_3] = var_3_3["mission_" .. iter_3_3]

				if var_3_4 == 0 then
					var_3_3.firstMissionId = var_3_3["mission_" .. iter_3_3]
					self._missions[var_3_3["mission_" .. iter_3_3]].isFirst = true
				end

				assert(self._missions[var_3_3["mission_" .. iter_3_3]], "cannot find mission id " .. var_3_3["mission_" .. iter_3_3])

				self._missions[var_3_3["mission_" .. iter_3_3]].chain = var_3_3.id
				self._missions[var_3_3["mission_" .. iter_3_3]].index = iter_3_3

				if var_3_4 > 0 then
					assert(self._missions[var_3_4], "cannot find mission id " .. var_3_4)

					self._missions[var_3_3["mission_" .. iter_3_3]].preset = var_3_4
					self._missions[var_3_4].next = var_3_3["mission_" .. iter_3_3]
				end

				var_3_4 = var_3_3["mission_" .. iter_3_3]
			end
		end

		var_3_3.lastMissionId = var_3_4
		self._missions[var_3_4].isLast = true
		self._chains[var_3_3.id] = var_3_3
	end

	local function var_3_5(arg_5_0, arg_5_1)
		if arg_5_1 == "unlock" then
			local var_5_0 = self:getChapter(arg_5_0.preset)

			if var_5_0 and not var_5_0.finish then
				return false
			end

			if arg_5_0.dungeon_chapter_open > 0 then
				local var_5_1 = g.core.model.User.dungeonData:getChapter(arg_5_0.dungeon_chapter_open)

				if var_5_1 and not var_5_1:isPassed() then
					return false
				end
			end

			return true
		end
	end

	for iter_3_4 = 1, g.core.config.biography_chapter_info.getLength() do
		local var_3_6 = g.core.config.biography_chapter_info.indexOf(iter_3_4)
		local var_3_7 = var_3_6.toObject()

		var_3_7.finish = false
		var_3_7.perfect = false
		var_3_7.fighting = false
		var_3_7.land = 0
		var_3_7.index = 0
		var_3_7.preset = 0
		var_3_7.next = 0
		var_3_7.isLast = false
		var_3_7.progressAwarded = false
		var_3_7.res = {}
		var_3_7.chains = {}
		var_3_7.chains[1] = var_3_6.mission_chain_main

		assert(self._chains[var_3_6.mission_chain_main], "cannot find chain id " .. var_3_6.mission_chain_main)

		self._chains[var_3_6.mission_chain_main].chapter = var_3_7.id

		for iter_3_5 = 1, 10 do
			if var_3_7["mission_chain_branch_" .. iter_3_5] and var_3_7["mission_chain_branch_" .. iter_3_5] > 0 then
				var_3_7.chains[iter_3_5 + 1] = var_3_7["mission_chain_branch_" .. iter_3_5]

				assert(self._chains[var_3_7["mission_chain_branch_" .. iter_3_5]], "cannot find chain id " .. var_3_7["mission_chain_branch_" .. iter_3_5])

				self._chains[var_3_7["mission_chain_branch_" .. iter_3_5]].chapter = var_3_7.id
			end
		end

		self._chapters[var_3_7.id] = var_3_7

		for iter_3_6, iter_3_7 in ipairs(var_3_7.chains) do
			for iter_3_8, iter_3_9 in ipairs(self:getChain(iter_3_7).missions) do
				local var_3_8 = self:getMission(iter_3_9).mission_resource

				if var_3_7.res[var_3_8] then
					var_3_7.res[var_3_8][#var_3_7.res[var_3_8] + 1] = iter_3_9
				else
					var_3_7.res[var_3_8] = {
						iter_3_9
					}
				end
			end
		end

		if var_3_7.dungeon_chapter_open > 0 then
			self._unlockChapters[var_3_7.dungeon_chapter_open] = self._unlockChapters[var_3_7.dungeon_chapter_open] or {}
			self._unlockChapters[var_3_7.dungeon_chapter_open][#self._unlockChapters[var_3_7.dungeon_chapter_open] + 1] = var_3_7.id
		end

		setmetatable(var_3_7, {
			__index = var_3_5
		})
	end

	local var_3_9 = g.core.config.biography_land_info.getLength()

	for iter_3_10 = 1, var_3_9 do
		local var_3_10 = g.core.config.biography_land_info.indexOf(iter_3_10).toObject()

		var_3_10.finish = false
		var_3_10.fighting = false
		var_3_10.current = 0
		var_3_10.preset = 0
		var_3_10.next = 0
		var_3_10.chapters = {}

		local var_3_11 = 0

		for iter_3_11 = 1, 5 do
			if var_3_10["chapter_" .. iter_3_11] and var_3_10["chapter_" .. iter_3_11] > 0 then
				var_3_10.chapters[iter_3_11] = var_3_10["chapter_" .. iter_3_11]

				assert(self._chapters[var_3_10["chapter_" .. iter_3_11]], "cannot find chapter id " .. var_3_10["chapter_" .. iter_3_11])

				self._chapters[var_3_10["chapter_" .. iter_3_11]].land = var_3_10.id
				self._chapters[var_3_10["chapter_" .. iter_3_11]].index = iter_3_11

				if var_3_11 > 0 then
					assert(self._chapters[var_3_11], "cannot find chapter id " .. var_3_11)

					self._chapters[var_3_10["chapter_" .. iter_3_11]].preset = var_3_11
					self._chapters[var_3_11].next = var_3_10["chapter_" .. iter_3_11]
				end

				var_3_11 = var_3_10["chapter_" .. iter_3_11]
			end
		end

		var_3_10.last = var_3_11
		self._chapters[var_3_11].isLast = true

		if var_3_10.biography_team > 0 and self._campaigns[var_3_10.biography_team] then
			self._campaigns[var_3_10.biography_team].land = var_3_10.id
		end

		self._lands[var_3_10.id] = var_3_10

		if iter_3_10 > 1 then
			var_3_10.preset = iter_3_10 - 1
		end

		if iter_3_10 < var_3_9 then
			var_3_10.next = iter_3_10 + 1
		end
	end

	self._lands[1].fighting = true
	self._lands[1].current = 1
	self:getChapter(self._lands[1].chapters[1]).fighting = true
end

function BioData:checkUnlock(arg_6_1, arg_6_2)
	if arg_6_1 == 36 then
		local var_6_0 = self:getMission(arg_6_2)

		assert(var_6_0, "can not find mission " .. arg_6_2 .. " as preset")

		return var_6_0.finish
	elseif arg_6_1 == 37 then
		return g.core.model.User.bagData:isOwnItem(g.core.common.Goods.TYPE_BIO, arg_6_2)
	elseif arg_6_1 == 38 then
		return g.core.model.User.knightsData:hasKnightByAdvanceId(arg_6_2)
	elseif arg_6_1 == 39 then
		return g.core.model.User.UniteTokenData:hasLineupTokenById(arg_6_2)
	elseif arg_6_1 == 40 then
		return g.core.model.User:getDressId() == arg_6_2
	elseif arg_6_1 == 41 then
		return arg_6_2 <= g.core.model.User:getFightValue()
	elseif arg_6_1 == 1 then
		return arg_6_2 <= g.core.model.User:getLevel()
	elseif arg_6_1 == 42 then
		if not self._missionConditions[42] then
			return false
		end

		return arg_6_2 <= self._missionConditions[42]
	elseif arg_6_1 == 3 then
		if not self._missionConditions[3] or self._missionConditions[3] == 0 then
			return false
		end

		return arg_6_2 >= self._missionConditions[3]
	elseif arg_6_1 == 4 then
		if not self._missionConditions[4] then
			return false
		end

		return arg_6_2 <= self._missionConditions[4]
	elseif arg_6_1 == 5 then
		if not self._missionConditions[5] then
			return false
		end

		return arg_6_2 <= self._missionConditions[5]
	end

	return true
end

function BioData:getUnlockDesc(arg_7_1, arg_7_2)
	if arg_7_1 == 36 then
		return g.core.lang:get(1023, {
			name = self:getMission(arg_7_2).name
		})
	elseif arg_7_1 == 37 then
		return g.core.lang:get(1026, {
			name = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_BIO,
				value = arg_7_2
			}).name
		})
	elseif arg_7_1 == 38 then
		return g.core.lang:get(1027, {
			name = g.core.model.User.knightsData:getKnightInfoByAdvanceId(arg_7_2).name
		})
	elseif arg_7_1 == 39 then
		return g.core.lang:get(1028, {
			name = g.core.config.unite_token_info.get(arg_7_2).name
		})
	elseif arg_7_1 == 40 then
		return g.core.lang:get(1029, {
			name = g.core.config.dress_info.get(arg_7_2).name
		})
	elseif arg_7_1 == 41 then
		return g.core.lang:get(1030, {
			num = arg_7_2
		})
	elseif arg_7_1 == 1 then
		return g.core.lang:get(1031, {
			num = arg_7_2
		})
	elseif arg_7_1 == 42 then
		return g.core.lang:get(1032, {
			name = g.core.config.dungeon_chapter_info.get(arg_7_2).name
		})
	elseif arg_7_1 == 3 then
		return g.core.lang:get(1033, {
			num = arg_7_2
		})
	elseif arg_7_1 == 4 then
		return g.core.lang:get(1024, {
			num = arg_7_2
		})
	elseif arg_7_1 == 5 then
		return g.core.lang:get(1025, {
			num = arg_7_2
		})
	end
end

function BioData:getChapterCurPro(arg_8_1)
	local var_8_0 = self:getChapter(arg_8_1)
	local var_8_1 = 0

	for iter_8_0 = 2, #var_8_0.chains do
		for iter_8_1, iter_8_2 in ipairs(self:getChain(var_8_0.chains[iter_8_0]).missions) do
			local var_8_2 = self:getMission(iter_8_2)

			if var_8_2.finish then
				var_8_1 = var_8_1 + var_8_2.weight
			end
		end
	end

	return var_8_1
end

function BioData:getChapterMaxPro(arg_9_1)
	local var_9_0 = self:getChapter(arg_9_1)
	local var_9_1 = 0

	for iter_9_0 = 2, #var_9_0.chains do
		for iter_9_1, iter_9_2 in ipairs(self:getChain(var_9_0.chains[iter_9_0]).missions) do
			var_9_1 = var_9_1 + self:getMission(iter_9_2).weight
		end
	end

	return var_9_1
end

function BioData:getMaxChapterId()
	return self._maxChapterId
end

function BioData:updateMissionInfo(arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	local var_11_0 = self._missions[arg_11_1.id]

	if not self._missions[arg_11_1.id] then
		return
	end

	self:initInfo()

	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = self:getChain(var_11_0.chain)
	local var_11_4 = self:getChapter(var_11_3.chapter)
	local var_11_5 = var_11_3.id - math.floor(var_11_3.id / 1000) * 1000 == 1

	if arg_11_1.finish then
		if self._mainMissionId and var_11_5 then
			if arg_11_1.id >= self._mainMissionId then
				self._mainMissionId = arg_11_1.id
			end
		elseif var_11_5 then
			self._mainMissionId = arg_11_1.id
		end
	end

	if self._mainMissionId then
		-- block empty
	end

	if not self._maxChapterId or self._maxChapterId < var_11_4.id then
		self._maxChapterId = var_11_4.id
	end

	if arg_11_2 then
		local var_11_6 = self:getChapter(self:getChain(var_11_0.chain).chapter)

		for iter_11_0 = 2, #var_11_6.chains do
			local var_11_7 = self:getChain(var_11_6.chains[iter_11_0])

			if var_11_7.type == 3 then
				for iter_11_1, iter_11_2 in ipairs(var_11_7.missions) do
					if self:getMission(iter_11_2).unlock then
						var_11_1[iter_11_2] = 1
					end
				end
			end

			if var_11_7.type == 2 and self:getMission(var_11_7.missions[1]).unlock then
				var_11_2[var_11_7.missions[1]] = 1
			end

			if var_11_7.type == 4 and self:getMission(var_11_7.missions[1]).unlock then
				var_11_2[var_11_7.missions[1]] = 1
			end
		end

		self._newFastLevel = nil

		if not var_11_0.finish and arg_11_1.finish and var_11_0.type == 1 and var_11_0.repeatable == 1 then
			self._newFastLevel = var_11_0
		end
	end

	if not var_11_0.finish and arg_11_1.finish then
		self._finishNewMission = true
		self._finishNewMissionInfo = var_11_0
	end

	var_11_0.finish = arg_11_1.finish
	var_11_0.attack_count = arg_11_1.attack_count or 0
	var_11_0.reset_count = arg_11_1.reset_count or 0

	if var_11_0.finish then
		self._chapterNew = false
		var_11_0.value = var_11_0.max

		if var_11_0.next > 0 then
			if not self._missions[var_11_0.next].finish then
				self._missions[var_11_0.next].fighting = true
			end

			self._chains[self._missions[var_11_0.next].chain].current = math.max(self._missions[var_11_0.next].index, self._chains[self._missions[var_11_0.next].chain].current)
		else
			local var_11_8 = self._chains[var_11_0.chain]

			var_11_8.finish = true
			var_11_8.fighting = false

			if var_11_8.type == 1 then
				self._chapters[var_11_8.chapter].finish = true
				self._chapters[var_11_8.chapter].fighting = false

				if self._chapters[var_11_8.chapter].next > 0 then
					if not self._chapters[self._chapters[var_11_8.chapter].next].finish then
						self._chapters[self._chapters[var_11_8.chapter].next].fighting = true
						self._lands[self._chapters[self._chapters[var_11_8.chapter].next].land].current = math.max(self._chapters[self._chapters[var_11_8.chapter].next].index, self._lands[self._chapters[self._chapters[var_11_8.chapter].next].land].current)
					end
				end

				if self._chapters[var_11_8.chapter].isLast then
					self._lands[self._chapters[var_11_8.chapter].land].finish = true
					self._lands[self._chapters[var_11_8.chapter].land].fighting = false

					if self._lands[self._chapters[var_11_8.chapter].land].next > 0 then
						if not self._lands[self._lands[self._chapters[var_11_8.chapter].land].next].finish then
							self._lands[self._lands[self._chapters[var_11_8.chapter].land].next].fighting = true

							if not self._chapters[self._lands[self._lands[self._chapters[var_11_8.chapter].land].next].chapters[1]].finish then
								self._chapters[self._lands[self._lands[self._chapters[var_11_8.chapter].land].next].chapters[1]].fighting = true
							end
						end
					end
				end
			end

			local var_11_9 = true

			for iter_11_3, iter_11_4 in ipairs(self._chapters[var_11_8.chapter].chains) do
				var_11_9 = var_11_9 and self._chains[iter_11_4].finish
			end

			if var_11_9 then
				self._chapters[var_11_8.chapter].perfect = true
			end
		end

		var_11_0.fighting = false
	end

	if arg_11_2 then
		self._newAdvanture = {}
		self._newBranches = {}

		local var_11_10 = self:getChapter(self:getChain(var_11_0.chain).chapter)

		for iter_11_5 = 1, #var_11_10.chains do
			local var_11_11 = self:getChain(var_11_10.chains[iter_11_5])

			if var_11_11.type == 3 then
				for iter_11_6, iter_11_7 in ipairs(var_11_11.missions) do
					if self:getMission(iter_11_7).unlock and var_11_1[iter_11_7] == nil then
						self._newAdvanture[#self._newAdvanture + 1] = iter_11_7
					end
				end
			end

			if var_11_11.type == 2 and self:getMission(var_11_11.missions[1]).unlock and var_11_2[var_11_11.missions[1]] == nil then
				self._newBranches[#self._newBranches + 1] = var_11_11
			end

			if var_11_11.type == 4 and self:getMission(var_11_11.missions[1]).unlock and var_11_2[var_11_11.missions[1]] == nil then
				self._newBranches[#self._newBranches + 1] = var_11_11
			end
		end
	end

	self._fastData:addMission(var_11_0)
end

function BioData:updateCampainInfos(arg_12_1)
	self:initInfo()

	for iter_12_0 = 1, #arg_12_1 do
		self._campaigns[arg_12_1[iter_12_0].id].finish = arg_12_1[iter_12_0].finish
		self._campaigns[arg_12_1[iter_12_0].id].award = arg_12_1[iter_12_0].award
	end
end

function BioData:updateCampainFinish(arg_13_1)
	if arg_13_1.is_win then
		self._campaigns[arg_13_1.id].finish = true
		self._campaignFinishInfo = arg_13_1
	end
end

function BioData:isCampainOpen(arg_14_1)
	local var_14_0 = self:getCampaign(arg_14_1)

	if not var_14_0 then
		return false
	end

	local var_14_1 = true
	local var_14_2
	local var_14_3 = var_14_0.preset_level

	if var_14_0.preset_level > 0 and var_14_3 > g.core.model.User:getLevel() then
		var_14_1 = false
		var_14_2 = g.core.lang:get(302094, {
			num = var_14_3
		})
	end

	if not var_14_1 then
		return var_14_1, var_14_2
	elseif var_14_0.preset_team > 0 and not self:getCampaign(var_14_0.preset_team).finish then
		var_14_1 = false
		var_14_2 = g.core.lang:get(302090)
	end

	return var_14_1, var_14_2
end

function BioData:updateMainInfo(arg_15_1)
	self._inited = true

	self:initInfo()

	if arg_15_1.missions then
		for iter_15_0 = 1, #arg_15_1.missions do
			self:updateMissionInfo(arg_15_1.missions[iter_15_0])
		end
	end

	if arg_15_1.campaigns then
		self:updateCampainInfos(arg_15_1.campaigns)
	end

	if arg_15_1.mission_progress_awarded then
		for iter_15_1, iter_15_2 in ipairs(arg_15_1.mission_progress_awarded) do
			self:gotProgressAward(iter_15_2)
		end
	end

	if arg_15_1.chapter_awarded then
		self._chapterAwarded = arg_15_1.chapter_awarded
	end

	self._finishNewMission = false
	self._finishNewMissionInfo = nil
end

function BioData:hasChapterAwarded(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._chapterAwarded) do
		if iter_16_1 == arg_16_1 then
			return true
		end
	end
end

function BioData:getAchieveLand()
	local var_17_0 = self:getLands()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1.chapters) do
			if not self:hasChapterAwarded(iter_17_3) then
				return iter_17_0
			end
		end
	end

	return #var_17_0
end

function BioData:hasAchieveAward()
	for iter_18_0, iter_18_1 in ipairs(self._chapters) do
		if iter_18_1.finish and not self:hasChapterAwarded(iter_18_1.id) then
			return true
		end
	end

	return false
end

function BioData:gotChapterAward(arg_19_1)
	self._chapterAwarded[#self._chapterAwarded + 1] = arg_19_1
end

function BioData:updatePresetCondition(arg_20_1)
	if arg_20_1 and next(arg_20_1) then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			self._missionConditions[iter_20_1.id] = iter_20_1.num
		end
	end
end

function BioData:gotProgressAward(arg_21_1)
	self:getChapter(arg_21_1).progressAwarded = true
end

function BioData:isInited()
	return self._inited
end

function BioData:getMaxMainMissionId()
	return self._mainMissionId
end

function BioData:getCurLandIndex()
	self:initInfo()

	local var_24_0 = 0

	for iter_24_0, iter_24_1 in ipairs(self._lands) do
		if iter_24_1.fighting then
			return iter_24_1.id
		end

		if iter_24_1.finish and var_24_0 < iter_24_1.id then
			var_24_0 = iter_24_1.id
		end
	end

	return var_24_0
end

function BioData:getCurChaptersIndex()
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self._chapters) do
		if iter_25_1.fighting then
			return iter_25_1.id
		end

		var_25_0 = iter_25_1.id
	end

	return var_25_0
end

function BioData:getMissionRewardBuyCharpter(arg_26_1, arg_26_2)
	local var_26_0 = self:getChapter(self:getCanFastCharBuyCharpter(arg_26_1, arg_26_2))
	local var_26_1 = {}

	if var_26_0 == nil then
		return var_26_1
	end

	local function var_26_2(arg_27_0)
		if arg_27_0.type == 3 then
			for iter_27_0, iter_27_1 in ipairs(var_0_3) do
				if iter_27_1 == arg_27_0.value then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0.chains) do
		for iter_26_2, iter_26_3 in ipairs(self:getChain(iter_26_1).missions) do
			local var_26_3 = self:getMission(iter_26_3)

			if var_26_3.type == 1 and var_26_3.repeatable == 1 and var_26_3.reward_drop > 0 then
				for iter_26_4, iter_26_5 in ipairs(g.core.common.Drops:getGoodsArray(var_26_3.reward_drop)) do
					if iter_26_5.type == 2 or var_26_2(iter_26_5) then
						iter_26_5.finish = var_26_3.finish
						iter_26_5.mid = var_26_3.id

						table.insert(var_26_1, iter_26_5)
					end
				end
			end
		end
	end

	return var_26_1
end

function BioData:isHaveFinishMission(arg_28_1)
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(self:getChapter(arg_28_1).chains) do
		for iter_28_2, iter_28_3 in ipairs(self:getChain(iter_28_1).missions) do
			local var_28_1 = self:getMission(iter_28_3)

			if var_28_1.type == 1 and var_28_1.repeatable == 1 and var_28_1.reward_drop > 0 then
				for iter_28_4, iter_28_5 in ipairs(g.core.common.Drops:getGoodsArray(var_28_1.reward_drop)) do
					if iter_28_5.type == 2 and var_28_1.finish then
						var_28_0 = true
					end
				end
			end
		end
	end

	return var_28_0
end

function BioData:getCanFastCharBuyCharpter(arg_29_1, arg_29_2)
	if arg_29_2 then
		return arg_29_1
	end

	for iter_29_0 = arg_29_1, 1, -1 do
		if self:isHaveFinishMission(iter_29_0) then
			arg_29_1 = iter_29_0

			break
		end
	end

	return arg_29_1
end

function BioData:getLandBuyCharpter(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(self._chapters) do
		if iter_30_1.id == arg_30_1 then
			return iter_30_1.land
		end
	end
end

function BioData:getBioChapterInfoByDungeonChapterId(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(self._chapters) do
		if iter_31_1.dungeon_chapter_open == arg_31_1 then
			return iter_31_1
		end
	end

	return nil
end

function BioData:checkHasNewChapterOpen()
	local var_32_0 = self:getCurChaptersIndex()

	if var_32_0 > 0 then
		local var_32_1 = self:getChapter(var_32_0)

		if var_32_1.finish then
			return false
		end

		if var_32_1.dungeon_chapter_open > 0 then
			local var_32_2 = g.core.model.User.dungeonData:getChapter(var_32_1.dungeon_chapter_open)

			if var_32_2 and not var_32_2:isPassed() then
				return false
			end
		end

		local var_32_3 = g.core.common.Storage:load("biography.json") or {}

		var_32_3.storys = var_32_3.storys or {}

		for iter_32_0, iter_32_1 in ipairs(var_32_3.storys) do
			if iter_32_1 == var_32_1.story then
				return false
			end
		end

		return true
	end

	return false
end

function BioData:getLands()
	self:initInfo()

	return self._lands
end

function BioData:getLand(arg_34_1)
	if not arg_34_1 then
		return
	end

	self:initInfo()

	return self._lands[arg_34_1]
end

function BioData:getChapter(arg_35_1)
	if not arg_35_1 then
		assert(arg_35_1, "error chapter id: " .. arg_35_1)

		return
	end

	self:initInfo()
	assert(self._chapters[arg_35_1], "cannot find chapter info, id is " .. arg_35_1)

	return self._chapters[arg_35_1]
end

function BioData:getMission(arg_36_1)
	if not arg_36_1 then
		return
	end

	self:initInfo()

	return self._missions[arg_36_1]
end

function BioData:getChain(arg_37_1)
	if not arg_37_1 then
		return
	end

	self:initInfo()

	return self._chains[arg_37_1]
end

function BioData:getCampaign(arg_38_1)
	if not arg_38_1 then
		return
	end

	self:initInfo()

	return self._campaigns[arg_38_1]
end

function BioData:getMissionLeftCount(arg_39_1)
	self:initInfo()

	local var_39_0 = self:getMission(arg_39_1)

	return var_39_0.attempts - var_39_0.attack_count, var_39_0.attempts
end

function BioData:getTeamInfo()
	return self._team
end

function BioData:updateTeamInfo(arg_41_1)
	if config.SHOW_BETA_FEEDBACK_BOARD then
		local var_41_0 = g.core.platform.ServerListProxy:getSelectedServer().sid

		if self._team.id ~= 0 and self._team.id ~= arg_41_1.id or self._team.id ~= 0 and arg_41_1.id == 0 then
			g.core.platform.PlatformProxy:imLeaveRoom(tostring(var_41_0) .. tostring(self._team.id))
		end

		if arg_41_1.id ~= 0 and self._team.id ~= arg_41_1.id then
			g.core.platform.PlatformProxy:imJoinRoom(tostring(var_41_0) .. tostring(arg_41_1.id))
		end
	end

	self._team = arg_41_1
end

function BioData:isActiveTime(arg_42_1)
	local var_42_0 = g.core.config.time_event_info.get(1, arg_42_1)

	return g.core.common.ServerTime:checkTimeArea(var_42_0.open_time, var_42_0.end_time)
end

function BioData:getAddition()
	local var_43_0 = self:getTeamInfo()

	return ((var_43_0.online_addition or 0) + (var_43_0.friend_addition or 0) + (var_43_0.guild_addition or 0)) / 10 + ((self:isActiveTime(1) or self:isActiveTime(2)) and 100 or 0)
end

function BioData:getFriendCd(arg_44_1)
	if self._friendCd[arg_44_1] then
		return self._friendCd[arg_44_1] - g.core.common.ServerTime:getTime()
	end
end

function BioData:onInviteFriend(arg_45_1)
	self._friendCd[arg_45_1.invitee_id] = g.core.common.ServerTime:getTime() + g.core.config.parameter_info.get(3004).parameter
end

function BioData:getInvitedInfo()
	return self._invitedInfo
end

function BioData:isInvited()
	for iter_47_0, iter_47_1 in ipairs(self._invitedInfo) do
		if iter_47_1.invite_time ~= self._invitedPass[iter_47_1.team_id] then
			return true
		end
	end

	return false
end

function BioData:addInvited(arg_48_1)
	self._invitedInfo[#self._invitedInfo + 1] = arg_48_1
end

function BioData:delInvited(arg_49_1)
	self:confirmInvited(arg_49_1)
end

function BioData:updateInvited(arg_50_1)
	if arg_50_1 then
		local var_50_0 = clone(self._invitedPass)

		for iter_50_0, iter_50_1 in ipairs(arg_50_1) do
			if iter_50_1.invite_time == var_50_0[iter_50_1.team_id] then
				var_50_0[iter_50_1.team_id] = nil
			end
		end

		for iter_50_2, iter_50_3 in pairs(var_50_0) do
			if iter_50_3 then
				self._invitedPass[iter_50_2] = nil
			end
		end

		self._invitedInfo = arg_50_1
	else
		self._invitedInfo = {}
		self._invitedPass = {}
	end
end

function BioData:confirmInvited(arg_51_1)
	for iter_51_0 = #self._invitedInfo, 1, -1 do
		if self._invitedInfo[iter_51_0].team_id == arg_51_1 then
			self._invitedPass[arg_51_1] = nil

			table.remove(self._invitedInfo, iter_51_0)
		end
	end
end

function BioData:updateInvitedPass(arg_52_1)
	self._invitedPass[arg_52_1.team_id] = arg_52_1.invite_time
end

function BioData:getInvitedPass()
	return self._invitedPass
end

function BioData:updateRedInfo(arg_54_1)
	if not arg_54_1.biography_hint then
		return
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		self:updateMainInfo(arg_54_1.biography_hint)
		self:updateInvited(arg_54_1.biography_hint.invitations)
	end
end

function BioData:updateBossInfo(arg_55_1, arg_55_2, arg_55_3)
	arg_55_3 = arg_55_3 or false

	if not arg_55_3 then
		if not arg_55_1 or arg_55_1 and arg_55_1.base_id == 0 then
			self._bossInfo = nil

			return
		end

		local var_55_0 = 0

		if not self._bossInfo then
			local var_55_1 = g.core.config.biography_boss_info.get(arg_55_1.base_id)
			local var_55_2 = g.core.config.monster_team_info.get(var_55_1.monster_team_id, 1)

			for iter_55_0 = 1, 6 do
				if var_55_2["monster_" .. iter_55_0] ~= 0 then
					var_55_0 = var_55_0 + g.core.config.monster_info.get(var_55_2["monster_" .. iter_55_0]).initial_hp
				end
			end

			arg_55_1.totalHP = var_55_0
			self._bossInfo = var_55_1.toObject()
		else
			var_55_0 = self._bossInfo.totalHP
		end

		local var_55_3 = self._bossInfo.curHp or var_55_0

		arg_55_1.curHp = math.uint64_max(math.uint64_sub(var_55_0, arg_55_1.hp), 0)
		arg_55_1.damageHp = var_55_3 - arg_55_1.curHp
		arg_55_1.isKill = false
		self._bossInfo.is_first = false

		for iter_55_1, iter_55_2 in pairs(arg_55_1) do
			self._bossInfo[iter_55_1] = iter_55_2
		end

		if self._bossInfo.is_first then
			local var_55_4 = g.core.common.Storage:load("biography_boss.json") or {}

			if var_55_4.boss and var_55_4.boss == arg_55_1.base_id then
				self._bossInfo.is_first = false
			end
		end
	else
		self._bossInfo.damageHp = self._bossInfo.curHp
		self._bossInfo.curHp = 0
		self._bossInfo.isKill = true
	end

	self._bossInfo.damage = arg_55_2 or {}
end

function BioData:updateBossAwards(arg_56_1, arg_56_2)
	self._bossAwards = arg_56_1
	arg_56_2 = arg_56_2 or {}

	for iter_56_0, iter_56_1 in ipairs(arg_56_2) do
		iter_56_1.isRare = true
		self._bossAwards[#self._bossAwards + 1] = iter_56_1
	end
end

function BioData:getBossInfo()
	return self._bossInfo
end

function BioData:getBossAwards()
	return self._bossAwards
end

function BioData:isNew()
	return self._chapterNew
end

function BioData:getNewAdvanture()
	return self._newAdvanture
end

function BioData:getNewBranchTask()
	return self._newBranches
end

function BioData:getNewUnlcokFast()
	return self._newFastLevel
end

function BioData:getUnlockChapters(arg_63_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		return
	end

	self:initInfo()

	return self._unlockChapters[arg_63_1]
end

function BioData:isUniteTokenPopTip()
	return (g.core.common.Storage:load("biounitetoken_tip_config.json") or {}).tip or false
end

function BioData:setUniteTokenPopTip(arg_65_1)
	g.core.common.Storage:save("biounitetoken_tip_config.json", {
		tip = arg_65_1
	})
end

function BioData:getShowCampaignId()
	local var_66_0 = {}
	local var_66_1 = {}
	local var_66_2 = {}

	for iter_66_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_66_3 = g.core.config.biography_team_info.indexOf(iter_66_0).id

		if var_66_3 > 0 then
			local var_66_4 = g.core.model.User.bioData:getCampaign(var_66_3)

			if var_66_4.award then
				table.insert(var_66_0, var_66_3)
			elseif var_66_4.finish then
				table.insert(var_66_1, var_66_3)
			else
				table.insert(var_66_2, var_66_3)
			end
		end
	end

	if #var_66_1 > 0 then
		return var_66_1[1]
	end

	if #var_66_2 > 0 then
		return var_66_2[1]
	end

	if #var_66_0 > 0 then
		return var_66_0[#var_66_0]
	end

	return 0
end

function BioData:getFinishNewMission()
	return self._finishNewMission, self._finishNewMissionInfo
end

function BioData:setFinishNewMission()
	self._finishNewMission = false
	self._finishNewMissionInfo = nil
end

function BioData:getCampaignAward()
	return self._campaignFinishInfo
end

function BioData:getFastData()
	return self._fastData
end

function BioData:getSelf()
	local var_71_0 = self:getTeamInfo()

	if var_71_0.members then
		for iter_71_0 = 1, #var_71_0.members do
			if var_71_0.members[iter_71_0].user.id == g.core.model.User:getId() then
				return var_71_0.members[iter_71_0]
			end
		end
	end
end

function BioData:getMemberAtPos(arg_72_1)
	local var_72_0 = self:getTeamInfo()

	if var_72_0.members then
		for iter_72_0 = 1, #var_72_0.members do
			if arg_72_1 then
				if var_72_0.members[iter_72_0].position == arg_72_1 then
					return var_72_0.members[iter_72_0]
				end
			elseif var_72_0.members[iter_72_0].user.id == g.core.model.User:getId() then
				return var_72_0.members[iter_72_0]
			end
		end
	end
end

function BioData:setInviteTeamData(arg_73_1)
	self._inviteTeamData = {
		{},
		{}
	}

	if arg_73_1 then
		if arg_73_1.npc_robot then
			arg_73_1.npc_robot.team_id = arg_73_1.id
			arg_73_1.npc_robot.corner = g.core.lang:get(302043)
			arg_73_1.npc_robot.name = arg_73_1.npc_robot.name .. g.core.lang:get(302042)
			self._inviteTeamData[1][1] = arg_73_1.npc_robot
		end

		if arg_73_1.friends then
			for iter_73_0, iter_73_1 in ipairs(arg_73_1.friends) do
				iter_73_1.team_id = arg_73_1.id

				table.insert(self._inviteTeamData[1], #self._inviteTeamData[1] + 1, iter_73_1)
			end
		end

		if arg_73_1.guild_members then
			for iter_73_2, iter_73_3 in ipairs(arg_73_1.guild_members) do
				iter_73_3.team_id = arg_73_1.id

				table.insert(self._inviteTeamData[2], #self._inviteTeamData[2] + 1, iter_73_3)
			end
		end
	end
end

function BioData:getInviteTeamData(arg_74_1)
	return clone(self._inviteTeamData[arg_74_1 or 1])
end

function BioData:getOpenLands(arg_75_1, arg_75_2)
	arg_75_2 = arg_75_2 or 1

	local var_75_0 = {}

	for iter_75_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_75_2 = g.core.config.biography_team_info.indexOf(iter_75_0)

		if var_75_2.id > 0 and var_75_2.tab == arg_75_2 then
			if arg_75_1 then
				if self:isCampainOpen(var_75_2.id) then
					var_75_0[#var_75_0 + 1] = var_75_2
				end
			else
				var_75_0[#var_75_0 + 1] = var_75_2
			end
		end
	end

	return var_75_0
end

function BioData:getAllCampaignByLands()
	local var_76_0 = {}

	for iter_76_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_76_1 = g.core.config.biography_team_info.indexOf(iter_76_0).id

		if var_76_1 > 0 then
			var_76_0[#var_76_0 + 1] = var_76_1
		end
	end

	return var_76_0
end

function BioData:getAllSortCampaignByLands(arg_77_1)
	local var_77_0 = {}

	for iter_77_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_77_1 = g.core.config.biography_team_info.indexOf(iter_77_0)

		if arg_77_1 == var_77_1.tab then
			local var_77_2 = var_77_1.id

			if var_77_1.id > 0 then
				local var_77_3 = g.core.model.User.bioData:getCampaign(var_77_2)

				var_77_0[#var_77_0 + 1] = {
					cid = var_77_2,
					sortWeight = var_77_3.award and 1 or var_77_3.finish and 3 or 2,
					sort = var_77_3.sort
				}
			end
		end
	end

	table.sort(var_77_0, function(arg_78_0, arg_78_1)
		if arg_78_0.sortWeight ~= arg_78_1.sortWeight then
			return arg_78_0.sortWeight > arg_78_1.sortWeight
		end

		return arg_78_0.sort < arg_78_1.sort
	end)

	local var_77_5 = {}

	for iter_77_1 = 1, #var_77_0 do
		var_77_5[iter_77_1] = var_77_0[iter_77_1].cid
	end

	return var_77_5
end

function BioData:isShowCampaignRed(arg_79_1)
	for iter_79_0 = 1, g.core.config.biography_team_info.getLength() do
		local var_79_0 = g.core.config.biography_team_info.indexOf(iter_79_0)

		if arg_79_1 == var_79_0.tab then
			if var_79_0.id > 0 then
				local var_79_1 = g.core.model.User.bioData:getCampaign(var_79_0.id)

				if not var_79_1.award and var_79_1.finish then
					return true
				end
			end
		end
	end

	return false
end

function BioData:getCurChooseTeamList(arg_80_1)
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs(self._joinTeamData.teams or {}) do
		if not iter_80_1.lock and #iter_80_1.members < 2 then
			if not arg_80_1 then
				table.insert(var_80_0, iter_80_1)
			elseif iter_80_1.campaign_id == arg_80_1 then
				table.insert(var_80_0, iter_80_1)
			end
		end
	end

	return var_80_0
end

function BioData:updateJoinTeamData(arg_81_1)
	if arg_81_1 then
		self._joinTeamData = arg_81_1
	end
end

function BioData:getJoinTeamData()
	return self._joinTeamData
end

function BioData:getActLandNum()
	self._landOpenArr = {}

	local var_83_1 = self:getLands() or {}
	local var_83_2 = #var_83_1

	for iter_83_0, iter_83_1 in ipairs(var_83_1) do
		if iter_83_1.finish or iter_83_1.fighting then
			table.insert(self._landOpenArr, iter_83_1)
		else
			break
		end
	end

	local var_83_3 = #self._landOpenArr

	return var_83_3, #self._landOpenArr < var_83_2 and var_83_3 + 1 or var_83_3
end

function BioData:getCanGetBioTeamAwardIds()
	local var_84_0 = {}
	local var_84_1

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM) then
		do return {} end

		var_84_1 = false
	end

	for iter_84_0, iter_84_1 in ipairs((self:getAllCampaignByLands())) do
		local var_84_2 = self:getCampaign(iter_84_1)

		if var_84_2.award then
			-- block empty
		elseif var_84_2.finish then
			table.insert(var_84_0, iter_84_1)
		end
	end

	return var_84_0
end

function BioData:isCanGetBioTeamAward()
	return #self:getCanGetBioTeamAwardIds() > 0
end

function BioData:isBioChapterNew(arg_86_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		return false
	end

	if arg_86_1 and arg_86_1.id then
		if self:_checkUnlock((self:getChapter(arg_86_1.id))) == BioConst.BIO_CHAPTER_UNLOCK and not self:judgeBioChapterNewSetting(arg_86_1.id) then
			return true
		end

		return false
	else
		for iter_86_0, iter_86_1 in ipairs((self:getLands())) do
			self._refLand = iter_86_1

			for iter_86_2 = 1, 5 do
				if self:_checkUnlock((self:getChapter(iter_86_1.chapters[iter_86_2]))) == BioConst.BIO_CHAPTER_UNLOCK and not self:judgeBioChapterNewSetting(iter_86_1.chapters[iter_86_2]) then
					return true
				end
			end
		end

		return false
	end
end

function BioData:_checkUnlock(arg_87_1)
	if arg_87_1.if_open ~= 1 then
		return BioConst.BIO_CHAPTER_LOCK
	end

	if arg_87_1.dungeon_chapter_open > 0 then
		local var_87_0 = g.core.model.User.dungeonData:getChapter(arg_87_1.dungeon_chapter_open)

		if var_87_0 == nil or not var_87_0:isPassed() then
			return BioConst.BIO_CHAPTER_DUNGEON
		end
	end

	if not arg_87_1.fighting then
		return BioConst.BIO_CHAPTER_BEFORE
	end

	return BioConst.BIO_CHAPTER_UNLOCK
end

function BioData:isBioTeamCampaignNew(arg_88_1)
	if arg_88_1 and arg_88_1.id then
		local var_88_0, var_88_1 = self:isCampainOpen(arg_88_1.id)

		if var_88_0 and not self:judgeBioTeamCampaignNewSetting(arg_88_1.id) then
			return true
		end

		return false
	else
		for iter_88_0, iter_88_1 in ipairs((self:getOpenLands(true, 1))) do
			if not self:judgeBioTeamCampaignNewSetting(iter_88_1.id) then
				return true
			end
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
			for iter_88_2, iter_88_3 in ipairs((self:getOpenLands(true, 2))) do
				if not self:judgeBioTeamCampaignNewSetting(iter_88_3.id) then
					return true
				end
			end
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
			for iter_88_4, iter_88_5 in ipairs((self:getOpenLands(true, 3))) do
				if not self:judgeBioTeamCampaignNewSetting(iter_88_5.id) then
					return true
				end
			end
		end

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
			for iter_88_6, iter_88_7 in ipairs((self:getOpenLands(true, 4))) do
				if not self:judgeBioTeamCampaignNewSetting(iter_88_7.id) then
					return true
				end
			end
		end

		return false
	end
end

function BioData:_getBioChapterNewSettingStr(arg_89_1)
	return "BioChapterNewRecord" .. tostring(arg_89_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function BioData:setBioChapterNewSettingRecord(arg_90_1)
	local var_90_0 = self._bioChapterSetConfig

	if not self._bioChapterSetConfig then
		var_90_0 = g.core.common.Storage:load("BioChapterNewRecord.json", false)
		var_90_0 = var_90_0 or {}
	end

	self._bioChapterSetConfig = var_90_0
	self._bioChapterSetConfig[self:_getBioChapterNewSettingStr(arg_90_1)] = "1"

	g.core.common.Storage:save("BioChapterNewRecord.json", self._bioChapterSetConfig, false)
end

function BioData:judgeBioChapterNewSetting(arg_91_1)
	local var_91_0 = g.core.common.Storage:load("BioChapterNewRecord.json", false) or {}
	local var_91_1 = self:_getBioChapterNewSettingStr(arg_91_1)

	if var_91_0[var_91_1] and var_91_0[var_91_1] == "1" then
		return true
	end

	return false
end

function BioData:_getBioTeamCampaignNewSettingStr(arg_92_1)
	return "BioTeamCampaignNewRecord" .. tostring(arg_92_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function BioData:setBioTeamCampaignNewSettingRecord(arg_93_1)
	local var_93_0 = self._bioTeamCampaignSetConfig

	if not self._bioTeamCampaignSetConfig then
		var_93_0 = g.core.common.Storage:load("BioTeamCampaignNewRecord.json", false)
		var_93_0 = var_93_0 or {}
	end

	self._bioTeamCampaignSetConfig = var_93_0
	self._bioTeamCampaignSetConfig[self:_getBioTeamCampaignNewSettingStr(arg_93_1)] = "1"

	g.core.common.Storage:save("BioTeamCampaignNewRecord.json", self._bioTeamCampaignSetConfig, true)
end

function BioData:judgeBioTeamCampaignNewSetting(arg_94_1)
	local var_94_0 = g.core.common.Storage:load("BioTeamCampaignNewRecord.json", true) or {}
	local var_94_1 = self:_getBioTeamCampaignNewSettingStr(arg_94_1)

	if var_94_0[var_94_1] and var_94_0[var_94_1] == "1" then
		return true
	end

	return false
end

function BioData:getBioTeamRandomAwardDataById(arg_95_1)
	local var_95_0 = self:getCampaign(arg_95_1)
	local var_95_1 = {}

	if var_95_0 then
		if var_95_0.seen_type and var_95_0.seen_type ~= 0 then
			table.insert(var_95_1, {
				rewardType = 1,
				award = {
					type = var_95_0.seen_type,
					value = var_95_0.seen_value,
					size = var_95_0.seen_num
				}
			})
		end

		if var_95_0.seen_type2 and var_95_0.seen_type2 ~= 0 then
			table.insert(var_95_1, {
				rewardType = 2,
				award = {
					type = var_95_0.seen_type2,
					value = var_95_0.seen_value2,
					size = var_95_0.seen_num2
				}
			})
		end

		if var_95_0.seen_type3 and var_95_0.seen_type3 ~= 0 then
			table.insert(var_95_1, {
				rewardType = 0,
				award = {
					type = var_95_0.seen_type3,
					value = var_95_0.seen_value3,
					size = var_95_0.seen_num3
				}
			})
		end
	end

	return var_95_1
end

function BioData:getBioTeamCampaignInfoAwardById(arg_96_1)
	local var_96_0 = {}
	local var_96_1 = self:getCampaign(arg_96_1)

	if var_96_1 then
		local var_96_2 = self:getBioTeamChallengeTypeByLeftCounts()

		if var_96_2 == BioConst.BIO_TEAM_CHALLENGE_TYPE.HELP or var_96_2 == 0 then
			local var_96_3 = self:getBioTeamMaxLevelOpenLand()

			for iter_96_0, iter_96_1 in ipairs((g.core.common.Drops:getGoodsArray(self:getCampaign(((var_96_1.tab >= 3 or nil) and var_96_1).id).reward_help))) do
				table.insert(var_96_0, {
					rewardType = 3,
					award = iter_96_1
				})
			end
		elseif var_96_2 == BioConst.BIO_TEAM_CHALLENGE_TYPE.NORMAL then
			var_96_0 = clone(self:getBioTeamRandomAwardDataById(arg_96_1))

			for iter_96_2, iter_96_3 in ipairs({
				{
					rewardType = 0,
					award = {
						type = var_0_0.TYPE_RESOURCE,
						value = var_0_0.RESOURCE.TYPE_COIN,
						size = var_96_1.reward_tael
					}
				},
				{
					rewardType = 0,
					award = {
						value = 17,
						type = var_0_0.TYPE_ITEM,
						size = var_96_1.reward_material
					}
				}
			}) do
				table.insert(var_96_0, iter_96_3)
			end
		end
	end

	return var_96_0
end

function BioData:getBioTeamChallengeTypeByLeftCounts()
	if var_0_2:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM) > 0 then
		return BioConst.BIO_TEAM_CHALLENGE_TYPE.NORMAL
	elseif var_0_2:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM_HELP_CHALLENGE) > 0 then
		return BioConst.BIO_TEAM_CHALLENGE_TYPE.HELP
	end

	return 0
end

function BioData:getBioTeamLeftCountsInfo()
	return var_0_2:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM), var_0_2:getBuyLimitLeft((g.core.config.play_num_info.get(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM))), (var_0_2:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM_HELP_CHALLENGE))
end

function BioData:resetAllListNewState()
	for iter_99_0, iter_99_1 in ipairs((self:getOpenLands(true, 1))) do
		if not self:judgeBioTeamCampaignNewSetting(iter_99_1.id) then
			self:setBioTeamCampaignNewSettingRecord(iter_99_1.id)
		end
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		for iter_99_2, iter_99_3 in ipairs((self:getOpenLands(true, 2))) do
			if not self:judgeBioTeamCampaignNewSetting(iter_99_3.id) then
				self:setBioTeamCampaignNewSettingRecord(iter_99_3.id)
			end
		end
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		for iter_99_4, iter_99_5 in ipairs((self:getOpenLands(true, 3))) do
			if not self:judgeBioTeamCampaignNewSetting(iter_99_5.id) then
				self:setBioTeamCampaignNewSettingRecord(iter_99_5.id)
			end
		end
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		for iter_99_6, iter_99_7 in ipairs((self:getOpenLands(true, 4))) do
			if not self:judgeBioTeamCampaignNewSetting(iter_99_7.id) then
				self:setBioTeamCampaignNewSettingRecord(iter_99_7.id)
			end
		end
	end
end

function BioData:getBioTeamMaxLevelOpenLand(arg_100_1)
	local var_100_0 = self:getOpenLands(true, arg_100_1)
	local var_100_1 = var_100_0[1] or {}
	local var_100_2 = 1
	local var_100_3 = true

	if #var_100_0 > 0 then
		for iter_100_0 = #var_100_0, 1, -1 do
			local var_100_4 = self:getCampaign(var_100_0[iter_100_0].id)

			if var_100_4 and not var_100_4.finish then
				table.remove(var_100_0, iter_100_0)
			end
		end

		if #var_100_0 > 0 then
			var_100_3 = false
			var_100_1 = var_100_0[#var_100_0]
			var_100_2 = #var_100_0
		end
	end

	return var_100_1, var_100_2, var_100_3
end

function BioData:getCurChapterMainAndSubTaskState(arg_101_1)
	if not arg_101_1 then
		return
	end

	local var_101_0 = arg_101_1.chains

	if not self:getChain(arg_101_1.chains[1]).finish then
		return BioConst.BIO_TASK_STATE.MAIN_TASK_UN_FINISH
	end

	for iter_101_0 = 2, #var_101_0 do
		for iter_101_1, iter_101_2 in ipairs(self:getChain(var_101_0[iter_101_0]).missions) do
			if not self:getMission(iter_101_2).finish then
				return BioConst.BIO_TASK_STATE.SUB_TASK_UN_FINISH
			end
		end
	end

	return BioConst.BIO_TASK_STATE.ALL_FINISH
end

function BioData:isBioTeamBattleFriend(arg_102_1)
	local var_102_0 = self:getTeamInfo()

	if arg_102_1 and var_102_0 and var_102_0.members then
		for iter_102_0 = 1, #var_102_0.members do
			local var_102_1 = var_102_0.members[iter_102_0] or {}

			if var_102_1.user and var_102_1.user.id == arg_102_1 then
				return true
			end
		end
	end

	return false
end

function BioData:isBioCntEnough()
	local var_103_0

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
		do return false end

		var_103_0 = g.core.model.User.resourceData:getBioGraphie()
	end

	local var_103_1 = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_BIOGRAPHIE).time_limit

	return var_103_0 > 5
end

function BioData:_initChapterInteractCfgInfo()
	return
end

function BioData:getInteractByBindAndChapterId(arg_105_1, arg_105_2)
	local var_105_0 = g.core.config.biography_interaction_info.get(arg_105_1, arg_105_2)

	if var_105_0 then
		return var_105_0.toObject()
	end
end

function BioData:setIsEnterBattle(arg_106_1)
	self._isEnterBattle = arg_106_1
end

function BioData:getIsEnterBattle(arg_107_1)
	return self._isEnterBattle
end

function BioData:setInviteeListConnectTime(arg_108_1)
	self._inviteeListConnectTime = arg_108_1
end

function BioData:getInviteeListConnectTime()
	return self._inviteeListConnectTime
end

function BioData:isHaveBioTeamLeftCount()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM) then
		return false
	end

	return var_0_2:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.BIO_TEAM) > 0
end

function BioData:getNextBioChapterDungeonNum()
	for iter_111_0 = self:getCurLandIndex(), #self._lands do
		for iter_111_1, iter_111_2 in ipairs(self._lands[iter_111_0].chapters) do
			local var_111_0 = self:getChapter(iter_111_2)

			if self:_checkUnlock(var_111_0) == BioConst.BIO_CHAPTER_DUNGEON then
				return var_111_0.dungeon_chapter_open
			end
		end
	end
end

function BioData:setRoomOutTime(arg_112_1, arg_112_2)
	if not arg_112_1 then
		return
	end

	self._roomTimeMap[arg_112_1] = arg_112_2
end

function BioData:getRoomOutTime(arg_113_1)
	return self._roomTimeMap[arg_113_1]
end

function BioData:checkAttackTime(arg_114_1)
	local var_114_0 = self._attackTimeDict[arg_114_1] or 0
	local var_114_1 = g.core.common.ServerTime:getTime()

	if var_114_0 <= var_114_1 then
		self._attackTimeDict[arg_114_1] = var_114_1 + 1
	else
		return false
	end

	return true
end

function BioData:setDisplayVersion(arg_115_1)
	self._displayVersion = arg_115_1
end

function BioData:getDisplayVersion()
	return self._displayVersion
end

return BioData
