-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/AttackPointShakeUtil.lua

module("logic.battle.util.AttackPointShakeUtil", package.seeall)

local AttackPointShakeUtil = {}
local shakeTemplate = {
	{
		0.3333333333333333,
		0.08
	},
	{
		0.4666666666666667,
		0.12
	},
	{
		0.6666666666666666,
		0.2
	}
}

AttackPointShakeUtil.Amplitude = {
	HEAVY = 3,
	LIGHT = 1,
	MEDIUM = 2
}

function AttackPointShakeUtil.getShakeTemplate(amplitude)
	return shakeTemplate[amplitude]
end

function AttackPointShakeUtil.shake(amplitude)
	if amplitude == 0 then
		return
	end

	local settingModel = BattleMgr.instance:getSettingModel()

	if not settingModel:getShakeEnable() then
		return
	end

	local cam = VirtualCameraMgr.instance:getCinemachineBrain().ActiveVirtualCamera
	local shake = CinemachineShake.Get(cam.gameObject)
	local shakeCO = AttackPointShakeUtil.getShakeTemplate(amplitude)

	if shakeCO and shake then
		shake:Shake(BattleTime.getScaledTime(shakeCO[1]), shakeCO[2], 0)
	end
end

return AttackPointShakeUtil
