-- @FileName:   FieldExplorationEventConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationEventConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.eventId = key
    self.type = cusData.type
    self.skill_id = cusData.skill_id
    self.delay_time = cusData.delay_time * 0.001
    self.normal_speed = cusData.normal_speed
    self.prefab_name = cusData.prefab_name
    self.is_cross = cusData.is_cross == 1
    self.interact_type = cusData.interact_type
    self.interact_range = cusData.interact_range

    if table.empty(cusData.interact_center) then
        self.interact_center = gs.VEC3_ZERO
    else
        self.interact_center = gs.Vector3(cusData.interact_center[1] * 0.01, cusData.interact_center[2] * 0.01, cusData.interact_center[3] * 0.01)
    end

    self.movePos = {}

    for i = 1, #cusData.movePos do
        self.movePos[i] = {x = cusData.movePos[i][1][1], y = 0, z = cusData.movePos[i][1][2], time = cusData.movePos[i][2]}
    end

    self.trigger_type = cusData.trigger_type
    self.repeat_type = cusData.is_repeat

    self.goin_effct = cusData.effect[1]
    self.stand_effct = cusData.effect[2]
    self.idle_effct = cusData.effect[3]
    self.atk_effct = cusData.effect[4]

    self.goin_sound = cusData.sound_effect[1]
    self.stand_sound = cusData.sound_effect[2]
    self.idle_sound = cusData.sound_effect[3]
    self.atk_sound = cusData.sound_effect[4]
end

return _M
