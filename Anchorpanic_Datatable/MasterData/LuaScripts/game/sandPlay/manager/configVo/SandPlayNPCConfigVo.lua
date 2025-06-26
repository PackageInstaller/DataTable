-- @FileName:   SandPlayNPCConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayNPCConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.npc_id = key

    self.type = cusData.type

    -- self.event_list = cusData.event_list
    self.event_ConfigVoList = {}
    for _, event_id in pairs(cusData.event_list) do
        local eventConfigVo = sandPlay.SandPlayManager:getEventConfigVo(event_id)
        table.insert(self.event_ConfigVoList, eventConfigVo)
    end

    self.fun_name = _TT(cusData.fun_name)
    self.name = _TT(cusData.name)
    self.icon = cusData.icon

    self.bubbleList = {}
    for k, v in pairs(cusData.bubble_txt) do
        local data = {}
        data.unLockType = v.type
        data.unLockParam = v.param
        data.text = _TT(v.txt)
        table.insert(self.bubbleList, data)
    end

    self.moveSpeed = cusData.normal_speed
    self.prefab_name = cusData.prefab_name
    self.effect_name = cusData.effect_name
    self.is_cross = cusData.is_cross == 1

    --触发范围
    self.interact_range = cusData.interact_range * 0.01
    --碰撞类型
    self.collision_type = cusData.collision_type
    --碰撞距离
    self.collision_range = cusData.collision_range
end

function getRandomBubble(self)
    if table.empty(self.mBubbleLibrary) then
        self.mBubbleLibrary = table.copy(self.bubbleList)
    end

    local index = math.random(1, #self.mBubbleLibrary)
    local bubble = self.mBubbleLibrary[index]
    table.remove(self.mBubbleLibrary, index)
    return bubble.text
end

function getSignPath(self)
    if string.NullOrEmpty(self.icon) then
        return nil
    end
    return "arts/ui/icon/sandPlay/" .. self.icon
end

return _M
