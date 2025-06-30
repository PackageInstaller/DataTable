--[[ 
-----------------------------------------------------
@filename       : HeroActionManager
@Description    : 英雄动作管理
@date           : 2022-7-12 20:04:51
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.hero.manager.HeroActionManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.mConfigData = nil
end

-- 解析英雄互动配置
function parseConfigData(self)
    self.mConfigData = {}
    local baseData = RefMgr:getData("hero_action_data")
    for key, data in pairs(baseData) do
        if not self.mConfigData[key] then
            self.mConfigData[key] = {}
        end
        for action_id, v in pairs(data.action) do
            if not self.mConfigData[key].action then
                self.mConfigData[key].action = {}
            end

            local acitonHash = gs.Animator.StringToHash(v.action)
            if not self.mConfigData[key].action[acitonHash] then
                self.mConfigData[key].action[acitonHash] = {}
            end
            self.mConfigData[key].action[acitonHash].action_id = action_id
            self.mConfigData[key].action[acitonHash].items = v.item
            self.mConfigData[key].action[acitonHash].unlock_item = v.unlock_item
        end

        if not table.empty(data.always_item) then
            self.mConfigData[key].always_item = data.always_item
        end
    end
end

-- 获取英雄动作配置数据
function getConfigData(self, model_id)
    if not self.mConfigData then
        self:parseConfigData()
    end
    return self.mConfigData[model_id]
end

function getConfigAcitonItems(self, model_id, actionHash)
    local baseData = self:getConfigData(model_id)
    if baseData == nil or table.empty(baseData) then
        return nil
    end
    if baseData.action == nil or table.empty(baseData.action) then return nil end
    if baseData.action[actionHash] == nil or table.empty(baseData.action[actionHash]) then
        return nil
    end
    if baseData.action[actionHash].items == nil or table.empty(baseData.action[actionHash].items) then
        return nil
    end

    return baseData.action[actionHash].items
end

--获取当前看板娘动作是否需要道具解锁
function getActionIsNeedItemOpen(self, model_id, actionHash)
    local baseData = self:getConfigData(model_id)
    if baseData == nil or table.empty(baseData) then
        return false
    end
    if baseData.action == nil or table.empty(baseData.action) then
        return false
    end
    if baseData.action[actionHash] == nil or table.empty(baseData.action[actionHash]) then
        return false
    end

    return baseData.action[actionHash].unlock_item ~= 0
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]