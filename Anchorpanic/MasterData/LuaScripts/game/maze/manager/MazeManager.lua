module("maze.MazeManager", Class.impl(Manager))

-- 排行榜更新
EVENT_MAZE_RANK_UPDATE = "EVENT_MAZE_RANK_UPDATE"

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
    -- 迷宫异常字典
    self.mAbnormalDic = nil
    -- 迷宫物资列表
    self.mGoodsConfigDic = nil
    -- 迷宫副本列表
    self.mDupConfigDic = nil
    -- 迷宫排行奖励列表
    self.mRankAwardList = nil

    -- 迷宫信息列表
    self.mMazeList = nil
    -- 迷宫战员信息（包含自己的和支援的）
    self.mHeroListDic = nil
    -- 迷宫副本怪物信息
    self.mMonsterListDic = nil
    -- 已经激活的物资列表字典
    self.mGoodsList = nil
    -- 我的排名
    self.myRank = nil
    -- 我的最短通关时间
    self.myPassTime = nil
    -- 排行版列表
    self.rankList = nil
    -- 挑战通过后计算用到的数据
    self.mCaculateData = nil
end

-- 解析迷宫拥有异常数据
function parseAbnormalConfig(self)
    self.mAbnormalDic = {}
    local baseData = RefMgr:getData('maze_abnormal_data')
    for key, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(maze.MazeAbnormalConfigVo)
        configVo:parseData(key, data)
        self.mAbnormalDic[key] = configVo
    end
end

-- 解析迷宫物资配置
function parseGoodsConfig(self)
    self.mGoodsConfigDic = {}
    local baseData = RefMgr:getData('maze_supplies_data')
    for key, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(maze.MazeGoodsConfigVo)
        configVo:parseData(key, data)
        self.mGoodsConfigDic[key] = configVo
    end
end

-- 解析迷宫副本配置
function parseDupConfig(self)
    self.mDupConfigDic = {}
    local baseData = RefMgr:getData('maze_dup_data')
    for key, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(maze.MazeDupConfigVo)
        configVo:parseData(key, data)
        self.mDupConfigDic[key] = configVo
    end
end

-- 解析迷宫排行奖励配置
function parseRankAwardConfig(self)
    self.mRankAwardList = {}
    local baseData = RefMgr:getData('maze_reward_data')
    for key, data in pairs(baseData) do
        local rewardVo = LuaPoolMgr:poolGet(rank.RankRewardVo)
        rewardVo:parseData(key, data)
        table.insert(self.mRankAwardList, rewardVo)
    end
    table.sort(self.mRankAwardList, function(a, b)
        return a.leftRank < b.leftRank
    end)
end

--- *s2c* 返回迷宫面板信息 19160
function parseMsgMazeList(self, mazeList)
    self.mMazeList = {}
    for i = 1, #mazeList do
        local mazeVo = maze.MazeVo.new()
        mazeVo:setData(mazeList[i])
        table.insert(self.mMazeList, mazeVo)
    end
    table.sort(self.mMazeList, function(a, b)
        return a.mazeId < b.mazeId
    end)
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_PANEL_DATA)
end

--- *s2c* 迷宫排行榜返回 19167
function parseMazeRankInfo(self, msg)
    self.myRank = msg.my_rank
    self.myPassTime = msg.my_pass_cost_time
    self.rankList = {}
    for i, v in ipairs(msg.rank_list) do
        local vo = dup.DupImpliedRankVo.new()
        -- local vo = rank.RankBaseVo.new()
        vo:parseMsg(v)
        table.insert(self.rankList, vo)
    end
    -- self:dispatchEvent(self.EVENT_MAZE_RANK_UPDATE)
    GameDispatcher:dispatchEvent(EventName.EVENT_RANK_UPDATE)
end

-- 返回迷宫战员信息（包含自己的和支援的）
function parseMazeHeroList(self, msg)
    if(not self.mHeroListDic)then
        self.mHeroListDic = {}
    end
    if(not self.mHeroListDic[msg.maze_id])then
        self.mHeroListDic[msg.maze_id] = {}
    end
    local heroList = self.mHeroListDic[msg.maze_id]
    for i = 1, #heroList do
        LuaPoolMgr:poolRecover(heroList[i])
    end
    heroList = {}
    self.mHeroListDic[msg.maze_id] = heroList

    for i = 1, #msg.hero_info do
        local mazeHeroVo = LuaPoolMgr:poolGet(maze.MazeHeroVo)
        mazeHeroVo:setData(msg.hero_info[i])
        table.insert(heroList, mazeHeroVo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_HERO_LIST, {mazeId = msg.maze_id})
end

-- 返回迷宫指定副本怪物信息
function parseDupMonsterList(self, msg)
    if(not self.mMonsterListDic)then
        self.mMonsterListDic = {}
    end
    if(not self.mMonsterListDic[msg.maze_id])then
        self.mMonsterListDic[msg.maze_id] = {}
    end
    if(not self.mMonsterListDic[msg.maze_id][msg.target_pos])then
        self.mMonsterListDic[msg.maze_id][msg.target_pos] = {}
    end
    local monsterList = self.mMonsterListDic[msg.maze_id][msg.target_pos]
    for i = 1, #monsterList do
        LuaPoolMgr:poolRecover(monsterList[i])
    end
    monsterList = {}
    self.mMonsterListDic[msg.maze_id][msg.target_pos] = monsterList

    for i = 1, #msg.mon_info do
        local mazeHeroVo = LuaPoolMgr:poolGet(maze.MazeHeroVo)
        mazeHeroVo:setData(msg.mon_info[i])
        table.insert(monsterList, mazeHeroVo)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_MONSTER_LIST, {mazeId = msg.maze_id})
end

-- 迷宫挑战通过后计算用到的数据
function setCaculateData(self, msg)
    if(msg)then
        self.mCaculateData = {mazeId = msg.maze_id, tileId = msg.target_pos, buffIdList = msg.buff_list}
    else
        self.mCaculateData = nil
    end
end
-- 迷宫挑战通过后计算用到的数据
function getCaculateData(self)
    return self.mCaculateData
end

-- 设置迷宫通过所有副本后的数据
function setAllDupPassData(self, msg)
    -- 奖励(第二次通过为空)
    if(msg and #msg.award > 0)then
        self.mAllDupPassData = {mazeId = msg.maze_id, awardMsgList = msg.award}
    else
        self.mAllDupPassData = nil
    end
end
-- 获取迷宫通过所有副本后的数据
function getAllDupPassData(self)
    return self.mAllDupPassData
end

-- 设置物资列表
function setGoodsList(self, mazeId, list)
    if(not self.mGoodsList)then
        self.mGoodsList = {}
    end
    self.mGoodsList[mazeId] = list
end

-- 新增物资列表
function addGoods(self, mazeId, goodsId)
    if(goodsId > 0)then
        if(not self.mGoodsList)then
            self.mGoodsList = {}
        end
        if(not self.mGoodsList[mazeId])then
            self.mGoodsList[mazeId] = {}
        end
        table.insert(self.mGoodsList[mazeId], 1, goodsId)
    end
end

-- 获取境界的异常环境列表
function getAbnormalConfigVo(self, abnromalId)
    if(not self.mAbnormalDic)then
        self:parseAbnormalConfig()
    end
    return self.mAbnormalDic[abnromalId]
end

-- 获取物资列表
function getGoodsList(self, mazeId)
    if(self.mGoodsList)then
        return self.mGoodsList[mazeId]
    end
    return {}
end

-- 获取迷宫信息列表
function getMazeList(self)
    return self.mMazeList or {}
end

-- 获取迷宫信息
function getMazeVo(self, mazeId)
    if(self.mMazeList)then
        for i = 1, #self.mMazeList do
            if(self.mMazeList[i].mazeId == mazeId)then
                return self.mMazeList[i]
            end
        end
    end
    return nil
end

-- 获取迷宫战员vo列表
function getMazeHeroVoList(self, mazeId)
    if(self.mHeroListDic)then
        return self.mHeroListDic[mazeId]
    end
end

-- 获取迷宫战员列表
function getMazeHeroList(self, mazeId, sourceType, isNeedHeroId)
    local list = {}
    if(self.mHeroListDic)then
        local tempList = self.mHeroListDic[mazeId]
        for i = 1, #tempList do
            local mazeHeroVo = tempList[i]
            if(sourceType == nil or mazeHeroVo.sourceType == sourceType)then
                table.insert(list, isNeedHeroId and mazeHeroVo.heroId or mazeHeroVo)
            end
        end
        return list
    end
    return list
end

-- 获取迷宫战员
function getMazeHero(self, mazeId, heroId, sourceType)
    local heroList = self:getMazeHeroList(mazeId, sourceType, false)
    if(heroList)then
        for i = 1, #heroList do
            local mazeHeroVo = heroList[i]
            if(mazeHeroVo.heroId == heroId)then
                return mazeHeroVo
            end
        end
    end
    local mazeHeroVo = maze.MazeHeroVo.new()
    mazeHeroVo.heroId = heroId
    mazeHeroVo.monsterId = nil
    mazeHeroVo.sourceType = sourceType
    mazeHeroVo.nowHp = 1
    mazeHeroVo.maxHp = 1
    return mazeHeroVo
end

-- 获取迷宫副本怪物列表
function getMazeMonsterList(self, mazeId, tildId)
    if(self.mMonsterListDic)then
        local dic = self.mMonsterListDic[mazeId]
        if(dic)then
            return dic[tildId]
        end
    end
    return {}
end

-- 获取副本怪物
function getMazeMonster(self, mazeId, tildId, monsterId)
    local monsterList = self:getMazeMonsterList(mazeId, tildId)
    if(monsterList)then
        for i = 1, #monsterList do
            local mazeHeroVo = monsterList[i]
            if(mazeHeroVo.monsterId == monsterId)then
                return mazeHeroVo
            end
        end
    end
    local mazeHeroVo = maze.MazeHeroVo.new()
    mazeHeroVo.heroId = nil
    mazeHeroVo.monsterId = monsterId
    mazeHeroVo.nowHp = 1
    mazeHeroVo.maxHp = 1
    return mazeHeroVo
end

-- 获取物资数据
function getGoodsConfigVo(self, buffId)
    if(not self.mGoodsConfigDic)then
        self:parseGoodsConfig()
    end
    return self.mGoodsConfigDic[buffId]
end

-- 获取副本数据
function getDupConfigVo(self, dupId)
    if(not self.mDupConfigDic)then
        self:parseDupConfig()
    end
    return self.mDupConfigDic[dupId]
end

-- 获取排行奖励数据
function getRankAwardList(self)
    if self.mRankAwardList == nil then
        self:parseRankAwardConfig()
    end
    return self.mRankAwardList
end

-- 本地记录下每次进入的迷宫id，用于战斗后打开迷宫
function setLastMazeId(self, mazeId)
    self.mLastMazeId = mazeId
end
function getLastMazeId(self)
    return self.mLastMazeId
end

-- 战斗结算界面用
function getDupName(self, tileId)
    local caculateData = self:getCaculateData()
    local tileId = caculateData and caculateData.tileId or tileId
    local mazeEventVo = maze.MazeSceneManager:getMazeEventVo(tileId)
    if(mazeEventVo)then
        local eventConfigVo = maze.MazeSceneManager:getEventConfigVo(mazeEventVo:getEventId())
        return eventConfigVo:getEventTitle()
    else
        Debug:log_error("MazeManager", string.format("找不到格子id为%s的事件数据", tileId))
    end
end

function getRecommandFight(self, tileId)
    local mazeEventVo = maze.MazeSceneManager:getMazeEventVo(tileId)
    if(mazeEventVo)then
        local dupId = mazeEventVo:getEffecctList()[1]
        local dupConfigVo = maze.MazeManager:getDupConfigVo(dupId)
        return dupConfigVo:getRecommandFight()
    else
        Debug:log_error("MazeManager", string.format("找不到格子id为%s的事件数据", tileId))
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
