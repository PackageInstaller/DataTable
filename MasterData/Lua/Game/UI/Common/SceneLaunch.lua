
---{
--- luaPath:string  必传 scene 入口脚本路径
---}

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait

------------ import ------------
local sceneManagement     = SceneManagement:GetInstance()
local Yielders            = CS.Engine.Lib.Yielders
local cs_coroutine        = import('XLua.cs_coroutine')
------------ import ------------

------------ define ------------

local SceneMaxProgress    = 60

local yield               = cs_coroutine.yield_return
local EndOfFrame          = Yielders.EndOfFrame
------------ define ------------

---@class SceneLaunch
local SceneLaunch = Class("SceneLaunch")

function SceneLaunch:__init()
    
end

function SceneLaunch:__delete()
    self._launch:__delete()
    self.controller = nil
end

function SceneLaunch:Awake()
    local parameters = self.controller.Argument.parameters
    self._parameters = parameters
    self._sceneId         = self._parameters.sceneId
    local luaPath    = parameters.luaPath
    assert(not string.isEmpty(luaPath), "parameters not find luaPath")
    ---@type ClubGVGSceneLaunch
    self._launch = import(luaPath).New(parameters)
    --- New 会掉 __init
    if self._launch.Awake then
        self._launch:Awake(parameters, self)
    end
    
end

function SceneLaunch:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._launch.OnInitialize then
            self._launch:OnInitialize()
        end
        
    end))
    return coWait
end

function SceneLaunch:OnShow()
    --- @type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._launch.OnShow then
            self._launch:OnShow()
        end

    end))
    return coWait
end

function SceneLaunch:OnFocus(focus)
    if self._launch.OnFocus then
        self._launch:OnFocus(focus)
    end

end

function SceneLaunch:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._launch.OnHide then
            self._launch:OnHide()
        end

        self:UnloadScene()

        
    end))
    return coWait
end

function SceneLaunch:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if self._launch.OnFinalize then
            self._launch:OnFinalize()
        end

        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

function SceneLaunch:AsyncLoadingResources()
    local launch = self._launch
    ---@type UILoadingPanel
    local loadingUI = self:GetLoadingUI()
    --- 真实场景加载前 预处理
    if launch and launch.PreHandler then
        launch:PreHandler(loadingUI)
    end

    ---自定义加载进度的逻辑在此处
    local displayProgress = 0
    local toProgress      = SceneMaxProgress
    local sceneId         = self._sceneId
    sceneManagement:Transition({ identifier = sceneId, isCache = true })
    while sceneManagement:IsTransition() do
        displayProgress = self:UpdateProgress(loadingUI, displayProgress, toProgress)
    end

    local isFailure
    --- 真实场景加载完成后处理
    if launch and launch.PostHandler then
        ---@type SceneInstance
        local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
        isFailure = launch:PostHandler(loadingUI, sceneInstance)
    end
    
    if launch and launch.CloseLoading then
        launch:CloseLoading(loadingUI)
    end

    loadingUI:Close()
    if isFailure then
        CfUtils.ConditionAppend("SceneLaunch.CloseScene")
        GameUtils.ShowBlack(1.2, nil, function() 
            GameUtils.HideBlack(0.1)
            CfUtils.ConditionRemove("SceneLaunch.CloseScene")
            if launch and launch.CloseScene then
                launch:CloseScene()
            end

        end)

    end
end

--- UpdateProgress
---@param loadingUI UILoadingPanel
---@param displayProgress number 
---@param toProgress number
function SceneLaunch:UpdateProgress(loadingUI, displayProgress, toProgress)
    if displayProgress < toProgress then
        while displayProgress < toProgress do
            displayProgress = displayProgress + 1.5
            loadingUI:__Progress(displayProgress * 0.01)
            yield(EndOfFrame)
        end
    else
        yield(EndOfFrame)
    end
    return displayProgress
end

function SceneLaunch:UnloadScene()
    local sceneId         = self._sceneId
    local sceneInstance = sceneManagement:GetSceneInstance(sceneId)
    if sceneInstance then
        coroutine.yield(sceneManagement:UnloadScene(sceneInstance))
    end
end

---@param loadingUI UILoadingPanel
function SceneLaunch:SetLoadingUI(loadingUI)
    self._loadingUI = loadingUI
end

---@return UILoadingPanel
function SceneLaunch:GetLoadingUI()
    return self._loadingUI
end

return SceneLaunch