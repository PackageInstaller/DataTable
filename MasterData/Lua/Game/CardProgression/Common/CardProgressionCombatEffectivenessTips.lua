
------------ import ------------
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
local KTool = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
-- ---@type IllustratedHandbookComponent
-- local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
---@type CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils     = import("Game.CardProgression.CardProgressionCombatEffUtils")

------------ import ------------


------------ define ------------
local AttributeProviderType = Constants.AttributeProviderType

local ProviderTypeTextConfig = {
    {AttributeProviderType.Base,          localize("基础战力")},
    {AttributeProviderType.Level,         localize("升级")},
    {AttributeProviderType.AdvLevel,      localize("突破")},
    {AttributeProviderType.Star,          localize("升星")},
    {AttributeProviderType.Weapon,        localize("专武")},
    {AttributeProviderType.Equipment,     localize("装备")},
    -- {AttributeProviderType.Skill,      localize("技能升级")},
    -- {AttributeProviderType.FavorLevel, localize("好感度加成")},
    {AttributeProviderType.Fashion,       localize("皮肤加成")},
    {AttributeProviderType.Global,        localize("全局加成")},
    {AttributeProviderType.GlobalTalent,  localize("全局天赋")},
    {AttributeProviderType.CheckIn,       localize("信息录入"), function() return GameUtils.IsSwitchedBySystemTogId(Constants.SystemToggleIds.Id6003) end},
}

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaCardsCombatEffectivenessTips.prefab
---@class CardProgressionCombatEffectivenessTips
---@field Env                           	CardProgressionCombatEffectivenessTips  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Arrow                         	UnityEngine.RectTransform               
---@field Node                          	UnityEngine.RectTransform               @ 全局属性属性节点
---@field ArmedImageNode                	UnityEngine.RectTransform               @ 全局属性根节点
---@field Bg                            	UnityEngine.RectTransform               @ 根节点
local CardProgressionCombatEffectivenessTips = Class('CardProgressionCombatEffectivenessTips', CommonTipsBoard)

function CardProgressionCombatEffectivenessTips:__init()
    CommonTipsBoard.__init(self)
end


function CardProgressionCombatEffectivenessTips:__delete()
    CommonTipsBoard.__delete(self)
end


function CardProgressionCombatEffectivenessTips:Awake()
    CommonTipsBoard.Awake(self)
    CommonTipsBoard.Init(self)
end


function CardProgressionCombatEffectivenessTips:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

---InitCombatEffectivenessModuleList
---@param entity CardProgressionEntity
function CardProgressionCombatEffectivenessTips:InitCombatEffectivenessModuleList(entity)
    local isIgnoreGlobal = entity.isIgnoreGlobal
    ---属性战力
    local providerType2CombatEff    = {}
    ---附加战力
    local providerType2ExtraCombatEff = {}
    FormulaUtils.CalcCardCombatEffectiveness(entity, {isIgnoreGlobal = isIgnoreGlobal}, nil, function (providerType, providerCombatEff, isExtra)
        if isExtra then
            providerType2ExtraCombatEff[providerType] = providerCombatEff
        else
            providerType2CombatEff[providerType] = providerCombatEff
        end
    end)
    
    local checkNumber = checkNumber
    providerType2CombatEff[AttributeProviderType.Star]          = checkNumber(providerType2CombatEff[AttributeProviderType.Star])      + (providerType2ExtraCombatEff[AttributeProviderType.Skill]     or 0)
    providerType2CombatEff[AttributeProviderType.Equipment]     = checkNumber(providerType2CombatEff[AttributeProviderType.Equipment]) + (providerType2ExtraCombatEff[AttributeProviderType.Equipment] or 0)
    providerType2CombatEff[AttributeProviderType.Weapon]        = checkNumber(providerType2CombatEff[AttributeProviderType.Weapon])    + (providerType2ExtraCombatEff[AttributeProviderType.Weapon] or 0)
    providerType2CombatEff[AttributeProviderType.GlobalTalent]  = checkNumber(providerType2CombatEff[AttributeProviderType.GlobalTalent])    + (providerType2ExtraCombatEff[AttributeProviderType.GlobalTalent] or 0)

    local dataList = {}
    for index, config in ipairs(ProviderTypeTextConfig) do
        local providerType, text, isOpenedFunc = SafeUnpack(config)
        local needShow = true
        if isNotNull(isOpenedFunc) and not isOpenedFunc() then
            needShow = false
        end
        if needShow then
            table.insert(dataList, {text = text, combatEff = providerType2CombatEff[providerType] or 0})
        end
    end
    self._dataList = dataList

end


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionCombatEffectivenessTips:FreshUI(data)
    self:InitCombatEffectivenessModuleList(data)
    self:UpdateAdditionListView_()
end

function CardProgressionCombatEffectivenessTips:UpdateAdditionListView_()
    local parent = self.Bg.gameObject
    local node = self.Node.gameObject
    for index, value in ipairs(self._dataList) do
        local nodeGo = parent:AddChild(node)
        nodeGo.name  = 'additionNode_' .. index
        CfUtils.SetActive(nodeGo.transform:Find('ImgBackGround'), true)
        CfUtils.SetActive(nodeGo, true)

        self:UpdateAdditionListNode_(nodeGo, value, index)
    end
    
end

---@param nodeGo UnityEngine.GameObject
function CardProgressionCombatEffectivenessTips:UpdateAdditionListNode_(nodeGo, data, index)
    CfUtils.FillText(nodeGo.transform:Find('TxtName'), data.text)
    CfUtils.FillText(nodeGo.transform:Find('TxtNumber'), string.format('+%s', data.combatEff))
    CfUtils.SetCanvasGroupAlpha(nodeGo.transform:Find('ImgBackGround'), index % 2)
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


return CardProgressionCombatEffectivenessTips
