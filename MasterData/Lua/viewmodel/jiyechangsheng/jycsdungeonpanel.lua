require("ViewModel/JiYeChangSheng/ViewItem/JYCSDungeonItem")
local objs = {
    dungeonItem = {path = "template/DungeonItem", type = UITool.GameObject},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {
    scrollViewWidth = 0
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
    this.toggleNodes = {}
    for i = 1, 3 do
        local name = "Toggle" .. i

        local toggleNode = CommonToggleItem.New(this[name], nil, false, i, this.ClickPageToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
    end
    this.scrollViewWidth = LuaMgr.GetScreenWidth()
    RedMgr.Singleton:RegisterViewModel(UIName.JYCSDungeonPanel)
end

this.before_active = function()
    this.curSelectPage = JYCSData.GetDungeonPage()
    for i = 1, #this.toggleNodes do
        local toggleNode = this.toggleNodes[i]
        toggleNode.toggle.isOn = this.curSelectPage == i
    end
    this.SwitchPage()
    local redNum3_1 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.Repeat)
    local redNum3_2 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.Hard)
    local redNum3_3 = JYCSData.GetDungeonRedPoint(JYCSConst.EventType.MainLine)
    RedMgr.Singleton:SetRedState(JYCSConst.RedPoint.Repeat, redNum3_1)
    RedMgr.Singleton:SetRedState(JYCSConst.RedPoint.HardDungeon, redNum3_2)
    RedMgr.Singleton:SetRedState(JYCSConst.RedPoint.MainLineDungeon, redNum3_3)
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        JYCSData.SetDungeonPage(index)
        this.SwitchPage()
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(index == i)
        end
    end
end

this.SwitchPage = function()
    this.scrollViewUI:Clear()
    local allDatas = {}
    local firstUnlockData = nil
    if this.curSelectPage == 1 then
        allDatas, firstUnlockData = JYCSData.GetDungeonDatas(JYCSConst.EventType.Repeat)
    elseif this.curSelectPage == 2 then
        allDatas, firstUnlockData = JYCSData.GetDungeonDatas(JYCSConst.EventType.MainLine)
    elseif this.curSelectPage == 3 then
        allDatas, firstUnlockData = JYCSData.GetDungeonDatas(JYCSConst.EventType.Hard)
    end
    this.firstUnlockData = firstUnlockData
    local scrollDatas = {}
    local itemWidth = 460
    local lastData = JYCSData.GetTempDungeonData(this.curSelectPage)
    local lastDataIndex = 0
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickDungeon = this.OnClickDungeon
        local scrollData = UIScrollData.GetData(this.dungeonItem, "JYCSDungeonItem", itemWidth, 606, data)
        table.insert(scrollDatas, scrollData)
        if data.Status == CommonRewardItem.Status.None and lastDataIndex == 0 then
            lastDataIndex = i - 1
            lastDataIndex = math.max(lastDataIndex, 1)
        end
    end
    if lastDataIndex == 0 and lastData ~= nil then
        lastDataIndex = lastData.Index
    elseif lastDataIndex == 0 then
        lastDataIndex = 1
    end
    this.scrollViewUI:SetParams(this.scrollViewWidth, 628)
    this.scrollViewUI:SetData(scrollDatas, true)
    this.scrollViewUI:MoveToIndex(lastDataIndex)
end



this.OnClickDungeon = function(item)
    if this.firstUnlockData ~= nil then
        local prefix = nil
        if this.curSelectPage == 1 then
            prefix = JYCSConst.RedPoint.Repeat
        elseif this.curSelectPage == 2 then
            prefix = JYCSConst.RedPoint.MainLineDungeon
        elseif this.curSelectPage == 3 then
            prefix = JYCSConst.RedPoint.HardDungeon
        end
        local dungeonID = this.firstUnlockData.id
        if item.data.id == dungeonID then
            local redID = string.format("%s_%s", prefix, dungeonID)
            RedMgr.Singleton:FrushRedCondition(redID)
        end
    end
    JYCSData.SetTempDungeonData(this.curSelectPage, item.data)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, 3 do
            local name = "Toggle" .. i
            local path = "root/Middle/ToggleGroup/" .. name
            objs[name] = {path = path, type = UITool.GameObject}
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("JYCSDungeonItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)