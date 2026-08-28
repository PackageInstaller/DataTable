--- 养成-羁绊界面

------------ import ------------
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------
local isNotNull = isNotNull
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIllustratedHandbookAndFetter.prefab
---@class CardProgressionSynergies
---@field Env                           	CardProgressionSynergies                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field FetterNode                    	UnityEngine.RectTransform               
---@field MainHeadNode                  	UnityEngine.RectTransform               
local CardProgressionSynergies = Class('CardProgressionSynergies')

function CardProgressionSynergies:__init()
    self._isInitialize = false
end

function CardProgressionSynergies:__delete()

end

function CardProgressionSynergies:Awake()
    ---@type CardComponent
    self._cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
end

function CardProgressionSynergies:Start()
end

function CardProgressionSynergies:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

-- function CardProgressionSynergies:OnInitialize()
--     if self._isInitialize then return end
--     self._isInitialize = false

-- end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionSynergies:FreshUI(cardId)
    self._cardId = cardId
    self:FreshHeadNode(self.MainHeadNode, cardId)
    local synergiesCardIds = cardConfMgr:GetRoleCardSynergies(cardId) or {}
    self:FreshSynergiesCards(synergiesCardIds)

    ---@type CardProgressionControllerRole
    local controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    controllerEnv:FreshCameraState(CardProgressionConstants.CameraState.CultivateRoleFull, false)

end

function CardProgressionSynergies:FreshHeadNode(node, cardId, vo)
    ---@type CardProgressionSynergiesHeadNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionSynergiesHeadNode)
    if isNull(env) then return end
    
    env:FreshUI(cardId, cardId ~= nil and self._cardComp:GetIdByCardId(cardId) ~= nil, vo)
end

function CardProgressionSynergies:FreshEffect(effect, cardId)
    if isNull(effect) then
        return
    end
    local isUnLock = cardId ~= nil and self._cardComp:GetIdByCardId(cardId) ~= nil
    KTool.SetActive(effect.gameObject, isUnLock)

end

function CardProgressionSynergies:FreshSynergiesCards(synergiesCardIds)
    local parent = self.FetterNode
    for i = 1, parent.childCount, 1 do
        local child = parent:GetChild(i - 1)
        local voId = synergiesCardIds[i]
        local cardId, vo
        if voId then
            ---@type RoleCardSynergiesVo
            vo = cardConfMgr:GetRoleCardSynergiesVo(voId)
            cardId = vo.relationCard
        end
        
        local effect = child:Find(string.format("UIFX_line%s", i))
        local headNode = child:Find("FetterHeadNode")
        self:FreshHeadNode(headNode, cardId, vo)
        self:FreshEffect(effect, cardId)
        -- KTool.SetActive(node.gameObject, true)
    end
end

--- OnEnter
--- 进入时调用
function CardProgressionSynergies:OnEnter()
    
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionSynergies:OnLeave()
    
    
end


---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionSynergies
