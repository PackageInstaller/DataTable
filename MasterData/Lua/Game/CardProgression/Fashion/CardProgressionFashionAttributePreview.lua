
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils     = import("Game.CardProgression.CardProgressionCombatEffUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashionUpgradePreview.prefab > name: CultivateOverseaFashionUpgradePreview
---@class CardProgressionFashionAttributePreview
---@field Env                           	CardProgressionFashionAttributePreview    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopGridView            
local CardProgressionFashionAttributePreview = Class('CardProgressionFashionAttributePreview')


function CardProgressionFashionAttributePreview:__init()
end


function CardProgressionFashionAttributePreview:__delete()
    self.controller = nil
end


function CardProgressionFashionAttributePreview:Awake()
end

function CardProgressionFashionAttributePreview:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, false)
        self:OnInit()
        self:FreshUI()
    end))
    return coWait
end

function CardProgressionFashionAttributePreview:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CardProgressionFashionAttributePreview:OnInit()
    self:InitData()
    self:InitAction()
end

function CardProgressionFashionAttributePreview:InitData()
    local parameters  = self.controller.Argument.parameters
    local cardId      = parameters.cardId
    local attrAddId2ValInfos   = {}
    local attrAddId2V = CardProgressionCombatEffUtils.CalcFashionProperty(cardId, nil, nil, {}, function (skinId, level, attrAddId, attrV)
        attrAddId2ValInfos[attrAddId] = attrAddId2ValInfos[attrAddId] or {}
        table.insert(attrAddId2ValInfos[attrAddId], {skinId = skinId, level = level, attrV = attrV})
    end)

    local t = CardProgressionCombatEffUtils.GenerateSingleAttrTypeDataByAttrAddId2V(attrAddId2V, false)
    self._attributes = t
    self._attrAddId2ValInfos = attrAddId2ValInfos
end

function CardProgressionFashionAttributePreview:InitAction()
    SetButtonAction(self.BtnClose, function ()
        CfUtils.DialogBack()
    end)
end

--endregion 


--region logic 

function CardProgressionFashionAttributePreview:FreshUI()
    self:FreshScrollView()
end

function CardProgressionFashionAttributePreview:FreshScrollView()
    local ScrollView = self.ScrollView
    local count = #self._attributes
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end


function CardProgressionFashionAttributePreview:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionStarUpPreviewCell)
    
    ---@type CardProgressionStarUpPreviewCell
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end
    
    if nodeEnv then
        local position = index + 1
        local attribute = self._attributes[position]
        nodeEnv:FreshUI(attribute, position, self._attrAddId2ValInfos[attribute.attrAddId])
    end

    return cell
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CardProgressionFashionAttributePreview
