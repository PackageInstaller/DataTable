
------------ import ------------
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type QuestConfMgr
local questConfMgr     = QuestConfMgr:GetInstance()
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
------------ import ------------


------------ define ------------
local isNull        = isNull
local UICommonUtils = UICommonUtils

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalExploreTracking.prefab > name: TrackingPanel
---@class MapDecryptionTrackingPanel
---@field Env                           	MapDecryptionTrackingPanel              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field NodeContainer                 	UnityEngine.RectTransform               
---@field redPoint                      	UnityEngine.RectTransform               
---@field BtnExplore                    	UnityEngine.RectTransform               
---@field TxtTips                       	Game.Native.Common.UISwitchText         
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field FontStyleButton2              	UnityEngine.RectTransform               
---@field CommonGoodsList               	UnityEngine.RectTransform               
---@field TxtName                       	UnityEngine.UI.Text                     
---@field NameNode                      	UnityEngine.RectTransform               
---@field TxtTitle                      	UnityEngine.UI.Text                     
---@field ImgIcon                       	Engine.UI.RawImageAlterable             
local MapDecryptionTrackingPanel = Class('MapDecryptionTrackingPanel')

function MapDecryptionTrackingPanel:__init()
    self._trackingIndex    = 1
    self._trackingNodes = {}
    self._trackingDataEntityList = nil
end

function MapDecryptionTrackingPanel:__delete()

end


function MapDecryptionTrackingPanel:Awake()
end


function MapDecryptionTrackingPanel:Start()
    SetButtonAction(self.BtnExplore, Bind(self, self.OnClickBtnExploreAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickFontStyleButtonAction))
    SetButtonAction(self.FontStyleButton2, Bind(self, self.OnClickFontStyleButton2Action))

end


function MapDecryptionTrackingPanel:OnDestroy()
    if self.co ~= nil then
        cs_coroutine.stop(self.co)
        self.co = nil
    end

    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionTrackingPanel:Init(nodePositions, nodeRotations, questId)
    ---@type MapDecryptionComponent
    local component              = MapDecryptionMgr:GetComponent()
    self._trackingDataEntityList = component:GenerateTrackingDataEntityList()
    
    if questId then
        questId = checkNumber(questId)
        for i, v in ipairs(self._trackingDataEntityList) do
            if v.questId == questId then
                self._trackingIndex = i
                break
            end
        end
        
    end

    self:InitTrackingNodes(nodePositions, nodeRotations, self.NodeContainer)
    
end

function MapDecryptionTrackingPanel:InitTrackingNodes(nodePositions, nodeRotations, parent)
    self.co = cs_coroutine.start(function ()
        local go
        local parentGo = parent.gameObject
        local tInsert  = table.insert
        for i, entity in ipairs(self._trackingDataEntityList) do
            if i == 1 then
                go = MapDecryptionUtils.CreateGameObjectByPath(MapDecryptionConstants.PrefabPath.MapTrackingNode, parent)
            else
                go = parentGo:AddChild(go)
            end
            tInsert(self._trackingNodes, go)

            local nodePosition         = nodePositions[i]
            local transform            = go.transform
            transform.anchoredPosition = CfUtils.WorldPosition2UIPosition(nodePosition, parent)
            transform.rotation         = nodeRotations[i]

            self:FreshTrackingNode(go, entity, self._trackingIndex == i, i)

        end

        -- local entityList = self._trackingDataEntityList
        -- ---@type MapDecryptionExploreTrackingController
        -- local controllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.ExploreTracking)
        -- local root = controllerComp._trackingPositionRoot
        -- while true do
        --     for i, entity in ipairs(entityList) do
        --         local child = root:GetChild(i - 1)
        --         local nodePosition            = child.position
        --         local node = self._trackingNodes[i]
        --         node.transform.anchoredPosition = CfUtils.WorldPosition2UIPosition(nodePosition, parent)
                
        --     end
        --     cs_coroutine.yield_return()
        -- end

        self.co = nil
    end)
end

function MapDecryptionTrackingPanel:FreshTrackingNode(go, entity, isSelect, index)
    ---@type MapDecryptionMapTrackingNode
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.MapTrackingNode)
    if not isNull(env) then
        if index then
            env:SetIndex(index)
            env:SetCallback(Bind(self, self.OnClickTrackingNodeAction))
        end
        env:FreshUI(entity, isSelect)
    end
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function MapDecryptionTrackingPanel:FreshUI()
    ---@type MapDecryptionTrackingDataEntity
    local entity = self._trackingDataEntityList[self._trackingIndex]

    local questId     = entity.questId
    -- KCookie.Set(MapDecryptionConstants.EventNames.TrackQuestId, questId)

    ---@type MapDecryptionQuestVo
    local questVo     = MapDecryptionConfMgr:GetQuestVoById(questId)
    local isUnlock    = entity.isUnlock == 1
    --- 刷新bossIcon
    self.ImgIcon:LoadSprite(isUnlock and questVo.picture or MapDecryptionConstants.DefaultImgAssets.TrackingBoss)
    
    --- 刷新关卡名称
    self.TxtTitle.text = questVo.name
    
    KTool.SetActive(self.NameNode.gameObject, isUnlock)
    KTool.SetActive(self.CommonBtnConsumePop.gameObject, isUnlock)
    if isUnlock then
        --- 刷新boss名称
        ---@type table<number, WaveVo>
        local allQuestLineup = questConfMgr:GetAllQuestLineupVo(questId)
        for i, waveVo in ipairs(allQuestLineup) do
            local wave1NpcId = waveVo.wave1NpcId
            for monsterIndex, monsterId in ipairs(wave1NpcId) do
                ---@type MonsterTypeVo
                local monsterTypeVo = cardConfMgr:GetMonsterTypeVoById(monsterId)
                if monsterTypeVo.monsterClass == Constants.RoleClass.Boss then
                    self.TxtName.text = monsterTypeVo.name
                    break
                end
            end
        end

        --- 关卡消耗
        UICommonUtils.FillCommonBtnConsumePop(self.CommonBtnConsumePop, questVo.costItem, questVo.costNum, false)
    end

    --- 关卡奖励
    UICommonUtils.FillQuestCommonGoodsList(self.CommonGoodsList, questId)

    self:FreshBottomUI(MapDecryptionMgr:CheckActivityIsEnd(), isUnlock, questId)
end

function MapDecryptionTrackingPanel:FreshBottomUI(isTimeEnd, isUnlock, questId)
    local isShowTips = isTimeEnd or not isUnlock
    KTool.SetActive(self.FontStyleButton.gameObject, not isShowTips)
    KTool.SetActive(self.FontStyleButton2.gameObject, not isShowTips)
    KTool.SetActive(self.TxtTips.gameObject, isShowTips)

    if isShowTips then
        self.TxtTips.Status = isTimeEnd and 2 or 1
    else
        local isPass             = QuestConfMgr:GetInstance():IsPassQuest(questId)
        self.FontStyleButton2:ResetFontStyle(isPass and "B25" or "B18")
    end

end

function MapDecryptionTrackingPanel:FreshSelectState(index, isSelect)
    local go = self._trackingNodes[index]
    ---@type MapDecryptionMapTrackingNode
    local env = CfUtils.GetLuaScr(go, MapDecryptionConstants.EnvPath.MapTrackingNode)
    if not isNull(env) then
        env:FreshSelectState(isSelect)
    end

end

---------------------------------------------------
--- ui logic end --
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

function MapDecryptionTrackingPanel:OnClickBtnExploreAction()
    local MapDecryptionConstants = MapDecryptionConstants
    Events.Broadcast(MapDecryptionConstants.EventNames.SwitchExploreOrTracking, MapDecryptionConstants.ExploreTrackingSubViewType.Explore)
    
end


-- 点击 "追踪" 按钮, 进入战斗 "队伍选择" 界面:
function MapDecryptionTrackingPanel:OnClickFontStyleButtonAction()
    ---@type MapDecryptionTrackingDataEntity
    local trackingDataEntity = self._trackingDataEntityList[self._trackingIndex]

    if trackingDataEntity.isUnlock ~= 1 then
        GameUtils.Toast(localize("请通关上一关卡"))
        return
    end

    local questId      = trackingDataEntity.questId
    local activityUUid = MapDecryptionMgr:GetActivityUUId()
    MapDecryptionUtils.EnterTeamChoose(
        questId, 
        activityUUid, 
        {
            UIArgs(MapDecryptionUtils.GetDialogId(MapDecryptionUtils.DialogType.ExploreTrack))
        }
    )
    KCookie.Set(MapDecryptionConstants.EventNames.TrackQuestId, questId)

end

-- 点击 "扫荡" 按钮, 进入 "扫荡" 界面:
function MapDecryptionTrackingPanel:OnClickFontStyleButton2Action()
    ---@type MapDecryptionTrackingDataEntity
    local trackingDataEntity = self._trackingDataEntityList[self._trackingIndex]
    local questId            = trackingDataEntity.questId
    local isPass             = QuestConfMgr:GetInstance():IsPassQuest(questId)
    if isPass then
        local activityUUid = MapDecryptionMgr:GetActivityUUId()
        CfUtils.DialogOpen(Constants.UITypeIds.UISweepPrepareDialog, { questId = questId, activityUuid = activityUUid } )
    else
        GameUtils.Toast(localize("首次通关后解锁扫荡"))
    end
end

--- OnClickTrackingNodeAction
---@param entity MapDecryptionTrackingDataEntity
---@param index number
---@param luaEnv MapDecryptionMapTrackingNode
function MapDecryptionTrackingPanel:OnClickTrackingNodeAction(entity, index, luaEnv)
    if self._trackingIndex == index then return end

    local oldTrackingIndex = self._trackingIndex
    self._trackingIndex = index
    luaEnv:FreshSelectState(true)
    self:FreshSelectState(oldTrackingIndex, false)

    self:FreshUI()

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionTrackingPanel
