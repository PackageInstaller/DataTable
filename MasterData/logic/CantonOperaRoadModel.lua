-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantonoperaroad/model/CantonOperaRoadModel.lua

module("logic.extensions.cantonoperaroad.model.CantonOperaRoadModel", package.seeall)

local CantonOperaRoadModel = class("CantonOperaRoadModel", BaseModel)

function CantonOperaRoadModel:ctor()
	return
end

function CantonOperaRoadModel:onInit()
	self:onReset()
end

function CantonOperaRoadModel:onReset()
	self._activityId = 189001
	self._modelPool = {}
	self._jigsawInfo = {}
	self._bossInfo = {}

	self:clearPrizeIdListAsAnswer()
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadGetInfoRes(msg)
	self._activityId = msg.activityId
	self._isHasGainPrizeAsPv = msg.pvHasGainPrize
	self._modelPool = {}

	if msg.modelList then
		for _, mo in ipairs(msg.modelList) do
			self._modelPool[mo.modelType] = mo
		end
	end
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadAnswerInfoRes(msg)
	self._correctNumAsAnswer = msg.correctNum
	self._lastNumAsAnswer = msg.lastNum
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadAnswerRes(msg)
	return
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadAnswerSceneExitRes(msg)
	self._exitReasonAsAnswer = msg.reason
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadAnswerPrizeNotifyRes(msg)
	if msg.answerPrizeId then
		table.insert(self._prizeIdListAsAnswer, msg.answerPrizeId)
	end
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadJigsawInfoRes(msg)
	self._jigsawInfo = msg.jigsawInfo
	self._stageIdsAsJigsaw = msg.stageIds
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadJigsawClgRes(msg)
	return
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadJigsawBattleEndRes(msg)
	self._pieceInfoListAsJigsawBattleGet = msg.piece
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadLightUpRes(msg)
	self._jigsawInfo = msg.jigsawInfo
	self._changeSetIdAsLightUp = msg.changeSetId
	self._curJigsawIdAsLightUp = msg.jigsawId
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadBossInfoRes(msg)
	self._bossInfo = msg.bossInfo
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadBossClgRes(msg)
	return
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadBossBattleEndRes(msg)
	self._changeSetIdAsBoss = msg.changeSetId
	self._bossInfo = msg.bossInfo
	self._dmageAsBossChallenge = msg.damage
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadBossFormRes(msg)
	self._simpleFormAsCORBoss = msg.simpleForm
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadBossRankRes(msg)
	self._activityId = msg.activityId
	self._rankListAsBoss = msg.rankList
	self._myRankAsBoss = msg.myRank
	self._rankSizeAsBoss = msg.rankSize
end

function CantonOperaRoadModel:handlePM_CantonOperaRoadPvGetPrizeRes(msg)
	return
end

function CantonOperaRoadModel:getCurActivityId()
	return self._activityId
end

function CantonOperaRoadModel:getModelByType(modelType)
	return self._modelPool[modelType]
end

function CantonOperaRoadModel:getModelProgress(modelType)
	local mo = self:getModelByType(modelType)

	return (mo or nil) and (mo.progress or 0)
end

function CantonOperaRoadModel:getCorrectNumAsAnswer()
	return self._correctNumAsAnswer
end

function CantonOperaRoadModel:getLastNumAsAnswer()
	return self._lastNumAsAnswer
end

function CantonOperaRoadModel:getExitReasonAsAnswer()
	return self._exitReasonAsAnswer
end

function CantonOperaRoadModel:getPrizeIdListAsAnswer()
	return self._prizeIdListAsAnswer or {}
end

function CantonOperaRoadModel:clearPrizeIdListAsAnswer()
	self._prizeIdListAsAnswer = {}
end

function CantonOperaRoadModel:saveAnswerRecord(rightDelta, wrongDelta)
	self._rightNum = self._rightNum + checknumber(rightDelta)
	self._wrongNum = self._wrongNum + checknumber(wrongDelta)
end

function CantonOperaRoadModel:clearAnswerRecord()
	self._rightNum = 0
	self._wrongNum = 0
end

function CantonOperaRoadModel:getRightAnswerRecord()
	return self._rightNum or 0
end

function CantonOperaRoadModel:getWrongAnswerRecord()
	return self._wrongNum or 0
end

function CantonOperaRoadModel:getLightUpInfo(id)
	if not self._jigsawInfo.jigsaw then
		local res

		for _, info in ipairs(self._jigsawInfo.jigsaw) do
			if info.id == id then
				res = info

				break
			end
		end

		return res
	end
end

function CantonOperaRoadModel:getLightUpIdList(id)
	local info = self:getLightUpInfo(id)

	return (info or nil) and (info.lightUpIds or {})
end

function CantonOperaRoadModel:getPieceNum(pieceId)
	local num = 0

	if self._jigsawInfo and self._jigsawInfo.piece then
		for _, info in ipairs(self._jigsawInfo.piece) do
			if info.pieceId == pieceId then
				num = info.num

				break
			end
		end
	end

	return num
end

function CantonOperaRoadModel:getPieceInfoListAsJigsawBattleGet()
	return self._pieceInfoListAsJigsawBattleGet or {}
end

function CantonOperaRoadModel:clearPieceInfoListAsJigsawBattleGet()
	self._pieceInfoListAsJigsawBattleGet = {}
end

function CantonOperaRoadModel:getChangeSetIdAsLightUp()
	return self._changeSetIdAsLightUp
end

function CantonOperaRoadModel:getCurJigsawIdAsLightUp()
	return self._curJigsawIdAsLightUp
end

function CantonOperaRoadModel:getStageIdsAsJigsaw()
	return self._stageIdsAsJigsaw or {}
end

function CantonOperaRoadModel:getCustomFmtMoAsJigsaw()
	if not self._customFmtMoAsJigsaw then
		local customFmtMo = CORJigsawCustomFmtMo.New()

		self._customFmtMoAsJigsaw = self._customFmtMoAsJigsaw

		return self._customFmtMoAsJigsaw
	end
end

function CantonOperaRoadModel:getBossInfoAsCORBoss()
	return self._bossInfo
end

function CantonOperaRoadModel:getCostChallengeTimesAsCORBoss()
	return (self._bossInfo or nil) and (self._bossInfo.tdChallengeTimes or 0)
end

function CantonOperaRoadModel:getTotalDmgAsCORBoss()
	return (self._bossInfo or nil) and (self._bossInfo.totalDmg or 0)
end

function CantonOperaRoadModel:getDmageAsCORBossChallenge()
	return self._dmageAsBossChallenge or 0
end

function CantonOperaRoadModel:getRankListAsCORBoss()
	return self._rankListAsBoss or {}
end

function CantonOperaRoadModel:getMyRankAsCORBoss()
	return self._myRankAsBoss or -1
end

function CantonOperaRoadModel:getRankSizeAsCORBoss()
	return self._rankSizeAsBoss or 0
end

function CantonOperaRoadModel:getCustomFmtMoAsCORBoss()
	if not self._customFmtMoAsCORBoss then
		local customFmtMo = CORBossCustomFmtMo.New()

		self._customFmtMoAsCORBoss = self._customFmtMoAsCORBoss

		return self._customFmtMoAsCORBoss
	end
end

function CantonOperaRoadModel:getSimpleFormAsCORBoss()
	return self._simpleFormAsCORBoss
end

function CantonOperaRoadModel:isHasGainPrizeAsPv()
	return self._isHasGainPrizeAsPv == true
end

function CantonOperaRoadModel:addViewInfo(viewName, ...)
	UIJumper.instance:pushOneStack(viewName, true, ...)
end

function CantonOperaRoadModel:getViewInfos()
	return {}
end

function CantonOperaRoadModel:clearViewInfos()
	self._viewInfo = {}
end

CantonOperaRoadModel.instance = CantonOperaRoadModel.New()

return CantonOperaRoadModel
