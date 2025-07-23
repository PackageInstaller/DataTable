module("preFight.BaseManager", Class.impl("game.preFight.base.preFightShow.manager.PreFightShowEventDispatcher"))


-------------------备战选择英雄界面-----------------------------
-- 打开备战选择英雄界面
OPEN_PRE_FIGHT_PANEL = "OPEN_PRE_FIGHT_PANEL"
-- 请求开始战斗
REQ_START_BATTLE = "REQ_START_BATTLE"
-- 更新列表item
UPDATE_LIST_ITEM = "UPDATE_LIST_ITEM"
-- 备战选择英雄界面选择临时变动
PREP_FIGHT_SELECT_TEMP_CHANGE = "PREP_FIGHT_SELECT_TEMP_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

function __init(self)
    -- 攻方：每个模型的配置位置
    self.m_attPosDic = {
        [1] = { x = -180, y = 152 },
        [2] = { x = -180, y = 17 },
        [3] = { x = -420, y = 220 },
        [4] = { x = -420, y = 85 },
        [5] = { x = -420, y = -50 },
    }

    -- 守方：每个模型的配置位置
    self.m_defPosDic = {
        [1] = { x = 180, y = 152 },
        [2] = { x = 180, y = 17 },
        [3] = { x = 420, y = 220 },
        [4] = { x = 420, y = 85 },
        [5] = { x = 420, y = -50 },
    }
    -- 进攻目标副本id
    self.targetId = 0
    -- 供界面临时选择用的
    self.m_tempShowList = {}
    self.m_isAttackerSetting = true

    self.m_showList = {}
    -- 设置攻方
    local posDic = self:getPosDic(true)
    for index, pos in pairs(posDic) do
        local showVo = LuaPoolMgr:poolGet(preFight.ModelShowVo)
        showVo.index = index
        showVo.isAttacker = true
        showVo.pos = gs.Vector3(pos.x, pos.y, 0)
        showVo.heroVo = nil
        table.insert(self.m_showList, showVo)
    end
    -- 设置守方
    posDic = self:getPosDic(false)
    for index, pos in pairs(posDic) do
        local showVo = LuaPoolMgr:poolGet(preFight.ModelShowVo)
        showVo.index = index
        showVo.isAttacker = false
        showVo.pos = gs.Vector3(pos.x, pos.y, 0)
        showVo.heroVo = nil
        table.insert(self.m_showList, showVo)
    end
    -- 攻守方默认全英雄
    local attList = hero.HeroManager:getHeroList(true)
    local defList = hero.HeroManager:getHeroList(false)
    for _, showVo in pairs(self.m_showList) do
        local list
        if (showVo.isAttacker) then
            list = attList
        else
            list = defList
        end
        for i = 1, #list do
            if (showVo.index == i) then
                showVo.heroVo = list[i]
                break
            end
        end
    end
end

function getPosDic(self, cusIsAttacker)
    if (cusIsAttacker) then
        return self.m_attPosDic
    else
        return self.m_defPosDic
    end
end

function isEnoughHero(self)
    local isEnoughAtt = false
    local isEnoughDef = false
    local tempShowList = self:getTempShowList()
    for _, showVo in pairs(tempShowList) do
        if (showVo.heroVo) then
            if (showVo.isAttacker) then
                isEnoughAtt = true
            else
                isEnoughDef = true
            end
        end
    end
    if (not isEnoughAtt) then
        gs.Message.Show("请选择攻方英雄")
        return false
    end
    -- if (not isEnoughDef) then
    --     gs.Message.Show("请选择守方英雄")
    --     return false
    -- end
    return true
end

-- 获取展示vo列表
function getShowList(self, cusIsAttacker)
    local tempShowList = {}
    for _, showVo in pairs(self.m_showList) do
        if (cusIsAttacker == nil or showVo.isAttacker == cusIsAttacker) then
            local tempShowVo = LuaPoolMgr:poolGet(preFight.ModelShowVo)
            table.insert(tempShowList, tempShowVo:copy(showVo))
        end
    end
    return tempShowList
end

-- 获取临时的展示vo列表
function getTempShowList(self)
    if (self.m_tempShowList == nil or #self.m_tempShowList == 0) then
        self.m_tempShowList = self:getShowList()
    end
    return self.m_tempShowList
end

-- 获取临时的展示vo
function getTempShowVo(self, cusIsAttacker, cusIndex)
    local tempShowList = self:getTempShowList()
    for _, showVo in pairs(tempShowList) do
        if (showVo.isAttacker == cusIsAttacker and showVo.index == cusIndex) then
            return showVo
        end
    end
    return nil
end

-- 将临时展示vo列表更新到正式的展示vo列表
function updateShowList(self)
    for _, showVo in pairs(self.m_showList) do
        LuaPoolMgr:poolRecover(showVo)
    end
    self.m_showList = self.m_tempShowList
    -- 这里整体赋值给了self.m_showList，就不能再对self.m_tempShowList进行回收了
    self.m_tempShowList = {}
end

-- 重置临时的展示vo列表
function resetTempShowList(self, cusIsAttacker)
    -- 全部重置
    if (cusIsAttacker == nil) then
        for _, showVo in pairs(self.m_tempShowList) do
            LuaPoolMgr:poolRecover(showVo)
        end
        self.m_tempShowList = {}
    else
        for _, showVo in pairs(self.m_tempShowList) do
            if (showVo.isAttacker == cusIsAttacker) then
                showVo.heroVo = nil
            end
        end
    end
end

-- 当前是否攻方排阵
function getIsAttackerSetting(self)
    return self.m_isAttackerSetting
end
function setIsAttackerSetting(self, cusIsAttacker)
    self.m_isAttackerSetting = cusIsAttacker
end

--析构函数
function dtor(self)
end

------------------------------------------------------子类必须实现方法------------------------------------------------------
function getBattleType(self)
    return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
