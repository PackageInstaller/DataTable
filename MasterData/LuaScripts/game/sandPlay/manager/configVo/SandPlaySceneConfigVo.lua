-- @FileName:   SandPlaySceneConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlaySceneConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.scene_id = cusData.scene_id
    self.born_pos = {x = cusData.born_pos[1], y = cusData.born_pos[2], z = cusData.born_pos[3]}
    self.born_angle = cusData.born_angle

    self.hero_id = cusData.hero_id
    self.minimap = cusData.minimap
    self.camera_rotation = cusData.camera_rotation
    self.camera_distance = cusData.camera_distance
    self.map_load_res = cusData.map_load_res

    self.npcList = {}
    for id, sceneconfig in pairs(cusData.npc_list_data) do
        local data = {}
        data.id = sceneconfig.npc_id
        data.pos = {x = sceneconfig.pos[1], y = sceneconfig.pos[2], z = sceneconfig.pos[3]}
        data.angle = sceneconfig.angle

        --前置事件，需要触发了这些事件才能触发这个NPC
        data.pre_event = sceneconfig.pre_event

        --显示事件
        data.show_Dt = table.empty(sceneconfig.begin_time) and 0 or TimeUtil.transTime(sceneconfig.begin_time)
        --隐藏时间
        data.hide_Dt = table.empty(sceneconfig.end_time) and 0 or TimeUtil.transTime(sceneconfig.end_time)

        --显示的活动关卡id
        data.show_condition = sceneconfig.show_condition
        --隐藏的活动关卡id
        data.hide_condition = sceneconfig.hide_condition

        if sceneconfig.find_type ~= 0 and not table.empty(sceneconfig.movePos) then
            data.patrol_config = {type = sceneconfig.find_type, speed = sceneconfig.move_speed * 0.01}
            --移动点
            data.patrol_config.path = {}

            local movePos = sceneconfig.movePos
            for i = 1, #movePos do
                data.patrol_config.path[i] = {x = movePos[i][1], y = movePos[i][2], z = movePos[i][3]}
            end
        end

        data.base_config = sandPlay.SandPlayManager:getNPCConfigVo(sceneconfig.npc_id)

        self.npcList[sceneconfig.npc_id] = data
    end

    self.guideList = {}
    for guide_id, guide_data in pairs(cusData.guide_data) do
        local data = {}
        data.name = _TT(guide_data.name)
        data.icon = "arts/ui/icon/sandPlay/" .. guide_data.icon
        data.param = guide_data.param
        data.activityList = guide_data.activity_id
        data.red_id = guide_data.red_id or 0
        self.guideList[guide_id] = data
    end
end

function savePlayerScenePosOnPrefab(self, pos, angle)
    local key = gstor.SANDPLAY_PLAYER_POSITION .. self.scene_id
    local tab = {pos = pos, angle = angle}
    StorageUtil:saveTable1(key, tab)
end

function getPlayerPositionTab(self)
    local key = gstor.SANDPLAY_PLAYER_POSITION .. self.scene_id
    return StorageUtil:getTable1(key)
end

--获取玩家的出生位置
function getPlayerBornPos(self)
    local outside_pos = sandPlay.SandPlayManager:getPlayerThingScenePos()
    if outside_pos == nil then
        local posData = self:getPlayerPositionTab()
        if posData == nil then
            return self.born_pos
        else
            return posData.pos
        end
    else
        return outside_pos
    end
end

function getPlayerBornAngle(self)
    local posData = self:getPlayerPositionTab()
    if posData == nil then
        return self.born_angle
    else
        return posData.angle
    end
end

function getMinMapPath(self)
    if string.NullOrEmpty(self.minimap) then
        return nil
    end
    return "arts/ui/bg/sandPlay/" .. self.minimap
end

function getHeroVo(self)
    local heroConfig = sandPlay.SandPlayManager:getHeroConfigVo(self.hero_id)

    return {bornPos = self:getPlayerBornPos(), bornAngle = self:getPlayerBornAngle(), config = heroConfig, id = self.hero_id}
end

return _M
