-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/buff/AQAFNewBulletBuff.lua

module("logic.extensions.aoqiattackforce.minigame.buff.AQAFNewBulletBuff", package.seeall)

local AQAFNewBulletBuff = class("AQAFNewBulletBuff", AQAFBuffBase)
local params = {}

function AQAFNewBulletBuff:onBuffTrigger()
	local num = checknumber(self._tiggerParam[1])

	if self._unit:getTag() == AQAFGameEnum.UnitTag.Bullet then
		for i = 1, num do
			params.CriRate = self._unit._CriRate
			params.CriDamRate = self._unit._CriDamRate
			params.Atk = self._unit._Atk
			params.bulletId = self._unit.bulletId
			params.position = self._unit.position
			params.owner = self._unit.owner
			params.dirX = 1
			params.dirY = math.random(-1, 1)
			params.hasHitIds = {
				self._target.id
			}

			AoQiAttackForceGameController.instance:createBullet(params, true)
		end
	end
end

return AQAFNewBulletBuff
