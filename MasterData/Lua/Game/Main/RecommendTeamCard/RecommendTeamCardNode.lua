--- from: Assets/BundleResources/Prefabs/RecommendTeam/RecommendTeamCardNode.prefab > name: RecommendTeamCardNode
---@class RecommendTeamCardNode
---@field Env                           	RecommendTeamCardNode                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field OwnerImgBg                    	UnityEngine.RectTransform               	@ 0    
---@field CommonHeadItemNode            	UnityEngine.RectTransform               	@ 1    
---@field OwnerText                     	UnityEngine.RectTransform               	@ 2    
---@field CardTextDesc                  	UnityEngine.RectTransform               	@ 3    
---@field TextDesc_2                    	UnityEngine.RectTransform               	@ 4    
---@field AttrTextDesc                  	UnityEngine.RectTransform               	@ 5    
local RecommendTeamCardNode = Class('RecommendTeamCardNode')


function RecommendTeamCardNode:__init()

end


function RecommendTeamCardNode:__delete()

end


function RecommendTeamCardNode:Awake()

end
---@param vo RecommendTeamCardVo
function RecommendTeamCardNode:Refresh(vo)
    local cardId = vo.cardid
    local CardHeadNode = "Game.Behaviours.CardHeadNode"
    local scr = CfUtils.GetLuaScr(self.CommonHeadItemNode, CardHeadNode)
    local cardComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CardComponent)
    local hasCard = cardComponent:IsHasCard(cardId)
    if hasCard then
        local cardDojo = cardComponent:GetCardByConfId(cardId)
        scr:FreshNode(cardDojo, true, 1)
    else
        scr:FreshNodeByCardVo(cardId, 1, false)
    end
    scr:SetCallBack(function()
        if hasCard then
            ---@type CardProgressionUtils
            local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
            local id = cardComponent:GetIdByCardId(cardId)
            CardProgressionUtils.OpenDialog(Constants.UITypeIds.CultivateMain, {playerCardId = id}, UICommonUtils.GetShowDialogArguments())
        else
            local gachaponUtils = import('Game.Gachapon.GachaponUtils')
            gachaponUtils.OpenDetail(cardId, UICommonUtils.GetShowDialogArguments())
        end
    end )
   

    CfUtils.SetUISwitchText(self.OwnerText, hasCard and 2 or 1)
    CfUtils.SetUISwitchImage(self.OwnerImgBg, hasCard and 2 or 1)
    CfUtils.FillText(self.AttrTextDesc , vo.desc)
    CfUtils.FillText(self.TextDesc_2 , vo.access)
end


function RecommendTeamCardNode:Start()
end


function RecommendTeamCardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return RecommendTeamCardNode
