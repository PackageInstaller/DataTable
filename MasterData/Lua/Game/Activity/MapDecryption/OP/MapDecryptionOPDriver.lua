------------ import ------------
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
---@type Engine.Modules.ResourceModule
local ResourceModule = CS.Engine.Modules.ResourceModule
---@type ChapterUtils
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local sceneManagementIns = SceneManagement:GetInstance()
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
local URPCameraController       = CS.Game.Native.URP.URPCameraController
local UINavigationBarRoot = CS.UINavigationBarRoot
local cs_coroutine     = require "XLua.cs_coroutine"
------------ import ------------

------------ define ------------
local IsPlayMapDecryptionOP = "IsPlayMapDecryptionOP"

local UINodePrefabPath = "Prefabs/SpringFestival%s/SpringFestivalOpeningPrologueDialog.prefab"
-- local MoviePrefabPath  = "Prefabs/SpringFestival/SpringFestivalMovieOP.prefab"
------------ define ------------


---@class MapDecryptionOPDriver
local MapDecryptionOPDriver = Class('MapDecryptionOPDriver')


function MapDecryptionOPDriver:__init()
end


function MapDecryptionOPDriver:__delete()

end

--- Start
---@param activityData ActivityDojo
function MapDecryptionOPDriver:Start(activityData)
    self._activityData = activityData
    local key    = self:GetLocalDataKey(activityData)
    local isPlayOP = checkNumber(CfUtils.GetLocalData(key)) == 0
    if isPlayOP then
        self:StartOp(activityData, key)
    else
        self:EnterMapDecryptionPanel(activityData, isPlayOP)
    end
    -- self:EnterMapDecryptionPanel(activityData, false)
end

--- StartOp
---@param activityData table 
function MapDecryptionOPDriver:StartOp(activityData, key)
    local activityContentId = activityData.activityContentId

    ---@type MapDecryptionPlanVo
    local planVo       = CfUtils.GetCfVo(AutoIds.IdSetting2801, "MapDecryptionPlanVo", activityContentId)
    local moviePath    = planVo.story2
    -- local moviePath = "Movie/op_rain_loop_01.usm"
    KCookie.Set(Constants.UICacheDataKeys.SPECIFY_SCENE_LOADING_MOVIE_PATH, moviePath)
    UIRaycastBlocker:AddCondition("MapDecryptionOPDriver.StartOp")
    cs_coroutine.start(function ()
        cs_coroutine.yield_return(self:PlayStory1(planVo.story1, activityData.prefab, planVo))
        CfUtils.WriteLocalData(key, 1)
        self:EnterMapDecryptionPanel(activityData, true)
    end)

end

function MapDecryptionOPDriver:PlayStory1(story1, prefabId, planVo)
    return ChapterUtils.StartExternalChapter(story1, function(loader, go)
        -- local mainCamera     = URPCameraController.Instance.mainCamera
        -- KTool.SetActive(mainCamera.gameObject, false)

        local luaBehaviour = AddLuaBehaviour(go, "Game.Activity.MapDecryption.OP.MapDecryptionPlayer")
        ---@type MapDecryptionPlayer
        local env = luaBehaviour.Env
        if not isNull(env) then
            env:Initialize()
            env:InitializePrefab(string.format(UINodePrefabPath, prefabId), go)
            env:InitializeBind(planVo, go)
            self._env = env
        end

        self._plotGo     = go
        self._plotLoader = loader

        -- Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
        UINavigationBarRoot.Instance:SetActive(false)
        
        local lastDialog = UIModule.CurrentScreen:LastDialog()
        if not isNull(lastDialog) then
            -- lastDialog.transform.localPosition = Vector3(9999, 9999, 9999)
            CfUtils.SetActive(lastDialog, false)
        end
        UIRaycastBlocker:RemoveCondition("MapDecryptionOPDriver.StartOp")
        
    end, function(go)
        -- print("MapDecryptionOPDriver finished")
        -- if self._env then
        --     self._env:Clear()
        -- end
        if self._preloadGo then
            KTool.SafeDelete(self._preloadGo)
        end
        KTool.SafeDelete(self._plotGo)
        if self._plotLoader then
            self._plotLoader:Release(true)
        end
        
    end, function (go)
        ---@type MapDecryptionPlayer
        local env = CfUtils.GetLuaScr(go, "Game.Activity.MapDecryption.OP.MapDecryptionPlayer")
        if not isNull(env) then
            env:InitializeCamera()
            env:StartPlay()
            env:SetLoopEventCallback(Bind(self, self.OnLoopEventCallback))
        end
    end)
end

function MapDecryptionOPDriver:EnterMapDecryptionPanel(activityData, isPlayOp)
    local parameters = {
        activityData      = activityData,
        isPlayOp          = isPlayOp,
        luaPath           = "Game.Activity.MapDecryption.MapDecryptionSceneEnter",
        isSaveSceneRecord = true,

    }
    -- GameUtils.OpenLoadingPanel(UIArgs(Constants.UITypeIds.UISceneMapDecryption, parameters), { UIArgs(Constants.UITypeIds.MapDecryptionHomeView, parameters) }, Constants.LoadingType.SpecifyScene, false)

    GameUtils.OpenLoadingPanel(
        UIArgs(Constants.UITypeIds.UISceneMapDecryption, parameters),
        { UIArgs(Constants.UITypeIds.MapDecryptionHomeView, parameters) }, Constants.LoadingType.Others, false, true)
end

function MapDecryptionOPDriver:GetLocalDataKey(activityData)
    return table.concat({IsPlayMapDecryptionOP, activityData.id, activityData.activityContentId}, "_")
end

function MapDecryptionOPDriver:OnLoopEventCallback()
    if not isNull(self._env) then
        self._env:SetPreloadGoShowState(true)
    end
end

return MapDecryptionOPDriver
