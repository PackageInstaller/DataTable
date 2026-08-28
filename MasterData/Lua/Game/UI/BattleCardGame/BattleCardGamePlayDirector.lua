-------------------------------------------------------------------------------
-- 和风战牌 - 打牌游戏 - 演出控制器
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-12 13:48:23
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local AnimName = {
    ROOT_OPENING_SHOW   = 'ActivityJapanesePokerPlayerBattleDialog_Entry',                   -- 开场动画 显示
    ROOT_OPENING_HIDE   = 'ActivityJapanesePokerPlayerBattleDialog_Out',                     -- 开场动画 隐藏
    BOARD_LIGHT_FLASH   = 'ActivityJapanesePokerPlayerBattleDialog_BoardCardCellLightFlash', -- 棋盘格 高亮闪烁
    BOARD_LIGHT_ALWAYS  = 'ActivityJapanesePokerPlayerBattleDialog_BoardCardCellLightShow',  -- 棋盘格 高亮常亮
    RULE_CELL_SHOW      = 'ActivityJapanesePokerBattleTips_Cell_Show',                       -- 规则节点 显示
    RULE_CELL_SHOW_WAIT = 'ActivityJapanesePokerBattleTips_Cell_Show_Wait',                  -- 规则节点 显示等待
    RULE_CELL_HIDE      = 'ActivityJapanesePokerBattleTips_Cell_Out',                        -- 规则节点 隐藏
    RULE_CELL_HIDE_WAIT = 'ActivityJapanesePokerBattleTips_Cell_Out_Wait',                   -- 规则节点 隐藏等待
    RULE_CELL_ACTIVE    = 'ActivityJapanesePokerBattleTips_Cell_Active',                     -- 规则节点 激活
}

---@class BattleCardGamePlayDirector
local BattleCardGamePlayDirector = Class('BattleCardGamePlayDirector')


function BattleCardGamePlayDirector:__init(viewer)
    ---@type BattleCardGamePlayDialog
    self.gamePlayViewer_ = viewer

    ---@type boolean @ 表现是否执行中
    self.isShowPlaying_ = false

    ---@type UnityEngine.Coroutine @ 表演播放协程
    self.showPlayingCo_ = nil
end


function BattleCardGamePlayDirector:__delete()
    CoStop(self.showPlayingCo_)
    self.gamePlayViewer_ = nil
    self.isShowPlaying_  = nil
    self.showPlayingCo_  = nil
end


-------------------------------------------------
-- get / set

---@return boolean
function BattleCardGamePlayDirector:IsShowPlaying()
    return self.isShowPlaying_
end


-------------------------------------------------
-- public

function BattleCardGamePlayDirector:StopShowPlaying()
    CoStop(self.showPlayingCo_)
    self.isShowPlaying_ = false
end


-------------------------------------------------------------------------------
-- 整体
-------------------------------------------------------------------------------

--- 播放【开场动画】表现
---@param effectViewDatas table[]
---@param finishCb fun():void
function BattleCardGamePlayDirector:PlayOpeningShow(effectViewDatas, finishCb)
    self:StopShowPlaying()

    self.showPlayingCo_ = CoStart(function()
        self.isShowPlaying_ = true

        local animRootNode        = self.gamePlayViewer_.RootNode
        local tipsRuleNodeList    = self.gamePlayViewer_.tipsRuleNodeList_
        local playerCardNodeMap   = self.gamePlayViewer_.playerCardNodeMap_
        local opponentCardNodeMap = self.gamePlayViewer_.opponentCardNodeMap_
        local playerCardSiteMap   = self.gamePlayViewer_.playerCardSiteMap_
        local opponentCardSiteMap = self.gamePlayViewer_.opponentCardSiteMap_
        
        ------------------------------------------------- 显示 vs界面

        -- 隐藏根节点
        CfUtils.SetActive(animRootNode, false)
        
        -- 显示开场vs界面
        local isVsDialogShowing = true
        CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerCardVsDialog, {closeCb = function()
            isVsDialogShowing = false
        end})
        while isVsDialogShowing do
            CoYield()
        end

        -- 显示根节点
        CfUtils.SetActive(animRootNode, true)

        ------------------------------------------------- 播放 显示动画

        -- 双方卡牌状态初始化
        -- for cardIndex, cardNode in pairs(playerCardNodeMap) do
            -- cardNode:StatusToStandby()
        -- end
        -- for cardIndex, cardNode in pairs(opponentCardNodeMap) do
            -- cardNode:StatusToStandby()
        -- end

        -- 播放开场动画
        local openShowTime = CfUtils.GetAnimationTime(animRootNode, AnimName.ROOT_OPENING_SHOW)
        CfUtils.PlayAnimation(animRootNode, AnimName.ROOT_OPENING_SHOW)
        for tipsRuleIndex, tipsRuleNode in ipairs(tipsRuleNodeList) do
            CfUtils.PlayDelayShowAnimation(tipsRuleNode, tipsRuleIndex - 1, AnimName.RULE_CELL_SHOW, AnimName.RULE_CELL_SHOW_WAIT)
        end

        -- 入场动画时，实时同步卡牌位置
        ---@type UnityEngine.Animation
        local rootAnimation = CfUtils.GetOrAddComponent(animRootNode, CS.UnityEngine.Animation)
        while rootAnimation.isPlaying do
            for cardIndex, cardNode in pairs(playerCardNodeMap) do
                cardNode:MoveToSiteNode(playerCardSiteMap[cardIndex])
            end
            for cardIndex, cardNode in pairs(opponentCardNodeMap) do
                cardNode:MoveToSiteNode(opponentCardSiteMap[cardIndex])
            end
            CoYield() -- 更新一帧
        end

        ------------------------------------------------- 演绎 规则效果
        for tipsRuleIndex, tipsRuleNode in ipairs(tipsRuleNodeList) do
            local defaultTime = CfUtils.GetAnimationTime(tipsRuleNode, AnimName.RULE_CELL_ACTIVE)
            CfUtils.PlayAnimation(tipsRuleNode, AnimName.RULE_CELL_ACTIVE)
            if self:ParseInitRuleEffect_(effectViewDatas[tipsRuleIndex]) then
                CoYield(defaultTime)
            end
            CoYield(0.1) -- 为切换到下一个动画留个视觉喘息的气口
        end

        for cardIndex, cardNode in pairs(playerCardNodeMap) do
            cardNode:SetCardIndex(cardIndex)  -- 交换完顺序以后再赋值
            cardNode:SetDraggable(true)
        end
        for cardIndex, cardNode in pairs(opponentCardNodeMap) do
            cardNode:SetCardIndex(cardIndex)  -- 交换完顺序以后再赋值
            cardNode:SetClickable(true)
        end

        ------------------------------------------------- 播放 隐藏动画

        -- 播放开场隐藏
        local openHideTime = CfUtils.GetAnimationTime(animRootNode, AnimName.ROOT_OPENING_HIDE)
        CfUtils.PlayAnimation(animRootNode, AnimName.ROOT_OPENING_HIDE)
        for tipsRuleIndex, tipsRuleNode in ipairs(tipsRuleNodeList) do
            CfUtils.PlayDelayShowAnimation(tipsRuleNode, tipsRuleIndex - 1, AnimName.RULE_CELL_HIDE, AnimName.RULE_CELL_HIDE_WAIT)
        end
        CoYield(openHideTime)

        -- 表现播放完成
        self.isShowPlaying_ = false

        if finishCb then
            finishCb()
        end
    end)
end


--- 表现具体规则效果
---@param effectViewData table
function BattleCardGamePlayDirector:ParseInitRuleEffect_(effectViewData)
    local GameRuleEffects     = BattleCardGameUtils.RuleEffects
    local playerCardNodeMap   = self.gamePlayViewer_.playerCardNodeMap_
    local playerCardSiteMap   = self.gamePlayViewer_.playerCardSiteMap_
    local opponentCardNodeMap = self.gamePlayViewer_.opponentCardNodeMap_
    local opponentCardSiteMap = self.gamePlayViewer_.opponentCardSiteMap_

    ------------------------------------------------- 1:明牌
    if effectViewData.ruleType == GameRuleEffects.CARDS_PUBLIC then
        local playPublicRuleAnimTime = 0
        for cardIndex = 1, checkInt(effectViewData.publicCardNum) do
            local playerCardNode   = playerCardNodeMap[cardIndex]
            local opponentCardNode = opponentCardNodeMap[cardIndex]
            local playerFlipTime   = playerCardNode:PlayRuleAnimByPublic(cardIndex, function()
                playerCardNode:GetCardNode():SetShowPublicEye(true)
            end)
            local opponentFlipTime = opponentCardNode:PlayRuleAnimByPublic(cardIndex, function()
                opponentCardNode:GetCardNode():SetBackState(false)
                opponentCardNode:GetCardNode():SetShowPublicEye(true)
            end)
            playPublicRuleAnimTime = math.max(playPublicRuleAnimTime, playerFlipTime, opponentFlipTime)
        end
        CoYield(playPublicRuleAnimTime)

    ------------------------------------------------- 5:交换（只互换一张）
    elseif effectViewData.ruleType == GameRuleEffects.CARDS_SWAP then
        local swapOperatorIndex    = checkInt(effectViewData.swapOperatorIndex)
        local swapOpponentIndex    = checkInt(effectViewData.swapOpponentIndex)
        local swapPlayerCardNode   = playerCardNodeMap[swapOperatorIndex]
        local swapOpponentCardNode = opponentCardNodeMap[swapOpponentIndex]
        if swapOperatorIndex == 0 or swapOpponentIndex == 0 then
            return true
        end
        -- 双方卡牌交换位置
        local isSwapPlayerPublic   = swapPlayerCardNode:GetCardNode():IsShowPublicEye()
        local isSwapOpponentPublic = swapOpponentCardNode:GetCardNode():IsShowPublicEye()
        local playerCardMoveTime   = swapPlayerCardNode:PlayRuleAnimBySwap(opponentCardSiteMap[swapOpponentIndex])
        local opponentCardMoveTime = swapOpponentCardNode:PlayRuleAnimBySwap(playerCardSiteMap[swapOperatorIndex])
        CoYield(math.max(playerCardMoveTime, opponentCardMoveTime))
        -- 交换卡牌的节点记录
        playerCardNodeMap[swapOperatorIndex] = swapOpponentCardNode
        opponentCardNodeMap[swapOpponentIndex] = swapPlayerCardNode
        -- 卡牌相互状态
        local playerCardFlipTime   = 0
        local opponentCardFlipTime = 0
        -- 玩家换给对手的牌：如果对手牌是之前就是明牌，则不需要翻转到背面了
        if isSwapOpponentPublic then
            -- 直接换色为对方的颜色
            swapPlayerCardNode:GetCardNode():SetRedPlayMode(true)
            -- 如果玩家换过去之前这个位置不是明牌，则需要加上明牌标识
            if not isSwapPlayerPublic then
                swapPlayerCardNode:GetCardNode():SetShowPublicEye(true)
            end
        else
            -- 把玩家的卡牌翻转到背面
            playerCardFlipTime = swapPlayerCardNode:PlayFlipAnim(function()
                swapPlayerCardNode:GetCardNode():SetBackState(true)
                swapPlayerCardNode:GetCardNode():SetRedPlayMode(true)
                swapPlayerCardNode:GetCardNode():SetShowPublicEye(false)
            end)
        end
        -- 对手换给玩家的牌：如果对手牌之前就是明牌，则不需要翻转到正面了
        if isSwapOpponentPublic then
            -- 直接换色为玩家的颜色
            swapOpponentCardNode:GetCardNode():SetBluePlayMode(true)
            -- 如果玩家之前这个位置不是明牌，则需要去掉明牌标识
            if not isSwapPlayerPublic then
                swapOpponentCardNode:GetCardNode():SetShowPublicEye(false)
            end
        else
            -- 把对方的卡牌翻转到正面
            opponentCardFlipTime = swapOpponentCardNode:PlayFlipAnim(function()
                swapOpponentCardNode:GetCardNode():SetBackState(false)
                swapOpponentCardNode:GetCardNode():SetBluePlayMode(true)
                if isSwapPlayerPublic then
                    swapOpponentCardNode:GetCardNode():SetShowPublicEye(true)
                end
            end)
        end
        if playerCardFlipTime > 0 or opponentCardFlipTime > 0 then
            CoYield(math.max(playerCardFlipTime, opponentCardFlipTime))
        end
    
    ------------------------------------------------- 2:混乱 | 6:秩序
    elseif effectViewData.ruleType == GameRuleEffects.ORDER_CHAOS or effectViewData.ruleType == GameRuleEffects.ORDER_INDEX then
        local operatorPlayOrder = checkTable(effectViewData.operatorPlayOrder)
        local opponentPlayOrder = checkTable(effectViewData.opponentPlayOrder)
        if #operatorPlayOrder == 0 or #opponentPlayOrder == 0 then
            return true
        end
        local playOrderRuleAnimTime = 0
        for orderIndex = 1, #operatorPlayOrder do
            local operatorCardIndex = operatorPlayOrder[orderIndex]
            local opponentCardIndex = opponentPlayOrder[orderIndex]
            local operatorCardNode  = playerCardNodeMap[operatorCardIndex]
            local opponentCardNode  = opponentCardNodeMap[opponentCardIndex]
            local operatorCardTime  = operatorCardNode:PlayRuleAnimByOrder(orderIndex, function()
                operatorCardNode:AdjustOrderToTop()
            end)
            local opponentCardTime  = opponentCardNode:PlayRuleAnimByOrder(orderIndex, function()
                opponentCardNode:AdjustOrderToTop()
            end)
            playOrderRuleAnimTime = math.max(playOrderRuleAnimTime, operatorCardTime, opponentCardTime)
        end
        CoYield(playOrderRuleAnimTime)
    
    ------------------------------------------------- 9:同盟初始强化 | 14:同盟初始弱化
    elseif effectViewData.ruleType == GameRuleEffects.TYPE_INC_FIXED or effectViewData.ruleType == GameRuleEffects.TYPE_DEC_FIXED then
        local initExtAttrType = checkInt(effectViewData.initExtAttrType)
        local initExtAttrNum  = checkInt(effectViewData.initExtAttrNum)
        if initExtAttrType == 0 or initExtAttrNum == 0 then
            return true
        end
        local attrAnimTime = 0
        for _, cardNodeMap in ipairs({playerCardNodeMap, opponentCardNodeMap}) do
            ---@param cardNode BattleCardGamePlayCardNode
            for cardIndex, cardNode in pairs(cardNodeMap) do
                local cardId = cardNode:GetCardNode():GetBattleCardId()
                local cardVo = BattleCardGameUtils.GetCardInfoVo(cardId)
                if initExtAttrType > 0 and cardVo.cardKind == initExtAttrType then
                    local extAttrMap = {
                        [tostring(BattleCardGameUtils.CardAttrIndex.TOP)]    = initExtAttrNum,
                        [tostring(BattleCardGameUtils.CardAttrIndex.LEFT)]   = initExtAttrNum,
                        [tostring(BattleCardGameUtils.CardAttrIndex.RIGHT)]  = initExtAttrNum,
                        [tostring(BattleCardGameUtils.CardAttrIndex.BOTTOM)] = initExtAttrNum,
                    }
                    cardNode:MergerExtAttrMap(extAttrMap)
                    attrAnimTime = cardNode:PlayAttrAnim()
                end
            end
        end
        CoYield(attrAnimTime)

    -------------------------------------------------
    else
        -- 走外面cell默认延迟
        return true
    end
end


-------------------------------------------------------------------------------
-- 棋盘
-------------------------------------------------------------------------------

--- 切换全部棋盘格 出牌提示
---@param isShow boolean
function BattleCardGamePlayDirector:SwitchAllBoardsPlayTips(isShow)
    local boardCardSiteMap = self.gamePlayViewer_.boardCardSiteMap_
    local boardCardNodeMap = self.gamePlayViewer_.boardCardNodeMap_
    for position, siteCell in pairs(boardCardSiteMap) do
        local isShowTips = boardCardNodeMap[position] == nil and isShow
        CfUtils.SetActive(siteCell:Find('ImgLight'), isShowTips)
        self:ShowBoardTipsAlwaysAnim(position)
    end
end


--- 显示指定棋盘格 出牌闪烁动画
---@param position integer
function BattleCardGamePlayDirector:ShowBoardTipsFlashAnim(position)
    local boardCardSiteMap = self.gamePlayViewer_.boardCardSiteMap_
    local boardSiteCell    = boardCardSiteMap[position]
    if boardSiteCell then
        CfUtils.PlayAnimation(boardSiteCell:Find('ImgLight'), AnimName.BOARD_LIGHT_FLASH)
    end
end


--- 显示指定棋盘格 出牌常亮动画
---@param position integer
function BattleCardGamePlayDirector:ShowBoardTipsAlwaysAnim(position)
    local boardCardSiteMap = self.gamePlayViewer_.boardCardSiteMap_
    local boardSiteCell    = boardCardSiteMap[position]
    if boardSiteCell then
        CfUtils.PlayAnimation(boardSiteCell:Find('ImgLight'), AnimName.BOARD_LIGHT_ALWAYS)
    end
end


-------------------------------------------------------------------------------
-- 卡牌
-------------------------------------------------------------------------------

--- 播放全部卡牌 高亮提示
---@param isOpponent boolean @ 是否为对手
function BattleCardGamePlayDirector:ShowAllCardsHightlightTips(isOpponent)
    local boardCardNodeMap    = self.gamePlayViewer_.boardCardNodeMap_
    local playerCardNodeMap   = self.gamePlayViewer_.playerCardNodeMap_
    local opponentCardNodeMap = self.gamePlayViewer_.opponentCardNodeMap_
    local allCardNodeMap      = isOpponent and opponentCardNodeMap or playerCardNodeMap

    for cardIndex, cardNode in pairs(allCardNodeMap) do
        cardNode:PlayHightlightTips()
    end

    for position, cardNode in pairs(boardCardNodeMap) do
        if isOpponent then
            if cardNode:GetCardNode():IsRedPlayMode() then
                cardNode:PlayHightlightTips()
            end
        else
            if cardNode:GetCardNode():IsBluePlayMode() then
                cardNode:PlayHightlightTips()
            end
        end
    end
end


--- 播放【卡牌还原回手牌】表现
---@param cardNode BattleCardGamePlayCardNode
---@param isPickUp boolean | nil
function BattleCardGamePlayDirector:PlayCardRevertToStandby(cardNode, isPickUp)
    self:StopShowPlaying()

    self.showPlayingCo_ = CoStart(function()
        self.isShowPlaying_ = true

        local playerCardSiteMap = self.gamePlayViewer_.playerCardSiteMap_
        local dropOutPlayTime   = cardNode:PlayStatusToRevert(playerCardSiteMap[cardNode:GetCardIndex()], isPickUp)
        CoYield(dropOutPlayTime)

        self.isShowPlaying_ = false
    end)
end


--- 同步【战牌游戏最新数据】表现状态
---@param viewData table
function BattleCardGamePlayDirector:SyncCardGamePlayData(viewData)
    local playerCardNodeMap   = self.gamePlayViewer_.playerCardNodeMap_
    local playerCardSiteMap   = self.gamePlayViewer_.playerCardSiteMap_
    local opponentCardNodeMap = self.gamePlayViewer_.opponentCardNodeMap_
    local opponentCardSiteMap = self.gamePlayViewer_.opponentCardSiteMap_
    local boardCardNodeMap    = self.gamePlayViewer_.boardCardNodeMap_
    local boardCardSiteMap    = self.gamePlayViewer_.boardCardSiteMap_
    local newCardExtAttrMap   = checkTable(viewData.newExtAttrMap)
    local recycleCardNodeList = {}

    -- 同步我方卡牌
    for cardIndex, cardNode in pairs(playerCardNodeMap) do
        if viewData.operatorPlayMap[cardIndex] then
            table.insert(recycleCardNodeList, cardNode)
            playerCardNodeMap[cardIndex] = nil
        else
            cardNode:MergerExtAttrMap(newCardExtAttrMap)
            cardNode:MoveToSiteNode(playerCardSiteMap[cardIndex])
            cardNode:StatusToStandby()
        end
    end

    -- 同步对方卡牌
    for cardIndex, cardNode in pairs(opponentCardNodeMap) do
        if viewData.opponentPlayMap[cardIndex] then
            table.insert(recycleCardNodeList, cardNode)
            opponentCardNodeMap[cardIndex] = nil
        else
            cardNode:MergerExtAttrMap(newCardExtAttrMap)
            cardNode:MoveToSiteNode(opponentCardSiteMap[cardIndex])
            cardNode:StatusToStandby()
        end
    end

    -- 同步桌面卡牌
    for position, boardData in pairs(checkTable(viewData.newBoardsData)) do
        if not boardCardNodeMap[position] then
            boardCardNodeMap[position] = table.remove(recycleCardNodeList)
        end
        local boardCardNode = boardCardNodeMap[position]
        boardCardNode:MoveToSiteNode(boardCardSiteMap[position])
        boardCardNode:StatusToBoard()
        if boardData.isOpponent then
            boardCardNode:GetCardNode():SetRedPlayMode(true)
        else
            boardCardNode:GetCardNode():SetBluePlayMode(true)
        end
        boardCardNode:GetCardNode():SetBackState(false)
        boardCardNode:GetCardNode():SetShowPublicEye(false)
        boardCardNode:GetCardNode():SetBattleCardId(boardData.boardCardId)
        boardCardNode:GetCardNode():SetCustomAttrMap(boardData.cardAttrMap)
    end

    -- 同步最新分数
    local newOpponentScore = checkInt(viewData.newOpponentScore)
    local newOperatorScore = checkInt(viewData.newOperatorScore)
    CfUtils.FillText(self.gamePlayViewer_.RedScoreTxt, newOpponentScore)
    CfUtils.FillText(self.gamePlayViewer_.BlueScoreTxt, newOperatorScore)
end


--- 播放【卡牌落棋盘上】表现
---@param viewData table
---@param finishCb fun():void
function BattleCardGamePlayDirector:PlayCardDropOutToBoard(viewData, finishCb)
    self:StopShowPlaying()

    self.showPlayingCo_ = CoStart(function()
        self.isShowPlaying_ = true

        local playerCardNodeMap   = self.gamePlayViewer_.playerCardNodeMap_
        local playerCardSiteMap   = self.gamePlayViewer_.playerCardSiteMap_
        local opponentCardNodeMap = self.gamePlayViewer_.opponentCardNodeMap_
        local opponentCardSiteMap = self.gamePlayViewer_.opponentCardSiteMap_
        local boardCardNodeMap    = self.gamePlayViewer_.boardCardNodeMap_
        local boardCardSiteMap    = self.gamePlayViewer_.boardCardSiteMap_
        local newCardExtAttrMap   = checkTable(viewData.newExtAttrMap)

        local isOpponent    = checkBool(viewData.isOpponent)
        local operateIndex  = checkInt(viewData.operateCardIndex)
        local boardPosition = checkInt(viewData.operatePosition)
        local revertIndex   = checkInt(viewData.revertCardIndex)

        -- 如果自己有正在拖拽中的卡牌，并且不是当前需要打出的卡牌，则回退到手牌区
        local revertCardTime = 0
        if revertIndex > 0 and revertIndex ~= operateIndex then
            local revertCardNode = playerCardNodeMap[revertIndex]
            revertCardTime = revertCardNode:PlayStatusToRevert(playerCardSiteMap[revertIndex])
        end

        -- 控制操作中的卡牌节点
        ---@type BattleCardGamePlayCardNode
        local operateCardNode = isOpponent and opponentCardNodeMap[operateIndex] or playerCardNodeMap[operateIndex]

        -- order to top
        operateCardNode:AdjustOrderToTop()

        -- close public eye
        operateCardNode:GetCardNode():SetShowPublicEye(false)

        -- move to board
        -- 对手的卡，需要加入选中状态。
        -- 自己的卡，手上未操作任何卡牌，等到超时自动出牌的，需要加入选中状态。
        -- 自己的卡，手上未操作卡牌和真正需要打出的牌不一致，手上的卡牌回退，需要打出的卡牌需要加入选中状态。
        local isIncludeSelect = isOpponent or revertIndex == 0 or revertIndex ~= operateIndex
        local dropOutPlayTime = operateCardNode:PlayStatusToDropBoard(boardCardSiteMap[boardPosition], isIncludeSelect)
        CoYield(math.max(revertCardTime, dropOutPlayTime))

        -- 如果是对手出牌，并且不是明牌状态，则翻牌
        if isOpponent and operateCardNode:GetCardNode():IsBackState() then
            local flipTime = operateCardNode:PlayFlipAnim(function()
                operateCardNode:GetCardNode():SetBackState(false)
            end)
            CoYield(flipTime)
        end

        -- 清除手牌区的卡牌节点位置
        if isOpponent then
            opponentCardNodeMap[operateIndex] = nil
        else
            playerCardNodeMap[operateIndex] = nil
        end

        -- 下牌的棋盘格记录卡牌节点
        boardCardNodeMap[boardPosition] = operateCardNode


        -------------------------------------------------
        -- 一组一组逐步吃卡
        for _, swallowsMap in ipairs(checkTable(viewData.swallowsMapList)) do
            local swallowTime = 0
            for positionId, boardData in pairs(swallowsMap) do
                local aroundIdMap    = BattleCardGameUtils.GetBoardAroundIdMap(positionId)
                local ownerSwallows  = checkTable(boardData.swallows)
                local ownerCardNode  = boardCardNodeMap[positionId]
                local isOwnerRedMode = boardData.isOpponent
                if ownerCardNode then
                    swallowTime = ownerCardNode:PlayToEatAnim(isOwnerRedMode)
                end
                for _, swallowId in ipairs(ownerSwallows) do
                    local beEatenTime = 0
                    local swallowDir  = 0
                    if swallowId == aroundIdMap[BattleCardGameUtils.CardAttrIndex.TOP] then
                        swallowDir = BattleCardGameUtils.CardAttrIndex.TOP
                    elseif swallowId == aroundIdMap[BattleCardGameUtils.CardAttrIndex.BOTTOM] then
                        swallowDir = BattleCardGameUtils.CardAttrIndex.BOTTOM
                    elseif swallowId == aroundIdMap[BattleCardGameUtils.CardAttrIndex.LEFT] then
                        swallowDir = BattleCardGameUtils.CardAttrIndex.LEFT
                    elseif swallowId == aroundIdMap[BattleCardGameUtils.CardAttrIndex.RIGHT] then
                        swallowDir = BattleCardGameUtils.CardAttrIndex.RIGHT
                    end
                    local boardCardNode = boardCardNodeMap[swallowId]
                    if boardCardNode then
                        beEatenTime = boardCardNode:PlayBeEatenAnim(isOwnerRedMode, swallowDir, function()
                            if isOwnerRedMode then
                                boardCardNode:GetCardNode():SetRedPlayMode(true)
                            else
                                boardCardNode:GetCardNode():SetBluePlayMode(true)
                            end
                        end)
                    end
                    swallowTime = math.max(swallowTime, beEatenTime)
                end
            end
            CoYield(swallowTime)
        end

        -------------------------------------------------
        -- 遍历棋盘数据，兜底检测是否有漏更新的
        local fixFlipTime = 0
        for position, boardData in pairs(checkTable(viewData.newBoardsData)) do
            local boardCardNode = boardCardNodeMap[position]
            if boardCardNode then
                if boardData.isOpponent then
                    if not boardCardNode:GetCardNode():IsRedPlayMode() then
                        fixFlipTime = boardCardNode:PlayFlipAnim(function()
                            boardCardNode:GetCardNode():SetRedPlayMode(true)
                        end)
                    end
                else
                    if not boardCardNode:GetCardNode():IsBluePlayMode() then
                        fixFlipTime = boardCardNode:PlayFlipAnim(function()
                            boardCardNode:GetCardNode():SetBluePlayMode(true)
                        end)
                    end
                end
            end
        end
        if fixFlipTime > 0 then
            CoYield(fixFlipTime)
        end


        -------------------------------------------------
        -- 更新双方分数
        local oldOpponentScore = checkInt(viewData.oldOpponentScore)
        local OldOperatorScore = checkInt(viewData.OldOperatorScore)
        local newOpponentScore = checkInt(viewData.newOpponentScore)
        local newOperatorScore = checkInt(viewData.newOperatorScore)
        CfUtils.FillText(self.gamePlayViewer_.RedScoreTxt, newOpponentScore)
        CfUtils.FillText(self.gamePlayViewer_.BlueScoreTxt, newOperatorScore)

    
        -------------------------------------------------
        -- 全部翻拍结束后，刷新卡牌属性
        local attrChangedTime = 0

        -- 同步我方卡牌属性加成
        for cardIndex, cardNode in pairs(playerCardNodeMap) do
            if cardNode:MergerExtAttrMap(newCardExtAttrMap) then
                attrChangedTime = cardNode:PlayAttrAnim()
            end
        end

        -- 同步对方卡牌属性加成
        for cardIndex, cardNode in pairs(opponentCardNodeMap) do
            if cardNode:MergerExtAttrMap(newCardExtAttrMap) then
                attrChangedTime = cardNode:PlayAttrAnim()
            end
        end

        -- 同步棋盘数据属性加成
        for position, boardData in pairs(checkTable(viewData.newBoardsData)) do
            local boardCardNode = boardCardNodeMap[position]
            if boardCardNode then
                boardCardNode:GetCardNode():SetCustomAttrMap(boardData.cardAttrMap)
                if boardData.attrChange then
                    attrChangedTime = boardCardNode:PlayAttrAnim()
                end
            end
        end

        if attrChangedTime then
            CoYield(attrChangedTime)
        end


        -------------------------------------------------
        self.isShowPlaying_ = false

        if finishCb then
            finishCb()
        end
    end)
end


return BattleCardGamePlayDirector
