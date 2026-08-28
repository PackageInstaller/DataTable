-------------------------------------------------------------------------------
-- 通用切页签活动商店界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-23 19:47:31
-------------------------------------------------------------------------------

local GroceryUtils        = import('Game.Grocery.GroceryUtils')
local ActivityUtils       = import('Game.Activity.ActivityUtils')
local ActivityConstants   = import('Game.Activity.ActivityConstants')
local activityMgr         = import('Game.Activity.ActivityMgr'):GetInstance()
local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local ProductListCellPath = 'Game.Activity.SkinShop.UIActivitySkinShopCellNode'
local CountDownTimeNum    = 2592000 --30 * 86400 30天的秒数

-- 本界面自定义用的，无配表关联
local MallMainTabType = {
    BattleCardGamePack = 1001,  -- 战牌商城 卡包
    BattleCardGameCard = 1002,  -- 战牌商城 卡牌
}


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Activity/ActivityCommonShopTabLeftDialog.prefab > name: ActivityCommonShopTabUpDialog
---@class UIActivityCommonShopTabUpDialog
---@field Env                           	UIActivityCommonShopTabUpDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ScrollView                    	Engine.UI.AutoFixSizeListView           	@ 0    商品列表
---@field TextTime                      	UnityEngine.RectTransform               	@ 1    剩余时间文字
---@field TextTime2                     	UnityEngine.RectTransform               	@ 2    剩余时间文本
---@field RightPanel                    	UnityEngine.RectTransform               	@ 3    右侧信息节点
---@field Container                     	UnityEngine.RectTransform               	@ 4    内容根节点
---@field Root                          	UnityEngine.RectTransform               	@ 5    根节点
---@field ImgBg                         	UnityEngine.RectTransform               	@ 6    背景图
---@field CommonTabToggleLeft           	UnityEngine.RectTransform               	@ 7    左侧页签控件
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 8    顶部页签控件
local UIActivityCommonShopTabUpDialog = Class('UIActivityCommonShopTabUpDialog')


function UIActivityCommonShopTabUpDialog:__init()
    ---@type CommonTabToggleLeft @ 左侧页签控制器
    self.mainTabEnv_ = nil

    ---@type CommonTabToggleUp @ 顶部页签控制器
    self.subTabEnv_ = nil

    ---@type table[] @ 主分类页签数据
    self.mainTabDatas_ = {}

    ---@type table[] @ 副分类页签数据
    self.subTabDatas_ = {}

    ---@type integer @ 活动唯一id
    self.activityUuid_ = 0

    ---@type ActivityConstants.ActivityType @ 活动类型
    self.activityType_ = 0

    ---@type integer[] @ 顶部货币id列表
    self.topGoodsList_ = {}

    ---@type string @ 商城背景图片
    self.mallBgImage_ = nil

    ---@type Engine.Modules.CDTimerModule @ 刷新倒计时的计时器
    self.mallRefreshTimer_ = nil

    ---@type table @ 活动商店数据
    self.mallHomeData_ = {}

    -- { [ mainTabIndex : integer ] = { [ subTabIndex : integer ] = indexList : integer[] } } 
    ---@type table<integer, table<integer, integer[]>> @ 商品数据页签分类map
    self.mallDataTabMap_ = {}
end


function UIActivityCommonShopTabUpDialog:__delete()
    self.mainTabEnv_       = nil
    self.subTabEnv_        = nil
    self.mainTabDatas_     = nil
    self.subTabDatas_      = nil
    self.activityUuid_     = nil
    self.activityType_     = nil
    self.topGoodsList_     = nil
    self.mallBgImage_      = nil
    self.mallRefreshTimer_ = nil
    self.mallHomeData_     = nil
    self.mallDataTabMap_   = nil
end


function UIActivityCommonShopTabUpDialog:Awake()
    self.mainTabEnv_ = CfUtils.GetLuaScr(self.CommonTabToggleLeft, Constants.UILuaTablePath.ComTabToggle)
    self.subTabEnv_  = CfUtils.GetLuaScr(self.CommonTabToggleUp, Constants.UILuaTablePath.ComUpToggle)
end


function UIActivityCommonShopTabUpDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods(self.topGoodsList_)
    end
end


function UIActivityCommonShopTabUpDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        self.activityUuid_ = checkInt(initParams.activityUuid)
        self.activityType_ = checkInt(initParams.customType)
        self.topGoodsList_ = checkTable(initParams.topGoods)
        self.mallBgImage_  = checkString(initParams.mallBgImage)

        -- check activityType
        if self:GetActivityType() == 0 then
            local activityData = activityMgr:GetActivityComponent():GetDojoByActivityId(self:GetActivityUuid())
            if activityData.mallBgImage and not string.isEmpty(activityData.mallBgImage) then
                self.mallBgImage_ = activityData.mallBgImage
            end
            self.activityType_ = checkInt(activityData.type)
        end

        -- init views
        self:UpdateMallBackground_()
        CfUtils.SetActive(self.Root, false)
        CfUtils.SetActive(self.TextTime2, false)

        -- request data
        self:SyncMallHomeData_(function()
            CfUtils.SetActive(self.Root, true)
            self:InitMainTabData_()
            self:SetMainTypeIndex(1)
            self:InitializeToggle_()
        end)
    end)
end


function UIActivityCommonShopTabUpDialog:OnFinalize()
    return CoWaitDo(function()
        self:MallRefreshCountdownClear_()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer
function UIActivityCommonShopTabUpDialog:GetActivityUuid()
    return checkInt(self.activityUuid_)
end


---@return ActivityConstants.ActivityType
function UIActivityCommonShopTabUpDialog:GetActivityType()
    return checkInt(self.activityType_)
end


---@return table
function UIActivityCommonShopTabUpDialog:GetMallHomeData()
    return checkTable(self.mallHomeData_)
end


---@return table[]
function UIActivityCommonShopTabUpDialog:GetMallProducts()
    return checkTable(self:GetMallHomeData().products)
end


---@return integer
function UIActivityCommonShopTabUpDialog:GetMallRemainingTime()
    return checkInt(self:GetMallHomeData().remainingTimes)
end


---@return boolean
function UIActivityCommonShopTabUpDialog:IsMallStaticMode()
    return self:GetMallRemainingTime() == -1
end


---@return integer
function UIActivityCommonShopTabUpDialog:GetMainTypeIndex()
    return checkInt(self.mainTypeIndex_)
end
function UIActivityCommonShopTabUpDialog:SetMainTypeIndex(typeIndex)
    self.mainTypeIndex_ = checkInt(typeIndex)
    self:UpdateMainTypeChange_()
end


---@return integer
function UIActivityCommonShopTabUpDialog:GetSubTypeIndex()
    return checkInt(self.subTypeIndex_)
end
function UIActivityCommonShopTabUpDialog:SetSubTypeIndex(typeIndex)
    self.subTypeIndex_ = checkInt(typeIndex)
    self:UpdateSubTypeChange_()
end


---@return integer[]
function UIActivityCommonShopTabUpDialog:GetMallTabDataList()
    local mainMallDatas = checkTable(self.mallDataTabMap_[self:GetMainTypeIndex()])
    local subMallDatas  = checkTable(mainMallDatas[self:GetSubTypeIndex()])
    return subMallDatas
end


-------------------------------------------------
-- private

function UIActivityCommonShopTabUpDialog:MallRefreshCountdownClear_()
    if isNotNull(self.mallRefreshTimer_) then
        CfUtils.CDTimerRemove(self.mallRefreshTimer_)
        self.mallRefreshTimer_ = nil
    end
end


function UIActivityCommonShopTabUpDialog:MallRefreshCountdownStart_()
    self:MallRefreshCountdownClear_()

    local isNeedCountdown = not self:IsMallStaticMode()
    if not isNeedCountdown then
        for _, productData in ipairs(self:GetMallProducts()) do
            if checkInt(productData.endTime) > 0 then
                isNeedCountdown = true
                break
            end
        end
    end

    if isNeedCountdown then
        self.mallRefreshTimer_ = CfUtils.CDTimerAppend(1, CountDownTimeNum, true, true, function(count, id, elapsed)
            local hasRequest = false
    
            -- update leftTime
            if not self:IsMallStaticMode() then
                self:GetMallHomeData().remainingTimes = math.max(self:GetMallRemainingTime() - elapsed, 0)
                if self:GetMallRemainingTime() == 0 then
                    hasRequest = true
                end
            end
    
            for _, productData in ipairs(self:GetMallProducts()) do
                if checkInt(productData.endTime) > 0 then
                    productData.endTime = checkInt(productData.endTime) - elapsed
                    if checkInt(productData.endTime) <= 0 then
                        hasRequest = true
                    end
                end
            end
    
            -- update views
            self:UpdateMallRefreshTime_()
            Events.Broadcast('SKIN_SHOP_TIME_COUNT_DOWN')
    
            -- check timeover
            if hasRequest or count == 0 then
                self:SyncMallHomeData_()
            end
        end)
    else
        self:UpdateMallRefreshTime_()
    end
end


function UIActivityCommonShopTabUpDialog:InitMainTabData_()
    if self:GetActivityType() == ActivityConstants.ActivityType.BattleCardGame then
        self.mainTabDatas_ = {
            {
                text = localize('战牌牌包'),
                type = MallMainTabType.BattleCardGamePack,
                func = Bind(self, self.OnClickMainTypeTabHandler_),
                subs = {},
                smap = {},
            },
            {
                text = localize('战牌卡牌'),
                type = MallMainTabType.BattleCardGameCard,
                func = Bind(self, self.OnClickMainTypeTabHandler_),
                subs = {},
                smap = {},
            },
        }
        -- 卡牌分类：添加子分类
        local cardsTabDatas = self.mainTabDatas_[2]
        for starIndex = #BattleCardGameUtils.CardStarNames, 1, -1 do
            local subTyabData = {
                type = starIndex,
                text = BattleCardGameUtils.CardStarNames[starIndex],
                func = Bind(self, self.OnClickSubTypeTabHandler_),
            }
            table.insert(cardsTabDatas.subs, subTyabData)
            cardsTabDatas.smap[subTyabData.type] = #cardsTabDatas.subs
        end
    end
end


---@param mainTabIndex integer
---@param productData table
---@return integer
function UIActivityCommonShopTabUpDialog:CheckProductSubIndex_(mainTabIndex, productData)
    local subTabIndex = 0
    local mainTabData = checkTable(self.mainTabDatas_[mainTabIndex])
    local mainTabSmap = checkTable(mainTabData.smap)
    local mainTabType = checkInt(mainTabData.type)

    if self:GetActivityType() == ActivityConstants.ActivityType.BattleCardGame then
        if mainTabType == MallMainTabType.BattleCardGameCard then
            local goodsId    = checkInt(productData.goodsId)
            local cardInfoVo = BattleCardGameUtils.GetCardInfoVo(goodsId)
            local cardStar   = checkInt(cardInfoVo.cardStar)
            subTabIndex = checkInt(mainTabSmap[cardStar])
        end
    end

    return subTabIndex
end


---@param finishCb fun():void | nil
function UIActivityCommonShopTabUpDialog:SyncMallHomeData_(finishCb)
    local requestData = {activityUuid = self:GetActivityUuid(), activityType = self:GetActivityType()}
    GameUtils.Request(Interfaces.StoreActivityHome, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            self.mallHomeData_ = responseData

            -- init callback
            if finishCb then
                finishCb()
            end

            -- init mallDatas
            self.mallDataTabMap_ = {}
            for productIndex, productData in pairs(self:GetMallProducts()) do
                local mainTabIndex = checkInt(productData.tab)
                local subTabIndex  = self:CheckProductSubIndex_(mainTabIndex, productData)
                self.mallDataTabMap_[mainTabIndex] = self.mallDataTabMap_[mainTabIndex] or {}
                self.mallDataTabMap_[mainTabIndex][subTabIndex] = self.mallDataTabMap_[mainTabIndex][subTabIndex] or {}
                table.insert(self.mallDataTabMap_[mainTabIndex][subTabIndex], productIndex)
            end

            -- update views
            self:MallRefreshCountdownStart_()
            self:SetMainTypeIndex(self:GetMainTypeIndex())
        end
    end)
end


function UIActivityCommonShopTabUpDialog:UpdateMallBackground_()
    CfUtils.FillImage(self.ImgBg, ActivityUtils.GetImageFullPath(self.mallBgImage_, false))
end


function UIActivityCommonShopTabUpDialog:UpdateMallRefreshTime_()
    local refreshTimeLeft = self:GetMallRemainingTime()
    CfUtils.SetActive(self.TextTime2, not self:IsMallStaticMode())
    CfUtils.FillText(self.TextTime2, CfUtils.GetTimeHMS(refreshTimeLeft))
end


function UIActivityCommonShopTabUpDialog:InitializeToggle_()
    local mainTabIndex = self:GetMainTypeIndex()
    self.mainTabEnv_:FillToggles(self.mainTabDatas_, mainTabIndex, nil, true)
end


function UIActivityCommonShopTabUpDialog:UpdateMainTypeChange_()
    local mainTabIndex = self:GetMainTypeIndex()
    local mainTabData  = checkTable(self.mainTabDatas_[mainTabIndex])

    self.subTabDatas_  = checkTable(mainTabData.subs)
    self.subTabEnv_:FillToggles(self.subTabDatas_, 1)
    CfUtils.SetActive(self.CommonTabToggleUp, #self.subTabDatas_ > 0)

    local subTypeIndex = #self.subTabDatas_ > 0 and 1 or 0
    self:SetSubTypeIndex(subTypeIndex)
end


function UIActivityCommonShopTabUpDialog:UpdateSubTypeChange_()
    self:UpdateMallProductList_()
end


function UIActivityCommonShopTabUpDialog:UpdateMallProductList_()
    local listDataLength = #self:GetMallTabDataList()
    if not self.ScrollView.mLoopListView.IsListViewInit then
        self.ScrollView:InitListView(listDataLength, Bind(self, self.OnUpdateProductListCellHandler_))
    else
        self.ScrollView:SetListItemCount(listDataLength)
    end
end


-------------------------------------------------
-- handler

---@param mainTabData table
---@param typeTabIndex integer
function UIActivityCommonShopTabUpDialog:OnClickMainTypeTabHandler_(mainTabData, typeTabIndex)
    local oldTypeTabIndex = self:GetMainTypeIndex()
    local newTypeTabIndex = checkInt(typeTabIndex)
    if oldTypeTabIndex ~= newTypeTabIndex then
        self:SetMainTypeIndex(newTypeTabIndex)
    end
end


---@param typeTabIndex integer
function UIActivityCommonShopTabUpDialog:OnClickSubTypeTabHandler_(typeTabIndex)
    local oldTypeTabIndex = self:GetSubTypeIndex()
    local newTypeTabIndex = checkInt(typeTabIndex)
    if oldTypeTabIndex ~= newTypeTabIndex then
        self:SetSubTypeIndex(newTypeTabIndex)
    end
end


function UIActivityCommonShopTabUpDialog:OnUpdateProductListCellHandler_(cellNode, listIndex)
    if listIndex < 0 then return nil end

    local luaIndex     = listIndex + 1
    local productIndex = checkInt(self:GetMallTabDataList()[luaIndex])
    local productData  = checkTable(self:GetMallProducts()[productIndex])

    ---@type UIActivitySkinShopCellNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, ProductListCellPath)
    if isNotNull(cellEnv) then
        cellEnv:Refresh(productData, function()

            local isLocked = GroceryUtils.ProductIsLocked(productData)
            if isLocked then
                GameUtils.Toast(localize('商品未解锁'))
                return
            end

            local isOnly = GroceryUtils.ProductIsOnly(productData)
            if isOnly then
                GameUtils.Toast(localize('商品已拥有'))
                return
            end

            local priceDatas = {}
            for priceId, priceData in pairs(productData.prices) do
                table.insert(priceDatas, {
                    current  = priceData.current,
                    original = priceData.original,
                    currency = priceId
                })
            end

            self._clickCellIndex = luaIndex
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonBuyItemDialog, {
                goodsId        = productData.icon,
                goodsNum       = productData.num,
                prices         = priceDatas,
                coinPrices     = productData.coinPrices,
                maxBuyNum      = productData.currentStock,
                rewards        = productData.rewards,
                remainTime     = productData.refreshTime,
                endTime        = productData.nextRefreshLeftSeconds,
                refreshType    = productData.refreshType,
                purchaseLimit  = productData.purchaseLimit,
                
                buyCb          = function (price, buyNum)
                    self:OnBuyItem(productData.productId, price, buyNum, cellEnv, productData.icon)
                end
            })
        end)
    end
end


---@param productId integer
---@param price table
---@param buyNum integer
---@param cellEnv UIActivitySkinShopCellNode
---@param buyGoodsId integer
function UIActivityCommonShopTabUpDialog:OnBuyItem(productId, price, buyNum, cellEnv, buyGoodsId)
    local requestPath = Interfaces.StoreActivityBuy
    local requestData = {
        productId    = productId,
        num          = buyNum,
        currency     = price.currency,
        activityUuid = self:GetActivityUuid(),
        activityType = self:GetActivityType(),
    }

    GameUtils.Request(requestPath, requestData, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update product data
            local productIndex = checkInt(self:GetMallTabDataList()[self._clickCellIndex])
            local productData  = checkTable(self:GetMallProducts()[productIndex])
            if self:GetMallTabDataList()[self._clickCellIndex] then
                productData.currentStock = checkInt(productData.currentStock) - buyNum
            end

            -- update product cell
            if cellEnv then
                cellEnv:RefreshData(productData)
            end

            -- update consume
            local consumeData = { {goodsId = price.currency, num = price.current * buyNum} }
            GoodsUtils.ConsumeGoods(consumeData, true)

            -- update rewards
            local rewardList = checkTable(responseData.rewards)
            rewardList = GoodsUtils.DrawRewards(rewardList, true)

            --TODO 统一到DrawRewards,需要修改ActivityGachaponWithoutReplacement里显示皮肤的逻辑
            local skinReward = nil
            for _, goodsData in ipairs(rewardList) do
                local goodsId   = checkInt(goodsData.goodsId)
                local goodsType = GoodsUtils.GetIdType(goodsId)
                if goodsType == Constants.IDType.CardSkin then
                    ---@type CardSkinComponent
                    local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
                    if not cardSkinComponent:IsHasSkin(goodsId) then
                        skinReward = goodsData
                        break
                    end
                end
            end

            -- show rewards
            if skinReward then
                CfUtils.DialogOpen(Constants.UITypeIds.CommonCardDisplayDialog, {
                    cardInfo  =  { {goodsId = skinReward.goodsId} },
                    isSkin    = true,
                    onCloseCb = function()
                        CfUtils.DialogClose(Constants.UITypeIds.CommonCardDisplayDialog)
                        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList } )
                    end, 
                })
            else
                local firstGoods = checkTable(rewardList[1])
                if GoodsUtils.GetIdType(firstGoods.goodsId) == Constants.IDType.BattleCardGameCard then
                    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerBuyAnimation, { rewards = rewardList, goodsId = buyGoodsId } )
                else
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList } )
                end
            end

            GameUtils.GetCriWareUtils().PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_shop_buy)
        end

    end, function(errStr)
        if string.isEmpty(errStr) or errStr == nil then
            return
        end
        printError("store buy" .. errStr)
    end)
end


return UIActivityCommonShopTabUpDialog
