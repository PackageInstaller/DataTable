---
--- Created by Eric.
--- DateTime: 2021/11/4 16:44
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local TimeZoneUtils = CS.Engine.Http.TimeZoneUtils

------------ import ------------

------------ define ------------
local SwitchTextStatus = {
    Limit = 1,
    TodayLimit = 2,
}
------------ define ------------


---@class BeginnerGiftBagCell
---@field ImgBg                         	Game.Native.Common.UISwitchImage
---@field ImgInk                         	UnityEngine.RectTransform
---@field TextTitle                     	UnityEngine.UI.Text
---@field ImgIcon                       	UnityEngine.RectTransform
---@field Text1                         	Game.Native.Common.UISwitchText
---@field Text2                         	TMPro.TextMeshProUGUI
---@field Discount                      	UnityEngine.RectTransform
---@field Text                          	TMPro.TextMeshProUGUI
---@field Price                         	UnityEngine.RectTransform
---@field TextNumberConsume             	TMPro.TextMeshProUGUI
---@field ImgIconCosume                 	Engine.UI.RawImageAlterable
---@field SoldOut                       	UnityEngine.RectTransform
---@field Free                          	UnityEngine.RectTransform

local BeginnerGiftBagCell = Class("BeginnerGiftBagCell")
function BeginnerGiftBagCell:__init()
    self.btnAction = nil

end

function BeginnerGiftBagCell:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置购买回调函数
function BeginnerGiftBagCell:SetBtnCallBackBuy(cb)
    self.btnAction = cb
end

function BeginnerGiftBagCell:GetCellDt()
    return checkTable(self.cellDt)
end

function BeginnerGiftBagCell:IsFree()
    if self:GetGiftType() == 2 then
        return false
    end
    local consume = self:GetCellDt().consume or {}
    return checkInt(consume.consumeNum) == 0
end
function BeginnerGiftBagCell:GetConsumeId()
    local consume = self:GetCellDt().consume or {}
    return checkInt(consume.consumeId)

end

function BeginnerGiftBagCell:GetPrice()
    local price = self:GetCellDt().price
    return price
end

function BeginnerGiftBagCell:GetGiftType()
   return  checkInt(self:GetCellDt().giftType)
end
function BeginnerGiftBagCell:GetConsumeNum()
    local consume = self:GetCellDt().consume or {}
    return checkInt(consume.consumeNum)
end
function BeginnerGiftBagCell:IsHasStock()
    return checkInt(self:GetCellDt().currentStock) > 0
end

function BeginnerGiftBagCell:GetShowItem()
    return checkInt(self:GetCellDt().showId)
end

function BeginnerGiftBagCell:Awake()
    SetButtonAction(self.controller.gameObject, function ()
        xRecord.record(string.format('9-01%d',checkInt(self:GetCellDt().id) - 1))
        if self:IsFree() and self:IsHasStock() then
            self:ConfirmPurchase(self:GetCellDt())
        elseif self:GetGiftType() == 2 then
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            local serverTime      = playerComponent.playerDojo.serverTime
            local nowTime         = checkInt(TimeZoneUtils.UtcSeconds)
            local pastTime        = nowTime - serverTime
            local refreshTime     = playerComponent.playerDojo.dailyRefreshTime - pastTime
            local endTime         = playerComponent.playerDojo.rookieOpened - pastTime
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
                goodsId        = self:GetShowItem(),
                consumeGoodsId = self:GetConsumeId(),
                consumeNum     = self:GetPrice(),
                isPayMoney     = self:GetGiftType() == 2,
                channelProductId = self:GetCellDt().channelProductId,
                maxBuyNum      =  self:GetCellDt().currentStock,
                buyCb          = Bind(self, self.ConfirmPurchase),
                rewards        = self:GetCellDt().rewards,
                --remainTime     = self:GetGiftType()  <= 1 and refreshTime or 0 ,
                --endTime        = endTime,
            }})
        else
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            local serverTime      = playerComponent.playerDojo.serverTime
            local nowTime         = checkInt(TimeZoneUtils.UtcSeconds)
            local pastTime        = nowTime - serverTime
            local refreshTime     = playerComponent.playerDojo.dailyRefreshTime - pastTime
            local endTime         = playerComponent.playerDojo.rookieOpened - pastTime
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
                goodsId        = self:GetShowItem(),
                consumeGoodsId = self:GetConsumeId(),
                consumeNum     = self:GetPrice(),
                isPayMoney     = self:GetGiftType() == 2,
                channelProductId = self:GetCellDt().channelProductId,
                maxBuyNum      =  self:GetCellDt().currentStock,
                buyCb          = Bind(self, self.ConfirmPurchase),
                rewards        = self:GetCellDt().rewards,
                remainTime     = self:GetGiftType()  <= 1 and refreshTime or 0 ,
                endTime        = endTime,
            }})
        end
    end)
end

function BeginnerGiftBagCell:FreshBaseUI(data)
    self.cellDt       = checkTable(data)
    local isFree      = self:IsFree()
    local hasStock    = self:IsHasStock()
    local giftData    = GoodsConfMgr:GetGoodsVoById(self:GetShowItem())
    local hasDiscount = data.iconTitle ~= ""

    CfUtils.FillText(self.TextTitle, giftData.name)
    self.Text1.Status   = isFree and SwitchTextStatus.TodayLimit or SwitchTextStatus.Limit
    CfUtils.FillText(self.Text2, string.format("%s/%s", data.currentStock, data.stock))

    KTool.SetActive(self.Price, hasStock and (not isFree))
    KTool.SetActive(self.SoldOut, not hasStock)
    if isFree then
        local redPoint = self.controller.transform:Find("redPoint")
        if hasStock then 
            if isNotNull(redPoint) then
                KTool.SetActive(redPoint , true)
            end
        else 
            if isNotNull(redPoint) then
                KTool.SetActive(redPoint , false)
            end 
        end
    end
   



    KTool.SetActive(self.Free, hasStock and isFree)
    KTool.SetActive(self.Discount, hasDiscount)

    CfUtils.SetUISwitchImage(self.ImgBg, isFree and 2 or 1)
    CfUtils.SetUISwitchImage(self.ImgInk, isFree and 2 or 1)

    self.controller.transform:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = hasStock and 1 or 0.8
    if hasDiscount then
        self.Text.text =   checkInt( tonumber(data.iconTitle) * 100  )
        local Text2 =  self.Text.transform.parent:Find("Text2")
        if isNotNull(Text2) then
            CfUtils.FillText(Text2, "%")
        end
    end
    if hasStock and not isFree then
        if self:GetGiftType() == 2 then
            self.TextNumberConsume.text = CfUtils.GetDisplayPrice(self:GetPrice(), self:GetCellDt().channelProductId) 
            local consumeId = self:GetConsumeId()
            if consumeId > 0 then
                local currencyData = GoodsConfMgr:GetGoodsVoById(consumeId)
                self.ImgIconCosume:LoadSprite(currencyData.photoPath)
            else
                KTool.SetActive(self.ImgIconCosume , false)
            end
        end
    end

    if self.Icon then
        CS.UnityEngine.GameObject.Destroy(self.Icon)
    end
    local iconPath = string.format("Prefabs/BeginnerEvent/BeginnerEventGiftBagNode%s.prefab", self:GetCellDt().id)
    self.Icon = GameUtils.LoadBundleSync(iconPath, self.ImgIcon.gameObject)
    
    local iconAnimator = KTool.GetComponent(self.Icon, typeof(CS.UnityEngine.Animator))
    if iconAnimator then
        CfUtils.PlayAnimator(iconAnimator, not hasStock and "Default" or "Go")
    end

end

function BeginnerGiftBagCell:ConfirmPurchase()
    local purchaseType =  checkInt(self:GetGiftType())
    if purchaseType == 1 then
        GameUtils.Request(
                Interfaces.RookieBuyGiftBag,
                { giftId = self:GetCellDt().productId},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        local data = response.data
                        local consumeId = self:GetConsumeId()
                        local consumeNum = self:GetConsumeNum()
                        if consumeId  > 0 then
                            GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}})
                        end
                        GoodsUtils.DrawRewards(data.rewards)
                        UIModule.OpenDialog(
                                {
                                    id = Constants.UITypeIds.UICommonRewardPop,
                                    parameters = { rewards = data.rewards }
                                }
                        )
                        if type(self.btnAction) == 'function' then--购买成功的回调
                            self.btnAction()
                        end
                    end
                end
        )
    elseif purchaseType == 2 then
        local giftData    = GoodsConfMgr:GetGoodsVoById(self:GetShowItem())
            ---@type SDKService
            local SDKService = import('Game.Entry.SDKService')
            ---  调用sdk支付
            SDKService:GetInstance():PayMoney({
                productId        = self:GetCellDt().productId,
                channelProductId = self:GetCellDt().channelProductId,
                payAmount        = self:GetCellDt().price,
                productDesc      = giftData.name
            })
    end
end

function BeginnerGiftBagCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return BeginnerGiftBagCell