module("formation.FormationManager", Class.impl(Manager))

-- 更新队列数据
UPDATE_TEAM_FORMATION_DATA = "UPDATE_TEAM_FORMATION_DATA"
-- 更新出战的队列id
UPDATE_FIGHT_TEAM_ID = "UPDATE_FIGHT_TEAM_ID"
-- 更新队列阵型id
UPDATE_TEAM_FORMATION_ID = "UPDATE_TEAM_FORMATION_ID"
-- 更新队列名字
UPDATE_TEAM_NAME = "UPDATE_TEAM_NAME"
-- 更新队列队长英雄id
UPDATE_TEAM_CAPTAIN_ID = "UPDATE_TEAM_CAPTAIN_ID"
-- 更新助战战员
UPDATE_ASSIST_FIGHT_HERO = "UPDATE_ASSIST_FIGHT_HERO"
-- 关闭战员选择
CLOSE_FORMATIONHERO_CHOOSE = "CLOSE_FORMATIONHERO_CHOOSE"

-- 打开助战界面
OPEN_FORMATION_ASSIST_PANEL = "OPEN_FORMATION_ASSIST_PANEL"
-- 打开阵型选择界面
OPEN_FORMATION_SELECT_PANEL = "OPEN_FORMATION_SELECT_PANEL"
-- 打开阵型英雄选择界面
OPEN_FORMATION_HERO_SELECT_PANEL = "OPEN_FORMATION_HERO_SELECT_PANEL"
-- 关闭阵型英雄选择界面
CLOSE_FORMATION_HERO_SELECT_PANEL = "CLOSE_FORMATION_HERO_SELECT_PANEL"
-- 打开助战界面
OPEN_FORMATION_ASSIST_PREVIEW_PANEL = "OPEN_FORMATION_ASSIST_PREVIEW_PANEL"
-- 打开英雄助战选择面板
OPEN_FORMATION_ASSIST_HERO_SELECT_PANEL = "OPEN_FORMATION_ASSIST_HERO_SELECT_PANEL"
-- 打开阵型队长选择面板
OPEN_FORMATION_CAPTAIN_SELECT_PANEL = "OPEN_FORMATION_CAPTAIN_SELECT_PANEL"
-- 打开阵型队列名修改面板
OPEN_FORMATION_MODIFY_TEAM_NAME_PANEL = "OPEN_FORMATION_MODIFY_TEAM_NAME_PANEL"

-- 请求阵型列表
REQ_FORMATION_LIST = "REQ_FORMATION_LIST"
-- 请求改变阵型
REQ_FORMATION_CHANGE = "REQ_FORMATION_CHANGE"
-- 请求设置出战
REQ_SET_FIGHT_TEAM = "REQ_SET_FIGHT_TEAM"
-- 请求改变阵型英雄列表
REQ_FORMATION_HERO_LIST = "REQ_FORMATION_HERO_LIST"
-- 请求阵型队列改名
REQ_MODIFY_TEAM_NAME = "REQ_MODIFY_TEAM_NAME"

--------------------------------界面元素事件----------------------------------
-- 英雄阵型界面 队列查看
HERO_TEAM_SEE = "HERO_TEAM_SEE"
-- 英雄阵型界面 阵型查看
HERO_FORMATION_SEE = "HERO_FORMATION_SEE"

-- 英雄阵型格子选择
HERO_FORMATION_TILE_SELECT = "HERO_FORMATION_TILE_SELECT"
-- 英雄阵型格子按下
HERO_FORMATION_TILE_POINTER_DOWN = "HERO_FORMATION_TILE_POINTER_DOWN"
-- 英雄阵型格子抬起
HERO_FORMATION_TILE_POINTER_UP = "HERO_FORMATION_TILE_POINTER_UP"
-- 英雄阵型选择界面 阵型选择
HERO_FORMATION_SELECT = "HERO_FORMATION_SELECT"
-- 英雄阵型选择界面 队长选择
HERO_FORMATION_CAPTAIN_SELECT = "HERO_FORMATION_CAPTAIN_SELECT"
-- 英雄阵型选择界面 阵型选择
HERO_FORMATION_ASSIST_SELECT = "HERO_FORMATION_ASSIST_SELECT"

-- 打开元素同调
OPEN_FORMATION_ELEMENT = "OPEN_FORMATION_ELEMENT"
-- 打开战场环境
OPEN_FORMATION_POSEFF = "OPEN_FORMATION_POSEFF"
--打开挑战目标
OPEN_FORMATION_TARGET = "OPEN_FORMATION_TARGET"

-- instance确保子类维护统一的数据
function instance(self)
    return formation.FormationManager
end

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
    formation.resetTypeTeamDic()
    -- 怪物阵型配置列表
    self:instance().m_monFormationConfigList = nil
    -- 怪物阵型配置字典
    self:instance().m_monFormationConfigDic = nil
    -- 阵型配置列表
    self:instance().m_formationConfigList = nil
    -- 阵型配置字典
    self:instance().m_formationConfigDic = nil

    -- 出战的队列id列表
    self:instance().m_fightTeamIdList = nil
    -- 队列id对应队列数据字典
    self:instance().m_teamDic = nil
    -- 队列id对应选择的阵型英雄列表字典
    self:instance().m_teamHeroListDic = nil

    -- 选择的阵容英雄列表字典
    self:instance().m_selectFormationHeroDic = {}
    -- 当前选择的阵型id
    self:instance().mSelectFormationTeamId = nil

    -- 助战配置字典
    self:instance().mAssistConfigDic = nil
    -- 队列id对应选择的助战英雄列表字典
    self:instance().mTeamAssistHeroListDic = nil
    -- 选择的助战英雄列表字典
    self:instance().mSelectTeamAssistHeroDic = {}
    -- 使用中宠物列表
    self:instance().mInUsePetDic = {}
    -- 临时变更阵型宠物
    self:instance().mTempPetDic = {}

    self:instance().mPosEffCongigDic = nil
    self:resetFormationData()
    self:instance().mAniPlaying = false
    -- 可以公用一个的筛选记录字典，关闭阵型后会清空
    self:instance().mFilterDic = {}
    -- -- 打断当前关闭战员选择窗口的操作
    -- self:instance().mBreakClose = false
end

-- function setBreakClose(self, isBreak)
--     self:instance().mBreakClose = isBreak
-- end

-- function getBreakClose(self)
--     return self:instance().mBreakClose
-- end

function setFilterDic(self, filterDic)
    self:instance().mFilterDic = filterDic
end

function getFilterDic(self)
    if self:instance().mFilterDic == nil then
        self:instance().mFilterDic = {}
    end
    if self:instance().mFilterDic.m_selectSortType == nil then
        self:resetFilterDic()
    end
    return self:instance().mFilterDic
end

function resetFilterDic(self)
    local dic = {}
    -- 是否默认显示处于状态的
    dic.mIsFilterUseState = false
    -- 过滤相同战员
    dic.m_isFilterSame = false
    -- 是否查找喜欢的英雄
    dic.m_isFindLike = false
    -- 是否查找锁定的英雄
    dic.m_isFindLock = false
    -- 是否降序
    dic.m_isDescending = true
    -- 选择的排序类型
    dic.m_selectSortType = showBoard.panelSortType.LEVEL
    -- 提供的筛选字典
    dic.m_selectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        dic.m_selectFilterDic[type] = {}
        dic.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    self:setFilterDic(dic)
end

function resetFormationData(self)
    -- 功能模块类型
    self:instance().m_type = nil
    -- 阵型的数据类型id
    self:instance().m_dataId = nil
    -- 功能模块的自定义数据
    self:instance().m_data = nil
    -- 关闭后回调方法
    self:instance().m_callFun = nil
end

function setData(self, type, dataId, data, callFun)
    self:instance().m_type = type and type or formation.TYPE.NORMAL
    self:instance().m_dataId = dataId
    self:instance().m_data = data
    self:instance().m_callFun = callFun
end

-- 运行回调
function runCallBack(self, callReason)
    if (self:instance().m_callFun) then
        self:instance().m_callFun(callReason)
    end
end

-- 阵型类型
function getType(self)
    return self:instance().m_type
end

-- 阵型数据类型id
function getDataId(self)
    return self:instance().m_dataId
end

-- 外部自定义传入数据
function getData(self)
    return self:instance().m_data
end

function getAniPlaying(self)
    return self.mAniPlaying
end

function setAniPlaying(self, isPlaying)
    self.mAniPlaying = isPlaying
end

----------------------------------------怪物阵型配置------------------------------------------------
-- 初始化怪物阵型配置表
function parseMonConfigData(self)
    self:instance().m_monFormationConfigList = {}
    self:instance().m_monFormationConfigDic = {}
    local baseData = RefMgr:getData("mon_formation_data")
    for formationId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(formation.MonFormationConfigVo)
        ro:parseData(formationId, data)
        self:instance().m_monFormationConfigDic[formationId] = ro
        table.insert(self:instance().m_monFormationConfigList, ro)
    end
    table.sort(self:instance().m_monFormationConfigList, self:instance().__sortFormationConfigList)
end

function getMonFormationConfigList(self)
    if (not self:instance().m_monFormationConfigList) then
        self:parseMonConfigData()
    end
    return self:instance().m_monFormationConfigList
end

function getMonFormationConfigVo(self, formationId)
    if (not self:instance().m_monFormationConfigDic) then
        self:parseMonConfigData()
    end
    return self:instance().m_monFormationConfigDic[formationId]
end
----------------------------------------怪物阵型配置------------------------------------------------

------------------------------------------阵型配置--------------------------------------------------
-- 初始化玩家阵型配置表
function parseConfigData(self)
    self:instance().m_formationConfigList = {}
    self:instance().m_formationConfigDic = {}
    local baseData = RefMgr:getData("hero_formation_data")
    for formationId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(formation.FormationConfigVo)
        ro:parseData(formationId, data)
        self:instance().m_formationConfigDic[formationId] = ro
        table.insert(self:instance().m_formationConfigList, ro)
    end
    table.sort(self:instance().m_formationConfigList, self:instance().__sortFormationConfigList)
end

-- 阵型列表排序
function __sortFormationConfigList(formationConfigVo1, formationConfigVo2)
    if (formationConfigVo1 and formationConfigVo2) then
        -- 阵型id从小到大
        if (formationConfigVo1:getRefID() < formationConfigVo2:getRefID()) then
            return true
        end
        if (formationConfigVo1:getRefID() > formationConfigVo2:getRefID()) then
            return false
        end
    end
    return false
end

-- 解析助战位配置数据
function parseAssistConfigData(self)
    self:instance().mAssistConfigDic = {}
    local baseData = RefMgr:getData("assist_data")
    for pos, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(formation.FormationAssistConfigVo)
        configVo:parseData(pos, data)
        self:instance().mAssistConfigDic[pos] = configVo
    end
end

-- 战场环境配置
function parsePosEffConfigData(self)
    self:instance().mPosEffCongigDic = {}
    local baseData = RefMgr:getData("pos_effect_data")
    for k, v in pairs(baseData) do
        local posEffVo = LuaPoolMgr:poolGet(formation.FormationPosEffVo)
        posEffVo:setData(k, v)
        self:instance().mPosEffCongigDic[k] = posEffVo
    end
end

-- 获取战场环境配置
function getPosEffConfigData(self, id)
    if self:instance().mPosEffCongigDic == nil then
        self:parsePosEffConfigData()
    end
    return self:instance().mPosEffCongigDic[id]
end

function getPosHasEffect(self, id, col, row)
    local effectVo = self:getPosEffConfigData(id)
    if effectVo then
        for i = 1, #effectVo.posList do
            if (effectVo.col[i] == col) and (effectVo.row[i] == row) then
                return effectVo.effectSkillList[i], effectVo.backGroundList[i], effectVo.iconList[i]
            end
        end
    end
end

-- 获取助战位配置数据
function getAssistConfigVo(self, pos)
    if (not self:instance().mAssistConfigDic) then
        self:parseAssistConfigData()
    end
    return self:instance().mAssistConfigDic[pos]
end

function getAssistUnlockNum(self)
    local nowLv = role.RoleManager:getRoleVo():getPlayerLvl()
    local unLockNum = 0
    local maxPos = sysParam.SysParamManager:getValue(SysParamType.MAX_HERO_ASSIST_COUNT, 0)
    for pos = 1, maxPos do
        if (nowLv >= self:getAssistConfigVo(pos).needPlayerLvl) then
            unLockNum = unLockNum + 1
        end
    end
    return unLockNum
end

function getFormationConfigList(self)
    if (not self:instance().m_formationConfigList) then
        self:parseConfigData()
    end
    return self:instance().m_formationConfigList
end

function getFormationConfigVo(self, formationId)
    if (not self:instance().m_formationConfigDic) then
        self:parseConfigData()
    end

    return self:instance().m_formationConfigDic[formationId]
end

-- 获取配置表里对应阵型的可上阵英雄数量
function getFormationHeroMaxCount(self, formationId)
    return #self:getFormationConfigVo(formationId):getFormationList()
end
------------------------------------------阵型配置--------------------------------------------------

------------------------------------------协议解析--------------------------------------------------
-- 解析服务器阵型列表
function parseFormationList(self, list)
    self:instance().m_teamDic = {}
    self:instance().m_fightTeamIdList = {}

    self:instance().m_teamHeroListDic = {}
    self:instance().m_selectFormationHeroDic = {}

    self:instance().mTeamAssistHeroListDic = {}
    self:instance().mSelectTeamAssistHeroDic = {}

    for i = 1, #list do
        local msgVo = list[i]
        local _teamId = msgVo.team_id
        local _teamName = msgVo.name
        local _formationId = msgVo.formation_id
        local _isReady = msgVo.is_ready == 1
        local _heroList = msgVo.formation_hero_list
        local _assistHeroList = msgVo.assist_fight_list
        local _petId = msgVo.pet_id
        -- 队列id对应选择的阵型id字典
        local teamVo = self:instance().m_teamDic[_teamId]
        if (not teamVo) then
            teamVo = LuaPoolMgr:poolGet(formation.FormationTeamVo)
            self:instance().m_teamDic[_teamId] = teamVo
        end
        teamVo:setData(_teamId, _formationId, _teamName, _petId)

        if _petId then
            self.mInUsePetDic[_teamId] = _petId
        end

        -- 出战的队列id列表
        if (_isReady) then
            table.insert(self:instance().m_fightTeamIdList, _teamId)
        end

        -- 队列id对应选择的阵型英雄列表字典
        local formationHeroList = self:instance().m_teamHeroListDic[_teamId]
        if (formationHeroList == nil) then
            formationHeroList = {}
            self:instance().m_teamHeroListDic[_teamId] = formationHeroList
        else
            for i = #formationHeroList, 1, -1 do
                LuaPoolMgr:poolRecover(formationHeroList[i])
                table.remove(formationHeroList, i)
            end
        end
        for i = 1, #_heroList do
            local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            vo:parseMsgData(_heroList[i])
            table.insert(formationHeroList, vo)
        end

        -- 队列id对应选择的助战英雄列表字典
        local assistHeroList = self:instance().mTeamAssistHeroListDic[_teamId]
        if (assistHeroList == nil) then
            assistHeroList = {}
            self:instance().mTeamAssistHeroListDic[_teamId] = assistHeroList
        else
            for i = #assistHeroList, 1, -1 do
                LuaPoolMgr:poolRecover(assistHeroList[i])
                table.remove(assistHeroList, i)
            end
        end
        for i = 1, #_assistHeroList do
            local vo = LuaPoolMgr:poolGet(formation.FormationAssistVo)
            vo:parseMsgData(_assistHeroList[i])
            table.insert(assistHeroList, vo)
        end
    end

    -- 队列列表排序，队列id从小到大
    local sortTeamList = function(teamId1, teamId2)
        if (teamId1 < teamId2) then
            return true
        end
        if (teamId1 > teamId2) then
            return false
        end
    end
    table.sort(self:instance().m_fightTeamIdList, sortTeamList)
    self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {})

    GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_RED_INFO)
end

-- 返回修改的服务器阵型英雄列表结果
function parseFormationHeroList(self, list)
    -- 只修改英雄列表
    for i = 1, #list do
        local msgVo = list[i]
        local _teamId = msgVo.team_id
        local _teamName = msgVo.name
        local _formationId = msgVo.formation_id
        local _isReady = msgVo.is_ready == 1
        local _heroList = msgVo.formation_hero_list
        local _assistHeroList = msgVo.assist_fight_list

        -- 队列id对应选择的阵型英雄列表字典
        local formationHeroList = self:instance().m_teamHeroListDic[_teamId]
        if (formationHeroList == nil) then
            formationHeroList = {}
            self:instance().m_teamHeroListDic[_teamId] = formationHeroList
        else
            for i = #formationHeroList, 1, -1 do
                LuaPoolMgr:poolRecover(formationHeroList[i])
                table.remove(formationHeroList, i)
            end
        end
        for i = 1, #_heroList do
            local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            vo:parseMsgData(_heroList[i])
            table.insert(formationHeroList, vo)
        end

        -- 队列id对应选择的助战英雄列表字典
        local assistHeroList = self:instance().mTeamAssistHeroListDic[_teamId]
        if (assistHeroList == nil) then
            assistHeroList = {}
            self:instance().mTeamAssistHeroListDic[_teamId] = assistHeroList
        else
            for i = #assistHeroList, 1, -1 do
                LuaPoolMgr:poolRecover(assistHeroList[i])
                table.remove(assistHeroList, i)
            end
        end
        for i = 1, #_assistHeroList do
            local vo = LuaPoolMgr:poolGet(formation.FormationAssistVo)
            vo:parseMsgData(_assistHeroList[i])
            table.insert(assistHeroList, vo)
        end

        self:updateSelectList(_teamId)
    end

    self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {})
end

-- 更新出战的队列id
function updateFightTeamId(self, teamId)
    local sameGroupList = formation.getTeamIdListById(teamId)
    local fightTeamIdList = self:getFightTeamIdList()
    for i = #fightTeamIdList, 1, -1 do
        local _teamId = fightTeamIdList[i]
        if (table.indexof(sameGroupList, _teamId) ~= false) then
            table.remove(fightTeamIdList, i)
        end
    end
    table.insert(fightTeamIdList, teamId)
    self:dispatchEvent(self.UPDATE_FIGHT_TEAM_ID, {
        teamId = teamId
    })
end

-- 更新队列的阵型id
function updateTeamFormationId(self, teamId, formationId)
    local teamDic = self:getTeamDic()
    local teamVo = teamDic[teamId]
    if (not teamVo) then
        teamVo = LuaPoolMgr:poolGet(formation.FormationTeamVo)
        teamDic[teamId] = teamVo
    end
    teamVo.formationId = formationId
    self:dispatchEvent(self.UPDATE_TEAM_FORMATION_ID, {
        teamId = teamId,
        formationId = formationId
    })
end

-- 更新队列的名字
function updateTeamName(self, teamId, teamName)
    local teamDic = self:getTeamDic()
    local teamVo = teamDic[teamId]
    if (not teamVo) then
        teamVo = LuaPoolMgr:poolGet(formation.FormationTeamVo)
        teamDic[teamId] = teamVo
    end
    teamVo.teamName = teamName
    self:dispatchEvent(self.UPDATE_TEAM_NAME, {
        teamId = teamId,
        teamName = teamName
    })
end

------------------------------------------协议解析--------------------------------------------------

-- 获取出战的队列id列表
function getFightTeamIdList(self)
    return self:instance().m_fightTeamIdList
end

-- 获取队列id对应队列数据字典
function getTeamDic(self)
    return self:instance().m_teamDic
end

-- 获取队列id对应选择的阵型英雄列表字典
function getTeamHeroListDic(self)
    return self:instance().m_teamHeroListDic
end

-- 判断队列id是否出战中
function isTeamIdInFight(self, teamId)
    return table.indexof(self:getFightTeamIdList(), teamId)
end

-- 根据队列id获取对应的队列数据
function getTeamVoByTeamId(self, teamId)
    local teamVo = self:getTeamDic()[teamId]
    return teamVo
end

-- 根据队列id获取对应的阵型英雄列表
function __getFormationHeroListByTeamId(self, teamId)
    return self:getTeamHeroListDic()[teamId] or {}
end

-- 获取出战中的队列id
function getFightTeamId(self, isNormal)
    local allTeamIdList = nil
    if isNormal then
        allTeamIdList = self:getAllTeamIdList(formation.TYPE.NORMAL)
    else
        allTeamIdList = self:getAllTeamIdList()
    end
    local fightTeamIdList = self:getFightTeamIdList()
    if fightTeamIdList then
        for k, teamId in pairs(fightTeamIdList) do
            if (table.indexof(allTeamIdList, teamId)) then
                return teamId
            end
        end
    end
end

-- 获取当前阵型是否被锁定
function isLockFormation(self)
    local dupVo = nil
    local data = self:getData()
    if (data and type(data) == "table") then
        local battleType = data.battleType or data.m_battleType
        local dupId = data.dupId or data.m_battleFieldId
        if battleType == PreFightBattleType.MainMapStage then -- 主线普通推图关卡
            local hapterVo, _dupVo = battleMap.MainMapManager:getChapterVoByStageId(dupId)
            dupVo = _dupVo
        elseif data.battleType == PreFightBattleType.ClimbTowerDup then -- 爬塔副本 --climb_tower_dup_data
            dupVo = dup.DupClimbTowerManager:getDeepDupVo(data.dupId)
        elseif data.battleType == PreFightBattleType.RogueLike then -- 肉鸽 event_cycle_dup_data
            dupVo = dup.DupClimbTowerManager:getDeepDupVo(data.dupId)
        elseif data.battleType == PreFightBattleType.DupApostle2War then -- 使徒之战2 boss_cloister_dup_data
            dupVo = dup.DupApostlesWarManager:getDupDataById(data.dupId)
        elseif data.battleType == PreFightBattleType.ElementTower then -- 元素塔 element_tower_dup_data
            dupVo = dup.DupClimbTowerManager:getDeepDupVo(data.dupId)
        elseif data.battleType == PreFightBattleType.Cycle then -- 元素塔 element_tower_dup_data
            dupVo = cycle.CycleManager:getCycleDupData(data.dupId)
        elseif data.battleType == PreFightBattleType.Fragment then -- 元素塔 element_tower_dup_data
            local hapterVo, _dupVo = battleMap.FragmentMapManager:getChapterVoByStageId(data.dupId)
            dupVo = _dupVo
        elseif battleType == PreFightBattleType.ActiveDup then -- 1.1活动 activity_stage_step_data
            dupVo = mainActivity.ActiveDupManager:getStageVo(dupId)
        elseif battleType == PreFightBattleType.ActiveDupHell then -- 主题活动强袭模式 activity_stage_step_data
            dupVo = mainActivity.ActiveDupManager:getStageVo(dupId)
        elseif battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate then -- 工会战
            dupVo = guild.GuildManager:getGuildBossDupIdConfig(nil, dupId)
        elseif battleType == PreFightBattleType.SandPlay then
            dupVo = sandPlay.SandPlayManager:getStageConfigVo(dupId)

        elseif battleType == PreFightBattleType.Doundless then
            dupVo = doundless.DoundlessManager:getDoundlessCityStageDataById(dupId)
        elseif battleType == PreFightBattleType.Seabed then
            dupVo = seabed.SeabedManager:getSeabedDupDataById(dupId)
        end

        if dupVo ~= nil then
            local formationId = dupVo:getFormationId()
            if formationId ~= 0 then
                return 1, formationId
            end
        end
    end
    return 0, 0
end

-- 根据队列id获取出战中的阵型id
function getFightFormationId(self, teamId)
    local lock, formationId = self:isLockFormation()
    if lock == 1 then
        return formationId
    end

    teamId = teamId and teamId or self:getFightTeamId()
    local teamVo = self:getTeamVoByTeamId(teamId)
    if (teamVo) then
        return teamVo.formationId
    end
end

-- 获取当前功能类型对应的所有的队列id列表
function getAllTeamIdList(self, type)
    if type then
        return formation.getTeamIdListByType(type, self:getDataId())
    end
    return formation.getTeamIdListByType(self:getType(), self:getDataId())
end

-- 根据队列id获取所在队列id模块的索引位置
function getTeamIdIndex(self, teamId)
    return formation.getTeamIndex(self:getType(), teamId)
end

-- 设置操作队列的队长id
function setSelectTeamCaptainHeroId(self, teamId, captainHeroId)
    local allFormationHeroList = self:getSelectFormationHeroList(teamId)
    for _, selectFormationHeroVo in pairs(allFormationHeroList) do
        selectFormationHeroVo.isCaptainHero = captainHeroId == selectFormationHeroVo.heroId
    end
    self:dispatchEvent(self.UPDATE_TEAM_CAPTAIN_ID, {
        teamId = teamId
    })
end

-- 更新队列对应的英雄列表和助战列表
function updateSelectList(self, teamId)
    local selectDic = self:getSelectFormationHeroListDic()
    if (selectDic and selectDic[teamId]) then
        local selectList = selectDic[teamId]
        if (selectList) then
            for i = #selectList, 1, -1 do
                LuaPoolMgr:poolRecover(selectList[i])
                table.remove(selectList, i)
            end
        end
        selectDic[teamId] = nil
    end
    self:getSelectFormationHeroList(teamId)

    selectDic = self:getSelectTeamAssistHeroListDic()
    if (selectDic and selectDic[teamId]) then
        local selectList = selectDic[teamId]
        if (selectList) then
            for i = #selectList, 1, -1 do
                LuaPoolMgr:poolRecover(selectList[i])
                table.remove(selectList, i)
            end
        end
        selectDic[teamId] = nil
    end
    self:getSelectTeamAssistHeroList(teamId)
end

-- 操作队列对应的英雄列表
-- teamId：操作的队列id
-- formationId：操作的阵型id
-- selectHeroId：选择的英雄的id
-- selectHeroTid：选择的英雄的tid
-- selectHeroSourceType：选择的英雄的类型
-- targetPos：要替换的目标格子位置
function setSelectFormationHeroList(self, teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType,
targetPos, isCheckCan)
local selectFormationHeroVo = nil
local targetFormationHeroVo = nil
local allFormationHeroList = self:getSelectFormationHeroList(teamId)
for i = #allFormationHeroList, 1, -1 do
    if (allFormationHeroList[i].heroPos == targetPos) then
        targetFormationHeroVo = allFormationHeroList[i]
    end
    if (allFormationHeroList[i].heroId == selectHeroId) then
        selectFormationHeroVo = allFormationHeroList[i]
    end
end
if (targetFormationHeroVo) then
    -- 下阵英雄或交换英雄
    if (selectFormationHeroVo) then
        if (targetFormationHeroVo.heroId == selectHeroId) then
            -- 删除英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
            if (teamId == self:getFightTeamId()) then
                -- 判断删除后是否留有至少一个玩家自己的英雄
                if (selectHeroSourceType == formation.HERO_SOURCE_TYPE.OWN) then
                    local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                    if (ownCount <= 1 and targetFormationHeroVo.heroId == selectHeroId) then
                        if (#allFormationHeroList > ownCount) then
                            gs.Message.Show(_TT(1267))
                        else
                            gs.Message.Show(_TT(1252))
                        end
                        return false
                    end
                end
            end
            for i = #allFormationHeroList, 1, -1 do
                local delFormationHeroVo = allFormationHeroList[i]
                if (delFormationHeroVo.heroPos == targetPos) then
                    LuaPoolMgr:poolRecover(delFormationHeroVo)
                    table.remove(allFormationHeroList, i)
                    break
                end
            end
            self:validateCaptain(teamId)
            self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {targetPos = targetPos})
            return false
        else
            -- 交换英雄
            targetFormationHeroVo.heroPos, selectFormationHeroVo.heroPos = selectFormationHeroVo.heroPos,
            targetFormationHeroVo.heroPos
        end
    else
        -- 更换英雄，判断是否出战队列，是出战队列则需要保留至少一个我方英雄，不是出战队列则可以全部下阵
        if (teamId == self:getFightTeamId()) then
            -- 判断更换后是否留有至少一个玩家自己的英雄
            if (selectHeroSourceType ~= formation.HERO_SOURCE_TYPE.OWN) then
                local ownCount = self:getSelectFilterHeroCount(teamId, formation.HERO_SOURCE_TYPE.OWN)
                if (ownCount <= 1 and targetFormationHeroVo.heroId ~= selectHeroId) then
                    if (targetFormationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
                        gs.Message.Show(_TT(1267))
                        return false
                    end
                end
            end
        end

        -- 更换英雄，判断选择能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
        for i = 1, #allFormationHeroList do
            local formationHeroVo = allFormationHeroList[i]
            -- 排除同一阵型格子
            if (formationHeroVo.heroPos ~= targetPos) then
                -- 排除同一英雄id
                if (formationHeroVo.heroId ~= selectHeroId) then
                    -- 过滤相同tid的
                    if (formationHeroVo:getHeroTid() == selectHeroTid) then
                        gs.Message.Show(_TT(1253))
                        return false
                    end
                end
            end
        end

        -- 确保在助战中的相同英雄被替换成功才允许添加到助战
        local isCan = true
        if (isCheckCan) then
            local updateAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
            if (updateAssistHeroVo) then
                isCan = false
                local result = self:setSelectTeamAssistHeroList(teamId, formationId, targetFormationHeroVo.heroId,
                targetFormationHeroVo:getHeroTid(), selectHeroSourceType, updateAssistHeroVo.heroPos, false)
                if (result) then
                    isCan = true
                end
            end
        end

        if (isCan) then
            targetFormationHeroVo.heroId = selectHeroId
            targetFormationHeroVo.heroPos = targetFormationHeroVo.heroPos
            targetFormationHeroVo.sourceType = selectHeroSourceType

            local heroVo = hero.HeroManager:getHeroVo(targetFormationHeroVo.heroId)
            if heroVo then
                local orgData = heroVo:getConfigVo():getOrgData()
                if orgData and orgData.join_voice then
                    AudioManager:playHeroCVOnReplace(orgData.join_voice)
                end
            end
        end
    end
else
    -- 更换位置或添加英雄
    if (selectFormationHeroVo) then
        -- 更换位置
        selectFormationHeroVo.heroPos = targetPos
    else
        -- 上阵英雄，判断能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
        for i = 1, #allFormationHeroList do
            local formationHeroVo = allFormationHeroList[i]
            -- 排除同一阵型格子
            if (formationHeroVo.heroPos ~= targetPos) then
                -- 排除同一英雄id
                if (formationHeroVo.heroId ~= selectHeroId) then
                    -- 过滤相同tid的
                    if (formationHeroVo:getHeroTid() == selectHeroTid) then
                        gs.Message.Show(_TT(1254))
                        return false
                    end
                end
            end
        end
        -- 判断上阵的上限
        local heroMaxCount = self:getFormationHeroMaxCount(formationId)
        local allCount = self:getSelectFilterHeroCount(teamId)
        if (allCount >= heroMaxCount) then
            gs.Message.Show(_TT(1255) .. heroMaxCount)
            return false
        end

        -- 确保在出战中的相同英雄被移除成功才允许添加到助战
        local isCan = true
        if (isCheckCan) then
            local delAssistHeroVo = self:getSelectTeamAssistHeroVoById(teamId, selectHeroId, selectHeroSourceType)
            if (delAssistHeroVo) then
                isCan = false
                local result = self:setSelectTeamAssistHeroList(teamId, formationId, selectHeroId, selectHeroTid,
                selectHeroSourceType, delAssistHeroVo.heroPos, false)
                if (result) then
                    isCan = true
                end
            end
        end

        if (isCan) then
            -- 添加英雄
            local addFormationHeroVo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            addFormationHeroVo.heroId = selectHeroId
            addFormationHeroVo.heroPos = targetPos
            addFormationHeroVo.sourceType = selectHeroSourceType
            table.insert(allFormationHeroList, addFormationHeroVo)

            local heroVo = hero.HeroManager:getHeroVo(addFormationHeroVo.heroId)
            if heroVo then
                local orgData = heroVo:getConfigVo():getOrgData()
                if orgData and orgData.join_voice then
                    AudioManager:playHeroCVOnReplace(orgData.join_voice)
                end
            end
        end
    end
end
self:validateCaptain(teamId)
self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {targetPos = targetPos})
return true
end

-- 验证下阵英雄是不是也下掉了队长，是的话自动选一个
function validateCaptain(self, teamId)
    local formationHeroVo = nil
    local allFormationHeroList = self:getSelectFormationHeroList(teamId)
    for i = #allFormationHeroList, 1, -1 do
        formationHeroVo = allFormationHeroList[i]
        if (formationHeroVo.isCaptainHero) then
            return
        end
    end
    if (formationHeroVo) then
        self:setSelectTeamCaptainHeroId(teamId, formationHeroVo.heroId)
    end
end

-- 根据队列id获取阵型选择中的英雄列表
function getSelectFormationHeroList(self, teamId)
    self:instance().m_selectFormationHeroDic = self:instance().m_selectFormationHeroDic and
    self:instance().m_selectFormationHeroDic or {}
    if (teamId == nil) then
        teamId = self:getFightTeamId()
    end
    local selectFormationHeroList = self:instance().m_selectFormationHeroDic[teamId]
    if (selectFormationHeroList == nil) then
        selectFormationHeroList = {}
        self:instance().m_selectFormationHeroDic[teamId] = selectFormationHeroList
        local formationHeroList = self:__getFormationHeroListByTeamId(teamId)
        for key, value in pairs(formationHeroList) do
            local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            table.insert(selectFormationHeroList, vo:copy(value))
        end
    end
    return selectFormationHeroList
end

function initPetData(self)
    for k, v in pairs(self:instance().mInUsePetDic) do
        self:instance().mTempPetDic[k] = v
    end
end

function getPetIdByTeamId(self, teamId)
    if self:instance().mTempPetDic[teamId] then
        return self:instance().mTempPetDic[teamId]
    end
    return 0
end

function getIsPetChange(self, teamId)
    return self:instance().mTempPetDic[teamId] ~= self:instance().mInUsePetDic[teamId]
end

function setUsePetByTeamId(self, teamId, petId)
    self:instance().mTempPetDic[teamId] = petId
end

function resetPetTempList(self)
    self:instance().mTempPetDic = {}
end

-- 获取选择的阵容英雄列表字典
function getSelectFormationHeroListDic(self)
    return self:instance().m_selectFormationHeroDic
end

-- 根据队列id获取阵型选择中的筛选过的英雄数量
function getSelectFilterHeroCount(self, teamId, heroSourceType)
    local selectList = self:getSelectFormationHeroList(teamId)
    local count = 0
    for key, value in pairs(selectList) do
        if (heroSourceType == nil or value.sourceType == heroSourceType) then
            count = count + 1
        end
    end
    return count
end

-- 获取英雄列表有变化的队列id列表
function getChangeTeamIdList(self)
    local changeTeamIdList = {}
    local allTeamIdList = self:getAllTeamIdList()
    for k, teamId in pairs(allTeamIdList) do
        if (self:isTeamChange(teamId)) then
            table.insert(changeTeamIdList, teamId)
        end
    end
    return changeTeamIdList
end

-- 指定队列是否发生改变（阵型和助战改变）
function isTeamChange(self, teamId)
    -- 先不用这么全面判断
    -- if (self:getTeamVoByTeamId(teamId) and self:__getFormationHeroListByTeamId(teamId)) then
    local isChange = self:isTeamHeroListChange(teamId)
    if (not isChange) then
        isChange = self:isTeamAssistHeroListChange(teamId)
    end
    if not isChange then
        isChange = self:getIsPetChange(teamId)
    end
    -- end
    return isChange
end

-- 判断队列id对应的原始英雄列表和选择英雄列表是否有改变
function isTeamHeroListChange(self, teamId)
    local selectList = self:getSelectFormationHeroList(teamId)
    local sourceList = self:__getFormationHeroListByTeamId(teamId)
    if (#selectList ~= #sourceList) then
        return true
    else
        for k, sourceHeroVo in pairs(sourceList) do
            local isHasHeroId = false
            for _k, selectHeroVo in pairs(selectList) do
                if (sourceHeroVo.heroId == selectHeroVo.heroId) then
                    isHasHeroId = true
                    if (sourceHeroVo.heroPos ~= selectHeroVo.heroPos or sourceHeroVo.sourceType ~=
                    selectHeroVo.sourceType or sourceHeroVo.isCaptainHero ~= selectHeroVo.isCaptainHero) then
                    return true
                end
            end
        end
        if (not isHasHeroId) then
            return true
        end
    end
end
return false
end

-- 判断队列id对应的原始助战英雄列表和选择助战英雄列表是否有改变
function isTeamAssistHeroListChange(self, teamId)
    local selectList = self:getSelectTeamAssistHeroList(teamId)
    local sourceList = self:__getTeamAssistHeroListByTeamId(teamId)
    if (#selectList ~= #sourceList) then
        return true
    else
        for k, sourceAssistHeroVo in pairs(sourceList) do
            local isHasHeroId = false
            for _k, selectAssistHeroVo in pairs(selectList) do
                if (sourceAssistHeroVo.heroId == selectAssistHeroVo.heroId) then
                    isHasHeroId = true
                    if (sourceAssistHeroVo.heroPos ~= selectAssistHeroVo.heroPos) then
                        return true
                    end
                end
            end
            if (not isHasHeroId) then
                return true
            end
        end
    end
    return false
end

function setSelectFormationTeamId(self, teamId)
    self.mSelectFormationTeamId = teamId
end

function getSelectFormationTeamId(self)
    return self.mSelectFormationTeamId and self.mSelectFormationTeamId or self:getFightTeamId(true)
end

-- 获取我方英雄的tid列表
function getMySelectHeroTidList(self, teamId)
    local tidList = {}
    local formationHeroList = self:getSelectFormationHeroList(teamId)
    for i = #formationHeroList, 1, -1 do
        local formationHeroVo = formationHeroList[i]
        if (formationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN) then
            table.insert(tidList, formationHeroVo:getHeroTid())
        end
    end
    return tidList
end

-- 清理选择的所有队列英雄字典
function clearSelectHeroDic(self)
    local selectDic = self:getSelectFormationHeroListDic()
    if (selectDic) then
        for teamId, selectList in pairs(selectDic) do
            if (selectList) then
                for i = #selectList, 1, -1 do
                    LuaPoolMgr:poolRecover(selectList[i])
                    table.remove(selectList, i)
                end
            end
            selectDic[teamId] = nil
        end
    end
end

-- 清理选择的所有队列助战英雄字典
function clearSelectAssistHeroDic(self)
    local selectDic = self:getSelectTeamAssistHeroListDic()
    if (selectDic) then
        for teamId, selectList in pairs(selectDic) do
            if (selectList) then
                for i = #selectList, 1, -1 do
                    LuaPoolMgr:poolRecover(selectList[i])
                    table.remove(selectList, i)
                end
            end
            selectDic[teamId] = nil
        end
    end
end

-- 清理所有队列对应的非玩家自己的英雄
function clearAllTeamOtherHero(self)
    local allTeamIdList = self:getAllTeamIdList()
    for k, teamId in pairs(allTeamIdList) do
        -- 先不用这么全面判断
        -- if (self:getTeamVoByTeamId(teamId) and self:__getFormationHeroListByTeamId(teamId)) then
        self:clearTeamOtherHero(teamId)
        -- end
    end
end

-- 清理队列对应的非玩家自己的英雄
function clearTeamOtherHero(self, teamId)
    local formationHeroList = self:getSelectFormationHeroList(teamId)
    for i = #formationHeroList, 1, -1 do
        local formationHeroVo = formationHeroList[i]
        if (formationHeroVo.sourceType ~= formation.HERO_SOURCE_TYPE.OWN) then
            LuaPoolMgr:poolRecover(formationHeroVo)
            table.remove(formationHeroList, i)
        end
    end
end

-- 根据队列id、英雄id、英雄类型，判断英雄是否出战中
function isHeroInFormation(self, teamId, heroId, heroSourceType)
    local formationHeroList = self:getSelectFormationHeroList(teamId)
    for i = 1, #formationHeroList do
        if (formationHeroList[i].heroId == heroId) then
            if (heroSourceType) then
                if (formationHeroList[i].sourceType == heroSourceType) then
                    return true
                else
                    return false
                end
            else
                return true
            end
        end
    end
    return false
end

-- 根据阵型id、列、行获取指定的阵型格子次序
function getFormationTilePos(self, formationId, colIndex, rowIndex)
    local formationConfigVo = self:getFormationConfigVo(formationId)
    if formationConfigVo then
        local formationConfigList = formationConfigVo:getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            local col_x = formationConfigList[i][2][1]
            local row_y = formationConfigList[i][2][2]
            if (col_x == colIndex and row_y == rowIndex) then
                return pos
            end
        end
    end
    return 0
end

-- 判断格子是否解锁
function getFormationTileLock(self, formationId, colIndex, rowIndex)
    local lock = false
    local id = 0
    local formationConfigVo = self:getFormationConfigVo(formationId)
    if formationConfigVo then
        local lockList = sysParam.SysParamManager:getValue(SysParamType.FORMATION_LOCK)
        local formationConfigList = formationConfigVo:getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            local col_x = formationConfigList[i][2][1]
            local row_y = formationConfigList[i][2][2]

            if (col_x == colIndex and row_y == rowIndex and (lockList[i] and lockList[i] > 0)) then
                id = lockList[i]
                lock = not battleMap.MainMapManager:isStagePass(lockList[i])

                return lock, id
            end
        end
    end
    return lock, id
end

-- 根据阵型格子位置获取对应的行列
function getFormationTileRowCol(self, formationId, tilePos)
    local formationConfigVo = self:getFormationConfigVo(formationId)
    if formationConfigVo then
        local formationConfigList = formationConfigVo:getFormationList()
        for i = 1, #formationConfigList do
            local pos = formationConfigList[i][1]
            local col_x = formationConfigList[i][2][1]
            local row_y = formationConfigList[i][2][2]
            if (pos == tilePos) then
                return row_y, col_x
            end
        end
    end
    return 0, 0
end

-- 根据阵型格子位置获取对应的阵型英雄数据（在已上阵字典里搜索）
function getFormationHeroVoByPos(self, teamId, tilePos)
    local formationHeroList = self:getSelectFormationHeroList(teamId)
    for i = 1, #formationHeroList do
        if (formationHeroList[i].heroPos == tilePos) then
            return formationHeroList[i]
        end
    end
    return nil
end

-- 根据英雄唯一id获取对应的阵型英雄数据（在已上阵字典里搜索）
function getFormationHeroVoById(self, teamId, heroId, heroSourceType)
    local formationHeroList = self:getSelectFormationHeroList(teamId)
    for i = 1, #formationHeroList do
        if (formationHeroList[i].heroId == heroId) then
            if (heroSourceType and formationHeroList[i].sourceType == heroSourceType) then
                return formationHeroList[i]
            else
                return formationHeroList[i]
            end
        end
    end
    return nil
end

-- 获取阵型的格子瓦片数量
function getFormationTileCount(self)
    return 3 * 4, 3, 4
end

-- 根据行列获取指定格子的显示序号
function getGridIndexByColAndRow(self, cusCol_x, cusRow_y)
    local formationTileCount, row, col = self:getFormationTileCount()
    local gridIndex = (cusCol_x - 1) * row + cusRow_y
    return gridIndex
end

------------------------------------------------------------------- 助战 -----------------------------------------------------------------------
-- 获取选择的助战英雄列表字典
function getSelectTeamAssistHeroListDic(self)
    return self:instance().mSelectTeamAssistHeroDic
end

-- 根据队列id获取助战选择中的英雄列表
function getSelectTeamAssistHeroList(self, teamId)
    self:instance().mSelectTeamAssistHeroDic = self:instance().mSelectTeamAssistHeroDic and
    self:instance().mSelectTeamAssistHeroDic or {}
    teamId = teamId and teamId or self:getFightTeamId()
    local selectTeamAssistHeroList = self:instance().mSelectTeamAssistHeroDic[teamId]
    if (selectTeamAssistHeroList == nil) then
        selectTeamAssistHeroList = {}
        self:instance().mSelectTeamAssistHeroDic[teamId] = selectTeamAssistHeroList
        local teamAssistHeroList = self:__getTeamAssistHeroListByTeamId(teamId)
        for key, value in pairs(teamAssistHeroList) do
            local vo = LuaPoolMgr:poolGet(formation.FormationAssistVo)
            table.insert(selectTeamAssistHeroList, vo:copy(value))
        end
    end
    return selectTeamAssistHeroList
end

-- 获取队列id对应选择的助战英雄列表字典
function getTeamAssistHeroListDic(self)
    return self:instance().mTeamAssistHeroListDic
end

-- 根据队列id获取对应的助战英雄列表
function __getTeamAssistHeroListByTeamId(self, teamId)
    return self:getTeamAssistHeroListDic()[teamId] or {}
end

-- 根据队列id和助战部位获取对应的助战英雄数据
function getSelectTeamAssistHeroVoByPos(self, teamId, assitHeroPos)
    local list = self:getSelectTeamAssistHeroList(teamId)
    for i = 1, #list do
        if (list[i].heroPos == assitHeroPos) then
            return list[i]
        end
    end
end

-- 根据队列id和助战部位获取对应的助战英雄数据
function getSelectTeamAssistHeroVoById(self, teamId, assitHeroId)
    local list = self:getSelectTeamAssistHeroList(teamId)
    for i = 1, #list do
        if (list[i].heroId == assitHeroId) then
            return list[i]
        end
    end
end

-- 判断英雄是否在助战中
function isHeroInAssist(self, teamId, heroId)
    local allAssistHeroList = self:getSelectTeamAssistHeroList(teamId)
    for i = 1, #allAssistHeroList do
        if (allAssistHeroList[i].heroId == heroId) then
            return true
        end
    end
    return false
end

-- 操作队列对应的助战英雄列表
-- teamId：操作的队列id
-- formationId：操作的阵型id
-- selectHeroId：选择的助战英雄的id
-- selectHeroTid：选择的助战英雄的tid
-- selectHeroSourceType：选择的助战英雄的类型
-- targetPos：要替换的目标格子位置
function setSelectTeamAssistHeroList(self, teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType,
targetPos, isCheckCan)
local selectAssistHeroVo = nil
local targetAssistHeroVo = nil
local allAssistHeroList = self:getSelectTeamAssistHeroList(teamId)
for i = #allAssistHeroList, 1, -1 do
    if (allAssistHeroList[i].heroPos == targetPos) then
        targetAssistHeroVo = allAssistHeroList[i]
    end
    if (allAssistHeroList[i].heroId == selectHeroId) then
        selectAssistHeroVo = allAssistHeroList[i]
    end
end
if (targetAssistHeroVo) then
    -- 下阵英雄或交换英雄
    if (selectAssistHeroVo) then
        if (targetAssistHeroVo.heroId == selectHeroId) then
            for i = #allAssistHeroList, 1, -1 do
                local delAssistHeroVo = allAssistHeroList[i]
                if (delAssistHeroVo.heroPos == targetPos) then
                    LuaPoolMgr:poolRecover(delAssistHeroVo)
                    table.remove(allAssistHeroList, i)
                    break
                end
            end
        else
            -- 交换英雄
            targetAssistHeroVo.heroPos, selectAssistHeroVo.heroPos = selectAssistHeroVo.heroPos,
            targetAssistHeroVo.heroPos
        end
    else
        -- 更换英雄，判断选择能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
        for i = 1, #allAssistHeroList do
            local assistHeroVo = allAssistHeroList[i]
            -- 排除同一阵型格子
            if (assistHeroVo.heroPos ~= targetPos) then
                -- 排除同一英雄id
                if (assistHeroVo.heroId ~= selectHeroId) then
                    -- 过滤相同tid的
                    if (assistHeroVo:getHeroTid() == selectHeroTid) then
                        gs.Message.Show(_TT(1253))
                        return false
                    end
                end
            end
        end

        -- 确保在出战中的相同英雄被替换成功才允许添加到助战
        local isCan = true
        if (isCheckCan) then
            local updateFormationHeroVo = self:getFormationHeroVoById(teamId, selectHeroId, selectHeroSourceType)
            if (updateFormationHeroVo) then
                isCan = false
                local result = self:setSelectFormationHeroList(teamId, formationId, targetAssistHeroVo.heroId,
                targetAssistHeroVo:getHeroTid(), selectHeroSourceType, updateFormationHeroVo.heroPos, false)
                if (result) then
                    isCan = true
                end
            end
        end

        if (isCan) then
            targetAssistHeroVo.heroId = selectHeroId
            targetAssistHeroVo.heroPos = targetPos
            -- targetAssistHeroVo.sourceType = selectHeroSourceType
            local heroVo = hero.HeroManager:getHeroVo(targetAssistHeroVo.heroId)
            if heroVo then
                local orgData = heroVo:getConfigVo():getOrgData()
                if orgData and orgData.join_voice then
                    AudioManager:playHeroCVOnReplace(orgData.join_voice)
                end
            end
        end
    end
else
    -- 更换位置或添加英雄
    if (selectAssistHeroVo) then
        -- 更换位置
        selectAssistHeroVo.heroPos = targetPos
    else
        -- 上阵英雄，判断能否上阵，当前选择的英雄是否存在当前阵型中，同一个阵型中不允许有相同tid的英雄
        for i = 1, #allAssistHeroList do
            local assistHeroVo = allAssistHeroList[i]
            -- 排除同一阵型格子
            if (assistHeroVo.heroPos ~= targetPos) then
                -- 排除同一英雄id
                if (assistHeroVo.heroId ~= selectHeroId) then
                    -- 过滤相同tid的
                    if (assistHeroVo:getHeroTid() == selectHeroTid) then
                        gs.Message.Show(_TT(1254))
                        return false
                    end
                end
            end
        end

        -- 确保在出战中的相同英雄被移除成功才允许添加到助战
        local isCan = true
        if (isCheckCan) then
            local delFormationHeroVo = self:getFormationHeroVoById(teamId, selectHeroId, selectHeroSourceType)
            if (delFormationHeroVo) then
                isCan = false
                local result = self:setSelectFormationHeroList(teamId, formationId, selectHeroId, selectHeroTid,
                selectHeroSourceType, delFormationHeroVo.heroPos, false)
                if (result) then
                    isCan = true
                end
            end
        end

        if (isCan) then
            -- 添加英雄
            local addAssistHeroVo = LuaPoolMgr:poolGet(formation.FormationAssistVo)
            addAssistHeroVo.heroId = selectHeroId
            addAssistHeroVo.heroPos = targetPos
            -- addAssistHeroVo.sourceType = selectHeroSourceType
            table.insert(allAssistHeroList, addAssistHeroVo)

            local heroVo = hero.HeroManager:getHeroVo(addAssistHeroVo.heroId)
            if heroVo then
                local orgData = heroVo:getConfigVo():getOrgData()
                if orgData and orgData.join_voice then
                    AudioManager:playHeroCVOnReplace(orgData.join_voice)
                end
            end
        end

    end
end
self:dispatchEvent(self.UPDATE_TEAM_FORMATION_DATA, {})
return true
end

function getRecommandFight(self)
    local recommandFight = nil
    local data = self:getData()
    if (data and type(data) == "table") then
        local battleType = data.battleType
        local dupId = data.dupId
        if (battleType and dupId) then
            local mgr = FightResultProxy.battleMgrDic[battleType]
            if (mgr) then
                if not mgr.getRecommandFight then
                    logWarn(string.format("战斗类型%s的manager未提供getRecommandFight方法", battleType),
                    "FormationManager")
                else
                    recommandFight = mgr:getRecommandFight(dupId)
                end
            end
        end
    end
    return recommandFight
end

-- 解析元素同调数据
function parseElementResonanceData(self)
    self:instance().elementData = {}
    local baseData = RefMgr:getData("ele_resonance_data")
    for k, v in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(formation.ForamtionElementConfigVo)
        configVo:parseData(k, v)
        self:instance().elementData[k] = configVo
    end
end

-- 获取元素同调数据
function getElementResonanceData(self)
    if self:instance().elementData == nil then
        self:parseElementResonanceData()
    end
    return self:instance().elementData
end

function getDupVo(self, battleType, dupId)
    local dupVo = nil
    if battleType == nil and self:getData() and type(self:getData()) == "table" then
        battleType = self:getData().battleType
    end
    if dupId == nil and self:getData() and type(self:getData()) == "table" then
        dupId = self:getData().dupId
    end
    if not battleType or not dupId then
        return nil
    end
    if battleType == PreFightBattleType.MainMapStage then
        local chapterVo = nil
        chapterVo, dupVo = battleMap.MainMapManager:getChapterVoByStageId(dupId)
    elseif battleType == PreFightBattleType.ClimbTowerDup then
        dupVo = dup.DupClimbTowerManager:getDupVo(dupId)
    elseif battleType == PreFightBattleType.ElementTower then
        dupVo = dup.DupClimbTowerManager:getDeepDupVo(dupId)
    elseif battleType == PreFightBattleType.HeroBiography then
        dupVo = battleMap.BiographyManager:getDupConfigVo(dupId)
    elseif battleType == PreFightBattleType.DupMoney or battleType == PreFightBattleType.DupEquip_Low or
        battleType == PreFightBattleType.DupEquip_Mid or battleType == PreFightBattleType.DupEquip_High or
        battleType == PreFightBattleType.DupEquipTupo or battleType == PreFightBattleType.DupExp or
        battleType == PreFightBattleType.DupBracelets or battleType == PreFightBattleType.DupHeroStarUp or
        battleType == PreFightBattleType.DupHeroGrowUp or battleType == PreFightBattleType.DupHeroSkill or
        battleType == PreFightBattleType.DupFirePotency or battleType == PreFightBattleType.DupIcePotency or
        battleType == PreFightBattleType.DupElectricPotency or battleType ==
        PreFightBattleType.DupCavitationPotency or battleType == PreFightBattleType.DupLifePotency or
        battleType == PreFightBattleType.DupBraceletUp or battleType ==
        PreFightBattleType.DupBraceletEvolve then
        dupVo = dup.DupDailyMainManager:getDupData(dupId)
    elseif battleType == PreFightBattleType.DupApostle2War then
        dupVo = dup.DupApostlesWarManager:getDupBaseVo(dupId)
    elseif battleType == PreFightBattleType.ArenaChallenge then
        dupVo = arena.ArenaManager:getRobotData(dupId)
    elseif battleType == PreFightBattleType.CodeHopeDup then
        dupVo = dup.DupCodeHopeManager:getDupVo(dupId)
    elseif battleType == PreFightBattleType.Training then
        dupVo = training.TrainingManager:getTrainingDupConfigVo(dupId)
    elseif battleType == PreFightBattleType.DupImplied then
        dupVo = dup.DupImpliedManager:getDupInfo(dupId)
    elseif battleType == PreFightBattleType.DupBranchEquip then
        dupVo = branchStory.BranchStoryManager:getStageConfigVo(dupId)
    elseif battleType == PreFightBattleType.DupMaze then
        local eventVo = maze.MazeSceneManager:getMazeEventVo(dupId)
        if eventVo then
            local dupId = eventVo:getEffecctList()[1]
            dupVo = maze.MazeManager:getDupConfigVo(dupId)
        end
    elseif battleType == PreFightBattleType.DupTactivs then
        dupVo = branchStory.BranchTactivsManager:getTactivsStageConfigVo(dupId)
    elseif battleType == PreFightBattleType.BranchMain then
        dupVo = branchStory.BranchMainManager:getMainStageConfigVo(dupId)
    elseif battleType == PreFightBattleType.BranchPower then
        dupVo = branchStory.BranchPowerManager:getPowerVo(dupId)
    elseif battleType == PreFightBattleType.MainExplore then
        dupVo = mainExplore.MainExploreManager:getTriggerDupData()
    elseif battleType == PreFightBattleType.Cycle then
        dupVo = cycle.CycleManager:getCycleDupData(dupId)
    elseif battleType == PreFightBattleType.Fragment then
        local chapterVo = nil
        chapterVo, dupVo = battleMap.FragmentMapManager:getChapterVoByStageId(dupId)
    elseif battleType == PreFightBattleType.ActiveDup then
        dupVo = mainActivity.ActiveDupManager:getStageVo(dupId)
    elseif battleType == PreFightBattleType.ActiveDupHell then
        dupVo = mainActivity.ActiveDupManager:getStageVoByHell(dupId)
    elseif battleType == PreFightBattleType.Guild_boss_war or battleType == PreFightBattleType.Guild_boss_imitate then
        dupVo = guild.GuildManager:getGuildBossDupIdConfig(nil, dupId)
    elseif battleType == PreFightBattleType.Guild_Imitate  then
        dupVo = guildBossImitate.GuildBossImitateManager:getDupConfig(dupId)
    elseif battleType == PreFightBattleType.SandPlay then
        dupVo = sandPlay.SandPlayManager:getStageConfigVo(dupId)

    elseif battleType == PreFightBattleType.Doundless then
        dupVo = doundless.DoundlessManager:getDoundlessCityStageDataById(dupId)
    elseif battleType == PreFightBattleType.Guild_Sweep then
        dupVo = guild.GuildManager:getSweepDupDataByDupId(dupId)
    elseif battleType == PreFightBattleType.Disaster or battleType == PreFightBattleType.Disater_imitate then
        dupVo = disaster.DisasterManager:getDisasterDupDataByDupId(dupId)
    elseif battleType == PreFightBattleType.Seabed then
        dupVo = seabed.SeabedManager:getSeabedDupDataById(dupId)
    end
    return dupVo
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(1254):"不可上阵相同战员"
语言包: _TT(1253):"已有相同战员"
语言包: _TT(1255):"上阵战员最大数量为"
语言包: _TT(1254):"不可上阵相同战员"
语言包: _TT(1253):"已有相同战员"
语言包: _TT(1267):"请至少保留一个我方战员"
语言包: _TT(1252):"不可下阵全部战员"
语言包: _TT(1267):"请至少保留一个我方战员"
]]
