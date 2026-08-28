local pairs = pairs

---@type ECSComponent
local ECSComponent = import("Frame.ECS.ECSComponent")
local cs_coroutine     = require "XLua.cs_coroutine"

local Object         = CS.UnityEngine.Object
local HotPointCollectionDojo = import("Game.Dojo.HotPointCollectionDojo")

local MovieFlag = "HotPointCollection.MovieFlag.%s"
---@class HotPointCollectionComponent : ECSComponent
local HotPointCollectionComponent = Class("HotPointCollectionComponent", ECSComponent)

function HotPointCollectionComponent:__init()
    ---@type HotPointCollectionDojo
    self._dojo = nil
    self._requesting  = nil
    self._texturePool = {}
    self._activityTab2Data = {}
end

function HotPointCollectionComponent:__delete()
    if isNotNull(self._co) then
        cs_coroutine.stop(self._co)
        self._co = nil
    end
    self:ReleaseTexturePool()
    self._dojo = nil
end

function HotPointCollectionComponent:Initial(closeTime, hotspotCollectionActivityUuid)
    -- self:InitDojo(checkTable(jsonData))
    

    self._isDisableLoop = false
    self._closeTime = closeTime + os.time()
    self._hotspotCollectionActivityUuid = checkNumber(hotspotCollectionActivityUuid)
    self:CheckInitialRequest()
end

function HotPointCollectionComponent:CheckInitialRequest()
    -- if not self:IsCanPlayVideo() then
    --     return
    -- end
    self:CheckRequest()
end

---CheckRequest
---@return boolean 是否正在请求
function HotPointCollectionComponent:CheckRequest()
    if not self:IsOpen() then
        return false
    end
    self:Request()
    return true
end

function HotPointCollectionComponent:Request()
    self._requesting = true
    GameUtils.Request(Interfaces.OverseaPlayerHotSpotCollection, {}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        local data = response.data
        self:InitDojo(data.hotspotCollection)
        self:SortList(self:GetActivityList())
        self:SortList(self:GetModuleList())
        self._requesting = false
        Events.Broadcast(Constants.EventNames.HomeRefreshHotPointCollectionEntranceIcon)
    end)
end

function HotPointCollectionComponent:InitDojo(jsonData)
    local dojo = self._dojo
    if dojo == nil then
        dojo = HotPointCollectionDojo.New()
        self._dojo = dojo
    end
    dojo:Fill(jsonData)


end

function HotPointCollectionComponent:IsOpen()
    return os.time() < self._closeTime
end


function HotPointCollectionComponent:IsOpenSystem()
    return GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id110004)
end

function HotPointCollectionComponent:CheckMoviePopUp(startCb, endCb)
    if not self:IsOpen() then
        return false
    end
    
    if not self:IsOpenSystem() then
        return false
    end

    if not self:IsCanPlayVideo() then
        return false
    end

    self:SaveMovieFlag()

    CfUtils.StartCoroutineWithBlocker(function() 
        local CoYield = CoYield
        while self._requesting do
            CoYield()
        end

        local dojo = self:GetDojo()
        local pvVideoPath = dojo.pvVideoPath
        
        if startCb then
            startCb()
        end
        if string.isEmpty(pvVideoPath) then
            if endCb then
                endCb()
            end
            return            
        end
        ---@type HotPointCollectionConstants
        local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
        local subEnvPath      = "Game.Activity.HotPointCollection.HotPointCollectionMoviePanel"
        local moviePrefabPath = "Prefabs/Hotpoint/HotpointMoviePanel.prefab"
        local moviePath       = string.format(HotPointCollectionConstants.PrefabPath.MoviePath, pvVideoPath)
        local design          = Vector2.New(2560, 1440)
        local animNameOut     = "HotpointMoviePanel_Out"
        local co = UICommonUtils.ShowCommonSkipButton(subEnvPath, moviePrefabPath, moviePath, design, animNameOut, endCb)
        if co then
            
            self._isPlaying = true
            self._co = CoStart(function ()
                cs_coroutine.yield_return(co)
                self._isPlaying = false
            end)
        end

    end)
    return true
end


function HotPointCollectionComponent:IsCanPlayVideo()
    local str = string.format(MovieFlag, self._hotspotCollectionActivityUuid)
    return checkNumber(CfUtils.GetLocalData(str, 0)) == 0
end
function HotPointCollectionComponent:SaveMovieFlag()
    local str = string.format(MovieFlag, self._hotspotCollectionActivityUuid)
    return CfUtils.WriteLocalData(str, 1)
end

function HotPointCollectionComponent:SortList(t)
    if next(t) == nil then
        return
    end
    
    local time = os.time()
    local GetPriority = function(data)
        local startTime = data.startTime
        local endTime   = data.endTime
        if time < startTime then
            return 2
        end
        if time >= endTime then
            return 1
        end
        
        return 3
    end
    -- local GetLeftTime = function(data)
    --     local startTime = data.startTime
    --     local endTime   = data.endTime
    --     return endTime - startTime
    -- end

    table.sort(t, function (a, b)
        local aP, bP = GetPriority(a), GetPriority(b)
        if aP == bP then
            return checkNumber(a.tab) < checkNumber(b.tab)
        end
        return aP > bP
    end)
end

--region get/set 

---GetDojo
---@return HotPointCollectionDojo
function HotPointCollectionComponent:GetDojo()
    return self._dojo
end

function HotPointCollectionComponent:GetActivityList()
    return self:GetDojo().activityList
end


function HotPointCollectionComponent:GetModuleList()
    return self:GetDojo().moduleList
end

function HotPointCollectionComponent:GetCardInfo()
    return self:GetDojo().cardInfo
end

function HotPointCollectionComponent:GetSkinInfo()
    return self:GetDojo().skinInfo
end

function HotPointCollectionComponent:GetTabId2Data()
    return self:GetDojo().tabId2Data
end

function HotPointCollectionComponent:GetRequesting()
    return self._requesting
end

function HotPointCollectionComponent:SetIsDisableLoop(isDisable)
    self._isDisableLoop = isDisable
end
function HotPointCollectionComponent:GetIsDisableLoop()
    return self._isDisableLoop
end

function HotPointCollectionComponent:GetIsPlaying()
    return self._isPlaying
end

---GetAssociationActivityListByIds
---获取关联活动列表
function HotPointCollectionComponent:GetAssociationActivityListByIds(associationIds)
    associationIds  = checkTable(associationIds)
    local tabIdData = self:GetTabId2Data()
    local t = {}
    for index, tabId in pairs(associationIds) do
        local data = tabIdData[checkNumber(tabId)]
        if tabIdData[checkNumber(tabId)] then
            table.insert(t, data)
        end
        
    end

    return t

end


function HotPointCollectionComponent:GetTexturePool()
    return self._texturePool
end
function HotPointCollectionComponent:ReleaseTexturePool()
    for key, value in pairs(self._texturePool) do
        if isNotNull(value) then
            Object.Destroy(value)
        end
    end
    self._texturePool = {}
    
end

---endregion 

return HotPointCollectionComponent