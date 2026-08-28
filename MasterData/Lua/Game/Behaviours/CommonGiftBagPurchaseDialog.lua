---
--- Created by Eric.
--- DateTime: 2021/11/5 10:38
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local Gradient2 = CS.UnityEngine.UI.Extensions.Gradient2
local Image = CS.UnityEngine.UI.Image
local XLuaUtils    = CS.Engine.Lib.XLuaUtils

------------ import ------------

------------ define ------------

------------ define ------------


---@class CommonGiftBagPurchaseDialog
---@field Text                          	TMPro.TextMeshProUGUI
---@field Discount                      	UnityEngine.RectTransform
---@field BGClose                       	UnityEngine.RectTransform
---@field BtnClose                      	UnityEngine.UI.Button
---@field Imgicon                       	Engine.UI.ImageAlterable
---@field TxtNumber                     	TMPro.TextMeshProUGUI
---@field ButtonItem                    	UnityEngine.UI.Button
---@field LayoutGood                    	SuperScrollView.LoopGridView
---@field Imgtime                       	UnityEngine.RectTransform
---@field GoodIcon                      	Engine.UI.ImageAlterable
---@field TxtName                       	UnityEngine.UI.Text
local CommonGiftBagPurchaseDialog = Class("CommonGiftBagPurchaseDialog")
function CommonGiftBagPurchaseDialog:__init()

end

function CommonGiftBagPurchaseDialog:__delete()
    self.controller = nil
end

function CommonGiftBagPurchaseDialog:Awake()
    SetButtonAction(self.BtnClose.gameObject, function()
        self.controller:Close()
    end)
    UIEventProxy.Create(self.BGClose.gameObject).onPointerClick = function()
        self.controller:Close()
    end
    --SetButtonAction(self.controller.gameObject, function()
    --    self.controller:Close()
    --end)
end

function CommonGiftBagPurchaseDialog:OnFocus(focus)
end

function CommonGiftBagPurchaseDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        if not isNull(argument.parameters) then
            self.data = argument.parameters.data
            self.purchaseCB = argument.parameters.purchaseCB

        end
    end))
    return coWait
end

function CommonGiftBagPurchaseDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self:FreshBaseUI()

    end))
    return coWait
end

function CommonGiftBagPurchaseDialog:FreshBaseUI()
    if isNull(self.data) then
        return
    end
    local giftData = GoodsConfMgr:GetGoodsVoById(self.data.showItem)
    local currencyData = GoodsConfMgr:GetGoodsVoById(self.data.consumeId)
    local hasStock = checkNumber(self.data.currentStock) > 0 --拥有库存
    self.TxtName.text = giftData.name
    self.GoodIcon:LoadSprite(giftData.photoPath)
    if not hasStock then
        KTool.SetActive(self.TxtNumber.transform, false)
        self.ButtonItem.transform.gameObject:EnsureComponent(typeof(Gradient2)).enabled = false
        CfUtils.FillText(self.ButtonItem.transform:Find("TxtBuy"), "已售空")
        self.ButtonItem.transform.gameObject:EnsureComponent(typeof(Image)).color = XLuaUtils.HexToColor('#A9A9A9')
    else
        self.TxtNumber.text = self.data.consumeNum
        self.Imgicon:LoadSprite(currencyData.photoPath)
    end
    if not self.LayoutGood.IsListViewInit then
        self.LayoutGood:InitGridView(#self.data.rewards, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.LayoutGood, #self.data.rewards)
    end
    local hasDiscount = self.data.iconTitle ~= ""
    KTool.SetActive(self.Discount, hasDiscount)
    if hasDiscount then
        self.Text.text = self.data.iconTitle
    end

    SetButtonAction(self.ButtonItem.gameObject, function()
        if hasStock then
            local haveDiamondNum = GoodsUtils.GetThingNo(self.data.consumeId)
            if haveDiamondNum >= self.data.consumeNum then
                GameUtils.SecondConfirm
                (
                        localize("确认花费_Num__Name_购买_Name1_？",{_Num_ = self.data.consumeNum, _Name_ = currencyData.name, _Name1_ = giftData.name}),
                        function()
                            if type(self.purchaseCB) == "function" then
                                self.purchaseCB()
                            end
                            if self.controller == nil then
                                return
                            end
                            self.controller:Close()
                        end
                )
            else
                local StoreUtils = import('Game.UI.Store.StoreUtils')
                StoreUtils.OpenRechargePopUp(self.data.consumeNum - haveDiamondNum)
            end
        else
            GameUtils.Toast(localize("商品已售完"))
        end
    end)
end

function CommonGiftBagPurchaseDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("GoodNode")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.Behaviours.GoodNodeMB")
    if nodeEnv then
        local luaIndex = index + 1
        local data = self.data.rewards[luaIndex]
        nodeEnv:SetClickButtonAction(function()
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.goodsId)
            if isTable(vo) then
                GameUtils.ShowCommonTipsBoard(cell, vo.name, vo.desc, vo.quality, vo.id)
            end
        end)
        nodeEnv:Reload(
                {
                    goodsId = data.goodsId,
                    isShowNo = true, text = 'x' .. tostring(data.num)
                }
        )
    end
    return cell
end

function CommonGiftBagPurchaseDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return CommonGiftBagPurchaseDialog