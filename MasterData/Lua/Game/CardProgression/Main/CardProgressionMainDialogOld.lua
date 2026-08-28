--- 养成-主界面
--- OnReload 只更新UI显示
--- 当前卡页签切换 掉子界面 OnEnter
--- 切换卡优先掉子界面 调OnReload 无OnReload调onEnter
--- 卡牌属性刷新 掉OnReload



------------ global define ------------
local isNull = isNull
local import = import
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

------------ import ------------


------------ define ------------
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CriWareUtils
local CriWareUtils             = import('Game.Entry.CriWareUtilsFix')
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")

local ModelType = {
    Role = 1,
    Cat  = 2,
}

local MainViewType2CameraState = {
    [CardProgressionConstants.MainViewType.Intelligence]    = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleFull, },
    [CardProgressionConstants.MainViewType.Level]           = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleHalf, },
    [CardProgressionConstants.MainViewType.AdvanceLevel]    = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleHalf, },
    [CardProgressionConstants.MainViewType.Star]            = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleHalf, },
    [CardProgressionConstants.MainViewType.Break]           = {ModelType.Cat,  CardProgressionConstants.CameraState.CultivateCatAwakenFull,  },
    [CardProgressionConstants.MainViewType.Equip]           = {ModelType.Cat,  CardProgressionConstants.CameraState.CultivateCatFull,  },
    [CardProgressionConstants.MainViewType.Fashion]         = {ModelType.Role, CardProgressionConstants.CameraState.CultivateRoleFull, },
    [CardProgressionConstants.MainViewType.ExclusiveWeapon] = {ModelType.Role, CardProgressionConstants.CameraState.ExclusiveWeapon, },

}
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaMainDialog.prefab
---@class CardProgressionMainDialogOld
---@field Env                           	CardProgressionMainDialogOld               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnFetter                     	UnityEngine.RectTransform               
---@field BtnArchives                   	UnityEngine.RectTransform
---@field TextNumber                    	TMPro.TextMeshProUGUI
---@field BtnFeeling                    	UnityEngine.RectTransform
---@field ImgHead                       	Engine.UI.ImageAlterable
---@field BtnStylePreview               	UnityEngine.RectTransform
---@field BtnRight                      	UnityEngine.RectTransform
---@field BtnLeft                       	UnityEngine.RectTransform
---@field CommonTabToggleLeft           	UnityEngine.RectTransform
---@field ChildContainer                	UnityEngine.RectTransform
---@field ContainerCanvas               	UnityEngine.Canvas
local CardProgressionMainDialogOld = Class('CardProgressionMainDialogOld')


function CardProgressionMainDialogOld:__init()
    -- self._mainViewType   = CardProgressionConstants.MainViewType.Intelligence
    self._mainViewEnvs   = {}
    self._mainViewCanvas = {}
    self._isShowContainerCanvas = true
    
end


function CardProgressionMainDialogOld:__delete()
    self.controller = nil
end


function CardProgressionMainDialogOld:Awake()
    self.SwitchArrowNode = self.BtnLeft.parent
end


function CardProgressionMainDialogOld:OnFocus(focus)
    if self._focus == focus then
        if focus then
            GameUtils.SetUICameraProjection(false)
            CardProgressionUtils.BlockerAndStartCo("CardProgressionMainDialogOld.FixCamera", function()
                cs_coroutine.yield_return()
                UICommonUtils.WaitBrainBlendingComplete()

                local mainView = self._mainViewCanvas[self._selectedTabViewType]
                self:SetChildTransform(mainView)

            end)
        end
        return
    end
    self._focus = focus
    if focus then
        self:FreshContainerCanvasShowState(true)
        self:ResetBackHandle()
        self:FreshCurrencyList()
        
    else
        CfUtils.ResetNavigatorCustomBackAction()
        
    end
end


function CardProgressionMainDialogOld:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- CfUtils.ChangeMainCamDefalultBlend(0.5)
        --- 显示养成场景
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
        Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
        cs_coroutine.yield_return()
        self:InitData()
        self:FreshTabs()
        self:InitListeners()
        self:FreshCardHead()
        self:LoadModel()
        

    end))
    return coWait
end

function CardProgressionMainDialogOld:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---修正 <CAT-20864> [养成] 装备升级/升星跳转返回异常修复 如果 要跳入界面在OnFinalize 处理过 透视 则还会有显示问题
        GameUtils.SetUICameraProjection(false)
        cs_coroutine.yield_return()
        self:FreshUI()
        self:FreshBtnShowState()
    end))
    return coWait
end

function CardProgressionMainDialogOld:OnHide()
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
        GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.StrengthenFavor)
    end))
    return coWait
end


function CardProgressionMainDialogOld:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
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

function CardProgressionMainDialogOld:InitData()
    local parameters       = self.controller.Argument.parameters
    local mainViewType     = parameters.mainViewType or CardProgressionConstants.MainViewType.Intelligence
    self._maxAdvanceLevel = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MaxAdvanceLevel))
    self:InitEntityList(parameters)
    self:InitTabInfo(mainViewType)

    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()
    
    self._currencyList      = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.MainCurrency))
    self._equipCurrencyList = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.EquipmentCurrency))
end

--- InitTabInfo
---@param mainViewType CardProgressionConstants.MainViewType
function CardProgressionMainDialogOld:InitTabInfo(mainViewType)
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

function CardProgressionMainDialogOld:ReloadTabInfo(entity)
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
function CardProgressionMainDialogOld:InitTabData(config, entity, index, isReloadCardTab)
    local systemTogId = config.systemToggleId
    local name        = config.title1 and CardProgressionUtils.CheckMainViewTabTitle(config, entity) or config.title
    local isLock      = not GameUtils.IsUnlockedBySystemTogId(systemTogId)
    local isShow      = true
    local mainViewType = config.mainViewType
    if mainViewType == CardProgressionConstants.MainViewType.ExclusiveWeapon then
        local cardId = entity.cardDojo.cardId
        ---@type RoleCardExclusiveWeaponVo
        local vo = cardConfMgr:GetRoleCardExclusiveWeaponVo(cardId)
        isShow = vo ~= nil
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


function CardProgressionMainDialogOld:InitEntityList(parameters)
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
    

end

function CardProgressionMainDialogOld:InitSelectedEntityData(entityList, playerCardId)
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

function CardProgressionMainDialogOld:InitListeners()
    local Bind            = Bind
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnLeft,         Bind(self, self.OnClickBtnLeftAction))
    SetButtonAction(self.BtnRight,        Bind(self, self.OnClickBtnRightAction))
    SetButtonAction(self.BtnFetter,       Bind(self, self.OnClickBtnFetterAction))
    SetButtonAction(self.BtnFeeling,      Bind(self, self.OnClickBtnFeelingAction))
    SetButtonAction(self.BtnArchives,     Bind(self, self.OnClickBtnArchivesAction))
    SetButtonAction(self.BtnStylePreview, Bind(self, self.OnClickBtnStylePreviewAction))

    self._listenerConf = {
        [CardProgressionConstants.EventNames.ToggleTab]                 = Bind(self, self.OnEventToggleTab),
        [CardProgressionConstants.EventNames.RequestSuccess]            = Bind(self, self.OnEventRequestSuccess),
        [CardProgressionConstants.EventNames.SetArrowShowState]         = Bind(self, self.OnEventSetArrowShowState),
        [CardProgressionConstants.EventNames.SetStylePreviewShowState]  = Bind(self, self.OnEventSetStylePreviewShowState),
        [CardProgressionConstants.EventNames.SetCultivateMainShowState] = Bind(self, self.OnEventSetCultivateMainShowState),
    }

    for eventName, func in pairs(self._listenerConf) do
        Events.AddListener(eventName, func)
    end

    GameUtils.BindRedPoint(Constants.RedPointConst.StrengthenFavor, self.BtnFeeling, true)
    
end


function CardProgressionMainDialogOld:ResetBackHandle()
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

function CardProgressionMainDialogOld:FreshCurrencyList()
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
function CardProgressionMainDialogOld:FreshTabs(mainViewType)
    ---@type CommonTabToggleLeft
    local env = CfUtils.GetLuaScr(self.CommonTabToggleLeft.gameObject, CardProgressionConstants.EnvPath.CommonTabToggleLeft)
    if isNull(env) then return end
    mainViewType = mainViewType or self._selectedTabViewType
    env:FillToggles(self._tabs, self._viewType2Index[mainViewType])
    
end

function CardProgressionMainDialogOld:FreshUI()
    self:FreshArrowShowState()
     self.TextNumber.text = self._selectCardEntity.cardDojo.favorabilityLevel
    self:EnterMainViewByViewType(self._selectedTabViewType)

end

function CardProgressionMainDialogOld:FreshArrowShowState()
    local selectedCardIndex = self._selectedCardIndex
    local isShowLeft        = (selectedCardIndex - 1) > 0
    KTool.SetActive(self.BtnLeft.gameObject, isShowLeft)
    
    local isShowRight = (selectedCardIndex + 1) <= self._maxCount
    KTool.SetActive(self.BtnRight.gameObject, isShowRight)
    
end

function CardProgressionMainDialogOld:EnterMainViewByViewType(viewType)
    local mainViewEnv = self:GetEnvByViewType(viewType)
    self:EnterMainView(mainViewEnv)

end

function CardProgressionMainDialogOld:FreshBtnShowState()
    local mainViewType = self._selectedTabViewType
    KTool.SetActive(self.BtnArchives.gameObject, mainViewType == CardProgressionConstants.MainViewType.Intelligence)
    KTool.SetActive(self.BtnFeeling.gameObject,  mainViewType == CardProgressionConstants.MainViewType.Intelligence)
    KTool.SetActive(self.BtnFetter.gameObject,   mainViewType == CardProgressionConstants.MainViewType.Intelligence)

    if isNotNull(self.SwitchArrowNode) then
        local anchoredPosition = self.SwitchArrowNode.anchoredPosition
        self.SwitchArrowNode.anchoredPosition = Vector2.New(anchoredPosition.x, mainViewType == CardProgressionConstants.MainViewType.Equip and 87 or 206)
    end
end

--- EnterMainView
---@param env Engine.Modules.LuaBehaviour
function CardProgressionMainDialogOld:EnterMainView(env)
    if isNull(env) then return end
    if env.OnEnter then
        env:OnEnter()
    end

end

function CardProgressionMainDialogOld:LoadModel(isDisableEnter, isDisableRoleLoader)
    ---@type CardProgressionControllerRole
    local controllerEnv = self._controllerEnv
    ---@type CardDojo
    local cardDojo      = self._selectCardEntity.cardDojo

    GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenStar, CardProgressionUtils.IsCanStarUp(cardDojo) and 1 or 0)
    GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenFavor, CardProgressionUtils.IsCanReceiveFavorReward(cardDojo) and 1 or 0)
    local redPointGo = GameUtils.GetRedPointGo(self.BtnArchives.gameObject)
    if isNotNull(redPointGo) then
        ---@type CardComponent
        local cardComp  = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        local map = cardComp:GetStoryRedPointByCardId(cardDojo.cardId)
        KTool.SetActive(redPointGo, map ~= nil and table.count(map) > 0)
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
    
    if modelType == ModelType.Role then
        controllerEnv:LoadRole(cardDojo.cardSkin, isDisableEnter, {cameraState}, nil, cardDojo)
    elseif modelType == ModelType.Cat then
        -- Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
        controllerEnv:LoadCat(cardDojo.cardSkin,  t[cameraState] or {cameraState})
        -- 
        -- self:TestBreakAni(cardDojo.cardId, cardDojo.cardSkin)
        
    end

end

function CardProgressionMainDialogOld:TestBreakAni(cardId, skinId)
    cs_coroutine.start(function() 
        ---@type CardProgressionControllerRole
        local controllerEnv = self._controllerEnv
        local cultivateCameraTrans              = controllerEnv.cultivateCameraTrans

        ---@type Engine.Lib.Yielders
        local Yielders          = CS.Engine.Lib.Yielders
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(2))

        if true then
            controllerEnv:LoadCat(skinId,  {CardProgressionConstants.CameraState.CultivateCatAwakenSuccess, 2})
            return
        end

        local Covert = Vector3.Covert

        local sceneManagement = SceneManagement:GetInstance()
        local sceneId         = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
        ---@type SceneInstance
        local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
        ---@type UnityEngine.GameObject
        local go = sceneInstance:GetCacheObjectByName("CameraPositions")
        local oldPositionTrans = go.transform:Find("BreakPosition1")
        local newPositionTrans = go.transform:Find("BreakPosition2")
        --- 1. 镜头拉远
        local oldPosition = Covert(oldPositionTrans.position)
        local newPosition = Covert(newPositionTrans.position)
        local cameraUp          = Covert(cultivateCameraTrans.up)
        local cameraForward = Covert(cultivateCameraTrans.forward)

        -- local cat = controllerEnv:GetCatBySkinId(skinId)
        -- ---@type UnityEngine.Transform
        -- local catTrans = cat.transform
        local catRootTrans = controllerEnv.catRoot.transform
        local catForward = Covert(catRootTrans.forward)

        -- catTrans:SetParent(newPositionTrans, true)


        local midPosition = (oldPosition + newPosition) * 0.5
        local cameraPos = midPosition - cameraForward * 5 + cameraUp * 0.2

        --- 2. 猫转身
        local direction = newPosition - oldPosition
        -- 顺时针为 1, 逆时针为 -1
        local clockwise = 1
        if Vector3.Cross(catForward, direction).y < 0 then
            clockwise = -1
        end
        local angle     = Vector3.Angle(catForward, direction) * clockwise
        print(angle, clockwise, "angle: ")

        local DOTween                  = CS.DG.Tweening.DOTween
        local eulerAngles = catRootTrans.localEulerAngles
        local sequence = DOTween.Sequence()
        sequence:Append(cultivateCameraTrans:DOMove(cameraPos, 0.3))
        sequence:Append(catRootTrans:DOLocalRotateQuaternion(Quaternion.Euler(eulerAngles.x, eulerAngles.y + angle, eulerAngles.z), 0.3))
        sequence:Append(catRootTrans:DOJump(newPosition, 0.5, 1, 0.3))
        sequence:AppendCallback(function ()
            print("播放特效--->>22")
        end)

        local sequence1 = DOTween.Sequence()
        sequence1:Append(catRootTrans:DORotateQuaternion(newPositionTrans.rotation, 0.3))
        local forwardFactor = 1.5
        local rightFactor   = 0.165
        local upFactor      = 0.2
        local right         = Covert(newPositionTrans.right)
        local up            = Covert(newPositionTrans.up)
        local forward = Covert(newPositionTrans.forward)
        local cameraPosition = newPosition + forward * forwardFactor - right * rightFactor + up * upFactor
        local cameraRotation = Quaternion.LookRotation(forward * -1)
        sequence1:Insert(0, cultivateCameraTrans:DOMove(cameraPosition ,0.3))
        sequence1:Insert(0, cultivateCameraTrans:DORotateQuaternion(cameraRotation ,0.3))
        sequence:Append(sequence1)
        sequence:Play()
        -- while sequence:IsPlaying() do
        --     cs_coroutine.yield_return()
        -- end
        -- sequence1:Play()
        -- catTrans:DOLocalRotateQuaternion(Quaternion.Euler(eulerAngles.x, clockwise * angle, eulerAngles.z), 0.3)
        -- while tween:IsPlaying() do
        --     print("------->>>")
        --     cs_coroutine.yield_return()
        -- end
        --- 3. 猫起跳


        --- 4. 播特效
        --- 5. 镜头拉进并且猫转身


        -- while not controllerEnv:IsLoadCatComplete() do
        --     cs_coroutine.yield_return()
        -- end

        -- ---@type CardPositionVo
        -- local positionVo = cardConfMgr:GetCardPosByCardId(cardId)
        -- local position   = positionVo.halfRoleStance
        -- self._wait = true
        -- cultivateCameraTrans.transform:DOMove(position, 0.5):OnComplete(function()
        --     self._wait = false
        -- end)
        -- while self._wait do
        --     cs_coroutine.yield_return()
        -- end
        -- CfUtils.ShowSwitchAnimation()
        -- Events.Broadcast(Constants.EventNames.HomeSceneRoleActive, false, true)
        -- local sceneManagement          = SceneManagement:GetInstance()
        -- local sceneId = KCookie.Get(Constants.UICacheDataKeys.MainSceneID)
        -- ---@type SceneInstance
        -- local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
        -- ---@type UnityEngine.GameObject
        -- local go = sceneInstance:GetCacheObjectByName("CameraPositions")
        -- local positionTrans = go.transform:Find("BreakPosition1")
        -- local v3 = positionTrans.position
        -- local luaV3 = Vector3.Covert(v3)
        -- local nodeForward = positionTrans.forward
        -- local nodeRight   = positionTrans.right
        -- local nodeUp   = positionTrans.up
        -- local luaNodeForward = Vector3.Covert(nodeForward)
        -- local luaNodeRight = Vector3.Covert(nodeRight)
        -- local luaNodeUp = Vector3.Covert(nodeUp)
        
        -- local d = 1.5
        -- local pos = luaNodeForward:Mul(d):Add(luaV3):Sub(luaNodeRight:Mul(0.165)):Add(luaNodeUp:Mul(0.2))
        -- ---@type UnityEngine.GameObject
        -- local catGo = controllerEnv:GetCatBySkinId(skinId)
        -- catGo.transform:SetParent(positionTrans, false)
        -- local Quaternion = CS.UnityEngine.Quaternion
        -- cultivateCameraTrans.transform.position = pos
        -- cultivateCameraTrans.transform.rotation = Quaternion.LookRotation(Vector3.New(-1 * nodeForward.x, -1 * nodeForward.y, -1 * nodeForward.z))

        -- ---@type Engine.Lib.Yielders
        -- local Yielders          = CS.Engine.Lib.Yielders
        -- cs_coroutine.yield_return(Yielders.GetWaitForSeconds(3))
        
        -- local forward  = Vector3.Covert(cultivateCameraTrans.forward)
        -- local position = Vector3.Covert(cultivateCameraTrans.position)
        -- local up       = Vector3.Covert(cultivateCameraTrans.up)
        -- cultivateCameraTrans.position = position:Sub(forward:Mul(3)):Add(up:Mul(0.5))
        
        -- local fullCamera = go.transform:Find("CameraBreakFull")
        -- local DOTween         = CS.DG.Tweening.DOTween
        -- local duration   = 0.5
        -- local sequence = DOTween.Sequence()
        -- sequence:Append(cultivateCameraTrans:DOMove(fullCamera.position, duration))
        -- sequence:Insert(0, cultivateCameraTrans:DORotateQuaternion(fullCamera.rotation))
        -- sequence:PlayForward()


    end)

end


function CardProgressionMainDialogOld:ToggleMainView(viewType, oldViewType, localData, interface)
    
    local mainViewEnv = self:GetEnvByViewType(viewType)
    local tabIndex    = self:GetTabIndexByViewType(viewType)
    
    ---页签中缓存的卡牌数据库id 不匹配 或者 页签变换
    if self._selectCardEntity.playerCardId ~= self._tabs[tabIndex].playerCardId or viewType ~= oldViewType then
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
function CardProgressionMainDialogOld:ReloadMainViewByViewType(viewType, entity, localData, interface)
    local env = self:GetEnvByViewType(viewType)
    self:ReloadMainView(env, entity, localData, interface)

end

--- ReloadMainView
--- 刷新主界面
---@param env userdata
---@param entity CardProgressionEntity
function CardProgressionMainDialogOld:ReloadMainView(env, entity, localData, interface)
    if isNull(env) then return end
    ---没有reload 走enter
    if env.OnReload then
        env:OnReload(entity, localData, interface)
    elseif env.OnEnter then
        env:OnEnter(entity, localData, interface)
    end

end

function CardProgressionMainDialogOld:FreshContainerCanvasShowState(isShow)
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

function CardProgressionMainDialogOld:FreshCardHead()
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

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionMainDialogOld:GetEnvByViewType(viewType)
    local env = self._mainViewEnvs[viewType]
    if isNull(env) then
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
    return env
end


---SetChildTransform
---设置 子节点 位置信息
---@param mainView UnityEngine.GameObject
function CardProgressionMainDialogOld:SetChildTransform(mainView)
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
    local scaleOffset = 0
    transform.localScale = Vector3.New(y ~= 0 and (localScale.x + scaleOffset) or localScale.x , localScale.y, localScale.z)
    transform.sizeDelta  = Vector2.New(rect.width, rect.height)
    
end

function CardProgressionMainDialogOld:GetSelectCardEntity()
    return self._selectCardEntity
end

function CardProgressionMainDialogOld:GetSelectTabViewType()
    return self._selectedTabViewType
end

function CardProgressionMainDialogOld:GetTabIndexByViewType(viewType)
    return self._viewType2Index[viewType]
end

---GetMainViewConfigByViewType
---根据界面类型获取界面配置
---@param viewType CardProgressionConstants.MainViewType
function CardProgressionMainDialogOld:GetMainViewConfigByViewType(viewType)
    return self:GetMainViewConfig(self:GetTabIndexByViewType(viewType))
end

function CardProgressionMainDialogOld:GetMainViewConfig(tabIndex)
    local tabData       = self._tabs[tabIndex]
    return tabData.config
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


function CardProgressionMainDialogOld:OnClickBtnStylePreviewAction()
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

function CardProgressionMainDialogOld:OnClickBtnArchivesAction()
    local cardDojo = self._selectCardEntity.cardDojo
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.CardProgressionIntroduction,
            {cardId = cardDojo.cardId, favorLevel = cardDojo.favorabilityLevel, viewType = CardProgressionConstants.IntroductionViewType.Illustrated},
            {
                UIArgs(Constants.UITypeIds.CultivateMain)
            }
    )
end

function CardProgressionMainDialogOld:OnClickBtnFetterAction()
    local cardDojo = self._selectCardEntity.cardDojo
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.CardProgressionIntroduction,
            {cardId = cardDojo.cardId, favorLevel = cardDojo.favorabilityLevel, viewType = CardProgressionConstants.IntroductionViewType.Synergies},
            {
                UIArgs(Constants.UITypeIds.CultivateMain)
            }
    )
end

function CardProgressionMainDialogOld:OnClickBtnFeelingAction()
    CardProgressionUtils.OpenDialog(
            Constants.UITypeIds.CardProgressionFavor,
            {playerCardId = self._selectCardEntity.cardDojo.id},
            {
                UIArgs(Constants.UITypeIds.CultivateMain)
            }
    )
end

function CardProgressionMainDialogOld:OnClickBtnRightAction()
    self:ToggleCard(self._selectedCardIndex + 1)
end

function CardProgressionMainDialogOld:OnClickBtnLeftAction()
    self:ToggleCard(self._selectedCardIndex - 1)
end

function CardProgressionMainDialogOld:ToggleTab(viewType)
    local tabIndex = self:GetTabIndexByViewType(viewType)
    local tabData = self._tabs[tabIndex]
    if tabData.lock then
        GameUtils.Toast(GameUtils.GetUnlockDescrBySystemTogId(tabData.systemTogId))
        return
    end

    self:OnEventSetStylePreviewShowState(false)
    self:ToggleMainView(viewType, self._selectedTabViewType)
    self._selectedTabViewType = viewType
    self:FreshCurrencyList()
    self:FreshBtnShowState()
    self:LoadModel()
end

function CardProgressionMainDialogOld:ToggleCard(index)
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

    self.TextNumber.text      = self._selectCardEntity.cardDojo.favorabilityLevel
    local newTabViewType      = self:ReloadTabInfo(self._selectCardEntity)
    local tabViewType         = self._selectedTabViewType
    self._selectedTabViewType = newTabViewType or tabViewType
    self:LoadModel()

    if newTabViewType then
        self:ToggleMainView(newTabViewType, tabViewType)
    else
        self:ReloadMainViewByViewType(tabViewType, self._selectCardEntity)
    end
    self:FreshTabs()
    self:FreshArrowShowState()
    self:FreshCardHead()
    
end

function CardProgressionMainDialogOld:ResetTab(localData, interface, isDisableRoleLoader)
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

function CardProgressionMainDialogOld:OnEventRequestSuccess(interface, localData)
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
                else
                    local index self:GetTabIndexByViewType(viewType)
                    local tabData = self._tabs[index]
                    if tabData then
                        --- 将 playerCardId  置空 下次选中对应页签时 掉一次 OnReload
                        tabData.playerCardId = nil
                    end
                end
            end
        elseif cardDojo then
            local entity   = CardProgressionUtils.GenerateEntityByCardDojo(cardDojo)
            self._entityList[self._selectedCardIndex] = entity
            self._selectCardEntity = entity
            for viewType, env in pairs(self._mainViewEnvs) do
                if self._selectedTabViewType == viewType then
                    viewEnv = env
                    
                else
                    local index = self:GetTabIndexByViewType(viewType)
                    local tabData = self._tabs[index]
                    if tabData then
                        --- 将 playerCardId  置空 下次选中对应页签时 掉一次 OnReload
                        tabData.playerCardId = nil
                    end
                end
            end
            
        end

        if localData.isAdvanceLevelUp then
            self:ResetTab(localData, interface, true)
            
            ---@type CardDojo
            local dojo = localData.dojo
            ---@type CardDojo
            local oldDojo = localData.oldDojo
            CardProgressionUtils.PlayAdvanceLevelUpTimeline(dojo.cardSkin, localData, oldDojo)
            
        elseif viewEnv then
            self:ReloadMainView(viewEnv, self._selectCardEntity, localData, interface)
            if localData.isReloadModel then
                self:LoadModel(true)
            else
                GameUtils.SetRedPointNum(Constants.RedPointConst.StrengthenStar, CardProgressionUtils.IsCanStarUp(cardDojo) and 1 or 0)
            end
            
        end

    end


end

function CardProgressionMainDialogOld:OnEventSetCultivateMainShowState(isShow)
    self:FreshContainerCanvasShowState(isShow)
end

function CardProgressionMainDialogOld:OnEventSetStylePreviewShowState(isShow)
    KTool.SetActive(self.BtnStylePreview.gameObject, isShow)
end

function CardProgressionMainDialogOld:OnEventSetArrowShowState(isShow)
    if isShow then
        self:FreshArrowShowState()
    else
        KTool.SetActive(self.BtnLeft.gameObject, false)
        KTool.SetActive(self.BtnRight.gameObject, false)
    end
end

function CardProgressionMainDialogOld:OnEventToggleTab(mainViewType)
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

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionMainDialogOld
