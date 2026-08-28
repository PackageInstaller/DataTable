-------------------------------------------------------------------------------
-- 夜巡迷宫 - 工具类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-21 11:31:53
-------------------------------------------------------------------------------

---@class PatrolMazeUtils
local PatrolMazeUtils = Class('PatrolMazeUtils')


-- 初始选卡数量
PatrolMazeUtils.EnterAreaCardNum = 4

-- 战斗选卡数量
PatrolMazeUtils.QuestTeamCardNum = 4


---@alias PatrolMazeUtils.ParamsId integer @ 参数id
PatrolMazeUtils.ParamsId = {
    HELP_CARD_NUM        = 1,  -- 助战角色数量（后端用）
    BUFF_SELECT_NUM      = 2,  -- 圣物每次选择数量（后端用）
    FLOOR_START_NUM      = 6,  -- 开始层
    FLOOR_ENDED_NUM      = 7,  -- 结束层
    SHOW_PRODUCT_NUM     = 10, -- 迷宫商店商品数量（后端用）
    CARD_ATK_LIMIT       = 12, -- 攻击系数上限
    CARD_DEF_LIMIT       = 13, -- 防御系数上限
    CARD_HP_LIMIT        = 14, -- 血量系数上限
    REST_HP_RECOVER      = 15, -- 休息点血量恢复百分比
    PRIMARY_MAP_DESCR    = 16, -- 关卡页面背景描述
    INIT_CARD_LEVEL      = 17, -- 武装统一默认等级
    MAZE_CURRENCY_ID     = 18, -- 夜巡徽章（货币）
    SHOP_EVENT_DESCR     = 19, -- 商店事件描述
    HELP_EVENT_DESCR     = 20, -- 助战事件描述
    HP_RECOVER_DESCR     = 21, -- 剧情卡牌回血描述
    INIT_CARD_ALEVEL     = 22, -- 武装统一默认突破等级
    MAZE_BGM_NAME        = 23, -- BGM
    BUFF_REFRESH_COUNT   = 24, -- 圣物刷新次数（后端用）
    BUFF_REFRESH_CONSUME = 25, -- 圣物刷新消耗数量（夜巡徽章）
    MAZE_SCORE_ID        = 26, -- 积分道具
    MAZE_SCORE_DESCR     = 27, -- 积分说明
}


---@alias PatrolMazeUtils.EventsName string @ 事件名字
PatrolMazeUtils.EventsName = {
    ENTER_TEAM_SELECT  = 'PatrolMazeUtils_ENTER_TEAM_SELECT',  -- 出战编队-选择
    ENTER_TEAM_ENTER   = 'PatrolMazeUtils_ENTER_TEAM_ENTER',   -- 出战编队-进入
    ENTER_TEAM_CLOSE   = 'PatrolMazeUtils_ENTER_TEAM_CLOSE',   -- 出战编队-关闭
    MAZE_CONTINUE_STEP = 'PatrolMazeUtils_MAZE_CONTINUE_STEP', -- 迷宫需要进行下一步
    MAZE_CHAPTER_END   = 'PatrolMazeUtils_MAZE_CHAPTER_END',   -- 迷宫剧情完成
    MAZE_FLOOR_SELECT  = 'PatrolMazeUtils_MAZE_FLOOR_SELECT',  -- 迷宫层级选择
    MAZE_GOODS_USED    = 'PatrolMazeUtils_MAZE_GOODS_USED',    -- 迷宫使用道具
}


---@alias PatrolMazeUtils.AreaState integer @ 区域点状态
PatrolMazeUtils.AreaState = {
    MAZE_ENDED  = 0,  -- 活动已结束
    TIME_LOCKED = 1,  -- 时间锁定，时间未到
    AREA_LOCKED = 2,  -- 区域锁定，前置区域未通关
    PREV_LOCKED = 3,  -- 前置锁定，前置区域未解锁
    CHALLENGING = 4,  -- 挑战中
    AREA_PASSED = 5,  -- 全通关
}


---@alias PatrolMazeUtils.TaskType integer @ 任务类型 @see 任务内容类型表
PatrolMazeUtils.TaskType = {
    UNKNOWN         = 0,    -- 未知的
    PASSED_AREA_ID  = 2201, -- 通关指定区域
    PASSED_AREA_NUM = 2202, -- 通关区域数量
}


---@alias PatrolMazeUtils.QuestState integer @ 关卡点状态
PatrolMazeUtils.QuestState = {
    UNKNOWN     = 0, -- 未知的
    CURRENT     = 1, -- 当前层
    PAASED      = 2, -- 已通关
    COMING_SOON = 3, -- 下一关
    DISABLE     = 4, -- 未激活
    INVALID     = 5, -- 无效的
}


---@alias PatrolMazeUtils.QuestType integer @ 关卡类型
PatrolMazeUtils.QuestType = {
    UNKNOWN = 0, -- 未知的
    EMPTY   = 1, -- 初级关
    MIDDLE  = 2, -- 中等关
    ELITE   = 3, -- 精英关
    BOSS    = 4, -- BOSS关
    SHOP    = 5, -- 商店关
    STORY   = 6, -- 剧情关
    HELP    = 7, -- 助战关
}


---@alias PatrolMazeUtils.EffectType integer @ 道具效果类型
PatrolMazeUtils.EffectType = {
    UNKNOWN  = 0, -- 未知的
    RECOVER  = 1, -- 回血
    REVIVE   = 2, -- 复活
    ERASURE  = 3, -- 消除（诅咒）
    UP_ATTR  = 5, -- 升属性
    UP_STAR  = 6, -- 升星
    RELIC_UP = 7, -- 圣物选择可多选1个
}


---@alias PatrolMazeUtils.CurseEffectType integer @ 诅咒效果类型
PatrolMazeUtils.CurseEffectType = {
    EMPTY            = 0, -- 无效果
    RELIC_BANNED     = 1, -- 选择圣物界面：无法刷新圣物
    RELIC_CONSUME_UP = 2, -- 选择圣物界面：刷新消耗翻倍
}


---@type table<PatrolMazeUtils.ParamsId, number>
PatrolMazeUtils.paramValueMap_ = {}


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- 夜巡迷宫 迷宫参数表
---@param id PatrolMazeUtils.ParamsId
---@return PatrolMazeParamsVo
function PatrolMazeUtils.GetMazeParamsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting359, 'PatrolMaze.PatrolMazeParamsVo', id) or {}
end


--- 夜巡迷宫 区域信息表
---@return PatrolMazeAreaInfoVo
function PatrolMazeUtils.GetAreaInfoVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting368, 'PatrolMaze.PatrolMazeAreaInfoVo', id) or {}
end


--- 夜巡迷宫 迷宫路线表
---@return PatroMazeFloorPathVo
function PatrolMazeUtils.GetFloorPathVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting369, 'PatrolMaze.PatroMazeFloorPathVo', id) or {}
end


--- 夜巡迷宫 关卡类型表
---@return PatrolMazeQuestTypeVo
function PatrolMazeUtils.GetQuestTypeVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting351, 'PatrolMaze.PatrolMazeQuestTypeVo', id) or {}
end


--- 夜巡迷宫 战斗关卡表
---@return PatrolMazeBattleLevelVo
function PatrolMazeUtils.GetBattleLevelVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting358, 'PatrolMaze.PatrolMazeBattleLevelVo', id) or {}
end


--- 夜巡迷宫 剧情关卡表
---@return PatrolMazeStoryLevelVo
function PatrolMazeUtils.GetStoryLevelVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting356, 'PatrolMaze.PatrolMazeStoryLevelVo', id) or {}
end


--- 夜巡迷宫 关卡奖励表
---@return QuestRewardVo
function PatrolMazeUtils.GetQuestRewardsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting752, 'QuestRewardVo', id) or {}
end


--- 获取 关卡奖励展示道具
---@param areaId integer
---@param floorNum integer
---@param questRewardId integer
---@return table[]
function PatrolMazeUtils.GetQuestShowRewardData(areaId, floorNum, questRewardId)
    local mazeCurrencyId = PatrolMazeUtils.GetCurrencyId()
    local questRewardsVo = PatrolMazeUtils.GetQuestRewardsVo(questRewardId)
    local coefficientVo  = PatrolMazeUtils.GetCoefficientVoAt(areaId, floorNum)
    local showRewardData = {}
    if checkInt(questRewardsVo.mazeCoin) > 0 then
        -- 最终奖励 = 关卡配置的基础奖励 * ( 1 + rewardUp ) 向上取整
        local rewardNum = math.ceil(num_floor(checkInt(questRewardsVo.mazeCoin) * (1 + checkNumber(coefficientVo.rewardUp))))
        table.insert(showRewardData, {goodsId = mazeCurrencyId, num = rewardNum, type = Constants.RewardSourceType.Certain})
    end
    if questRewardsVo.GetShowRewardData then
        table.insertto(showRewardData, questRewardsVo:GetShowRewardData())
    end
    return showRewardData
end


--- 获取 关卡奖励获取道具
---@param areaId integer
---@param floorNum integer
---@param questRewardId integer
---@return table[]
function PatrolMazeUtils.GetQuestDrawRewardData(areaId, floorNum, questRewardId)
    local mazeCurrencyId = PatrolMazeUtils.GetCurrencyId()
    local questRewardsVo = PatrolMazeUtils.GetQuestRewardsVo(questRewardId)
    local coefficientVo  = PatrolMazeUtils.GetCoefficientVoAt(areaId, floorNum)
    local drawRewardData = {}
    if checkInt(questRewardsVo.mazeCoin) > 0 then
        -- 最终奖励 = 关卡配置的基础奖励 * ( 1 + rewardUp ) 向上取整
        local rewardNum = math.ceil(num_floor(checkInt(questRewardsVo.mazeCoin) * (1 + checkNumber(coefficientVo.rewardUp))))
        table.insert(drawRewardData, {goodsId = mazeCurrencyId, num = rewardNum})
    end
    if questRewardsVo.regularReward and questRewardsVo.regularRewardNum then
        table.insertto(drawRewardData, parse_rewards2(questRewardsVo.regularReward, questRewardsVo.regularRewardNum))
    end
    return drawRewardData
end


--- 夜巡迷宫 楼层奖励表
---@return PatrolMazeFloorRewardVo
function PatrolMazeUtils.GetFloorRewardsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting367, 'PatrolMaze.PatrolMazeFloorRewardVo', id) or {}
end


--- 指定区域 全部楼层奖励表
---@return PatrolMazeFloorRewardVo[]
function PatrolMazeUtils.GetFloorRewardsVoList(areaId)
    local floorRewardVoList = {}
    ---@param floorRewardVo PatrolMazeFloorRewardVo
    for _, floorRewardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting367, 'PatrolMaze.PatrolMazeFloorRewardVo')) do
        if floorRewardVo.areaId == checkInt(areaId) then
            table.insert(floorRewardVoList, floorRewardVo)
        end
    end
    return floorRewardVoList
end


--- 夜巡迷宫 迷宫道具表
---@return PatrolMazeGoodsVo
function PatrolMazeUtils.GetMazeGoodsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting353, 'PatrolMaze.PatrolMazeGoodsVo', id) or {}
end


--- 夜巡迷宫 迷宫圣物表
---@return PatrolMazeRelicVo
function PatrolMazeUtils.GetMazeRelicVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting357, 'PatrolMaze.PatrolMazeRelicVo', id) or {}
end


--- 夜巡迷宫 迷宫诅咒表
---@return PatrolMazeCurseVo
function PatrolMazeUtils.GetMazeCurseVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting362, 'PatrolMaze.PatrolMazeCurseVo', id) or {}
end


--- 夜巡迷宫 助战角色表
---@return PatrolMazeAssistCardVo
function PatrolMazeUtils.GetAssistCardVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting361, 'PatrolMaze.PatrolMazeAssistCardVo', id) or {}
end


--- 夜巡迷宫 难度系数表
---@return PatrolMazeCoefficientVo
function PatrolMazeUtils.GetCoefficientVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting366, 'PatrolMaze.PatrolMazeCoefficientVo', id) or {}
end


--- 夜巡迷宫 圣物标签表
---@return PatrolMazeRelicTagVo
function PatrolMazeUtils.GetMazeRelicTagVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting385, 'PatrolMaze.PatrolMazeRelicTagVo', id) or {}
end


--- 夜巡迷宫 迷宫区域官方推荐表
---@return PatrolMazeRecommendVo
function PatrolMazeUtils.GetMazeRecommendVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting386, 'PatrolMaze.PatrolMazeRecommendVo', id) or {}
end


--- 夜巡迷宫 指定区域的全部官方推荐表
---@param areaId integer @ 地区区域id
---@return PatrolMazeRecommendVo[]
function PatrolMazeUtils.GetMazeRecommendVoList(areaId)
    local recommendVoList = {}
    ---@param recommendVo PatrolMazeRecommendVo
    for _, recommendVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting386, 'PatrolMaze.PatrolMazeRecommendVo')) do
        if recommendVo.openAreaId == areaId then
            table.insert(recommendVoList, recommendVo)
        end
    end
    return recommendVoList
end


--- 夜巡迷宫 通过指定区域和层数 获取难度系数表
---@param areaId integer
---@param floorNum integer
---@return PatrolMazeCoefficientVo
function PatrolMazeUtils.GetCoefficientVoAt(areaId, floorNum)
    ---@param coefficientVo PatrolMazeCoefficientVo
    for _, coefficientVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting366, 'PatrolMaze.PatrolMazeCoefficientVo')) do
        if coefficientVo.areaId == areaId and coefficientVo.floorNum == floorNum then
            return coefficientVo
        end
    end
    return {}
end


--- 夜巡迷宫 区域任务表
---@return PatrolMazeAreaTaskVo
function PatrolMazeUtils.GetAreaTaskVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting377, 'PatrolMaze.PatrolMazeAreaTaskVo', id) or {}
end


--- 夜巡迷宫 迷宫分数表
---@return PatrolMazeScoreVo
function PatrolMazeUtils.GetMazeScoreVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting384, 'PatrolMaze.PatrolMazeScoreVo', id) or {}
end


--- 根据参数id 获取参数表的值
---@param paramId PatrolMazeUtils.ParamsId
---@return number
function PatrolMazeUtils.GetParamValue(paramId)
    local paramValue = PatrolMazeUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = PatrolMazeUtils.GetMazeParamsVo(paramId)
        paramValue = checkNumber(paramVo.paramNum)
        PatrolMazeUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


--- 根据参数id 获取参数表的描述
---@param paramId PatrolMazeUtils.ParamsId
---@return string
function PatrolMazeUtils.GetParamDescr(paramId)
    local paramVo = PatrolMazeUtils.GetMazeParamsVo(paramId)
    return checkString(paramVo.paramTxt)
end


-------------------------------------------------------------------------------
-- about short
-------------------------------------------------------------------------------

---@return PatrolMazeComponent
function PatrolMazeUtils.GetComp()
    return GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PatrolMazeComponent)
end


--- 获取 夜巡迷宫货币id
---@return integer
function PatrolMazeUtils.GetCurrencyId()
    return PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.MAZE_CURRENCY_ID)
end


--- 获取 夜巡迷宫积分id
---@return integer
function PatrolMazeUtils.GetScoreId()
    return PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.MAZE_SCORE_ID)
end


--- 获取 层数关起的积分数值
---@param areaId integer
---@param floorNum integer
---@param questType integer
---@return integer
function PatrolMazeUtils.GetScoreNum(areaId, floorNum, questType)
    local scoreNum = 0
    ---@param mazeScoreVo PatrolMazeScoreVo
    for _, mazeScoreVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting384, 'PatrolMaze.PatrolMazeScoreVo')) do
        if mazeScoreVo.floorNum == floorNum then
            scoreNum = mazeScoreVo:GetScoreNum(questType)
            break
        end
    end
    return scoreNum
end


--- 打开 活动主界面
---@param args table
function PatrolMazeUtils.GotoMainDialog(args)
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazePrimaryMapDialog, args, CfUtils.DialogGetAllArgs())
end


-------------------------------------------------------------------------------
-- about card
-------------------------------------------------------------------------------

--- 获取 迷宫内卡牌 基础dojo（无迷宫内数据加成）
---@param cardId integer @ 卡牌配表id
---@return CardDojo | nil
function PatrolMazeUtils.GetMazeCardDojo(cardId)
    local cardConfMgr = CardConfMgr:GetInstance()

    ---@type CardComponent
    local cardComp   = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local initLevel  = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.INIT_CARD_LEVEL)
    local initALevel = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.INIT_CARD_ALEVEL)
    local customData = {
        cardLevel    = initLevel,
        advanceLevel = initALevel,
    }
    if cardComp:IsHasCard(cardId) then
        local myCardDojo = cardComp:GetCardByConfId(cardId)
        customData.star  = myCardDojo.star
    end
    -- 过滤掉配置了错误的卡
    if cardConfMgr:GetCardByRefId(cardId) then
        return CardUtils.GenerateCustomById(cardId, customData)
    else
        return nil
    end
end


--- 获取 代理卡牌 基础dojo（无迷宫内数据加成）
---@param assistId integer @ 代理id
---@return CardDojo
function PatrolMazeUtils.GetAssistCardDojo(assistId)
    local cardConfMgr  = CardConfMgr:GetInstance()
    local assistCardVo = PatrolMazeUtils.GetAssistCardVo(assistId)
    
    local cardId     = assistCardVo.cardId
    local initLevel  = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.INIT_CARD_LEVEL)
    local initALevel = PatrolMazeUtils.GetParamValue(PatrolMazeUtils.ParamsId.INIT_CARD_ALEVEL)
    local customData = {
        cardLevel    = initLevel,
        advanceLevel = initALevel,
        star         = assistCardVo.starNum,
        cardSkin     = assistCardVo.skinId,
    }
    -- 过滤掉配置了错误的卡
    if cardConfMgr:GetCardByRefId(cardId) then
        return CardUtils.GenerateCustomById(cardId, customData)
    else
        return nil
    end
end


return PatrolMazeUtils
