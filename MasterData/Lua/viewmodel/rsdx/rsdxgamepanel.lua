require("ViewModel/RSDX/ViewItem/RSDXElementItem")
require("ViewModel/RSDX/ViewItem/RSDXGameSelectItem")
local objs = {
    elementItem = {path = "template/ElementItem", type = UITool.GameObject},
    elementSelectItem = {path = "template/SelectElement", type = UITool.GameObject},
    rewardItem = {path = "template/ItemParent", type = UITool.GameObject},
    elementParent = {path = "root/Middle/ElementParent", type = UITool.Transform},
    selectElementGroup = {path = "root/Middle/ChooseElementGroup", type = UITool.Transform},
    jumpBtn = {path = "root/Middle/ButtonGroup/SkipBtn", type = UITool.Button},
    resetBtn = {path = "root/Middle/ButtonGroup/ResetBtn", type = UITool.Button},
    remainStepText = {path = "root/Middle/RemainStep", type = UITool.Text},
    rewardParent = {path = "root/Middle/RewardGroup/RewardParent", type = UITool.Transform},
    curSelectTipsTrans = {path = "root/Middle/ChooseElementGroup/CurSelect", type = UITool.Transform},
    tipsText = {path = "root/Middle/Tips", type = UITool.Text},
    animator = {path = "root", type = UITool.Animator}
}

local this = {

    elementItems = {},

    elementItemsDic = {},

    elementItemPool = {},

    elementSelectItems = {},

    elementSelectItemPool = {},

    rewardItems = {},

    rewardItemPool = {},
    remainStep = 0,
    gameUseTimeSec = 0
}

this.before_awake = function()
end

this.before_active = function()
    this.Recycle()
    this.gameUseTimeSec = 0
    SetActive(this.jumpBtn.gameObject, false)
    LuaMgr.RemoveTimer(TimerConst.RSDXGameSkipTimer)
    LuaMgr.AddTimer(TimerConst.RSDXGameSkipTimer, this.OnClickJumpBtnTimer, 1, -1, false)
    this.selectElementID = nil
    this.InitElementGrid()
    this.InitSelectElement()
    this.RefreshReward()
    this.RefreshUI()
end

this.RefreshUI = function()
    this.remainStepText.text = tostring(this.remainStep)
    this.tipsText.text = LuaMgr.GetLangText(this.curPassData.ConditionsDescLan)
end


this.InitElementGrid = function()
    local curPassData = RSDXMgr.GetCurPassData(this.curPassID)
    this.remainStep = curPassData.Cost

    local gridDatas = curPassData.GridDatas
    this.curPassData = curPassData
    for i = 1, #gridDatas do
        local gridData = gridDatas[i]
        local elementItem = this.GetElementItem()
        SetActive(elementItem.gameObject, false)
        gridData.OnClickElementItem = this.OnClickElementItem
        elementItem:SetData(gridData)
        elementItem:RefreshElementData(gridData.OrigeonElementID, true)
        this.SetElementItemPos(elementItem, gridData.GridPos)
        table.insert(this.elementItems, elementItem)
        this.elementItemsDic[gridData.GridPosKey] = elementItem
    end
    if this.initElementCor ~= nil then
        coroutine_runner.stop(this.initElementCor)
        this.initElementCor = nil
    end
    this.isInitComplete = false
    this.initElementCor = coroutine_runner.start(this.InitElementCor)
end

this.InitElementCor = function()
    local centerPos = GridPosition.New(1, 1)
    local centerKey = centerPos:ToString()
    local eliminateCircleDatas = {}
    local curLevelRow = this.curPassData.MaxRow
    local curLevelCol = this.curPassData.MaxCol
    local maxRadius = math.max(curLevelCol, curLevelRow)
    eliminateCircleDatas[1] = {centerKey}
    for i = 1, maxRadius do
        eliminateCircleDatas[i + 1] = {}

        for x = -i, i do
            local newX = centerPos.X + x
            local newY = centerPos.Y - i
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(x, -i)
                local key = gridPos:ToString()
                table.insert(eliminateCircleDatas[i + 1], key)
            end
        end

        for y = -i + 1, i - 1 do
            local newX = centerPos.X + i
            local newY = centerPos.Y + y
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(i, y)
                local key = gridPos:ToString()
                table.insert(eliminateCircleDatas[i + 1], key)
            end
        end

        for x = -i, i do
            local newX = centerPos.X + x
            local newY = centerPos.Y + i
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(x, i)
                local key = gridPos:ToString()
                table.insert(eliminateCircleDatas[i + 1], key)
            end
        end

        for y = -i + 1, i - 1 do
            local newX = centerPos.X - i
            local newY = centerPos.Y + y
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(-i, y)
                local key = gridPos:ToString()
                table.insert(eliminateCircleDatas[i + 1], key)
            end
        end
    end

    for i = 1, maxRadius do
        local eliminateCircleData = eliminateCircleDatas[i]
        local needDelay = false
        if eliminateCircleData ~= nil and #eliminateCircleData > 0 then
            for j = 1, #eliminateCircleData do
                local gridPosKey = eliminateCircleData[j]
                if this.elementItemsDic[gridPosKey] ~= nil then
                    needDelay = true
                    local item = this.elementItemsDic[gridPosKey]
                    SetActive(item.gameObject, true)
                end
            end
            if i < maxRadius and needDelay == true then
                coroutine_runner.wait(RSDXConst.ElementScaleAnimTime1)
            end
        end
    end
    this.isInitComplete = true
end




this.SetElementItemPos = function(elementItem, pos)
    local posX = (pos.X - 1) * elementItem.rectTrans.sizeDelta.x + (pos.X - 1) * RSDXConst.ItemGridSpace.X
    local posY = -((pos.Y - 1) * elementItem.rectTrans.sizeDelta.y + (pos.Y - 1) * RSDXConst.ItemGridSpace.Y)
    elementItem.rectTrans.anchoredPosition = Vector2(posX, posY)
end

this.GetElementItem = function()
    local elementItem = nil
    if #this.elementItemPool > 0 then
        elementItem = table.remove(this.elementItemPool)
    else
        local obj = LuaMgr.InstantiateGO(this.elementItem, this.elementParent, false)
        elementItem = RSDXElementItem.New(obj)
    end
    return elementItem
end

this.RecycleAllElementItem = function()
    for i = 1, #this.elementItems do
        local elementItem = this.elementItems[i]
        SetActive(elementItem.gameObject, false)
        table.insert(this.elementItemPool, elementItem)
    end
    this.elementItems = {}
end



this.OnClickElementItem = function(elementItem)
    if this.isEliminating == true then
        return
    end
    local gridData = elementItem.data
    if gridData == nil or this.selectElementID == nil then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31117")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.selectElementID == gridData.CurElementID then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31118")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local eliminateDataDic = RSDXMgr.GetAllEliminateDatas(this.curPassID, gridData)
    local centerPos = gridData.GridPos
    this.EliminateCircleItem(eliminateDataDic, centerPos)
end

this.EliminateCircleItem = function(eliminateDataDic, centerPos)
    local curLevelRow = this.curPassData.MaxRow
    local curLevelCol = this.curPassData.MaxCol
    local maxRadius = math.max(curLevelCol, curLevelRow)
    local eliminateCircleDatas = {}

    local centerKey = centerPos:ToString()
    eliminateCircleDatas[1] = {centerKey}
    for i = 1, maxRadius do
        eliminateCircleDatas[i + 1] = {}

        for x = -i, i do
            local newX = centerPos.X + x
            local newY = centerPos.Y - i
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(x, -i)
                local key = gridPos:ToString()
                if eliminateDataDic[key] ~= nil then
                    table.insert(eliminateCircleDatas[i + 1], key)
                end
            end
        end

        for y = -i + 1, i - 1 do
            local newX = centerPos.X + i
            local newY = centerPos.Y + y
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(i, y)
                local key = gridPos:ToString()
                if eliminateDataDic[key] ~= nil then
                    table.insert(eliminateCircleDatas[i + 1], key)
                end
            end
        end

        for x = -i, i do
            local newX = centerPos.X + x
            local newY = centerPos.Y + i
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(x, i)
                local key = gridPos:ToString()
                if eliminateDataDic[key] ~= nil then
                    table.insert(eliminateCircleDatas[i + 1], key)
                end
            end
        end

        for y = -i + 1, i - 1 do
            local newX = centerPos.X - i
            local newY = centerPos.Y + y
            if newX >= 1 and newX <= curLevelCol and newY >= 1 and newY <= curLevelRow then
                local gridPos = centerPos:AddRef(-i, y)
                local key = gridPos:ToString()
                if eliminateDataDic[key] ~= nil then
                    table.insert(eliminateCircleDatas[i + 1], key)
                end
            end
        end
    end
    this.eliminateCircleDatas = eliminateCircleDatas
    if this.eliminateCor ~= nil then
        coroutine_runner.stop(this.eliminateCor)
    end
    this.remainStep = this.remainStep - 1
    this.RefreshUI()
    this.isEliminating = true
    this.eliminateCor = coroutine_runner.start(this.EliminateCircleAnim)
end

this.EliminateCircleAnim = function()
    local curLevelRow = this.curPassData.MaxRow
    local curLevelCol = this.curPassData.MaxCol
    local maxCount = math.max(curLevelCol, curLevelRow)
    for i = 1, maxCount do
        local eliminateCircleData = this.eliminateCircleDatas[i]
        local needDelay = false
        if eliminateCircleData ~= nil and #eliminateCircleData > 0 then
            for j = 1, #eliminateCircleData do
                local gridPosKey = eliminateCircleData[j]
                if this.elementItemsDic[gridPosKey] ~= nil then
                    needDelay = true
                    local item = this.elementItemsDic[gridPosKey]
                    item:RefreshElementData(this.selectElementID, false)
                end
            end
            if i < maxCount and needDelay == true then
                coroutine_runner.wait(RSDXConst.EliminateAnimDelay)
            end
        end
    end
    this.isEliminating = false
    this.RefreshUI()
    local isEnd, isSucc = this.CheckGameOver()
    if isSucc == true then
        this.GameSuccess()
    elseif isEnd == true then
        this.GameFail()
    end
end




this.RefreshReward = function()
    local datas = this.curPassData.Reward
    local status = CommonRewardItem.Status.None
    if RSDXMgr.CheckGameIsComplete(this.curPassData.Id) then
        status = CommonRewardItem.Status.Got
    end
    for i = 1, #datas do
        local data = table.CopyNoMeta(datas[i])
        data.status = status
        local rewardItem = this.GetRewardItem()
        SetActive(rewardItem.gameObject, true)
        rewardItem.gameObject.transform:SetAsLastSibling()
        rewardItem:SetData1(data)
        table.insert(this.rewardItems, rewardItem)
    end
end

this.GetRewardItem = function()
    local rewardItem = nil
    if #this.rewardItemPool > 0 then
        rewardItem = table.remove(this.rewardItemPool)
    else
        local obj = LuaMgr.InstantiateGO(this.rewardItem, this.rewardParent, false)
        rewardItem = CommonRewardItem.New(obj, true, 0.55)
    end
    return rewardItem
end

this.RecycleAllRewardItem = function()
    for i = 1, #this.rewardItems do
        local rewardItem = this.rewardItems[i]
        SetActive(rewardItem.gameObject, false)
        table.insert(this.rewardItemPool, rewardItem)
    end
    this.rewardItems = {}
end




this.InitSelectElement = function()
    local selectElementDatas = this.curPassData.Color
    for i = 1, #selectElementDatas do
        local elementID = selectElementDatas[i]
        local elementItem = this.GetSelectElementItem()
        SetActive(elementItem.gameObject, true)
        local data = {}
        data.ElementID = elementID
        data.OnClickElementItem = this.OnClickSelectElementItem
        elementItem:SetData(data)
        table.insert(this.elementSelectItems, elementItem)
    end
    this.RefreshCurSelectElementItem()
end

this.OnClickSelectElementItem = function(elementItem)
    if this.isInitComplete ~= true then
        return
    end
    if this.isEliminating == true then
        return
    end
    if this.remainStep <= 0 then
        return
    end
    this.selectElementID = elementItem.data.ElementID
    this.RefreshCurSelectElementItem(elementItem)
end



this.RefreshCurSelectElementItem = function(elementItem)
    SetActive(this.curSelectTipsTrans.gameObject, this.selectElementID ~= nil)
    if elementItem ~= nil then
        local x, y = this.curSelectTipsTrans.localPosition.x, elementItem.rectTrans.localPosition.y
        this.curSelectTipsTrans.localPosition = Vector3(x, y, 0)
    end
end

this.GetSelectElementItem = function()
    local elementItem = nil
    if #this.elementSelectItemPool > 0 then
        elementItem = table.remove(this.elementSelectItemPool)
    else
        local obj = LuaMgr.InstantiateGO(this.elementSelectItem, this.selectElementGroup, false)
        elementItem = RSDXGameSelectItem.New(obj)
    end
    elementItem.gameObject.transform:SetAsLastSibling()
    return elementItem
end

this.RecycleAllChooseElementItem = function()
    for i = 1, #this.elementSelectItems do
        local elementItem = this.elementSelectItems[i]
        SetActive(elementItem.gameObject, false)
        table.insert(this.elementSelectItemPool, elementItem)
    end
    this.elementSelectItems = {}
end



this.CheckGameOver = function()
    if this.CheckCompleteGame() == true then
        return true, true
    end
    if this.remainStep <= 0 then
        return true, false
    end
    return false, false
end

this.CheckCompleteGame = function()
    for key, elementItem in pairs(this.elementItemsDic) do
        local gridData = elementItem.data
        local isAny = false
        for key, conditionID in pairs(this.curPassData.Conditions) do
            if gridData.CurElementID == conditionID then
                isAny = true
                break
            end
        end
        if not isAny then
            return false
        end
    end
    return true
end

this.GameSuccess = function()
    local data = {}
    local allGameData = RSDXMgr.GetAllGameData()
    local curPassIndex = 0
    for i = 1, #allGameData do
        local gameData = allGameData[i]
        if gameData.Id == this.curPassID then
            curPassIndex = i
            break
        end
    end
    data.OnlyLeftBtn = curPassIndex == #allGameData
    data.RewardData = this.curPassData.Reward
    data.RemainStep = this.remainStep
    data.PassID = this.curPassID
    if curPassIndex < #allGameData then
        data.NextPassID = allGameData[curPassIndex + 1].Id
    end
    data.OnClickLeft = function()
        LuaMgr.Back()
    end
    data.OnClickRight = function(passID)
        this.curPassID = passID
        this.before_active()
        this.animator:Play("ani_RSDXGamePanel_root", 0, 0)
    end
    LuaMgr.ShowLuaPanel(UIName.RSDXGameSuccPopup, data)
    this.GetSuccReward()
end

this.GetSuccReward = function()
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
    end
    local data = {}
    data.Id = this.curPassID
    ApiMgr.Request("colorGame/settlement", data, true, onSucc, nil, true)
end

this.GameFail = function()
    local data = {}
    data.Content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31114")
    data.OnConfirm = this.before_active
    data.OnCancel = function()
        LuaMgr.Back()
    end
    LuaMgr.ShowLuaPanel(UIName.RSDXGameMsgBoxPopup, data)
end

this.OnSkipGame = function()
    this.GameSuccess()
end



this.OnBack = function()
    local data = {}
    data.Content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31113")
    data.OnConfirm = function()
        LuaMgr.Back()
    end
    LuaMgr.ShowLuaPanel(UIName.RSDXGameMsgBoxPopup, data)
end

this.OnClickJumpBtnTimer = function()
    this.gameUseTimeSec = this.gameUseTimeSec + 1
    if this.gameUseTimeSec >= this.curPassData.SkipTime then
        SetActive(this.jumpBtn.gameObject, true)
        LuaMgr.RemoveTimer(TimerConst.RSDXGameSkipTimer)
    end
end

this.OnClickResetBtn = function()
    if this.isInitComplete ~= true then
        return
    end
    local data = {}
    data.Content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31111")
    data.OnConfirm = this.before_active
    LuaMgr.ShowLuaPanel(UIName.RSDXGameMsgBoxPopup, data)
end

this.OnClickJumpBtn = function()
    if this.isInitComplete ~= true then
        return
    end
    local data = {}
    data.Content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_31112")
    data.OnConfirm = this.GameSuccess
    LuaMgr.ShowLuaPanel(UIName.RSDXGameMsgBoxPopup, data)
end

this.Recycle = function()
    this.RecycleAllElementItem()
    this.RecycleAllChooseElementItem()
    this.RecycleAllRewardItem()
end

local command = {}

local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.jumpBtn, this.OnClickJumpBtn)
        LuaMgr.AddClick(this.resetBtn, this.OnClickResetBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.vmBehaviour = vm.behaviour
        this.vmBehaviour:UpdateTopBar("", this.OnBack)
        this.curPassID = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.RSDXGameSkipTimer)
        if this.initElementCor ~= nil then
            coroutine_runner.stop(this.initElementCor)
            this.initElementCor = nil
        end
        if this.eliminateCor ~= nil then
            coroutine_runner.stop(this.eliminateCor)
            this.eliminateCor = nil
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.jumpBtn, this.OnClickJumpBtn)
        LuaMgr.RemoveClick(this.resetBtn, this.OnClickResetBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)