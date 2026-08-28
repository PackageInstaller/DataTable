--- 养成-时装界面

------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie

---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type GoodsConfMgr
local goodsConfMgr             = GoodsConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionMgr
local CardProgressionMgr       = import("Game.CardProgression.CardProgressionMgr")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils     = import("Game.CardProgression.CardProgressionCombatEffUtils")
---@type IdolLive3D_Utils
local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')
---@type IdolLive3D_Loader
local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')

---@type CardSkinComponent
local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
------------ import ------------


------------ define ------------
local LabelType = {
    Role = 1, --- 人物模型
    Cat  = 2, --- 猫模型
    Skin = 3, --- 人物立绘
}

local AttrAddId2V = {}

local AnimationName = "UI_CommonCellShowAlpha"
local CookieName    = "CardProgressionFashion.labelType"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFashion.prefab > name: CultivateOverseaFashion
---@class CardProgressionFashion
---@field Env                           	CardProgressionFashion                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnLabelNode3                 	UnityEngine.RectTransform               	@ 0    
---@field BtnLabelNode2                 	UnityEngine.RectTransform               	@ 1    
---@field BtnLabelNode1                 	UnityEngine.RectTransform               	@ 2    
---@field BtnEnlarge                    	UnityEngine.RectTransform               	@ 3    
---@field BtnLeaveFor                   	UnityEngine.RectTransform               	@ 4    
---@field BtnInteractive                	UnityEngine.RectTransform               	@ 5    
---@field LeaveForButton                	UnityEngine.RectTransform               	@ 6    
---@field TextDesc                      	UnityEngine.UI.Text                     	@ 7    
---@field TextDesc2                     	Game.Native.Common.UISwitchText         	@ 8    
---@field Lock                          	UnityEngine.RectTransform               	@ 9    
---@field EmptyAttribute                	UnityEngine.RectTransform               	@ 10   
---@field LevelUpButton                 	Game.Native.Common.FontStyleButton      	@ 11   
---@field LevelUp                       	UnityEngine.RectTransform               	@ 12   
---@field WearButton                    	Game.Native.Common.FontStyleButton      	@ 13   
---@field ButtonClickWear               	UnityEngine.RectTransform               	@ 14   
---@field CurrentWear                   	UnityEngine.RectTransform               	@ 15   
---@field StatusWear                    	UnityEngine.RectTransform               	@ 16   
---@field MaskRoot                      	UnityEngine.RectTransform               	@ 17   
---@field BtnLevel                      	UnityEngine.RectTransform               	@ 18   
---@field BtnLevelText                  	Game.Native.Common.UISwitchText         	@ 19   
---@field ItemAttribute                 	UnityEngine.RectTransform               	@ 20   
---@field ScrollView                    	SuperScrollView.LoopListView2           	@ 21   
---@field BtnPreview                    	UnityEngine.RectTransform               	@ 22   
---@field RoleRareNode                  	UnityEngine.RectTransform               	@ 23   
---@field DrawingNodeAnim               	UnityEngine.Animation                   	@ 24   
---@field DrawingNode                   	Game.Native.Common.DrawingNode          	@ 25   
local CardProgressionFashion = Class('CardProgressionFashion')

function CardProgressionFashion:__init()
    self._isInitialize = false
    self._selectedIndex = 1
    local labeType = CfUtils.CookieLoad(CookieName)
    if labeType then
        CfUtils.CookieSave(CookieName)
        self._selectedLabelType = checkNumber(labeType)

    else
        self._selectedLabelType = LabelType.Role

    end

    self._isMaxLv = false
end

function CardProgressionFashion:__delete()

end

function CardProgressionFashion:Awake()
    
end

function CardProgressionFashion:Start()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnEnlarge,     Bind(self, self.OnClickBtnEnlargeAction))
    SetButtonAction(self.BtnPreview,     Bind(self, self.OnClickBtnPreviewAction))
    SetButtonAction(self.WearButton,     Bind(self, self.OnClickWearButtonAction))
    SetButtonAction(self.LevelUpButton,  Bind(self, self.OnClickLevelUpButtonAction))
    SetButtonAction(self.LeaveForButton, Bind(self, self.OnClickBtnLeaveForAction))
    SetButtonAction(self.BtnInteractive, Bind(self, self.OnClickBtnInteractiveAction))
    SetButtonAction(self.BtnLevel,       Bind(self, self.OnClickBtnLevelAction))

    CardProgressionUtils.RegRoleSwipeRegion(self.controller, function()
        return self._selectedLabelType ~= LabelType.Skin
    end)
end

function CardProgressionFashion:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

--- OnInitialize
---@param entity CardProgressionEntity
function CardProgressionFashion:OnInitialize(entity)
    if self._isInitialize then return end
    self._isInitialize = false
    self:RequestInterface()

    self._entity = entity

    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    self._playerDojo = playerComponent:GetPlayerDojo()

    self._labelType2Node = {
        [LabelType.Role] = self.BtnLabelNode1,
        [LabelType.Cat] = self.BtnLabelNode2,
        [LabelType.Skin] = self.BtnLabelNode3,
    }

    local jumpIds = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.FashionJumpIds), ";")
    local jumpId2Res = {}
    for i, v in ipairs(jumpIds) do
        jumpId2Res[checkNumber(v)] = 1
    end
    self._jumpId2Res = jumpId2Res

    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    
    -- Id2101
    self._isUnlockSystem = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id2101)

    self:InitSkinInfo(entity.cardDojo)
    self:FreshUI(true)
end

function CardProgressionFashion:RequestInterface()
    GameUtils.Request(Interfaces.OverseaCardSkinFrom, {}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        local data = response.data
        local skinFrom = data.skinFrom
        
        self._skinFrom = {}
        local curTime = os.time()
        for skinId, skinFromData in pairs(skinFrom) do
            for index, value in ipairs(skinFromData) do
                value.endTime = curTime + checkNumber(value.remainTime)
                
            end
            self._skinFrom[checkNumber(skinId)] = skinFromData
        end

        local skinInfo = self._skinData[self._selectedIndex]
        local isUnlock = skinInfo.isUnlock
        KTool.SetActive(self.Lock.gameObject,    not isUnlock)
        if not isUnlock then
            ---@type CardSkinVo
            local skinVo   = skinInfo.skinVo
            self:FreshLockNode(skinVo)
        end
    end) 
end

--- GetSkinInfo
---@param cardDojo CardDojo
function CardProgressionFashion:InitSkinInfo(cardDojo)
    local cardId = cardDojo.cardId
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local cardSkin = checkNumber(cardDojo.cardSkin)
    local equipSkinId = cardSkin > 0 and cardSkin or cardVo.defaultSkin

    local cardSkinIds = cardConfMgr:GetCardSkinsByCardId(cardId)
    local skinData    = {}
    local curIndex    = 1
    if cardSkinIds then
        local realIndex = 0
        for index, cardSkinId in ipairs(cardSkinIds) do
            ---@type CardSkinVo
            local skinVo = cardConfMgr:GetCardSkinBySkinId(cardSkinId)
            if skinVo.isHandbook then
                realIndex = realIndex + 1
                table.insert(skinData, {
                    skinVo = skinVo,
                    isUnlock = cardSkinComponent:IsHasSkin(skinVo.skinId)
                })
                if skinVo.skinId == equipSkinId then
                    curIndex = realIndex
                end
            end
        end

    end

    local skinId2MaxLvAttrAddIdInfo = {}
    local FashionSkinAttrLimit = CardProgressionConstants.FashionSkinAttrLimit
    local skinId2Lv = cardSkinComponent:GetSkinId2LvByCardId(cardId)
    CardProgressionCombatEffUtils.CalcMultiFashionProperty(skinId2Lv, AttrAddId2V, function (skinId, level, attrAddId, attrV, index)
        skinId2MaxLvAttrAddIdInfo[skinId] = skinId2MaxLvAttrAddIdInfo[skinId] or {}
        skinId2MaxLvAttrAddIdInfo[skinId][attrAddId] = true
        return index ~= nil and index >= FashionSkinAttrLimit
    end)

    
    self._skinData    = skinData
    self._selectedIndex = curIndex
    self._equipSkinIndex = curIndex
    self._skinId2MaxLvAttrAddIdInfo = skinId2MaxLvAttrAddIdInfo

end

function CardProgressionFashion:ReloadSkinInfo()
    ---@type CardDojo
    local cardDojo = self._entity.cardDojo
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardDojo.cardId)
    local cardSkin = checkNumber(cardDojo.cardSkin)
    local curIndex    = 1
    local equipSkinId = cardSkin > 0 and cardSkin or cardVo.defaultSkin
    ---@type CardSkinComponent
    local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
    for i, v in ipairs(self._skinData) do
        local skinId =  v.skinVo.skinId
        v.isUnlock = cardSkinComponent:IsHasSkin(v.skinVo.skinId)
        if skinId == equipSkinId then
            curIndex = i
        end
    end

    local isChange = self._equipSkinIndex ~= curIndex
    self._equipSkinIndex = curIndex
    return isChange
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
function CardProgressionFashion:FreshUI(isInitialize)
    ---@type CardDojo
    local cardDojo = self._entity.cardDojo
    self:FreshRoleRareNode(cardDojo:GetRare(), cardDojo.cardId)
    
    self:FreshScrollView()
    
    self:FreshSkinInfoPanel(isInitialize)
    
    self:FreshFashion()

end

function CardProgressionFashion:FreshSkinInfoPanel(isInitialize)
    local skinInfo = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo

    local attrAddId2V = self:GetAttributes(skinVo)
    
    self:FreshAttributes(skinInfo.isUnlock, attrAddId2V)

    self:FreshBottomGroup(skinVo, skinInfo.isUnlock, attrAddId2V)

    self:FreshFashionLabelNodes(isInitialize)

    self:FreshBtnInteractive()

    
end

function CardProgressionFashion:FreshDrawingNode(skinId)
    self.DrawingNodeAnim:Play(AnimationName)
    self.DrawingNode:Execute(skinId)

end

function CardProgressionFashion:FreshRoleRareNode(rare, cardId)
    ---@type CardProgressionRoleRareNode
    local env = CfUtils.GetLuaScr(self.RoleRareNode, CardProgressionConstants.EnvPath.CardProgressionRoleRareNode)
    if isNull(env) then return end
    env:FreshUI(rare, cardId)
        
end

function CardProgressionFashion:FreshScrollView()
    local ScrollView = self.ScrollView
    local count = #self._skinData
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
        ScrollView:MovePanelToItemIndex(self._selectedIndex - 1)
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end


function CardProgressionFashion:OnGetItemByIndex(listView, index, row, column)
    if index < 0 then return nil end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)

    local cellViewMB = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionFashionCell)
    ---@type CardProgressionFashionCell
    local mbEnv = cellViewMB.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        if cellViewMB.Env == nil then
            cellViewMB:Init()
        end
        mbEnv = cellViewMB.Env
        mbEnv:SetCallback(Bind(self, self.OnClickFashionCellAction))
    end

    
    if mbEnv == nil then return end
    local pos = index + 1
    mbEnv:FreshUI(self._skinData[pos], pos, self._equipSkinIndex)
    mbEnv:FreshSelectState(pos == self._selectedIndex)

    return cell
end

function CardProgressionFashion:FreshFashionCellSelectState(index, isSelect)
    local node = self.ScrollView:GetShownItemByItemIndex(index - 1)
    ---@type CardProgressionFashionCell
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionCell)
    if isNull(env) then return end
    env:FreshSelectState(isSelect)
end

function CardProgressionFashion:FreshFashionCellNewState(index, skinId)
    local node = self.ScrollView:GetShownItemByItemIndex(index - 1)
    ---@type CardProgressionFashionCell
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionCell)
    if isNull(env) then return end
    env:FreshImgNewShowState(skinId)
end

function CardProgressionFashion:FreshAttributes(isUnlock, t)
    if not isUnlock then
        KTool.SetActive(self.MaskRoot.gameObject, false)
        CfUtils.SetActive(self.EmptyAttribute, false)
        CfUtils.SetActive(self.BtnLevel, false)
        -- CfUtils.SetActive(self.TextDesc2, false)
        return
    end
    
    local isShow = t ~= nil
    KTool.SetActive(self.MaskRoot.gameObject, isShow)
    CfUtils.SetActive(self.BtnLevel, isShow)
    -- CfUtils.SetActive(self.TextDesc2, not isShow)
    CfUtils.SetActive(self.EmptyAttribute, not isShow)
    
    if not isShow then return end
    
    ---@type CardProgressionAttributeGroupNode
    local env = CfUtils.GetLuaScr(self.ItemAttribute, CardProgressionConstants.EnvPath.CardProgressionAttributeGroupNode)
    if isNull(env) then return end
    env:FreshUI(t, false, false, CardProgressionConstants.EnvPath.CardProgressionFashionAttributeNode)

end

---FreshBottomGroup
---@param skinVo CardSkinVo
---@param isUnlock boolean
function CardProgressionFashion:FreshBottomGroup(skinVo, isUnlock, attrAddId2V)
    local isEquipped = self._equipSkinIndex == self._selectedIndex
    -- KTool.SetActive(self.CurrentWear.gameObject, isEquipped)
    KTool.SetActive(self.ButtonClickWear.gameObject, isUnlock and not isEquipped)
    KTool.SetActive(self.BtnLeaveFor.gameObject, false)
    local skinMaxLevel = skinVo.skinMaxLevel
    local isShow = self._isUnlockSystem and isUnlock and skinMaxLevel > 1
    KTool.SetActive(self.LevelUp.gameObject, isShow and cardSkinComponent:GetSkinLevelById(skinVo.skinId, skinMaxLevel) < skinMaxLevel)
    if isShow then
        local isMaxLv = cardSkinComponent:GetSkinLevelById(skinVo.skinId, skinMaxLevel) >= skinMaxLevel
        self.LevelUpButton:ResetFontStyle(isMaxLv and "B18" or "B7", isMaxLv and localize("已满级") or localize("升级"))
    end

    local isShowLock = not isUnlock and self._skinFrom ~= nil
    KTool.SetActive(self.Lock.gameObject,    isShowLock)
    if isShowLock then
        self:FreshLockNode(skinVo)
        local isShowAttr = attrAddId2V ~= nil
        self.TextDesc2.Status = isShowAttr and 1 or 2
    end
end

--- FreshLockNode
---@param skinVo CardSkinVo
function CardProgressionFashion:FreshLockNode(skinVo)
    local skinId = skinVo.skinId
    local text, row = self:GetUnlockInfo(skinId, skinVo)
    local isShowDesc = text ~= nil
    self._row = row
    KTool.SetActive(self.TextDesc.gameObject, isShowDesc)
    KTool.SetActive(self.BtnLeaveFor.gameObject, row ~= nil)
    if isShowDesc then
        self.TextDesc.text = text

    end
    
end

function CardProgressionFashion:FreshFashionLabelNodes(isInitialize)
    for labelType, node in pairs(self._labelType2Node) do
        self:FreshFashionLabelNode(labelType, node, isInitialize)
    end
end

function CardProgressionFashion:FreshFashionLabelNode(labelType, node, isInitialize)
    ---@type CardProgressionFashionLabelNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionLabelNode)
    if isNull(env) then return end
    
    local isUnlock
    if labelType == LabelType.Role then
        isUnlock = true
    else
        local skinInfo   = self._skinData[self._selectedIndex]
        isUnlock = skinInfo.isUnlock
    end
    env:FreshUI(isUnlock)
    env:FreshSelectState(self._selectedLabelType == labelType, isInitialize)
    env:SetCallback(function ()
        if self._selectedLabelType == labelType then
            return
        end
        if not isUnlock then
            GameUtils.Toast(localize("尚未解锁"))
            return
        end

        self:FreshFashionLabelNodeSelectState(self._selectedLabelType, false)
        self._selectedLabelType = labelType
        env:FreshSelectState(true)
        self:FreshFashion(true)
    end)
end

function CardProgressionFashion:FreshFashionLabelNodeSelectState(labelType, isSelect)
    local node = self._labelType2Node[labelType]
    ---@type CardProgressionFashionLabelNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFashionLabelNode)
    if isNull(env) then return end
    env:FreshSelectState(isSelect)
end

function CardProgressionFashion:FreshFashion(isEnter)
    local skinInfo = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo
    local labelType = self._selectedLabelType
    KTool.SetActive(self.DrawingNode.gameObject, labelType == LabelType.Skin)

    KTool.SetActive(self.BtnEnlarge.gameObject, labelType ~= LabelType.Skin)
    local DOTween                  = CS.DG.Tweening.DOTween
    DOTween.KillAll()
    if labelType == LabelType.Role then
        --Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, true, false)
        if not isNull(self._controllerEnv) then
            ---@type CardDojo
            local cardDojo = self._entity.cardDojo
            
            self._controllerEnv:LoadRole(skinVo.skinId, true, {CardProgressionConstants.CameraState.CultivateRoleFull, not isEnter}, false, cardDojo, true)
        end

    elseif labelType == LabelType.Cat then
        --Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
        if not isNull(self._controllerEnv) then
            self._controllerEnv:LoadCat(skinVo.skinId, {CardProgressionConstants.CameraState.CultivateCatFull, not isEnter})
        end
        
    elseif labelType == LabelType.Skin then
        if not isNull(self._controllerEnv) then
            self._controllerEnv:FreshCameraStateByParams({CardProgressionConstants.CameraState.CultivateRoleAndCatHide})
        end
        self:FreshDrawingNode(skinVo.skinId)

    end
    
end


--- OnEnter
--- 进入时调用
function CardProgressionFashion:OnEnter()
    self:FreshFashion(true)
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionFashion:OnLeave()
    
    
end

--- OnReload
--- 重载界面  切换卡牌
---@param entity CardProgressionEntity
function CardProgressionFashion:OnReload(entity)
    local oldEntity = self._entity
    self._entity    = entity
    if entity.cardId ~= oldEntity.cardId then
        self:InitSkinInfo(entity.cardDojo)
    else
        local isChange = self:ReloadSkinInfo()
        if isChange and self._combatEffectiveness then
            local combatEffectiveness = FormulaUtils.CalcCardCombatEffectiveness(entity)
            if combatEffectiveness ~= self._combatEffectiveness then
                CardProgressionUtils.ChangePointToast(combatEffectiveness - self._combatEffectiveness)
            end
            self._combatEffectiveness = nil
        end
    end
    self:FreshUI()
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

--- GetUnlockInfo
---@param skinId number 皮肤id
---@param skinVo CardSkinVo 皮肤VO
function CardProgressionFashion:GetUnlockInfo(skinId, skinVo)
    local res, text, row, skinActivityInfo = self:CheckSkinPlacement(skinId, skinVo)
    self._skinActivityInfo = skinActivityInfo
    if res then
        return text, row
    end
    local text, row
     ---@type GoodsVo
     local goodsVo  = goodsConfMgr:GetGoodsVoById(skinId)
     local jumpAway = goodsVo.jumpAway
     local isShowJumpAway = jumpAway ~= nil and #jumpAway > 0
     if isShowJumpAway then
        local jumpId2Res = self._jumpId2Res
        for i, v in ipairs(jumpAway) do
            local row = goodsConfMgr:GetJumpModuleRow(v)
            if jumpId2Res[v] then
                return text, row
            else
                local functionName = GoodsUtils.GetFunctionName(row, goodsVo, i)
                text = functionName
                --  table.insert(t, functionName)
                --  count = count + 1

            end
        end
 
     end
     return text, row
end

--- CheckSkinPlacement
---@param skinId number 皮肤id
---@param skinVo CardSkinVo 皮肤VO
function CardProgressionFashion:CheckSkinPlacement(skinId, skinVo)
    local jump = skinVo.jump
    if jump <= 0 then
        return false
    end
    ---@type SkinPlacementRouteVo
    local vo = cardConfMgr:GetSkinPlacementRouteVoById(jump)
    if vo.btn == 0 then
        return false
    end

    local placementType = vo.type
    local functionId = vo.functionId
    if placementType    == CardProgressionConstants.SkinPlacementType.Module then
        local row = goodsConfMgr:GetJumpModuleRow(functionId)
        return true, vo.name, row
    elseif placementType == CardProgressionConstants.SkinPlacementType.Activity then
        local skinFromData = self._skinFrom[skinId]
        if skinFromData == nil then
            return false
        end

        local curTime = os.time()
        local res = false
        local skinActivityInfo
        for index, value in ipairs(skinFromData) do
            if curTime < value.endTime then
                skinActivityInfo = value
                res = true
                break
            end
        end
        if not res then
            return false
        end
        
        local row = goodsConfMgr:GetJumpModuleRow(functionId)

        return true, vo.name, row, skinActivityInfo
    end
    return false
end


---GetAttributes
---@param skinVo CardSkinVo
function CardProgressionFashion:GetAttributes(skinVo)
    local skinMaxLevel = skinVo.skinMaxLevel
    if skinMaxLevel == 0 then
        return
    end

    local skinId2Lv = cardSkinComponent:GetSkinId2LvByCardId(skinVo.roleId)
    local skinId2AttrAddIdInfo = {}
    local FashionSkinAttrLimit = CardProgressionConstants.FashionSkinAttrLimit
    CardProgressionCombatEffUtils.CalcMultiFashionProperty(skinId2Lv, AttrAddId2V, function (skinId, level, attrAddId, attrV, index)
        skinId2AttrAddIdInfo[skinId] = skinId2AttrAddIdInfo[skinId] or {}
        skinId2AttrAddIdInfo[skinId][attrAddId] = true
        return index ~= nil and index >= FashionSkinAttrLimit
    end)


    local skinId2MaxLvAttrAddIdInfo = self._skinId2MaxLvAttrAddIdInfo
    local skinId   = skinVo.skinId


    local level             = cardSkinComponent:GetSkinLevelById(skinId, skinMaxLevel)
    level = self._isMaxLv and skinMaxLevel or level
    ---@type SkinAttributeVo
    local vo       = cardConfMgr:GetSkinAttributeVo(skinId, level)
    local attributes         = vo:GetAttributes()
    
    return CardProgressionUtils.GenerateSkinAttrTypeData(attributes, skinId2AttrAddIdInfo[skinId], skinId2MaxLvAttrAddIdInfo[skinId], self._isMaxLv, true)
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFashion:OnClickBtnEnlargeAction()
    
    ---@type CardProgressionEntity
    local entity    = self._entity
    local labelType = self._selectedLabelType
    local isCat     = labelType == LabelType.Cat and 1 or 0
    CfUtils.CookieSave(CookieName, labelType)
    local skinInfo = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.UICultivateObserveDialog, 
            { cardId = entity.cardId, cardSkin = skinVo.skinId, isCat = isCat}, {
                UIArgs(Constants.UITypeIds.CultivateMain)
            })
    
end

function CardProgressionFashion:OnClickBtnPreviewAction()
    ---@type CardProgressionEntity
    local entity = self._entity
    local cardId = entity.cardId
    CfUtils.DialogOpen(Constants.UITypeIds.CardProgressionFashionAttributePreview, {cardId = cardId})

end

function CardProgressionFashion:OnClickWearButtonAction()
    self._combatEffectiveness = checkInt(FormulaUtils.CalcCardCombatEffectiveness(self._entity))
    local skinInfo   = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo
    CardProgressionMgr:RequestOverseaCardChangeSkin({cardSkinId = skinVo.skinId, playerCardId = self._entity.cardDojo.id})

    --- 更换皮肤后, 立刻触发主界面 UIHomeDialogueNode 刷新自己的数据, 这样在跳回主界面时, 不至于显示旧皮肤的数据: (比如 爱豆3D深度互动 按钮的显示与隐藏)
    local playerCardId_ = self._entity.cardDojo.id
    local cardId_       = self._entity.cardDojo.cardId
    local skinId_       = skinVo.skinId
    if type(playerCardId_)=="number" and type(cardId_)=="number" and type(skinId_)=="number" then 
        Events.Broadcast(Constants.EventNames.UIEventHomeRoleQuickTapAction, { playerCardId = playerCardId_, cardId = cardId_, skinId = skinId_ })
    end 
end

function CardProgressionFashion:OnClickLevelUpButtonAction()
    local skinInfo   = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo
    local skinMaxLevel = skinVo.skinMaxLevel
    local isMaxLv = cardSkinComponent:GetSkinLevelById(skinVo.skinId, skinMaxLevel) >= skinMaxLevel
    if isMaxLv then
        GameUtils.Toast(localize("已满级"))
        return
    end
    local skinInfo   = self._skinData[self._selectedIndex]
    CfUtils.DialogOpen(Constants.UITypeIds.CardProgressionFashionLevelUp, {skinInfo = skinInfo, playerCardId = self._entity.cardDojo.id})
end

--- OnClickFashionCellAction
---@param index number
function CardProgressionFashion:OnClickFashionCellAction(index)
    if self._selectedIndex == index then
        return false
    end
    self:FreshFashionCellSelectState(self._selectedIndex, false)
    self._selectedIndex = index

    local skinInfo = self._skinData[index]
    local skinId   = skinInfo.skinVo.skinId
    local isNew    = cardSkinComponent:GetIsNewBySkinId(skinId)
    if isNew then
        cardSkinComponent:SetIsNewBySkinId(skinId, nil)
        Events.Broadcast(CardProgressionConstants.EventNames.UpdateFashionRedPoint)
        self:FreshFashionCellNewState(index, false)
    end
    local isUnlock = skinInfo.isUnlock
    if not isUnlock then
        self._selectedLabelType = LabelType.Role
    end
    self:FreshSkinInfoPanel(false)
    self:FreshFashion()
    return true
end

function CardProgressionFashion:OnClickBtnLeaveForAction()
    if self._row == nil then
        return
    end
    
    if self._skinActivityInfo and os.time() >= self._skinActivityInfo.endTime then
        GameUtils.Toast(localize("活动已过期"))
        return
    end
    local index    = self._selectedIndex
    local skinInfo = self._skinData[index]
    local skinId   = skinInfo.skinVo.skinId
    ---@type GoodsVo
    local goodsVo  = goodsConfMgr:GetGoodsVoById(skinId)
    local extraPara = self._skinActivityInfo ~= nil and self._skinActivityInfo.activityId or nil
    goodsConfMgr:ExecuteJump(self._row, goodsVo, 1, false, extraPara)

end



function CardProgressionFashion:FreshBtnInteractive()
    local skinInfo = self._skinData[self._selectedIndex]
    ---@type CardSkinVo
    local skinVo   = skinInfo.skinVo
    local isUnlock = skinInfo.isUnlock
    ---
    local skinId = skinInfo.skinVo.skinId
    local btnTF = self.BtnInteractive
    local btnGray = btnTF:Find("ImgIcon")

    if isUnlock and isNotNull(IdolLive3D_Utils.GetLive3DCardVoRow(skinId)) then -- 这个皮肤支持 深度互动
        if IdolLive3D_Utils.IsBuyThisSkinsLive3D(skinId) == false then -- 没额外购买这个皮肤的 深度互动服务
            CfUtils.MarkGray(btnGray.gameObject, true)
        else 
            CfUtils.MarkGray(btnGray.gameObject, false)
        end
        KTool.SetActive( btnTF.gameObject, true )
    else 
        KTool.SetActive( btnTF.gameObject, false )
    end 
end

function CardProgressionFashion:OnClickBtnInteractiveAction()
    local index    = self._selectedIndex
    local skinInfo = self._skinData[index]
    local skinId   = skinInfo.skinVo.skinId
    IdolLive3D_Loader.TryOpenScene( skinId )
end

function CardProgressionFashion:OnClickBtnLevelAction()
    self._isMaxLv = not self._isMaxLv

    self.BtnLevelText.Status = self._isMaxLv and 2 or 1
    local skinInfo = self._skinData[self._selectedIndex]
    local attrAddId2V = self:GetAttributes(skinInfo.skinVo)
    self:FreshAttributes(skinInfo.isUnlock, attrAddId2V)

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFashion
