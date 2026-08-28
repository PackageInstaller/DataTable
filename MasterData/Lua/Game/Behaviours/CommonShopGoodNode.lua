---
--- Created by gaole.
--- DateTime: 2020-04-28 15:10
---
--[[
    迷宫商店出售的商品
--]]
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local KTool = CS.Engine.Lib.KTool
local ID = CS.Game.Native.Common.ID
local UIEventProxy = CS.Engine.UI.UIEventProxy
local ImageAlterable = CS.Engine.UI.ImageAlterable
local StarProgressNode = CS.StarProgressNode
local PrefabType = CS.Game.Native.Common.PrefabType
local GoodsConfMgr = GoodsConfMgr:GetInstance()

---@class CommonShopGoodNode
---@field btn                           	UnityEngine.UI.Button                   
---@field currency                      	Engine.UI.ImageAlterable                
---@field price                         	UnityEngine.UI.Text                     
---@field item                          	UnityEngine.RectTransform               
---@field name                          	UnityEngine.UI.Text                     
local CommonShopGoodNode = Class('CommonShopGoodNode')

function CommonShopGoodNode:__init()
    self._itemLoader = nil
end

function CommonShopGoodNode:__delete()
    self._itemLoader = nil
end

function CommonShopGoodNode:Awake()
    self.controller.ClearCache = false
end

--[[
    @desc: 刷新
    author:{author}
    time:2020-04-28 16:09:25
    --@goodInfo: 迷宫商品
    @return:
]]
function CommonShopGoodNode:RefeshSelf(goodInfo, idAreaType)
    local mazeGoodVo = CfUtils.GetCfVo(AutoIds.IdSetting364, "MazeGoodsVo", goodInfo.id)
    if not mazeGoodVo then return end

    CfUtils.FillText(self.name, mazeGoodVo.name)

    CfUtils.FillText(self.price, mazeGoodVo.newPrice)

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
            CfUtils.RefeshGoodGo(go, mazeGoodVo.itemId, goodInfo.num, 0.7, idAreaType)
        end
    end

    local currency = GoodsConfMgr:GetGoodsVoById(mazeGoodVo.goodsConsum)
    if currency then 
        CfUtils.FillImage(self.currency, currency.photoPath)
    end
end

function CommonShopGoodNode:OnDestroy()
    if not isNull(self._itemLoader) then
        self._itemLoader:Release()
        self._itemLoader = nil
    end
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return CommonShopGoodNode