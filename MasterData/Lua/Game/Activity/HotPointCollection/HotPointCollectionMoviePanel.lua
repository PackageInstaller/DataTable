
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type Engine.UI.UIModule
local UIModule              = CS.Engine.UI.UIModule
---@type Engine.Lib.KTool
local KTool                 = CS.Engine.Lib.KTool
local UINavigationBarRoot   = CS.UINavigationBarRoot
local Yielders              = CS.Engine.Lib.Yielders
local cs_coroutine          = require "XLua.cs_coroutine"
--endregion

--region define
local CriManaMovieControllerForUIType = typeof(CS.CriWare.CriManaMovieControllerForUI)
local AnimationType = typeof(CS.UnityEngine.Animation)
local UIAutoCameraFixType = typeof(CS.Engine.UI.UIAutoCameraFix)
local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')


local yield_return = cs_coroutine.yield_return
local EndOfFrame   = Yielders.EndOfFrame
local PlayEnd      = CS.CriWare.CriMana.Player.Status.PlayEnd
--endregion

local HotPointCollectionMoviePanel = Class('HotPointCollectionMoviePanel')

-- function HotPointCollectionMoviePanel:__init()

-- end


-- function HotPointCollectionMoviePanel:__delete()

-- end


--region init 


--endregion 


--region logic 



function HotPointCollectionMoviePanel:Start(moviePrefabPath, moviePath, ...)
    if string.isEmpty(moviePrefabPath) then
        printError("视频预制路径是空的")
        return 
    end
    if string.isEmpty(moviePath) then
        printError("视频链接是空的")
        return 
    end

    KTool.SetActive(UINavigationBarRoot.Instance.gameObject, false)
    return UICommonUtils.BlockerAndStartCo(moviePrefabPath, Bind(self, self.LoadAndPlayMovie, moviePrefabPath, moviePath, ...))

end

function HotPointCollectionMoviePanel:LoadAndPlayMovie(moviePrefabPath, moviePath, design, animNameOut, endCallback, isDefaultShowSkip)
    local moviePrefab = GameUtils.LoadBundleAsync(moviePrefabPath, UIModule.RootCanvas.gameObject)
    
    ---@type CriWare.CriManaMovieControllerForUI
    local movieController = moviePrefab:GetComponentInChildren(CriManaMovieControllerForUIType)

    movieController.player:SetFile(nil, GameUtils.GetManaPath(moviePath))
    movieController:Play()
    CriWareUtils.StopAll()

    if design then
        ---@type Engine.UI.UIAutoCameraFix
        local autoCameraFix = moviePrefab:GetComponentInChildren(UIAutoCameraFixType)
        autoCameraFix.designW = design.x
        autoCameraFix.designH = design.y
    end

    local animComponent
    if animNameOut then
        animComponent = moviePrefab:GetComponentInChildren(AnimationType)
    end

    local wait = true
    movieController.player.statusChangeCallback = function(status)
        if status == PlayEnd then
            wait = false
        end
    end

    if not isDefaultShowSkip then
        CoYield(3)
    end

    --- 显示跳过按钮
    if self._waitCoCb then
        self._waitCoCb()
    end
    
    self._co = cs_coroutine.start(function() 
        while wait do
            yield_return(EndOfFrame)
        end
        self._co = nil
    end)

    while self._co ~= nil do
        yield_return(EndOfFrame)
    end

    CriWareUtils.PlayLastBGMMusic()
    CriWareUtils.ClearLastBGMRecord()
    movieController.player.statusChangeCallback = nil

    if animComponent then
        animComponent:Play(animNameOut)
        while animComponent:IsPlaying(animNameOut) do
            yield_return(EndOfFrame)
        end
    end

    KTool.SafeDelete(moviePrefab)

    if self._waitCoEndCb then
        self._waitCoEndCb()
    end
    
    KTool.SetActive(UINavigationBarRoot.Instance.gameObject, true)
    
    if endCallback then
        endCallback()
    end

end

function HotPointCollectionMoviePanel:Close()
    if isNotNull(self._co) then
        cs_coroutine.stop(self._co)
        self._co = nil
    end
    
end

--endregion 


--region get/set 

function HotPointCollectionMoviePanel:SetWaitCoIsStartCb(cb)
    self._waitCoCb = cb
end


function HotPointCollectionMoviePanel:SetWaitCoIsEndCb(cb)
    self._waitCoEndCb = cb
end

---endregion 


--region handler 


---endregion 


return HotPointCollectionMoviePanel
