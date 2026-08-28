-------------------------------------------------------------------------------
-- 和风战牌 - 工具类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 16:24:21
-------------------------------------------------------------------------------

---@class BattleCardGameUtils
local BattleCardGameUtils = Class('BattleCardGameUtils')


---@type integer @ 牌组的卡牌数量
BattleCardGameUtils.DeckCardCount = 5


---@type integer @ 牌组的自由卡牌数量（不受等级限制）
BattleCardGameUtils.DeckFreeLimit = 1


---@type integer @ 高级卡牌星级
BattleCardGameUtils.CardAdvancedStar = 5


---@type integer @ 特效卡牌星级
BattleCardGameUtils.CardEffectedStar = 6


---@type string[] @ 卡牌星级名字列表
BattleCardGameUtils.CardStarNames = {
    'I', 'II', 'III', 'IV', 'V', 'VI', 
}


---@alias BattleCardGameUtils.CardAttrIndex integer @ 卡牌属性方向
BattleCardGameUtils.CardAttrIndex = {
    TOP    = 1, -- 上
    RIGHT  = 2, -- 右
    BOTTOM = 3, -- 下
    LEFT   = 4, -- 左
}


--- 游戏常量定义
BattleCardGameUtils.PlayDefines = {
    ROUND_SECONDS = 40, -- 每回合的秒数
    BOARD_ROWS    = 3,  -- 棋盘 行数
    BOARD_COLS    = 3,  -- 棋盘 列数
    CARD_ATTR_MIN = 1,  -- 卡牌属性 最小值
    CARD_ATTR_MAX = 10, -- 卡牌属性 最大值
}


---@alias BattleCardGameUtils.RuleEffect integer @ 规则效果 (@see 活动汇总/战牌/流行规则类型表.csv)
BattleCardGameUtils.RuleEffects = {
    CARDS_PUBLIC    = 1,  -- 明   牌（卡牌：初始翻牌）
    CARDS_SWAP      = 5,  -- 交   换（卡牌：初始交换）
    ORDER_CHAOS     = 2,  -- 混   乱（出牌：指定顺序）
    ORDER_INDEX     = 6,  -- 秩   序（出牌：初始顺序）
    RULE_OVERFLOW   = 3,  -- 王牌杀手（规则：1比A大，逆转下A比1大）
    RULE_REVERSAL   = 7,  -- 逆   转（规则：反转大小对比条件）
    RULE_SAME       = 10, -- 同   数（规则：2处及以上临边分别相等）
    RULE_SAME_COMBO = 11, -- 同数连锁（规则：同数连锁版，以同数方式吃掉的牌再继续做同数连锁检测。后端只连锁了一次，不是无限连锁）
    RULE_PLUS       = 12, -- 加   算（规则：2处及以上临边相加相等）
    RULE_PLUS_COMBO = 13, -- 加算连锁（规则：加算连锁版，以加算方式吃掉的牌再继续做加算连锁检测。后端只连锁了一次，不是无限连锁）
    TYPE_INCREASE   = 4,  -- 同盟强化（类型：同类强化。全场同类统计，不区分敌我）
    TYPE_DECREASE   = 8,  -- 同盟弱化（类型：同类弱化。全场同类统计，不区分敌我）
    TYPE_INC_FIXED  = 9,  -- 同盟定强（类型：同类指定强化值。全场同类统计，不区分敌我）
    TYPE_DEC_FIXED  = 14, -- 同盟定弱（类型：同类指定弱化值。全场同类统计，不区分敌我）
}


---@alias BattleCardGameUtils.PlayResult integer @ 游戏结果
BattleCardGameUtils.PlayResult = {
    NONE = 0, -- 未知
    WIN  = 1, -- 胜利
    DRAW = 2, -- 平局
    FAIL = 3, -- 失败
}


---@alias BattleCardGameUtils.ParamsId integer @ 参数id
BattleCardGameUtils.ParamsId = {
    REVERT_TIMES      = 1,  -- 体力回复时间（分号分割）
    REVERT_NUMS       = 2,  -- 体力回复数量（分号分割）
    HP_GOOGDS_ID      = 3,  -- 体力id
    HP_INIT_NUM       = 4,  -- 体力初始值
    HP_LIMIT_NUM      = 5,  -- 体力最大值
    MALL_CURRENCY_ID  = 6,  -- 商店货币id
    HP_EXCHANGE_ID    = 7,  -- 兑换体力-消耗道具id
    HP_EXCHANGE_NUM   = 8,  -- 兑换体力-消耗道具数量（分号分隔）
    HP_RECEIVE_NUM    = 9,  -- 兑换体力-得到的数量
    HP_EXCHANGE_LIMIT = 10, -- 兑换体力-每天次数上限
    GAME_BGM_NAME     = 11, -- 打战牌时的背景音乐
}


---@alias BattleCardGameUtils.PlayerPrefsKey string @ 本地玩家数据存储key
BattleCardGameUtils.PlayerPrefsKey = {
    QuestDeckIndex   = 'BattleCardGameUtils_QuestDeckIndex__questId_',
    GamePlayHandbook = 'BattleCardGameUtils_GamePlayHandbook',
}


---@alias BattleCardGameUtils.LuaSrcPath string @ lua脚本路径
BattleCardGameUtils.LuaSrcPath = {
    BaseCardNode = 'Game.UI.BattleCardGame.BattleCardGameCardNode',     -- 基础卡牌节点路径
    PlayCardNode = 'Game.UI.BattleCardGame.BattleCardGamePlayCardNode', -- 战中卡牌节点路径
}


---@alias BattleCardGameUtils.EventsName string @ 事件名字
BattleCardGameUtils.EventsName = {
    HAVE_CARDS_CHANGE  = 'BattleCardGameUtils__HAVE_CARDS_CHANGE',  -- 卡牌 数量变化
    DECK_CARDS_CHANGE  = 'BattleCardGameUtils__DECK_CARDS_CHANGE',  -- 卡组 编辑变化
    DECK_LEVEL_CHANGE  = 'BattleCardGameUtils__DECK_LEVEL_CHANGE',  -- 卡组 等级变化
    SOCKET_CONNECT     = 'BattleCardGameUtils__SOCKET_CONNECT',     -- TCP 连接成功
    SOCKET_TIMEOUT     = 'BattleCardGameUtils__SOCKET_TIMEOUT',     -- TCP 连接超时
    SOCKET_STOPPED     = 'BattleCardGameUtils__SOCKET_STOPPED',     -- TCP 连接终止
    TCP_ENTER_TAKE     = 'BattleCardGameUtils__TCP_ENTER_TAKE',     -- TCP 收到9002
    TCP_MATCHED_NOTICE = 'BattleCardGameUtils__TCP_MATCHED_NOTICE', -- TCP 收到9006
    TCP_SYNC_TAKE      = 'BattleCardGameUtils__TCP_SYNC_TAKE',      -- TCP 收到9008
    TCP_OPERATE_NOTICE = 'BattleCardGameUtils__TCP_OPERATE_NOTICE', -- TCP 收到9010
    TCP_RESULT_NOTICE  = 'BattleCardGameUtils__TCP_RESULT_NOTICE',  -- TCP 收到9014
    TCP_ABANDON_TAKE   = 'BattleCardGameUtils__TCP_ABANDON_TAKE',   -- TCP 收到9016
    TCP_OPERATE_ERROR  = 'BattleCardGameUtils__TCP_OPERATE_ERROR',  -- TCP 收到9018
}


---@alias BattleCardGameUtils.PacketDefines table<string, PacketDefine> @ 数据包定义
BattleCardGameUtils.PacketDefines = {
    --             = send -->
    ENTER_SEND     = {PacketId = 9001, PacketName = '战牌->进入NPC'},
    SYNC_SEND      = {PacketId = 9003, PacketName = '战牌->重连同步'},
    ABANDON_SEND   = {PacketId = 9007, PacketName = '战牌->认输'},
    OPERATE_SEND   = {PacketId = 9009, PacketName = '战牌->出牌'},
    --             = <-- take
    ENTER_TAKE     = {PacketId = 9002, PacketName = '战牌<-确认NPC', PacketEvent = BattleCardGameUtils.EventsName.TCP_ENTER_TAKE},
    MATCHED_NOTICE = {PacketId = 9006, PacketName = '战牌<-匹配成功', PacketEvent = BattleCardGameUtils.EventsName.TCP_MATCHED_NOTICE},
    SYNC_TAKE      = {PacketId = 9008, PacketName = '战牌<-重连结果', PacketEvent = BattleCardGameUtils.EventsName.TCP_SYNC_TAKE},
    OPERATE_NOTICE = {PacketId = 9010, PacketName = '战牌<-系统出牌', PacketEvent = BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE},
    RESULT_NOTICE  = {PacketId = 9014, PacketName = '战牌<-结算结果', PacketEvent = BattleCardGameUtils.EventsName.TCP_RESULT_NOTICE},
    ABANDON_TAKE   = {PacketId = 9016, PacketName = '战牌<-认输确认', PacketEvent = BattleCardGameUtils.EventsName.TCP_ABANDON_TAKE},
    OPERATE_ERROR  = {PacketId = 9018, PacketName = '战牌<-出牌出错', PacketEvent = BattleCardGameUtils.EventsName.TCP_OPERATE_ERROR},
}


---@type table<BattleCardGameUtils.ParamsId, number>
BattleCardGameUtils.paramValueMap_ = {}


-------------------------------------------------------------------------------
-- about conf
-------------------------------------------------------------------------------

--- 获取指定 和风战牌 卡牌信息vo
---@return BattleCardGameCardInfoVo
function BattleCardGameUtils.GetCardInfoVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10001, 'BattleCardGame.BattleCardGameCardInfoVo', id) or {}
end

--- 获取全部 和风战牌 卡牌信息vo
---@return BattleCardGameCardInfoVo[]
function BattleCardGameUtils.GetAllCardInfoVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10001, 'BattleCardGame.BattleCardGameCardInfoVo')
end


--- 获取指定 和风战牌 初始卡牌vo
---@return BattleCardGameCardInitVo
function BattleCardGameUtils.GetCardInitVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10002, 'BattleCardGame.BattleCardGameCardInitVo', id) or {}
end

--- 获取全部 和风战牌 初始卡牌vo
---@return BattleCardGameCardInitVo[]
function BattleCardGameUtils.GetAllCardInitVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10002, 'BattleCardGame.BattleCardGameCardInitVo')
end


--- 获取指定 和风战牌 卡牌种类vo
---@return BattleCardGameCardKindVo
function BattleCardGameUtils.GetCardKindVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10003, 'BattleCardGame.BattleCardGameCardKindVo', id) or {}
end

--- 获取全部 和风战牌 卡牌种类vo
---@return BattleCardGameCardKindVo[]
function BattleCardGameUtils.GetAllCardKindVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10003, 'BattleCardGame.BattleCardGameCardKindVo')
end


--- 获取指定 和风战牌 卡组信息vo
---@return BattleCardGameDeckInfoVo
function BattleCardGameUtils.GetDeckInfoVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10004, 'BattleCardGame.BattleCardGameDeckInfoVo', id) or {}
end

--- 获取全部 和风战牌 卡组信息vo
---@return BattleCardGameDeckInfoVo[]
function BattleCardGameUtils.GetAllDeckInfoVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10004, 'BattleCardGame.BattleCardGameDeckInfoVo')
end


--- 获取指定 和风战牌 收集册vo
---@return BattleCardGameCollectionVo
function BattleCardGameUtils.GetCollectionVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10005, 'BattleCardGame.BattleCardGameCollectionVo', id) or {}
end

--- 获取全部 和风战牌 收集册vo
---@return BattleCardGameCollectionVo[]
function BattleCardGameUtils.GetAllCollectionVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10005, 'BattleCardGame.BattleCardGameCollectionVo')
end


--- 获取指定 和风战牌 关卡信息vo
---@return BattleCardGameNpcQuestVo
function BattleCardGameUtils.GetNpcQuestVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10006, 'BattleCardGame.BattleCardGameNpcQuestVo', id) or {}
end

--- 获取全部 和风战牌 关卡信息vo
---@return BattleCardGameNpcQuestVo[]
function BattleCardGameUtils.GetAllNpcQuestVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10006, 'BattleCardGame.BattleCardGameNpcQuestVo')
end


--- 获取指定 和风战牌 规则定义vo
---@return BattleCardGameRuleInfoVo
function BattleCardGameUtils.GetRuleInfoVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10007, 'BattleCardGame.BattleCardGameRuleInfoVo', id) or {}
end

--- 获取全部 和风战牌 规则定义vo
---@return BattleCardGameRuleInfoVo[]
function BattleCardGameUtils.GetAllRuleInfoVo()
    return CfUtils.GetWholeVo(AutoIds.IdSetting10007, 'BattleCardGame.BattleCardGameRuleInfoVo')
end


--- 获取指定 和风战牌 参数定义vo
---@return BattleCardGameComParamsVo
function BattleCardGameUtils.GetCommonParamsVo(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting10008, 'BattleCardGame.BattleCardGameComParamsVo', id) or {}
end


--- 根据参数id 获取参数表的值
---@param paramId BattleCardGameUtils.ParamsId
---@param isString boolean | nil
---@return number | string
function BattleCardGameUtils.GetParamValue(paramId, isString)
    local paramValue = BattleCardGameUtils.paramValueMap_[paramId]
    if not paramValue then
        local paramVo = BattleCardGameUtils.GetCommonParamsVo(paramId)
        paramValue = isString and tostring(paramVo.paramValue) or checkNumber(paramVo.paramValue)
        BattleCardGameUtils.paramValueMap_[paramId] = paramValue
    end
    return paramValue
end


-------------------------------------------------------------------------------
-- about res
-------------------------------------------------------------------------------

--- 获取 规则图标路径
---@param ruleId integer
---@return string
function BattleCardGameUtils.GetRuleIconPath(ruleId)
    return string.fmt('UIAtlas/ActivityJapaneseLevel/Battle/activity_poker_icon_buff_%1.png', checkInt(ruleId))
end


--- 获取 属性值图标路径
---@param attrNum integer
---@return string
function BattleCardGameUtils.GetAttrNumIconPath(attrNum)
    return string.fmt('UIAtlas/ActivityJapaneseLevel/Battle/activity_poker_card_number_%1.png', checkInt(attrNum))
end


-------------------------------------------------------------------------------
-- about short
-------------------------------------------------------------------------------

---@return BattleCardGameComponent
function BattleCardGameUtils.GetComp()
    return GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.BattleCardGameComponent)
end


--- 获取 打牌体力id
---@return integer
function BattleCardGameUtils.GetHpGoodsId()
    return BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_GOOGDS_ID)
end


--- 获取 商店货币id
---@return integer
function BattleCardGameUtils.GetMallCurrencyId()
    return BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.MALL_CURRENCY_ID)
end


--- 获取 打牌体力 兑换道具id
---@return integer
function BattleCardGameUtils.GetHpExchangeId()
    return BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_EXCHANGE_ID)
end


--- 获取 打牌体力 兑换道具数量
---@param times integer @ 第几次兑换
---@return integer
function BattleCardGameUtils.GetHpExchangeNum(times)
    local numTimes = checkInt(times)
    local numValue = BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.HP_EXCHANGE_NUM, true)
    local numList  = string.split2(numValue, ';')
    return checkInt(numList[math.min(numTimes, #numList)])
end


-------------------------------------------------------------------------------
-- about views
-------------------------------------------------------------------------------

--- 背景节点 播放入场你动画 
---@param bgNode UnityEngine.RectTransform
function BattleCardGameUtils.BgNodePlayEnterAnim(bgNode)
    if isNull(bgNode) then return end

    ---@type BattleCardGameMainBgNode
    local mainBgNode = CfUtils.GetLuaScr(bgNode, 'Game.UI.BattleCardGame.BattleCardGameMainBgNode')
    if isNull(mainBgNode) then return end

    mainBgNode:PlayEnterAnim()
end


--- 卡牌节点 加载并实例化
---@param parentNode UnityEngine.RectTransform
---@return UnityEngine.RectTransform | nil
function BattleCardGameUtils.LoadBattleCardNode(parentNode)
    local parentNodeObj  = parentNode and parentNode.gameObject or nil
    local battleCardPath = 'Prefabs/ActivityJapaneseLevel/PokerBattle/PokerCardNode.prefab'
    local battleCardNode = GameUtils.LoadBundleSync(battleCardPath, parentNodeObj, false)
    return CfUtils.GetRectTransform(battleCardNode)
end


--- 卡牌节点 刷新内容
---@param battleCardNode UnityEngine.RectTransform
---@param battleCardId integer
---@param extraParams table | nil
function BattleCardGameUtils.UpcateBattleCardNode(battleCardNode, battleCardId, extraParams)
    if isNull(battleCardNode) then return end

    ---@type BattleCardGameCardNode
    local cardNodeEnv = CfUtils.GetLuaScr(battleCardNode, BattleCardGameUtils.LuaSrcPath.BaseCardNode)
    if isNull(cardNodeEnv) then return end

    cardNodeEnv:SetBattleCardId(battleCardId)
    if extraParams then
        cardNodeEnv:ParseExtraParams(extraParams)
    end
end


-------------------------------------------------------------------------------
-- about sounds
-------------------------------------------------------------------------------

function BattleCardGameUtils.PlayGameBgm()
    local gameBgmName  = BattleCardGameUtils.GetParamValue(BattleCardGameUtils.ParamsId.GAME_BGM_NAME, true)
    local CriWareUtils = GameUtils.GetCriWareUtils()
    CriWareUtils.RecordBgm() -- 先记录旧的bgm
    CriWareUtils.PlayMusicById(gameBgmName)
end


function BattleCardGameUtils.RevertGameBgm()
    local CriWareUtils = GameUtils.GetCriWareUtils()
    CriWareUtils.PlayLastBGMMusic()
end


-------------------------------------------------------------------------------
-- about boards
-------------------------------------------------------------------------------

--- 根据棋盘位置 获取 四周的位置id map
---@param positionId integer @ 位置id
---@return table<BattleCardGameUtils.CardAttrIndex, integer>
function BattleCardGameUtils.GetBoardAroundIdMap(positionId)
    local aroundIdMap = {}
    local boardRowMax = BattleCardGameUtils.PlayDefines.BOARD_ROWS
    local boardColMax = BattleCardGameUtils.PlayDefines.BOARD_COLS
    local boardRowNum = math.ceil(positionId / boardColMax)
    local boardColNum = (positionId - 1) % boardColMax + 1

    if boardRowNum > 0 and boardRowNum <= boardRowMax then
        local upPositionId    = (boardRowNum > 1) and (positionId - boardColMax) or 0
        local downPositionId  = (boardRowNum < boardRowMax) and (positionId + boardColMax) or 0
        local leftPositionId  = (boardColNum > 1) and (positionId - 1) or 0
        local rightPositionId = (boardColNum < boardColMax) and (positionId + 1) or 0

        if upPositionId > 0 then
            aroundIdMap[BattleCardGameUtils.CardAttrIndex.TOP] = upPositionId
        end
        if downPositionId > 0 then
            aroundIdMap[BattleCardGameUtils.CardAttrIndex.BOTTOM] = downPositionId
        end
        if leftPositionId > 0 then
            aroundIdMap[BattleCardGameUtils.CardAttrIndex.LEFT] = leftPositionId
        end
        if rightPositionId > 0 then
            aroundIdMap[BattleCardGameUtils.CardAttrIndex.RIGHT] = rightPositionId
        end
    end

    return aroundIdMap
end


return BattleCardGameUtils
