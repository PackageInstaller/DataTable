-------------------------------------------------------------------------------
-- 和风战牌 - 关卡信息界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-26 19:36:13
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerChooseDialog.prefab > name: ActivityJapanesePokerChooseDialog
---@class BattleCardGameQuestDialog
---@field Env                           	BattleCardGameQuestDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BgNode                        	UnityEngine.RectTransform               	@ 1    背景节点
---@field NpcDrawNode                   	Game.Native.Common.DrawingNode          	@ 2    NPC立绘节点
---@field NpcInfoNode                   	UnityEngine.RectTransform               	@ 3    NPC信息节点
---@field NpcNameTxt                    	UnityEngine.RectTransform               	@ 4    NPC名字文本
---@field NpcLinesTxt                   	UnityEngine.RectTransform               	@ 5    NPC台词文本
---@field RuleIconParent                	UnityEngine.RectTransform               	@ 6    规则图标父节点
---@field RuleIconCell                  	UnityEngine.RectTransform               	@ 7    规则图标子节点
---@field GoodsListLight                	UnityEngine.RectTransform               	@ 8    奖励道具列表
---@field DeckTabParent                 	UnityEngine.RectTransform               	@ 9    牌组页签父节点
---@field DeckTabCell                   	UnityEngine.RectTransform               	@ 10   牌组页签子节点
---@field GameStartBtn                  	UnityEngine.RectTransform               	@ 11   游戏开始按钮
---@field ConsumeInfoPop                	UnityEngine.RectTransform               	@ 12   消耗信息节点
---@field LeftTimesTxt                  	UnityEngine.RectTransform               	@ 13   剩余次数文本
---@field CardAddNode1                  	UnityEngine.RectTransform               	@ 14   牌组卡牌节点1
---@field CardAddNode2                  	UnityEngine.RectTransform               	@ 15   牌组卡牌节点2
---@field CardAddNode3                  	UnityEngine.RectTransform               	@ 16   牌组卡牌节点3
---@field CardAddNode4                  	UnityEngine.RectTransform               	@ 17   牌组卡牌节点4
---@field CardAddNode5                  	UnityEngine.RectTransform               	@ 18   牌组卡牌节点5
---@field BtnArrowRight                 	UnityEngine.RectTransform               	@ 19   指南按钮
local BattleCardGameQuestDialog = Class('BattleCardGameQuestDialog')


function BattleCardGameQuestDialog:__init()
    ---@type integer @ 当前关卡id
    self.npcQuestId_ = 0

    ---@type BattleCardGameNpcQuestVo
    self.npcQuestVo_ = nil

    ---@type BattleCardGameQuestDojo
    self.npcQuestDojo_ = nil

    ---@type BattleCardGameQuestDialog.DeckData[] @ 牌组数据列表
    self.deckDataList_ = {}

    ---@type UnityEngine.RectTransform[] @ 牌组页签子节点列表
    self.deckTabCells_ = {}

    ---@type UnityEngine.RectTransform[] @ 牌组卡牌子节点列表
    self.deckCardCells_ = {}

    ---@type boolean @ 是否从打牌主界面进入
    self.isFromEntry_ = true

    ---@type fun(isWin:boolean):void
    self.playResultCb_ = nil
end


function BattleCardGameQuestDialog:__delete()
    self.npcQuestId_    = nil
    self.npcQuestVo_    = nil
    self.npcQuestDojo_  = nil
    self.deckDataList_  = nil
    self.deckTabCells_  = nil
    self.deckCardCells_ = nil
    self.isFromEntry_   = nil
    self.playResultCb_  = nil
end


function BattleCardGameQuestDialog:Awake()
    SetButtonAction(self.GameStartBtn, Bind(self, self.OnClickGameStartButtonHandler_))
    SetButtonAction(self.BtnArrowRight, Bind(self, self.OnClickHandbookButtonHandler_))

    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [BattleCardGameUtils.EventsName.DECK_CARDS_CHANGE]  = Bind(self, self.OnDeckCardsChangeHandler_),
        [BattleCardGameUtils.EventsName.TCP_ENTER_TAKE]     = Bind(self, self.OnTcpEnterTakeHandler_),
        [BattleCardGameUtils.EventsName.TCP_MATCHED_NOTICE] = Bind(self, self.OnTcpMatchedNoticeHandler_),
        [BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE] = Bind(self, self.OnTcpOperateNoticeHandler_),
    })
end


function BattleCardGameQuestDialog:OnFocus(focus)
    if focus then
        local enterConsumeNum = checkInt(self:GetNpcQuestVo().costGoodsNum)
        if enterConsumeNum > 0 then
            CfUtils.RefreshTopGoods({ BattleCardGameUtils.GetHpGoodsId() })
        end
    end
end


function BattleCardGameQuestDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- init vars
        self.isFromEntry_  = checkBool(initParams.isFromEntry)
        self.npcQuestId_   = checkInt(initParams.npcId)
        self.npcQuestVo_   = BattleCardGameUtils.GetNpcQuestVo(self:GetNpcQuestId())
        self.playResultCb_ = initParams.resultCb

        local initViewFunc = function()
            self.npcQuestDojo_ = battleCardGameComp:GetHomeDojo().questDojoMap[self:GetNpcQuestId()]
            self:InitDeckData_()
            self:InitDeckTabList_()
            self:InitDeckCardList_()
            self:UpdateQuestInfo_()
    
            -- init state
            local defalutDeckIndex = 1
            local saveDeckIndexKey = string.fmt(BattleCardGameUtils.PlayerPrefsKey.QuestDeckIndex, {_questId_ = self:GetNpcQuestId()})
            local saveDeckIndexNum = checkInt(CfUtils.GetLocalData(saveDeckIndexKey))
            local recoverDeckIndex = checkInt(initParams.deckIndex_)
            if saveDeckIndexNum > 0 then
                -- 上一次挑战的所选牌组
                defalutDeckIndex = saveDeckIndexNum
            end
            if recoverDeckIndex > 0 then
                -- 刚刚编辑的所选牌组
                defalutDeckIndex = recoverDeckIndex
            end
            self:SetDeckIndex(defalutDeckIndex)
        end

        -- init views
        if self.isFromEntry_ then
            initViewFunc()
        else
            BattleCardGameUtils.BgNodePlayEnterAnim(self.BgNode)
            CfUtils.SetActive(self.RootNode, false)

            -- request home
            battleCardGameComp:SyncHomeData(function()
                CfUtils.SetActive(self.RootNode, true)
                initViewFunc()
            end)
        end
    end)
end


function BattleCardGameQuestDialog:OnFinalize()
    return CoWaitDo(function()
        CfUtils.DialogClose(Constants.UITypeIds.UIActivityJapanesePokerMatchDialog)

        -- save dialog cache
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        initParams.deckIndex_ = self:GetDeckIndex()

        CfUtils.EventsUndecorated(self.eventsDecorated_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameQuestDialog:GetNpcQuestId()
    return checkInt(self.npcQuestId_)
end


---@return BattleCardGameNpcQuestVo
function BattleCardGameQuestDialog:GetNpcQuestVo()
    return checkTable(self.npcQuestVo_)
end


---@return BattleCardGameQuestDojo
function BattleCardGameQuestDialog:GetNpcQuestDojo()
    return checkTable(self.npcQuestDojo_)
end


---@return BattleCardGameQuestDialog.DeckData[]
function BattleCardGameQuestDialog:GetDeckDataList()
    return checkTable(self.deckDataList_)
end


---@return integer
function BattleCardGameQuestDialog:GetDeckIndex()
    return checkInt(self.deckIndex_)
end
function BattleCardGameQuestDialog:SetDeckIndex(index)
    self.deckIndex_ = checkInt(index)
    self:UpdateDeckTabList_()
    self:UpdateDeckCardList_()
end


---@return boolean
function BattleCardGameQuestDialog:IsDeckCardFull()
    local deckData = checkTable(self:GetDeckDataList()[self:GetDeckIndex()])
    return #checkTable(deckData.cardList) >= BattleCardGameUtils.DeckCardCount
end


-------------------------------------------------
-- private

function BattleCardGameQuestDialog:InitDeckData_()
    self.deckDataList_ = {}
    for deckIndex, deckInfoVo in ipairs(BattleCardGameUtils.GetAllDeckInfoVo()) do
        ---@class BattleCardGameQuestDialog.DeckData
        ---@field deckIndex integer
        ---@field deckInfoVo BattleCardGameDeckInfoVo
        ---@field cardList integer[]
        local deckData = {
            deckIndex  = deckIndex,
            deckInfoVo = deckInfoVo,
            cardList   = battleCardGameComp:GetHomeDojo():GetDeckCards(deckIndex),
        }
        self.deckDataList_[deckIndex] = deckData
    end
end


function BattleCardGameQuestDialog:InitDeckTabList_()
    self.deckTabCells_ = {}
    local deckDataList = self:GetDeckDataList()
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.DeckTabParent, self.DeckTabCell, #deckDataList, function(luaIndex, childNode)
        childNode.name = 'DeckTabCell' .. luaIndex
        local deckData = checkTable(deckDataList[luaIndex])
        CfUtils.FillText(childNode:Find('TxtTitle'), tostring(luaIndex))
        SetButtonAction(childNode, Bind(self, self.OnClickDeckTabNodeHandler_, luaIndex))
        self.deckTabCells_[luaIndex] = childNode
    end)
end
function BattleCardGameQuestDialog:UpdateDeckTabList_()
    for deckIndex, deckTabCell in ipairs(self.deckTabCells_) do
        local isSelect = self:GetDeckIndex() == deckIndex
        CfUtils.SetActive(deckTabCell:Find('ImgSelect'), isSelect)
        CfUtils.SetUISwitchText(deckTabCell:Find('TxtTitle'), isSelect and 2 or 1)
    end
end


function BattleCardGameQuestDialog:InitDeckCardList_()
    self.deckCardCells_ = {}
    for cardIndex = 1, BattleCardGameUtils.DeckCardCount do
        ---@type UnityEngine.RectTransform
        local deckCardNode  = self[string.fmt('CardAddNode%1', cardIndex)]
        if isNotNull(deckCardNode) then
            CfUtils.FillText(deckCardNode:Find('ImgBg/ImgDeco/TxtNum'), cardIndex)
            SetButtonAction(deckCardNode:Find('ImgBg'), Bind(self, self.OnClickDeckCardNodeHandler_, cardIndex))
            SetButtonAction(deckCardNode:Find('Card/PokerCardNode'), Bind(self, self.OnClickDeckCardNodeHandler_, cardIndex))
            self.deckCardCells_[cardIndex] = deckCardNode
        end
    end
end
function BattleCardGameQuestDialog:UpdateDeckCardList_()
    local deckData = checkTable(self:GetDeckDataList()[self:GetDeckIndex()])
    for cardIndex, deckCardNode in ipairs(self.deckCardCells_) do
        local cardId  = checkInt(deckData.cardList[cardIndex])
        local hasCard = cardId > 0
        CfUtils.SetActive(deckCardNode:Find('Card'), hasCard)
        CfUtils.SetActive(deckCardNode:Find('ImgBg'), false)  -- 先关一下再打开，为了刷激活动画
        CfUtils.SetActive(deckCardNode:Find('ImgBg'), not hasCard)
        if hasCard then
            BattleCardGameUtils.UpcateBattleCardNode(deckCardNode:Find('Card/PokerCardNode'), cardId)
        end
    end
end


function BattleCardGameQuestDialog:UpdateQuestInfo_()
    local npcCardId = checkInt(self:GetNpcQuestVo().npcDrawId)
    local npcCardVo = npcCardId > 0 and CardConfMgr:GetInstance():GetCardByRefId(npcCardId) or nil

    -- update card draw
    if npcCardVo then
        self.NpcDrawNode:Execute(checkInt(npcCardVo.defaultSkin))
    end

    -- update name / lines
    CfUtils.FillText(self.NpcNameTxt, string.fmt('%1 %2', self:GetNpcQuestVo().npcTitle, self:GetNpcQuestVo().npcName))
    CfUtils.FillText(self.NpcLinesTxt, tostring(self:GetNpcQuestVo().npcLines))

    -- update rewards
    ---@type CommonGoodsListLight
    local rewardsList = CfUtils.GetLuaScr(self.GoodsListLight, Constants.UILuaTablePath.ComGoodsList2)
    if isNotNull(rewardsList) then
        rewardsList:FreshBaseUI(self:GetNpcQuestVo().rewards)
    end
    CfUtils.SetActive(self.RootNode:Find('content/Left/Title'), #self:GetNpcQuestVo().rewards > 0)

    -- update rules
    local ruleIdList = checkTable(self:GetNpcQuestVo().questRules)
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.RuleIconParent, self.RuleIconCell, #ruleIdList, function(luaIndex, childNode)
        childNode.name = 'RuleIconCell' .. luaIndex
        local ruleId   = checkInt(ruleIdList[luaIndex])
        local iconPath = BattleCardGameUtils.GetRuleIconPath(ruleId)
        CfUtils.FillImage(childNode:Find('ImgIcon'), iconPath)
        SetButtonAction(childNode, Bind(self, self.OnClickRuleIconNodeHandler_, luaIndex))
    end)


    -- update left times
    local leftRewardTimes = checkInt(self:GetNpcQuestDojo().leftRewardTimes)
    CfUtils.FillText(self.LeftTimesTxt, localize('剩余奖励次数：_num_', {_num_ = leftRewardTimes}))

    -- update consume info
    ---@type CommonBtnConsumePop
    local consumeInfoPop  = CfUtils.GetLuaScr(self.ConsumeInfoPop, Constants.UILuaTablePath.BtnConsumePop)
    local enterConsumeId  = checkInt(self:GetNpcQuestVo().costGoodsId)
    local enterConsumeNum = checkInt(self:GetNpcQuestVo().costGoodsNum)
    if isNotNull(consumeInfoPop) then
        consumeInfoPop:RefreshUI(enterConsumeId, enterConsumeNum)
        CfUtils.SetActive(self.ConsumeInfoPop, enterConsumeNum > 0)
        CfUtils.SetActive(self.LeftTimesTxt, enterConsumeNum > 0)
    end

    -- update enter button
    local ownedConsumeNum = GoodsUtils.GetThingNo(enterConsumeId)
    local isDisableEnter  = leftRewardTimes <= 0 or ownedConsumeNum < enterConsumeNum
    CfUtils.SetButtonStyle(self.GameStartBtn, isDisableEnter and 'B17' or 'B3')
end


-------------------------------------------------
-- handler

function BattleCardGameQuestDialog:OnClickRuleIconNodeHandler_(ruleIndex)
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerCradRulePopup, {questId = self:GetNpcQuestId()})
end


function BattleCardGameQuestDialog:OnClickDeckTabNodeHandler_(tabIndex)
    local deckData = checkTable(self:GetDeckDataList()[tabIndex])
    if self:GetDeckIndex() ~= tabIndex then
        self:SetDeckIndex(tabIndex)
    end
end


function BattleCardGameQuestDialog:OnClickDeckCardNodeHandler_(cardIndex)
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerEditDialog, {deckIndex = self:GetDeckIndex()})
end


function BattleCardGameQuestDialog:OnClickHandbookButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UiActivityJapanesePokerHandbook)
end


function BattleCardGameQuestDialog:OnClickGameStartButtonHandler_()
    local leftRewardTimes = checkInt(self:GetNpcQuestDojo().leftRewardTimes)
    local enterConsumeId  = checkInt(self:GetNpcQuestVo().costGoodsId)
    local enterConsumeNum = checkInt(self:GetNpcQuestVo().costGoodsNum)
    local ownedConsumeNum = GoodsUtils.GetThingNo(enterConsumeId)

    if leftRewardTimes <= 0 and not self:GetNpcQuestVo():IsTestQuest() then
        GameUtils.Toast(localize('奖励次数已用完'))
        return
    end

    if ownedConsumeNum < enterConsumeNum then
        local goodsName = GoodsConfMgr:GetInstance():GetGoodsNameById(enterConsumeId)
        GameUtils.Toast(localize('_name_不足', {_name_ = goodsName}))
        return
    end

    if not self:IsDeckCardFull() then
        GameUtils.Toast(localize('牌组需要填满，请先编辑牌组'))
        return
    end

    if string.isEmpty(battleCardGameComp:GetHomeDojo().socketHost) then
        GameUtils.Toast(localize('连接地址为空，无法连接'))
        return
    end

    -- 是否阅读过游戏指南
    local isReadHandbook = checkInt(CfUtils.GetLocalData(BattleCardGameUtils.PlayerPrefsKey.GamePlayHandbook)) == 1
    if not isReadHandbook then
        CfUtils.DialogOpen(Constants.UITypeIds.UiActivityJapanesePokerHandbook, {closeCb = function()
            self:OnClickGameStartButtonHandler_()
        end})
        return
    end

    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerMatchDialog, {connectedCb = function()
        -- 清空牌局数据
        battleCardGameComp:GetPlayDojo():Cleanup()

        -- 连接成功：发送 9001 NPC进入
        local PacketDefines = BattleCardGameUtils.PacketDefines
        local requestData   = {deckId = self:GetDeckIndex(), npcId = self:GetNpcQuestId()}
        local socketClient  = battleCardGameComp:GetClient()
        socketClient:SendPacket(PacketDefines.ENTER_SEND.PacketId, requestData)
    end})
end


function BattleCardGameQuestDialog:OnDeckCardsChangeHandler_(eventData)
    local deckIndex = checkInt(eventData.deckId)
    local deckData  = checkTable(self:GetDeckDataList()[deckIndex])

    -- update data cache
    deckData.cardList = battleCardGameComp:GetHomeDojo():GetDeckCards(deckIndex)

    -- update deck cards
    if self:GetDeckIndex() == deckIndex then
        self:UpdateDeckCardList_()
    end
end


--- TCP收到 9002
function BattleCardGameQuestDialog:OnTcpEnterTakeHandler_(response)
    local resultCode = checkInt(response.result)
    if resultCode == 0 then
        local playDojo = battleCardGameComp:GetPlayDojo()

        -- save key values
        playDojo.roomId     = checkInt(response.roomNo)
        playDojo.npcQuestId = self:GetNpcQuestId()
    
        -- save select deck
        local saveDeckIndexKey = string.fmt(BattleCardGameUtils.PlayerPrefsKey.QuestDeckIndex, {_questId_ = self:GetNpcQuestId()})
        CfUtils.WriteLocalData(saveDeckIndexKey, self:GetDeckIndex())

    else
        -- 关闭加载界面
        CfUtils.DialogClose(Constants.UITypeIds.UIActivityJapanesePokerMatchDialog)

        GameUtils.Toast(localize('匹配遇到意外：_text_', {_text_ = tostring(response.msg)}))
    end
end


--- TCP收到 9006
function BattleCardGameQuestDialog:OnTcpMatchedNoticeHandler_(response)
    local playDojo = battleCardGameComp:GetPlayDojo()
    if playDojo.roomId ~= checkInt(response.roomNo) then
        return
    end

    local deckCards     = battleCardGameComp:GetHomeDojo():GetDeckCards(self:GetDeckIndex())
    local npcQuestVo    = BattleCardGameUtils.GetNpcQuestVo(self:GetNpcQuestId())
    local playerDojo    = GameUtils.GetPlayerDojo()
    local operatorDojo  = playDojo.operatorDojo
    local opponentDojo  = playDojo.opponentDojo
    local firstPlayerId = checkInt(response.firstHandMemberUuid)
    local opponentCards = {}

    for cardIndex, cardId in ipairs(checkTable(response.opponentBattleCards)) do
        opponentCards[cardIndex] = checkInt(cardId)
    end
    
    -- operator playr
    operatorDojo.playerId   = GameUtils.GetPlayerId2()
    operatorDojo.playerName = GameUtils.GetPlayerName()
    operatorDojo.avatarId   = checkInt(playerDojo.playerAvatar)
    operatorDojo.frameId    = checkInt(playerDojo.playerAvatarFrame)
    operatorDojo.handCards  = clone(deckCards)
    
    -- opponent playr
    opponentDojo.playerId   = checkInt(response.opponentUuid)
    opponentDojo.playerName = tostring(response.opponentName)
    opponentDojo.avatarId   = checkInt(response.opponentAvatar)
    opponentDojo.frameId    = checkInt(response.opponentAvatarFrame)
    opponentDojo.handCards  = opponentCards
    -- 如果是npc关卡，则对手名字读表（因为客户端可以热切语言，而长连接也没有通知当前客户端使用的语言）
    if self:GetNpcQuestId() > 0 then
        opponentDojo.playerName = npcQuestVo.npcName
    end

    -- init battleModel
    playDojo.ruleIdList      = checkTable(npcQuestVo.questRules)
    playDojo.initRuleEffects = checkTable(response.initialRuleEffects)
    playDojo:SwitchRoundInfo(BattleCardGameUtils.PlayDefines.ROUND_SECONDS, firstPlayerId)
    playDojo:ParseGameRules()

    -- 关闭加载界面
    CfUtils.DialogClose(Constants.UITypeIds.UIActivityJapanesePokerMatchDialog)

    -- 一定要先赋值出来，下面在自身关闭后，再使用时self已经不存在了
    local npcQuestId   = self:GetNpcQuestId()
    local isFromEntry  = self.isFromEntry_
    local myDialogId   = self.controller.Argument.id
    local playResultCb = self.playResultCb_
    CfUtils.StartCoroutineWithBlocker(function()
        
        -- 打开打牌界面
        CoYield(CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerPlayerBattleDialog, {
            ---@param isWin boolean
            playResultCb = function(isWin)
                if isWin then
                    local npcQuestDojo = battleCardGameComp:GetHomeDojo().questDojoMap[npcQuestId]
                    npcQuestDojo.leftRewardTimes = npcQuestDojo.leftRewardTimes - 1
                end
                if playResultCb then
                    playResultCb(isWin)
                end
            end,
        }, { UIArgs(myDialogId) }))

        -- 副本模式进入的打牌，打牌结束后回到副本，所以本关卡详情界面就先从堆栈中关掉
        if not isFromEntry then
            CfUtils.DialogRecordRemove(myDialogId)
        end
    end)
end


--- TCP收到 9010 系统出牌
function BattleCardGameQuestDialog:OnTcpOperateNoticeHandler_(response)
    local playDojo = battleCardGameComp:GetPlayDojo()
    if playDojo.roomId ~= checkInt(response.roomNo) then
        return
    end

    -- 如果先手是NPC，则会出现收到 9006 后后，直接出牌
    -- 此时可能游戏界面还未打开，所以这边需要代接收一下
    table.insert(playDojo.eventResults, {
        name = BattleCardGameUtils.EventsName.TCP_OPERATE_NOTICE,
        data = response,
        time = os.time(),
    })
end


return BattleCardGameQuestDialog
