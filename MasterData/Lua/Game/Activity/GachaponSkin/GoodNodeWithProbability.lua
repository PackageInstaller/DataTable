--- from: Assets/BundleResources/Prefabs/GachaponSkin/GoodGroup.prefab > name: GoodGroup
---@class GoodNodeWithProbability
---@field Env                           	GoodNodeWithProbability                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field GoodNode                      	Engine.Modules.LuaBehaviour             
---@field TxtProbability                	UnityEngine.UI.Text                     
local GoodNodeWithProbability = Class("GoodNodeWithProbability")

function GoodNodeWithProbability:__init()
    self.controller = nil
end

function GoodNodeWithProbability:__delete()
    self.controller = nil
end

function GoodNodeWithProbability:Awake()
end

function GoodNodeWithProbability:RefreshData(params,probability)
    self:RefreshGoodNode(params)
    self:RefreshText(probability)
end

function GoodNodeWithProbability:RefreshText(probability)
    self.TxtProbability.text = probability.."%"
end

function GoodNodeWithProbability:RefreshGoodNode(params)
    ---@type GoodNodeMB
    local goodEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    goodEnv:Reload(params)

    goodEnv:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(params.goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(self.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
end

return GoodNodeWithProbability