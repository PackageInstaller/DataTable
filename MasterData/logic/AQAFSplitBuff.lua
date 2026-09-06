-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFSplitBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFSplitBuff", package.seeall)

local AQAFSplitBuff = class("AQAFSplitBuff", AQAFBuffBase)

function AQAFSplitBuff:onBuffTrigger()
	local prams = {}

	for i, v in ipairs(self._tiggerParam) do
		local paramsArr = string.split(v, ":")

		prams[paramsArr[1]] = checknumber(paramsArr[2])
	end

	local atkRate = checknumber(prams.atkRate)
	local hpRate = checknumber(prams.hpRate)
	local count = checknumber(prams.count)
	local modelId = checknumber(prams.modelId)
	local params = {}

	if self._target.getParams then
		local copyParams = self._target:getParams()

		params.isBoss = copyParams.isBoss
		params.modelId = modelId > 0 and modelId or copyParams.modelId
		params.CD = copyParams.CD
		params.moveSpeed = copyParams.moveSpeed
		params.magicDamRate = copyParams.magicDamRate
		params.phyDamRate = copyParams.phyDamRate
		params.shield = copyParams.shield
		params.atkRange = copyParams.atkRange
		params.atkType = copyParams.atkType
		params.bulletId = copyParams.bulletId
		params.MaxHp = copyParams.MaxHp * hpRate
		params.Atk = copyParams.Atk * atkRate
		params.bornBuffId = 0

		for i = 1, count do
			local monster = AoQiAttackForceGameController.instance:createMonster(params, true)

			monster:updatePosition(self._target.position.x + math.random(-30, 30), self._target.position.y + math.random(-50, 50))
			monster:initMoveDir()
			GlobalDispatcher:dispatch(GlobalNotify.AQAFGameCreateUnit, monster)
		end

		GlobalDispatcher:dispatch(GlobalNotify.AQAFShowAlertTxt, lang("分裂"), self._target.position.x, self._target.position.y + 50, AQAFSimpleFloatTipsMgr.TYPE_SPLIT_TEXT)
	end
end

return AQAFSplitBuff
