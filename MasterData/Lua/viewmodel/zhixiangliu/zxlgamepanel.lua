require("ViewModel/ZhiXiangLiu/ViewItem/ZXLShape")
require("ViewModel/ZhiXiangLiu/ViewItem/ZXLStarRewardItem")
require("ViewModel/ZhiXiangLiu/Data/ZXLConst")
local objs = {
    gridCell = {path = "template/GridCell", type = UITool.GameObject},
    cellParent = {path = "template/CellParent", type = UITool.GameObject},
    pauseBtn = {path = "root/Middle/PauseBtn", type = UITool.Button},
    continueFlag = {path = "root/Middle/PauseBtn/ContinueFlag", type = UITool.GameObject},
    pauseFlag = {path = "root/Middle/PauseBtn/PauseFlag", type = UITool.GameObject},
    resetBtn = {path = "root/Middle/ResetBtn", type = UITool.Button},
    tipsBtn = {path = "root/Middle/TipsBtn", type = UITool.Button},
    tipsCount = {path = "root/Middle/TipsBtn/RemainCount", type = UITool.Text},
    materialScroll = {path = "root/Middle/ScrollView", type = UITool.ScrollRect},
    materialScrollRect = {path = "root/Middle/ScrollView", type = UITool.RectTransform},
    remainTime = {path = "root/Middle/RemainTime/Text", type = UITool.Text},
    materialParent = {path = "root/Middle/ScrollView/Viewport/Content", type = UITool.Transform},
    gameGridParent = {path = "root/Middle/GameParent", type = UITool.Transform},
    downTimeGroup = {path = "root/Middle/DownTimeGroup", type = UITool.GameObject},
    middleTrans = {path = "root/Middle", type = UITool.Transform},
    timeProgress = {path = "root/Middle/Slider/Fill", type = UITool.Image},
    passName = {path = "root/Middle/Title", type = UITool.Text}
}

local this = {
    cellParentSize = 144,
    gridCellSize = ZXLConst.SmallGridSize,
    viewportCount = 4,
    perframeSecond = 1 / 30,

    viewportItems = nil,

    noneViewportItems = nil,

    mapCellCache = {},

    mapCells = {},

    mapCellDic = {},

    rewardItems = {},

    lastOperateShapeData = nil,

    sparkleSmallCells = nil
}

this.before_awake = function()

    this.uiCamera = LuaMgr.UICamera()
end

this.before_active = function()
    this.passName.text = this.name
    this.StartGameBefore()
end



this.StartGameBefore = function()
    this.lastOperateShapeData = nil
    this.vmBehaviour:UpdateTopBar("", this.OnPauseGame)
    this.CancelSparkle()
    this.RecycleAllMatItem()
    this.passData = ZXLGameData.GetPassData(this.passID)
    this.LoadGridMap()
    this.RefreshMaterial()
    ZXLGameData.SetGameStatus(ZXLConst.GameStatus.BeforeStart, this.passID)
    ZXLGameData.SetRemainTime(this.passData.Limittimes)
    this.startGameTime = ZXLConst.StartGameDelayTime
    LuaMgr.RemoveTimer(TimerConst.ZXLStartGameDelay)
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
    this.SetRemainTimeText(this.passData.Limittimes)
    this.RefreshReward()
    SetActive(this.downTimeGroup, true)
    LuaMgr.AddTimer(TimerConst.ZXLStartGameDelay, this.StartGameTimer, 1, -1, false)
    this.SetRemainTipsCount()
end

this.StartGameTimer = function()
    this.startGameTime = this.startGameTime - 1
    if this.startGameTime <= 0 then
        SetActive(this.downTimeGroup, false)
        LuaMgr.RemoveTimer(TimerConst.ZXLStartGameDelay)
        this.OnGameStart()
    end
end

this.OnGameStart = function()
    this.SetPauseBtnStatus(false)
    ZXLGameData.SetGameStatus(ZXLConst.GameStatus.Gaming)
    local remainTime = ZXLGameData.GetRemainTime()
    this.remainTimeFrame = remainTime
    this.maxDownTime = this.passData.Limittimes
    LuaMgr.AddTimer(TimerConst.ZXLTotaTimeDelay, this.GameDownTimerSecond, 1, -1, true)
    LuaMgr.AddTimer(TimerConst.ZXLTotaTimeDelayFrame, this.GameDownTimeFrame, this.perframeSecond, -1, false)
end

this.GameDownTimerSecond = function()
    local remainTime = ZXLGameData.GetRemainTime()
    remainTime = remainTime - 1
    this.SetRemainTimeText(remainTime)
    ZXLGameData.SetRemainTime(remainTime)
    this.RefreshReward()
    if remainTime <= 0 then
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
        local gameResult = this.CheckGameResult()
        this.OnGameOver(gameResult)
    end
end

this.GameDownTimeFrame = function()
    this.remainTimeFrame = this.remainTimeFrame - this.perframeSecond
    this.timeProgress.fillAmount = this.remainTimeFrame / this.maxDownTime
    if this.remainTimeFrame <= 0 then
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
    end
end

this.SetRemainTimeText = function(remainTime)
    local hour, minute, seconds = GetTimeHMS(remainTime)
    this.remainTime.text = string.format("%s:%s", minute, seconds)
end

this.OnPauseGame = function()
    if ZXLGameData.GetGameStatus() ~= ZXLConst.GameStatus.Gaming then
        return
    end
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
    ZXLGameData.SetGameStatus(ZXLConst.GameStatus.Pause)
    this.OnClickBack()
    this.SetPauseBtnStatus(true)
end

this.SetPauseBtnStatus = function(isPause)
    SetActive(this.continueFlag, isPause == true)
    SetActive(this.pauseFlag, isPause == false)
end

this.OnClickResetBtn = function()
    if this.lastOperateShapeData == nil then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29406")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.MatchGridFaild(this.lastOperateShapeData)
    this.lastOperateShapeData = nil
end
this.OnClickTipsBtn = function()
    local useTipItem = ZXLGameData.UseTipItem()
    if useTipItem == true then

        local tipsShapeItem = nil
        for i = 1, #this.scrollItems do
            local scrollItem = this.scrollItems[i]
            if scrollItem:IsPlaceSucc() == false then
                tipsShapeItem = scrollItem
                break
            end
        end
        if tipsShapeItem ~= nil then
            local allSmallItems = tipsShapeItem:GetSmallCells()
            this.sparkleSmallCells = {}
            for i = 1, #allSmallItems do
                local smallItems = allSmallItems[i]
                local mapCell = this.mapCellDic[smallItems:GetOccupy()]
                if mapCell ~= nil then
                    mapCell:SetGridIcon(tipsShapeItem:GetIconID())
                    mapCell:SetIsSparkle(true)
                    table.insert(this.sparkleSmallCells, mapCell)
                end
            end
            this.SetRemainTipsCount()
        end
    else
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29405")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
    end
end

this.SetRemainTipsCount = function()
    local remainTipFuncCount = ZXLGameData.GetTipsItemCount()
    this.tipsCount.text = tostring(remainTipFuncCount)
end

this.ContinueGame = function()
    this.OnGameStart()
end

this.CancelSparkle = function()
    if this.sparkleSmallCells == nil then
        return
    end
    for key, value in pairs(this.sparkleSmallCells) do
        value:SetIsSparkle(false)
        value:ResetGrid()
    end
    this.sparkleSmallCells = nil
end

this.CheckGameResult = function()
    local res = ZXLConst.GameResult.Success
    for key, value in pairs(this.scrollItems) do
        if value:IsPlaceSucc() == false then
            res = ZXLConst.GameResult.Fail
            return res
        end
    end
    return res
end



this.OnGameOver = function(res)
    this.CancelSparkle()
    ZXLGameData.SetGameStatus(ZXLConst.GameStatus.None)
    local data = {}
    data.passData = this.passData
    data.gameRes = res or ZXLConst.GameResult.Fail
    data.name = this.name
    data.remainTime = ZXLGameData.GetRemainTime()
    data.star = ZXLGameData.GetStar()
    data.onExistCallback = function()
        ZXLGameData.SetGameStatus(ZXLConst.GameStatus.None)
        this.vmBehaviour:UpdateTopBar("", nil)
        LuaMgr.Back()
    end
    data.onReplayCallback = function()
        this.StartGameBefore()
    end
    LuaMgr.RemoveTimer(TimerConst.ZXLStartGameDelay)
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
    LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
    this.vmBehaviour:UpdateTopBar("", nil)
    LuaMgr.ShowLuaPanel(UIName.ZXLGameResPopup, data)
end

this.LoadGridMap = function()
    this.RecycleAllMapCell()
    local offsetX = -300 + 2.8
    local offsetY = 221

    for j = 1, #this.passData.MapGroup do
        local materialData = this.passData.MapGroup[j]
        for i = 1, #materialData.orginOccupy do
            local gridCell = this.GetMapCellByCache()
            local data = {}
            local occupy = materialData.orginOccupy[i]
            data.valid = true
            data.materialID = materialData.ID
            data.icon = materialData.config.Icon
            data.occupy = occupy
            local gridPos = materialData.orginPosDatas[i]
            if (gridPos.X % 2 == 0 and gridPos.Y % 2 == 0) or (gridPos.X % 2 ~= 0 and gridPos.Y % 2 ~= 0) then
                data.darkType = 1
            else
                data.darkType = 2
            end
            local posX = this.gridCellSize + (gridPos.X - 1) * this.gridCellSize + offsetX
            local posY = -(gridPos.Y - 1) * this.gridCellSize + offsetY
            data.position = Vector3(posX, posY, 0)
            gridCell:SetData(data)
            table.insert(this.mapCells, #this.mapCells + 1, gridCell)
            this.mapCellDic[occupy] = gridCell
        end
    end

    for i = 1, this.passData.MaxCol do
        for j = 1, this.passData.MaxRow do
            local key = string.format("%d_%d", i, j)
            if this.passData.Map[key] == nil then
                local gridCell = this.GetMapCellByCache()
                local data = {}
                data.valid = false
                if (i % 2 == 0 and j % 2 == 0) or (i % 2 ~= 0 and j % 2 ~= 0) then
                    data.darkType = 1
                else
                    data.darkType = 2
                end
                local gridPos = GridPosition.New(i, j)
                local posX = this.gridCellSize + (gridPos.X - 1) * this.gridCellSize + offsetX
                local posY = -(gridPos.Y - 1) * this.gridCellSize + offsetY
                data.position = Vector3(posX, posY, 0)
                gridCell:SetData(data)
                table.insert(this.mapCells, #this.mapCells + 1, gridCell)
            end
        end
    end
end

this.GetMapCellByCache = function()
    local cell = table.remove(this.mapCellCache, 1)
    if cell == nil then
        cell = ZXLBaseShape.New(this.gridCell, this.gameGridParent, false)
    end
    SetActive(cell.gameObject, true)
    return cell
end

this.RecycleAllMapCell = function()
    for key, cell in pairs(this.mapCells) do
        SetActive(cell.gameObject, false)
        table.insert(this.mapCellCache, #this.mapCellCache + 1, cell)
    end
end

this.RecycleAllMatItem = function()
    if this.scrollItems == nil then
        return
    end
    for key, value in pairs(this.scrollItems) do
        value:Clear()
    end
    this.scrollItems = nil
end

this.RefreshReward = function()
    local remainTime = ZXLGameData.GetRemainTime()
    local restTime = this.passData.config.RestTime
    local curStar = 3
    for i = #restTime, 1, -1 do
        local time = tonumber(restTime[i])
        if remainTime <= time then
            curStar = 3 - i
            break
        end
    end
    ZXLGameData.SetStar(curStar)
    for i = 1, #this.rewardItems do
        local rewardItem = this.rewardItems[i]
        local data = {}
        data.reward = this.passData.Reward[i]
        data.isLight = curStar >= i
        local serverStar = ZXLData.GetMiniGameData(this.passID) or 0
        data.status = serverStar >= i and CommonRewardItem.Status.Got or CommonRewardItem.Status.None
        data.time = restTime[i - 1] or 0
        rewardItem:SetData(data)
    end
end





this.OnGamePointerDown = function(params)
    if params.Length < 1 then
        LuaDebug.error("OnGamePointerDown参数错误")
        return
    end
    local data = params[0]

    local shapeData = data.shapeData
    if this.IsScrollViewOutside(data.screenPos) then
        shapeData:SetSmallItem(true, this.gameGridParent)
        shapeData:OnDragStartHandle(data.eventData, data.screenPos)
        shapeData:SetAsLastSibling()
        shapeData.isDraging = true
        shapeData:SetIsPlace(false)
        this.lastOperateShapeData = nil
    end
end

this.OnGameGragBegin = function(params)
    if params.Length < 1 then
        LuaDebug.error("OnGameGragBegin参数错误")
        return
    end
    local data = params[0]

    local shapeData = data.shapeData
    this.beginDragScreenPos = data.screenPos
    if this.IsScrollViewOutside(data.screenPos) or shapeData.isDraging == true then
    else
        this.materialScroll:OnBeginDrag(data.eventData)
    end
end

this.OnGameGrag = function(params)
    if params.Length < 1 then
        LuaDebug.error("OnGameGrag参数错误")
        return
    end
    local data = params[0]
    local screenPos = data.screenPos

    local shapeData = data.shapeData
    if this.beginDragScreenPos ~= nil and this.IsScrollViewOutside(screenPos) then
        shapeData:SetSmallItem(true, this.gameGridParent)
        shapeData:OnDragStartHandle(data.eventData, screenPos)
        shapeData.isDraging = true
    end
    if shapeData.isDraging == true then
        shapeData:OnDragHandle(data.eventData, screenPos)
        this.materialScroll:OnEndDrag(data.eventData)
        this.CancelSparkle()
        if this.IsGameParentInside(screenPos) then
            if this.allMatchSuccGrids ~= nil then
                for i = 1, #this.allMatchSuccGrids do
                    local smallCell = this.allMatchSuccGrids[i]
                    smallCell:ResetGrid()
                end
                this.allMatchSuccGrids = nil
            end
            local allMatchSuccGrids = this.GetMatchGridCells(shapeData)
            if #allMatchSuccGrids > 0 then
                this.allMatchSuccGrids = allMatchSuccGrids
                for i = 1, #this.allMatchSuccGrids do
                    local smallCell = this.allMatchSuccGrids[i]
                    smallCell:SetGridIcon(shapeData:GetIconID())
                end
            end
        end
    else
        this.materialScroll:OnDrag(data.eventData)
    end
end

this.OnGameGragEnd = function(params)
    if params.Length < 1 then
        LuaDebug.error("OnGameGragEnd参数错误")
        return
    end
    local data = params[0]

    local shapeData = data.shapeData
    if shapeData.isDraging == true then
        shapeData:SetSmallItem(true, this.gameGridParent)
        shapeData.isDraging = false
        shapeData:OnDragEndHandle(data.eventData, data.screenPos)
        return
    end
    if this.IsScrollViewOutside(data.screenPos) or shapeData.isDraging == true then
    else
        this.materialScroll:OnEndDrag(data.eventData)
    end
end

this.OnGamePointerUp = function(params)
    if params.Length < 1 then
        LuaDebug.error("OnGamePointerUp参数错误")
        return
    end
    local data = params[0]

    local shapeData = data.shapeData
    local screenPos = data.screenPos
    if this.IsScrollViewOutside(screenPos) or shapeData.isDraging == true then
        shapeData.isDraging = false
        if this.IsGameParentInside(screenPos) then
            local allMatchSuccGrids, offsetX, offsetY = this.GetMatchGridCells(shapeData)
            if #allMatchSuccGrids == #shapeData:GetSmallCells() then
                this.MatchGridSuccess(shapeData, allMatchSuccGrids, offsetX, offsetY)
                this.lastOperateShapeData = shapeData
            else
                this.MatchGridFaild(shapeData)
            end
        else
            this.MatchGridFaild(shapeData)
        end
        if this.allMatchSuccGrids then
            for i = 1, #this.allMatchSuccGrids do
                local smallCell = this.allMatchSuccGrids[i]
                smallCell:ResetGrid()
            end
            this.allMatchSuccGrids = nil
        end
    else
        this.materialScroll:OnEndDrag(data.eventData)
    end
end



this.GetMatchGridCells = function(dragShape)
    local dragSmallCells = dragShape:GetSmallCells()

    local allNearestCells = {}

    local allNearestCellDic = {}
    local offsetX, offsetY = 0, 0
    for key, smallCell in pairs(dragSmallCells) do
        local worldPos = smallCell:GetWorldPosition()
        local gameGridParentLocalPos = this.gameGridParent:InverseTransformPoint(worldPos)
        local nearestDis = 100000000

        local nearestDisCell = nil
        for i = 1, #this.mapCells do
            local gridCell = this.mapCells[i]
            if gridCell:IsValid() then
                local gridCellPos = gridCell:GetLocalPosition()
                local distance = Vector2.Distance(gridCellPos, Vector2(gameGridParentLocalPos.x, gameGridParentLocalPos.y))
                if distance < nearestDis then
                    offsetX = gridCellPos.x - gameGridParentLocalPos.x
                    offsetY = gridCellPos.y - gameGridParentLocalPos.y
                    nearestDis = distance
                    nearestDisCell = gridCell
                end
            end
        end
        if nearestDisCell ~= nil and nearestDis < this.gridCellSize then
            allNearestCellDic[nearestDisCell:GetOccupy()] = nearestDisCell
        end
    end
    for key, value in pairs(allNearestCellDic) do
        if value:IsBePlace() == false then
            table.insert(allNearestCells, value)
        end
    end
    return allNearestCells, offsetX, offsetY
end


this.MatchGridSuccess = function(dragShape, allMatchSuccGrids, offsetX, offsetY)
    local func = function()
        if this.CheckGameResult() == ZXLConst.GameResult.Success then
            this.OnGameOver(ZXLConst.GameResult.Success)
        end
    end
    local data = {}
    data.offsetX = offsetX
    data.offsetY = offsetY
    data.callback = func
    data.allMatchSuccGrids = allMatchSuccGrids
    dragShape:SetIsPlace(true, data)
end


this.MatchGridFaild = function(dragShape)
    dragShape:SetSmallItem(false, this.materialParent)
    dragShape:SetSiblingIndex()
    dragShape:SetIsPlace(false)
end

this.IsScrollViewOutside = function(screenPos)
    if not this.middleTrans or not this.materialScrollRect or not screenPos then
        return false
    end
    local localScreenPos = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y), this.middleTrans)
    local scrollLocalPosX = this.materialScrollRect.localPosition.x
    local scrollLocalPosY = this.materialScrollRect.localPosition.y
    local scrollSizeDeltaX = this.materialScrollRect.sizeDelta.x
    local scrollSizeDeltaY = this.materialScrollRect.sizeDelta.y
    local leftBound = scrollLocalPosX - scrollSizeDeltaX / 2
    local rightBound = scrollLocalPosX + scrollSizeDeltaX / 2
    local bottomBound = scrollLocalPosY - scrollSizeDeltaY / 2
    local topBound = scrollLocalPosY + scrollSizeDeltaY / 2

    local isOutside = false
    if localScreenPos.x < leftBound or localScreenPos.y < bottomBound then
        isOutside = true
    end
    if localScreenPos.x > rightBound or localScreenPos.y > topBound then
        isOutside = true
    end
    return isOutside
end

this.IsGameParentInside = function(screenPos)
    local localScreenPos = LuaMgr.Screen2Local(Vector2(screenPos.x, screenPos.y), this.middleTrans)
    local gridParentLocalPosX = this.gameGridParent.localPosition.x
    local gridParentLocalPosY = this.gameGridParent.localPosition.y
    local gridParentSizeDeltaX = this.gameGridParent.sizeDelta.x
    local gridParentSizeDeltaY = this.gameGridParent.sizeDelta.y
    local leftBound = gridParentLocalPosX - gridParentSizeDeltaX / 2
    local rightBound = gridParentLocalPosX + gridParentSizeDeltaX / 2
    local bottomBound = gridParentLocalPosY - gridParentSizeDeltaY / 2
    local topBound = gridParentLocalPosY + gridParentSizeDeltaY / 2
    local isInsideX, isInsideY = true, true
    if localScreenPos.x < leftBound or localScreenPos.y < bottomBound then
        isInsideX = false
    end
    if localScreenPos.x > rightBound or localScreenPos.y > topBound then
        isInsideY = false
    end

    return isInsideX and isInsideY
end



this.RefreshMaterial = function()
    if this.remainItemDatas == nil or #this.remainItemDatas == 0 then
        this.remainItemDatas = {}
        local configDatas = this.passData.MapGroup
        for i = 1, #configDatas do
            local data = {}
            data.index = i
            data.configData = configDatas[i]
            data.gridCellPrefab = this.gridCell
            data.rowCount = data.configData.rangeY.max - data.configData.rangeY.min + 1
            data.colCount = data.configData.rangeX.max - data.configData.rangeX.min + 1
            data.cellParentSize = this.cellParentSize
            data.gridCellSize = this.gridCellSize
            data.canvas = this.GetTempCanvans()
            data.camera = this.uiCamera
            this.remainItemDatas[tostring(data.configData.ID)] = data
        end
    end


    this.scrollItems = {}
    for key, data in pairs(this.remainItemDatas) do
        local item = ZXLShape.New(this.cellParent, this.materialParent)
        item:SetData(data, true)
        table.insert(this.scrollItems, item)
    end
end

this.ClearMaterialItems = function()
end


this.GetTempCanvans = function()
    if this.tempCanvas == nil then
        local canvansObj = GameObject("TempCanvas")
        local uiRoot = CS.Laigu.Manager.UIManager.Singleton.UIRoot
        canvansObj.transform:SetParent(uiRoot.transform)


        canvansObj.transform.localPosition = UnityEngine.Vector3.zero
        canvansObj.transform.localScale = UnityEngine.Vector3.one
        canvansObj.transform.localEulerAngles = UnityEngine.Vector3.zero

        local cavansType = typeof(UnityEngine.Canvas)
        local canvas = canvansObj:AddComponent(cavansType)
        canvas.renderMode = UnityEngine.RenderMode.ScreenSpaceCamera
        canvas.worldCamera = this.uiCamera
        local mainCanvas = this.vmBehaviour.gameObject:GetComponentInParent(cavansType)
        canvas.planeDistance = mainCanvas.planeDistance
        canvas.scaleFactor = mainCanvas.scaleFactor
        canvas.pixelPerfect = false
        canvas.overrideSorting = true
        canvas.sortingOrder = 9999
        canvas.enabled = false
        this.tempCanvas = canvas
    end
    return this.tempCanvas
end



this.BatchInitNode = function()
    for i = 1, 4 do
        local data = {}
        data.path = "root/Middle/DownTimeGroup/DownTime" .. i
        data.type = UITool.GameObject
        local cellName = "StartDownTime" .. i
        objs[cellName] = data
    end

    for i = 1, 3 do
        local data = {}
        data.path = "root/Middle/Slider/RewardItem" .. i
        data.type = UITool.GameObject
        local cellName = "RewardItem" .. i
        objs[cellName] = data
    end
end

this.BatchInitNodeItem = function()
    for i = 1, 3 do
        local cellName = "RewardItem" .. i
        local item = ZXLStarRewardItem.New(this[cellName])
        table.insert(this.rewardItems, #this.rewardItems + 1, item)
    end
end

this.OnClickBack = function()
    local data = {}
    data.onExistCallback = function()
        LuaMgr.HidePanel(UIName.ZXLGamePausePopup)
        local func = function()
            this.vmBehaviour:UpdateTopBar("", nil)
            LuaMgr.Back()
        end
        ZXLGameData.SetGameStatus(ZXLConst.GameStatus.None)
        LuaMgr.NextFrame(func)
    end
    data.onReplayCallback = function()
        LuaMgr.HidePanel(UIName.ZXLGamePausePopup)
        this.StartGameBefore()
    end
    data.onContinueCallback = function()
        LuaMgr.HidePanel(UIName.ZXLGamePausePopup)
        this.ContinueGame()
    end
    LuaMgr.ShowLuaPanel(UIName.ZXLGamePausePopup, data)
end

this.before_deactive = function()
end

this.before_destroy = function()
end

local data = {}
local command = {}
local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.BatchInitNodeItem()
        LuaMgr.AddClick(this.pauseBtn, this.OnPauseGame)
        LuaMgr.AddClick(this.resetBtn, this.OnClickResetBtn)
        LuaMgr.AddClick(this.tipsBtn, this.OnClickTipsBtn)
        LuaMgr.AddUIEventListener(UIEventConst.ZXLGamePointerDown, this.OnGamePointerDown)
        LuaMgr.AddUIEventListener(UIEventConst.ZXLGameDragBegin, this.OnGameGragBegin)
        LuaMgr.AddUIEventListener(UIEventConst.ZXLGameDrag, this.OnGameGrag)
        LuaMgr.AddUIEventListener(UIEventConst.ZXLGameDragEnd, this.OnGameGragEnd)
        LuaMgr.AddUIEventListener(UIEventConst.ZXLGamePointerUp, this.OnGamePointerUp)
        this.before_awake()
    end,
    before_active = function(vm)
        this.vmBehaviour = vm.behaviour
        if (vm.behaviour.Params == nil) then
            return
        end
        this.passID = this.vmBehaviour.Params[0].passID
        this.name = this.vmBehaviour.Params[0].name
        this.before_active()
    end,
    before_deactive = function(vm)
        this.before_deactive()
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
        this.RecycleAllMatItem()
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveTimer(TimerConst.ZXLStartGameDelay)
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelay)
        LuaMgr.RemoveTimer(TimerConst.ZXLTotaTimeDelayFrame)
        LuaMgr.RemoveClick(this.pauseBtn, this.OnPauseGame)
        LuaMgr.RemoveClick(this.resetBtn, this.OnClickResetBtn)
        LuaMgr.RemoveClick(this.tipsBtn, this.OnClickTipsBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZXLGamePointerDown, this.OnGamePointerDown)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZXLGameDragBegin, this.OnGameGragBegin)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZXLGameDrag, this.OnGameGrag)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZXLGameDragEnd, this.OnGameGragEnd)
        LuaMgr.RemoveUIEventListener(UIEventConst.ZXLGamePointerUp, this.OnGamePointerUp)
        this.before_destroy()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)