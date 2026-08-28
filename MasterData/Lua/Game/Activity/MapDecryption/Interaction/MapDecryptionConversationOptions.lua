
------------ import ------------
local util             = require 'XLua.util'
-- local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local cs_coroutine     = require "XLua.cs_coroutine"
local Input = CS.UnityEngine.Input
local Rect = CS.UnityEngine.Rect
------------ import ------------


------------ define ------------
local DataIndex2NodeIndex = {
    5,
    3,
    1,
    2,
    4,
}

local Status
------------ define ------------
--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalConversationOptions.prefab
---@class MapDecryptionConversationOptions
---@field Env                           	MapDecryptionConversationOptions                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field OptionNode                    	UnityEngine.RectTransform               
---@field DialogueNode                  	UnityEngine.RectTransform               
---@field DialogueGroup                 	UnityEngine.Animation                   
---@field OptionsGroup                  	UnityEngine.Animation                   
local MapDecryptionConversationOptions = Class('MapDecryptionConversationOptions')


function MapDecryptionConversationOptions:__init()
    Status                      = MapDecryptionConstants.InteractStatus
    self._status                = Status.None
    self._dialogueDataCount     = 0
    self._dialogueDataList      = {}
    self._curDialogueIndex      = 1
    self._optionPositionNodes   = {}
    self._optionNodes           = {}
    self._curOptionIndex        = 0
    self._dialoguePositionNodes = {}
    self._dialogueNodes         = {}
end


function MapDecryptionConversationOptions:__delete()
    if self._eventConf then
        for k, v in pairs(self._eventConf) do
            Events.RemoveListener(k, v)
        end
        
    end
    self.controller = nil
    
end


function MapDecryptionConversationOptions:Awake()
    if MapDecryptionUtils.IsPCPlatform() then
        self._eventConf = {
            [MapDecryptionConstants.EventNames.PCControllerF]            = Bind(self, self.OnEventPCControllerF),
            [MapDecryptionConstants.EventNames.PCControllerSwitchOption] = Bind(self, self.OnEventPCControllerSwitchOption),
        }

        for k, v in pairs(self._eventConf) do
            Events.AddListener(k, v)
        end
        
    end
    
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionConversationOptions:ClearCache()
    self:FreshDialogueNodeSelectIndex(1)
    self:FreshOptionNodeSelectIndex(0)
    self._status            = Status.None
    self._dialogueDataCount = 0
    self._dialogueDataList  = {}
    self._nodeIndexConfig   = {}
    self._choices = nil
    self._dataCount = 0
end

function MapDecryptionConversationOptions:ClearData()
    self:FreshDialogueNodeSelectIndex(1)
    self:FreshOptionNodeSelectIndex(0)
    self._status            = Status.None
    self._dialogueDataCount = 0
    self._dialogueDataList  = {}
    self._nodeIndexConfig   = {}
    -- self._curDialogueIndex = 1
    self._nodeIndexConfig = {}
    self._choices = nil
    self._dataCount = 0
end

function MapDecryptionConversationOptions:AddDialogue(dialogueData)
    self._dialogueDataCount = self._dialogueDataCount + 1
    self._dialogueDataList[self._dialogueDataCount] = dialogueData
    
end

function MapDecryptionConversationOptions:RemoveDialogue(dialogueData)
    local count = self._dialogueDataCount
    self._dialogueDataCount = count - 1
    local dialogueDataList = self._dialogueDataList
    for i = count, 1, -1 do
        if dialogueDataList[i].npcId == dialogueData.npcId and i ~= count then
            --- 把最后一个交换到当前下标
            dialogueDataList[i], dialogueDataList[count] = dialogueDataList[count], dialogueDataList[i]
            break
        end
    end
    if self._curDialogueIndex > self._dialogueDataCount then
        self:FreshDialogueNodeSelectIndex(self._dialogueDataCount)
        -- self._curDialogueIndex = self._dialogueDataCount

    end
end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function MapDecryptionConversationOptions:FreshUI(isShowDialogue)
    isShowDialogue = checkBool(isShowDialogue)

    if isShowDialogue then
        self:FreshDialogueGroup(self._dialogueDataList, self._dialogueDataCount)
    else
        local dialogueData = self._dialogueDataList[self._curDialogueIndex]
        ---@type MapDecryptionMainSceneInteractionVo
        local vo           = dialogueData.vo
        local options      = vo.ability
        self:FreshOptionsGroup(options, #options)
    end
    
    self:FreshUIShowState(isShowDialogue)

end

function MapDecryptionConversationOptions:FreshUIShowState(isShowDialogue)
    KTool.SetActive(self.DialogueGroup.gameObject, isShowDialogue)
    KTool.SetActive(self.OptionsGroup.gameObject,  not isShowDialogue)
    self:SetStatus(isShowDialogue and Status.Dialogue or Status.Option)
    if self._status == Status.Dialogue then
        self:FreshOptionNodeSelectIndex(0)
    end

end

function MapDecryptionConversationOptions:FreshDialogueGroup(dataList, dataCount)
    self._status            = Status.Dialogue
    self._nodeIndexConfig = self:FreshOrCreateNodes(
        self.DialogueGroup, 
        self.DialogueNode.gameObject, 
        self._dialoguePositionNodes, 
        self._dialogueNodes, 
        dataList,
        dataCount,
        self.FreshDialogueNode,
        "SpringFestivalConversationOptionsDialogueGroup"
    )


end

function MapDecryptionConversationOptions:FreshDialogueNode(go, data, index)
    ---@type MapDecryptionConversationDialogueNode
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.ConversationDialogueNode)
    if isNull(env) then
        return
    end

    env:FreshUI(data)
    env:SetSelectState(index == self._curDialogueIndex)
    env:SetCallback(function ()
        self:FreshDialogueNodeSelectIndex(index)

        Events.Broadcast(MapDecryptionConstants.EventNames.ShowOptions, data)
    end) 

end

--- FreshDialogueNodeSelectIndex
-- 刷新对话节点选择下标
---@param index number 数据下标
function MapDecryptionConversationOptions:FreshDialogueNodeSelectIndex(index)
    if self._curDialogueIndex == index then
        return
    end
    
    self:FreshDialogueNodeSelectState(index, true)
    self:FreshDialogueNodeSelectState(self._curDialogueIndex, false)
    self._curDialogueIndex = index
end

--- FreshDialogueNodeSelectState
-- 刷新对话节点选择状态
---@param index number
function MapDecryptionConversationOptions:FreshDialogueNodeSelectState(index, isSelect)
    local nodeIndex = self._nodeIndexConfig[index]
    if nodeIndex == nil then
        return
    end
    local node = self._dialogueNodes[nodeIndex]
    if isNull(node) then
        return
    end
    ---@type MapDecryptionConversationDialogueNode
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.ConversationDialogueNode)
    if isNull(env) then
        return
    end

    env:SetSelectState(isSelect)
end

--- FreshOptionsGroup
---@param options table
function MapDecryptionConversationOptions:FreshOptionsGroup(options, optionCount)
    self._status            = Status.Option
    self._nodeIndexConfig = self:FreshOrCreateNodes(
        self.OptionsGroup, 
        self.OptionNode.gameObject, 
        self._optionPositionNodes, 
        self._optionNodes, 
        options,
        optionCount,
        self.FreshOptionNode, 
        "SpringFestivalConversationOptionsOption"
    )

    
end

function MapDecryptionConversationOptions:FreshOptionNode(node, optionData, index)
    ---@type MapDecryptionConversationOptionNode
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.ConversationOptionNode)
    if isNull(env) then
        return
    end

    local dialogueData = self._dialogueDataList[self._curDialogueIndex]
    env:FreshUI(optionData, dialogueData)
    env:SetSelectState(self._curOptionIndex == index)
    env:SetCallback(function ()
        local enterType = checkNumber(optionData)
        if enterType == MapDecryptionConstants.FunctionEnterType.Tracking then
            MapDecryptionMgr:GetComponent():ClearTrackQuestRedPoint()
        end
        -- self:FreshOptionNodeSelectIndex(index)
        MapDecryptionUtils.HandleFunctionEnterType(enterType, {dialogueData = dialogueData})

    end)
    env:SetPointerEnteCallback(function ()
        self:FreshOptionNodeSelectIndex(index)
    end)
    env:SetPointerExitCallback(function ()
        self:FreshOptionNodeSelectIndex(0)
    end)
end

function MapDecryptionConversationOptions:FreshOptionNodeSelectIndex(index)
    local oldIndex = self._curOptionIndex
    if oldIndex == index then
        return
    end
    self._curOptionIndex = index
    self:FreshOptionNodeSelectState(index, true)
    self:FreshOptionNodeSelectState(oldIndex, false)

end

function MapDecryptionConversationOptions:FreshOptionNodeSelectState(index, isSelect)
    local nodeIndex = self._nodeIndexConfig[index]
    
    if nodeIndex == nil then
        return
    end
    local node = self._optionNodes[nodeIndex]
    if isNull(node) then
        return
    end
    ---@type MapDecryptionConversationOptionNode
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.ConversationOptionNode)
    if isNull(env) then
        return
    end
    env:SetSelectState(isSelect)

end


--- FreshGossipOptions
---@param gossipOption table 闲聊选项数据
function MapDecryptionConversationOptions:FreshGossipOptions(choices)
    self._status          = Status.Gossip
    self._choices         = choices
    self._nodeIndexConfig = self:FreshOrCreateNodes(
        self.OptionsGroup, 
        self.OptionNode.gameObject, 
        self._optionPositionNodes, 
        self._optionNodes, 
        choices,
        #choices,
        self.FreshGossipNode, 
        "SpringFestivalConversationOptionsOption"
    )
    self:FreshOptionNodeSelectIndex(0)
end

--- FreshGossipNode
--- 刷新闲聊节点
---@param node UnityEngine.GameObject
---@param optionData table
function MapDecryptionConversationOptions:FreshGossipNode(node, optionData, index)
    ---@type MapDecryptionConversationOptionNode
    local env = CfUtils.GetLuaScr(node, MapDecryptionConstants.EnvPath.ConversationOptionNode)
    if isNull(env) then
        return
    end

    env:FreshGossipUI(optionData)
    env:SetCallback(function ()
        -- self:FreshOptionNodeSelectIndex(index)
        local _, choiceId = SafeUnpack(optionData)
        Events.Broadcast(MapDecryptionConstants.EventNames.SelectGossip, choiceId)
    end)

    env:SetPointerEnteCallback(function ()
        self:FreshOptionNodeSelectIndex(index)
    end)
    env:SetPointerExitCallback(function ()
        self:FreshOptionNodeSelectIndex(0)
    end)
end

--- FreshOrCreateNodes
---@param root UnityEngine.Animation
---@param node UnityEngine.RectTransform
---@param positionNodes table<number, UnityEngine.RectTransform>
---@param nodes table<number, UnityEngine.GameObject>
---@param dataList table<number, table>
---@param dataCount number
---@param freshCb fun(go:UnityEngine.GameObject):void
---@param animationBaseName string
function MapDecryptionConversationOptions:FreshOrCreateNodes(root, prototype, positionNodes, nodes, dataList, dataCount, freshCb, animationBaseName)
    local rootTrans           = root.transform
    local childCount          = rootTrans.childCount
    local forTimes            = math.max(childCount, dataCount)

    local nodeIndexConfig = {}
    for i, v in ipairs(DataIndex2NodeIndex) do
        if v <= dataCount then
            table.insert(nodeIndexConfig, v)
        end
    end 

    --- 先写死一个配置 等以后有时间在调
    -- local nodeIndexConfig = Config[dataCount]
    for i = 1, forTimes, 1 do
        local nodeIndex = nodeIndexConfig[i]
        if nodeIndex then
            local optionPositionNode = positionNodes[nodeIndex]
            if optionPositionNode == nil then
                optionPositionNode = rootTrans:GetChild(nodeIndex - 1)
                positionNodes[nodeIndex] = optionPositionNode

                local node = optionPositionNode.gameObject:AddChild(prototype)
                KTool.SetActive(node.gameObject, true)
                nodes[nodeIndex] = node
            end
            
            local isShow = i <= dataCount
            KTool.SetActive(optionPositionNode.gameObject, isShow)
            if isShow and freshCb then
                freshCb(self, nodes[nodeIndex], dataList[i], i)
                
            end
        elseif positionNodes[i] then
            KTool.SetActive(positionNodes[i].gameObject, false)
        end
    end


    if animationBaseName and dataCount > 0 then
        root:Play(animationBaseName .. dataCount)
    end
    return nodeIndexConfig
end


---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionConversationOptions:SetStatus(status)
    self._status = status
end

function MapDecryptionConversationOptions:GetDialogueData()
    local dialogueData = self._dialogueDataList[self._curDialogueIndex]
    return dialogueData
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionConversationOptions:OnClickDialogueAction(optionData)
    -- self:FreshUI(false)
    Events.Broadcast(MapDecryptionConstants.EventNames.ShowOptions, optionData)
end

function MapDecryptionConversationOptions:OnEventPCControllerF()
    local status = self._status
    if status == Status.None then
        return
    end
    -- print("OnEventPCControllerF", status)
    if status == Status.Dialogue then
        local dialogueData = self._dialogueDataList[self._curDialogueIndex]
        Events.Broadcast(MapDecryptionConstants.EventNames.ShowOptions, dialogueData)

    -- elseif status == Status.Option then
    --     local dialogueData = self._dialogueDataList[self._curDialogueIndex]
    --     ---@type MapDecryptionMainSceneInteractionVo
    --     local vo           = dialogueData.vo
    --     local options      = vo.ability
    --     MapDecryptionUtils.HandleFunctionEnterType(options[self._curOptionIndex], {dialogueData = dialogueData})

    -- elseif status == Status.Gossip then
    --     local optionData  = self._choices[self._curOptionIndex]
    --     local _, choiceId = SafeUnpack(optionData)
    --     Events.Broadcast(MapDecryptionConstants.EventNames.SelectGossip, choiceId)

    end
end

function MapDecryptionConversationOptions:OnEventPCControllerSwitchOption(deltaY)
    local status = self._status
    if status == Status.None then
        return
    end
    
    local delta = deltaY > 0 and 1 or -1
    if status == Status.Dialogue then
        local newIndex = math.max(1, math.min(self._dialogueDataCount, self._curDialogueIndex + delta))
        self:FreshDialogueNodeSelectIndex(newIndex)
        
    -- elseif status == Status.Option then
    --     local newIndex = math.max(1, math.min(self._dataCount, self._curOptionIndex + delta))
    --     self:FreshOptionNodeSelectIndex(newIndex)
    -- elseif status == Status.Gossip then
    --     local newIndex = math.max(1, math.min(self._dataCount, self._curOptionIndex + delta))
    --     self:FreshOptionNodeSelectIndex(newIndex)
    end
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionConversationOptions
