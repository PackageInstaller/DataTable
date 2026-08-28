
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
------------ import ------------


------------ define ------------
local attribute_format = attribute_format
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarupSuccess.prefab > name: CultivateOverseaStarupSuccess
---@class CardProgressionStarUpSuccess
---@field Env                           	CardProgressionStarUpSuccess            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field DrawingNode                   	Game.Native.Common.DrawingNode               
---@field Success                       	UnityEngine.Animation
---@field FontStyleButton               	UnityEngine.RectTransform
---@field CultivateOverseaBreakNode     	UnityEngine.RectTransform               
---@field StarUpEffect                  	UnityEngine.RectTransform               
---@field CombatEffectivenessNode       	UnityEngine.RectTransform               
---@field ItemAttribute                 	UnityEngine.RectTransform
---@field StarLevelNode                 	UnityEngine.RectTransform
local CardProgressionStarUpSuccess = Class('CardProgressionStarUpSuccess')


function CardProgressionStarUpSuccess:__init()
end


function CardProgressionStarUpSuccess:__delete()
    self.controller = nil
end


function CardProgressionStarUpSuccess:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
    SetButtonAction(self.BtnSkill, Bind(self, self.OnClickBtnSkillAction))
end


function CardProgressionStarUpSuccess:OnFocus(focus)

end


function CardProgressionStarUpSuccess:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitData()
        

    end))
    return coWait
end


function CardProgressionStarUpSuccess:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshUI()
        CoYield()
        self.Success:Play("CultivateOverseaStarupSuccessGo")
    end))
    return coWait
end


function CardProgressionStarUpSuccess:OnFinalize()
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

function CardProgressionStarUpSuccess:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type CardDojo
    local dojo    = parameters.dojo
    local star    = checkNumber(dojo.star)
    local oldDojo = parameters.oldDojo
    self._oldDojo = oldDojo
    self._dojo = dojo

    self._oldStar       = star - 1
    self._star          = star
    self._cardId        = dojo.cardId
    
    local tInsert    = table.insert
    local attributes = {}
    local preCombatEffectiveness, combatEffectiveness = FormulaUtils.CompareCombatEffectivenessAndAttr(dojo, dojo, function(basicVo, preAttrV, attrV, i)
        if preAttrV ~= attrV then
            local isConversion = basicVo.isConversion
            tInsert(attributes, {
                icon         = basicVo.icon,
                name         = basicVo.name,
                attrNum      = attribute_format(isConversion, preAttrV),
                plusAttrNum  = attribute_format(isConversion, attrV),
                viewType     = CardProgressionConstants.AttrNodeType.Double
            })
        end
        
    end, {star = self._oldStar}, {star = self._star})

    local cardConfMgr = CardConfMgr:GetInstance()
    local rate     = cardConfMgr:GetSynergiesGeneralAddNum(self._oldStar, self._cardId)
    local nextRate = cardConfMgr:GetSynergiesGeneralAddNum(self._star, self._cardId)
    tInsert(attributes, {
        icon        = CardProgressionConstants.AssetPath.Synergies,
        name        = localize("羁绊属性加成"),
        attrNum     = attribute_format(1, rate),
        plusAttrNum = attribute_format(1, nextRate),
        viewType    = CardProgressionConstants.AttrNodeType.Double,
    })
    self._attributes = attributes
    
    self._combatEffectivenessData = {
        name        = localize("战斗力"),
        attrNum     = preCombatEffectiveness,
        plusAttrNum = combatEffectiveness,
        viewType    = CardProgressionConstants.AttrNodeType.Double,
    }   


    --- 跳转排除该界面
    self.controller:SetExtraArgument(tostring(dojo.id))
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------


function CardProgressionStarUpSuccess:FreshUI()
    self:FreshDrawingNode()
    self:FreshStarNodes()
    self:FreshCombatEffectivenessNode()
    self:FreshAttributes()
    self:FreshStarUpSkillNode()
    self:PlayStarUpVoice()
end

function CardProgressionStarUpSuccess:FreshDrawingNode()
    self.DrawingNode:Execute(self._dojo.cardSkin)

end

function CardProgressionStarUpSuccess:FreshStarNodes()
    ---@type CardProgressionStarGroupNode
    local env = CfUtils.GetLuaScr(self.StarLevelNode, CardProgressionConstants.EnvPath.CardProgressionStarGroupNode)
    if isNull(env) then return end
    env:FreshUI(self._oldStar, self._star, nil, nil, true)

end

function CardProgressionStarUpSuccess:FreshCombatEffectivenessNode()
    ---@type CardProgressionAttributeNode
    local env = CfUtils.GetLuaScr(self.CombatEffectivenessNode, CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
    if isNull(env) then return end
    env:FreshUI(self._combatEffectivenessData)
end

function CardProgressionStarUpSuccess:FreshAttributes()
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(self._attributes, true)

end

function CardProgressionStarUpSuccess:FreshStarUpSkillNode()
    ---@type CardProgressionBreakNode
    local env = CfUtils.GetLuaScr(self.CultivateOverseaBreakNode, CardProgressionConstants.EnvPath.CardProgressionBreakNode)
    if isNull(env) then return end
    env:FreshStarUpUI(self._cardId, self._star, self._oldDojo, true)

end

function CardProgressionStarUpSuccess:PlayStarUpVoice()
    --- 播放升星语音
    RoleVoiceMgr:GetInstance():PlayRoleStarUpVoiceByCardId(self._cardId, nil, self._dojo.cardSkin)
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
function CardProgressionStarUpSuccess:OnClickBtnAction()
    UIModule.CloseDialog(self.controller)
end

function CardProgressionStarUpSuccess:OnClickBtnSkillAction()
    local unlockVo = self._unlockVo
    if unlockVo == nil then
        return
    end
    CardProgressionUtils.ShowCommonTipsSkill(self.BtnSkill, {skillId = unlockVo.initOpenAbility, skillGroupType = CardProgressionConstants.SkillGroupType.Buff})
end


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionStarUpSuccess
