module("formation.FormationDistributeManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- 此类为了派发事件到对应的控制器，或修改对应继承而来的方法

-- 请求打开剧情队员分配选择界面
OPEN_FORMATION_DISTRIBUTE_SELECT_PANEL = "OPEN_FORMATION_DISTRIBUTE_SELECT_PANEL"

-- 请求设置支援队员列表
REQ_SET_SUPPORT_HERO = "REQ_SET_SUPPORT_HERO"
-- 响应设置支援队员列表
RES_SET_SUPPORT_HERO = "RES_SET_SUPPORT_HERO"

-- 请求获取支援队员列表
REQ_GET_SUPPORT_HERO = "REQ_GET_SUPPORT_HERO"
-- 响应获取支援队员列表
RES_GET_SUPPORT_HERO = "RES_GET_SUPPORT_HERO"

function __initData(self)
    super.__initData(self)
    
    -- 选择的阵容英雄列表字典
    self:instance().m_DistributeDic = {}
end

function getDistributeDic(self)
    return self:instance().m_DistributeDic
end

-- 解析从服务器获取的分配数据
function parseDistributeData(self, battleType, dupId, supportList)
    local index_1
    local selectList_1
    local index_2
    local selectList_2
    for k, v in pairs(supportList) do
        if(v.team_index == 1)then
            index_1 = v.team_index
            selectList_1 = v.support_id_list
        elseif(v.team_index == 2)then
            index_2 = v.team_index
            selectList_2 = v.support_id_list
        end
    end
    if(index_1 and selectList_1 and index_2 and selectList_2)then
        self:setDistributeData(battleType, dupId, index_1, selectList_1, index_2, selectList_2)
        self:dispatchEvent(self.RES_GET_SUPPORT_HERO, {})
    else
        print(string.format("副本类型%s副本id%s返回的分配数据有误", battleType, dupId))
    end
end

function setDistributeData(self, battleType, dupId, index_1, selectList_1, index_2, selectList_2)
    local dic = self:getDistributeDic()
    local key = self:getKey(battleType, dupId)
    dic[key] = {}
    local data = {}
    data.teamIndex = index_1
    data.selectIdList = selectList_1
    table.insert(dic[key], data)

    local data = {}
    data.teamIndex = index_2
    data.selectIdList = selectList_2
    table.insert(dic[key], data)
end

function getDistributeData(self, battleType, dupId)
    local storyRo = self:getData()
    battleType = battleType and battleType or storyRo:getBattleType()
    dupId = dupId and dupId or storyRo:getBattleFieldId()
    local key = self:getKey(battleType, dupId)
    local data = self:getDistributeDic()[key]
    if(not data)then
        self:dispatchEvent(self.REQ_GET_SUPPORT_HERO, {battleType = battleType, dupId = dupId})
    end
    return data
end

function getDistributeSelectList(self, battleType, dupId, teamIndex)
    local list = self:getDistributeData(battleType, dupId)
    if(list)then
        for k, v in pairs(list) do
            if(v.teamIndex == teamIndex)then
                local copyList = {}
                for i = 1, #v.selectIdList do
                    table.insert(copyList, v.selectIdList[i])
                end
                return copyList
            end
        end
    end
    return {}
end

-- 剧情对话特殊调用
function getMonsterConfigVoByStory(self, battleType, dupId, teamIndex, monsterIndex)
    local selectIdList = self:getDistributeSelectList(battleType, dupId, teamIndex)
    local monsterId = -1 
    local _monsterIndex = 0
    for i = 1, #selectIdList do
        _monsterIndex = _monsterIndex + 1
        if(_monsterIndex == monsterIndex)then
            monsterId = selectIdList[i]
        end
    end
    if(monsterId > 0)then
        local monsterTidVo = monster.MonsterManager:getMonsterVo(monsterId)
        if(monsterTidVo)then
            return monsterTidVo:getBaseConfig()
        else
            print("剧情获取分配的怪物数据错误")
            return nil
        end
    else
        return nil
    end
end

function getKey(self, battleType, dupId)
    return battleType.."_"..dupId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
