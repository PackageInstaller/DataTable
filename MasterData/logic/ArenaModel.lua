-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/model/ArenaModel.lua

module("logic.extensions.arena.model.ArenaModel", package.seeall)

local ArenaModel = class("ArenaModel", BaseModel)

function ArenaModel:ctor()
	self:onReset()
end

function ArenaModel:onReset()
	self._seasonId = 0
	self._arenaId = 0
	self._topGroupId = 0
	self._lastWeekPrizeInfo = nil
	self._rankPrizeMO = nil
	self._zoneId = 0
	self._position = 0
	self._topGroupId = 0
	self._targets = nil
	self._leftChallengeTimes = 0
	self._challengeCdSec = 0
	self._refreshTimes = 0
	self._refreshCdSec = 0
	self._challengeBuyTime = 0
	self._totalZone = 5
	self._maxChallengeTimes = 0
	self._curChallengerPos = -1
	self._curSelectZoneId = -1
	self._bestPosition = -1
	self._bestPositionEver = -1
	self._userNums = {}
	self._challengeCdEndTime = self._challengeCdSec + ServerTime.now()
	self._refreshCdEndTime = self._refreshCdSec + ServerTime.now()
	self._open_arenafmtview_tag = false
	self._isRequireMyzoneInfo = false
	self._upPositionData = nil
	self._curChallengerUserId = nil
end

function ArenaModel:initArenaMO(mo)
	self._zoneId = mo.zoneId
	self._position = mo.position
	self._topGroupId = mo.topGroupId
	self._maxChallengeTimes = mo.maxChallengeTimes
	self._leftChallengeTimes = mo.leftChallengeTimes
	self._challengeCdSec = mo.challengeCdSec
	self._challengeCdEndTime = mo.challengeCdSec + ServerTime.now()
	self._refreshTimes = mo.refreshTimes
	self._refreshCdSec = mo.refreshCdSec
	self._refreshCdEndTime = mo.refreshCdSec + ServerTime.nowMs() * 0.001
	self._challengeBuyTime = mo.challengeBuyTime
	self._bestPosition = mo.bestPosition

	self:setBestPosition(mo.bestPositionEver)

	self._bestPositionEver = mo.bestPositionEver

	self:setTargets(mo)
end

function ArenaModel:onArenaChallengeRes(msg)
	self._leftChallengeTimes = Mathf.Max(0, self._leftChallengeTimes - 1)

	if msg:HasField("newPosition") then
		self._position = msg.newPosition
	end

	if msg:HasField("challengeCdSec") then
		self._challengeCdSec = msg.challengeCdSec
	end

	if msg:HasField("allTargets") then
		self:setTargets(msg)
	end
end

function ArenaModel:getLeftBuyCnt()
	local totalTimes = VipModel.instance:getAbleToBuyTimesOfArena()

	return totalTimes - self._challengeBuyTime
end

function ArenaModel:getLeftChallengeTimes()
	return self._leftChallengeTimes
end

function ArenaModel:setLeftChallengeTimes(cnt)
	self._leftChallengeTimes = cnt
end

function ArenaModel:getMaxRefreshCnt()
	return ArenaConfig.instance:getMaxDailyRefreshTime()
end

function ArenaModel:getLeftRefreshCnt()
	return self:getMaxRefreshCnt() - self._refreshTimes
end

function ArenaModel:getRefreshCdEndTime()
	return self._refreshCdEndTime
end

function ArenaModel:setRefreshCd(cd)
	self._refreshCdSec = cd
	self._refreshCdEndTime = cd + ServerTime.nowMs() * 0.001
end

function ArenaModel:addupRefreshCnt()
	self._refreshTimes = self._refreshTimes + 1
end

function ArenaModel:setRefreshCnt(cnt)
	self._refreshTimes = cnt
end

function ArenaModel:setSelectZoneId(id)
	self._curSelectZoneId = id
end

function ArenaModel:confirmSelectZoneId()
	self._zoneId = self._curSelectZoneId
end

function ArenaModel:getChallengeTimes()
	return self._challengeTimes
end

function ArenaModel:setChallengeBuyTime(cnt)
	self._challengeBuyTime = cnt
end

function ArenaModel:getChallengeBuyTime()
	return self._challengeBuyTime
end

function ArenaModel:addChallengeBuyTime()
	self._challengeBuyTime = self._challengeBuyTime + 1
end

function ArenaModel:getChallengeMaxTimes()
	return self._maxChallengeTimes
end

function ArenaModel:getChallengeCdEndTime()
	return self._challengeCdEndTime
end

function ArenaModel:clearChallengeCD()
	self._challengeCdSec = 0
	self._challengeCdEndTime = ServerTime.now() - 999
end

function ArenaModel:setZoneId(zoneId)
	self._zoneId = zoneId
end

function ArenaModel:getZoneId()
	return self._zoneId
end

function ArenaModel:getPosition()
	return self._position
end

function ArenaModel:setSeasonId(seasonId)
	self._seasonId = seasonId
end

function ArenaModel:getSeasonId()
	return self._seasonId
end

function ArenaModel:setArenaId(arenaId)
	self._arenaId = arenaId
end

function ArenaModel:getArenaId()
	return self._arenaId
end

function ArenaModel:setTopGroupId(groupId)
	self._topGroupId = groupId
end

function ArenaModel:getTopGroupId()
	return self._topGroupId
end

function ArenaModel:getRefreshCD()
	return self._refreshCdSec
end

function ArenaModel:setLastWeekPrizeInfo(msg)
	self._lastWeekPrizeInfo = ArenaLastPrizeMO.New()

	self._lastWeekPrizeInfo:initMo("arenaId", msg.arenaId)
	self._lastWeekPrizeInfo:initMo("zoneId", msg.zoneId)
	self._lastWeekPrizeInfo:initMo("position", msg.position)
	self._lastWeekPrizeInfo:initMo("topGroupId", msg.topGroupId)
	self._lastWeekPrizeInfo:initMo("hasGain", msg.hasGain)
end

function ArenaModel:getLastWeekPrizeInfo()
	return self._lastWeekPrizeInfo
end

function ArenaModel:setRankPrizeMO(msg)
	self._rankPrizeMO = ArenaRankPrizeMO.New()

	self._rankPrizeMO:initMO(msg)
end

function ArenaModel:setTargets(mo)
	self._targets = {}

	if mo.allTargets and mo.allTargets.targets then
		for i, v in ipairs(mo.allTargets.targets) do
			local zoneInfo = ArenaZoneInfoMO.New()

			zoneInfo:initMo(v)
			table.insert(self._targets, zoneInfo)
		end
	end

	if mo.allTargets and mo.allTargets.sweepTarget and mo.allTargets.sweepTarget.position ~= 0 then
		local zoneInfo = ArenaZoneInfoMO.New()

		zoneInfo:initMo(mo.allTargets.sweepTarget)
		table.insert(self._targets, zoneInfo)
	end

	table.sort(self._targets, function(x, y)
		return x._position < y._position
	end)
end

function ArenaModel:getChallengers()
	return self._targets
end

function ArenaModel:getChallengersPosition(index)
	if self._targets and self._targets[index] then
		return self._targets[index]:getPosition()
	end

	return -1
end

function ArenaModel:getZoneName(zoneId)
	zoneId = zoneId or self._zoneId

	return ArenaConfig.instance:getZoneName(zoneId)
end

function ArenaModel:setUserNum(zoneId, num)
	self._userNums[zoneId] = num
end

function ArenaModel:getUserNum(zoneId)
	return self._userNums[zoneId]
end

function ArenaModel:setCurChallengerPos(pos)
	self._curChallengerPos = pos
end

function ArenaModel:getCurChallengerPos()
	return self._curChallengerPos
end

function ArenaModel:setCurChallengerUserId(userId)
	self._curChallengerUserId = userId
end

function ArenaModel:getCurChallengerUserId()
	return self._curChallengerUserId
end

function ArenaModel:setOtherPlayerForm(playerView)
	self._playerView = playerView
end

function ArenaModel:getOtherPlayerForm()
	local playerView = self._playerView
	local ret = {}
	local form = playerView.curForm

	for i = 1, 9 do
		ret[i] = -1
	end

	for i, v in ipairs(form.pos) do
		ret[i] = v
	end

	return ret
end

function ArenaModel:getOtherPetMo(id)
	local mo

	for i, v in ipairs(self._playerView.petSimpleView) do
		if v.petId == id then
			mo = BagPetMo.New()

			mo:initBaseView(v)
		end
	end

	return mo
end

function ArenaModel:getOtherHeroSkillId()
	return self._playerView.curForm.extParams.heroSkillId
end

function ArenaModel:getOtherFormatInfo()
	local extParams = self._playerView.curForm.extParams

	return extParams.formStrengthId, extParams.formStrengthLv
end

function ArenaModel:getCurExtParams()
	return (self._playerView and self._playerView.curForm and self._playerView.curForm.extParams or nil) and self._playerView.curForm.extParams
end

function ArenaModel:setOpenArenaFmtViewTag(tag)
	self._open_arenafmtview_tag = tag
end

function ArenaModel:getOpenArenaFmtViewTag()
	return self._open_arenafmtview_tag
end

function ArenaModel:setBestPosition(bestPosition)
	if self._bestPositionEver ~= -1 and bestPosition ~= 0 and bestPosition < self._bestPositionEver then
		self._upPositionData = {
			preRank = self._bestPositionEver,
			currRank = bestPosition,
			diamond = self._upPositionGetDiamond
		}
		self._upPositionGetDiamond = false
	end
end

function ArenaModel:getBestPosition()
	return self._bestPosition or 0
end

function ArenaModel:getBestPositionEver()
	return self._bestPositionEver or 0
end

function ArenaModel:getUpPositionData()
	return self._upPositionData
end

function ArenaModel:setChangeSetId(changeSetId)
	local items = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)

	if items then
		for k, v in pairs(items) do
			if v.type == 104 and v.id == 2 then
				if self._upPositionData then
					self._upPositionData.diamond = v.num
				else
					self._upPositionGetDiamond = v.num
				end
			end
		end
	end
end

function ArenaModel:resetUpPositionData()
	self._upPositionData = nil
end

function ArenaModel:getRequireMyZoneInfoTag()
	return self._isRequireMyzoneInfo
end

function ArenaModel:finishRequireMyZoneInfo()
	self._isRequireMyzoneInfo = true
end

ArenaModel.instance = ArenaModel.New()

return ArenaModel
