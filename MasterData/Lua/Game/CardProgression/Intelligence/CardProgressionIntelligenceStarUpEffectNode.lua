
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region import
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIntelligence.prefab > name: StarupEffect1
---@class CardProgressionIntelligenceStarUpEffectNode
---@field Env                           	CardProgressionIntelligenceStarUpEffectNode
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field StatusLockTextDesc            	CustomText                              
---@field StatusLock                    	UnityEngine.CanvasGroup               
---@field ImgBgLock                     	UnityEngine.RectTransform               
---@field TextDesc                      	CustomText                              
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field CanvasGroup                   	UnityEngine.RectTransform                 
local CardProgressionIntelligenceStarUpEffectNode = Class('CardProgressionIntelligenceStarUpEffectNode')

function CardProgressionIntelligenceStarUpEffectNode:__init()
    self._cardId = nil
    self._star   = nil
end


function CardProgressionIntelligenceStarUpEffectNode:__delete()

end

function CardProgressionIntelligenceStarUpEffectNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param cardId number
---@param star number
---@param vo CardStarVo
function CardProgressionIntelligenceStarUpEffectNode:FreshUI(cardId, star, vo)
    local isChange = cardId ~= self._cardId or self._star ~= star
    if not isChange then return end
    
    self._cardId = cardId
    self._star   = star
    
    local isUnlock = star >= vo.star
    
    KTool.SetActive(self.ImgBgLock.gameObject, not isUnlock)
    KTool.SetActive(self.StatusLock.gameObject, not isUnlock)

    --- 角色天赋表id
    local talentId   = vo.initOpenAbility
    if talentId > 0 then
        local desc, _, realVo = CardProgressionSkillUtils.GetCardTalentDescById(talentId)
        self.TextDesc.text = desc
        self.ImgIcon:LoadSprite(realVo.iconPath)
    end
    if not isUnlock then
        self.StatusLockTextDesc.text = localize("_num_星解锁", {_num_ = vo.star})
    end

end

--endregion 


--region get/set 

function CardProgressionIntelligenceStarUpEffectNode:SetActive(isShow)
    CfUtils.SetActive(self.controller.gameObject, isShow)
end

---endregion 


--region handler 


---endregion 


return CardProgressionIntelligenceStarUpEffectNode
