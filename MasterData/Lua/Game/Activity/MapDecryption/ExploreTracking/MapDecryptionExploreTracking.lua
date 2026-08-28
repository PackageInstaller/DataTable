
-- 点击 "探索望月城" 后, 显示的 桌面界面

------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
local cs_coroutine     = require "XLua.cs_coroutine"
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local Yielders            = CS.Engine.Lib.Yielders
------------ import ------------


------------ define ------------
local isNull             = isNull
local SceneManagementIns = SceneManagement:GetInstance()

------------ define ------------

--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalExploreTracking.prefab
---@class MapDecryptionExploreTracking
---@field Env                           	MapDecryptionExploreTracking                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Root                          	UnityEngine.Animation                   
---@field TrackingPanel                 	UnityEngine.RectTransform               
---@field ExplorePanel                  	UnityEngine.RectTransform               
local MapDecryptionExploreTracking = Class('MapDecryptionExploreTracking')


---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()


function MapDecryptionExploreTracking:__init()
    -- self.mapId = 1
    self._nodePositions = {}
    
    self._subViewInitRes = {}
end


function MapDecryptionExploreTracking:__delete()
    self.__eventSwitchExploreOrTracking = nil
    self.__eventActivityEnd = nil
    self.controller = nil
end


-- function MapDecryptionExploreTracking:Awake()
-- end


-- function MapDecryptionExploreTracking:OnFocus(focus)

-- end


function MapDecryptionExploreTracking:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local activityData = MapDecryptionMgr:GetComponent():GetActivityData()
        local isShow = false
        GameUtils.Request(Interfaces.ActivityMapDecryptionHome, {activityUuid = activityData.id}, function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            MapDecryptionMgr:GetComponent():Initial(response.data)
            MapDecryptionMgr:InitAllAntique()
            isShow = true
        end)

        while not isShow do
            cs_coroutine.yield_return(Yielders.EndOfFrame)
        end

        self:InitData()
        self:InitMapNodes()
        self:InitSubView()
        self:InitListener()
    end))
    return coWait
end

function MapDecryptionExploreTracking:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FreshUI()
        -- self:StartCountdown()

    end))
    return coWait
end

-- 从 "探索望月城" 桌面界面 退回到 3d场景对话界面 (F键等待玩家按下)
function MapDecryptionExploreTracking:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local EventNames = MapDecryptionConstants.EventNames
        if self.__eventSwitchExploreOrTracking then
            Events.RemoveListener(EventNames.SwitchExploreOrTracking, self.__eventSwitchExploreOrTracking)
        end
        
        if self.__eventActivityEnd then
            Events.RemoveListener(EventNames.ActivityEnd, self.__eventActivityEnd)
        end
        local parameters         = self.controller.Argument.parameters
        parameters.viewType = self._viewType
        --print( "tpr - MapDecryptionExploreTracking:OnFinalize()" )
        local sceneId = KCookie.Get(MapDecryptionConstants.EventNames.ExploreMapId)
        local questId = KCookie.Get(MapDecryptionConstants.EventNames.TrackQuestId)
        if not (sceneId ~= nil or questId ~= nil) then
            --self._controllerComp:ShowVirtualCameraBySubType(nil)

            MapDecryptionMgr:BlackEaseInAndOut(
                7.0, -- 变黑的速度
                4.0, -- 变淡的速度
                0.1, -- 黑色阶段的时长
                function() -- 进入黑色阶段后要调用的callback
                    self._controllerComp:SwitchVCameraWhenReturn()
                end
            )

            -- cs_coroutine.yield_return()
            
            UICommonUtils.WaitBrainBlendingComplete()
    
            -- Events.Broadcast(MapDecryptionConstants.EventNames.RestoreBubble)
        -- else
            
        end
        
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end



---------------------------------------------------
--- init begin --
---------------------------------------------------

function MapDecryptionExploreTracking:InitData()
    local MapDecryptionConstants = MapDecryptionConstants
    local parameters         = self.controller.Argument.parameters
    self._viewType           = checkNumber(parameters.viewType)
    ---@type MapDecryptionComponent
    local springFestivalComp = MapDecryptionMgr:GetComponent()
    local activityData       = springFestivalComp:GetActivityData()
    local activityContentId  = activityData.activityContentId
    ---@type MapDecryptionPlanVo
    local planVo             = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    self._planVo             = planVo

    local sceneId = KCookie.Get(MapDecryptionConstants.EventNames.ExploreMapId)
    if sceneId then
        KCookie.Set(MapDecryptionConstants.EventNames.ExploreMapId)
    end
    self._sceneId = sceneId
    
    local questId = KCookie.Get(MapDecryptionConstants.EventNames.TrackQuestId)
    if questId then
        KCookie.Set(MapDecryptionConstants.EventNames.TrackQuestId)
    end
    self._questId = questId

    ---@type MapDecryptionExploreTrackingController
    self._controllerComp = MapDecryptionMgr:GetControllerCompByType(MapDecryptionConstants.ControllerCompType.ExploreTracking)

end

function MapDecryptionExploreTracking:InitMapNodes()
    ---@type SceneInstance
    local sceneInstance = SceneManagementIns:GetSceneInstance(self._planVo.sceneId)
    self.worldSpaceCanvas = sceneInstance:GetCacheObjectByName("worldSpaceCanvas")

end

function MapDecryptionExploreTracking:InitSubView(oldViewType)
    local viewType = self._viewType
    self:InitSubViewShowState(oldViewType)

    if self._subViewInitRes[viewType] then return end

    local go, envPath = self:GetGoAndEnvPathByType(viewType)
    ---@type MapDecryptionExplorePanel | MapDecryptionTrackingPanel
    local env = CfUtils.GetLuaScr(go, envPath)
    if isNull(env) then
        return
    end
    self._subViewInitRes[viewType] = true
    local nodePositions, nodeRotations = self._controllerComp:GetAllPositionBySubType(viewType)
    local id = MapDecryptionConstants.ExploreTrackingSubViewType.Explore == viewType
    local ExploreTrackingSubViewType = MapDecryptionConstants.ExploreTrackingSubViewType
    if ExploreTrackingSubViewType.Explore == viewType then
        id = self._sceneId
        self._sceneId = nil
    elseif ExploreTrackingSubViewType.Tracking == viewType then
        id = self._questId
        self._questId = nil
    end
    env:Init(nodePositions, nodeRotations, id, self.controller)

end


-- 点击 "探索望月城", 相机对准桌面, 或从 "望月城" 回到桌面
-- 或者从 "追踪" 战斗中出来, 回到桌面:
function MapDecryptionExploreTracking:InitSubViewShowState(oldViewType)

    --print("tpr -2 MapDecryptionExploreTracking:InitSubViewShowState()")

    -- 播放 地图铺开的音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_open )
    
    local viewType = self._viewType
    KTool.SetActive(self.ExplorePanel.gameObject,  false)
    KTool.SetActive(self.TrackingPanel.gameObject, false)
    if not isNull(self.Root) then
        KTool.SetActive(self.Root.gameObject, false)
    end
    
    -- 更为复杂的 虚拟相机运动:
    cs_coroutine.yield_return(self._controllerComp:ShowVirtualCameraBySubTypePro(viewType))
    
    UICommonUtils.WaitBrainBlendingComplete()

    KTool.SetActive(self.Root.gameObject, true)
    self.Root:Play("SpringFestivalExploreTrackingPlay")

    local ExploreTrackingSubViewType = MapDecryptionConstants.ExploreTrackingSubViewType
    KTool.SetActive(self.ExplorePanel.gameObject,  ExploreTrackingSubViewType.Explore  == viewType) -- 探索面板, 进入望月城入口
    KTool.SetActive(self.TrackingPanel.gameObject, ExploreTrackingSubViewType.Tracking == viewType)

end

function MapDecryptionExploreTracking:InitListener()
    local EventNames = MapDecryptionConstants.EventNames
    self.__eventSwitchExploreOrTracking = Events.AddListener(EventNames.SwitchExploreOrTracking, Bind(self, self.OnEventSwitchExploreOrTracking))
    self.__eventActivityEnd = Events.AddListener(EventNames.ActivityEnd, Bind(self, self.OnEventActivityEndAction))

end


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function MapDecryptionExploreTracking:FreshUI()
    self:FreshSubPanel()

end

function MapDecryptionExploreTracking:FreshSubPanel()
    local go, envPath = self:GetGoAndEnvPathByType(self._viewType)

    ---@type MapDecryptionExplorePanel | MapDecryptionTrackingPanel
    local env = CfUtils.GetLuaScr(go, envPath)
    if isNull(env) then
        return
    end

    env:FreshUI()

end



---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function MapDecryptionExploreTracking:GetGoAndEnvPathByType(subViewType)
    local viewType = self._viewType
    local MapDecryptionConstants = MapDecryptionConstants
    local ExploreTrackingSubViewType = MapDecryptionConstants.ExploreTrackingSubViewType
    local isExplore  = ExploreTrackingSubViewType.Explore  == viewType
    local isTracking = ExploreTrackingSubViewType.Tracking == viewType

    local go, envPath
    if isExplore then
        go, envPath = self.ExplorePanel,  MapDecryptionConstants.EnvPath.ExplorePanel
    elseif isTracking then
        go, envPath = self.TrackingPanel, MapDecryptionConstants.EnvPath.TrackingPanel
    end

    return go, envPath
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function MapDecryptionExploreTracking:OnEventSwitchExploreOrTracking(viewType)
    if self._viewType == viewType then
        return
    end
    --- todo 播放场景翻书动画
    
    UIRaycastBlocker:AddCondition("ExploreTracking.Switch")
    cs_coroutine.start(function ()
        local oldViewType = self._viewType
        self._viewType = viewType
        self:InitSubView(oldViewType)
        self:FreshUI()
        UIRaycastBlocker:RemoveCondition("ExploreTracking.Switch")
    end)

end


function MapDecryptionExploreTracking:OnEventActivityEndAction()
    local viewType    = self._viewType
    local go, envPath = self:GetGoAndEnvPathByType(viewType)
    ---@type MapDecryptionExplorePanel | MapDecryptionTrackingPanel
    local env = CfUtils.GetLuaScr(go, envPath)
    if isNull(env) then
        return
    end

    env:FreshBottomUI(false)

end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return MapDecryptionExploreTracking
