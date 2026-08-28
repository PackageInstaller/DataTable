--- 养成-羁绊界面

------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type UIBattlingTools
local UIBattlingTools = import("Game.UI.UIBattling.UIBattlingTools")
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFetterPopupTips.prefab
---@class CardProgressionSynergiesTips
---@field Env                           	CardProgressionSynergiesTips            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field UIFX_ConnectPanel_EffectGlow  	UnityEngine.RectTransform               
---@field Effect                        	UnityEngine.RectTransform
---@field ImgR                          	Game.Native.Common.UISwitchImage        
---@field ImgM2                         	Game.Native.Common.UISwitchImage        
---@field ImgM1                         	Game.Native.Common.UISwitchImage        
---@field ImgMEffect                    	UnityEngine.RectTransform               
---@field ImgL                          	Game.Native.Common.UISwitchImage        
---@field Root                          	UnityEngine.Animator
---@field TextDesc                      	UnityEngine.UI.Text
---@field AttributeTitleNode            	UnityEngine.RectTransform
---@field FetterHeadNode                	UnityEngine.RectTransform
---@field TextNameRole                  	UnityEngine.UI.Text
---@field TextDescBase                  	UnityEngine.UI.Text
---@field TextName                      	UnityEngine.UI.Text
local CardProgressionSynergiesTips = Class('CardProgressionSynergiesTips')


function CardProgressionSynergiesTips:__init()
end


function CardProgressionSynergiesTips:__delete()
    self.controller = nil
end


function CardProgressionSynergiesTips:Awake()
end


function CardProgressionSynergiesTips:OnFocus(focus)

end


function CardProgressionSynergiesTips:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitData()
        self:FreshUI()
    end))
    return coWait
end

function CardProgressionSynergiesTips:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._isUnlock then
            self.Root:SetTrigger(CardProgressionConstants.AnimatorHash.FetterHash)
        else
            self.Root:ResetTrigger(CardProgressionConstants.AnimatorHash.FetterHash)
        end

        if self._isUnlock then
            ---@type CardProgressionControllerRole
            local controllerEnv = self._controllerEnv
            controllerEnv:FreshCameraState(CardProgressionConstants.CameraState.CultivateRoleHalf, false)
        end
    end))
    return coWait
end

--function Card()
--    
--end

function CardProgressionSynergiesTips:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------

function CardProgressionSynergiesTips:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type RoleCardSynergiesVo
    self._vo         = parameters.vo
    self._cardId     = parameters.cardId
    self._isUnlock   = parameters.isUnlock

    ---@type CardProgressionControllerRole
    local env = CardProgressionUtils.GetRoleControllerEnv()
    self._controllerEnv = env
end

---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionSynergiesTips:FreshUI()
    self.TextName.text = self._vo.relationName

    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(self._cardId)
    self.TextNameRole.text = cardVo.name

    self:FreshHeadNode()

    self.TextDescBase.text = self._vo.desc

    local titleName, desc = CardProgressionSkillUtils.ParseSkillBuffDesc(self._vo.buff)
    self.TextDesc.text = desc
    
    local status      = self._isUnlock and 2 or 1
    self.ImgR.Status  = status
    self.ImgM1.Status = status
    self.ImgM2.Status = status
    self.ImgL.Status  = status
    --KTool.SetActive(self.Effect.gameObject, self._isUnlock)
    KTool.SetActive(self.ImgMEffect.gameObject, self._isUnlock)
    KTool.SetActive(self.UIFX_ConnectPanel_EffectGlow.gameObject, self._isUnlock)
end

function CardProgressionSynergiesTips:FreshHeadNode()
    ---@type CardProgressionSynergiesHeadNode
    local env = CfUtils.GetLuaScr(self.FetterHeadNode, CardProgressionConstants.EnvPath.CardProgressionSynergiesHeadNode)
    if isNull(env) then return end
    env:FreshUI(self._cardId, self._isUnlock)
    
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


return CardProgressionSynergiesTips
