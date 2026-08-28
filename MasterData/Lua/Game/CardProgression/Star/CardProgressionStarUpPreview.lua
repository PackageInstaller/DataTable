
------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaStarupPreview.prefab > name: CultivateOverseaStarupPreview
---@class CardProgressionStarUpPreview
---@field Env                           	CardProgressionStarUpPreview            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               
---@field EffectScrollView              	SuperScrollView.LoopListView2   
---@field ScrollView                    	SuperScrollView.LoopGridView               
local CardProgressionStarUpPreview = Class('CardProgressionStarUpPreview')


function CardProgressionStarUpPreview:__init()
end


function CardProgressionStarUpPreview:__delete()
    self.controller = nil
end


function CardProgressionStarUpPreview:Awake()
    SetButtonAction(self.BtnClose, function ()
        UIModule.CloseDialog(self.controller)
    end)
end


function CardProgressionStarUpPreview:OnFocus(focus)

end


function CardProgressionStarUpPreview:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Events.Broadcast(CardProgressionConstants.EventNames.SetCultivateMainShowState, false)
        self:InitData()
        self:FreshUI()
    end))
    return coWait
end

function CardProgressionStarUpPreview:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshStarSkillNodes()
    end))
    return coWait
end

function CardProgressionStarUpPreview:OnFinalize()
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

function CardProgressionStarUpPreview:InitData()
    local parameters   = self.controller.Argument.parameters
    ---@type CardDojo
    local dojo         = parameters.dojo
    local star         = checkNumber(dojo.star)
    local maxStar      = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxStar))
    local isMaxStar =  star >= maxStar
    local t = {}

    ---@type CardStarVo
    local starVo     = cardConfMgr:GetCardStarInfo(dojo.cardId, maxStar)
    local attrAddId2V = starVo:GetAttributes()
    local attributeId2Res = {}
    for addrAddId, _ in pairs(attrAddId2V) do
        local attrId = cardConfMgr:GetBasicAttrIdByBasicAttrAdditionId(addrAddId)
        attributeId2Res[attrId] = true
    end
    FormulaUtils.CompareBasicAttrs(dojo, dojo, function (vo, preBaseV, baseV, i)
        if attributeId2Res[vo.id] then
            local text    = attribute_format(vo.isConversion, baseV)
            table.insert(t, {
                icon = vo.icon,
                name = vo.name,
                attrNum = isMaxStar and text or attribute_format(vo.isConversion, preBaseV),
                plusAttrNum = text,
                viewType = isMaxStar and CardProgressionConstants.AttrNodeType.Single or CardProgressionConstants.AttrNodeType.Double,
            })
        end
    end, {star = star}, {star = maxStar})

    local rate     = cardConfMgr:GetSynergiesGeneralAddNum(star, dojo.cardId)
    local nextRate = cardConfMgr:GetSynergiesGeneralAddNum(maxStar, dojo.cardId)
    local text = attribute_format(1, nextRate)
    table.insert(t, {
        icon = CardProgressionConstants.AssetPath.Synergies,
        name = localize("羁绊属性加成"),
        attrNum = isMaxStar and text or attribute_format(1, rate),
        plusAttrNum = text,
        viewType = isMaxStar and CardProgressionConstants.AttrNodeType.Single or CardProgressionConstants.AttrNodeType.Double,
    })
    
    self._attributes = t
    self._cardId = dojo.cardId
    self._originStar = star
    self._maxStar = maxStar

    local dataList = CardProgressionSkillUtils.GetFullStarSkillTypeData(self._cardId, maxStar)
    self._skillTypeDataList = {}
    for i = 1, math.ceil(#dataList * 0.5) do
        table.insert(self._skillTypeDataList, {dataList[i * 2 - 1], dataList[i * 2]})
    end

end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionStarUpPreview:FreshUI()
    self:FreshScrollView()

    
end

function CardProgressionStarUpPreview:FreshScrollView()
    local ScrollView = self.ScrollView
    local count = #self._attributes
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end

function CardProgressionStarUpPreview:OnGetItemByIndex(listView, index)
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
        nodeEnv:FreshUI(attribute)
        nodeEnv:FreshImgBg(position)
    end

    return cell
end

function CardProgressionStarUpPreview:FreshStarSkillNodes()
    local ScrollView = self.EffectScrollView
    local count = #self._skillTypeDataList
    ScrollView:InitListView(count, Bind(self, self.OnGetSkillItemByIndex))

    -- ScrollView:MovePanelToItemIndex(0)
    
end

function CardProgressionStarUpPreview:OnGetSkillItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionStarUpPreviewSkillInfoCell)
    
    ---@type CardProgressionStarUpPreviewSkillInfoCell
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
        local data = self._skillTypeDataList[position]
        nodeEnv:FreshUI(data, self._cardId, self._originStar, self._maxStar, true)
        
        listView:OnItemSizeChanged(index)
    end

    return cell
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


return CardProgressionStarUpPreview
