-- @FileName:   FieldExplorationSceneConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-24 17:01:40
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationSceneConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    --场景id
    self.scene_id = cusData.scene_id
    --出生坐标
    self.born_pos = cusData.born_pos

    self.time = cusData.time

    self.eventList = {}
    for event_id, event in pairs(cusData.event_list) do
        local scale = nil
        if not table.empty(event.scale) then
            scale = gs.Vector3(event.scale[1], event.scale[2], event.scale[3])
        end

        local data =
        {
            id = event_id,
            event_id = event.event_id,
            createPos = {x = event.pos[1], y = event.pos[2], z = event.pos[3]},
            show_time = event.show_time,
            durationTime = event.duration * 0.001,
            --出生朝向
            createAngle = event.angle,
            scale = scale,
        }

        table.insert(self.eventList, data)
    end

end

return _M
