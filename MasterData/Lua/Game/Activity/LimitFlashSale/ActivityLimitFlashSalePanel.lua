
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
local ActivityUtils     = import("Game.Activity.ActivityUtils")
---@type ActivityConstants
local ActivityConstants = import("Game.Activity.ActivityConstants")
---@type SDKService
local SDKService        = import('Game.Entry.SDKService')
local CDTimerModule     = CS.Engine.Modules.CDTimerModule.GetInstance()
--endregion

--region define
local StickerNodeLuaPath = "Game.Activity.LimitFlashSale.ActivityLimitFlashSaleStickerNode"

--endregion

--- from: Assets/BundleResources/Prefabs/Activity/ActivityLimitFlashSaleDIalog140001.prefab > name: ActivityLimitFlashSaleDIalog140001
---@class ActivityLimitFlashSalePanel
---@field Env                           	ActivityLimitFlashSalePanel             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextNumber                    	CustomText                              	@ 0    
---@field TextRemainTimes               	CustomText                              	@ 1    
---@field BtnNoneTxtBuy                 	Game.Native.Common.UISwitchText         	@ 2    
---@field BtnNone                       	UnityEngine.RectTransform               	@ 3    
---@field BtnCostTxtBuy                 	UnityEngine.UI.Text                     	@ 4    
---@field BtnCost                       	UnityEngine.RectTransform               	@ 5    
---@field BtnCostImgIcon                	UnityEngine.RectTransform               	@ 6    
---@field Unlock                        	UnityEngine.RectTransform               	@ 7    
---@field LockTipsTextDesc              	CustomText                              	@ 8    
---@field BtnLockTxtBuy                 	UnityEngine.UI.Text                     	@ 9    
---@field BtnLock                       	UnityEngine.RectTransform               	@ 10   
---@field LockImgIcon                   	Engine.UI.ImageAlterable                	@ 11   
---@field Lock                          	UnityEngine.RectTransform               	@ 12   
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 13   
---@field BtnExchange                   	UnityEngine.RectTransform               	@ 14   
---@field StickerNode                   	UnityEngine.RectTransform               	@ 15   
---@field Stickers                      	UnityEngine.RectTransform               	@ 16   
---@field TxtTime                       	TMPro.TextMeshProUGUI                   	@ 17   
---@field BtnExplain                    	UnityEngine.RectTransform               	@ 18   
---@field ImgTitle                      	Engine.UI.WebRawImage                   	@ 19   
local ActivityLimitFlashSalePanel = Class('ActivityLimitFlashSalePanel')

function ActivityLimitFlashSalePanel:__init()
    self._isInit = false
end


function ActivityLimitFlashSalePanel:__delete()
    
end


-- function ActivityLimitFlashSalePanel:Awake()
-- end


function ActivityLimitFlashSalePanel:Start()
    SetButtonAction(self.BtnExplain, Bind(self, self.OnClickBtnExplainAction))
    SetButtonAction(self.BtnExchange, Bind(self, self.OnClickBtnExchangeAction))
    SetButtonAction(self.BtnNone,    Bind(self, self.OnClickBtnNoneAction))
    SetButtonAction(self.BtnCost,    Bind(self, self.OnClickBtnCostAction))
    SetButtonAction(self.BtnLock,    Bind(self, self.OnClickBtnLockAction))

    self.__EventSdkEvent = Events.AddListener(Constants.EventNames.EVENT_SDK, Bind(self, self.OnEventSdkEvent))
    self.__EventFreshHome = Events.AddListener(Constants.EventNames.ActivityLimitFlashSaleFreshHome, Bind(self, self.OnEventFreshHome))
end


function ActivityLimitFlashSalePanel:OnDestroy()
    self:StopRequestCo()
    self:StopCountDown()
    if self.__EventSdkEvent then
        Events.RemoveListener(Constants.EventNames.EVENT_SDK, self.__EventSdkEvent)
        self.__EventSdkEvent = nil
    end
    if self.__EventFreshHome then
        Events.RemoveListener(Constants.EventNames.ActivityLimitFlashSaleFreshHome, self.__EventFreshHome)
        self.__EventFreshHome = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

function ActivityLimitFlashSalePanel:StartCountDown()
    -- if isNotNull(self._timer) then return end
    -- self._timer = CDTimerModule:AddCD(1, function (count, id)
    --     local curTime   = os.time()
    --     local homeData = self._provider:GetHomeData()
    --     local countDown = curTime - homeData.countDown
    --     if countDown > 0 then
    --         self:FreshLeftUnlockSeconds(false, countDown)
    --     else
    --         self:FreshButtonGroup(homeData)
    --         self:StopCountDown()
    --     end
    -- end, 86400, true, true, true)
    self:StopCountDown()
    self._timer = CfUtils.CDTimerAppend(1, 86400, false, true, function(count, id, elapsed)
        local curTime   = os.time()
        local homeData = self._provider:GetHomeData()
        local countDown = homeData.countDown - curTime
        if countDown > 0 then
            self:FreshLeftUnlockSeconds(false, countDown)
        else
            self:FreshButtonGroup(homeData)
            self:StopCountDown()
        end
       
    end)

end

function ActivityLimitFlashSalePanel:StopCountDown()
    CfUtils.CDTimerRemove(self._timer)
    -- if not isNull(self._timer) then
    --     CDTimerModule:RemoveCD(self._timer)
    --     self._timer = nil
    -- end
end


--region init 


--endregion 


--region logic 

---Refresh
---@param activityDojo ActivityDojo
function ActivityLimitFlashSalePanel:Refresh(activityDojo)
    -- print(table.toString(activityDojo))
    self._activityDojo = activityDojo
    local activityType = checkNumber(activityDojo.type)
    local config        = ActivityConstants.Configs[activityType] or ActivityConstants.Configs[ActivityConstants.ActivityType.LimitFlashSale]
    local providerPath = config.providerPath
    local provider     = import(providerPath)
    provider:SetActivityDojo(activityDojo)
    ---@type ActivityLimitFlashSaleDataProvider
    self._provider = provider

    local titleImgUrl = checkString(activityDojo.titleImage)
    if not string.isEmpty(titleImgUrl) then
        CfUtils.FillWebRawImage(self.ImgTitle, titleImgUrl)
    end

    self:RequestAndFreshUI(activityDojo)
    self:FreshPanel(activityDojo)
end

function ActivityLimitFlashSalePanel:FreshPanel(activityDojo)
    self.TxtTime.text   = ActivityUtils.ConventActivityDurationTime(activityDojo.startTime, activityDojo.endTime)
end

function ActivityLimitFlashSalePanel:RequestAndFreshUI(activityDojo)
    self._provider:RequestHome(activityDojo.id)
    self:WaitAndFreshUI()
    
end

function ActivityLimitFlashSalePanel:WaitAndFreshUI()
    self:StopRequestCo()
    self._requestCo = CoStart(function() 
        local CoYield = CoYield
        while not self._provider:GetIsRequestComplete() do
            CoYield()
        end
        self:FreshUI()
        self._requestCo = nil
    end)
    
end

function ActivityLimitFlashSalePanel:StopRequestCo()
    if isNotNull(self._requestCo) then
        CoStop(self._requestCo)
        self._requestCo = nil
    end
end

function ActivityLimitFlashSalePanel:FreshUI()
    local homeData = self._provider:GetHomeData()
    self:FreshStickers(homeData.showCollectGoodsId)
    self:FreshGiftGoods(homeData.superRewards)
    self:FreshButtonGroup(homeData)
    self:FreshStock(homeData.stock)
end

function ActivityLimitFlashSalePanel:FreshStickers(dataList)
    GameUtils.ResizeContent(self.Stickers, self.StickerNode, #dataList, function(index, childNode) 
        ---@type ActivityLimitFlashSaleStickerNode
        local env = CfUtils.GetLuaScr(childNode, StickerNodeLuaPath)
        if isNotNull(env) then
            env:FreshUI(dataList[index])
        end
    end)
end

function ActivityLimitFlashSalePanel:FreshGiftGoods(goods)
    UICommonUtils.FillCommonGoodsListLight(self.CommonGoodsListLight, goods, false, false, true, false, false) 
end

---FreshButtonGroup
---@param data FlashSaleDataDojo
function ActivityLimitFlashSalePanel:FreshButtonGroup(data)
    local curTime   = os.time()
    local isEnd     = not ActivityUtils.IsActivityEnabled(self._activityDojo)
    local countDown = curTime - data.countDown
    local isUnLock  = countDown >= 0 and not isEnd

    CfUtils.SetActive(self.Lock,     not isUnLock)
    CfUtils.SetActive(self.Unlock, isUnLock)
    
    
    local priceText, imgPath  = self:GetPriceInfo(data)
    if isUnLock then
        local stock    = checkNumber(data.stock)
        local buyLimit = checkNumber(data.buyLimit)
        local isNone   = stock <= 0 or buyLimit <= 0
        CfUtils.SetActive(self.BtnCost, not isNone)
        CfUtils.SetActive(self.BtnNone, isNone)

        local isShowImg = not string.isEmpty(imgPath)
        CfUtils.SetActive(self.BtnCostImgIcon, isShowImg)
        if isShowImg then
            self.BtnCostImgIcon:LoadSprite(imgPath)
        end

        if isNone then
            local isOwnTimes = buyLimit > 0 
            self.BtnNoneTxtBuy.text = isOwnTimes and localize("无库存") or localize("无次数")

        else
            self.BtnCostTxtBuy.text = priceText

        end

        self.TextRemainTimes.text = localize("剩余兑换次数：_num_", {_num_ = buyLimit})

    else
        self.BtnLockTxtBuy.text = priceText
        local isShowImg = not string.isEmpty(imgPath)
        CfUtils.SetActive(self.LockImgIcon, isShowImg)
        if isShowImg then
            self.LockImgIcon:LoadSprite(imgPath)
        end

        self:FreshLeftUnlockSeconds(isEnd, countDown * -1)
        if not isEnd then
            self:StartCountDown()
        end
    end

end

function ActivityLimitFlashSalePanel:FreshLeftUnlockSeconds(isEnd, seconds)
    self.LockTipsTextDesc.text = isEnd and localize("活动已结束") or localize("秒杀开启：_num_", {_num_ = CfUtils.GetTimeHMS9(seconds)}) 
end

function ActivityLimitFlashSalePanel:FreshStock(num)
    self.TextNumber.text = num
end

--endregion 


--region get/set 

---GetPriceInfo
---@param data FlashSaleDataDojo
function ActivityLimitFlashSalePanel:GetPriceInfo(data)
    local isExchange = data:IsGoodExchange()
    local priceText, imgPath
    if isExchange then
        local prices = data.prices
        priceText = prices.priceNum
        local currency = checkNumber(prices.goodsId) == 0 and Constants.Currency.FreeDiamondId or prices.goodsId
        ---@type GoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(currency)
        imgPath = goodsVo.photoPath
    else
        local windowsPriceId = CfUtils.GetWindowsPriceId(data)
        priceText  = localize('<size=30>_YUAN_</size>_num_',{_num_= CfUtils.GetPrice(windowsPriceId, data.channelProductId), _YUAN_ = CfUtils.GetCurrerySymbol()})
    end

    return priceText, imgPath

end

---endregion 


--region handler 


function ActivityLimitFlashSalePanel:OnClickBtnExplainAction()
    -- self._activityDojo
    local luckyNumConf = self._provider:GetHomeData().luckyNumConf
    local ruleId       = luckyNumConf.ruleId
    if checkNumber(ruleId) > 0 then
        CfUtils.ShowModuleToast(ruleId)
    end
    
end

function ActivityLimitFlashSalePanel:OnClickBtnExchangeAction()
    if self._provider:CheckIsActivityClosed() then
        return
    end
    
    local activityType = self._activityDojo.type
    CfUtils.DialogOpen(Constants.UITypeIds.ActivityLimitFlashSaleExchangePopup, {activityType = activityType})
end

function ActivityLimitFlashSalePanel:OnClickBtnNoneAction()
    if not self._provider:CheckIsActivityEnabled() then
        return
    end
    -- local homeData = self._provider:GetHomeData()
    -- local isOwnTimes = homeData.buyLimit > 0
    -- local toastText = isOwnTimes and localize("无次数") or localize("无库存")
    GameUtils.Toast(self.BtnNoneTxtBuy.text)
end

function ActivityLimitFlashSalePanel:OnClickBtnCostAction()
    if not self._provider:CheckIsActivityEnabled() then
        return
    end

    ---@type FlashSaleDataDojo
    local homeData = self._provider:GetHomeData()
    local isExchange = homeData:IsGoodExchange()

    if isExchange then
        self:HandlerGoodsExchange(homeData)
        return
    end

    -- if true then
    --     local homeData = self._provider:GetHomeData()
    --     local data = {
    --         productId = homeData.productId,
    --         channelProductId = homeData.channelProductId,
    --         channelProducts = homeData.channelProducts,
    --         price = homeData.price
    --     }

    --     CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = {{goodsId = Constants.Currency.MidFestivalStamina, num = 1}} } })
    --     Events.Broadcast(Constants.EventNames.EVENT_SDK, { event = Constants.EventNames.EVENT_SDK_PAY, data = data, productId = homeData.productId })

    --     Events.Broadcast(Constants.EventNames.ActivityDialogRefresh)
    --     return
    -- end

    SDKService:GetInstance():PayMoney({
        productId = homeData.productId,
        channelProductId = homeData.channelProductId,
        channelProducts = homeData.channelProducts,
        productDesc = localize('超值礼包'),
        payAmount = checkNumber(homeData.price),
        windowsPriceId = checkNumber(homeData.windowsPriceId),
        data = {
            productId = homeData.productId,
            channelProductId = homeData.channelProductId,
            windowsPriceId = homeData.windowsPriceId,
            channelProducts = homeData.channelProducts,
            price = homeData.price
        }
    })
end

---HandlerGoodsExchange
---@param homeData FlashSaleDataDojo
function ActivityLimitFlashSalePanel:HandlerGoodsExchange(homeData)
    ---@type ServerDifferenceMgr
    local ServerDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()
    
    local prices = homeData.prices
    local currency = checkNumber(prices.goodsId) == 0 and Constants.Currency.FreeDiamondId or checkNumber(prices.goodsId)
    local priceNum = prices.priceNum
    ServerDifferenceMgr:WrapPrimaryCurrencyBuy({
        currency = checkNumber(currency),
        current = checkNumber(priceNum),
    }, function(isSuccess)
        isSuccess = checkBool(isSuccess)
        if not isSuccess then
            return
        end
        ----请求兑换的逻辑
        GameUtils.Request(Interfaces.ActivityLuckyNumBuyProduct,{
            activityUuid = self._activityDojo.id,
            productId  = homeData.productId,
            currency = currency,
            num = priceNum,
        }, function(request,response)
            if checkInt(response.errCode) == 0 then
                local oneRewards = response.data.rewards  or {}
                local rewards = clone(oneRewards)
                rewards[#rewards+1] = {
                    goodsId = currency ,
                    num = -priceNum,
                    productId = checkNumber(homeData.productId),
                }
                GoodsUtils.DrawRewards(rewards)
                self:OnEventFreshHome()
                if #oneRewards > 0 then
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = oneRewards} )
                end
            end
        end )
    end)

end

function ActivityLimitFlashSalePanel:OnClickBtnLockAction()
    if not self._provider:CheckIsActivityEnabled() then
        return
    end
    local homeData = self._provider:GetHomeData()
    local curTime   = os.time()
    if (curTime - homeData.countDown) < 0 then
        GameUtils.Toast(localize("活动暂未开启"))
    end
end

function ActivityLimitFlashSalePanel:OnEventSdkEvent(parameters)
    if parameters.event == Constants.EventNames.EVENT_SDK_PAY then
        self:RequestAndFreshUI(self._activityDojo)
    end
end

function ActivityLimitFlashSalePanel:OnEventFreshHome()
    self:RequestAndFreshUI(self._activityDojo)
    
end

---endregion 


return ActivityLimitFlashSalePanel
