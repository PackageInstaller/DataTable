-- @FileName:   SandPlayTreasureBoxThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayTreasureBoxThing', Class.impl(sandPlay.SandPlayNPCThing))

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    local isCanTrigger = true
    if not table.empty(self.mData.config.pre_event) then
        for _, eventInfo in pairs(self.mData.config.pre_event) do
            local npc_id = eventInfo[1]
            local event_id = eventInfo[2]
            if not sandPlay.SandPlayManager:getMapEventIsPass(nil, npc_id, event_id) then
                isCanTrigger = false
            end
        end
    end

    local path = ""
    if isCanTrigger then
        if string.find(self.mData.config.base_config.prefab_name, "modeldx_prop_01_box") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_01.prefab"
        elseif string.find(self.mData.config.base_config.prefab_name, "modeldx_prop_02_box") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_02.prefab"
        elseif string.find(self.mData.config.base_config.prefab_name, "modelnewyear_box_a") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_newyear_box_a.prefab"
        elseif string.find(self.mData.config.base_config.prefab_name, "modelnewyear_box_b") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_newyear_box_a.prefab"
        end
    else
        if string.find(self.mData.config.base_config.prefab_name, "modeldx_prop_01_box") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_01_suo.prefab"
        elseif string.find(self.mData.config.base_config.prefab_name, "modeldx_prop_02_box") then
            path = "arts/fx/3d/scene/dx_101/fx_scene_dx_101_box_02_suo.prefab"
        end
    end
    if not string.NullOrEmpty(path) then
        self:addEffect(path, -1)
    end

    for _, eventConfigVo in pairs(self.mData.config.base_config.event_ConfigVoList) do
        if sandPlay.SandPlayManager:getMapEventIsPass(nil, self.mData.config.base_config.npc_id, eventConfigVo.event_id) then
            self:playAction("After")
            return
        end
    end

    self:playAction("shut")
end

function getModel(self)
    return sandPlay.SandPlayNPCModel.new()
end

return _M
