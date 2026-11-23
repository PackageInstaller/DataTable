require("ViewModel/SongShiYouXin/ViewItem/SSYXDungeonItem")
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
    RedMgr.Singleton:RegisterViewModel(UIName.SSYXOutDungeonPanel)
end

this.before_active = function()
    this.curSelectPage = SSYXData.GetDungeonPage()
    for i = 1, #this.toggleNodes do
        local toggleNode = this.toggleNodes[i]
        toggleNode.toggle.isOn = this.curSelectPage == i
    end
    SSYXData.SetDungeonRedPoint(0)
    this.SwitchPage()
    local redCount = SSYXData.GetDungeonRedPoint()
    SSYXData.SetDungeonRedPoint(redCount)
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        SSYXData.SetDungeonPage(index)
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
    if this.curSelectPage == 1 then
        allDatas = SSYXData.GetDungeonDatas(SSYXConst.EventType.Repeat)
    elseif this.curSelectPage == 2 then
        allDatas = SSYXData.GetDungeonDatas(SSYXConst.EventType.MainLine)
    elseif this.curSelectPage == 3 then
        allDatas = SSYXData.GetDungeonDatas(SSYXConst.EventType.Hard)
    end
    local scrollDatas = {}
    local itemWidth = 460
    local lastData = SSYXData.GetTempDungeonData(this.curSelectPage)
    local lastDataIndex = 0
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickDungeon = this.OnClickDungeon
        local scrollData = UIScrollData.GetData(this.dungeonItem, "SSYXDungeonItem", itemWidth, 606, data)
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
    SSYXData.SetTempDungeonData(this.curSelectPage, item.data)
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
        UIScrollView.ClearItem("SSYXDungeonItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)