------------ import ------------
local KTool               = CS.Engine.Lib.KTool
local KCookie             = CS.Engine.Lib.KCookie
local URPCameraController = CS.Game.Native.URP.URPCameraController
local UIRaycastBlocker    = CS.Engine.UI.UIRaycastBlocker.Instance
local cs_coroutine        = require 'XLua.cs_coroutine'
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
---@type Engine.Lib.Yielders
local Yielders          = CS.Engine.Lib.Yielders
---@type CardProgressionUtils
local CardProgressionUtils = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaCardsEntryPerspectivePanel.prefab
---@class CardProgressionEntryPanel
---@field Env                           	CardProgressionEntryPanel               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PanelCanvas                   	UnityEngine.Canvas                      @ 自身的Canvas
---@field CommonFilterNode              	UnityEngine.RectTransform               @ 过滤选项节点
---@field ImgShadow3                    	UnityEngine.RectTransform               @ 过滤阴影节点
---@field Text                          	Game.Native.Common.UISwitchText         @ 前往详情文本
---@field FontStyleButton               	Game.Native.Common.FontStyleButton      @ 前往详情按钮
---@field BtnReward                     	UnityEngine.RectTransform               @ 收集奖励按钮
---@field CollectTextNumber             	TMPro.TextMeshProUGUI                   @ 收集率文本
---@field Collect                       	UnityEngine.RectTransform               @ 收集信息节点
---@field EmptyNode                     	UnityEngine.RectTransform               @ 列表空状态节点
---@field ScrollView                    	SuperScrollView.LoopGridView            @ 卡牌滚动列表
local CardProgressionEntryPanel = Class("CardProgressionEntryPanel")

------------ define ------------
local PrefabName           = "CultivateHeadItemNode"
local CardHeadNodePath     = "Game.CardProgression.Entry.CardProgressionEntryCardHeadCell"
local UICommonFilterMBPath = 'Game.Behaviours.UICommonFilterMB' --通用筛选条的逻辑

local isNull         = isNull
local checkNumber    = checkNumber
local GoodsSameCard  = Constants.IDType.GoodsSameCard



local EffectType = {
    Fly     = 1,
    Open    = 2,
    Compose = 3
}

local EffectPath = {
    [EffectType.Fly]  = "Effect/prefab/ui_prefab/UIFX_CardParticlFly.prefab",
    [EffectType.Open] = "Effect/prefab/ui_prefab/UIFX_CultivateCardsOpen.prefab",
    [EffectType.Compose] = "Effect/prefab/ui_prefab/UIFX_CultivateModelCompose.prefab"
}

-- local FrostedSceneCameraPath = "Prefabs/Runtime/FrostedSceneCamera.prefab"

------------ define ------------

function CardProgressionEntryPanel:__init()
    self.effectGos     = {}
    -- self.effectLoaders = {}
    self.playAniIndex = {}
    self.count = 0
    ---@type CardProgressionEntity
    self.selectCardEntity = nil
end


function CardProgressionEntryPanel:__delete()
    self.effectGos = nil
    -- if not isNull(self.go) then
    --     KTool.SafeDelete(self.go.gameObject)

    -- end
    -- for k, loader in pairs(self.effectLoaders) do
    --     loader:Release(true)
    -- end
    -- self.effectLoaders = nil
end

function CardProgressionEntryPanel:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickCultivateButtonAction))
    SetButtonAction(self.BtnReward, Bind(self, self.OnClickCollectRewardButtonAction))
    -- KTool.SetActive(URPCameraController.Instance.worldUICamera.gameObject, true)
    -- self.go = GameUtils.LoadBundleSync(FrostedSceneCameraPath, URPCameraController.Instance.mainCamera.gameObject)

    local rewardRedPointNode = self.BtnReward.transform:Find('redPoint')
    ---@param node RedPointDojo
    GameUtils.BindRedPoint(Constants.RedPointConst.StrengthenAddition, rewardRedPointNode, true, nil, function(node)
        CfUtils.SetActive(rewardRedPointNode, node.pointNum > 0)
    end)
    
    self.PanelCanvas.worldCamera = URPCameraController.Instance.uiCamera

    self:InitData()

end


function CardProgressionEntryPanel:OnDestroy()
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.StrengthenAddition)
    self.cardLoadCo = nil
    -- KTool.SetActive(URPCameraController.Instance.worldUICamera.gameObject, false)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end

---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionEntryPanel:InitData()
    local cardEntityList, cardCount, maxCount = CardProgressionUtils.GenerateAllEntity()
    self.originCardEntityList = cardEntityList
    self.cardCount         = cardCount
    self.maxCardNum        = maxCount

end


function CardProgressionEntryPanel:InitView(isFromHome)
    -- KTool.SetActive(self.AttrTextImg.gameObject, true)
    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    
    self:InitFilter(self.originCardEntityList)
    self:FreshCardInfo(true, isFromHome)
    self:FreshCollect()

end


function CardProgressionEntryPanel:InitFilter(cardEntitys)
    -- self.cardEntitys = cardEntitys

    ---@type UICommonFilterMB
    local filterNodeEnv = CfUtils.GetLuaScr(self.CommonFilterNode.gameObject, UICommonFilterMBPath)
    if isNull(filterNodeEnv) then return end
    -- filterNodeEnv:SetUIRenderCamera(URPCameraController.Instance.worldUICamera)
    filterNodeEnv:SetStyleType(2)
    filterNodeEnv:SetCloseButtonStateUpdateCallback(function (isShow)
        KTool.SetActive(self.ImgShadow3.gameObject, isShow)
    end)
    -- filterNodeEnv:SetPageType(Constants.UIFilterPageType.PullUP)
    filterNodeEnv:SetCallback(cardEntitys, function(data)
        self.cardEntityList = data
        ------------------------
        --- 排序后重置下标
        self.index = 0
        local goodsId = self.selectCardEntity.cardId
        ---@param cardEntitys CardProgressionEntity[]
        for i, cardEntity in ipairs(data) do
            if cardEntity.cardId == goodsId then
                self.index = i
                break
            end
        end
        
        self:FreshGridView()
    end, Constants.UISortType.CardEntry)

    filterNodeEnv:RestoreState(Constants.UICacheDataKeys.UICultivateEntryFilterState, function(data)
        self.cardEntityList = data
        local index
        ---@warn: 由于 Constants.UICacheDataKeys.UICultivatePlayerCardId 再这里只用一次  如果筛选为空 再reload lua 会报错
        local playerCardId = KCookie.Get(Constants.UICacheDataKeys.UICultivatePlayerCardId)
        if playerCardId then
            KCookie.Set(Constants.UICacheDataKeys.UICultivatePlayerCardId)
             ---@param cardEntity CardProgressionEntity
            for i, cardEntity in ipairs(data) do
                if checkNumber(cardEntity.playerCardId) == playerCardId then
                    self.selectCardEntity = cardEntity
                    index = i
                    break
                end
            end

            --- 从情报界面返回后 可能出现找不到下标的情况（被筛选过） 需要在源数据种找数据
            if index == nil then
                ---@param cardEntity CardProgressionEntity
                for i, cardEntity in ipairs(cardEntitys) do
                    if cardEntity.playerCardId == playerCardId then
                        self.selectCardEntity = cardEntity
                        break
                    end
                end
            end
            self.index = index
        else
            self.index = 1
            self:InitSelectCardEntity()

        end
        self:FreshGridView(index)

    end)
end

function CardProgressionEntryPanel:InitSelectCardEntity()
    ---@type CardProgressionEntity
    local cardEntity = self:GetSelectCardEntity()
    self.selectCardEntity = cardEntity
    return cardEntity
end

---------------------------------------------------
--- init end --
---------------------------------------------------

---------------------------------------------------
--- ui logic begin --
---------------------------------------------------

function CardProgressionEntryPanel:FreshCollect()
    local cardCount, maxCardNum = self.cardCount, self.maxCardNum
    self.CollectTextNumber.text = string.format("%s%%", math.min(math.floor(cardCount / maxCardNum * 100), 100))

end



function CardProgressionEntryPanel:FreshCardInfo(isInit, isFromHome)
    ---@type CardProgressionEntity
    local cardEntity = self.selectCardEntity

    --- 刷新UI
    self:FreshCardEntityInfo(cardEntity)

    -- ---@type CardVo
    -- local cardVo = CardConfMgr:GetInstance():GetCardByRefId(cardEntity.cardDojo.cardId)

    ---@type CardProgressionControllerRole
    local controllerEnv = self._controllerEnv
    if not isNull(controllerEnv) and not isFromHome then
        --if controllerEnv:GetIsActiveCatRoot() then
        --    Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
        --end
        local cameraParams = {CardProgressionConstants.CameraState.CultivateRoleLeftFull, isInit}
        -- print("fogOfWar.SetTile(currentPlayerTile + new Vector3Int(x, y, 0), null);", table.toString(cameraParams))
        ---@type CardDojo
        local cardDojo     = cardEntity.cardDojo
        controllerEnv:LoadRole(cardEntity.cardDojo.cardSkin, false, cameraParams, false, cardDojo)

    end
    
end


--FreshGridView
---刷新gridview列表数据
function CardProgressionEntryPanel:FreshGridView(index)
    local cardEntityList = self.cardEntityList
    --刷新列表
    local len = #cardEntityList
    ---@type SuperScrollView.LoopGridView
    local gridView = self.ScrollView
    local isShowList = len > 0
    KTool.SetActive(gridView.gameObject, isShowList)
    KTool.SetActive(self.EmptyNode.gameObject, not isShowList)
    if isShowList then
        if gridView.IsListViewInit then
            GameUtils.ReloadData(gridView, len)
        else
            gridView:InitGridView(len, Bind(self, self.OnGetItemByIndex))
            local cellSizeW              = gridView.ItemSizeWithPadding.x;
            local cellShowNum            = math.floor(gridView.ViewPortWidth / cellSizeW)
            local whollyDisplayItemCount = cellShowNum * gridView.MFixedRowOrColumnCount
            if index and index > whollyDisplayItemCount then
                gridView:MovePanelToItemByIndex(index - 1, 80)
            end
        end

    end

    local gridView = self.ScrollView
    local confData = gridView:GetItemPrefabConfData(PrefabName)
    local mItemPrefab = confData.mItemPrefab

    local rt        = gridView.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local w         = rt.rect.width
    local transform = mItemPrefab:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local w1        = transform.rect.width

    self.maxShowCount = math.ceil(w / w1) + ((index ~= nil and index > 2) and 1 or 0)

end


---OnGetItemByIndex
---@param listView SuperScrollView.LoopGridView
---@param index number
---@return SuperScrollView.LoopGridView
function CardProgressionEntryPanel:OnGetItemByIndex(listView, index, row, column)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(PrefabName)
    ---@type Engine.Modules.LuaBehaviour
    local headNode = GetLuaBehaviour(cell.gameObject, CardHeadNodePath)
    ---@type CardProgressionEntryCardHeadCell
    local env = headNode.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        --是否需要cell的init的逻辑
        headNode:Init()
        env = headNode.Env
        env:InitUI()
        env:SetCallBack(Bind(self, self.OnClickHeadNodeAction))
        self.count = self.count + 1
        
    end
    if not KTool.IsNull(headNode) then
        local position = index + 1
        local isDelay =  not self.playAniIndex[self.count] and (self.maxShowCount == nil or checkInt(self.count / 2) <= self.maxShowCount)
        if isDelay then
            self.playAniIndex[self.count] = true
        end
        ---@type CardProgressionEntity
        local cardEntity = self.cardEntityList[position]
        if isTable(cardEntity) then
            env:FreshUI(cardEntity, position, self.index == position, isDelay, self.count)

        end
    end
    return cell
end

function CardProgressionEntryPanel:FreshCellSelectStateByIndex(index, isShow)
    local cell = self.ScrollView:GetShownItemByItemIndex(index - 1)
    if isNull(cell) then return end
    ---@type CardProgressionEntryCardHeadCell
    local env  = CfUtils.GetLuaScr(cell.gameObject, CardHeadNodePath)
    if isNull(env) then return end
    env:FreshSelectState(isShow)
end

---FreshCardEntityInfo
---@param cardEntity CardProgressionEntity 
function CardProgressionEntryPanel:FreshCardEntityInfo(cardEntity)
    if not cardEntity then return end

    ---刷新锁的显示状态
    local goodsType  = cardEntity.goodsType
    local isSameCard = goodsType == GoodsSameCard

    ---刷新按钮的显示状态
    self.Text.Status = isSameCard and 2 or 1
    self.FontStyleButton:SetDisableFontStyle(cardEntity.typePriority == 1)
end

function CardProgressionEntryPanel:FreshCellSelectStateByIndex(index, isShow)
    local cell = self.ScrollView:GetShownItemByItemIndex(index - 1)
    if isNull(cell) then return end
    ---@type CardProgressionEntryCardHeadCell
    local env  = CfUtils.GetLuaScr(cell.gameObject, CardHeadNodePath)
    if isNull(env) then return end
    env:FreshSelectState(isShow)
end

---StoreFilterState
---记录筛选状态
function CardProgressionEntryPanel:StoreFilterState()
    ---@type UICommonFilterMB
    local filterNodeEnv = CfUtils.GetLuaScr(self.CommonFilterNode.gameObject, UICommonFilterMBPath)
    if isNull(filterNodeEnv) then return end
    return filterNodeEnv:SaveState(Constants.UICacheDataKeys.UICultivateEntryFilterState)
end


---------------------------------------------------
--- ui logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin --
---------------------------------------------------

function CardProgressionEntryPanel:GetRootGo()
    return self.rootGo
end
function CardProgressionEntryPanel:SetRootGo(rootGo)
    self.rootGo = rootGo
end

function CardProgressionEntryPanel:SetEnterCallback(cb)
    self.callback = cb
end

function CardProgressionEntryPanel:GetEffectByType(effectType, parent)
    if self.effectGos[effectType] then
        local go = self.effectGos[effectType] 
        if parent then
            KTool.SetParent(go, parent)
        end
        return self.effectGos[effectType] 
    end
    local effectPath = EffectPath[effectType]
    local go = GameUtils.LoadBundleSync(effectPath, parent, nil, true)
    -- go.transform:ResetLocal()
    self.effectGos[effectType] = go
    -- self.effectLoaders[effectType] = loader
    return go
end

---GetSelectCardEntity
---获取选择的卡牌数据
---@return CardProgressionEntity
function CardProgressionEntryPanel:GetSelectCardEntity()
    ---@type CardProgressionEntity
    return self.cardEntityList[self.index]
end

---------------------------------------------------
--- get/set end --
---------------------------------------------------


---------------------------------------------------
--- handler begin --
---------------------------------------------------

function CardProgressionEntryPanel:OnClickHeadNodeAction(index, cellEnv)
    -- if true then
    --     ---@type CardProgressionUtils
    --     local CardProgressionUtils      = import("Game.CardProgression.CardProgressionUtils")
    --     ---@type CardProgressionControllerRole
    --     local env = CardProgressionUtils.GetRoleControllerEnv()
    --     if not isNull(env) then
    --         env:FreshCameraState(3)
    --     end
    --     return
    -- end

    if self.index == index then return end

    --- 1. 更新旧的选中状态
    if self.index and self.index > 0 then
        self:FreshCellSelectStateByIndex(self.index, false)
    end

    ---2. 更新选中下标
    self.index = index

    ---3. 更新选中状态
    cellEnv:FreshSelectState(true)

    ---4. 重新初始化选择的数据
    self:InitSelectCardEntity()

    ---5. 重新初始化选择的数据  
    self.cardLoadCo = self:FreshCardInfo()

end

function CardProgressionEntryPanel:OnClickCollectRewardButtonAction()
    CfUtils.DialogOpen(Constants.UITypeIds.CardProgressionCollectRewardsDialog)
end

function CardProgressionEntryPanel:OnClickCultivateButtonAction()
    ---@type CardProgressionEntity 
    local selectCardEntity = self.selectCardEntity
    if self.callback then
        self.callback()
    end

    if isNull(self.cardLoadCo) then
        self:EnterMain(selectCardEntity)
    else
        UIRaycastBlocker:AddCondition("CardProgressionEntryPanel.EnterMain")
        cs_coroutine.start(function ()
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
            UIRaycastBlocker:RemoveCondition("CardProgressionEntryPanel.EnterMain")
            self:EnterMain(selectCardEntity)
        end)

    end

    ---typePriority -> 1: 碎片不足不能合成 2: 能合成 3: 完整卡
    -- local typePriority     = selectCardEntity.typePriority

    -- if typePriority == 3 then
    --     if self.callback then
    --         self.callback()
    --     end

    --     if isNull(self.cardLoadCo) then
    --         self:EnterMain(selectCardEntity)
    --     else
    --         UIRaycastBlocker:AddCondition("CardProgressionEntryPanel.EnterMain")
    --         cs_coroutine.start(function ()
    --             cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.2))
    --             UIRaycastBlocker:RemoveCondition("CardProgressionEntryPanel.EnterMain")
    --             self:EnterMain(selectCardEntity)
    --         end)

    --     end
        
    -- elseif typePriority == 2 then
    --     self:RequestCardComposite(selectCardEntity)

    -- else
    --     GameUtils.Toast(localize("情绪武装碎片不足"))

    -- end
end

function CardProgressionEntryPanel:EnterMain(selectCardEntity)
    if not selectCardEntity then return end
    local playerCardIds = CardProgressionUtils.GetPlayerIdsByEntityList(self.cardEntityList)
    
    ---@type CardComponent
    local cardComp    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    cardComp:SetNewByCardId(selectCardEntity.cardId, false)

    ---存筛选状态
    self:StoreFilterState()
    CardUtils.ShowCultivateMain({
        playerCardIds    = playerCardIds,
        playerCardId     = selectCardEntity.playerCardId,
        --selectCardEntity = selectCardEntity,
        isFromEntry      = true,
        subViewType      = Constants.CultivateMainSubViewType.Information
    }, {
        { id = Constants.UITypeIds.CultivateEntry }
    }) 
end

---------------------------------------------------
--- handler end --
---------------------------------------------------

return CardProgressionEntryPanel
