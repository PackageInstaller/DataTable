
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------
local attribute_format = attribute_format
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaLevelupSuccess.prefab
---@class CardProgressionLevelUpSuccess
---@field Env                           	CardProgressionLevelUpSuccess                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field TxtNumberNew                  	TMPro.TextMeshProUGUI                   
---@field TxtNumber                     	TMPro.TextMeshProUGUI                   
---@field ItemAttribute                 	UnityEngine.RectTransform               
---@field TextNumberNew                 	TMPro.TextMeshProUGUI                   
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
local CardProgressionLevelUpSuccess = Class('CardProgressionLevelUpSuccess')


function CardProgressionLevelUpSuccess:__init()
end


function CardProgressionLevelUpSuccess:__delete()
    self.controller = nil
end


function CardProgressionLevelUpSuccess:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
    
    local successNode = self.controller.gameObject.transform:Find("Root/Container/Success")
    if not isNull(successNode) then
        ---@type UnityEngine.Animation
        local animation   = successNode.gameObject:GetComponent(typeof(CS.UnityEngine.Animation))
        animation.playAutomatically = false
        self._animation = animation
    end
end


function CardProgressionLevelUpSuccess:OnFocus(focus)

end


function CardProgressionLevelUpSuccess:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitData()
        self:FreshUI()
    end))
    return coWait
end
function CardProgressionLevelUpSuccess:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CoYield()

        local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')
        CriWareUtils.PlaySe(UISheets.SFX_UI_SE.path, UISheets.SFX_UI_SE.ui_se_card_upgrade)
        if not isNull(self._animation) then
            self._animation:Play("CultivateOverseaLevelupSuccessGo")
        end
        
    end))
    return coWait
end


function CardProgressionLevelUpSuccess:OnFinalize()
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

function CardProgressionLevelUpSuccess:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type CardDojo
    local oldDojo    = parameters.oldDojo
    ---@type CardDojo
    local dojo       = parameters.dojo
    self._oldDojo    = oldDojo
    self._dojo       = dojo

    local oldEntity      = CardProgressionUtils.GenerateEntityByCardDojo(oldDojo)
    local entity         = CardProgressionUtils.GenerateEntityByCardDojo(dojo)
    local oldCombatPower = FormulaUtils.CalcCardCombatEffectiveness(oldEntity)
    local combatPower    = FormulaUtils.CalcCardCombatEffectiveness(entity)

    self._oldCombatPower = oldCombatPower
    self._combatPower    = combatPower

    --- 初始化属性
    local attributes = {}
    local tInsert    = table.insert
    local viewType   = CardProgressionConstants.AttrNodeType.Double
    FormulaUtils.CompareBasicAttrs(oldDojo, dojo, function (basicVo, preAttrV, attrV, index)
        if preAttrV ~= attrV then
            tInsert(attributes, {
                icon         = basicVo.icon,
                name         = basicVo.name,
                attrNum      = attribute_format(basicVo.isConversion, preAttrV),
                plusAttrNum  = attribute_format(basicVo.isConversion, attrV),
                viewType     = viewType
            })
        end
    end)
    self._attributes = attributes

    --- 跳转排除该界面
    self.controller:SetExtraArgument(tostring(dojo.id))
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionLevelUpSuccess:FreshUI()
    self.TextNumber.text    = self._oldDojo.cardLevel
    self.TextNumberNew.text = self._dojo.cardLevel
    self.TxtNumber.text     = self._oldCombatPower
    self.TxtNumberNew.text  = self._combatPower

    self:FreshAttributes()
end

function CardProgressionLevelUpSuccess:FreshAttributes()
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(self._attributes, true)
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

function CardProgressionLevelUpSuccess:OnClickBtnAction()
    UIModule.CloseDialog(self.controller)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionLevelUpSuccess
