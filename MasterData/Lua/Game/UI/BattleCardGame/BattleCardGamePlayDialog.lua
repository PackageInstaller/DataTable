-------------------------------------------------------------------------------
-- 和风战牌 - 战牌界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-09-05 11:05:34
-------------------------------------------------------------------------------

local GamePlayDirector    = import('Game.UI.BattleCardGame.BattleCardGamePlayDirector')
local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/ActivityJapanesePokerPlayerBattleDialog.prefab > name: ActivityJapanesePokerPlayerBattleDialog
---@class BattleCardGamePlayDialog
---@field Env                           	BattleCardGamePlayDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BgNoed                        	UnityEngine.RectTransform               	@ 1    背景节点
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field RuleTipsNode                  	UnityEngine.RectTransform               	@ 3    规则提示 根节点
---@field RuleTipsIconParent            	UnityEngine.RectTransform               	@ 4    规则提示 图标父节点
---@field RuleTipsIconNode              	UnityEngine.RectTransform               	@ 5    规则提示 图标子节点
---@field BattleRuleParent              	UnityEngine.RectTransform               	@ 6    开场规则 图标父节点
---@field BattleRuleCell                	UnityEngine.RectTransform               	@ 7    开场规则 图标子节点
---@field BoardCardParent               	UnityEngine.RectTransform               	@ 8    棋盘格子 卡牌父节点
---@field BoardCardNode                 	UnityEngine.RectTransform               	@ 9    棋盘格子 卡牌子节点
---@field RedNameTxt                    	UnityEngine.RectTransform               	@ 10   红方-名字文本
---@field RedScoreTxt                   	UnityEngine.RectTransform               	@ 11   红方 分数文本
---@field RedScoreNode                  	UnityEngine.RectTransform               	@ 12   红方 分数节点
---@field RedHeadNode                   	UnityEngine.RectTransform               	@ 13   红方 头像节点
---@field RedTimeRoot                   	UnityEngine.RectTransform               	@ 14   红方 时间根节点
---@field RedTimeTxt                    	UnityEngine.RectTransform               	@ 15   红方 时间文本
---@field RedTimeSlider                 	UnityEngine.RectTransform               	@ 16   红方 时间进度条
---@field RedCradRoot                   	UnityEngine.RectTransform               	@ 17   红方 卡牌根节点
---@field BlueNameTxt                   	UnityEngine.RectTransform               	@ 18   蓝方-名字文本
---@field BlueScoreTxt                  	UnityEngine.RectTransform               	@ 19   蓝方 分数文本
---@field BlueScoreNode                 	UnityEngine.RectTransform               	@ 20   蓝方 分数节点
---@field BlueHeadNode                  	UnityEngine.RectTransform               	@ 21   蓝方 头像节点
---@field BlueTimeRoot                  	UnityEngine.RectTransform               	@ 22   蓝方 时间根节点
---@field BlueTimeTxt                   	UnityEngine.RectTransform               	@ 23   蓝方 时间文本
---@field BlueTimeSlider                	UnityEngine.RectTransform               	@ 24   蓝方 时间进度条
---@field BlueCradRoot                  	UnityEngine.RectTransform               	@ 25   蓝方 卡牌根节点
---@field BattleCardsRoot               	UnityEngine.RectTransform               	@ 26   战牌-根节点
---@field BattleCardsNode               	UnityEngine.RectTransform               	@ 27   战牌-子节点
local BattleCardGamePlayDialog = Class('BattleCardGamePlayDialog')


function BattleCardGamePlayDialog:__init()
    ---@type boolean @ 是否允许操作
    self.isControllable_ = false

    ---@type boolean @ 是否显示开场动画显示完毕
    self.isOpeningShowed_ = false

    ---@type UnityEngine.RectTransform[] @ 提示规则节点列表
    self.tipsRuleNodeList_ = {}

    ---@type table<integer, BattleCardGamePlayCardNode> @ 玩家的卡牌节点map（key: 手牌位置索引，value: 卡牌节点）
    self.playerCardNodeMap_ = {}

    ---@type table<integer, UnityEngine.RectTransform> @ 玩家的卡牌位置map（key: 手牌位置索引，value: 位置节点）
    self.playerCardSiteMap_ = {}
    
    ---@type table<integer, BattleCardGamePlayCardNode> @ 对手的卡牌节点map（key: 手牌位置索引，value: 卡牌节点）
    self.opponentCardNodeMap_ = {}
    
    ---@type table<integer, UnityEngine.RectTransform> @ 对手的卡牌位置map（key: 手牌位置索引，value: 位置节点）
    self.opponentCardSiteMap_ = {}

    ---@type table<integer, BattleCardGamePlayCardNode> @ 棋盘的卡牌节点map（key: 棋盘格子索引，value: 卡牌节点）
    self.boardCardNodeMap_ = {}

    ---@type table<integer, UnityEngine.RectTransform> @ 棋盘的卡牌位置map（key: 棋盘格子索引，value: 位置节点）
    self.boardCardSiteMap_ = {}

    ---@type BattleCardGamePlayCardNode @ 当前操作的卡牌节点
    self.operateCardNode_ = nil

    ---@type BattleCardGameSocketClient @ 长连接控制器
    self.socketClient_ = battleCardGameComp:GetClient()

    ---@type BattleCardGamePlayDojo @ 战牌游戏数据
    self.gamePlayDojo_ = battleCardGameComp:GetPlayDojo()

    ---@type BattleCardGameRuleDojo @ 游戏规则数据
    self.gameRuleDojo_ = self.gamePlayDojo_.gameRuleDojo

    ---@type BattleCardGamePlayDirector @ 演出控制器
    self.gamePlayDirector_ = GamePlayDirector.New(self)

    ---@type fun(isWin:boolean):void @ 游戏结果回调
    self.playResultCb_ = nil
end


function BattleCardGamePlayDialog:__delete()
    self.isControllable_      = nil
    self.tipsRuleNodeList_    = nil
    self.playerCardNodeMap_   = nil
    self.playerCardSiteMap_   = nil
    self.opponentCardNodeMap_ = nil
    self.opponentCardSiteMap_ = nil
    self.boardCardNodeMap_    = nil
    self.boardCardSiteMap_    = nil
    self.operateCardNode_     = nil
    self.socketClient_        = nil
    self.gamePlayDojo_        = nil
    self.gameRuleDojo_        = nil
    self.gamePlayDirector_    = nil
    self.playResultCb_        = nil
end


function BattleCardGamePlayDialog:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickQuitButtonHandler_))
    SetButtonAction(self.RuleTipsNode, Bind(self, self.OnClickRuleTipsNodeHandler_))
    SetButtonAction(self.RedScoreNode, Bind(self, self.OnClickRedScoreNodeHandler_))
    SetButtonAction(self.BlueScoreNode, Bind(self, self.OnClickBlueScoreNodeHandler_))

    -- 手动创建卡牌节点
    ---@type BattleCardGamePlayCardNode[]
    local battleCardNodes = {}
    local battleCardCount = BattleCardGameUtils.DeckCardCount * 2
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.BattleCardsRoot, self.BattleCardsNode, battleCardCount, function(luaIndex, childNode)
        childNode.name = 'ActivityJapanesePokerCardNode_'..luaIndex
        local cardNode = CfUtils.GetLuaScr(childNode, BattleCardGameUtils.LuaSrcPath.PlayCardNode)
        battleCardNodes[luaIndex] = cardNode
        -- 因为会交换卡牌，所以全部卡牌都一样建立好侦听，初始化的时候再决定自己的卡牌开启拖动，对方的卡牌开启点击
        cardNode:SetClickCardCb(Bind(self, self.OnClickOpponentCardNodeHandler_))
        cardNode:SetDragBeginCb(Bind(self, self.OnDragBeginPlayerCardNodeHandler_))
        cardNode:SetDragMovedCb(Bind(self, self.OnDragMovedPlayerCardNodeHandler_))
        cardNode:SetDragEndedCb(Bind(self, self.OnDragEndedPlayerCardNodeHandler_))
    end)
    for cardIndex = 1, BattleCardGameUtils.DeckCardCount do
        self.playerCardNodeMap_[cardIndex] = battleCardNodes[cardIndex*2-1]
        self.opponentCardNodeMap_[cardIndex] = battleCardNodes[cardIndex*2]
    end

    -- 避免 BattleCardGameQuestDialog 和自己重复执行事件，移除其他人
    Events.DisconnectAll(BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE)

    self.mainLoopAction_  = CfUtils.BehaviourActionAdd(self.controller, Bind(self, self.OnMainUpdateBehaviourHandler_))
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [BattleCardGameUtils.EventsName.SOCKET_CONNECT]     = Bind(self, self.OnSocketConnectHandler_),
        [BattleCardGameUtils.EventsName.SOCKET_TIMEOUT]     = Bind(self, self.OnSocketTimeoutHandler_),
        [BattleCardGameUtils.EventsName.SOCKET_STOPPED]     = Bind(self, self.OnSocketStoppedHandler_),
        [BattleCardGameUtils.EventsName.TCP_SYNC_TAKE]      = Bind(self, self.OnTcpSyncTakeHandler_),
        [BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE] = Bind(self, self.OnTcpOperateNoticeHandler_),
        [BattleCardGameUtils.EventsName.TCP_RESULT_NOTICE]  = Bind(self, self.OnTcpResultNoticeHandler_),
        [BattleCardGameUtils.EventsName.TCP_ABANDON_TAKE]   = Bind(self, self.OnTcpAbandonTakeHandler_),
        [BattleCardGameUtils.EventsName.TCP_OPERATE_ERROR]  = Bind(self, self.OnTcpOperateErrorHandler_),
    })
end


function BattleCardGamePlayDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        self.playResultCb_ = initParams.playResultCb

        -- init views
        self:InitalRulesView_()
        self:InitialPlayerView_()
        self:InitialBoardsView_()

        -- 播放开场表现
        self.isControllable_ = true
        self.gamePlayDirector_:PlayOpeningShow(self.gameRuleDojo_.initEffectViewDatas, function()
            self.isOpeningShowed_ = true

            -- 更新交换效果的卡牌数据
            local swapOperatorIndex = self.gamePlayDojo_.operatorDojo.swapIndex
            local swapOpponentIndex = self.gamePlayDojo_.opponentDojo.swapIndex
            if swapOperatorIndex > 0 and swapOpponentIndex > 0 then
                local swapOperatorCardId = self.gamePlayDojo_.operatorDojo.playCards[swapOperatorIndex]
                local swapOpponentCardId = self.gamePlayDojo_.opponentDojo.playCards[swapOpponentIndex]
                self.gamePlayDojo_.operatorDojo.playCards[swapOperatorIndex] = swapOpponentCardId
                self.gamePlayDojo_.opponentDojo.playCards[swapOpponentIndex] = swapOperatorCardId
            end

            -- 更新一下当前回合的目标剩余秒数，需要去掉开场表现的耗时。
            -- 剩下的当做本回合新的倒计时时间，不然就会发生显示倒计时已经是少了一截的效果，因为表现过程中也早走倒计时
            local roundPlayerId    = self.gamePlayDojo_.roundPlayerId
            local leftRoundSeconds = self.gamePlayDojo_:GetLeftRoundSeconds()
            self.gamePlayDojo_:SwitchRoundInfo(leftRoundSeconds, roundPlayerId)

            -- 显示回合倒计时
            self:SwitchRoundTimeView_()

            -- 检测是否有需要执行的队列
            self:CheckExecuteEventResults_()
        end)

        -- play bgm
        BattleCardGameUtils.PlayGameBgm()
    end)
end


function BattleCardGamePlayDialog:OnFinalize()
    return CoWaitDo(function()
        BattleCardGameUtils.RevertGameBgm()
        CfUtils.BehaviourActionDel(self.mainLoopAction_)
        CfUtils.EventsUndecorated(self.eventsDecorated_)
        if self.gamePlayDirector_ then
            self.gamePlayDirector_:Delete()
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- public

function BattleCardGamePlayDialog:Close()
    if self.socketClient_ then
        self.socketClient_:SocketDestory()
    end
    CfUtils.DialogBack()
end


function BattleCardGamePlayDialog:CloseOthers()
    -- 关闭 是否退出确认框
    GameUtils.SecondConfirmClose()
    -- 关闭 规则介绍弹窗
    CfUtils.DialogClose(Constants.UITypeIds.UIActivityJapanesePokerCradRulePopup)
end


-------------------------------------------------
-- private

--- 初始化 规则列表信息
function BattleCardGamePlayDialog:InitalRulesView_()
    local ruleIdList = self.gamePlayDojo_.ruleIdList

    -- 底部规则图标
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.RuleTipsIconParent, self.RuleTipsIconNode, #ruleIdList, function(luaIndex, childNode)
        local ruleId = checkInt(ruleIdList[luaIndex])
        CfUtils.FillImage(childNode:Find('ImgIcon'), BattleCardGameUtils.GetRuleIconPath(ruleId))
    end)

    -- 弹窗规则列表
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.BattleRuleParent, self.BattleRuleCell, #ruleIdList, function(luaIndex, childNode)
        local ruleId = checkInt(ruleIdList[luaIndex])
        local ruleVo = BattleCardGameUtils.GetRuleInfoVo(ruleId)
        childNode.name = string.fmt('Cell%1', luaIndex)
        CfUtils.FillImage(childNode:Find('Root/ImgIcon'), BattleCardGameUtils.GetRuleIconPath(ruleId))
        CfUtils.FillText(childNode:Find('Root/TxtTitle'), ruleVo.ruleName)
        self.tipsRuleNodeList_[luaIndex] = childNode
    end)
end


--- 初始化 双方玩家信息
function BattleCardGamePlayDialog:InitialPlayerView_()
    local opponentDojo = self.gamePlayDojo_.opponentDojo
    CfUtils.FillText(self.RedNameTxt, opponentDojo.playerName)
    CfUtils.FillText(self.RedScoreTxt, self.gamePlayDojo_:GetOpponentScore())

    ---@type CommonPlayerHeadNode
    local operatorPlayerNode = CfUtils.GetLuaScr(self.RedHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    operatorPlayerNode:FreshAvatarFrame(opponentDojo.avatarId, opponentDojo.frameId)
    
    for cardIndex, battleCardId in ipairs(opponentDojo.handCards) do
        -- init site node
        local siteNode = self.RedCradRoot:Find(string.fmt('Card%1', cardIndex))
        self.opponentCardSiteMap_[cardIndex] = CfUtils.GetRectTransform(siteNode)
        -- init card node
        local cardNode = self.opponentCardNodeMap_[cardIndex]
        cardNode:GetCardNode():SetBattleCardId(battleCardId)
        cardNode:GetCardNode():SetCustomAttrMap(cardNode:GetCardNode():GetBaseAttrMap())
        cardNode:GetCardNode():SetRedPlayMode(true)
        cardNode:GetCardNode():SetFlipBackImg(true)
        cardNode:GetCardNode():SetBackState(true)
    end

    -------------------------------------------------

    local operatorDojo = self.gamePlayDojo_.operatorDojo
    CfUtils.FillText(self.BlueNameTxt, operatorDojo.playerName)
    CfUtils.FillText(self.BlueScoreTxt, self.gamePlayDojo_:GetOperatorScore())

    ---@type CommonPlayerHeadNode
    local opponentPlayerNode = CfUtils.GetLuaScr(self.BlueHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    opponentPlayerNode:FreshAvatarFrame(operatorDojo.avatarId, operatorDojo.frameId)

    for cardIndex, battleCardId in ipairs(operatorDojo.handCards) do
        -- init site node
        local siteNode = self.BlueCradRoot:Find(string.fmt('Card%1', cardIndex))
        self.playerCardSiteMap_[cardIndex] = CfUtils.GetRectTransform(siteNode)
        -- init card node
        local cardNode = self.playerCardNodeMap_[cardIndex]
        cardNode:GetCardNode():SetBattleCardId(battleCardId)
        cardNode:GetCardNode():SetCustomAttrMap(cardNode:GetCardNode():GetBaseAttrMap())
        cardNode:GetCardNode():SetBluePlayMode(true)
        cardNode:GetCardNode():SetFlipBackImg(false)
        cardNode:GetCardNode():SetBackState(false)
    end
end


--- 初始化 棋盘格信息
function BattleCardGamePlayDialog:InitialBoardsView_()
    local boardDojoList = self.gamePlayDojo_.boardDojoList
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.BoardCardParent, self.BoardCardNode, #boardDojoList, function(luaIndex, childNode)
        childNode.name = string.fmt('BoardCell%1', luaIndex)
        self.boardCardSiteMap_[luaIndex] = childNode
    end)
    self.gamePlayDirector_:SwitchAllBoardsPlayTips(false)
end


--- 切换 回合相关信息
function BattleCardGamePlayDialog:SwitchRoundTimeView_()
    local isOperatorRound = self.gamePlayDojo_:IsOperatorRound()
    CfUtils.SetActive(self.RedTimeRoot, not isOperatorRound)
    CfUtils.SetActive(self.BlueTimeRoot, isOperatorRound)
    CfUtils.LayoutForceRebuild(self.RedTimeRoot.parent)
    CfUtils.LayoutForceRebuild(self.BlueTimeRoot.parent)

    for cardIndex, cardNode in pairs(self.playerCardNodeMap_) do
        cardNode:MoveToSiteNode(self.playerCardSiteMap_[cardIndex])
    end
    for cardIndex, cardNode in pairs(self.opponentCardNodeMap_) do
        cardNode:MoveToSiteNode(self.opponentCardSiteMap_[cardIndex])
    end

    -- auto select handCard
    local playerDojo   = self.gamePlayDojo_.operatorDojo
    local opponentDojo = self.gamePlayDojo_.opponentDojo
    if isOperatorRound then
        if #playerDojo.playOrder > 0 then
            -- 找到当前应该打出的卡牌
            local forwardCardIndex = playerDojo:GetOrderCardIndex()
            if forwardCardIndex > 0 then
                for cardIndex, cardNode in pairs(self.playerCardNodeMap_) do
                    if cardIndex == forwardCardIndex then
                        cardNode:MarkCardGrayEffect(false)
                        self:SwitchOperateCardNode_(cardNode)
                    else
                        cardNode:MarkCardGrayEffect(true)
                    end
                end
            end
        end
    else
        if #playerDojo.playOrder > 0 then
            for cardIndex, cardNode in pairs(self.playerCardNodeMap_) do
                cardNode:MarkCardGrayEffect(false)
            end
            -- 触发网络同步时，可能当前手上已经灰色标记的卡被同步到棋盘上，那么最好全部清掉灰色标记
            for position, cardNode in pairs(self.boardCardNodeMap_) do
                cardNode:MarkCardGrayEffect(false)
            end
        end
    end

    self:UpdateRoundTimeView_()
end


--- 更新 回合相关信息
function BattleCardGamePlayDialog:UpdateRoundTimeView_()
    local isOperatorRound   = self.gamePlayDojo_:IsOperatorRound()
    local roundTimeTxt      = isOperatorRound and self.BlueTimeTxt or self.RedTimeTxt
    local roundTimeSlider   = isOperatorRound and self.BlueTimeSlider or self.RedTimeSlider
    local totalRoundSeconds = self.gamePlayDojo_:GetTotalRoundSeconds()
    local leftRoundSeconds  = self.gamePlayDojo_:GetLeftRoundSeconds()
    CfUtils.SetSliderPercent(roundTimeSlider, leftRoundSeconds / totalRoundSeconds)
    CfUtils.FillText(roundTimeTxt, leftRoundSeconds)
end


--- 检测执行结果消息队列
function BattleCardGamePlayDialog:CheckExecuteEventResults_()
    if #self.gamePlayDojo_.eventResults > 0 then
        local eventResult = table.remove(self.gamePlayDojo_.eventResults, 1)
        Events.Broadcast(eventResult.name, eventResult.data, eventResult.time)
    end
end


--- 切换 当前操作的卡牌节点
---@param operateCardNode BattleCardGamePlayCardNode | nil
---@param isNeedRevert boolean | nil @ 是否表现回退动画
---@param isMuteCancel boolean | nil @ 是否取消恢复动画
function BattleCardGamePlayDialog:SwitchOperateCardNode_(operateCardNode, isNeedRevert, isMuteCancel)
    if operateCardNode == self.operateCardNode_ then
        return
    end

    -- reset old operate card
    if self.operateCardNode_ then

        -- hide all board tips
        self.gamePlayDirector_:SwitchAllBoardsPlayTips(false)

        -- stop drag action
        self.operateCardNode_:BreakDragAction()
        
        -- close layer depth
        self.operateCardNode_:SetLayerDepth(false)

        if isNeedRevert then
            -- revert to standby
            self.gamePlayDirector_:PlayCardRevertToStandby(self.operateCardNode_)

        elseif not isMuteCancel then
            -- state to pickUp
            self.operateCardNode_:StatusToPutDown()
        end
    end

    -- save new operate card
    self.operateCardNode_ = operateCardNode

    if operateCardNode then
        -- show all board tips
        self.gamePlayDirector_:SwitchAllBoardsPlayTips(true)
        
        -- state to pickUp
        self.operateCardNode_:StatusToPickUp()

        -- order to top
        self.operateCardNode_:AdjustOrderToTop()

        -- open layer depth
        self.operateCardNode_:SetLayerDepth(true)
    end
end


-------------------------------------------------
-- handler

--- 点击 退出（认输）按钮
function BattleCardGamePlayDialog:OnClickQuitButtonHandler_()
    if not self.isControllable_ then return end  -- 是否禁止操作中

    if self.gamePlayDojo_.isGameOver then
        self:Close()
        return
    end

    local hasRewards = false
    local npcQuestId = self.gamePlayDojo_.npcQuestId
    if npcQuestId > 0 then
        local npcQuestVo = BattleCardGameUtils.GetNpcQuestVo(npcQuestId)
        hasRewards = npcQuestVo.costGoodsNum > 0
    end

    GameUtils.SecondConfirm(localize('确定要中途放弃比赛吗？'), function()
        -- send 9007 : abandon
        local PacketDefines = BattleCardGameUtils.PacketDefines
        self.socketClient_:SendPacket(PacketDefines.ABANDON_SEND.PacketId, {
            roomNo = self.gamePlayDojo_.roomId,
            uuid   = self.gamePlayDojo_.operatorDojo.playerId,
        })
    end, nil, hasRewards and localize('（认输不消耗奖励次数）') or nil)
end


--- 点击 规则提示节点
function BattleCardGamePlayDialog:OnClickRuleTipsNodeHandler_()
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerCradRulePopup, {ruleIdList = self.gamePlayDojo_.ruleIdList})
end


--- 点击 红方分数节点
function BattleCardGamePlayDialog:OnClickRedScoreNodeHandler_()
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    self.gamePlayDirector_:ShowAllCardsHightlightTips(true)
end


--- 点击 蓝方分数节点
function BattleCardGamePlayDialog:OnClickBlueScoreNodeHandler_()
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    self.gamePlayDirector_:ShowAllCardsHightlightTips(false)
end


--- 点击 对手卡牌节点
---@param sender BattleCardGamePlayCardNode
function BattleCardGamePlayDialog:OnClickOpponentCardNodeHandler_(sender)
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    -- 已经不在手牌区的卡牌，无需响应
    if not self.opponentCardNodeMap_[sender:GetCardIndex()] then
        return
    end

    local tipsText = localize('对手的_num_号卡牌', {_num_ = sender:GetCardIndex()}) 
    -- GameUtils.ShowCommonTipsBoardBase(sender.controller.transform, tipsText, true)
    GameUtils.Toast(tipsText)
end


--- 开始拖拽 自己卡牌节点
---@param sender BattleCardGamePlayCardNode
---@return boolean
function BattleCardGamePlayDialog:OnDragBeginPlayerCardNodeHandler_(sender)
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    -- 已经不在手牌区的卡牌，无需响应
    if not self.playerCardNodeMap_[sender:GetCardIndex()] then
        return false
    end

    -- 检测当前是否为自己的回合
    local playerDojo = self.gamePlayDojo_.operatorDojo
    if not self.gamePlayDojo_:IsOperatorRound() then
        GameUtils.Toast(localize('当前为对手回合，请稍安勿躁'))
        return false
    end

    local leftRoundSeconds = self.gamePlayDojo_:GetLeftRoundSeconds()
    if leftRoundSeconds <= 0 then
        GameUtils.Toast(localize('当前回合时间已结束'))
        return false
    end

    local clickCardIdx = sender:GetCardIndex()
    
    -- 检测卡牌是否已经被使用
    for _, usedIndex in ipairs(playerDojo.playCards) do
        if usedIndex == clickCardIdx then
            GameUtils.Toast(localize('无法操作已经打出的卡牌'))
            return false
        end
    end

    -- 是否开启了顺序出牌
    if #playerDojo.playOrder > 0 then
        -- 找到当前应该打出的卡牌
        local forwardCardIndex = playerDojo:GetOrderCardIndex()
        if forwardCardIndex <= 0 then
            GameUtils.Toast(localize('当前没有可操作的卡牌'))
            return false
        end

        if forwardCardIndex ~= clickCardIdx then
            if self.gameRuleDojo_.hasOrderRuleEffects then
                GameUtils.Toast(localize('在【秩序】规则下，请按照顺序出牌'))
                return false

            elseif self.gameRuleDojo_.hasChaosRuleEffects then
                GameUtils.Toast(localize('在【混乱】规则下，无法任意出牌'))
                return false
            end
        end
    end

    -- save operate card
    self:SwitchOperateCardNode_(sender)
    return true
end


--- 拖拽中 自己卡牌节点
---@param sender BattleCardGamePlayCardNode
---@param checkCollisionCb fun(target:UnityEngine.GameObject):boolean
function BattleCardGamePlayDialog:OnDragMovedPlayerCardNodeHandler_(sender, checkCollisionCb)
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作
 
    for position, boardDojo in ipairs(self.gamePlayDojo_.boardDojoList) do
        local boardSiteCell = self.boardCardSiteMap_[position]
        if boardDojo:IsEmpty() and boardSiteCell and checkCollisionCb(boardSiteCell) then
            self.gamePlayDirector_:ShowBoardTipsFlashAnim(position)
        else
            self.gamePlayDirector_:ShowBoardTipsAlwaysAnim(position)
        end
    end
end


--- 结束拖拽 自己卡牌节点
---@param sender BattleCardGamePlayCardNode
---@return boolean
function BattleCardGamePlayDialog:OnDragEndedPlayerCardNodeHandler_(sender, checkCollisionCb)
    if not self.isControllable_ then return end  -- 是否禁止操作中
    if self.gamePlayDirector_:IsShowPlaying() then return end  -- 动画演绎中，不能操作

    -- 如果一直拖拽着手牌，收到同步消息时会清除操作手牌，紧接着再移动鼠标会触发取消回调
    if self.operateCardNode_ == nil then
        return false
    end

    -- check collision board
    local collisionPosition = 0
    for position, boardDojo in ipairs(self.gamePlayDojo_.boardDojoList) do
        local boardSiteCell = self.boardCardSiteMap_[position]
        if boardDojo:IsEmpty() and boardSiteCell and checkCollisionCb(boardSiteCell) then
            collisionPosition = position
            break
        end
    end

    local isCollisionBoard = collisionPosition > 0
    if isCollisionBoard then
        -- send 9009 : operate card
        local PacketDefines = BattleCardGameUtils.PacketDefines
        self.socketClient_:SendPacket(PacketDefines.OPERATE_SEND.PacketId, {
            roomNo          = self.gamePlayDojo_.roomId,
            uuid            = self.gamePlayDojo_.operatorDojo.playerId,
            position        = collisionPosition,
            battleCardIndex = sender:GetCardIndex(),
        })
    else
        if self.gameRuleDojo_.hasOrderRuleEffects or self.gameRuleDojo_.hasChaosRuleEffects then
            -- revert to standby
            self.gamePlayDirector_:PlayCardRevertToStandby(self.operateCardNode_, true)
        else
            -- 清空当操作的手牌记录
            self:SwitchOperateCardNode_(nil, true)
        end
    end
    return isCollisionBoard
end


--- 主循环更新
function BattleCardGamePlayDialog:OnMainUpdateBehaviourHandler_()
    if self.gamePlayDojo_.isGameOver then return end
    self:UpdateRoundTimeView_()
end


--- 长连接重新连通
function BattleCardGamePlayDialog:OnSocketConnectHandler_()
    -- send 9003 : sync data
    local PacketDefines = BattleCardGameUtils.PacketDefines
    self.socketClient_:SendPacket(PacketDefines.SYNC_SEND.PacketId, {roomNo = self.gamePlayDojo_.roomId})
end


--- 长连接连接超时
function BattleCardGamePlayDialog:OnSocketTimeoutHandler_()
    self:CloseOthers()
    GameUtils.SecondConfirm(localize('建立连接超时，是否要重新尝试？'), 
        function()
            self.socketClient_:SocketReconnect()
        end,
        function()
            self:Close()
        end
    )
end


--- 长连接链接失效
function BattleCardGamePlayDialog:OnSocketStoppedHandler_()
    self:CloseOthers()
    GameUtils.SecondConfirm(localize('无法建立连接'), 
        function()
            self:Close()
        end,
        function()
            self:Close()
        end
    )
end


--- TCP收到 9016 认输确认
function BattleCardGamePlayDialog:OnTcpAbandonTakeHandler_(response)
    if self.gamePlayDojo_.roomId ~= checkInt(response.roomNo) then return end

    self.gamePlayDojo_.isGameOver = true
    self.gamePlayDojo_.resultType = BattleCardGameUtils.PlayResult.FAIL
    self:Close()
end


--- TCP收到 9018 出牌出错
function BattleCardGamePlayDialog:OnTcpOperateErrorHandler_(response)
    if self.gamePlayDojo_.roomId ~= checkInt(response.roomNo) then return end
    
    GameUtils.Toast(localize('出牌遇到意外：_text_', {_text_ = tostring(response.msg)}))

    -- 1 => 位置被占用了
    -- 2 => 战牌不存在
    -- 3 => 卡牌错误 (战牌已被使用)
    -- 4 => 出牌错误 (出牌顺序错误)
    -- 5 => 重复出牌
    local errorCode = checkInt(response.result)
    if errorCode ~= 4 then
        -- 如果遇到意外同步一下，避免卡死
        -- 比如切后台，再回到游戏，此时可能已经超时出牌过了
        self:OnSocketConnectHandler_()
    else
        if self.gameRuleDojo_.hasOrderRuleEffects or self.gameRuleDojo_.hasChaosRuleEffects then
            -- revert to standby
            self.gamePlayDirector_:PlayCardRevertToStandby(self.operateCardNode_, true)
        else
            -- 清空当操作的手牌记录
            self:SwitchOperateCardNode_(nil, true)
        end
    end
end


--- TCP收到 9008 重连成功
function BattleCardGamePlayDialog:OnTcpSyncTakeHandler_(response)
    if self.gamePlayDojo_.roomId ~= checkInt(response.roomNo) then return end

    -- clear event results
    self.gamePlayDojo_.eventResults = {}

    -- 开场动画表现必须完成之前，先暂存最后一次的同步结果
    if not self.isOpeningShowed_ then
        table.insert(self.gamePlayDojo_.eventResults, {
            name = BattleCardGameUtils.EventsName.TCP_SYNC_TAKE,
            data = response,
            time = os.time(),
        })
        return
    end

    -- 停止正在执行中的动画表现
    self.gamePlayDirector_:StopShowPlaying()

    -- 清空当操作的手牌记录
    self:SwitchOperateCardNode_(nil, false, true)

    -- 分析最新的游戏数据
    local resultCode = checkInt(response.result)
    if resultCode == 0 then
        local operatorDojo  = self.gamePlayDojo_.operatorDojo
        local opponentDojo  = self.gamePlayDojo_.opponentDojo
        local boardDojoList = self.gamePlayDojo_.boardDojoList

        -- 同步 双方玩家的出牌记录
        operatorDojo.playCards = {}
        opponentDojo.playCards = {}
        local operatorPlayMap  = {}
        local opponentPlayMap  = {}
        for _, cardIndex in pairs(checkTable(response.myPlayBattleCards)) do
            table.insert(operatorDojo.playCards, checkInt(cardIndex))
            operatorPlayMap[checkInt(cardIndex)] = true
        end
        for _, cardIndex in pairs(checkTable(response.opponentPlayBattleCards)) do
            table.insert(opponentDojo.playCards, checkInt(cardIndex))
            opponentPlayMap[checkInt(cardIndex)] = true
        end

        -- 同步 全部的棋盘数据
        local newBoardsData = {}
        for position, boardData in pairs(checkTable(response.map)) do
            local ownerId   = checkInt(boardData.ownerId)
            local cardId    = checkInt(boardData.battleCardId)
            local cardAttrs = checkTable(boardData.cardAttrs)
            local boardDojo = self.gamePlayDojo_.boardDojoList[checkInt(position)]
            if ownerId ~= 0 then
                boardDojo.ownerId = ownerId
                boardDojo.cardId  = cardId
                boardDojo.attrMap = cardAttrs
                newBoardsData[checkInt(position)] = {
                    isOpponent  = ownerId ~= operatorDojo.playerId,  -- 是否为对手
                    boardCardId = cardId,                            -- 战牌id
                    cardAttrMap = cardAttrs,                         -- 属性map（key：方向，value：属性值）
                }
            end
        end

        -- 计算最新的属性加成
        local newExtAttrMap = self.gameRuleDojo_:ParseCardPlayExtAttr()

        -- 同步 当前回合信息
        local nextPlayerId = checkInt(response.currentHandMemberUuid)
        local roundSeconds = checkInt(response.currentRoundLeftSeconds)
        self.gamePlayDojo_:SwitchRoundInfo(roundSeconds, nextPlayerId)

        -- 显示回合倒计时
        self:SwitchRoundTimeView_()

        -- sync playData
        local viewData = {
            operatorPlayMap  = operatorPlayMap,                       -- 玩家 打出的卡牌位置记录map（key：手牌位置）
            opponentPlayMap  = opponentPlayMap,                       -- 对手 打出的卡牌位置记录map（key：手牌位置）
            newOpponentScore = self.gamePlayDojo_:GetOpponentScore(), -- 玩家 最新的分数
            newOperatorScore = self.gamePlayDojo_:GetOperatorScore(), -- 对手 最新的分数
            newBoardsData    = newBoardsData,                         -- 最新的 棋盘数据map（key：位置，value：{isOpponent, boardCardId, cardAttrMap}）
            newExtAttrMap    = newExtAttrMap,                         -- 最新的 全局属性加成map（key：卡牌类型，value：加成值）
        }
        self.gamePlayDirector_:SyncCardGamePlayData(viewData)

        -- show tips
        GameUtils.Toast(localize('由于网络异常，战牌数据同步成功'))

    ------------------------------------------------- [on error]
    else
        local gameInvalidFunc = function()
            self.gamePlayDojo_.isGameOver = true
            self.gamePlayDojo_.resultType = BattleCardGameUtils.PlayResult.NONE
            self:Close()
        end

        if resultCode == -100 then
            GameUtils.SecondConfirm(localize('该局战牌已经结束'), gameInvalidFunc, gameInvalidFunc)

        elseif resultCode == -99 then
            GameUtils.SecondConfirm(localize('由于超时，您已不在房间'), gameInvalidFunc, gameInvalidFunc)

        else
            GameUtils.SecondConfirm(localize('战牌遇到了一点意外，原因：_text_', {_text_ = resultCode}), gameInvalidFunc, gameInvalidFunc)
        end
    end
end


--- TCP收到 9010 出牌通知
function BattleCardGamePlayDialog:OnTcpOperateNoticeHandler_(response, takeTime)
    if self.gamePlayDojo_.roomId ~= checkInt(response.roomNo) then return end

    -- 表现执行中，先暂存数据
    if not self.isControllable_ or self.gamePlayDirector_:IsShowPlaying() then
        table.insert(self.gamePlayDojo_.eventResults, {
            name = BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE,
            data = response,
            time = os.time(),
        })
        return
    end

    local operateUuid      = checkInt(response.uuid)
    local operateCardId    = checkInt(response.battleCardId)
    local operateCardIndex = checkInt(response.battleCardIndex)
    local operatePosition  = checkInt(response.position)

    ---@type BattleCardGamePlayCardNode
    local operateCardNode  = nil
    local operatorDojo     = self.gamePlayDojo_.operatorDojo
    local opponentDojo     = self.gamePlayDojo_.opponentDojo
    local oldOpponentScore = self.gamePlayDojo_:GetOpponentScore()
    local OldOperatorScore = self.gamePlayDojo_:GetOperatorScore()

    -- 计算下回合的玩家id
    -- 添加打出的卡牌记录
    local nextPlayerId = nil
    local responseTime = takeTime or os.time()
    if operateUuid == operatorDojo.playerId then
        nextPlayerId    = opponentDojo.playerId
        operateCardNode = self.playerCardNodeMap_[operateCardIndex]
        table.insert(operatorDojo.playCards, operateCardIndex)
        -- 立即关闭自己手牌的出牌顺序特效（虽然最后的 SwitchRoundTimeView 也会关闭，但是时机太晚了）
        if #operatorDojo.playOrder > 0 then
            for cardIndex, cardNode in pairs(self.playerCardNodeMap_) do
                cardNode:MarkCardGrayEffect(false)
            end
        end
    else
        nextPlayerId    = operatorDojo.playerId
        operateCardNode = self.opponentCardNodeMap_[operateCardIndex]
        table.insert(opponentDojo.playCards, operateCardIndex)
    end

    -- 更新全部棋盘格数据
    local newBoardsData = {}
    for position, boardData in pairs(checkTable(response.map)) do
        local boardDojo  = self.gamePlayDojo_.boardDojoList[checkInt(position)]
        local ownerId    = checkInt(boardData.ownerId)
        local cardId     = checkInt(boardData.battleCardId)
        local cardAttrs  = checkTable(boardData.cardAttrs)
        local swallows   = checkTable(boardData.swallows)
        local attrChange = false

        if ownerId ~= 0 then
            if boardDojo:IsEmpty() then
                local oldAttrMap = operateCardNode:GetCardNode():GetCustomAttrMap()
                attrChange = self.gameRuleDojo_:CheckAttrMapHasDiff(oldAttrMap, cardAttrs)
            else
                attrChange = self.gameRuleDojo_:CheckAttrMapHasDiff(boardDojo.attrMap, cardAttrs)
            end

            -- update boardDojo
            boardDojo.cardId  = cardId
            boardDojo.ownerId = ownerId
            boardDojo.attrMap = cardAttrs

            -- save boardData
            newBoardsData[checkInt(position)] = {
                isOpponent  = ownerId ~= operatorDojo.playerId,  -- 是否为对手
                boardCardId = cardId,                            -- 战牌id
                cardAttrMap = cardAttrs,                         -- 最新的属性map（key：方向，value：属性值）
                attrChange  = attrChange,                        -- 比之前的属性是否有变化
                swallows    = swallows,                          -- 吃掉的卡牌位置列表
            }
        end
    end

    -- 分析吃牌顺序
    local swallowsMapList  = {}
    local checkedBoardnMap = { [operatePosition] = true } -- 检测去重标记，防止出现同一位置的反复检测，导致死循环
    local checkSwallowList = { operatePosition }          -- 下一轮检测的位置列表
    while #checkSwallowList > 0 do
        local newCheckSwallowList = {}
        local positionSwallowsMap = {}
        for _, checkPositionId in ipairs(checkSwallowList) do
            local boardData = checkTable(newBoardsData[checkInt(checkPositionId)])
            local swallows  = checkTable(boardData.swallows)
            if #swallows > 0 then
                for _, swallowPositionId in ipairs(swallows) do
                    if not checkedBoardnMap[swallowPositionId] then
                        checkedBoardnMap[swallowPositionId] = true
                        table.insert(newCheckSwallowList, swallowPositionId)
                    end
                end
                positionSwallowsMap[checkPositionId] = boardData
            end
        end
        if next(positionSwallowsMap) ~= nil then
            table.insert(swallowsMapList, positionSwallowsMap)
        end
        checkSwallowList = newCheckSwallowList
    end

    -- 计算最新的属性加成
    local newExtAttrMap = self.gameRuleDojo_:ParseCardPlayExtAttr()

    -- 表现出牌到棋盘上
    local viewData = {
        isOpponent       = operateUuid ~= operatorDojo.playerId,  -- 是否为对手
        operateCardIndex = operateCardIndex,                      -- 操作的 手牌位置
        operatePosition  = operatePosition,                       -- 操作的 棋盘位置
        oldOpponentScore = oldOpponentScore,                      -- 玩家 之前的分数
        OldOperatorScore = OldOperatorScore,                      -- 对手 之前的分数
        newOpponentScore = self.gamePlayDojo_:GetOpponentScore(), -- 玩家 最新的分数
        newOperatorScore = self.gamePlayDojo_:GetOperatorScore(), -- 对手 最新的分数
        newBoardsData    = newBoardsData,                         -- 最新的 棋盘数据map（key：位置，value：{isOpponent, boardCardId, cardAttrMap}）
        newExtAttrMap    = newExtAttrMap,                         -- 最新的 全局属性加成map（key：卡牌类型，value：加成值）
        swallowsMapList  = swallowsMapList,                       -- 吃掉的卡牌位置map列表（key：牌的位置，value：吃掉的卡牌位置列表）
        revertCardIndex  = nil,                                   -- 当前拖拽中的手牌位置（有值就是需要放回到手牌区）
    }

    -- 如果手牌在拖拽中，等到了超时自动出牌，先中断拖动行为
    -- 并且打出的不是当前操作的手牌，则需要回退当前的手牌
    if self.operateCardNode_ then
        self.operateCardNode_:BreakDragAction()
        viewData.revertCardIndex = self.operateCardNode_:GetCardIndex()
    end

    -- 清空当操作的手牌记录
    self:SwitchOperateCardNode_(nil, false, true)

    self.gamePlayDirector_:PlayCardDropOutToBoard(viewData, function()

        -- 棋盘填充满就是结束了，就不再切换回合信息了
        if not self.gamePlayDojo_:IsFilledAllBoard() then
            -- 切换回合数据（回合时间 = 设定回合时间 - 表演耗时）
            local roundSeconds = BattleCardGameUtils.PlayDefines.ROUND_SECONDS - (os.time() - responseTime)
            self.gamePlayDojo_:SwitchRoundInfo(roundSeconds, nextPlayerId)
            self:SwitchRoundTimeView_()
        end

        -- 检测是否有事件队列执行
        self:CheckExecuteEventResults_()
    end)
end


--- TCP收到 9014 结果通知
function BattleCardGamePlayDialog:OnTcpResultNoticeHandler_(response, takeTime)
    if self.gamePlayDojo_.roomId ~= checkInt(response.roomNo) then return end

    -- 先断掉长连接
    self.socketClient_:SocketDestory()

    -- 表现执行中，先暂存数据
    if not self.isControllable_ or self.gamePlayDirector_:IsShowPlaying() then
        table.insert(self.gamePlayDojo_.eventResults, {
            name = BattleCardGameUtils.EventsName.TCP_RESULT_NOTICE,
            data = response,
            time = os.time(),
        })
        return
    end

    -- 同步战牌hp结构
    local hpData = response.hp
    if hpData then
        battleCardGameComp:GetHpDojo():Fill(hpData)
    end

    -- 记录结果数据
    self.gamePlayDojo_.isGameOver = true
    self.gamePlayDojo_.resultType = checkInt(response.result)

    if self.playResultCb_ then
        self.playResultCb_(self.gamePlayDojo_:IsPlayResultWin())
    end
    self:CloseOthers()

    -- draw rewards
    local allRewards = checkTable(response.rewards)
    local rewardData = checkTable(allRewards[response.rewardIndex])
    local rewardList = { rewardData }
    local hasRewards = checkInt(rewardData.goodsId) > 0
    if hasRewards then
        GoodsUtils.DrawRewards(rewardList, true)
    end

    -- 显示结果界面
    CfUtils.StartCoroutineWithBlocker(function()
        CoYield()  -- 预留一帧给【文本更新内容、节点更新坐标】等各种变动更新后，弹窗的截屏能截到最新的状态
        CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerBattleResult, {closeCb = function()
            if hasRewards then
                if GoodsUtils.GetIdType(rewardData.goodsId) == Constants.IDType.BattleCardGameCard then
                    -- 显示战牌奖励
                    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerBuyAnimation, {
                        rewards = rewardList, 
                        closeCb = function()
                            CfUtils.StartCoroutineWithBlocker(function()
                                while CfUtils.DialogGet(Constants.UITypeIds.UIActivityJapanesePokerBuyAnimation) do
                                    CoYield()
                                end
                                self:Close()
                            end)
                        end
                    })
                else
                    -- 显示通用奖励
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {
                        rewards = rewardList, 
                        closeCb = function()
                            CfUtils.StartCoroutineWithBlocker(function()
                                while CfUtils.DialogGet(Constants.UITypeIds.UICommonRewardPop) do
                                    CoYield()
                                end
                                self:Close()
                            end)
                        end
                    })
                end
            else
                -- 直接关闭
                CfUtils.StartCoroutineWithBlocker(function()
                    while CfUtils.DialogGet(Constants.UITypeIds.UIActivityJapanesePokerBattleResult) do
                        CoYield()
                    end
                    self:Close()
                end)
            end
        end})
    end)
end


return BattleCardGamePlayDialog
