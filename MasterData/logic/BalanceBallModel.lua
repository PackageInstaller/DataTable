-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/balanceball/model/BalanceBallModel.lua

module("logic.extensions.balanceball.model.BalanceBallModel", package.seeall)

local BalanceBallModel = class("BalanceBallModel")

BalanceBallModel.ConstParam = {
	handOpt = {
		drag = 0.7,
		balanceFactor = 0.05,
		bounciness = 1,
		force = 30,
		mass = 1
	},
	gravityOpt = {
		drag = 0.7,
		balanceFactor = 0.05,
		bounciness = 1,
		force = 100,
		mass = 1
	}
}
BalanceBallModel.EControlType = {
	Gravity = 1,
	RightKey = 2,
	LeftKey = 0
}

function BalanceBallModel:ctor()
	self:reset()
end

function BalanceBallModel:reset()
	self._lastSceneType = 0
	self._lastSceneId = 0
	self._controlType = 0
	self._levelId = 0
	self._curGotScore = 0
	self._curScore = 0
	self._totalScoreWithoutCurrent = 0
	self._lifeNum = 0
	self._targetScore = 0
end

function BalanceBallModel:setControlType(cType)
	printInfo("cType:================" .. cType)

	self._controlType = cType
end

function BalanceBallModel:setAddScore(addScore)
	self._curScore = self._curScore + addScore

	return self._curScore
end

function BalanceBallModel:getCurScore()
	return self._curScore
end

function BalanceBallModel:getNewGetScore()
	local score = self._curScore - self._curGotScore

	if score < 0 then
		return 0
	else
		return score
	end
end

function BalanceBallModel:getNewTotalScore()
	return self:getNewGetScore() + self:getTotalScoreWithoutCurrent()
end

function BalanceBallModel:setServerExtTableParam(extTableParam, levelId)
	local scores = 0

	for i, v in ipairs(extTableParam.collected_stars) do
		scores = scores + v

		if i == levelId + 1 then
			self._curGotScore = v
		end
	end

	self._totalScoreWithoutCurrent = scores
	self._lifeNum = extTableParam.blood
end

function BalanceBallModel:getTotalScoreWithoutCurrent()
	return self._totalScoreWithoutCurrent
end

function BalanceBallModel:getLifeNum()
	return self._lifeNum
end

function BalanceBallModel:setTargetScore(num)
	self._targetScore = num
end

function BalanceBallModel:getTargetScore()
	return self._targetScore
end

function BalanceBallModel:setLastScene(type, id)
	self._lastSceneType = type
	self._lastSceneId = id
end

function BalanceBallModel:setLevelId(levelId)
	self._levelId = levelId
end

function BalanceBallModel:getLevelId()
	return self._levelId
end

function BalanceBallModel:getLastSceneType()
	return self._lastSceneType
end

function BalanceBallModel:getLastSceneId()
	return self._lastSceneId
end

function BalanceBallModel:getControlType()
	if self._controlType ~= 1 then
		return self._controlType
	elseif UnityEngine.SystemInfo.supportsGyroscope then
		return self._controlType
	else
		return 2
	end
end

function BalanceBallModel:getControlUIType()
	return self._controlType
end

function BalanceBallModel:getParamByControlType()
	if self._controlType == self.EControlType.Gravity then
		return self.ConstParam.gravityOpt
	else
		return self.ConstParam.handOpt
	end
end

BalanceBallModel.instance = BalanceBallModel.New()

return BalanceBallModel
