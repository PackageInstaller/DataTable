
------------ import ------------
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------


------------ define ------------

------------ define ------------

---@class CardProgressionAttributeGroupNode
---@field Env                           	CardProgressionAttributeGroupNode                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ScrollView                    	SuperScrollView.LoopGridView            
local CardProgressionAttributeNodeGroup = Class('CardProgressionAttributeNodeGroup')

function CardProgressionAttributeNodeGroup:__init()

end


function CardProgressionAttributeNodeGroup:__delete()

end


function CardProgressionAttributeNodeGroup:Awake()
end


function CardProgressionAttributeNodeGroup:Start()
end


function CardProgressionAttributeNodeGroup:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionAttributeNodeGroup:FreshUI(attributes, isResetCellName, isPlayFadeIn, customLuaPath)
    self._attributes = attributes
    self._isResetCellName = isResetCellName
    self._isPlayFadeIn = isPlayFadeIn
    self._customLuaPath = customLuaPath
    self:FreshScrollView(attributes)
end

--- FreshTabs
--- 刷新所有标签
function CardProgressionAttributeNodeGroup:FreshScrollView(attributes)
    local ScrollView = self.ScrollView
    local count = #attributes
    if not ScrollView.IsListViewInit then
        ScrollView:InitGridView(count, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end

    self._isPlayFadeIn = false
end

function CardProgressionAttributeNodeGroup:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionListCell)
    
    ---@type CardProgressionAttributeNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
        nodeEnv:InitLuaEnvPath(self._customLuaPath or CardProgressionConstants.EnvPath.CardProgressionAttributeNode)
        
    else
        nodeEnv = node.Env
    end
    if self._isResetCellName then
        cell.name = "Cell" .. (index + 1)
    end
    ---@type UnityEngine.Animation
    local animation = nodeEnv:GetCellAnimation()
    if not isNull(animation) then
        if self._defaultName and self._alphaName then
            animation:Play(self._isPlayFadeIn and self._alphaName or self._defaultName)
        end

    end
    if nodeEnv then
        local position = index + 1
        local attribute = self._attributes[position]
        nodeEnv:FreshUI(attribute, self._targetNode, position)
    end

    return cell
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionAttributeNodeGroup:SetTargetNode(targetNode)
    self._targetNode = targetNode
end
function CardProgressionAttributeNodeGroup:SetAnimName(defaultName, alphaName)
    self._defaultName = defaultName
    self._alphaName   = alphaName
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionAttributeNodeGroup
