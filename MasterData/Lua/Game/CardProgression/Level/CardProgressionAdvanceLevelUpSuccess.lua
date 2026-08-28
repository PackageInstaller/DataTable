
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------
local attribute_format = attribute_format
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaEvolutonSuccess.prefab > name: CultivateOverseaEvolutonSuccess
---@class CardProgressionAdvanceLevelUpSuccess
---@field Env                           	CardProgressionAdvanceLevelUpSuccess    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field FontStyleButton               	UnityEngine.RectTransform
---@field ArmForceNode                  	UnityEngine.RectTransform               
---@field TxtNumberNew                  	TMPro.TextMeshProUGUI
---@field TxtNumber                     	TMPro.TextMeshProUGUI
---@field ItemAttribute                 	UnityEngine.RectTransform
---@field Effect                        	UnityEngine.RectTransform               
---@field ImgRareIconOld                	Game.Native.Common.UISwitchImage        
---@field ImgRareIconLight              	Game.Native.Common.UISwitchImage        
---@field ImgRareIcon2                  	Game.Native.Common.UISwitchImage
---@field ImgRareIcon                   	Game.Native.Common.UISwitchImage
---@field ImgRareBg                     	Game.Native.Common.UISwitchImage
---@field Success                       	UnityEngine.Animation
---@field BossDrawingNode               	Game.Native.Common.DrawingNode
local CardProgressionAdvanceLevelUpSuccess = Class('CardProgressionAdvanceLevelUpSuccess')


function CardProgressionAdvanceLevelUpSuccess:__init()
end


function CardProgressionAdvanceLevelUpSuccess:__delete()
    self.controller = nil
end


function CardProgressionAdvanceLevelUpSuccess:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))

    self.Root = self.controller.transform:Find("Root")
    ---@type Game.Native.Common.UISwitchParticleSystem[]
    self._effects = self.Effect.gameObject:GetComponentsInChildren(CardProgressionConstants.CompType.UISwitchParticleSystemType)
end


function CardProgressionAdvanceLevelUpSuccess:OnFocus(focus)

end


function CardProgressionAdvanceLevelUpSuccess:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false, true)
        self:InitData()
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, false, false, true, self._skinId)
        self:FreshUI()
        KTool.SetActive(self.Root.gameObject, false)
        
    end))
    return coWait
end

function CardProgressionAdvanceLevelUpSuccess:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CoYield()
        KTool.SetActive(self.Root.gameObject, true)
        local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')
        CriWareUtils.PlaySe(UISheets.SFX_UI_SE.path, UISheets.SFX_UI_SE.ui_se_card_up_quality_success)
        
        CfUtils.PlayAnimation(self.Success, "CultivateOverseaEvolutonSuccessGo")        
    end))
    return coWait
end


function CardProgressionAdvanceLevelUpSuccess:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionAdvanceLevelUpSuccess:InitData()
    local parameters = self.controller.Argument.parameters
    ---@type CardDojo
    local oldDojo    = parameters.oldDojo
    ---@type CardDojo
    local dojo            = parameters.dojo
    ---@type CardVo
    local vo              = cardConfMgr:GetCardByRefId(dojo.cardId)
    local advanceLevel    = checkNumber(dojo.advanceLevel)
    local oldAdvanceLevel = advanceLevel - 1
    self._oldRare         = cardConfMgr:GetCardRare(oldAdvanceLevel, vo.rare)
    self._rare            = cardConfMgr:GetCardRare(advanceLevel, vo.rare)
    
    self._skinId          = checkNumber(dojo.cardSkin)

    self._oldMaxLevel     = cardConfMgr:GetCardMaxLevel(oldAdvanceLevel)
    self._maxLevel        = cardConfMgr:GetCardMaxLevel(advanceLevel)

    --- 初始化属性
    ---@type RoleAdvanceVo
    local vo    = cardConfMgr:GetRoleAdvanceVo(dojo.cardId, advanceLevel)
    local attrs = vo:GetBreakAttributes()
    local attrId2Res = {}
    for i, v in pairs(attrs) do
        local attrId = cardConfMgr:GetBasicAttrIdByBasicAttrAdditionId(i)
        attrId2Res[attrId] = true
    end
    
    local attributes = {}
    local tInsert    = table.insert

    local viewType   = CardProgressionConstants.AttrNodeType.Double
    local preTotalCombatEff, totalCombatEff = FormulaUtils.CompareCombatEffectivenessAndAttr(oldDojo, dojo, function (vo, preBaseV, baseV, i)
        local order = vo.order
        if order > 0 and attrId2Res[vo.id] then
            local preText = attribute_format(vo.isConversion, preBaseV)
            local text    = attribute_format(vo.isConversion, baseV)
            tInsert(attributes, {
                icon = vo.icon,
                name = vo.name,
                attrNum = preText,
                plusAttrNum = baseV ~= preBaseV and text or nil,
                viewType = viewType,
            })
        end
    end)
    

    local combatEffectivenessConf = {
        name        = localize("战斗力"),
        attrNum     = preTotalCombatEff,
        plusAttrNum = preTotalCombatEff ~= totalCombatEff and totalCombatEff or nil,
        viewType    = CardProgressionConstants.AttrNodeType.Double,
    }

    self._attributes = attributes
    self._combatEffectivenessConf = combatEffectivenessConf

    --- 跳转排除该界面
    self.controller:SetExtraArgument(tostring(dojo.id))

end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionAdvanceLevelUpSuccess:FreshUI()
    local rare = self._rare
    local oldRare = self._oldRare
    self.ImgRareIconOld.Status = oldRare
    self.ImgRareIconLight.Status = rare
    -- self.Particle.Status = rare
    -- self.ImgRareIcon2New.Status = rare
    -- self.ImgRareIconNew.Status = rare
    -- self.ImgRareBgNew.Status = rare
    self.ImgRareIcon2.Status = rare
    self.ImgRareIcon.Status = rare
    self.ImgRareBg.Status = rare

    if isNotNull(self._effects) then
        for i = 0, self._effects.Length - 1 do 
            local switch = self._effects[i]
            if isNotNull(switch) then
                switch.Status = rare
            end
        end
    end

    UICommonUtils.ShowSkin(self.BossDrawingNode.gameObject, self._skinId)
    -- self.BossDrawingNode:Execute(self._skinId)

    self.TxtNumber.text = self._oldMaxLevel
    self.TxtNumberNew.text = self._maxLevel

    self:FreshCombatEffectiveness(self._combatEffectivenessConf)
    self:FreshAttributes()

end


function CardProgressionAdvanceLevelUpSuccess:FreshCombatEffectiveness(data)
    ---@type CardProgressionAttributeNode
    local env = CfUtils.GetLuaScr(self.ArmForceNode, CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
    if isNull(env) then return end
    env:FreshUI(data)

end

function CardProgressionAdvanceLevelUpSuccess:FreshAttributes()
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

function CardProgressionAdvanceLevelUpSuccess:OnClickBtnAction()
    UIModule.CloseDialog(self.controller)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionAdvanceLevelUpSuccess
