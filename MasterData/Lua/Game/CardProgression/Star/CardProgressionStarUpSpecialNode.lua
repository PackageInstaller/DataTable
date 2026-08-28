
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local CfUtils   = CfUtils
--endregion

--region import
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define

local Status = {
    Unlock           = 1,
    -- NextStarPreview  = 2,
    Preview          = 2,
    Lock             = 3,
}

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/BtnStarupSpecialNode.prefab > name: BtnStarupSpecialNode
---@class CardProgressionStarUpSpecialNode
---@field Env                           	CardProgressionStarUpSpecialNode        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFX_Select                   	UnityEngine.RectTransform               
---@field UIFX_SpecialStar              	UnityEngine.RectTransform               
---@field Lock                          	UnityEngine.RectTransform               
---@field ImgStar2                      	UnityEngine.RectTransform               
---@field Normal                        	UnityEngine.RectTransform               
---@field StarNode                      	UnityEngine.Animation               
local CardProgressionStarUpSpecialNode = Class('CardProgressionStarUpSpecialNode')

function CardProgressionStarUpSpecialNode:__init()

end


function CardProgressionStarUpSpecialNode:__delete()

end


-- function CardProgressionStarUpSpecialNode:Awake()
-- end


function CardProgressionStarUpSpecialNode:Start()
    SetButtonAction(self.controller.gameObject, Bind(self, self.OnClickNodeAction))
end


function CardProgressionStarUpSpecialNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function CardProgressionStarUpSpecialNode:FreshUI(nextStar, star, isMaxStar, cardId)
    self._star = star
    local status = self:GetStarStatus(nextStar, star, isMaxStar)

    ---@type CardStarVo
    local starVo      = cardConfMgr:GetCardStarInfo(cardId, star)
    local isStarSkill = starVo.skillType == CardProgressionConstants.SkillType.Star

    -- CfUtils.SetActive(self.ImgStar,         status == Status.Lock)
    -- CfUtils.SetActive(self.ImgStar2,        status == Status.Unlock)
    CfUtils.SetActive(self.Normal,        status == Status.Unlock)
    -- CfUtils.SetActive(self.LockBg,          status == Status.Lock or status == Status.Preview)
    CfUtils.SetActive(self.Lock,            status == Status.Lock or status == Status.Preview)
    CfUtils.SetActive(self.UIFX_SpecialStar,    isStarSkill)


    local isPreview = status == Status.Preview
    if isPreview then
        CfUtils.PlayAnimation(self.StarNode, "CultivateOverseaStarNode_Upgradeable")
    else
        CfUtils.PlayAnimation(self.StarNode, "CultivateOverseaStarNode_Default")
    end

end

function CardProgressionStarUpSpecialNode:FreshSelectState(isSelect)
    CfUtils.SetActive(self.UIFX_Select,    isSelect)
end

--endregion 


--region get/set 

function CardProgressionStarUpSpecialNode:GetStarStatus(nextStar, star, isMaxStar)
    local status
    if isMaxStar then
        status = Status.Unlock
    elseif star == nextStar then
        status = Status.Preview
    elseif star > nextStar then
        status = Status.Lock
    else
        status = Status.Unlock
    end

    return status

end

function CardProgressionStarUpSpecialNode:SetCallback(callback)
    self._callback = callback
end

---endregion 


--region handler 

function CardProgressionStarUpSpecialNode:OnClickNodeAction()
    if self._callback then
        self._callback(self._star)
    end
end

---endregion 


return CardProgressionStarUpSpecialNode
