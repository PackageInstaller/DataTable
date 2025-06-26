--[[ 
-----------------------------------------------------
@filename       : DispatchDockManager
@Description    : 战舰(基建)-派遣坞管理器
@date           : 2023/2/25
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DispatchDockManager", Class.impl(Manager))

ON_HERO_SELECT = "ON_HERO_SELECT"
ON_AUTO_DISPATCH = "ON_AUTO_DISPATCH"
ON_SELETED_HERO_CHANGE = "ON_SELETED_HERO_CHANGE"
------------------------------------------------------------
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- 析构函数
function dtor(self)
end


-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    --战舰Msg信息
    self.mBuildBaseInfo = {}

    --已经派遣得战员字典<tid,hero>
    self.mDispathcedHeroDic = {}

    --战舰派遣战员Msg信息<exploreId,heroTid>
    self.mBuildBaseHeroPosDic = {}

    --战舰buildId 
    self.mBuildId = 0
    --派遣区域Msg <exploreId,herolist<posm>>
    self.mAreaInfosDic = {}
    --区域配置信息
    self.mAreaConfigDic = {}
    --任务配置信息字典
    self.mTaskConfigDic = {}
    --英雄战员所有战员MSG字典 hero.HeroManager里面的
    self.mHeroAllInfo = {}
    --组队选中tid
    self.dispatchHeroList = {}

    --派遣的位置
    self.selectedPos = 0

    self.hasNotShown = true
    --读取配置表信息
    --self:parseConfig()
end

---------------------------------------------------------------- 服务器数据 ----------------------------------------------------------------
function parseMsg(self, msg)
    if msg ~= nil then
        self.mBuildId = msg.building_id
        for _, v in pairs(msg.explore_list) do
            local vo = buildBase.DispatchExploreMsgVo.new()
            vo:parseMsgInfo(v)
            self.mAreaInfosDic[vo.exploreId] = vo
            self.mBuildBaseHeroPosDic[vo.exploreId] = vo.heroList
            if next(vo.heroList) then
                for _, heroTid in pairs(vo.heroList) do
                    self.mDispathcedHeroDic[heroTid] = heroTid
                end
            end
        end
    else
        logError("DispatchDockManager msg is nil~")
    end
end

--更新基建建筑信息
function onUpdateBuildPanelMsg(self)
    self.mBuildBaseInfo = buildBase.BuildBaseManager:getBuildBaseData(buildBase.BuildBaseManager:getNowBuildId())
    -- self.mDispathcedHeroDic = buildBase.BuildBaseHeroManager:getDispatchMemList()
end

--更新派遣屋区域信息
function onUpdateMsg(self, explore_info)
    self:onUpdateBuildPanelMsg()
    self.mBuildBaseHeroPosDic[explore_info.explore_id] = explore_info.hero_list
    if self.mAreaInfosDic[explore_info.explore_id] ~= nil then
        self.mAreaInfosDic[explore_info.explore_id]:parseMsgInfo(explore_info)
    else
        local vo = buildBase.DispatchExploreMsgVo.new()
        vo:parseMsgInfo(explore_info)
        self.mAreaInfosDic[vo.id] = vo
    end

    self.mDispathcedHeroDic = {}
    for _, heroList in pairs(self.mBuildBaseHeroPosDic) do
        if next(heroList) then
            for _, heroTid in pairs(heroList) do
                self.mDispathcedHeroDic[heroTid] = heroTid
            end
        end
    end

end

--返回探索区域Msg信息
function getAreaInfo(self, exploreId)
    local mdataHelper = self.mAreaInfosDic[exploreId]
    if mdataHelper ~= nil then
        return mdataHelper
    else

    end
end

--返回探索区域派遣战员Msg信息 
function getAreaHeroInfo(self, exploreId)
    local mdataHelper = self.mAreaInfosDic[exploreId]
    if mdataHelper ~= nil then
        return mdataHelper.heroList or {}
    else
        logError("exploreId id is not in msg")
    end
end

function getBaseBuildId(self)
    return self.mBuildId
end

---------------------------------------------------------------- 本地数据 ----------------------------------------------------------------
--初始化区域配置信息和任务配置信息字典
function parseConfig(self)
    local baseData = RefMgr:getData("warship_dispatch_data")
    for exploreId, v in pairs(baseData) do
        local areaVo = LuaPoolMgr:poolGet(buildBase.DispatchAreaConfigVo)
        areaVo:parseConfigData(exploreId, v.need_level)
        self.mAreaConfigDic[exploreId] = areaVo
        for taskId, Vo in pairs(v.event_attr) do
            local taskVo = LuaPoolMgr:poolGet(buildBase.DispatchTaskConfigVo)
            taskVo:parseConfigData(taskId, exploreId, Vo)
            self.mTaskConfigDic[taskId] = taskVo
        end
    end
end

--获得任务配置信息
function getTaskConfig(self, taskId)
    if next(self.mTaskConfigDic) == nil then
        self:parseConfig()
    end
    local mdataHelper = self.mTaskConfigDic[taskId]
    if mdataHelper ~= nil then
        return mdataHelper
    else
        logError("task tid is not in Config Table")
    end
end
--获得区域配置信息
function getAreaConfig(self, exploreId)
    if next(self.mAreaConfigDic) == nil then
        self:parseConfig()
    end
    local mdataHelper = self.mAreaConfigDic[exploreId]
    if mdataHelper ~= nil then
        return mdataHelper
    else
        logError("explore tid is not in Config Table")
    end
end

--判断探索区域任务状态
function checkTaskState(self, exploreId)
    local mAreaVo = self:getAreaConfig(exploreId)
    local mAreaInfo = self:getAreaInfo(exploreId)
    if not self.mBuildBaseInfo then
        self:onUpdateBuildPanelMsg()
    end
    if self.mBuildBaseInfo.lv < mAreaVo.unlockLevel then
        return buildBase.TaskState.Locked
    end
    if mAreaInfo == nil then
        return buildBase.TaskState.Finished
    else
        if mAreaInfo.state == 1 then
            return buildBase.TaskState.Available
        elseif mAreaInfo.state == 2 then
            return buildBase.TaskState.Incomplete
        elseif mAreaInfo.state == 3 then
            return buildBase.TaskState.Complete
        elseif mAreaInfo.state == 4 then
            return buildBase.TaskState.Finished
        end
    end
end

function getExploreAreaLength(self)
    if self.mAreaConfigDic ~= nil then
        return #self.mAreaConfigDic
    else
        self:parseConfig()
        return #self.mAreaConfigDic
    end
end

--获取基础奖励道具配置表(taskId)
function getBaseItemCofigs(self, taskId)
    local dataHelper = self:getTaskConfig(taskId)
    local baseItemDataHelper = AwardPackManager:getAwardListById(dataHelper.baseReward)
    if baseItemDataHelper ~= nil then
        return baseItemDataHelper
    else
        logError("item id is not in AwardPackManager ConfigTable")
        return {}
    end
end

--获取额外奖励道具配置表(taskId)
function getExtraItemCofigs(self, taskId)
    local dataHelper = self:getTaskConfig(taskId)
    local baseItemDataHelper = AwardPackManager:getAwardListById(dataHelper.extraReward)
    if baseItemDataHelper ~= nil then
        return baseItemDataHelper
    else
        logError("item id is not in AwardPackManager ConfigTable")
        return {}
    end
end

function checkIsFull(self)
    return #self.dispatchHeroList < 3
end

function checkIsSelected(self, tid)
    if self.dispatchHeroList then
        if table.indexof(self.dispatchHeroList, tid) then
            return true
        end
    end
    return false
end

function setSelectedPos(self, pos)
    self.selectedPos = pos
end

function getPos(self)
    return self.selectedPos
end

--获得额外加长
function checkExtraProps(self, taskId)
    local len = 0
    if next(self.dispatchHeroList) then
        local taskConfig = self.mTaskConfigDic[taskId]
        for _, heroTid in pairs(self.dispatchHeroList) do
            if heroTid > 0 then
                local heroVo = hero.HeroManager:getHeroConfigVo(heroTid)
                for _, heroType in pairs(taskConfig.heroType) do
                    if heroVo.professionType == heroType then
                        len = len + 1
                    end
                end

                for _, eleTyep in pairs(taskConfig.eleType) do
                    if heroVo.eleType == eleTyep then
                        len = len + 1
                    end
                end
            end
        end
    end
    return len
end

--获得正在进行时的队伍加成
function checkExtraProps2(self, taskId, exploreId)
    local len = 0
    local mAreaHeroInfo = self:getAreaHeroInfo(exploreId)
    if next(mAreaHeroInfo) then
        local taskConfig = self.mTaskConfigDic[taskId]
        for i, heroTid in pairs(mAreaHeroInfo) do
            local heroVo = hero.HeroManager:getHeroConfigVo(heroTid)
            if heroVo.professionType == taskConfig.heroType[1] then
                len = len + 1
            end
            for _, eleTyep in pairs(taskConfig.eleType) do
                if heroVo.eleType == eleTyep then
                    len = len + 1
                end
            end
        end
    end
    return len
end

--变更该id角色被选状态
function changeHeroList(self, tid, exploreId, taskId)
    if self.mDispathcedHeroDic[tid] then
        gs.Message.Show(_TT(40031))--"战员已经在探索中")
        return
    end
    local idx = table.indexof01(self.dispatchHeroList, tid)
    local reIdx = table.indexof01(self.dispatchHeroList, -1)
    local taskVo = self:getTaskConfig(self:getAreaInfo(exploreId).taskId)

    if idx > 0 then
        table.remove(self.dispatchHeroList, idx)
    else
        local len = 0
        for _, heroTid in pairs(self.dispatchHeroList) do
            if heroTid > 0 then
                len = len + 1
            end
        end

        if len >= taskVo.maxNum then
            gs.Message.Show("超过派遣最大人数")
            return
        else
            if self:checkIsFullIncome(taskId) then
                UIFactory:alertMessge(_TT(76194), true, function()
                    table.insert(self.dispatchHeroList, tid)
                    buildBase.DispatchDockManager:dispatchEvent(self.ON_SELETED_HERO_CHANGE)
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.DISPATCHDOCK_IS_FULL_INCOME)
            else
                table.insert(self.dispatchHeroList, tid)

            end
        end


    end
    buildBase.DispatchDockManager:dispatchEvent(self.ON_SELETED_HERO_CHANGE)
end

--检查当前入队的战员是否满收益
function checkIsFullIncome(self, taskId)
    if self.dispatchHeroList then
        if next(self.dispatchHeroList) then
            local rateHelper = 0
            local baseLen = #self.dispatchHeroList
            local taskVo = self:getTaskConfig(taskId)
            rateHelper = baseLen * taskVo.baseIncome
            local len = self:checkExtraProps(taskId)
            rateHelper = rateHelper + (len * taskVo.extraIncome)
            return (rateHelper / 10000) >= 1
        end
    else
        self.dispatchHeroList = {}
    end
    return false
end

--获取该id角色是否被选择
function getHeroSelect(self, id)
    if self.dispatchHeroList == nil then
        return false
    end
    return table.indexof01(self.dispatchHeroList, id) > 0
end

--获取该id角色是否被选择
function getHeroDispathed(self, heroTid)
    if next(self.mDispathcedHeroDic) then
        if self.mDispathcedHeroDic[heroTid] then
            return true
        else
            return false
        end
    end
    return false
end

--已派遣的队伍
function getDispatchedTeam(self)
    local len = 0
    if self.mBuildBaseInfo == nil then
        self.mBuildBaseInfo = {}
    end
    if not next(self.mBuildBaseInfo) then
        self:onUpdateBuildPanelMsg()
    end
    for i = 1, 6 do
        self.state = self:checkTaskState(i)
        if self.state == buildBase.TaskState.Incomplete then
            len = len + 1
        end
        if self.state == buildBase.TaskState.Complete then
            len = len + 1
        end
    end
    return len
end

--已完成的任务
function getAwardCanReceiveLen(self)
    local len = 0
    for _, AreaMsgVo in pairs(self.mAreaInfosDic) do
        if AreaMsgVo.state == buildBase.TaskState.Complete then
            len = len + 1
        end
    end
    return len
end

function getDispatchedLen(self)
    local len = 0
    if self.mBuildBaseInfo == nil then
        self.mBuildBaseInfo = {}
    end
    if not next(self.mBuildBaseInfo) then
        self:onUpdateBuildPanelMsg()
    end
    for i = 1, 6 do
        self.state = self:checkTaskState(i)
        if self.state ~= buildBase.TaskState.Locked then
            len = len + 1
        end
    end

    return len
end


function getAvailableTaskLen(self)
    local len = 0
    for _, AreaMsgVo in pairs(self.mAreaInfosDic) do
        if AreaMsgVo.state == buildBase.TaskState.Available then
            len = len + 1
        end
    end
    return len
end


function autoDispatch(self, taskId, exploreId)
    self.allHeroList = hero.HeroManager:getAllHeroList()
    self.dispatchHeroList = {}
    if next(self.allHeroList) then
        local taskVo = self:getTaskConfig(taskId)
        for _, heroVo in pairs(self.allHeroList) do
            if self:checkIsFullIncome(taskId) then
                break
            end
            if #self.dispatchHeroList >= taskVo.maxNum then
                break
            end
            for _, eleType in pairs(taskVo.eleType) do
                if eleType == heroVo.eleType then
                    self:insertDisTable(heroVo.tid, taskId)
                end
            end
            if next(taskVo.heroType) then
                if taskVo.heroType[1] == heroVo.professionType then
                    self:insertDisTable(heroVo.tid, taskId)
                end
            end
        end
        if #self.dispatchHeroList <= taskVo.maxNum then
            for _, heroVo in pairs(self.allHeroList) do
                if #self.dispatchHeroList >= taskVo.maxNum then
                    break
                end
                self:insertDisTable(heroVo.tid, taskId)
            end
        end
        self:dispatchEvent(self.ON_AUTO_DISPATCH)
    else
        gs.Message.Show("当前没有战员")
    end
end

function insertDisTable(self, heroTid, taskId)
    if self:checkIsFullIncome(taskId) == false then
        if not table.indexof(self.dispatchHeroList, heroTid) then
            if self.mDispathcedHeroDic[heroTid] == nil then
                table.insert(self.dispatchHeroList, heroTid)
            end
        end
    end
end

-- 获取自动派遣的战员列表
function getAutoDispatchList(self, areaData)
    local heroList = hero.HeroManager:getAllHeroList()
    self.dipsatchMap = {}
    for exploreId, taskId in pairs(areaData) do
        self.dispatchHeroList = {}
        local taskVo = self:getTaskConfig(taskId)
        for _, heroVo in pairs(heroList) do
            if self:checkIsFullIncome(taskId) then
                break
            end
            if #self.dispatchHeroList >= taskVo.maxNum then
                break
            end
            for _, eleType in pairs(taskVo.eleType) do
                if eleType == heroVo.eleType then
                    self:insertAutoDisTable(heroVo.tid, taskId)
                end
            end
            if next(taskVo.heroType) then
                if taskVo.heroType[1] == heroVo.professionType then
                    self:insertAutoDisTable(heroVo.tid, taskId)
                end
            end
        end
        if #self.dispatchHeroList <= taskVo.maxNum then
            for _, heroVo in pairs(heroList) do
                if #self.dispatchHeroList >= taskVo.maxNum then
                    break
                end
                self:insertAutoDisTable(heroVo.tid, taskId)
            end
        end
        if not table.empty(self.dispatchHeroList) then
            self.dipsatchMap[exploreId] = table.copy(self.dispatchHeroList)
        end
    end

    return self.dipsatchMap
end

function insertAutoDisTable(self, heroTid, taskId)
    if self:checkIsFullIncome(taskId) == false then
        local have = false
        for k, list in pairs(self.dipsatchMap) do
            if table.indexof(list, heroTid) ~= false then
                have = true
                break
            end
        end
        if not table.indexof(self.dispatchHeroList, heroTid) then
            if not have and self.mDispathcedHeroDic[heroTid] == nil then
                table.insert(self.dispatchHeroList, heroTid)
            end
        end
    end
end
----------------------------------------------------------------方法-------------------------------------------------  
function dispatchMemebers(self, exploreId)
    if next(self.dispatchHeroList) then
        local tableHelper = {}
        local flag = 0
        for pos, tid in pairs(self.dispatchHeroList) do
            -- flag = buildBase.BuildBaseHeroManager:checkHeroIsWork(tid) and flag + 1 or flag
            table.insert(tableHelper, { hero_tid = tid, pos = pos })
        end
        -- if flag > 0 and self.hasNotShown then
        --     UIFactory:alertMessge(_TT(76176), true, function()
        --         GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCH_HERO, { buildId = self.mBuildId, exploreId = exploreId, heroList = tableHelper })
        --     end, _TT(1), nil, true,
        --     nil
        --     , _TT(2), _TT(5), nil, RemindConst.BUILDBASE_DISPATCH_HERO
        --     )
        -- else
        -- end

        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCH_HERO, { buildId = self.mBuildId, exploreId = exploreId, heroList = tableHelper })
        return true
    end
    return false
end

function flagShowTips(self)
    self.hasNotShown = false
end

function onClearDispatchMemebers(self)
    self.dispatchHeroList = {}
    self.dipsatchMap = {}
    buildBase.DispatchDockManager:dispatchEvent(buildBase.DispatchDockManager.ON_HERO_SELECT, 0)
end

--派遣坞 红点
function updateRedPoint(self)
    local len = self:getAwardCanReceiveLen() + self:getAvailableTaskLen()
    return len > 0
end

return _M


--[[ 替换语言包自动生成，请勿修改！
	语言包:
]]