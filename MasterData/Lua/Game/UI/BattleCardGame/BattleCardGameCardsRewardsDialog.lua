-------------------------------------------------------------------------------
-- 和风战牌 - 卡牌奖励弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-09 19:29:34
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local CardOnlyAnimName = 'ActivityJapanesePokerBuyAnimation_CardrEntry'
local CardPackAnimName = 'ActivityJapanesePokerBuyAnimation_SilverEntry'
local CardPackAnimNameMap = {
    [5050001] = CardPackAnimName,
    [5050002] = 'ActivityJapanesePokerBuyAnimation_GoldEntry',
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerBuyAnimation.prefab > name: ActivityJapanesePokerBuyAnimation
---@class BattleCardGameCardsRewardsDialog
---@field Env                           	BattleCardGameCardsRewardsDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimNode                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field EmptyArea                     	UnityEngine.RectTransform               	@ 2    空白区域
---@field CardOnlyRoot                  	UnityEngine.RectTransform               	@ 3    买卡牌-根节点
---@field CardOnlyNode                  	UnityEngine.RectTransform               	@ 4    买卡牌 卡牌节点1
---@field CardMultiRoot                 	UnityEngine.RectTransform               	@ 5    买卡包-根节点
---@field CardMultiNode1                	UnityEngine.RectTransform               	@ 6    买卡包 卡牌节点1
---@field CardMultiNode2                	UnityEngine.RectTransform               	@ 7    买卡包 卡牌节点2
---@field CardMultiNode3                	UnityEngine.RectTransform               	@ 8    买卡包 卡牌节点3
---@field CardMultiNode4                	UnityEngine.RectTransform               	@ 9    买卡包 卡牌节点4
---@field CardMultiNode5                	UnityEngine.RectTransform               	@ 10   买卡包 卡牌节点5
---@field ConfirrmBtn                     	UnityEngine.RectTransform               	@ 11   确认按钮
local BattleCardGameCardsRewardsDialog = Class('BattleCardGameCardsRewardsDialog')


function BattleCardGameCardsRewardsDialog:__init()
    ---@type integer @ 购买的商品id
    self.buyGoodsId_ = 0

    ---@type table[] @ 奖励数据列表
    self.rewardList_ = {}

    ---@type UnityEngine.RectTransform[] @ 卡牌节点列表
    self.cardNodeList_ = {}

    ---@type boolean @ 是否可操作
    self.isControllable_ = true

    ---@type UnityEngine.Coroutine @ 开场表演协程
    self.initShowAnimCo_ = nil

    ---@type fun():void @ 关闭回调
    self.closeCallback_ = nil
end


function BattleCardGameCardsRewardsDialog:__delete()
    self.buyGoodsId_     = nil
    self.rewardList_     = nil
    self.cardNodeList_   = nil
    self.isControllable_ = nil
    self.initShowAnimCo_ = nil
    self.closeCallback_  = nil
end


function BattleCardGameCardsRewardsDialog:Awake()
    SetButtonAction(self.EmptyArea, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ConfirrmBtn, Bind(self, self.OnClickCloseButtonHandler_))
end


function BattleCardGameCardsRewardsDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = CfUtils.DialogSafeParameters(self.controller)
        self.rewardList_    = checkTable(initParams.rewards)
        self.buyGoodsId_    = checkInt(initParams.goodsId)
        self.closeCallback_ = initParams.closeCb

        -- init view
        local isMuildRewards = self:IsMuildRewards()
        CfUtils.SetActive(self.CardMultiRoot, isMuildRewards)
        CfUtils.SetActive(self.CardOnlyRoot, not isMuildRewards)
        if isMuildRewards then
            for cardIndex = 1, 5 do
                table.insert(self.cardNodeList_, self['CardMultiNode' .. cardIndex])
            end
        else
            table.insert(self.cardNodeList_, self.CardOnlyNode)
        end
        self:UpdateCardNodeList_()

        -- play anim
        self:InitShowAnimStart_()
    end)
end


function BattleCardGameCardsRewardsDialog:OnFinalize()
    return CoWaitDo(function()
        self:InitShowAnimClean_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function BattleCardGameCardsRewardsDialog:GetRewardList()
    return checkTable(self.rewardList_)
end


---@return boolean
function BattleCardGameCardsRewardsDialog:IsMuildRewards()
    return #self:GetRewardList() > 1
end


-------------------------------------------------
-- private

function BattleCardGameCardsRewardsDialog:InitShowAnimClean_()
    if self.initShowAnimCo_ then
        CoStop(self.initShowAnimCo_)
        self.initShowAnimCo_ = nil
    end
end
function BattleCardGameCardsRewardsDialog:InitShowAnimStart_()
    local isMuildRewards = self:IsMuildRewards()
    local initAnimName   = self:IsMuildRewards() and CardPackAnimName or CardOnlyAnimName
    if isMuildRewards and CardPackAnimNameMap[self.buyGoodsId_] then
        initAnimName = CardPackAnimNameMap[self.buyGoodsId_]
    end

    local initAnimTime   = CfUtils.GetAnimationTime(self.AnimNode, initAnimName)
    self.isControllable_ = false
    self.initShowAnimCo_ = CoStart(function()
        CoYield(initAnimTime)
        self.isControllable_ = true
    end)

    CfUtils.PlayAnimation(self.AnimNode, initAnimName)
end


function BattleCardGameCardsRewardsDialog:UpdateCardNodeList_()
    for nodeIndex, cardNode in ipairs(self.cardNodeList_) do
        local goodsData = checkTable(self:GetRewardList()[nodeIndex])
        CfUtils.SetActive(cardNode:Find('ImgNew'), checkBool(goodsData.isNew))
        CfUtils.SetActive(cardNode:Find('ImgMask'), goodsData.convertGoods ~= nil)
        if goodsData.convertGoods then
            local convertGoodId  = checkInt(goodsData.convertGoods.goodsId)
            local convertGoodNum = checkInt(goodsData.convertGoods.num)
            CfUtils.FillText(cardNode:Find('ImgMask/NumRoot/TxtNum'), convertGoodNum)
            CfUtils.FillImage(cardNode:Find('ImgMask/NumRoot/TxtNum/ImgIcon'), GoodsUtils.GetGoodsIconById(convertGoodId))
        end
        BattleCardGameUtils.UpcateBattleCardNode(cardNode:Find('PokerCardNode'), goodsData.goodsId)
    end
end


-------------------------------------------------
-- handler

function BattleCardGameCardsRewardsDialog:OnClickCloseButtonHandler_()
    if not self.isControllable_ then return end

    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogClose(self.controller)
end


return BattleCardGameCardsRewardsDialog
