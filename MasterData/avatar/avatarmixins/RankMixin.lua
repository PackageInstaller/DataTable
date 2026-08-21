-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\RankMixin.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local UIManager = UIManager
local RankMixin = {}

function RankMixin:onRankListRequestNextPage(rankType)
	if rankType ~= self.rankListType then
		self.rankList = {}

		self:onClearRankList()
	end

	if #self.rankList ~= 0 and self.requestRankPageTime and Time.time - self.requestRankPageTime < 0.2 then
		self.rankListType = rankType
		self.delayNextPageTimer = Timer.New(Slot(self.delayNextPage, self), 0.2, 1)

		self.delayNextPageTimer:Start()

		return
	end

	if self.nowRankpage + 1 > 0 and self.nowRankpage + 1 > self.maxRankPage then
		return
	end

	if rankType == Const.RANK_TYPE_MULTIPVP then
		RPC.multiPVPRank(self.nowRankpage + 1)
	elseif rankType == Const.RANK_TYPE_OPACTPVP then
		local actObj = self:getPVPArenaActivity()

		if actObj and actObj.actData then
			RPC.opactArenaRankGet(actObj.opId, actObj.actData.arenaData.league, self.nowRankpage + 1)
		end
	else
		RPC.rankGet(rankType, self.nowRankpage + 1)
	end

	self.requestRankPageTime = Time.time
	self.rankListType = rankType
end

function RankMixin:delayNextPage()
	self:onRankListRequestNextPage(self.rankListType)
end

function RankMixin:onClearRankList()
	self.nowRankpage = -1
	self.maxRankPage = 0
	self.rankList = {}
end

function RankMixin:setRankBeSame()
	local flagRankIdx = 0
	local tempScore = 0

	for i, v in ipairs(self.rankList) do
		if v.data.uid == self.uid then
			-- block empty
		end

		if v.data.score ~= tempScore then
			self.rankList[i].rank = i
			tempScore = v.data.score
			flagRankIdx = i
		else
			self.rankList[i].rank = flagRankIdx
		end
	end
end

function RankMixin:getRankCache(rankType)
	if self.myRankCache[rankType] then
		return self.myRankCache[rankType]
	else
		return 0
	end
end

function RankMixin:onRankIndexGetResp(rank, rank_type)
	rank.rank = rank.rank + 1

	if rank_type == Const.RANK_TYPE_ASYNCPVP then
		self.pvpRank = rank.rank

		local pvpMainDlg = UIManager.getUI("pvpMainDlg", nil, false)

		if pvpMainDlg then
			pvpMainDlg:initMyInfo(rank.rank)
		end
	end
end

local RANK_DLG = {
	"rankMainDlg",
	"pvpMainDlg",
	"seniorPvpMainDlg",
	"activityPvpMainDlg"
}

function RankMixin:onRankGetResp(rankType, rankPage, rankData, selfData, totalCount)
	if not self.myRankCache then
		self.myRankCache = {}
	end

	selfData.rank = selfData.rank + 1
	self.myRankCache[rankType] = selfData.rank

	local rankMainDlg

	for i, name in ipairs(RANK_DLG) do
		local dlg = UIManager.getUI(name, nil, false)

		if dlg ~= nil then
			rankMainDlg = dlg

			break
		end
	end

	if rankMainDlg == nil then
		return
	end

	for k, v in ipairs(self.rankList) do
		if v.rankType ~= rankType then
			if rankPage >= 1 then
				return
			end

			self.rankList = {}

			break
		end
	end

	self.nowRankpage = self.nowRankpage + 1

	for i, _rankData in ipairs(rankData) do
		_rankData.rank = _rankData.rank + 1
		_rankData.rankType = rankType
		_rankData.data.score = tonumber(_rankData.data.score) or 0

		if _rankData.data.comm.uid == self.uid then
			_rankData.data.comm.level = self:getLevel()
			selfData = _rankData

			rankMainDlg:setSelfRankCell(selfData)
		elseif rankType == Const.RANK_TYPE_ASYNCPVP then
			PVPCommon.checkAndChangeRobotCommInfo(_rankData.data.comm, Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)
		end

		table.insert(self.rankList, _rankData)
	end

	selfData.rankType = rankType
	selfData.data.score = tonumber(selfData.data.score) or 0

	local totalPage = 0

	if totalCount == 0 then
		rankMainDlg:emptyRankData()

		if rankType == Const.RANK_TYPE_ASYNCPVP or rankType == Const.RANK_TYPE_MULTIPVP then
			rankMainDlg:setSelfRankCell(selfData)
		end

		return
	end

	if totalCount < 10 then
		totalPage = 1
	end

	if totalCount % 10 == 0 then
		totalPage = totalCount / 10
		totalPage = math.floor(totalPage)
	else
		totalPage = totalCount / 10 + 1
		totalPage = math.floor(totalPage)
	end

	self.maxRankPage = totalPage

	if rankMainDlg then
		rankMainDlg.panelRankList:setDataList(self.rankList, totalPage == rankPage + 1)

		if rankPage == 0 then
			rankMainDlg:setSelfRankCell(selfData)
		end
	end

	if rankData[1] and rankData[1].rank == 1 then
		self:refreshHandBookRankDlg(rankData[1].data, rankType)
	end
end

function RankMixin:refreshHandBookRankDlg(rank, rankType)
	local handBookRankSelectDlg = UIManager.getUI("handBookRankSelectDlg", nil, false)

	if handBookRankSelectDlg then
		handBookRankSelectDlg:refreshOnePlayer(rank, rankType)
	end

	local masterApprenticeMainDlg = UIManager.getUI("masterApprenticeMainDlg", nil, false)

	if masterApprenticeMainDlg then
		masterApprenticeMainDlg:refreshOnePlayer(rank, rankType)
	end

	local handBookRankInfoDlg = UIManager.getUI("handBookRankInfoDlg", nil, false)

	if handBookRankInfoDlg then
		handBookRankInfoDlg:refreshOnePlayer(rank, rankType)
	end
end

function RankMixin:onRankTopGetResp(rank)
	local handBookRankSelectDlg = UIManager.getUI("handBookRankSelectDlg", nil, false)

	if handBookRankSelectDlg then
		handBookRankSelectDlg:setPlayerInfo(rank)
	end

	local masterApprenticeMainDlg = UIManager.getUI("masterApprenticeMainDlg", nil, false)

	if masterApprenticeMainDlg then
		masterApprenticeMainDlg:setPlayerInfo(rank)
	end
end

function RankMixin:onMultiPVPRankResp(data, score, rank, tick, page)
	local datas = {}
	local comm = self:getMyCommInfo()

	for i, rankData in ipairs(data) do
		local _data = {}

		if utils.isRobot(rankData.comm.uid) == false then
			_data.data = rankData
		else
			_data.isRobot = true
			_data.data = {
				comm = PVPCommon.getMultiPvpRobotCommInfo(rankData.comm.uid)
			}
			_data.data.power = PVPCommon.getRobotFormationPower(rankData.comm.uid)
		end

		_data.data.tick = -1
		_data.data.score = 0
		_data.rank = rankData.rank

		table.insert(datas, _data)
	end

	local selfData = {}

	selfData.data = {
		comm = utils.copyTable(comm)
	}
	selfData.data.tick = -1
	selfData.data.score = 0
	selfData.rank = rank - 1
	selfData.rankType = Const.RANK_TYPE_MULTIPVP

	self:onRankGetResp(Const.RANK_TYPE_MULTIPVP, page, datas, selfData, Const.SENIORPVP_RANK_COUNT)

	local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

	if ui then
		ui:pointGetTimer(score, tick, true)
	end
end

function RankMixin:onOpActPlotGetRankResp(act_id, index, rankDataItems)
	local rankMainDlg = UIManager.getUI("rankMainDlg", nil, false)

	if rankMainDlg then
		local rankData = {}
		local rankDataList = {}
		local selfData = {}

		for _, dataItem in pairs(rankDataItems) do
			local _rankData = {}
			local rankCommonData = {}

			rankCommonData.score = dataItem.pass_time
			rankCommonData.comm = dataItem.comm
			rankCommonData.tick = 0
			_rankData.rank = dataItem.rank + 1
			_rankData.rankType = Const.RANK_TYPE_ACTIVITY_PLOT

			if rankCommonData.comm.uid == self.uid then
				rankCommonData.comm = self:getMyCommInfo()
				selfData.data = rankCommonData
				selfData.rank = dataItem.rank + 1
				selfData.rankType = Const.RANK_TYPE_ACTIVITY_PLOT
			end

			_rankData.data = rankCommonData

			table.insert(rankDataList, _rankData)
		end

		if not selfData.data then
			selfData.data = {}

			local rankCommonData = {}

			rankCommonData.score = rankMainDlg.plotActObj.actData:getPassTimeByIndex(rankMainDlg.plotLevelIdx)
			rankCommonData.comm = self:getMyCommInfo()
			rankCommonData.tick = 0
			selfData.data = rankCommonData
			selfData.rank = -1
			selfData.rankType = Const.RANK_TYPE_ACTIVITY_PLOT
		end

		rankData.dataList = rankDataList
		rankData.selfData = selfData

		rankMainDlg:setRankData(rankData)
	end
end

function RankMixin:sendOpactPvpTopRankReq(...)
	self.opactTopRankReqFlag = true

	local actId = self:getPVPArenaActivityOpId()

	if actId then
		RPC.opactArenaRankGet(actId, 1, 0)
	end
end

function RankMixin:onOpactArenaRankGetResp(rank_data, page, rank_num)
	self:onClearRankList()

	if self.opactTopRankReqFlag == true then
		self.opactTopRankReqFlag = nil

		local datas = {}

		for i, rankData in ipairs(rank_data) do
			local _data = {}

			_data.data = {
				comm = rankData.comm
			}
			_data.data.power = rankData.power
			_data.data.tick = -1
			_data.data.score = rankData.score
			_data.rank = 0

			if #datas < 10 then
				table.insert(datas, _data)
			else
				break
			end
		end

		table.sort(datas, function(v1, v2)
			return v1.data.score > v2.data.score
		end)
		UIManager.getUI("activityPvpTopRankDlg", true):show(datas)
	else
		local selfData = self:getMyOpactPvpRankData()
		local datas = {}

		for i, rankData in ipairs(rank_data) do
			local _data = {}

			_data.data = {
				comm = rankData.comm
			}
			_data.data.power = rankData.power
			_data.data.tick = rankData.tick
			_data.data.score = rankData.score
			_data.rank = 0

			table.insert(datas, _data)
		end

		local page = math.ceil(rank_num / 10) - 1

		if #datas == 0 then
			local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

			if ui then
				ui.panelRankList:setDataList(datas, true)
			end
		else
			self:onRankGetResp(Const.RANK_TYPE_OPACTPVP, page, datas, selfData, rank_num)
		end
	end
end

function RankMixin:getMyOpactPvpRankData(...)
	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}
	selfData.data.tick = ClientUtils.getServerTime()

	local score = 0
	local arenaActData = self:getPVPArenaActivityData()

	if arenaActData then
		score = arenaActData.score
	end

	selfData.data.score = score
	selfData.rank = (self.opactPvpRank or 0) - 1
	selfData.rankType = Const.RANK_TYPE_OPACTPVP
	selfData.data.power = PVPCommon.getOpactPvpDefendPower()

	return selfData
end

function RankMixin:onRankCacheGetPageResp(rank_data, page, rank_num, is_end, cache_type)
	if page == 0 then
		self.cacheRankDataList = {}
	end

	for i, _rankData in ipairs(rank_data) do
		_rankData.score = tonumber(_rankData.score) or 0

		local rankData = {}

		rankData.data = _rankData

		table.insert(self.cacheRankDataList, rankData)
	end

	local typeRank = Const.CACHE_TYPE_TO_RANK_TYPE[cache_type]
	local rankMainDlg = UIManager.getUI("rankMainDlg", nil, false)
	local circleBattleBossAwardDlg = UIManager.getUI("circleBattleBossAwardDlg", nil, false)

	if rank_num == 0 and is_end == 1 then
		if rankMainDlg and (rankMainDlg.typeRank == typeRank or rankMainDlg.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER) then
			rankMainDlg:emptyRankData()
		end

		if circleBattleBossAwardDlg then
			circleBattleBossAwardDlg:refreshForCircleRank(-1)
		end

		return
	end

	if is_end == 1 and (rankMainDlg or circleBattleBossAwardDlg) then
		local myCircleId = self.myCircle and tostring(self.myCircle.gid) or "0"
		local myUid = typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER and myCircleId or self.uid
		local selfTick = ClientUtils.getServerTime()
		local myReplayId = "0"

		for i, data in ipairs(self.cacheRankDataList) do
			local rankData = self.cacheRankDataList[i]

			if rankData.data.comm.uid == myUid then
				selfTick = self.cacheRankDataList[i].data.tick

				if typeRank == Const.RANK_TYPE_PET_MAZE then
					myReplayId = rankData.data.replay_id
				end

				table.remove(self.cacheRankDataList, i)

				break
			end
		end

		local selfRankData

		if typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER or typeRank == Const.RANK_TYPE_SEASON_TOWER_SCORE then
			selfRankData = self:getMyOpactTowerRankData(rankMainDlg.seasonTowerId)
		elseif typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
			selfRankData = self:getCircleBattleLayerRankData(rankMainDlg.seasonTowerId)
		elseif typeRank == Const.RANK_TYPE_WORLDBOSS then
			selfRankData = self:getWorldBossRankData()
		elseif typeRank == Const.RANK_TYPE_NEW_MAZE then
			selfRankData = self:getNewMazeRankData()
		elseif typeRank == Const.RANK_TYPE_PET_MAZE then
			selfRankData = self:getPetMazeRankData(myReplayId)
		elseif typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
			selfRankData = self:getSneakBattleRankData()
		end

		if selfRankData and selfRankData.data.score > 0 then
			if typeRank ~= Const.RANK_TYPE_CIRCLE_BATTLE_LAYER and typeRank ~= Const.RANK_TYPE_WORLDBOSS and typeRank ~= Const.RANK_TYPE_SNEAK_BATTLE then
				selfRankData.data.tick = selfTick
			end

			if typeRank == Const.RANK_TYPE_WORLDBOSS then
				if WorldBossCommon.canShowOnRank(selfRankData.data.score) then
					table.insert(self.cacheRankDataList, selfRankData)
				end
			elseif typeRank == Const.RANK_TYPE_NEW_MAZE then
				local actData = self:getNewMazeActData()

				if actData and actData:canShowOnRank(selfRankData.data.score) then
					table.insert(self.cacheRankDataList, selfRankData)
				end
			else
				table.insert(self.cacheRankDataList, selfRankData)
			end

			table.sort(self.cacheRankDataList, function(v1, v2)
				if v1.data.score ~= v2.data.score then
					return v1.data.score > v2.data.score
				elseif typeRank == Const.RANK_TYPE_SNEAK_BATTLE then
					if v1.data.tick ~= v2.data.tick then
						return v1.data.tick < v2.data.tick
					else
						return v1.data.param < v2.data.param
					end
				else
					return v1.data.tick < v2.data.tick
				end
			end)

			for idx = #self.cacheRankDataList, 100, -1 do
				table.remove(self.cacheRankDataList, idx)
			end
		end

		local selfData

		for rank, data in ipairs(self.cacheRankDataList) do
			self.cacheRankDataList[rank].rank = rank
			self.cacheRankDataList[rank].rankType = typeRank

			if self.cacheRankDataList[rank].data.comm.uid == myUid then
				selfData = self.cacheRankDataList[rank]
			end
		end

		if not selfData and selfRankData then
			selfData = selfRankData

			if typeRank ~= Const.RANK_TYPE_SNEAK_BATTLE then
				selfData.data.tick = ClientUtils.getServerTime()
			end

			selfData.rankType = typeRank
		end

		local rankData = {}

		rankData.dataList = self.cacheRankDataList
		rankData.selfData = selfData

		if typeRank == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
			self.cachedCircleBattleLayerRankData = rankData
			self.circleBattleGetRankTick = ClientUtils.getServerTime()

			if circleBattleBossAwardDlg then
				circleBattleBossAwardDlg:refreshForCircleRank(self.cachedCircleBattleLayerRankData.selfData.rank)
			end
		end

		if rankMainDlg and (rankMainDlg.typeRank == typeRank or rankMainDlg.typeRank == Const.RANK_TYPE_SEASON_TOWER_LAYER) then
			rankMainDlg:setRankData(rankData)
		end
	end

	if cache_type == Const.RANK_CACHE_TYPE_TOP_PVP then
		self.cachedTopPvpRankData = rank_data

		if rank_data and #rank_data ~= 0 then
			SceneManager.refreshTopPvpRank()
		end
	end
end

function RankMixin:onRankCacheGetRealRankingResp(cache_type, sub_type, actid, season, uniqueid, ranking)
	if cache_type == Const.RANK_CACHE_TYPE_CIRCLE_LAYER then
		local selfData = self:getCircleBattleLayerRankData()

		selfData.rank = ranking + 1
		selfData.rankType = Const.RANK_TYPE_CIRCLE_BATTLE_LAYER

		if selfData.rank > 0 then
			selfData.data.tick = ClientUtils.getServerTime()

			local rankMainDlg = UIManager.getUI("rankMainDlg", nil, false)

			if rankMainDlg then
				self.cachedCircleRealRankingData = selfData
				self.getCircleRealRankingTick = ClientUtils.getServerTime()

				rankMainDlg:setSelfRankCell(self.cachedCircleRealRankingData)
			end
		end

		self:checkSendMyCircleRank(selfData.rank)
	end
end

function RankMixin:getMyOpactTowerRankData(towerId)
	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}

	local score = 0
	local actObj = self:getActivityObjByType(Const.ACT_TYPE_SEASON_TOWER)

	if actObj then
		local actData = actObj.actData

		if actData then
			if towerId == 0 then
				score = actData.score or 0
			elseif actData.miscData.use_score_rank == 1 then
				if actData.towerRoleData[towerId] then
					score = actData.towerRoleData[towerId].score or 0
				end
			else
				score = actData.towerLayer[towerId] or 0
			end
		end
	end

	selfData.data.score = tonumber(score) or 0
	selfData.rank = -1
	selfData.data.power = 0

	return selfData
end

function RankMixin:getCircleBattleLayerRankData()
	if self.myCircle then
		local selfData = {}
		local comm = self:getMyCircleCommInfo()

		selfData.data = {
			comm = utils.copyTable(comm)
		}

		local layer = self.myCircle:getCurBattleLayer()
		local openedGridNum, totalGridNum = self.myCircle:getSearchProgress()

		if layer - 1 > 0 then
			local progressValue = math.floor(openedGridNum / totalGridNum * 10000)

			selfData.data.score = (layer - 1) * 100000 + progressValue
		else
			selfData.data.score = 0
		end

		if self.myCircle:getCurBattleLayerTick() > 0 then
			selfData.data.tick = self.myCircle:getCurBattleLayerTick()
		else
			selfData.data.tick = ClientUtils.getServerTime()
		end

		selfData.rank = -1

		return selfData
	end
end

function RankMixin:getWorldBossRankData()
	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}

	local score = 0
	local tick = ClientUtils.getServerTime()
	local replay_id = "0"
	local actData = self:getWorldBossActData()

	if actData then
		local worldBossData = actData:getWorldBossRoleData()

		if worldBossData then
			score = worldBossData.sum_score or 0
			tick = worldBossData.sum_score_tick
			replay_id = worldBossData.replay_id

			if CurAvatar.onShowWorldBossRankIndex and CurAvatar.onShowWorldBossRankIndex ~= 1 then
				score = worldBossData.team_two_max_score or 0
				tick = worldBossData.sum_score_tick
				replay_id = worldBossData.replay_id2
			end
		end
	end

	selfData.data.score = tonumber(score) or 0
	selfData.data.tick = tick
	selfData.data.replay_id = replay_id
	selfData.rank = -1

	return selfData
end

function RankMixin:getNewMazeRankData()
	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}

	local score = 0
	local tick = ClientUtils.getServerTime()
	local replay_id = "0"
	local actData = self:getNewMazeActData()

	if actData then
		score = (actData.seasonBestGradeLevel * 10000 + actData.seasonBestGradeLayer) * Const.RANK_NEW_MAZE_SCORE_RATE + actData.seasonBestGradeScore
	end

	selfData.data.score = score
	selfData.data.tick = tick
	selfData.data.replay_id = replay_id
	selfData.rank = -1

	return selfData
end

function RankMixin:getPetMazeRankData(replayId)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
	local checkOpen = actObj ~= nil and actObj:isValid()

	if not checkOpen then
		return nil
	end

	local bossData = actObj.actData.bossAreaData
	local score = bossData.score or 0

	if score == 0 then
		return
	end

	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}

	local tick = ClientUtils.getServerTime()
	local replay_id = replayId

	score = actObj.actData.layer * 100000000 + score
	selfData.data.score = score
	selfData.data.tick = tick
	selfData.data.replay_id = replay_id
	selfData.rank = -1

	return selfData
end

function RankMixin:getSneakBattleRankData(...)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_SNEAK_BATTLE)
	local checkOpen = actObj ~= nil and actObj:isValid()

	if not checkOpen then
		return nil
	end

	local bestData = actObj.actData.bestRecord
	local score = 0
	local tick = 0
	local param = ClientUtils.getServerTime()

	if bestData then
		local level = bestData.level
		local stage = bestData.stage

		score = level * 100 + stage
		tick = bestData.battle_time
		param = bestData.update_tick
	end

	local selfData = {}
	local comm = self:getMyCommInfo()

	selfData.data = {
		comm = utils.copyTable(comm)
	}

	local replay_id = "0"

	selfData.data.score = score
	selfData.data.tick = tick
	selfData.data.param = param
	selfData.rank = -1

	return selfData
end

return RankMixin
