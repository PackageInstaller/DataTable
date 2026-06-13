local LotteryTimelinePlayer = BaseClass("LotteryTimelinePlayer")
local M = LotteryTimelinePlayer
local tInsert = table.insert
local tRemove = table.remove

function M:__init(view)
    self._view = view
    self._processCallback = nil
    self._timelineUnit = nil
    self._raylightPool = {}
    self._curRayLights = {}
    self._curCraftLight = {}
    self._showPointArr = {}
    self._showedPoints = {}
    self._showPointNum = 0
    self._heroLen = 0
    self._isRay = false
    self._pauseTime = 0
    self._pauseCallback = nil
    self._view.rayLight:SetActive(false)
    self._view.craftLight:SetActive(false)
end

-----播放抽卡timeline
-----msg 协方式
-----pauseTime 到达此时间时暂停
-----pauseCall 到达此时间时回调
-----finishCallback完全播放完成之后回调
-----
function M:Play1ResultTimeline(heros, startFrame, pauseTime, pauseCallback, finshCallback, dragFinishCallback)
    -- local p = "Timeline/Prefab/CutScene/chouka"
    self._pauseTime = pauseTime
    self._pauseCallback = pauseCallback
    self._dragFinish = dragFinishCallback
    self._isRay = false
    local view = self._view
    local startTime = 0
    if startFrame > 0 then
        startTime = startFrame / CS.UnityEngine.Application.targetFrameRate
    end
    local onPlayComplete = function(finish)
        --播放结束
        --self._timelineUnit.brain:SetActive(false)
        GameHelper.SetTimeLineCameraByIndex(self._timelineUnit, false)
        if finshCallback ~= nil then
            finshCallback(heros, finish)
        end
        self._timelineUnit = nil
        for i, v in ipairs(self._curRayLights) do
            tInsert(self._raylightPool, v)
            v:SetActive(false)
        end
        self._curRayLights = {}
    end
    if PlayerPrefabHelper.GetBool("SkipLotteryTimeLine", true) then
        onPlayComplete()
    else
        self._timelineUnit = GameHelper.PlayTimelineObjByCallBack_Sign(view.gameObject, onPlayComplete, false, startTime)
    end
    local maxPoint = 20
    local heroLen = #heros
    self._heroLen = heroLen
    local heroDatas = heros
    self._showPointNum = 0
    local pointNos = self:_Random(heroLen, maxPoint)
    self._showPointArr = {}
    self._showedPoints = {}
    for i, v in ipairs(pointNos) do
        local showPoint = view["point" .. v].position
        local quality = ConfigHelper.GetCfg("hero", heroDatas[i].ObjId).rare --Quality:GetHashCode()
        tInsert(self._showPointArr, { id = i, pos = showPoint, quality = quality })
    end
    local rayLightTemplate = view.rayLight
    rayLightTemplate.gameObject:SetActive(false)
    view.craftLight:SetActive(false)
    -- view.dragSlider.gameObject:SetActive(false)
    if startFrame == 0 and pauseTime > 0 then
        view.dragSlider.touchDrag = Bind(self, self._OnDrag)
        view.dragSlider:SetAvalibale(false)
        --运行过程中调用
        GameHelper.SetTimeLineProcessActionByIndex(self._timelineUnit, Bind(self, self._OnTimelineProgress))
        --self._timelineUnit.processAction = Bind(self,self._OnTimelineProgress)
    else
        self:_OnDrag(1)
        view.dragSlider.touchDrag = nil
        GameHelper.SetTimeLineProcessActionByIndex(self._timelineUnit, nil)
        -- self._timelineUnit.processAction = nil
    end
end

function M:_OnTimelineProgress(time, totalTime)
    --到达指定时间，则暂停
    if self._pauseTime > 0 and time >= self._pauseTime then
        -- self._view.dragSlider.gameObject:SetActive(true)
        self._view.dragSlider:SetAvalibale(true)
        GameHelper.SetTimeLineProcessActionByIndex(self._timelineUnit, nil)
        --self._timelineUnit.processAction = nil
        GameHelper.PauseTimeLineByIndex(self._timelineUnit)
        --self._timelineUnit:Pause()
        if self._pauseCallback then
            self._pauseCallback()
        end
    end
end

function M:_OnDrag(progress)
    -- print("drag progress :" ..progress)

    --操作恢复
    if not self._isRay then
        local len = #self._showPointArr
        for i = 1, len do
            local showPoint = self._showPointArr[i].pos
            local quality = self._showPointArr[i].quality
            local id = self._showPointArr[i].id
            if not self._showedPoints[id] then
                if self._view.dragSlider:CheckPassPoint(showPoint.x, showPoint.y, showPoint.z) then
                    local rayLight = self:TryRayLight(quality)
                    rayLight.transform:SetPosBy3float(showPoint.x, showPoint.y, showPoint.z)
                    rayLight.gameObject:SetActive(true)
                    self._showPointNum = self._showPointNum + 1
                    if #self._showPointArr == self._showPointNum then
                        self._isRay = true
                    end
                    self._showedPoints[id] = true
                    -- break
                end
            end
        end
    end
    if progress >= 1 then
        self._view.dragSlider:SetAvalibale(false)
        if self._dragFinish then
            self._dragFinish()
        end
        self._dragFinish = nil
        GameHelper.ResumeTimeLineByIndex(self._timelineUnit)
        -- self._timelineUnit:Resume()
        for pos = 1, #self._showPointArr do
            local quality = self._showPointArr[pos].quality
            if self._curCraftLight[pos] == nil then
                self._curCraftLight[pos] = self._view.craftLight:Instantiate()
                self._curCraftLight[pos]:SetActive(true)
                self._curCraftLight[pos].transform:SetParent(self._view["craft" .. pos])
                self._curCraftLight[pos].transform:Reset()
            end
            for q = 1, 4 do
                if self._curCraftLight[pos]["quality" .. q] then
                    self._curCraftLight[pos]["quality" .. q]:SetActive(q == quality)
                end
            end
        end
    end
end

function M:_Random(num, maxNum)
    local numArr = {}
    for i = 1, maxNum do
        tInsert(numArr, i)
    end
    local randomArr = {}
    for i = 1, num do
        local idx = math.random(1, #numArr)
        tInsert(randomArr, numArr[idx])
        tRemove(numArr, idx)
    end
    return randomArr
end

function M:Play10ResultTimeline(heros, startFrame, pauseTime, pauseCallback, finshCallback)
    self:Play1ResultTimeline(heros, startFrame, pauseTime, pauseCallback, finshCallback)
end

function M:TryRayLight(quality)
    local rayLight = nil
    if #self._raylightPool > 0 then
        rayLight = self._raylightPool[1]
        tRemove(self._raylightPool, 1)
        rayLight:SetActive(true)
    else
        rayLight = self._view.rayLight:Instantiate()
    end
    tInsert(self._curRayLights, rayLight)
    for i = 1, 4 do
        rayLight["quality" .. i]:SetActive(i == quality)
    end
    return rayLight
end

function M:SetActive(v)
    if self._view ~= nil then
        self._view:SetActive(v)
    end
end

function M:Dispose()
    self._dragFinish = nil
    self._pauseCallback = nil
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LotteryTimelinePlayer
