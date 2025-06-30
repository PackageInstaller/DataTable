--[[ 
-----------------------------------------------------
@filename       : BossShowCofingVo
@Description    : BOSS战斗非技能演出配置
@date           : 2022-11-05 19:39:53
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("fight.BossShowCofingVo", Class.impl())

function parseData(self, cusModelId, cusData)
    self.modelId = cusModelId
    self.leaveEff = cusData.leave_eff
    self.leaveEffPoint = cusData.leave_eff_point
    self.enterEff = cusData.enter_eff
    self.enter01Eff = cusData.enter01_eff

    self.standbyEff = cusData.standby_eff
    self.changeEff = cusData.change_eff
    -- 01还没用到
    self.change02Eff = cusData.change02_eff
    self.standbySound = cusData.standby_sound
    self.leaveSound = cusData.leave_sound
    self.enterSound = cusData.enter_sound
    self.enter01Sound = cusData.enter01_sound
    self.changeSound = cusData.change_sound
    -- 01还没用到
    self.change02Sound = cusData.change02_sound
    self.standbyCv = cusData.standby_cv
    self.leveaCv = cusData.levea_cv
    self.enterMusic = cusData.enter_music
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]