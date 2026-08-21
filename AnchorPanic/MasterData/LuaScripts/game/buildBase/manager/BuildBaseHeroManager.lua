--[[ 
-----------------------------------------------------
@filename       : BuildBaseHeroManager
@Description    : 战舰(基建)- 战员管理器
@date           : 2023/3/25
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.buildBase.manager.BuildBaseHeroManager', Class.impl(Manager))

------------------------------------------------------------
--构造函数
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构函数
function dtor(self)

end

-- Override 重置数据
function resetData(self)
    self:init()
end

function init(self)
    --基建战员配置表
    self.mBuildBaseHeroSkillConfig = {}
    --基建战员Msg
    self.mBuildBaseHeroInfos = {}
    -- 战舰派遣人员列表
    self.mDispatchMemList = {}
    -- 战员入住字典 <buildId,heroTid> 
    self.mHeroSettleInList = {}
    -- 上一次战员入住信息 记录
    self.mLastHeroSettleList = {}
    --战员位置是否改变
    self.mHasHeroMoved = false

end

---------------------------------------------------------------- 服务器数据 ----------------------------------------------------------------
function parseBuildBaseHeroMsg(self, heroMsg)
    if next(heroMsg) then
        for _, hero in pairs(heroMsg) do
            if (self.mBuildBaseHeroInfos[hero.hero_tid]) then
                self.mBuildBaseHeroInfos[hero.hero_tid]:parseData(hero)
            else
                local vo = LuaPoolMgr:poolGet(buildBase.BuildBaseHeroMsgVo)
                vo:parseData(hero)
                self.mBuildBaseHeroInfos[vo.tid] = vo
            end
        end
        self.mLastHeroSettleList = {}
        -- self:updateDispatchMemer()
    end
end

-- 战舰派遣人员列表
-- function updateDispatchMemer(self)
--     self.mDispatchMemList = {}
--     -- 状态 1:入住 2：派遣
--     for _, hero in pairs(self.mBuildBaseHeroInfos) do
--         if hero.workType == 2 then
--             self.mDispatchMemList[hero.tid] = hero
--         end
--     end
-- end

---------------------------------------------------------------- 配置表数据 ----------------------------------------------------------------
-- 解析战员技能配置表数据
function parseBuildBaseHeroSkillConfig(self)
    local baseData = RefMgr:getData("warship_skill_data")
    for k, v in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(buildBase.BuildBaseHeroSkillVo)
        vo:parseData(k, v)
        self.mBuildBaseHeroSkillConfig[k] = vo
    end
end

---------------------------------------------------------------- --------------------------------------------------------------
-- 获取战员技能配置表信息
function getSkillConfigBySkillId(self, skillId)
    if not next(self.mBuildBaseHeroSkillConfig) then
        self:parseBuildBaseHeroSkillConfig()
    end
    local mDataHelper = self.mBuildBaseHeroSkillConfig[skillId]
    if mDataHelper ~= nil then
        return mDataHelper
    else
        logError("skillId is not in warship_skill_data")
    end

end

-- 返回战员派遣列表
-- function getDispatchMemList(self)
--     return self.mDispatchMemList
-- end

-- 返回战员派遣列表长度
-- function getDispatchMemLen(self)
--     local len = 0
--     if self.mDispatchMemList and next(self.mDispatchMemList) then
--         for _, v in pairs(self.mDispatchMemList) do
--             len = len + 1
--         end
--     end
--     return len
-- end
-- 返回战员Msg信息 tid
function getBuildHeroInfo(self, tid)
    return self.mBuildBaseHeroInfos[tid]
end

--判断战员工作状态
function checkHeroState(self, heroTid)
    local heroInfo = self:getBuildHeroInfo(heroTid)
    if heroInfo and heroInfo.buildId > 0 then
        -- if heroInfo.workType == 2 then
        --     return buildBase.HeroState.Dispatched
        -- end
        if buildBase.BuildBaseManager:getBuildType(heroInfo.buildId) == buildBase.BuildBaseType.Dormitory then
            if heroInfo.stamina == buildBase.HeroStaminaMax then
                return buildBase.HeroState.Able2Work
            else
                return buildBase.HeroState.Break
            end
        else
            if heroInfo.stamina > 0 then
                return buildBase.HeroState.Working
            else
                if heroInfo.staminaTime - GameManager:getClientTime() > 0 then
                    return buildBase.HeroState.Working
                else
                    return buildBase.HeroState.Tired
                end
            end
        end
    end
    if heroInfo and heroInfo.buildId == 0 then
        if heroInfo.stamina > 0 then
            return buildBase.HeroState.Ready2MoveIn
        else
            return buildBase.HeroState.Tired
        end
    end
end


--选择建筑改变
function onSelectedBuildChanged(self)
    if next(self.mHeroSettleInList) then
        self.mHeroSettleInList = {}
    end
    local nowBuildId = buildBase.BuildBaseManager:getNowBuildId()
    for heroTid, heroVo in pairs(self.mBuildBaseHeroInfos) do
        if heroVo.buildId == nowBuildId then
            self.mHeroSettleInList[heroVo.pos] = heroTid
            -- if heroVo.workType == 1 then
            -- end
        end
    end
    for pos, heroTid in pairs(self.mHeroSettleInList) do
        self.mLastHeroSettleList[pos] = heroTid
    end
end

--判断当前建筑是否已满
function checkSettleIsFull(self)
    local curLvBuildVo = buildBase.BuildBaseManager:getCurLvBuildConfigd()
    local upLimit = curLvBuildVo.num
    return #self.mHeroSettleInList >= upLimit
end

--判断当前建筑是单人入住
function checkBuildIsSoloSettleIn(self)
    local curLvBuildVo = buildBase.BuildBaseManager:getCurLvBuildConfigd()
    local upLimit = curLvBuildVo.num
    return upLimit == 1
end

--判断战员是否入住建筑
function checkHeroIsInBuild(self, heroTid)
    if next(self.mHeroSettleInList) then
        for pos, hero in pairs(self.mHeroSettleInList) do
            if hero == heroTid then
                return true, pos
            end
        end
    end
    return false, 0
end

--判断是否有新战员入住
function checkSettleInStateIsChanged(self)
    local result = false
    if #self.mLastHeroSettleList ~= #self.mHeroSettleInList then
        result = true
    else
        for i = 1, #self.mLastHeroSettleList do
            if self.mLastHeroSettleList[i] ~= self.mHeroSettleInList[i] then
                result = true
                break
            end
        end
        for _, heroTid in pairs(self.mHeroSettleInList) do
            if self.mBuildBaseHeroInfos[heroTid].buildId ~= buildBase.BuildBaseManager.mNowBuildId then
                result = true
                break
            end
        end
    end
    self.mLastHeroSettleList = self.mHeroSettleInList
    return result
end

--战员入住更改
function onClickChangeHero(self, heroTid, isSelect)
    local idx = table.indexof(self.mHeroSettleInList, heroTid)
    if self:checkBuildIsSoloSettleIn() then
        if idx then
            table.remove(self.mHeroSettleInList, idx)
        else
            self.mHeroSettleInList = { heroTid }
        end
        GameDispatcher:dispatchEvent(EventName.SELECT_SETTLEIN_HERO_UI, {false, self:getBuildHeroInfo(heroTid) })
        return
    else
        if idx and not isSelect then
            table.remove(self.mHeroSettleInList, idx)
            GameDispatcher:dispatchEvent(EventName.SELECT_SETTLEIN_HERO_UI, {false, self:getBuildHeroInfo(heroTid) })
            return
        end
    end
    local isFull = self:checkSettleIsFull()
    if not idx and isSelect then
        if (not isFull) then
            table.insert(self.mHeroSettleInList, heroTid)
            GameDispatcher:dispatchEvent(EventName.SELECT_SETTLEIN_HERO_UI, {false, self:getBuildHeroInfo(heroTid) })
        else
            gs.Message.Show("超过最大入住人数")
        end
    end

end

--清空所有战员选择
function clearAllSettleHero(self)
    local dataList = buildBase.BuildBaseManager:getAllBuildBaseDataList()
    for k, baseVo in pairs(dataList) do
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, { build_id = baseVo.id, hero_list = {} })
    end
end

--清空选择
function clearSettleHero(self)
    if next(self.mHeroSettleInList) then
        self.mHeroSettleInList = {}
    end
end

-- 分帧一键入驻
function onOneKeyWorkSend(self, workSendList)
    local len = #workSendList
    local index = 1
    LoopManager:addFrame(1, len, self, function()
        local data = workSendList[index]
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, data)
        index = index + 1
    end)
end

function checkHeroIsMoved(self)
    if next(self.mHeroSettleInList) then
        for _, heroTid in pairs(self.mHeroSettleInList) do
            local heroVo = self:getBuildHeroInfo(heroTid)
            if heroVo then
                if heroVo.buildId > 0 then
                    if heroVo.buildId ~= buildBase.BuildBaseManager:getNowBuildId() then
                        if buildBase.BuildBaseManager:getBuildType(heroVo.buildId) ~=
                        buildBase.BuildBaseType.Dormitory then
                            return (heroVo.staminaTime - GameManager:getClientTime()) > 0
                        end
                    end
                end
            end
        end
        return false
    end
end

function checkHeroIsWork(self, heroTid)
    local buildBaseHeroVo = self:getBuildHeroInfo(heroTid)
    if buildBaseHeroVo.buildId > 0 then
        if buildBase.BuildBaseManager:getBuildBasePosDataByPos(buildBaseHeroVo.buildId).buildType ~= buildBase.BuildBaseType.Dormitory then
            if buildBaseHeroVo then
                return buildBaseHeroVo.workType == 1
            else
                return false
            end
        end
    end
    return false
end


-- 发送入住
function sendHeroMoveInto(self)
    if self:checkSettleInStateIsChanged() then
        local heroList = {}
        for i = 1, #self.mHeroSettleInList do
            table.insert(heroList, { hero_tid = self.mHeroSettleInList[i], pos = i })
        end
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_HEROLIST, { build_id = buildBase.BuildBaseManager:getNowBuildId(), hero_list = heroList })
        -- gs.Message.Show("战员入驻成功")
    end
end

-- 设置自动排班的当前建筑类型
function setSortBuildType(self, sortBuildType)
    self.sortBuildType = sortBuildType
end
-- 获取自动排班的当前建筑类型
function getSortBuildType(self)
    return self.sortBuildType
end

-- 按照疲劳、建筑技能排序 
function sortRelateSkillFunc(selectVo1, selectVo2)
    local staminaMax = sysParam.SysParamManager:getValue(5001)
    local buildBaseHeroInfo1 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(selectVo1:getDataVo().tid)
    local buildBaseHeroInfo2 = buildBase.BuildBaseHeroManager:getBuildHeroInfo(selectVo2:getDataVo().tid)
    local isAvailuable1 = hero.HeroCuteManager:getHeroCuteConfigVo(selectVo1:getDataVo().tid) and 0 or -999
    local isAvailuable2 = hero.HeroCuteManager:getHeroCuteConfigVo(selectVo2:getDataVo().tid) and 0 or -999
    local stamina1 = buildBaseHeroInfo1.stamina + isAvailuable1
    local stamina2 = buildBaseHeroInfo2.stamina + isAvailuable2

    local buildType = buildBase.BuildBaseHeroManager:getSortBuildType()
    local wight01, wight02 = 0, 0
    local wightType01, wightType02 = 0, 0
    for _, warShipSkillId in pairs(buildBaseHeroInfo1.skillList) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warShipSkillId.skill_id)
        if skillVo.buildType == buildType then
            wight01 = 1
            wightType01 = warShipSkillId.skill_id
        end
    end

    for _, warShipSkillId in pairs(buildBaseHeroInfo2.skillList) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(warShipSkillId.skill_id)
        if skillVo.buildType == buildType then
            wight02 = 1
            wightType02 = warShipSkillId.skill_id
        end
    end

    wight01 = isAvailuable1 == 0 and wight01 or -1
    wight02 = isAvailuable2 == 0 and wight02 or -1

    if wight01 == 1 and wight01 > wight02 and stamina1 > staminaMax * 0.6 then
        return true
    end

    if wight02 == 1 and wight02 > wight01 and stamina2 > staminaMax * 0.6 then
        return false
    end

    return stamina1 > stamina2
end

return _M