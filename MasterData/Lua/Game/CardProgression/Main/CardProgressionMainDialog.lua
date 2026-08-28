--- 养成-主界面
--- OnReload 只更新UI显示
--- 当前卡页签切换 掉子界面 OnEnter
--- 切换卡优先掉子界面 调OnReload 无OnReload调onEnter
--- 卡牌属性刷新 掉OnReload



------------ global define ------------
local isNull = isNull
local import = import
local SafeUnpack = SafeUnpack
------------ global define ------------

------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KCookie
local KCookie                  = CS.Engine.Lib.KCookie
local cs_coroutine     = require "XLua.cs_coroutine"
local URPCameraController = CS.Game.Native.URP.URPCameraController
local DOTween                  = CS.DG.Tweening.DOTween
---@type IdolLive3D_Utils
local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')
---@type IdolLive3D_Loader
local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')

------------ import ------------


------------ define ------------
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CriWareUtils
local CriWareUtils             = import('Game.Entry.CriWareUtilsFix')
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")

local ModelType = CardProgressionConstants.ModelType

local MainViewType2CameraState = {
    [CardProgressionConstants.MainViewType.Intelligence]    = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleFull, 206},
    [CardProgressionConstants.MainViewType.Level]           = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleHalf, 206},
    [CardProgressionConstants.MainViewType.AdvanceLevel]    = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleHalf, 206},
    [CardProgressionConstants.MainViewType.Star]            = {ModelType.Portrait, CardProgressionConstants.CameraState.CultivateRoleAndCatHide, 100},
    [CardProgressionConstants.MainViewType.Equip]           = {ModelType.Cat,  CardProgressionConstants.CameraState.CultivateCatFull,  87},
    [CardProgressionConstants.MainViewType.Fashion]         = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleFull, 206},
    [CardProgressionConstants.MainViewType.ExclusiveWeapon] = {ModelType.Role, CardProgressionConstants.CameraState.ExclusiveWeapon,   206},

}
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaMainDialog.prefab > name: CultivateOverseaMainDialog
---@class CardProgressionMainDialog
---@field Env                           	CardProgressionMainDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field UIFX_Number_BoomMove          	UnityEngine.RectTransform               	@ 0    
---@field UIFX_GlowBoom                 	UnityEngine.RectTransform               	@ 1    
---@field UIFX_MoveBoom                 	UnityEngine.RectTransform               	@ 2    
---@field Container                     	UnityEngine.Animation                   	@ 3    
---@field ButtonGroup                   	UnityEngine.RectTransform               	@ 4    
---@field BtnFetter                     	UnityEngine.RectTransform               	@ 5    
---@field BtnArchives                   	UnityEngine.RectTransform               	@ 6    
---@field TextNumber                    	TMPro.TextMeshProUGUI                   	@ 7    
---@field BtnFeeling                    	UnityEngine.RectTransform               	@ 8    
---@field BtnInteractive                	UnityEngine.RectTransform               	@ 9    
---@field ImgHead                       	Engine.UI.ImageAlterable                	@ 10   
---@field BtnStylePreview               	UnityEngine.RectTransform               	@ 11   
---@field BtnRight                      	UnityEngine.RectTransform               	@ 12   
---@field BtnLeft                       	UnityEngine.RectTransform               	@ 13   
---@field CommonTabToggleLeft           	UnityEngine.RectTransform               	@ 14   
---@field ChildContainer                	UnityEngine.RectTransform               	@ 15   
---@field ContainerCanvas               	UnityEngine.Canvas                      	@ 16   
local CardProgressionMainDialog = Class('CardProgressionMainDialog')


function CardProgressionMainDialog:__init()
    -- self._mainViewType   = CardProgressionConstants.MainViewType.Intelligence
    self._mainViewEnvs   = {}
    self._mainViewCanvas = {}
    self._isShowContainerCanvas = true
    
end


function CardProgressionMainDialog:__delete()
    self.controller = nil
end


function CardProgressionMainDialog:Awake()
    self.controller.IsAutoHandleNavBar = false
    self.SwitchArrowNode = self.BtnLeft.parent

    CfUtils.SetActive(self.BtnStylePreview, false)
end


function CardProgressionMainDialog:OnFocus(focus)
    if self._focus == focus then
        if focus then
            self:FixCamera()
        end
        return
    end
    self._focus = focus
    if focus then
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
        self:FixCamera()
        self.controller:FreshNavigator()
        self:FreshContainerCanvasShowState(true)
        self:ResetBackHandle()
        self:FreshCurrencyList()
        self:PlayUnlockURSkinAni()

        if self._focusCallback then
            self._focusCallback()
            self._focusCallback = nil
        end
        
    else
        CfUtils.ResetNavigatorCustomBackAction()
        
    end
end

function CardProgressionMainDialog:FixCamera()
    GameUtils.SetUICameraProjection(false)
    CardProgressionUtils.BlockerAndStartCo("CardProgressionMainDialog.FixCamera", function()
        UICommonUtils.WaitBrainBlendingComplete()
        local mainView = self._mainViewCanvas[self._selectedTabViewType]
        self:SetChildTransform(mainView)

    end)
end


function CardProgressionMainDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- CfUtils.ChangeMainCamDefalultBlend(0.5)
        self:InitData()
        self:FreshTabs()
        self:InitListeners()
        -- self:FreshCardHead()

    end))
    return coWait
end

function CardProgressionMainDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        --- 显示养成场景
        -- Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        ---修正 <CAT-20864> [养成] 装备升级/升星跳转返回异常修复 如果 要跳入界面在OnFinalize 处理过 透视 则还会有显示问题
        -- GameUtils.SetUICameraProjection(false)
        -- cs_coroutine.yield_return()
        self:LoadModel()
        -- cs_coroutine.yield_return()
        self:FreshUI()
        self:FreshBtnShowState()

    end))
    return coWait
end

function CardProgressionMainDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local mainViewType  = self._selectedTabViewType
        local parameters = self.controller.Argument.parameters
        parameters.mainViewType = mainViewType
        parameters.playerCardId = self._selectCardEntity.playerCardId
        --parameters.selectCardEntity = self._selectCardEntity
        if parameters.playerCardIds == nil then
            local playerCardIds = CardProgressionUtils.GetPlayerIdsByEntityList(self._entityList)
            parameters.playerCardIds = playerCardIds
        end
        for i, v in pairs(self._listenerConf) do
            Events.RemoveListener(i, v)
        end

        self:FreshContainerCanvasShowState(false)
        -- GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.StrengthenFavor)
    end))
    return coWait
end


function CardProgressionMainDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:StopUnlockURSkinAni()
        for i, canvas in pairs(self._mainViewCanvas) do
            KTool.SafeDelete(canvas.gameObject)
        end
        if self._isCloseScene then
            Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, false)
        end
        --
        --local mainViewType  = self._selectedTabViewType
        --local parameters = self.controller.Argument.parameters
        --parameters.mainViewType = mainViewType
        --parameters.playerCardId = self._selectCardEntity.playerCardId
        ----parameters.selectCardEntity = self._selectCardEntity
        --if parameters.playerCardIds == nil then
        --    local playerCardIds = CardProgressionUtils.GetPlayerIdsByEntityList(self._entityList)
        --    parameters.playerCardIds = playerCardIds
        --end
        --for i, v in pairs(self._listenerConf) do
        --    Events.RemoveListener(i, v)
        --end
        --GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.StrengthenFavor)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionMainDialog:InitData()
    local parameters       = checkTable(self.controller.Argument.parameters)
    local mainViewType     = parameters.mainViewType or CardProgressionConstants.MainViewType.Intelligence
    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))
    self:InitEntityList(parameters)
    self:InitTabInfo(mainViewType)

    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    
    self._currencyList      = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MainCurrency))
    self._equipCurrencyList = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.EquipmentCurrency))

    self._redPointConfig = {
        [self.BtnFeeling.gameObject]  = CardProgressionUtils.IsCanReceiveFavorReward,
        [self.BtnArchives.gameObject] = CardProgressionUtils.IsCanReceiveStoryReward,
    }
end

--- InitTabInfo
---@param mainViewType CardProgressionConstants.MainViewType
function CardProgressionMainDialog:InitTabInfo(mainViewType)
    --- init tabs
    local MainViewType = CardProgressionConstants.MainViewType
    local tabTypes = table.values(MainViewType)
    table.sort(tabTypes, function(a, b) return a < b end)
    self._tabTypes           = tabTypes
    
    ---@type CardProgressionEntity
    local entity = self._selectCardEntity
    local MainViewConfig = CardProgressionConstants.MainViewConfig
    local tabs = {}
    local index = 1
    local selectViewType
    local viewType2Index = {}
    --local needReloadTabs = {}
    for i, v in ipairs(tabTypes) do
        --if v == mainViewType then
        --    selectIndex = i
        --end
        local config  = MainViewConfig[v]
        local tabData = self:InitTabData(config, entity, index)
        if tabData then
            table.insert(tabs, tabData)
            viewType2Index[v] = index
            if v == mainViewType then
                selectViewType = mainViewType
            end
            index = index + 1
        end
        --
        --if config.isCanReload then
        --    table.insert(needReloadTabs, { config, i })
        --    --needReloadTabs[i] = config
        --end
    end
    self._tabs               = tabs
    self._viewType2Index     = viewType2Index
    --self._needReloadTabs     = needReloadTabs
    self._selectedTabViewType = selectViewType
    
end

function CardProgressionMainDialog:ReloadTabInfo(entity)
    local newMainViewType
    local tabs            = {}
    local oldMainViewType = self._selectedTabViewType
    local MainViewConfig  = CardProgressionConstants.MainViewConfig
    local tabTypes        = self._tabTypes
    local index           = 1
    local viewType2Index = {}
    for i, v in ipairs(tabTypes) do
        local config  = MainViewConfig[v]
        local tabData = self:InitTabData(config, entity, index)
        if tabData then
            
            viewType2Index[v] = index
            index = index + 1
            table.insert(tabs, tabData)
        end
    end
    
    self._tabs = tabs
    self._viewType2Index = viewType2Index
    local oldSelectIndex = viewType2Index[oldMainViewType]
    if tabs[oldSelectIndex] == nil or tabs[oldSelectIndex].config.mainViewType ~= oldMainViewType then
        newMainViewType = tabs[1].config.mainViewType
    end
    
    return newMainViewType
    
end

--- InitTabData
---@param config CardProgressionConstants.MainViewConfig
---@param entity CardProgressionEntity
function CardProgressionMainDialog:InitTabData(config, entity, index, isReloadCardTab)
    local systemTogId = config.systemToggleId
    local name        = config.title1 and CardProgressionUtils.CheckMainViewTabTitle(config, entity) or config.title
    local isLock      = not GameUtils.IsUnlockedBySystemTogId(systemTogId)
    local isShow      = true
    local mainViewType = config.mainViewType
    if mainViewType == CardProgressionConstants.MainViewType.ExclusiveWeapon then
        local cardId = entity.cardDojo.cardId
        local ids    = cardConfMgr:GetRoleCardExclusiveWeaponIds(cardId)
        isShow = ids ~= nil
    elseif mainViewType == CardProgressionConstants.MainViewType.AdvanceLevel then
        local advanceLevel = checkNumber(entity.cardDojo.advanceLevel)
        isShow = advanceLevel < self._maxAdvanceLevel
    end

    if not isShow then
        return nil
    end
    
    local data = {
        config           = config,
        text             = name,
        textDefStatus    = isLock and 3 or 1,
        imgIconDefStatus = isLock and 3 or 1,
        isHideShadow     = true,
        lock             = isLock,
        systemTogId      = systemTogId,
        index            = index,
        redPointStrNode  = config.redPointConstant,
        func             = function()
            self:ToggleTab(mainViewType)

            return isLock and 0 or 1
        end,
    }

    data.playerCardId = (not isReloadCardTab) and entity.playerCardId or nil
    
    return data
     
end


function CardProgressionMainDialog:InitEntityList(parameters)
    ---@type CardProgressionEntity
    local selectCardEntity = nil
    local playerCardId     = parameters.playerCardId
    local playerCardIds    = parameters.playerCardIds
    local entityList       = nil
    local selectIndex      = nil
    local maxCount         = nil
    
    local function GenerateDefineProperty()
        local sortTypeData = CardProgressionUtils.GetFirstSortTypeData(Constants.UISortType.CardEntry)
        entityList         = CardProgressionUtils.SortEntryBySortType(CardProgressionUtils.GenerateAllEntity(), sortTypeData.conditionType, sortTypeData.asc)
        selectIndex, selectCardEntity, maxCount = self:InitSelectedEntityData(entityList, playerCardId)
    end

    local function GenerateDefinePropertyById(id)
        ---@type CardComponent
        local comp            = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        selectCardEntity      = CardProgressionUtils.GenerateEntityByCardDojo(comp:GetCardById(id))
        entityList = {selectCardEntity}
        selectIndex, maxCount = 1, 1
    end
    
    if playerCardIds then
        entityList = CardProgressionUtils.GenerateAllEntityByIds(playerCardIds)
        selectIndex, selectCardEntity, maxCount = self:InitSelectedEntityData(entityList, checkNumber(playerCardId))

    elseif playerCardId then
        --parameters.playerCardId = nil
        if parameters.isSingle == 1 then
            GenerateDefinePropertyById(playerCardId)
        else
            GenerateDefineProperty()
        end
        
    else
        GenerateDefinePropertyById(playerCardId)
        
    end
    
    self._selectCardEntity  = selectCardEntity
    self._selectedCardIndex = selectIndex
    self._maxCount          = maxCount
    self._entityList        = entityList
    self._jumpFrom          = parameters.JumpFrom
    self._isFromEntry       = parameters.isFromEntry
    self._forceCloseMainScene = parameters.closeMainSceneOnFinalize
end

function CardProgressionMainDialog:InitSelectedEntityData(entityList, playerCardId)
    playerCardId = checkNumber(playerCardId)
    local count = #entityList
    for i = 1, count do
        local entity = entityList[i]
        if playerCardId == checkNumber(entity.cardDojo.id) then
            return i, entity, count
        end
    end
    local index = 1
    return index, entityList[index], count
end

function CardProgressionMainDialog:InitListeners()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnLeft,         Bind(self, self.OnClickBtnLeftAction))
    SetButtonAction(self.BtnRight,        Bind(self, self.OnClickBtnRightAction))
    SetButtonAction(self.BtnFetter,       Bind(self, self.OnClickBtnFetterAction))
    SetButtonAction(self.BtnFeeling,      Bind(self, self.OnClickBtnFeelingAction))
    SetButtonAction(self.BtnArchives,     Bind(self, self.OnClickBtnArchivesAction))
    SetButtonAction(self.BtnStylePreview, Bind(self, self.OnClickBtnStylePreviewAction))
    SetButtonAction(self.BtnInteractive,  Bind(self, self.OnClickBtnInteractiveAction))

    self._listenerConf = {
        [CardProgressionConstants.EventNames.ToggleTab]                 = Bind(self, self.OnEventToggleTab),
        [CardProgressionConstants.EventNames.RequestSuccess]            = Bind(self, self.OnEventRequestSuccess),
        [CardProgressionConstants.EventNames.SetArrowShowState]         = Bind(self, self.OnEventSetArrowShowState),
        [CardProgressionConstants.EventNames.SetStylePreviewShowState]  = Bind(self, self.OnEventSetStylePreviewShowState),
        [CardProgressionConstants.EventNames.SetCultivateMainShowState] = Bind(self, self.OnEventSetCultivateMainShowState),
        [CardProgressionConstants.EventNames.UpdateFashionRedPoint]     = Bind(self, self.OnEventUpdateFashionRedPoint),
    }

    for eventName, func in pairs(self._listenerConf) do
        Events.AddListener(eventName, func)
    end

end


function CardProgressionMainDialog:ResetBackHandle()
    local cb
    if self._isFromEntry then
        cb = function()
            KCookie.Set(Constants.UICacheDataKeys.UICultivatePlayerCardId, self._selectCardEntity.playerCardId)
            CfUtils.ResetNavigatorCustomBackAction()
            UIModule.BackDialog()
        end
    else
        cb = function()
            local jumpFrom = self._jumpFrom
            local t = {
                [JumpFromType.JF_TeamChoose2] = true,
                [JumpFromType.JF_BattleEnd]   = true,
                [JumpFromType.JF_Maze]        = true,
            }
    
            self._isCloseScene = t[jumpFrom]

            if self._forceCloseMainScene then
                self._isCloseScene = true
            end
            
            CfUtils.ResetNavigatorCustomBackAction()
            UIModule.BackDialog()
            if jumpFrom == JumpFromType.JF_TeamChoose2 then
                Events.Broadcast(Constants.EventNames.FightChooseCardsDialogAct, { isTrue = true })
                Events.Broadcast(Constants.EventNames.UIEntrustBattleTeamDialogActive,{isTrue = true})
            end
        end
    end

    CfUtils.SetTopCommonCb(function ()
        cb()
    end)
end


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionMainDialog:FreshCurrencyList()
    local config         = self:GetMainViewConfigByViewType(self._selectedTabViewType)
    CfUtils.SetTopCommonActive(true, not config.isHideCurrency)
    if not config.isHideCurrency then
        local isEquipment = self._selectedTabViewType == CardProgressionConstants.MainViewType.Equip
        local currencyList = isEquipment and self._equipCurrencyList or self._currencyList
        GameUtils.UpdateNavBarShowGoods(currencyList)
    end
end

--- FreshTabs
--- 刷新所有标签
function CardProgressionMainDialog:FreshTabs(mainViewType)
    ---@type CommonTabToggleLeft
    local env = CfUtils.GetLuaScr(self.CommonTabToggleLeft.gameObject, CardProgressionConstants.EnvPath.CommonTabToggleLeft)
    if isNull(env) then return end
    mainViewType = mainViewType or self._selectedTabViewType
    env:FillToggles(self._tabs, self._viewType2Index[mainViewType])
    
end

function CardProgressionMainDialog:FreshUI()
    self:FreshArrowShowState()
    self:FreshBtnInteractiveShowState()
    self.TextNumber.text = self._selectCardEntity.cardDojo.favorabilityLevel
    self:EnterMainViewByViewType(self._selectedTabViewType)

end

function CardProgressionMainDialog:FreshArrowShowState()
    local selectedCardIndex = self._selectedCardIndex
    local isShowLeft        = (selectedCardIndex - 1) > 0
    KTool.SetActive(self.BtnLeft.gameObject, isShowLeft)
    
    local isShowRight = (selectedCardIndex + 1) <= self._maxCount
    KTool.SetActive(self.BtnRight.gameObject, isShowRight)
    
end

function CardProgressionMainDialog:EnterMainViewByViewType(viewType)
    local mainViewEnv = self:GetEnvByViewType(viewType)
    self:EnterMainView(mainViewEnv)

end

function CardProgressionMainDialog:FreshBtnShowState()
    local mainViewType = self._selectedTabViewType
    KTool.SetActive(self.ButtonGroup.gameObject, mainViewType == CardProgressionConstants.MainViewType.Intelligence)
    -- KTool.SetActive(self.BtnFeeling.gameObject,  mainViewType == CardProgressionConstants.MainViewType.Intelligence)
    -- KTool.SetActive(self.BtnFetter.gameObject,   mainViewType == CardProgressionConstants.MainViewType.Intelligence)

    if isNotNull(self.SwitchArrowNode) then
        local anchoredPosition = self.SwitchArrowNode.anchoredPosition
        local _, _, y = SafeUnpack(MainViewType2CameraState[mainViewType])
        self.SwitchArrowNode.anchoredPosition = Vector2.New(anchoredPosition.x, y)
    end
end

--- EnterMainView
---@param env Engine.Modules.LuaBehaviour
function CardProgressionMainDialog:EnterMainView(env)
    if isNull(env) then return end
    if env.OnEnter then
        env:OnEnter()
    end

end

function CardProgressionMainDialog:LoadModel(isDisableEnter, isDisableRoleLoader)
    ---@type CardProgressionControllerRole
    local controllerEnv = self._controllerEnv
    ---@type CardDojo
    local cardDojo      = self._selectCardEntity.cardDojo

    GameUtils.SetRedPointNum(Constants.RedPointConst.CultivationStar, CardProgressionUtils.IsCanStarUp(cardDojo) and 1 or 0)
    GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenFashion, CardProgressionUtils.IsCanShowSkinNewByDojo(cardDojo) and 1 or 0)
    
    local redPointGo
    for go, func in pairs(self._redPointConfig) do
        redPointGo = GameUtils.GetRedPointGo(go)
        if isNotNull(redPointGo) then
            KTool.SetActive(redPointGo, func(cardDojo))
        end
    end
    
    local mainViewType  = self._selectedTabViewType
    ---时装交给内部加载人物
    if mainViewType == CardProgressionConstants.MainViewType.Fashion or isDisableRoleLoader then
        return
    end

    ---@type CardProgressionConstants.CameraState
    local modelType, cameraState = SafeUnpack(MainViewType2CameraState[mainViewType])
    local awakeningLevel = checkNumber(cardDojo.awakeningLevel)
    local t = {
        [CardProgressionConstants.CameraState.CultivateCatAwakenFull] = {cameraState, awakeningLevel},
    }
    
    if mainViewType == CardProgressionConstants.MainViewType.ExclusiveWeapon then
        local isMax = checkNumber(cardDojo.weaponUnlocked) >= cardConfMgr:GetMaxCardExclusiveWeaponLv(cardDojo.cardId)
        cameraState = isMax and CardProgressionConstants.CameraState.ExclusiveWeapon or CardProgressionConstants.CameraState.CultivateRoleFull
        
    end

    if modelType == ModelType.Role then
        controllerEnv:LoadRole(cardDojo.cardSkin, isDisableEnter, {cameraState}, nil, cardDojo)

    elseif modelType == ModelType.Cat then
        controllerEnv:LoadCat(cardDojo.cardSkin,  t[cameraState] or {cameraState})

    else
        controllerEnv:LoadExtraScene(cardDojo.cardSkin)
        controllerEnv:FreshCameraStateByParams(t[cameraState] or {cameraState}, nil, true)
        
    end

end


function CardProgressionMainDialog:ToggleMainView(viewType, oldViewType, localData, interface)
    
    local mainViewEnv, isInitialized = self:GetEnvByViewType(viewType)
    local tabIndex    = self:GetTabIndexByViewType(viewType)
    
    ---页签中缓存的卡牌数据库id 不匹配 或者 页签变换
    if not isInitialized and (self._selectCardEntity.playerCardId ~= self._tabs[tabIndex].playerCardId or viewType ~= oldViewType) then
        self._tabs[tabIndex].playerCardId = self._selectCardEntity.playerCardId
        mainViewEnv:OnReload(self._selectCardEntity, localData, interface)
    end
    
    if not isNull(mainViewEnv) and mainViewEnv.OnEnter then
        mainViewEnv:OnEnter()
    end

    local oldMainViewEnv = self:GetEnvByViewType(oldViewType)
    if not isNull(oldMainViewEnv) and oldMainViewEnv.OnLeave then
        oldMainViewEnv:OnLeave()
    end

    local oldCanvas, canvas = self._mainViewCanvas[oldViewType], self._mainViewCanvas[viewType]
    if not isNull(oldCanvas) then
        oldCanvas.enabled = false
    end
    if not isNull(canvas) then
        canvas.enabled    = true
    end

end

--- ReloadMainView
--- 刷新主界面
---@param viewType CardProgressionConstants.MainViewType
---@param entity CardProgressionEntity
function CardProgressionMainDialog:ReloadMainViewByViewType(viewType, entity, localData, interface, isSwitchCard)
    local env = self:GetEnvByViewType(viewType)
    self:ReloadMainView(env, entity, localData, interface, isSwitchCard)

end

--- ReloadMainView
--- 刷新主界面
---@param env userdata
---@param entity CardProgressionEntity
function CardProgressionMainDialog:ReloadMainView(env, entity, localData, interface, isSwitchCard)
    if isNull(env) then return end
    ---没有reload 走enter
    if env.OnReload then
        env:OnReload(entity, localData, interface, isSwitchCard)
    elseif env.OnEnter then
        env:OnEnter(entity, localData, interface, isSwitchCard)
    end

end

function CardProgressionMainDialog:FreshContainerCanvasShowState(isShow)
    if self._isShowContainerCanvas ~= isShow then
        self._isShowContainerCanvas = isShow
        --self.ContainerCanvas.enabled = isShow
        KTool.SetActive(self.controller.gameObject, isShow)
        
        local canvas = self._mainViewCanvas[self._selectedTabViewType]
        if not isNull(canvas) then
            canvas.enabled = isShow
        end
    end
end

function CardProgressionMainDialog:FreshCardHead()
    local cardId = self._selectCardEntity.cardDojo.cardId
    ---@type CardVo
    local vo = cardConfMgr:GetCardByRefId(cardId)
    ---@type GoodsVo
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(vo.urSkin)
    if goodsVo == nil then
        printError("卡牌id %s 未在 1000卡牌皮肤道具表 找到对应数据 urSkin %s", cardId, vo.urSkin)
        return
    end
    self.ImgHead:LoadSprite(goodsVo.photoPath)
end

function CardProgressionMainDialog:PlayUnlockURSkinAni()
    if not self._isUnlockURSkin then return end
    self._isUnlockURSkin = false
    self:StopUnlockURSkinAni()
    local roleRoot  = self._controllerEnv:GetRoleRoot()
    local transform = roleRoot.transform
    local v2 = CfUtils.WorldPosition2UIPosition(transform.position, self.SwitchArrowNode)
    local anchoredPosition = self.UIFX_MoveBoom.anchoredPosition
    self.UIFX_MoveBoom.anchoredPosition = Vector2.New(v2.x-40, anchoredPosition.y)

    local anim = self.Container
    anim.enabled = true
    local clipName = "CultivateOverseaMainDialog_SkinGo"
    self._unlockURSkinCo = CoStart(function() 
        anim:Play(clipName)
        local BoomMove = self.UIFX_Number_BoomMove
        local go = BoomMove.gameObject
        while not KTool.IsActive(go) do
            cs_coroutine.yield_return()
        end
        local startPos = BoomMove.position
        local endPos   = self.UIFX_MoveBoom.position
        self._boomMoveAni = BoomMove:DOMove(endPos, 0.3):OnKill(function ()
            BoomMove.position = startPos
            self._boomMoveAni = nil
        end)
        while anim:IsPlaying(clipName) do
            cs_coroutine.yield_return()
        end
        anim.enabled = false
        CoYield(1.25)
        KTool.SetActive(self.UIFX_MoveBoom.gameObject, false)
        self._unlockURSkinCo = nil
    end)
    
end

function CardProgressionMainDialog:StopUnlockURSkinAni(isResetState)
    if isNotNull(self._boomMoveAni) then
        self._boomMoveAni:Kill(true)
        self._boomMoveAni = nil
    end

    if isNotNull(self._unlockURSkinCo) then
        CoStop(self._unlockURSkinCo)
        self._unlockURSkinCo = nil
    end

    if isResetState then
        local anim = self.Container
        anim.enabled = false
        KTool.SetActive(self.UIFX_MoveBoom.gameObject, false)
        KTool.SetActive(self.UIFX_GlowBoom.gameObject, false)
        KTool.SetActive(self.UIFX_Number_BoomMove.gameObject, false)
    end
end



---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionMainDialog:GetEnvByViewType(viewType)
    local env = self._mainViewEnvs[viewType]
    local isInitialized = isNull(env)
    if isInitialized then
        local config         = self:GetMainViewConfigByViewType(viewType)
        local prefabPath     = config.prefabPath
        local mainView       = GameUtils.LoadBundleSync(prefabPath)
        self:SetChildTransform(mainView)
        ---@type UnityEngine.Canvas
        local canvas         = KTool.GetOrAddComponent(mainView, CardProgressionConstants.CompType.CanvasType)
        canvas.worldCamera   = URPCameraController.Instance.uiCamera
        canvas.enabled       = self._isShowContainerCanvas
        self._mainViewCanvas[viewType] = canvas
        
        KTool.GetOrAddComponent(mainView, CardProgressionConstants.CompType.GraphicRaycasterType)
        
        ---@type Engine.UI.OrderTracker
        local orderTracker = KTool.GetOrAddComponent(mainView, CardProgressionConstants.CompType.OrderTrackerType)
        orderTracker.addSortingOrder = -1
        
        local luaPath               = config.luaPath
        env = CfUtils.GetLuaScr(mainView, luaPath)
        self._mainViewEnvs[viewType] = env
        if not isNull(env) and env.OnInitialize then
            env:OnInitialize(self._selectCardEntity)
        end
    end
    return env, isInitialized
end


---SetChildTransform
---设置 子节点 位置信息
---@param mainView UnityEngine.GameObject
function CardProgressionMainDialog:SetChildTransform(mainView)
    if isNull(mainView) then
        return
    end
    ---@type UnityEngine.Transform
    local transform      = mainView.transform
    local ChildContainer = self.ChildContainer
    local rect           = ChildContainer.rect
    local y              = transform.localEulerAngles.y
    local localScale     = UIModule.RootCanvas.transform.localScale
    transform.position   = ChildContainer.position
    local scaleOffset    = 0
    transform.localScale = Vector3.New(y ~= 0 and (localScale.x + scaleOffset) or localScale.x , localScale.y, localScale.z)
    transform.sizeDelta  = Vector2.New(rect.width, rect.height)
    
end

function CardProgressionMainDialog:GetSelectCardEntity()
    return self._selectCardEntity
end

function CardProgressionMainDialog:GetSelectTabViewType()
    return self._selectedTabViewType
end

function CardProgressionMainDialog:GetTabIndexByViewType(viewType)
    return self._viewType2Index[viewType]
end

---GetMainViewConfigByViewType
---根据界面类型获取界面配置
---@param viewType CardProgressionConstants.MainViewType
function CardProgressionMainDialog:GetMainViewConfigByViewType(viewType)
    return self:GetMainViewConfig(self:GetTabIndexByViewType(viewType))
end

function CardProgressionMainDialog:GetMainViewConfig(tabIndex)
    local tabData       = self._tabs[tabIndex]
    return tabData.config
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


function CardProgressionMainDialog:OnClickBtnStylePreviewAction()
    local cardId = self._selectCardEntity.cardId
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local skinId = cardVo.urSkin
    if skinId == 0 then
        printError("角色卡牌表 卡牌%s 未配置 urSkin", self._cardVo.roleId)
        return
    end
    CardProgressionUtils.OpenDialog(Constants.UITypeIds.CommonStylePreView, {skinId = skinId, isIndie = false}, {
        UIArgs(Constants.UITypeIds.CultivateMain)
    })
end


function CardProgressionMainDialog:OnClickBtnArchivesAction()
    self:EnterIntroduction(CardProgressionConstants.IntroductionViewType.Illustrated)
end

function CardProgressionMainDialog:OnClickBtnFetterAction()
    self:EnterIntroduction(CardProgressionConstants.IntroductionViewType.Synergies)
end

function CardProgressionMainDialog:OnClickBtnFeelingAction()
    self:EnterIntroduction(CardProgressionConstants.IntroductionViewType.Favor)
end

function CardProgressionMainDialog:EnterIntroduction(viewType)
    local cardDojo = self._selectCardEntity.cardDojo
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.CardProgressionIntroduction,
            {cardId = cardDojo.cardId, playerCardId = cardDojo.id, favorLevel = cardDojo.favorabilityLevel, viewType = viewType},
            {
                UIArgs(Constants.UITypeIds.CultivateMain)
            }
    )
end

function CardProgressionMainDialog:OnClickBtnRightAction()
    self:ToggleCard(self._selectedCardIndex + 1)
end

function CardProgressionMainDialog:OnClickBtnLeftAction()
    self:ToggleCard(self._selectedCardIndex - 1)
end

function CardProgressionMainDialog:ToggleTab(viewType)
    local tabIndex = self:GetTabIndexByViewType(viewType)
    local tabData = self._tabs[tabIndex]
    if tabData.lock then
        GameUtils.Toast(GameUtils.GetUnlockDescrBySystemTogId(tabData.systemTogId))
        return
    end
    if self._selectedTabViewType == CardProgressionConstants.MainViewType.Equip then
        self:OnEventSetArrowShowState(true)
    end
    self:OnEventSetStylePreviewShowState(false)
    self:ToggleMainView(viewType, self._selectedTabViewType)
    self._selectedTabViewType = viewType
    self:FreshCurrencyList()
    self:FreshBtnShowState()
    self:LoadModel()
end

function CardProgressionMainDialog:ToggleCard(index)
    -- 打断角色语音
    CriWareUtils.PlayVoice("Audio/UI_Menu", "empty")

    -----------------------
    --- 刷新数据
    ---@type CardProgressionEntity
    local oldEntity         = self._selectCardEntity
    self._selectedCardIndex = index
    ---@type CardProgressionEntity
    self._selectCardEntity  = self._entityList[index]

    -----------------------
    --- 刷新

    self:StopUnlockURSkinAni(true)

    self.TextNumber.text      = self._selectCardEntity.cardDojo.favorabilityLevel
    local newTabViewType      = self:ReloadTabInfo(self._selectCardEntity)
    local tabViewType         = self._selectedTabViewType
    self._selectedTabViewType = newTabViewType or tabViewType
    self:LoadModel()

    if newTabViewType then
        self:ToggleMainView(newTabViewType, tabViewType)
    else
        self:ReloadMainViewByViewType(tabViewType, self._selectCardEntity, nil, nil, true)
    end
    self:FreshTabs()
    self:FreshArrowShowState()
    -- self:FreshCardHead()
    self:FreshBtnInteractiveShowState()
end

function CardProgressionMainDialog:ResetTab(localData, interface, isDisableRoleLoader)
    local newTabViewType    = self:ReloadTabInfo(self._selectCardEntity)
    local tabViewType         = self._selectedTabViewType
    self._selectedTabViewType = newTabViewType or tabViewType
    
    self:LoadModel(true, isDisableRoleLoader)
    if newTabViewType then
        self:ToggleMainView(newTabViewType, tabViewType, localData, interface)
    else
        self:ReloadMainViewByViewType(tabViewType, self._selectCardEntity, localData, interface)
    end
    self:FreshTabs()
  
end

function CardProgressionMainDialog:OnEventRequestSuccess(interface, localData)
    if localData and type(localData) == "table" then
        local cardDojo 
        if localData.dojo then
            ---@type CardDojo
            cardDojo = localData.dojo
            
        elseif localData.isReload then
            ---@type CardDojo
            local dojo = self._selectCardEntity.cardDojo
            ---@type CardComponent
            local comp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
            ---@type CardDojo
            cardDojo = comp:GetCardById(dojo.id)
            
        end
        
        local viewEnv
        if localData.dojos then
            for _, v in ipairs(checkTable(localData.dojos)) do
                local newEntity = CardProgressionUtils.GenerateEntityByCardDojo(v)
                for i, entity in ipairs(self._entityList) do
                    if checkInt(entity.playerCardId) == checkInt(newEntity.playerCardId) then
                        self._entityList[i] = newEntity
                        break
                    end
                end
            end
            local entity = self._entityList[self._selectedCardIndex]
            self._selectCardEntity = entity
            
            for viewType, env in pairs(self._mainViewEnvs) do
                if viewType == self._selectedTabViewType then
                    viewEnv = env

                end
            end
        elseif cardDojo then
            local entity   = CardProgressionUtils.GenerateEntityByCardDojo(cardDojo)
            self._entityList[self._selectedCardIndex] = entity
            self._selectCardEntity = entity
            for viewType, env in pairs(self._mainViewEnvs) do
                if self._selectedTabViewType == viewType then
                    viewEnv = env

                end
            end
        else
            viewEnv = self._mainViewEnvs[self._selectedTabViewType]
        end

        self:FreshBtnInteractiveShowState()
        
        --- 清空所有 playerCardId
        --- 将 playerCardId  置空 下次选中对应页签时 掉一次 OnReload
        for key, tabData in pairs(self._tabs) do
            self._tabs[key].playerCardId = nil
        end

        if localData.isAdvanceLevelUp then
            self:ResetTab(localData, interface, true)
            
            ---@type CardDojo
            local dojo = localData.dojo
            local curRare = dojo:GetRare()
            ---@type CardDojo
            local oldDojo = localData.oldDojo
            local oldRare = oldDojo:GetRare()
            if (curRare ~= oldRare or checkNumber(oldDojo.cardSkin) ~= checkNumber(dojo.cardSkin)) then
                local isUnlockURSkin = not CardUtils.IsMonsterCard(dojo.cardId)
                if curRare == Constants.RareType.UR and isUnlockURSkin then
                    self._isUnlockURSkin = isUnlockURSkin
                    CardProgressionUtils.PlayAdvanceLevelUpURTimeline(dojo.cardSkin, localData, oldDojo)
                else
                    CardProgressionUtils.PlayAdvanceLevelUpNonURTimeline(dojo.cardSkin, localData, oldDojo)    
                end
            else
                CardProgressionUtils.ShowAdvanceLevelUpSuccess(localData)
            end

        elseif viewEnv then

            local callback = function ()
                self:ReloadMainView(viewEnv, self._selectCardEntity, localData, interface)
                if localData.isReloadModel then
                    self:LoadModel(true)
                else
                    GameUtils.SetRedPointNum(Constants.RedPointConst.CultivationStar,    CardProgressionUtils.IsCanStarUp(cardDojo) and 1 or 0)
                    
                end
            end

            if interface == Interfaces.OverseaCardWeaponLevelUp and localData.isReloadModel then
                self._focusCallback = callback
            else
                callback()
            end
            
        end

    end


end

function CardProgressionMainDialog:OnEventSetCultivateMainShowState(isShow)
    self:FreshContainerCanvasShowState(isShow)

end

function CardProgressionMainDialog:OnEventSetStylePreviewShowState(isShow)
    if isShow then
        self:FreshCardHead()
    end
    KTool.SetActive(self.BtnStylePreview.gameObject, isShow)
    GameUtils.UpdateUIShowState(self.BtnStylePreview.gameObject, isShow)

end

function CardProgressionMainDialog:OnEventSetArrowShowState(isShow)
    if isShow then
        self:FreshArrowShowState()
    else
        KTool.SetActive(self.BtnLeft.gameObject, false)
        KTool.SetActive(self.BtnRight.gameObject, false)
    end
end

function CardProgressionMainDialog:OnEventToggleTab(mainViewType)
    --- 在当前页签中查找 有没有该类型  没有则强设置为第一个类型
    local index 
    for i, v in ipairs(self._tabs) do
        local config = v.config
        if mainViewType == config.mainViewType then
            index = i
            break
        end
        
    end
    if index == nil then
        mainViewType = self._tabs[1].config.mainViewType
    end
    
    self:FreshTabs(mainViewType)
    self:ToggleTab(mainViewType)
end

function CardProgressionMainDialog:OnEventUpdateFashionRedPoint()
    ---@type CardProgressionEntity
    local entity = self:GetSelectCardEntity()
    GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenFashion, CardProgressionUtils.IsCanShowSkinNewByDojo(entity.cardDojo) and 1 or 0)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------



function CardProgressionMainDialog:FreshBtnInteractiveShowState()
   
    local skinId = self._selectCardEntity.cardDojo.cardSkin
    local btnTF = self.BtnInteractive
    local btnGray = btnTF:Find("ImgIcon")

    if isNotNull(IdolLive3D_Utils.GetLive3DCardVoRow(skinId)) then -- 这个皮肤支持 深度互动
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



function CardProgressionMainDialog:OnClickBtnInteractiveAction()
    local skinId = self._selectCardEntity.cardDojo.cardSkin
    IdolLive3D_Loader.TryOpenScene( skinId )
end







return CardProgressionMainDialog
