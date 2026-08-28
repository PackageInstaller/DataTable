---
--- Created by gaole.
--- DateTime: 2020-04-28 15:10
---
--[[
    迷宫商店出售商品信息展示
--]]
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local KTool = CS.Engine.Lib.KTool
local ID = CS.Game.Native.Common.ID
local UIEventProxy = CS.Engine.UI.UIEventProxy
local ImageAlterable = CS.Engine.UI.ImageAlterable
local StarProgressNode = CS.StarProgressNode
local PrefabType = CS.Game.Native.Common.PrefabType
local GoodsConfMgr = GoodsConfMgr:GetInstance()
          
---@class CommonShopGoodDesNode
---@field btnBuy                        	UnityEngine.UI.Button                   
---@field buyNum                        	UnityEngine.UI.Text                     
---@field consumeItem2                  	UnityEngine.UI.Image                    
---@field price                         	UnityEngine.UI.Text                     
---@field cfText                        	UnityEngine.UI.Text                     
---@field desc                          	UnityEngine.UI.Text                     
---@field name                          	UnityEngine.UI.Text                     
---@field item                          	UnityEngine.RectTransform               
local CommonShopGoodDesNode = Class('CommonShopGoodDesNode')

function CommonShopGoodDesNode:__init()
    self._itemLoader = nil
end

function CommonShopGoodDesNode:__delete()
    self._itemLoader = nil
end

---SetCallBack
---设置单击回调函数
---
---@param cb fun():void
function CommonShopGoodDesNode:SetCallBack(cb)
    self.__callback = cb
end

function CommonShopGoodDesNode:Awake()
    self.controller.ClearCache = false
end

--[[
    @desc: 刷新
    author:{author}
    time:2020-04-28 16:09:25
    --@good: 迷宫商品
    --@currencyId: 货币id
    @return:
]]
function CommonShopGoodDesNode:RefeshSelf(good, currencyId, idAreaType)
    --good.goodsId = "300007"
    local item = GoodsConfMgr:GetGoodsVoById(good.goodsId)
    CfUtils.FillText(self.name, item.name)
    CfUtils.FillText(self.desc, item.desc)

    CfUtils.FillText(self.price, good.price)
    CfUtils.FillText(self.cfText, localize("小计"))
    CfUtils.FillText(self.buyNum, "x"..good.num)

    if not self._itemLoader then
        self._itemLoader = CS.Engine.Modules.ResourceModule.LoadBundleSync("Prefabs/Common/GoodNode.prefab", nil, true)
    end
    if self._itemLoader.IsSuccess then
        local go = self.item.transform:Find("item")
        if not go then 
            go = CfUtils.InstantiateGo(self._itemLoader.ResultObject, self.item)
            go.name = "item"
        end
        if go then
            CfUtils.RefeshGoodGo(go, good.goodsId, good.num, 0.9, idAreaType)
        end
    end

    local currency = GoodsConfMgr:GetGoodsVoById(currencyId)
    CfUtils.FillImage(self.consumeItem1, currency.photoPath)

    CfUtils.FillText(self.btnBuy.transform:Find("Text"), "购买")
end

function CommonShopGoodDesNode:OnDestroy()
    if not isNull(self._itemLoader) then
        self._itemLoader:Release()
        self._itemLoader = nil
    end
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return CommonShopGoodDesNode