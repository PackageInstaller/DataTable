
---{
--- luaPath:string  必传 scene 入口脚本路径
---}

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait

------------ import ------------
---@type ClubGVGUtils
local ClubGVGUtils             = import("Game.UI.Club.GVG.ClubGVGUtils")
local TileMap                  = CS.UnityEngine.Tilemaps.Tilemap
local URPCameraController      =  CS.Game.Native.URP.URPCameraController.Instance
local UINavigationBarRoot      = CS.UINavigationBarRoot
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie                  = CS.Engine.Lib.KCookie
---@type Engine.UI.UIModule
local UIModule                 = CS.Engine.UI.UIModule
local cs_coroutine             = require "XLua.cs_coroutine"
local ResourceModule           = CS.Engine.Modules.ResourceModule
local EasyTouch                = CS.HedgehogTeam.EasyTouch.EasyTouch
local CanvasType                    = typeof(CS.UnityEngine.Canvas)
-- local Vector3Int = CS.UnityEngine.Vector3Int

---@type ClubGVGTileSelectControl
local ClubGVGTileSelectControl     = import('Game.UI.Club.GVG.ClubGVGTileSelectControl')

------------ import ------------

------------ define ------------
local GVGConstants = ClubGVGUtils.Constants
local TileMapType  = typeof(TileMap)
local SetActive = CfUtils.SetActive
local yield = cs_coroutine.yield_return

local SubPanelType = {
    SafeMode     = 1, --- 安全模式
    Banner       = 2, --- 横幅（行军或连胜或终结连胜）
    RebornDetail = 3, --- 重生信息
    Watch        = 4, --- 观战节点
}
------------ define ------------

---@class ClubGVGSceneLaunch
local ClubGVGSceneLaunch = Class("ClubGVGSceneLaunch")

function ClubGVGSceneLaunch:__init()
    self._path2loading = {}
    self._subPanelType2Go = {}
    self._subPanelType2IsShow = {}
    self._extraPrefab2Ins = {}
    self._extraPrefab2Canvas = {}
end

function ClubGVGSceneLaunch:__delete()
    
end

function ClubGVGSceneLaunch:Awake(parameters, launch)
    self._parameters = parameters
    self._launch     = launch
    
end

function ClubGVGSceneLaunch:OnInitialize()
    self:Initial()
end

function ClubGVGSceneLaunch:OnShow()
    
end

function ClubGVGSceneLaunch:OnFocus(focus)

end

function ClubGVGSceneLaunch:OnHide()
    self:RemoveListener()
    self:ClearCache()
end

function ClubGVGSceneLaunch:OnFinalize()
    
end

--region Initial
function ClubGVGSceneLaunch:Initial()
    self:InitData()
    
end

function ClubGVGSceneLaunch:InitData()
    ClubGVGUtils.Initial()
    self._streamerDurationSeconds = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.StreamerDurationSeconds)

    self.RootCanvas = UIModule.RootCanvas.transform
    KCookie.Set(Constants.UICacheDataKeys.OVERSEA_ANNIHILATION_KEY, 1)
end

function ClubGVGSceneLaunch:InitListener()
    local Bind       = Bind
    local EventNames = ClubGVGUtils.Constants.EventNames
    self._listeners = CfUtils.EventsDecorated({
        [EventNames.ActivityEnd]                    = Bind(self, self.OnActivityEndAction),
        [EventNames.FocusHomeDialog]                = Bind(self, self.OnFocusHomeDialog),
        [EventNames.ChangeCountDown]                = Bind(self, self.OnEventChangeCountDown),
        [EventNames.ShowBannerUI]                   = Bind(self, self.OnEventShowBannerUI),
        [EventNames.DataUpdate]                     = Bind(self, self.OnEventDataUpdate),
        [EventNames.ReceiveRecord]                  = Bind(self, self.OnEventReceiveRecord),
        -- [EventNames.DrawLines]                   = Bind(self, self.OnEventDrawLines),
        [EventNames.FocusBuilding]                  = Bind(self, self.OnEventFocusBuilding),
        [EventNames.ControlBuildingEff]             = Bind(self, self.OnEventControlBuildingEff),
        [EventNames.RequestSuccess]                 = Bind(self, self.OnEventRequestSuccess),
        [EventNames.SetCameraShowState]             = Bind(self, self.OnSetCameraShowState),
        [EventNames.ChangeBuildingDetailsShowState] = Bind(self, self.OnEventChangeBuildingDetailsShowState),
        [EventNames.ChangeOrthographicSize]         = Bind(self, self.OnEventChangeOrthographicSize),
        [Constants.EventNames.CameraWidthMatcherChangeOrthSizeComplete]         = Bind(self, self.OnEventChangeOrthSizeComplete),

    })
end

function ClubGVGSceneLaunch:RemoveListener()
    CfUtils.EventsUndecorated(self._listeners)
end



--endregion

--region scene load

--- 真实场景加载前 预处理
function ClubGVGSceneLaunch:PreHandler(loadingUI)
    URPCameraController:SetMainCameraActive(false)

    self._extraPrefab2Path = {
        [GVGConstants.ExtraPrefabType.MpaSelectAsset]        = GVGConstants.PrefabPath.MpaSelectAsset,
        [GVGConstants.ExtraPrefabType.BuildingInfoContainer] = GVGConstants.PrefabPath.OverseaClubGvgBuildingInfoContainer,
        [GVGConstants.ExtraPrefabType.EffectContainer]       = GVGConstants.PrefabPath.OverseaClubGvgGroupEffectContainer,
    }

    self._extraPrefab2Loader = {}
    for extraPrefabType, path in pairs(self._extraPrefab2Path) do
        local loader = ResourceModule.LoadBundleAsync(path, nil, true )    
        self._extraPrefab2Loader[extraPrefabType] = loader
    end

    -- self._mapSelectAssetLoader = ResourceModule.LoadBundleAsync(GVGConstants.PrefabPath.MpaSelectAsset, nil, true )
    
end

--- 真实场景加载完成 后处理
---@param loadingUI UILoadingPanel
---@param sceneInstance SceneInstance
function ClubGVGSceneLaunch:PostHandler(loadingUI, sceneInstance)
    local gridGo          = sceneInstance:GetCacheObjectByName(GVGConstants.Name.Grid)
    local gridTrans       = gridGo.transform
    local TileMapBuilding = gridTrans:Find(GVGConstants.Name.Tilemap_building)
    local TileMapSelect   = gridTrans:Find(GVGConstants.Name.Tilemap_select)
    -- local TileMapSelect   = gridTrans:Find(GVGConstants.Name)
    
    local buildingTileMap = TileMapBuilding:GetComponent(TileMapType)
    local selectTileMap   = TileMapSelect:GetComponent(TileMapType)
    
    local cameraGo          = sceneInstance:GetCacheObjectByName(GVGConstants.Name.MainCamera)
    self._cameraGo = cameraGo
    ---@type UnityEngine.Camera
    local cameraComp = KTool.GetComponent(cameraGo, typeof(CS.UnityEngine.Camera))
    URPCameraController:InitCameraStack(cameraComp)

    ---@type ClubGVGMgr
    local mgr = ClubGVGUtils.GetMgr()
    while not mgr:GetIsRequestHomeComplete() or mgr:GetBuildId2TileData() == nil do
        yield()
    end

    local isFailure = mgr:GetRequestFailure()
    if isFailure then
        return isFailure
    end

    for extraPrefabType, loader in pairs(self._extraPrefab2Loader) do
        while not loader.IsCompleted do
            yield()
        end
        if extraPrefabType == GVGConstants.ExtraPrefabType.MpaSelectAsset then
            self._extraPrefab2Ins[extraPrefabType] = loader.ResultObject
            loader:Retain(gridGo)
            loader:Release()
        else
            local go = loader:Instantiate()
            self._extraPrefab2Ins[extraPrefabType] = go
            KTool.SetParent(go, self.RootCanvas.gameObject, false)
        end
    end

    local linesGo          = sceneInstance:GetCacheObjectByName(GVGConstants.Name.Lines)
    local CameraRoot       = sceneInstance:GetCacheObjectByName(GVGConstants.Name.CameraRoot)
    local BuildingInfoContainer = self._extraPrefab2Ins[GVGConstants.ExtraPrefabType.BuildingInfoContainer]
    local EffectContainer = self._extraPrefab2Ins[GVGConstants.ExtraPrefabType.EffectContainer]
    ---@type ClubGVGCameraControl
    self._cameraControl = CfUtils.GetLuaScr(CameraRoot, GVGConstants.LuaPath.ClubGVGCameraControl)
    if isNotNull(self._cameraControl) then
        self._cameraControl:Init(cameraComp, buildingTileMap, mgr, BuildingInfoContainer, EffectContainer, linesGo)
        self:InitCameraPosition()
    end

    local selectTileBase = self._extraPrefab2Ins[GVGConstants.ExtraPrefabType.MpaSelectAsset]
    ---@type ClubGVGTileSelectControl
    local tileSelectControl = ClubGVGTileSelectControl.New()
    tileSelectControl:Init(buildingTileMap, selectTileMap, cameraComp, mgr, selectTileBase)
    self._tileSelectControl = tileSelectControl

    self:InitListener()

    local dojo = mgr:GetHomeDojo()
    local clubIsDie = dojo.clubIsDie == 1
    if clubIsDie then
        self:FreshWatchNodeShowStatus(true)
    end


    -- test
    -- local buildingId2BuildingInfo = mgr:GetBuildId2BuildInfo()
    -- buildingId2BuildingInfo[40001].clubId = mgr:GetClubId()
    -- print(mgr:GetClubId())
    -- self:OnEventReceiveRecord(GVGConstants.ReportId.Building_Change, {bid = 40001, cid = mgr:GetClubId()})
end

---@todo 实现相机定位
function ClubGVGSceneLaunch:InitCameraPosition()
    self:OnEventFocusBuilding()

end

-- ---@todo 实现线的绘制
-- function ClubGVGSceneLaunch:DrawLines()
    
-- end

-- --region tile select frame

-- ---@todo 实现地块占领状态
-- function ClubGVGSceneLaunch:DrawSelectFrame()
    
    
-- end

-- function ClubGVGSceneLaunch:UpdateSelectFrame()
    
-- end


--endregion

--- 真实场景加载完成 关闭loading
function ClubGVGSceneLaunch:CloseLoading(loadingUI)
    UINavigationBarRoot.Instance:SetActive(true)
end

--endregion

--- 清理缓存
function ClubGVGSceneLaunch:ClearCache()
    for extraPrefabType, ins in pairs(self._extraPrefab2Ins) do
        if extraPrefabType ~= GVGConstants.ExtraPrefabType.MpaSelectAsset then
            KTool.SafeDelete(ins)
        end
    end
    for key, go in pairs(self._subPanelType2Go) do
        KTool.SafeDelete(go)
    end
    self._subPanelType2Go = nil
    KCookie.Set(Constants.UICacheDataKeys.OVERSEA_ANNIHILATION_KEY)
    ClubGVGUtils.Clear()
end

function ClubGVGSceneLaunch:OnEventChangeCountDown(curSeconds)
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    local stage = dojo.stage
    local stageLeftSeconds = dojo.stageEndSeconds - curSeconds
    self:FreshSafeModeCD(stageLeftSeconds < self._streamerDurationSeconds and stage == GVGConstants.Stage.Preview, stageLeftSeconds)

    if curSeconds > dojo.attackCDEndTime then
        local leftRebirthSeconds = dojo.rebirthTime - curSeconds
        self:FreshRebornDetailUI(leftRebirthSeconds, dojo.leftRebirthTimes)
    end

    self._cameraControl:UpdateBySeconds(curSeconds)
end


function ClubGVGSceneLaunch:OnFocusHomeDialog(focus)
    if isNull(self._cameraControl) then
        return
    end
    self._cameraControl:SetIsActive(focus)
    
end

function ClubGVGSceneLaunch:OnActivityEndAction()
    GameUtils.Toast("活动已结束")    

    local extraUIPages = {
        { id = Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, parameters = {levelUpType = Constants.UICultivateLevelUpFinishType.ClubGVGEnd}}
    }
    self:CloseScene(extraUIPages)

end

function ClubGVGSceneLaunch:CloseScene(extraUIPages)
    ClubGVGUtils.CloseScene(extraUIPages)
end


function ClubGVGSceneLaunch:OnEventShowBannerUI(...)
    self:FreshBannerUI(...)
end


function ClubGVGSceneLaunch:OnEventDataUpdate(triggerType, data, extraData)
    if triggerType == GVGConstants.TriggerType.March_Complete then
        ---@type {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
        local marchData = data
        self._cameraControl:RemoveMarchLine(marchData)
        self._cameraControl:FreshBuilding(marchData.startBuilding)
        self._cameraControl:FreshBuilding(marchData.endBuilding)

        self._cameraControl:FreshSelectBuildingStatus(marchData.startBuilding)
        self._cameraControl:FreshSelectBuildingStatus(marchData.endBuilding)
        
    elseif triggerType == GVGConstants.TriggerType.Protection_Period_Limit_Remove then
        self._cameraControl:RemoveAllProtectionPeriod()

    elseif triggerType == GVGConstants.TriggerType.Rebirth_Limit_Remove then
        local buildingId = data.buildingId
        self:OnEventFocusBuilding(buildingId, true)
        self._cameraControl:FreshSelectBuildingStatus(buildingId)
        
    elseif triggerType == GVGConstants.TriggerType.Atk_Player_Limit_Remove then
        local buildingIds = extraData.buildingIds
        for index, buildingId in ipairs(buildingIds) do
            self._cameraControl:FreshBuilding(buildingId)
        end

    elseif triggerType == GVGConstants.TriggerType.Atk_Building_Limit_Remove then
        local buildingId = extraData
        self._cameraControl:FreshBuilding(buildingId)

    end

    if data ~= nil and data.bid then
        local bid = data.bid
        self._cameraControl:FreshBuilding(bid)
        self._cameraControl:FreshSelectBuildingStatus(bid)
    end
end

function ClubGVGSceneLaunch:OnEventReceiveRecord(dataType, reportData, isFindSelf, extraData)
    if dataType == GVGConstants.ReportId.Building_Change then
        local oldBuildingClubId = extraData
        local buildingId = checkNumber(reportData.bid)
        local clubId = checkNumber(reportData.cid)
        ClubGVGUtils.CheckAndShowMessage(buildingId, clubId, oldBuildingClubId)

        self._tileSelectControl:DrawSelectColor(buildingId, clubId)
    elseif dataType == GVGConstants.ReportId.March or dataType == GVGConstants.ReportId.Accelerate then
        ---@type {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
        local marchData = extraData
        self._cameraControl:UpdateOrAddMarchLine(marchData, GameUtils.GetServerTime())

        if dataType == GVGConstants.ReportId.March then
            self._cameraControl:FreshBuilding(marchData.startBuilding)
            self._cameraControl:FreshBuilding(marchData.endBuilding)

            self._cameraControl:FreshSelectBuildingStatus(marchData.startBuilding)
            self._cameraControl:FreshSelectBuildingStatus(marchData.endBuilding)
        end
    elseif dataType == GVGConstants.ReportId.Join then
        local playerInfo          = checkTable(reportData.playerInfo)
        local playerPlace = checkNumber(playerInfo.place)
        if playerPlace > 0 then
            self._cameraControl:FreshBuilding(playerPlace)
            self._cameraControl:FreshSelectBuildingStatus(playerPlace)
        end

    elseif dataType == GVGConstants.ReportId.Player_Die then
        local result = checkNumber(reportData.r)
        local isClubDie = extraData.isClubDie
        if isClubDie then
            local playerIds = checkTable(reportData.pids)
            for index, playerId in ipairs(playerIds) do
                self._cameraControl:RemoveMarchLineById(playerId)
            end
            if isFindSelf then
                self:FreshWatchNodeShowStatus(true)
            end
        end

        local buildingIds = extraData.buildingIds
        for index, buildingId in ipairs(buildingIds) do
            self._cameraControl:FreshBuilding(buildingId)
        end

    elseif dataType == GVGConstants.ReportId.Building_Change_Multi then
        local bids = reportData.bids
        for key, buildingId in pairs(bids) do
            self._cameraControl:FreshBuilding(buildingId)
            self._tileSelectControl:DrawSelectColor(buildingId, 0)
        end

    end

    if reportData ~= nil and reportData.bid then
        -- print("reportData", table.toString(reportData))
        local buildingId = reportData.bid
        self._cameraControl:FreshBuilding(buildingId)
        self._cameraControl:FreshSelectBuildingStatus(buildingId)
    end
end


function ClubGVGSceneLaunch:OnEventShowRebornDetailUI()
    self:FreshRebornDetailUI()
end


function ClubGVGSceneLaunch:OnEventFocusBuilding(buildingId, isRebirth)
    if buildingId == nil then
        buildingId = self:GetPlayerPlace()
    end
    self._cameraControl:FocusBuilding(buildingId, isRebirth)
    
end

function ClubGVGSceneLaunch:GetPlayerPlace()
    ---@type ClubGVGHomeDojo
    local dojo = self:GetDojo()
    local playerPlace  = checkNumber(dojo.playerPlace)
    local buildingId = playerPlace == 0 and dojo.clubPlace or playerPlace
    return buildingId
end

function ClubGVGSceneLaunch:OnEventControlBuildingEff(isShow)
    local BuildingInfoContainer = self._extraPrefab2Ins[GVGConstants.ExtraPrefabType.BuildingInfoContainer]
    local canvas =  KTool.GetComponent(BuildingInfoContainer , typeof(CS.UnityEngine.Canvas))
    canvas.enabled = isShow
    self._cameraControl:FreshAllBuildingEffectShowStatus(isShow)
    
end

function ClubGVGSceneLaunch:OnEventRequestSuccess(interface)
    if interface == Interfaces.OverseaClubGVGHome then
        -- self._cameraControl:DrawAreaInfo()
        self._cameraControl:ReloadBuildings()
    end

    
end

function ClubGVGSceneLaunch:OnSetCameraShowState(isShow)
    SetActive(self._cameraGo, isShow)
    
end

function ClubGVGSceneLaunch:OnEventChangeBuildingDetailsShowState(isClose)
    self._cameraControl:DisableTouchState(not isClose)
 
end

function ClubGVGSceneLaunch:OnEventChangeOrthographicSize(num)
    self._orthSize = num
    if isNotNull(self._cameraControl) then
        self._cameraControl:ChangeOrthographicSize(num, self:GetPlayerPlace())
    end
 
end

function ClubGVGSceneLaunch:OnEventChangeOrthSizeComplete()
    if isNotNull(self._cameraControl) then
        self._cameraControl:CompleteChangeOrthographicSize(self._orthSize, self:GetPlayerPlace())
    end
end

---@return ClubGVGGroupSafeModeCountdown
function ClubGVGSceneLaunch:GetSafeModeEnv()
    if isNull(self._safeModeEnv) then
        self:LoadPrefab(GVGConstants.PrefabPath.OverseaClubGvgGroupSafeModeCountdownPopup, function (go)
            if isNull(self) then return end
            self._subPanelType2Go[SubPanelType.SafeMode] = go
            self._safeModeEnv = CfUtils.GetLuaScr(go, GVGConstants.LuaPath.ClubGVGGroupSafeModeCountdown)
            if isNotNull(self._safeModeEnv) then
                self._safeModeEnv:SetCloseCb(function ()
                    self._isShowSafeMode = false
                end)
            end
            ---@type ClubGVGHomeDojo
            local dojo = self:GetDojo()
            local stageLeftSeconds = dojo.stageEndSeconds - GameUtils.GetServerTime()
            self:FreshSafeMode(self._safeModeEnv, stageLeftSeconds)
        end)
        
    end
    return self._safeModeEnv
end


function ClubGVGSceneLaunch:FreshSafeModeCD(isShow, stageLeftSeconds)
    if self._isShowSafeMode ~= isShow then
        self._isShowSafeMode = isShow
        SetActive(self._subPanelType2Go[SubPanelType.SafeMode], isShow)
    end
    if isShow then
        ---@type ClubGVGGroupSafeModeCountdown
        local env = self:GetSafeModeEnv()
        self:FreshSafeMode(env, stageLeftSeconds)
    end

end

--- 刷新安全时间
---@param env ClubGVGGroupSafeModeCountdown
function ClubGVGSceneLaunch:FreshSafeMode(env, stageLeftSeconds)
    if isNotNull(env) then
        env:FreshUI(stageLeftSeconds)
    end
end

---@return ClubGVGGroupDefeatPlayerNode
function ClubGVGSceneLaunch:GetBannerEnv(data, dataType)
    local isEmpty = isNull(self._bannerEnv)
    if isEmpty then
        self:LoadPrefab(GVGConstants.PrefabPath.OverseaClubGvgGroupDefeatPlayerNode, function (go)
            if isNull(self) then return end
            self._subPanelType2Go[SubPanelType.Banner] = go
            
            self._bannerEnv = CfUtils.GetLuaScr(go, GVGConstants.LuaPath.ClubGVGGroupDefeatPlayerNode)
            self:FreshBannerEnv(self._bannerEnv, data, dataType)
        end)
        
    end
    return self._bannerEnv, isEmpty
end


function ClubGVGSceneLaunch:FreshBannerUI(data, dataType)
    ---@type ClubGVGGroupDefeatPlayerNode
    local env, isEmpty = self:GetBannerEnv(data, dataType)
    if isEmpty then return end
    self:FreshBannerEnv(env, data, dataType)

end

---@param env ClubGVGGroupDefeatPlayerNode
function ClubGVGSceneLaunch:FreshBannerEnv(env, data, dataType)
    if isNotNull(env) then
        env:FreshUI(data, dataType)
    end
end


---@return ClubGVGGroupRebornDetailsNode
function ClubGVGSceneLaunch:GetRebornDetailEnv(leftRebirthSeconds, leftRebirthTimes)
    if isNull(self._rebornDetailEnv) then
        self:LoadPrefab(GVGConstants.PrefabPath.OverseaClubGvgGroupRebornDetailsNode, function (go)
            if isNull(self) then return end
            self._subPanelType2Go[SubPanelType.RebornDetail] = go
            self._rebornDetailEnv = CfUtils.GetLuaScr(go, GVGConstants.LuaPath.ClubGVGGroupRebornDetailsNode)
            
            self:FreshRebornDetailEnv(self._rebornDetailEnv, leftRebirthSeconds, leftRebirthTimes)
        end)
        
    end
    return self._rebornDetailEnv
end


---刷新复活详情
function ClubGVGSceneLaunch:FreshRebornDetailUI(leftRebirthSeconds, leftRebirthTimes)
    local isShow = leftRebirthSeconds >= 0
    if self._isShowRebornDetail ~= isShow then
        self._isShowRebornDetail = isShow
        if isNotNull(self._rebornDetailEnv) then
            self._rebornDetailEnv:PlayAniOut()
        end
        -- SetActive(self._subPanelType2Go[SubPanelType.RebornDetail], isShow)
    end

    if not isShow then
        return
    end
    ---@type ClubGVGGroupRebornDetailsNode
    local env = self:GetRebornDetailEnv(leftRebirthSeconds, leftRebirthTimes)
    self:FreshRebornDetailEnv(env, leftRebirthSeconds, leftRebirthTimes)
end

---@param env ClubGVGGroupRebornDetailsNode
function ClubGVGSceneLaunch:FreshRebornDetailEnv(env, leftRebirthSeconds, leftRebirthTimes)
    if isNotNull(env) then
        env:FreshUI(leftRebirthSeconds, leftRebirthTimes)
    end
end

function ClubGVGSceneLaunch:FreshWatchNodeShowStatus(isShow)
    local node = self:GetWatchNode()
    SetActive(node, isShow)
end

function ClubGVGSceneLaunch:GetWatchNode(isShow)
    if self._subPanelType2Go[SubPanelType.Watch] == nil then 
        self:LoadPrefab(GVGConstants.PrefabPath.OverseaClubGvgGroupWatchNode, function (go)
            if isNull(self) then return end
            self._subPanelType2Go[SubPanelType.Watch] = go
            SetActive(go, isShow)
        end)
    end
    return self._subPanelType2Go[SubPanelType.Watch]
end

function ClubGVGSceneLaunch:LoadPrefab(prefabPath, callback, parent)
    if self._path2loading[prefabPath] then
        return true
    end

    self._path2loading[prefabPath] = true
    UICommonUtils.LoadGameObject(prefabPath, function (...)
        if isNull(self) then return end
        if callback then
            callback(...)
        end
        
        self._path2loading[prefabPath] = false

    end, parent or self.RootCanvas)
end

---@return ClubGVGHomeDojo
function ClubGVGSceneLaunch:GetDojo()
    ---@type ClubGVGHomeDojo
    local dojo = ClubGVGUtils.GetComp():GetDojo()
    return dojo
end

---@return UnityEngine.Canvas
function ClubGVGSceneLaunch:GetExtraPrefabCanvas(extraPrefabType)
    local canvas = self._extraPrefab2Canvas[extraPrefabType]
    if isNull(canvas) then
        local ins = self._extraPrefab2Ins[extraPrefabType]
        canvas = KTool.GetComponent(ins, CanvasType)
        self._extraPrefab2Canvas[extraPrefabType] = canvas
    end
    return canvas
end

return ClubGVGSceneLaunch