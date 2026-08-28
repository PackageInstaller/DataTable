--[[
    author:luqucheng
    time:2022-08-30 16:46:57
]]

local Shake = {}

function Shake:Evaluate()
    if BattleViewMgr.battleState ~= Constants.BattleState.Processing then
        return
    end
    local Time = CS.UnityEngine.Time
    local time = Time.time

    local allTime = 6
    local t = math.abs(time % allTime * 2 - allTime)
    local sign = math.sign(time % allTime * 2 - allTime)

    local vc = CS.Game.Native.Battle.BattleSkillCameraMgr.Instance.gameObject
    if isNull(vc) then
        return
    end
    local num = math.sin( t / allTime * math.pi)
    local angleZ = 0.5 * num * sign
    local euler = vc.transform.rotation.eulerAngles

    local r = Quaternion.Euler(euler.x, euler.y, angleZ)
    vc.transform.rotation = r
    -- vc.transform:RotateAroundZ(deltaAngleZ)
    -- vc.transform:DOLocalRotate(Vector3(0, 0, deltaAngleZ), deltaTime, CS.DG.Tweening.RotateMode.LocalAxisAdd)
end

return Shake