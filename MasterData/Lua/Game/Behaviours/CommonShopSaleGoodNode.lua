---
--- Created by gaole.
--- DateTime: 2020-04-28 15:10
---
--[[
    迷宫商店出售打折的商品  
--]]
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local KTool = CS.Engine.Lib.KTool
local ID = CS.Game.Native.Common.ID
local UIEventProxy = CS.Engine.UI.UIEventProxy
local ImageAlterable = CS.Engine.UI.ImageAlterable
local StarProgressNode = CS.StarProgressNode
local PrefabType = CS.Game.Native.Common.PrefabType
local GoodsConfMgr = GoodsConfMgr:GetInstance()

---@class CommonShopSaleGoodNode
---@field btn                           	UnityEngine.UI.Button                   
---@field currency                      	Engine.UI.ImageAlterable                
---@field price                         	UnityEngine.UI.Text                     
---@field item                          	UnityEngine.RectTransform               
---@field name                          	UnityEngine.UI.Text                     
local CommonShopSaleGoodNode = Class('CommonShopSaleGoodNode')

function CommonShopSaleGoodNode:__init()
    self._itemLoader = nil
end

function CommonShopSaleGoodNode:__delete()
    self._itemLoader = nil
end

function CommonShopSaleGoodNode:Awake()
    self.controller.ClearCache = false
end

--[[
    @desc: 刷新
    author:{author}
    time:2020-04-28 16:09:25
    --@goodInfo: 迷宫商品服务器数据 商品id和剩余数量
    @return:
]]
function CommonShopSaleGoodNode:RefeshSelf(goodInfo, idAreaType)
    local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting363, "MazeGoodsVo", goodInfo.id)
    if not mazeGoodVo then return end

    local goodVo = GoodsConfMgr:GetInstance():GetGoodsVoById(mazeGoodVo.itemId)
    if goodVo then
        CfUtils.FillText(self.name, goodVo.name)
    end

    CfUtils.FillText(self.oldPriceText, mazeGoodVo.oldPrice)
    CfUtils.FillText(self.newPrice, mazeGoodVo.newPrice)
    
    CfUtils.FillText(self.cfText, localize("超值折扣!"))

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
            CfUtils.RefeshGoodGo(go, mazeGoodVo.itemId, nil, 0.9, idAreaType)
        end
    end

    local currency = GoodsConfMgr:GetGoodsVoById(mazeGoodVo.goodsConsum)
    if currency then
        CfUtils.FillImage(self.consumeItem1, currency.photoPath)
        CfUtils.FillImage(self.consumeItem2, currency.photoPath)
    end
end

function CommonShopSaleGoodNode:OnDestroy()
    if not isNull(self._itemLoader) then
        self._itemLoader:Release()
        self._itemLoader = nil
    end
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return CommonShopSaleGoodNode