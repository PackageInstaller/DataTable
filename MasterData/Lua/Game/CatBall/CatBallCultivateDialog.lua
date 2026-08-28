
--region global define
local require = require
local import  = import
local isNotNull = isNotNull
local Quaternion = Quaternion
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CatBallUtils
local CatBallUtils                = import("Game.CatBall.CatBallUtils")
---@type GuideUtils
local GuideUtils = import('Game.UI.Guide.GuideUtils')
---@type MaidCoffeeConstants
local MaidCoffeeConstants = import("Game.MaidCoffee.MaidCoffeeConstants")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
local NamedAnimancerComponentType = typeof(CS.Animancer.NamedAnimancerComponent)
local URPCameraController       = CS.Game.Native.URP.URPCameraController
--endregion

--region define

local ViewType = {
    Information = 1, --- 信息
    StarUp      = 2, --- 升星
}

local shadowVerticalOffset = 0.034 -- 原始值为 0.034
local CatModelInteractionLocalRotation = {
    Child = Quaternion.Euler(0, -171, 0),
    Adult = Quaternion.Euler(0, -145, 0)
}

local Cell        = "ToggleCellNode"
local CellEnvPath = "Game.CatBall.CatBallToggleCellNode"
local URPBaseCameraType = typeof(CS.Game.Native.URP.URPBaseCamera)
local SceneId = Constants.IdSceneSetting24
--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballCultivateDialog.prefab > name: OverseaManageCatballCultivateDialog
---@class CatBallCultivateDialog
---@field Env                           	CatBallCultivateDialog                  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field PreviewTitle                  	UnityEngine.CanvasGroup                 
---@field BtnRight                      	UnityEngine.RectTransform               
---@field BtnLeft                       	UnityEngine.RectTransform               
---@field CommonTabToggleLeft           	UnityEngine.RectTransform            
---@field StarUpPanel                   	UnityEngine.Canvas               
---@field InformationPanel              	UnityEngine.Canvas               
local CatBallCultivateDialog = Class('CatBallCultivateDialog')


function CatBallCultivateDialog:__init()
    self._selectTabIndex = 1
    self._selectCatBallIndex = 1
    self._viewType2Env = {}
end


function CatBallCultivateDialog:__delete()
    self.controller = nil
end

function CatBallCultivateDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
        KTool.SetActive(self.PreviewTitle.gameObject, self._previewMode)
        
        CfUtils.SetTopCommonActive(true, not self._previewMode)

        local sceneManagement = SceneManagement:GetInstance()
        ---等到场景加载完成再显示
        while not sceneManagement:GetSceneInstance(Constants.IdSceneSetting24) do 
            cs_coroutine.yield_return()
        end 

    end))
    return coWait
end

function CatBallCultivateDialog:OnFocus(focus)
    local canvas = self.controller.CacheCanvas
    if isNotNull(canvas) then
        canvas.enabled = focus
    end
    if focus then
        if self._isRestCameraState then
            self._isRestCameraState = false
            URPCameraController.Instance:SetMainCameraActive(true, self.controller.gameObject.name)
        end
        if not self._previewMode then
            CfUtils.RefreshTopGoods(self._currency)
        else
            CfUtils.SetNavHomeShow(not GuideUtils.IsInGuiding())
        end

        -- CfUtils.SetTopCommonCb(function()
            -- GameUtils.ShowBlackOverlay(nil,function()
            --     cs_coroutine.yield_return(CfUtils.DialogBack())
            -- end)
        -- end)
        
    else
        CfUtils.ResetNavigatorCustomBackAction()
    end
end


function CatBallCultivateDialog:OnShow()
    ---@type Engine.Lib.CoWait
        
    -- local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshToggleList()
        self:SwitchCatBall(self._selectCatBallIndex)

    -- end))
    -- return coWait
end


function CatBallCultivateDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self.__EventRotationRole then
            Events.RemoveListener(CardProgressionConstants.EventNames.RotationRole, self.__EventRotationRole)
            self.__EventRotationRole = nil
        end
        self:StopCoroutine()
        --self:DeleteCatGameObject()
        ---加载场景
        -- local sceneManagement = SceneManagement:GetInstance()
        ---@type SceneInstance
        -- local sceneInstance = sceneManagement:GetSceneInstance(Constants.IdSceneSetting24)
        -- sceneInstance:Disable(true)

        -- local sceneManagement = SceneManagement:GetInstance()
        -- sceneManagement:UnloadAppendedSceneById(Constants.IdSceneSetting24)

    end))
    return coWait
end


function CatBallCultivateDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        

        self:DeleteCatGameObject()


        local sceneManagement = SceneManagement:GetInstance()
        sceneManagement:UnloadAppendedSceneById(Constants.IdSceneSetting24)

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallCultivateDialog:OnInit()
    self:InitScene()
    self:InitUI()
    self:InitData()
    self:InitAction()
end

function CatBallCultivateDialog:InitScene()
    
    Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, false)
    Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = false})
    local sceneManagement = SceneManagement:GetInstance()

    sceneManagement:AppendSceneAsync(SceneId, true, function(sceneInstance)
        Events.Broadcast("MaidCoffee_VimCraStageChange",false)

        if sceneInstance then
            
            local cameraObject  = sceneInstance:GetCacheObjectByName("Main Camera")
            KTool.GetOrAddComponent(cameraObject, URPBaseCameraType)
            
            URPCameraController.Instance:SetMainCameraActive(true, self.controller.gameObject.name)

        end
    end )

    -- cs_coroutine.yield_return(sceneManagement:AppendScene(SceneId, true))
    -- sceneManagement:AppendScene(SceneId, true)
    -- Events.Broadcast("MaidCoffee_VimCraStageChange",false)
    
    -- ---@type SceneInstance
    -- local sceneInstance = sceneManagement:GetSceneInstance(SceneId)
    -- local cameraObject  = sceneInstance:GetCacheObjectByName("Main Camera")
    -- KTool.GetOrAddComponent(cameraObject, URPBaseCameraType)
    
    -- URPCameraController.Instance:SetMainCameraActive(true, self.controller.gameObject.name)

end

function CatBallCultivateDialog:InitUI()
    -- self._canvas = self.controller.
end

function CatBallCultivateDialog:InitData()
    local parameters       = self.controller.Argument.parameters
    local previewMode      = checkNumber(parameters.previewMode) == 1
    self._previewMode      = previewMode
    self:InitCurrency()
    self:InitCatBallTransformInfo()
    self:InitToggleData()
    self:InitCatBallList(parameters)
    self:UpdateRedPointShowState()
end

function CatBallCultivateDialog:InitCurrency()
    local t = {
        ---猫球升星、融合界面显示的新海币
        checkNumber(CatBallUtils.GetCatBallParams(7)),
    }
    self._currency = t
end

function CatBallCultivateDialog:InitCatBallTransformInfo()
    local posValList = parse_strings(CatBallUtils.GetCatBallParams(8))
    self._catBallPos = Vector3.New(posValList[1], posValList[2], posValList[3])
end

function CatBallCultivateDialog:InitToggleData()
    local t = {
        {
            viewType = ViewType.Information, 
            text = localize("信息"), 
            envPath = "Game.CatBall.CatBallCultivateInformationPanel", 
            func = Bind(self, self.OnClickToggleCellAction),
            panel = self.InformationPanel,
        },
        {
            viewType = ViewType.StarUp, 
            text = localize("升星"), 
            envPath = "Game.CatBall.CatBallCultivateStarUpPanel",           
            func = Bind(self, self.OnClickToggleCellAction),
            redPointStrNode = Constants.RedPointConst.MainCafeCatBallEnterListStar,
            panel = self.StarUpPanel,
        },
    }
    self._toggleDataList = t

end

function CatBallCultivateDialog:InitCatBallList(parameters)
    local previewMode      = self._previewMode
    local dojos = {}
    local selectIndex = 0
    if previewMode then
        local catBallId        = checkNumber(parameters.catBallId)
        ---@type CatBallVo
        local vo = CatBallUtils.GetCatBallVo(catBallId)
        ---@type CatEggDojo
        local dojo = CatBallUtils.GeneratedCatEggDojo({id = -1, catBallId = catBallId, star = vo.starMax})
        table.insert(dojos, dojo)
        selectIndex = 1
        
    else
        local playerCatId      = checkNumber(parameters.playerCatId)
        local ids              = parameters.ids
        ---@type CatEggComponent
        local eggComponent     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
        
        if ids then
            for index, playerCatBallId in ipairs(ids) do
                if playerCatBallId == playerCatId then
                    selectIndex = index
                end
                local dojo = eggComponent:GetCatById(playerCatBallId)
                table.insert(dojos, dojo)
            end
        else
            local dojo = eggComponent:GetCatById(playerCatId)
            table.insert(dojos, dojo)
        end

    end

    self._previewMode = previewMode
    ---@type CatEggDojo[]
    self._dojos = dojos
    self._selectCatBallIndex = selectIndex == 0 and 1 or selectIndex
end

function CatBallCultivateDialog:InitAction()
    SetButtonAction(self.BtnLeft, Bind(self, self.OnClickBtnLeftAction))
    SetButtonAction(self.BtnRight, Bind(self, self.OnClickBtnRightAction))

    ---@type CardProgressionUtils
    local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
    CardProgressionUtils.RegRoleSwipeRegion(self.controller)
    
    self.__EventRotationRole = Events.AddListener(CardProgressionConstants.EventNames.RotationRole, Bind(self, self.OnEventRotationRoleAction))
end

--endregion 


--region logic 

function CatBallCultivateDialog:FreshToggleList()
    local ScrollView = self.CommonTabToggleLeft
    if self._previewMode then
        KTool.SetActive(ScrollView.gameObject, false)
        return
    end

    local scr = CfUtils.GetLuaScr(self.CommonTabToggleLeft, "Game.Behaviours.CommonTabToggleLeft")
    if scr then
        scr:FillToggles(self._toggleDataList)
    end
    
end

-- function CatBallCultivateDialog:OnGetItemByIndex(listView, index)
--     if index < 0 then
--         return nil
--     end

--     local cell = listView:NewListViewItem(Cell)
--     local node = GetLuaBehaviour(cell.gameObject, CellEnvPath)
    
--     ---@type CatBallToggleCellNode
--     local nodeEnv
--     if not cell.IsInitHandlerCalled then
--         cell.IsInitHandlerCalled = true
--         node:Init()
--         nodeEnv = node.Env
--         nodeEnv:SetCallback(Bind(self, self.OnClickToggleCellAction))
--     else
--         nodeEnv = node.Env
--     end

--     if nodeEnv then
--         local position = index + 1
--         local toggleData = self._toggleDataList[position]
--         nodeEnv:FreshUI(toggleData, position)
--         nodeEnv:FreshSelectState(self._selectTabIndex == position)
--         nodeEnv:FreshRedPointShowState(toggleData.viewType == ViewType.StarUp and self:GetRedPointShowState())
--     end

--     return cell
-- end

function CatBallCultivateDialog:SwitchCatBall(index)
    KTool.SetActive(self.BtnLeft.gameObject, index > 1)
    KTool.SetActive(self.BtnRight.gameObject, index < #self._dojos)

    self._selectCatBallIndex = index
    self:FreshModel()
    self:FreshSubUI(self._selectTabIndex)
    self:UpdateRedPointShowState()
end

function CatBallCultivateDialog:FreshModel()
    ---@type CatEggDojo
    local dojo = self._dojos[self._selectCatBallIndex]
    
    local playerCatId = checkNumber(dojo.id)
    if self._loadCatId == playerCatId then
        return
    end
    self:StopCoroutine()
    self:DeleteCatGameObject()
    self._co = cs_coroutine.start(function()
        ---@type CatEggComponent
        local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
        local vo = CatBallUtils.GetCatBallVo(dojo.catId)
        local genes = vo.kind
        eggComponent:LoadCatModelAsync(MaidCoffeeConstants.BornType.Adult, vo.catId, false, genes, nil, function(go)
            ---@type UnityEngine.Transform
            go.name = playerCatId
            self._catGo = go
            self._loadCatId = playerCatId
            local trans = go.transform
            trans.position = self._catBallPos
            trans.localRotation = CatModelInteractionLocalRotation.Adult
        end)
    end)
end

function CatBallCultivateDialog:StopCoroutine()
    if self._co then
        cs_coroutine.stop(self._co)
    end
    self._co = nil
end

function CatBallCultivateDialog:DeleteCatGameObject()
    if isNotNull(self._starAniCo) then
        CoStop(self._starAniCo)
        self._starAniCo = nil
    end
    if not isNull(self._catGo) then
        KTool.SafeDelete(self._catGo, true)
    end
    self._catGo = nil
end

function CatBallCultivateDialog:FreshSubUI(index)
    local config = self._toggleDataList[index]
    config.panel.enabled = true
    ---@type CatBallCultivateInformationPanel | CatBallCultivateStarUpPanel
    local env    = self:GetEnvByConfig(config)
    if isNull(env) then
        return
    end
    env:FreshUI(self._dojos[self._selectCatBallIndex], self)
end

-- function CatBallCultivateDialog:FreshSelectState(index, isSelect)
--     local item = self.CommonTabToggleLeft:GetShownItemByItemIndex(index - 1)
--     ---@type CatBallToggleCellNode
--     local nodeEnv = CfUtils.GetLuaScr(item.gameObject, CellEnvPath)
--     if isNull(nodeEnv) then
--         return
--     end
--     nodeEnv:FreshSelectState(isSelect)
-- end

function CatBallCultivateDialog:PlayStarAni()
    if isNull(self._catGo) then return end
    self._starAniCo = CoStart(function() 
        ---@type Animancer.NamedAnimancerComponent
        local animancer = KTool.GetComponent(self._catGo, NamedAnimancerComponentType)
        local animancerState = animancer:TryPlay("touch1", 1.5)
        if not isNull(animancerState) then
            CoYield(animancerState.Length)
            if isNotNull(animancer) then
                animancer:TryPlay("idle")
            end
        end
    end)
end

function CatBallCultivateDialog:UpdateRedPointShowState()
    GameUtils.SetRedPointNum(Constants.RedPointConst.MainCafeCatBallEnterListStar, self:GetRedPointShowState() and 1 or 0)

end

--endregion 


--region get/set 

function CatBallCultivateDialog:GetEnvByConfig(config)
    local viewType = config.viewType
    local env = self._viewType2Env[viewType]
    if isNull(env) then
        env = CfUtils.GetLuaScr(config.panel, config.envPath)
        self._viewType2Env[viewType] = env
    end
    return env
end

function CatBallCultivateDialog:GetRedPointShowState()
    ---@type CatEggDojo
    local dojo = self._dojos[self._selectCatBallIndex]
    return CatBallUtils.GetRedPointShowStateByDojo(dojo)
end

function CatBallCultivateDialog:SetIsRestCameraState(isReset)
    self._isRestCameraState = isReset
end

---endregion 


--region handler 

function CatBallCultivateDialog:OnClickToggleCellAction(_, index)
    if self._selectTabIndex == index then return end

    if self._selectTabIndex then
        local config = self._toggleDataList[self._selectTabIndex]
        config.panel.enabled = false

        -- self:FreshSelectState(self._selectTabIndex, false)
    end

    self._selectTabIndex = index

    self:FreshSubUI(index)

    return true

end

function CatBallCultivateDialog:OnClickBtnLeftAction()
    if self._selectCatBallIndex < 1 then
        return
    end
    self:SwitchCatBall(self._selectCatBallIndex - 1)
end

function CatBallCultivateDialog:OnClickBtnRightAction()
    if self._selectCatBallIndex > #self._dojos then
        return
    end
    self:SwitchCatBall(self._selectCatBallIndex + 1)
end

function CatBallCultivateDialog:OnEventRotationRoleAction(direction)
    local catGo = self._catGo
    if isNull(catGo) then
        return
    end
    ---@type UnityEngine.Transform
    local transform = catGo.transform
    local eulerAngles = Vector3.New(0, direction, 0)
    transform:Rotate(eulerAngles)
end

---endregion 


return CatBallCultivateDialog
