
------------ import ------------
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants     = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFeelingRewardTips.prefab
---@class CardProgressionFavorRewardTips
---@field Env                           	CardProgressionFavorRewardTips
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field DescNode                      	UnityEngine.RectTransform
---@field Arrow                         	UnityEngine.RectTransform
---@field Bg                            	UnityEngine.RectTransform
local CardProgressionFavorRewardTips = Class('CardProgressionFavorRewardTips', CommonTipsBoard)

function CardProgressionFavorRewardTips:__init()
    CommonTipsBoard.__init(self)

end


function CardProgressionFavorRewardTips:__delete()
    CommonTipsBoard.__delete(self)

end


function CardProgressionFavorRewardTips:Awake()
    KTool.SetActive(self.DescNode.gameObject, false)
    CommonTipsBoard.Awake(self)
end


function CardProgressionFavorRewardTips:Start()
    CommonTipsBoard.Start(self)
end


function CardProgressionFavorRewardTips:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param data table{
---@    vo: FavorableExpRewardVo
---@    expData: table {exp, totalExp}
---@}
function CardProgressionFavorRewardTips:FreshUI(data, cardId)
    local t      = CardProgressionUtils.CollectFavorLevelRewards(data, cardId)
    local parent = self.Bg.gameObject
    local child  = self.DescNode.gameObject 

    for i, v in ipairs(t) do
        local node = parent:AddChild(child)
        KTool.SetActive(node, true)
        ---@type CardProgressionFavorRewardTipsDescNode
        local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFavorRewardTipsDescNode)
        if not isNull(env) then
            env:FreshUI(v)
        end
    end
    
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionFavorRewardTips:GetPhotoPathById(goodsId)
    ---@type GoodsVo
    local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
    return goodsVo.photoPath, goodsVo
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFavorRewardTips
