module("hero.HeroUseCodeManager", Class.impl(Manager))

-- 英雄使用码更新
UPDATE_HERO_USECODE = "UPDATE_HERO_USECODE"

-- 英雄可使用
OKAY = 0
-- 英雄在进攻队列阵型中
IN_TEAM_FORMATION = 1
-- 英雄在竞技场防守队列阵型中
IN_ARENA_DEFENSE = 2
-- 英雄在展示面板中
IN_SHOWING = 3
-- 英雄在上锁中
IN_LOCKING = 4
-- 英雄在导力中
IN_HELPER_HELPED = 5

--英雄在探索中
IN_EXPLORE = 6
--英雄在迷宫中
IN_MAZE = 7
--英雄在宿舍中
IN_DORMITORY = 8
--英雄在助战中
IN_ASSIST_FIGHT = 9

-- 英雄在看板娘板中
-- IN_SHOW_BOARD = 1000

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.m_heroUseDic = {}
end
--是否屏蔽此功能  后端已将可删除战员列表协议返回屏蔽
function isShied(self)
    return true
end

function parseHeroList(self, cusList)
    self.m_heroUseDic = {}
    for i = 1, #cusList do
        if (not self.m_heroUseDic[cusList[i].hero_id]) then
            self.m_heroUseDic[cusList[i].hero_id] = {}
        end
        table.insert(self.m_heroUseDic[cusList[i].hero_id], cusList[i].reason)
    end

    local function _sortReqson(reason1, reason2)
        local index1 = self:_getSortIndex(reason1)
        local index2 = self:_getSortIndex(reason2)
        if (index1 ~= index2) then
            return index1 < index2
        else
            return false
        end
    end
    for heroId, reasonList in pairs(self.m_heroUseDic) do
        table.sort(reasonList, _sortReqson)
    end
    self:dispatchEvent(self.UPDATE_HERO_USECODE, {})
end

function _getSortIndex(self, reason)
    if (not self.mSortIndexDic) then
        self.mSortIndexDic = {}
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_ASSIST_FIGHT] = 1
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_TEAM_FORMATION] = 2
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_MAZE] = 3
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_ARENA_DEFENSE] = 4
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_HELPER_HELPED] = 5
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_EXPLORE] = 6
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_SHOWING] = 7
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_LOCKING] = 8
        self.mSortIndexDic[hero.HeroUseCodeManager.IN_DORMITORY] = 9
    end
    return self.mSortIndexDic[reason]
end

function getUseCodeListByHeroId(self, heroId)
    local useCodeList = self.m_heroUseDic[heroId]
    if (useCodeList) then
        return useCodeList
    else
        return {}
    end
end

function getFirstUseCodeByHeroId(self, heroId)
    local useCodeList = self:getUseCodeListByHeroId(heroId)
    if (useCodeList and #useCodeList > 0) then
        return useCodeList[1]
    else
        return -1
    end
end

function isInUse(self, heroId, useCode)
    if self:isShied() then
        return true
    else
        local useCodeList = self:getUseCodeListByHeroId(heroId)
        if (useCodeList and #useCodeList > 0) then
            return table.indexof(useCodeList, useCode) ~= false
        else
            return false
        end
    end
end

-- 判断战员是否可操作使用
function getIsCanUse(self, heroId, isShowTip, exceptUseCodeList)
    local isCanUse = true
    local isExcept = false
    local useCode = nil
    local useCodeList = self:getUseCodeListByHeroId(heroId)
    if (exceptUseCodeList and #exceptUseCodeList > 0) then
        for i = 1, #useCodeList do
            if (table.indexof(exceptUseCodeList, useCodeList[i]) == false) then
                useCode = useCodeList[i]
                isExcept = false
                break
            else
                isExcept = true
            end
        end
    else
        useCode = self:getFirstUseCodeByHeroId(heroId)
    end
    if (useCode == self.OKAY) then
        isCanUse = true

    elseif (not isExcept and useCode == self.IN_TEAM_FORMATION) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1101))
        end

    elseif (not isExcept and useCode == self.IN_ARENA_DEFENSE) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1102))
        end

    elseif (not isExcept and useCode == self.IN_SHOWING) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1194)) -- 无法选择展示中的战员
        end

    elseif (not isExcept and useCode == self.IN_LOCKING) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1103))
        end

    elseif (not isExcept and useCode == self.IN_HELPER_HELPED) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1145)) -- 无法选择看导力中的战员
        end

    elseif (not isExcept and useCode == self.IN_EXPLORE) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1123))
        end

    elseif (not isExcept and useCode == self.IN_MAZE) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1144)) -- 无法选择在迷宫中出战的战员
        end

    elseif (not isExcept and useCode == self.IN_DORMITORY) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1144)) -- 无法选择在宿舍中的战员
        end

    elseif (not isExcept and useCode == self.IN_ASSIST_FIGHT) then
        isCanUse = false
        if (isShowTip) then
            gs.Message.Show(_TT(1144)) -- 无法选择在助战中的战员
        end

        -- elseif (not isExcept and useCode == self.IN_SHOW_BOARD) then
        --     isCanUse = false
        --     if (isShowTip) then
        --         gs.Message.Show("无法选择看板娘板中的战员")
        --     end
    end

    return isCanUse
end

--判断战员是否在主线出战队列中
function isOnUseCode(self, heroId, isFlag)
    local fightTeamId = formation.FormationManager:getFightTeamId(true)
    local formationHeroList = formation.FormationManager:getSelectFormationHeroList(fightTeamId)
    if (formationHeroList) then
        for i = 1, #formationHeroList do
            if (formationHeroList[i].heroId == heroId) then
                return isFlag
            end
        end
    end
    return false
end

-- 获取战员不能操作使用的提示icon图（优先级）
function getIconByHeroUseCode(self, heroId)
    local useCodeList = self:getUseCodeListByHeroId(heroId)
    if (useCodeList and #useCodeList > 0) then
        self:getIconByUseCode(useCodeList[1])
    else
        return self:getIconByUseCode(nil)
    end
end

-- 获取战员不能操作使用的提示icon图（这里的资源是统一规格的头像专用，按需取）
function getIconByUseCode(self, useCode)
    local iconUrl = ""
    if (useCode == self.IN_TEAM_FORMATION) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_1.png")
    elseif (useCode == self.IN_ARENA_DEFENSE) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_4.png")
    elseif (useCode == self.IN_SHOWING) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_2.png")
    elseif (useCode == self.IN_LOCKING) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_3.png")
    elseif (useCode == self.IN_HELPER_HELPED) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_5.png")
    elseif (useCode == self.IN_EXPLORE) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_6.png")
    elseif (useCode == self.IN_MAZE) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_1.png")
    elseif (useCode == self.IN_ASSIST_FIGHT) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_x.png")
    elseif (useCode == self.IN_DORMITORY) then
        iconUrl = UrlManager:getPackPath("hero/hero_use_code_x.png")
        -- elseif (useCode == self.IN_SHOW_BOARD) then
        --     iconUrl = "hero_formation_other_8.png"
    end
    return iconUrl
end

-- 获取战员不能操作使用的提示文本（优先级）
function getTipByHeroUseCode(self, heroId)
    local useCodeList = self:getUseCodeListByHeroId(heroId)
    if (useCodeList and #useCodeList > 0) then
        return self:getTipByUseCode(useCodeList[1]), self:getTipColorByUseCode(useCodeList[1])
    else
        return self:getTipByUseCode(nil), self:getTipColorByUseCode(nil)
    end
end

-- 获取战员不能操作使用的提示文本
function getTipByUseCode(self, useCode)
    local tip = ""
    if (useCode == self.IN_TEAM_FORMATION) then
        tip = _TT(1174) --"出战中"
    elseif (useCode == self.IN_ARENA_DEFENSE) then
        tip = "防守中"
    elseif (useCode == self.IN_SHOWING) then
        tip = "展示中"
    elseif (useCode == self.IN_LOCKING) then
        tip = "上锁中"
    elseif (useCode == self.IN_HELPER_HELPED) then
        tip = "助手中"
    elseif (useCode == self.IN_EXPLORE) then
        tip = "探索中"
    elseif (useCode == self.IN_MAZE) then
        tip = "迷宫中"
    elseif (useCode == self.IN_ASSIST_FIGHT) then
        tip = "助战中"
    elseif (useCode == self.IN_DORMITORY) then
        tip = "宿舍中"
        -- elseif (useCode == self.IN_SHOW_BOARD) then
        --     tip = "展示中"
    end
    return tip
end

-- 获取战员不能操作使用的提示文本颜色
function getTipColorByUseCode(self, useCode)
    local color = "ffffffff"
    if (useCode == self.IN_TEAM_FORMATION) then
        color = "18ec68ff"
    elseif (useCode == self.IN_ARENA_DEFENSE) then
    elseif (useCode == self.IN_SHOWING) then
    elseif (useCode == self.IN_LOCKING) then
    elseif (useCode == self.IN_HELPER_HELPED) then
    elseif (useCode == self.IN_EXPLORE) then
    elseif (useCode == self.IN_MAZE) then
    elseif (useCode == self.IN_ASSIST_FIGHT) then
        color = "5bffbfff"
    elseif (useCode == self.IN_DORMITORY) then
        -- elseif (useCode == self.IN_SHOW_BOARD) then
    end
    return gs.ColorUtil.GetColor(color)
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]