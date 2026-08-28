-------------------------------------------------------------------------------
-- 噩梦回响Pass卡 - 奖励界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-17 16:52:51
-------------------------------------------------------------------------------

local SDKService          = import('Game.Entry.SDKService')
local PassCardUtils       = import('Game.UI.FightReady.ChaoticRecallPassCard.ChaoticRecallPassCardUtils')
local PassCardHomeDojo    = import('Game.Dojo.ChaoticRecallPassCard.ContractRecallPassCardHomeDojo')
local serverDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()
local goodsConfMgr        = GoodsConfMgr:GetInstance()

local RewardListCellPath1 = 'Game.UI.FightReady.ChaoticRecallPassCard.UIDarkDreamPassContractManualPanelRewardNode'
local RewardListCellPath2 = 'Game.UI.FightReady.ChaoticRecallPassCard.UIDarkDreamPassContractManualPanelFinalNode'
local RewardListCellName1 = 'Cell1'
local RewardListCellName2 = 'Cell2'

local ROOT_ANIM_NAME = {
    SHOW = 'DarkDreamPassContractManual_Entry'
}

--- from: Assets/BundleResources/Prefabs/ResidentEvent/DarkDreamPassContractManual.prefab > name: DarkDreamPassContractManual
---@class UIDarkDreamPassContractManualPanel
---@field Env                           	UIDarkDreamPassContractManualPanel      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 0    动画根节点
---@field ItemsRootNode                 	UnityEngine.RectTransform               	@ 1    显示道具-根节点
---@field Item1GoodsNode                	UnityEngine.RectTransform               	@ 2    显示道具 道具1节点
---@field Item1GoodsIconImg             	UnityEngine.RectTransform               	@ 3    显示道具 道具1图标
---@field Item1GoodsNumTxt              	UnityEngine.RectTransform               	@ 4    显示道具 道具1数量
---@field Item2GoodsNode                	UnityEngine.RectTransform               	@ 5    显示道具 道具2节点
---@field Item2GoodsIconImg             	UnityEngine.RectTransform               	@ 6    显示道具 道具2图标
---@field Item2GoodsNumTxt              	UnityEngine.RectTransform               	@ 7    显示道具 道具2数量
---@field Item3GoodsNode                	UnityEngine.RectTransform               	@ 8    显示道具 道具3节点
---@field Item3GoodsIconImg             	UnityEngine.RectTransform               	@ 9    显示道具 道具3图标
---@field Item3GoodsNumTxt              	UnityEngine.RectTransform               	@ 10   显示道具 道具3数量
---@field RewardSloganTxt               	UnityEngine.RectTransform               	@ 11   奖励说明文本
---@field PassFreeNameTxt               	UnityEngine.RectTransform               	@ 12   免费Pass卡 名字文本
---@field PassPaidLockIcon              	UnityEngine.RectTransform               	@ 13   付费Pass卡 锁定图标
---@field PassPaidNameTxt               	UnityEngine.RectTransform               	@ 14   付费Pass卡 名字文本
---@field PassPaidIconBtn               	UnityEngine.RectTransform               	@ 15   付费Pass卡 图标按钮
---@field RewardsToRightBtn             	UnityEngine.RectTransform               	@ 16   奖励信息-置右按钮
---@field RewardsToLeftBtn              	UnityEngine.RectTransform               	@ 17   奖励信息-置左按钮
---@field RewardsGoodsList              	SuperScrollView.LoopListView2           	@ 18   奖励信息 道具列表
---@field PassLevelMaxTxt               	UnityEngine.RectTransform               	@ 19   等级信息 满级文本
---@field PassLevelNumTxt               	UnityEngine.RectTransform               	@ 20   等级信息 等级文本
---@field PassLevelExpTxt               	UnityEngine.RectTransform               	@ 21   等级信息 经验文本
---@field PassLevelBuyBtn               	Game.Native.Common.FontStyleButton      	@ 22   等级信息 购买等级按钮
---@field PassLevelExpSlider            	UnityEngine.UI.Slider                   	@ 23   等级信息 经验进度条
---@field PointEntryBtn                 	UnityEngine.RectTransform               	@ 24   积分点数-前往按钮
---@field PointConvertTxt               	UnityEngine.RectTransform               	@ 25   积分点数-转换说明
---@field PassCardUpgradeUIFX           	UnityEngine.RectTransform               	@ 26   购买节点 升级Pass特效
---@field PassCardBuyUIFX               	UnityEngine.RectTransform               	@ 27   购买节点 购买Pass特效
---@field PassCardHasNode               	UnityEngine.RectTransform               	@ 28   购买节点 已拥有节点
---@field PassCardPriceTxt              	UnityEngine.RectTransform               	@ 29   购买节点 价格文本
---@field PassCardPriceIcon             	UnityEngine.RectTransform               	@ 30   购买节点 价格图标
---@field PassCardBuyBtn                	UnityEngine.RectTransform               	@ 31   购买节点 购买按钮
---@field RewardsDrawAllRed             	UnityEngine.RectTransform               	@ 32   领取全部 红点
---@field RewardsDrawAllBtn             	Game.Native.Common.FontStyleButton      	@ 33   领取全部 按钮
---@field RewardsLeftTimeTxt            	UnityEngine.RectTransform               	@ 34   奖励信息 剩余时间文本
local UIDarkDreamPassContractManualPanel = Class('UIDarkDreamPassContractManualPanel')


function UIDarkDreamPassContractManualPanel:__init()
    ---@type ContractRecallPassCardHomeDojo
    self.passHomeDojo_ = nil

    ---@type integer @ 当前的排期id
    self.currentScheduleId_ = nil

    ---@type Engine.Modules.CDTimerModule @ 刷新倒计时的计时器
    self.scheduleRefreshTimer_ = nil

    ---@type UnityEngine.Coroutine @ 奖励列表项逐帧初始化协程
    self.coRewardsListInit_ = nil
    
    ---@type UnityEngine.Coroutine @ 禁用列表的滚动检测协程
    self.coDisableScrollCheck_ = nil

    ---@type table[] @ 奖励列表数据
    self.rewardsDataList_ = {}

    ---@type number @ 奖励列表节点宽度
    self.rewardListItemW_ = 0
    
    ---@type integer @ 奖励列表视图宽度
    self.rewardListVPortW_ = 0

    ---@type integer @ 奖励列表奖励总宽度
    self.rewardListTotalW_ = 0

    ---@type integer @ 最小可领取奖励位置
    self.canDrawIndexMin_ = 0

    ---@type integer @ 最大可领取奖励位置
    self.canDrawIndexMax_ = 0
    
    ---@type UnityEngine.RectTransform @ 奖励列表容器
    self.rewardListCTrans_ = nil
end


function UIDarkDreamPassContractManualPanel:__delete()
    self.passHomeDojo_         = nil
    self.currentScheduleId_    = nil
    self.scheduleRefreshTimer_ = nil
    self.rewardsDataList_      = nil
    self.rewardListItemW_      = nil
    self.rewardListCTrans_     = nil
    self.rewardListVPortW_     = nil
    self.rewardListTotalW_     = nil
    self.canDrawIndexMin_      = nil
    self.canDrawIndexMax_      = nil
    self.coDisableScrollCheck_ = nil
    self.coRewardsListInit_    = nil
end


function UIDarkDreamPassContractManualPanel:Awake()
    SetButtonAction(self.PassCardBuyBtn, Bind(self, self.OnClickBuyPassButtonHandler_))
    SetButtonAction(self.PassPaidIconBtn, Bind(self, self.OnClickBuyPassButtonHandler_))
    SetButtonAction(self.PassLevelBuyBtn, Bind(self, self.OnClickPassLevelBuyButtonHandler_))
    SetButtonAction(self.RewardsDrawAllBtn, Bind(self, self.OnClickRewardsDrawAllButtonHandler_))
    SetButtonAction(self.PointEntryBtn, Bind(self, self.OnClickPointEntryButtonButtonHandler_))
    -- 先隐藏道具白块
    CfUtils.SetActive(self.Item1GoodsIconImg, false)
    CfUtils.SetActive(self.Item2GoodsIconImg, false)
    CfUtils.SetActive(self.Item3GoodsIconImg, false)
end


function UIDarkDreamPassContractManualPanel:OnInit()
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PassCardUtils.EventName.PASS_CARD_EXP_CHANGE]  = Bind(self, self.OnPassExpChangeEventHandler_),
        [PassCardUtils.EventName.PASS_CARD_LOOP_TIMES]  = Bind(self, self.OnPassLoopTimesEventHandler_),
        [PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE] = Bind(self, self.OnPassTypeChangeEventHandler_),
        [Constants.EventNames.EVENT_SDK]                = Bind(self, self.OnEventSdkEventHandler_),
    })

    local rewardItemData  = self.RewardsGoodsList:GetItemPrefabConfData(RewardListCellName1)
    local rewardItemWidth = rewardItemData.mItemPrefab.transform.sizeDelta.x
    self.rewardListItemW_ = rewardItemWidth + rewardItemData.mPadding
    
    SetListViewAction(self.RewardsGoodsList, Bind(self, self.OnUpdateRewardsListCellHandler_), nil, {mItemDefaultWithPaddingSize = self.rewardListItemW_})
    self.RewardsGoodsList.ScrollRect.onValueChanged:AddListener(Bind(self, self.OnRewardsGoodsListScrollChangedHandler_))
    
    self.rewardListCTrans_ = self.RewardsGoodsList.ContainerTrans
    self.rewardListVPortW_ = self.RewardsGoodsList.ViewPortWidth
end


function UIDarkDreamPassContractManualPanel:Start()
    -- 入场动画有修改滚动列表尺寸的行为，所以这时候侦听列表滚动距离会无意义，要等动画做完了再开启滚动事件检测
    local showTime = CfUtils.GetAnimationTime(self.AnimRoot, ROOT_ANIM_NAME.SHOW)
    self.coDisableScrollCheck_ = CoStart(function()
        CoYield(showTime)
        self.coDisableScrollCheck_ = nil
    end)
end


function UIDarkDreamPassContractManualPanel:OnDestroy()
    self:ClearRefreshCountdown_()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    if self.RewardsGoodsList.ScrollRect then  -- InitListView 之后 ScrollRect 才会有值
        self.RewardsGoodsList.ScrollRect.onValueChanged:RemoveAllListeners()
    end
    if self.coRewardsListInit_ then
        CoStop(self.coRewardsListInit_)
        self.coRewardsListInit_ = nil
    end
    if self.coDisableScrollCheck_ then
        CoStop(self.coDisableScrollCheck_)
        self.coDisableScrollCheck_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return ContractRecallPassCardHomeDojo
function UIDarkDreamPassContractManualPanel:GetHomeDojo()
    return self.passHomeDojo_
end


---@return table[]
function UIDarkDreamPassContractManualPanel:GetRewardsDataList()
    return checkTable(self.rewardsDataList_)
end


-------------------------------------------------
-- public

---@param welfareDojo WelfareDojo
---@param listIndex integer
function UIDarkDreamPassContractManualPanel:Refresh(welfareDojo, listIndex)
    if self:GetHomeDojo() then
    else
        self.passHomeDojo_ = PassCardHomeDojo.New()
        self:SyncPassHomeData_(function()
            self:OnInit()
            self:OnDataRefresh(true)
        end)
    end
    CfUtils.RefreshTopGoodsNew()
end


function UIDarkDreamPassContractManualPanel:OnDataRefresh(isDelayList)
    -- update rewardsData
    self.rewardsDataList_ = {}
    for rewardIndex, rewardData in ipairs(self:GetHomeDojo().drawRewardList) do
        self.rewardsDataList_[rewardIndex] = rewardData
    end
    if #self.rewardsDataList_ > 0 then
        table.insert(self.rewardsDataList_, {isChest = true})
    end

    -- update levelMax
    self.rewardListTotalW_ = self:GetHomeDojo().passCardLevelMax * self.rewardListItemW_

    -- update others
    self:UpdateBaseShowInfo_()
    self:UpdatePassTypeState_()
    self:UpdatePassLevelInfo_()
    self:StartRefreshCountdown_()
    self:UpdateDrawRewardsRed_()
    self:CheckCanDrawIndex_()

    -- 优先定位 最靠前的可领取奖励位置
    local firstViewDrawIndex = 0
    for drawIndex, _ in ipairs(self:GetHomeDojo().drawRewardList) do
        if self:GetHomeDojo():HasCanDrawRewardsAt(drawIndex) then
            firstViewDrawIndex = drawIndex
            break
        end
    end
    -- 其次定位 当前等级的解锁位置
    if firstViewDrawIndex == 0 then
        firstViewDrawIndex = self:GetHomeDojo().passCardLevelNow
    end

    -- 刷新固定奖励信息
    if firstViewDrawIndex > 0 then
        local moveToListIndex = firstViewDrawIndex - 1
        self:CheckStageDrawIndex_(moveToListIndex * -self.rewardListItemW_)
    else
        self:CheckStageDrawIndex_(0)
    end
    
    local initRewardList = function()
        self:UpdateRewardList_()
        -- 滚动奖励列表到指定为止
        if firstViewDrawIndex > 0 then
            local moveToListIndex = firstViewDrawIndex - 1
            self.RewardsGoodsList:MovePanelToItemIndex(moveToListIndex)
        end
    end
    if isDelayList then
        -- 由于首次打开界面时，奖励列表内容过多，会出现一瞬间的阻塞，等列表初始化结束后，动画会表现出一下子跳过好几帧的顿挫感，所以首次打开做个列表的延迟初始化
        self.coRewardsListInit_ = CoStart(function()
            for initIndex = 1, math.ceil(self.rewardListVPortW_ / self.rewardListItemW_) do
                self.RewardsGoodsList:ExpandPool(RewardListCellName1)
                CoYield(0.02)
            end
            self.coRewardsListInit_ = nil
            initRewardList()
        end)
    else
        initRewardList()
    end
end


-------------------------------------------------
-- private

--- 请求最新 Pass卡主页数据
---@param callback fun():void
function UIDarkDreamPassContractManualPanel:SyncPassHomeData_(callback)
    GameUtils.Request(Interfaces.OverseaNightmarePassCardHome, {}, function(request, response)
        if checkInt(response.errCode) == 0 then

            -- update homeDojo
            local responseData = checkTable(response.data)
            self:GetHomeDojo():Fill(responseData)

            -- check update cache
            local oldScheduleId = self.currentScheduleId_
            local newScheduleId = self:GetHomeDojo().scheduleId
            if oldScheduleId ~= newScheduleId then

                -- update scheduleId
                self.currentScheduleId_ = newScheduleId

                -- rebuild cacheData
                self:GetHomeDojo():RebuildCacheData()
            end

            -- sync playerDojo passScheduleId
            GameUtils.GetPlayerDojo().nightmarePassCardScheduleId = newScheduleId

            -- done callback
            if callback then
                callback()
            end
        end
    end)
end


function UIDarkDreamPassContractManualPanel:ClearRefreshCountdown_()
    if isNotNull(self.scheduleRefreshTimer_) then
        CfUtils.CDTimerRemove(self.scheduleRefreshTimer_)
        self.scheduleRefreshTimer_ = nil
    end
end


function UIDarkDreamPassContractManualPanel:StartRefreshCountdown_()
    self:ClearRefreshCountdown_()

    local passCardHomeDojo = self:GetHomeDojo()
    local countdownTimeNum = math.max(passCardHomeDojo.leftSeconds, 1)
    self.scheduleRefreshTimer_ = CfUtils.CDTimerAppend(1, countdownTimeNum, true, true, function(count, id, elapsed)

        -- update leftTime
        passCardHomeDojo.leftSeconds = passCardHomeDojo.leftSeconds - elapsed
        self:UpdateRefreshCountdownTime_()

        -- check timeover
        if count == 0 then
            self:SyncPassHomeData_(function()
                self:OnDataRefresh()
            end)
        end
    end)
end


function UIDarkDreamPassContractManualPanel:UpdateRefreshCountdownTime_()
    local leftSeconds = self:GetHomeDojo().leftSeconds
    local leftTimeTxt = CfUtils.GetTimeHMS4(math.max(leftSeconds, 0))
    CfUtils.FillText(self.RewardsLeftTimeTxt, leftTimeTxt)
end


--- 刷新 展示道具细腻
function UIDarkDreamPassContractManualPanel:UpdateBaseShowInfo_()
    -- show item1
    local item1GoodsId  = self:GetHomeDojo().showItem1GoodsId
    local item1GoodsVo  = goodsConfMgr:GetGoodsVoById(item1GoodsId)
    local item1IconPath = goodsConfMgr:GetPhotoPathById(item1GoodsId)
    local item1GoodsNum = self:GetHomeDojo():GetTotalRewardGoodsData(item1GoodsId)
    CfUtils.SetActive(self.Item1GoodsIconImg, item1GoodsId > 0)
    CfUtils.FillImage(self.Item1GoodsIconImg, item1IconPath)
    CfUtils.FillText(self.Item1GoodsNumTxt, string.fmt('x%1', item1GoodsNum))
    SetButtonAction(self.Item1GoodsNode, function()
        GameUtils.ShowCommonTipsBoard(self.Item1GoodsNode, item1GoodsVo.name, item1GoodsVo.desc, item1GoodsVo.quality, item1GoodsVo.id)
    end)
    
    -- show item2
    local item2GoodsId  = self:GetHomeDojo().showItem2GoodsId
    local item2GoodsVo  = goodsConfMgr:GetGoodsVoById(item2GoodsId)
    local item2IconPath = goodsConfMgr:GetPhotoPathById(item2GoodsId)
    local item2GoodsNum = self:GetHomeDojo():GetTotalRewardGoodsData(item2GoodsId)
    CfUtils.SetActive(self.Item2GoodsIconImg, item2GoodsId > 0)
    CfUtils.FillImage(self.Item2GoodsIconImg, item2IconPath)
    CfUtils.FillText(self.Item2GoodsNumTxt, string.fmt('x%1', item2GoodsNum))
    SetButtonAction(self.Item2GoodsNode, function()
        GameUtils.ShowCommonTipsBoard(self.Item2GoodsNode, item2GoodsVo.name, item2GoodsVo.desc, item2GoodsVo.quality, item2GoodsVo.id)
    end)
    
    -- show item3
    local item3IconPath = self:GetHomeDojo().showItem3ImgPath
    CfUtils.FillImage(self.Item3GoodsIconImg, item3IconPath)
    CfUtils.SetActive(self.Item3GoodsIconImg, not string.isEmpty(item3IconPath))
    CfUtils.FillText(self.Item3GoodsNumTxt, localize('专武升级材料'))

    -- pass slogan
    local rewardSloganTxt = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.PASS_BOTTOM_TIPS)
    CfUtils.FillText(self.RewardSloganTxt, rewardSloganTxt)

    -- pass name
    local freePassNameTxt = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.FREE_PARSS_NAME)
    local paidPassNameTxt = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.PAID_PARSS_NAME)
    CfUtils.FillText(self.PassFreeNameTxt, freePassNameTxt)
    CfUtils.FillText(self.PassPaidNameTxt, paidPassNameTxt)
    
    -- convert num
    local pointConvertNum = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.EXP_CONVERT_NUM)
    CfUtils.FillText(self.PointConvertTxt, localize('转化为_num_经验', {_num_ = pointConvertNum}))

    -- price info
    local paidProductDojo = self:GetHomeDojo():GetPaidPassCardProductDojo()
    if #checkTable(paidProductDojo.prices) > 0 then
        local priceData = checkTable(paidProductDojo.prices[1])
        CfUtils.FillText(self.PassCardPriceTxt, tostring(priceData.num))
        CfUtils.FillImage(self.PassCardPriceIcon, goodsConfMgr:GetPhotoPathById(priceData.goodsId))
        CfUtils.SetActive(self.PassCardPriceIcon, true)
    else
        local priceData = CfUtils.GetPayData(paidProductDojo.price, paidProductDojo.channelProductId) or {}
        CfUtils.FillText(self.PassCardPriceTxt, string.fmt('<size=40>%1</size>%2', priceData.currencySymbol, priceData.price))
        CfUtils.SetActive(self.PassCardPriceIcon, false)
    end
end


--- 刷新 Pass卡状态
function UIDarkDreamPassContractManualPanel:UpdatePassTypeState_()
    if self:GetHomeDojo().isBoughtPassCard then
        CfUtils.SetActive(self.PassCardBuyBtn, false)
        CfUtils.SetActive(self.PassCardHasNode, true)
        CfUtils.SetActive(self.PassCardBuyUIFX, false)
        CfUtils.SetActive(self.PassCardUpgradeUIFX, false)
        CfUtils.SetActive(self.PassPaidLockIcon, false)

    else
        CfUtils.SetActive(self.PassCardBuyBtn, true)
        CfUtils.SetActive(self.PassCardHasNode, false)
        CfUtils.SetActive(self.PassCardBuyUIFX, true)
        CfUtils.SetActive(self.PassCardUpgradeUIFX, false)
        CfUtils.SetActive(self.PassPaidLockIcon, true)
    end
end


--- 刷新 Pass卡等级
function UIDarkDreamPassContractManualPanel:UpdatePassLevelInfo_()
    local isPassLevelMax  = self:GetHomeDojo():IsPassLevelMax()
    local currentLevelNum = self:GetHomeDojo().passCardLevelNow

    -- update level text
    CfUtils.SetActive(self.PassLevelMaxTxt, isPassLevelMax)
    CfUtils.SetActive(self.PassLevelNumTxt, not isPassLevelMax)
    if not isPassLevelMax then
        CfUtils.FillText(self.PassLevelNumTxt, localize('LV. <size=80>_num_</size>', {_num_ = currentLevelNum}))
    end
    
    -- update buy button
    if isPassLevelMax then
        self.PassLevelBuyBtn:ResetFontStyle('B18', localize('已满级'))
    else
        self.PassLevelBuyBtn:ResetFontStyle('B25', localize('购买等级'))
    end
    
    -- update exp value
    local currentExpNum = self:GetHomeDojo().passCardShowExp
    local upgradeLevExp = isPassLevelMax and PassCardUtils:GetLoopChestEachExp() or PassCardUtils.ConvertPassUpgradeExp()
    CfUtils.FillText(self.PassLevelExpTxt, localize('<size=40>_num1_</size>/_num2_', {_num1_ = currentExpNum, _num2_ = upgradeLevExp}))
    CfUtils.SetSliderPercent(self.PassLevelExpSlider, currentExpNum / upgradeLevExp)
end


--- 刷新 领取奖励列表
function UIDarkDreamPassContractManualPanel:UpdateRewardList_()
    local listDataLength = #self:GetRewardsDataList()
    GameUtils.ReloadData(self.RewardsGoodsList, listDataLength)
end


--- 检测 悬停奖励位置
---@param scrollOffsetX number
function UIDarkDreamPassContractManualPanel:CheckStageDrawIndex_(scrollOffsetX)
    if self.rewardListTotalW_ <= 0 then return end

    local firstRewardIndex = math.floor(-scrollOffsetX / self.rewardListItemW_) + 1
    CfUtils.SetActive(self.RewardsToLeftBtn, self.canDrawIndexMin_ > 0 and firstRewardIndex > self.canDrawIndexMin_)

    -- 是否滚动出奖励区域
    local scrollLimitX = self.rewardListVPortW_ - self.rewardListTotalW_
    if scrollOffsetX < scrollLimitX then
        CfUtils.SetActive(self.RewardsToRightBtn, false)

    else
        local lastRewardIndex = math.ceil((self.rewardListVPortW_ + -scrollOffsetX) / self.rewardListItemW_)
        CfUtils.SetActive(self.RewardsToRightBtn, lastRewardIndex - 1 < self.canDrawIndexMax_)
    end
end


-- 检测 最左边/最右边的 可领取奖励位置
function UIDarkDreamPassContractManualPanel:CheckCanDrawIndex_()
    self.canDrawIndexMin_ = 0
    self.canDrawIndexMax_ = 0
    for drawIndex = 1, self:GetHomeDojo().passCardLevelMax do
        if self:GetHomeDojo():HasCanDrawRewardsAt(drawIndex) then
            if self.canDrawIndexMin_ == 0 then
                self.canDrawIndexMin_ = drawIndex
            end
            self.canDrawIndexMax_ = math.max(self.canDrawIndexMax_, drawIndex)
        end
    end
    self:OnRewardsGoodsListScrollChangedHandler_()
end


--- 刷新 领取全部按钮红点
function UIDarkDreamPassContractManualPanel:UpdateDrawRewardsRed_()
    local hasRedPoint = false

    -- check chest rewards
    if self:GetHomeDojo().canDrawCircleTimes > 0 then 
        hasRedPoint = true
    end

    -- check has rewards
    if hasRedPoint == false then
        hasRedPoint = self:GetHomeDojo():HasCanDrawRewards()
    end

    GameUtils.SetRedPointNum(Constants.RedPointConst.NightmarePassCard, hasRedPoint and 1 or 0)
    CfUtils.SetActive(self.RewardsDrawAllRed, hasRedPoint)
end


-------------------------------------------------
-- handler

--- Pass卡经验 发生变化
function UIDarkDreamPassContractManualPanel:OnPassExpChangeEventHandler_()
    self:UpdatePassLevelInfo_()
    self:UpdateDrawRewardsRed_()
    self:UpdateRewardList_()
    self:CheckCanDrawIndex_()
end


--- Pass卡循环宝箱次数 发生变化
function UIDarkDreamPassContractManualPanel:OnPassLoopTimesEventHandler_()
    self:UpdatePassLevelInfo_()
    self:UpdateDrawRewardsRed_()
end


--- Pass卡类型 发生变化
function UIDarkDreamPassContractManualPanel:OnPassTypeChangeEventHandler_()
    self:UpdatePassTypeState_()
    self:UpdateDrawRewardsRed_()
    self:UpdateRewardList_()
    self:CheckCanDrawIndex_()
end


--- 奖励列表滚动变化
function UIDarkDreamPassContractManualPanel:OnRewardsGoodsListScrollChangedHandler_()
    if self.coDisableScrollCheck_ then return end
    if not self.rewardListCTrans_ then return end
    self:CheckStageDrawIndex_(self.rewardListCTrans_.anchoredPosition3D.x)
end


--- 领取奖励列表刷新
---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIDarkDreamPassContractManualPanel:OnUpdateRewardsListCellHandler_(listView, luaIndex)
    local cellData = self:GetRewardsDataList()[luaIndex]
    local isChest  = cellData.isChest == true
    local cellNode = listView:NewListViewItem(isChest and RewardListCellName2 or RewardListCellName1)
    ---@type UIDarkDreamPassContractManualPanelRewardNode | UIDarkDreamPassContractManualPanelFinalNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, isChest and RewardListCellPath2 or RewardListCellPath1)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetHomeDojo(self:GetHomeDojo())
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        if isChest then
            cellEnv:SetClickDrawCB(Bind(self, self.OnClickChestCellDrawButtonCallback_))
        else
            cellEnv:SetClickDrawCB(Bind(self, self.OnClickRewardCellDrawButtonCallback_))
        end
    end
    return cellNode
end


--- 领取 指定位置的 Pass卡奖励
---@param luaIndex integer
---@param drawId integer
function UIDarkDreamPassContractManualPanel:OnClickRewardCellDrawButtonCallback_(luaIndex, drawId)
    local cellData = self:GetRewardsDataList()[luaIndex]
    self:DoDrawPassCardLevelRewards_({drawId}, function()
        self.RewardsGoodsList:RefreshItemByItemIndex(luaIndex - 1)
        self:CheckCanDrawIndex_()
    end)
end


--- 领取 全部的Pass卡奖励 + 循环宝箱奖励
function UIDarkDreamPassContractManualPanel:OnClickRewardsDrawAllButtonHandler_()
    local hasCanDrawRewards = self:GetHomeDojo():HasCanDrawRewards()
    local hasCanCircleTimes = self:GetHomeDojo().canDrawCircleTimes > 0
    if hasCanDrawRewards == false and hasCanCircleTimes == false then
        GameUtils.Toast(localize('没有可领取的奖励'))
        return
    end
    
    local drawIdList = self:GetHomeDojo():GetAllCanDrawIdList()
    self:DoDrawPassCardLevelRewards_(drawIdList, function()
        self:UpdateRewardList_()
        self:CheckCanDrawIndex_()
    end)
end


---@param drawIdList integer[]
---@param drawnCb fun():void
function UIDarkDreamPassContractManualPanel:DoDrawPassCardLevelRewards_(drawIdList, drawnCb)
    --- 奖励ID，传0表示一键领取全部
    local requestData = {rewardId = #drawIdList > 1 and 0 or drawIdList[1]}
    GameUtils.Request(Interfaces.OverseaNightmarePassCardDrawLevelRewards, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})

            -- save drawId
            for _, drawId in ipairs(drawIdList) do
                self:GetHomeDojo():SaveDrawnRewardsId(drawId)
            end

            -- check circleTimes
            if self:GetHomeDojo().canDrawCircleTimes > 0 then
                -- 能换几个一次性全兑换了
                local canDrawCount  = self:GetHomeDojo().canDrawCircleTimes
                local oldDrawnTimes = self:GetHomeDojo().drawnCircleTimes
                self:GetHomeDojo():UpdateDrawnCircleTimes(oldDrawnTimes + canDrawCount)
            end

            -- update redPoint
            self:UpdateDrawRewardsRed_()

            -- do callback
            if drawnCb then
                drawnCb()
            end
        end
    end)
end


--- 领取 循环宝箱奖励
function UIDarkDreamPassContractManualPanel:OnClickChestCellDrawButtonCallback_()
    if self:GetHomeDojo().canDrawCircleTimes <= 0 then
        GameUtils.Toast(localize('奖励领取次数不足'))
        return
    end

    GameUtils.Request(Interfaces.OverseaNightmarePassCardDrawCircleRewards, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})

            -- 能换几个一次性全兑换了
            local canDrawCount  = self:GetHomeDojo().canDrawCircleTimes
            local oldDrawnTimes = self:GetHomeDojo().drawnCircleTimes
            self:GetHomeDojo():UpdateDrawnCircleTimes(oldDrawnTimes + canDrawCount)

            -- update redPoint
            self:UpdateDrawRewardsRed_()
        end
    end)
end


--- 购买Pass卡
function UIDarkDreamPassContractManualPanel:OnClickBuyPassButtonHandler_()
    if self:GetHomeDojo().isBoughtPassCard then
        return
    end

    local passProductDojo = self:GetHomeDojo():GetPaidPassCardProductDojo()
    local passProductName = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.PAID_PARSS_NAME)
    if #checkTable(passProductDojo.prices) > 0 then

        local toBuyPassProduct = function()
            local requestData = {productId = passProductDojo.productId}
            GameUtils.Request(Interfaces.OverseaNightmarePassCardDiamondBuy, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)

                    -- 消耗钻石
                    GoodsUtils.ConsumeGoods(passProductDojo.prices, true)

                    -- 刷新界面
                    self:OnEventSdkEventHandler_({event = Constants.EventNames.EVENT_SDK_PAY, productId = passProductDojo.channelProductId})
                end
            end)
        end

        local _, errorTips = GoodsUtils.CheckGoodConsume(passProductDojo.prices)
        if errorTips then
            if serverDifferenceMgr:IsSecondaryCurrencyEnable() then
                local priceData = checkTable(passProductDojo.prices[1])
                serverDifferenceMgr:WrapPrimaryCurrencyBuy({currency = priceData.goodsId, current = priceData.num}, function(isSuccess)
                    if checkBool(isSuccess) then
                        toBuyPassProduct()
                    end
                end)
            else
                GameUtils.Toast(errorTips)
            end
            return
        end

        local priceData = checkTable(passProductDojo.prices[1])
        local consumeVo = GoodsConfMgr:GetInstance():GetGoodsVoById(priceData.goodsId)
        local text = localize("确认花费_Num__Name_购买商品?", {_Num_ = priceData.num, _Name_ = consumeVo.name})
        GameUtils.SecondConfirm(text, toBuyPassProduct, nil)

    else
        SDKService:GetInstance():PayMoney({
            productId        = passProductDojo.productId,
            channelProductId = passProductDojo.channelProductId,
            productDesc      = passProductName,
            payAmount        = passProductDojo.price,
            data             = passProductDojo.originData
        })
    end
end


function UIDarkDreamPassContractManualPanel:OnEventSdkEventHandler_(parameters)
    --- sdk pay succeed
    if parameters.event == Constants.EventNames.EVENT_SDK_PAY then

        local passProductDojo = self:GetHomeDojo():GetPaidPassCardProductDojo()
        if parameters.productId == passProductDojo.channelProductId then
            -- update passType
            self:GetHomeDojo():UpdatePassCardType(true)
        end

    end
end


--- 购买Pass卡等级
function UIDarkDreamPassContractManualPanel:OnClickPassLevelBuyButtonHandler_()
    if self:GetHomeDojo():IsPassLevelMax() then
        GameUtils.Toast(localize('等级已到达巅峰'))
        return
    end

    CfUtils.DialogOpen(Constants.UITypeIds.UIDarkDreamPassBuyRatingDialog, {passCardHomeDojo = self:GetHomeDojo()})
end


--- 前往噩梦回响功能
function UIDarkDreamPassContractManualPanel:OnClickPointEntryButtonButtonHandler_()
    local sysTemId = Constants.SystemToggleIds.Id2019
    local isUnlock = GameUtils.IsUnlockedBySystemTogId(sysTemId)
    if not isUnlock then
        GameUtils.Toast(GameUtils.GetUnlockDescrBySystemTogId(sysTemId))
        return
    end

    CfUtils.DialogOpen(Constants.UITypeIds.ActionDarkDreamMainDialog, {}, CfUtils.DialogGetAllArgs())
    GameUtils.SetRedPointNum(Constants.RedPointConst.QuestChaoticNewRecall, 0)
end


return UIDarkDreamPassContractManualPanel
