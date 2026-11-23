require("ViewModel/SuiChuNaJi/ViewItem/SCNJAllServerItemGroup")
require("ViewModel/SuiChuNaJi/ViewItem/SCNJRewardNormalItem")

local objs = {
    narmalItem = {path = "template/NormalItem", type = UITool.GameObject},
    allServerItem = {path = "template/AllServerItem", type = UITool.GameObject},
    allServerItemGroup = {path = "template/AllServerGroup", type = UITool.GameObject},
    normalGroup = {path = "root/Middle/NormalGroup", type = UITool.GameObject},
    allServerGroup = {path = "root/Middle/AllServerGroup", type = UITool.GameObject},
    phaseNum = {path = "root/Middle/AllServerGroup/Progress/PhaseNum", type = UITool.Text},
    phaseProgress = {path = "root/Middle/AllServerGroup/Progress/PhaseProgress", type = UITool.Text},
    progressFill = {path = "root/Middle/AllServerGroup/Progress/Progress/Fill", type = UITool.RectTransform},
    progressImage = {path = "root/Middle/AllServerGroup/Progress/Progress", type = UITool.Image},
    progressFillImage = {path = "root/Middle/AllServerGroup/Progress/Progress/Fill", type = UITool.Image},
    normalScroll = {path = "root/Middle/NormalGroup/NormalScrollView", type = UITool.GameObject},
    allServerScroll = {path = "root/Middle/AllServerGroup/AllServerScrollView", type = UITool.GameObject}
}

local this = {

    toggleItems = {},
    progressColors = {
        {"#A9BE5C", "#F1C468"},
        {"#F1C468", "#F7A04E"},
        {"#F7A04E", "#EE181D"},
        {"#EE181D", "#A9BE5C"}
    }
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.SCNJRewardPanel)
    this.normalScrollUI = UIScrollView.New(this.normalScroll)
    this.allServerScrollUI = UIScrollView.New(this.allServerScroll)
end

this.BatchInitNode = function()
    for i = 1, 4 do
        local name = "Toggle" .. i
        local path = "root/Middle/ToggleGroup/" .. name
        objs[name] = {path = path, type = UITool.GameObject}
    end
end

this.BatchInitNodeItem = function()
    for i = 1, 4 do
        local name = "Toggle" .. i

        local item = CommonToggleItem.New(this[name], nil, false, i, this.ClickPageToggle)
        this.toggleItems[i] = item
        local data = {}
        item:SetData(data)
        local curSelectPageType = SCNJData.GetCurSelectedRewardPage()
        if curSelectPageType == nil then
            this.ClickPageToggle(i, true)
        end
    end
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        SCNJData.SetCurSelectedRewardPage(index)
        this.SwitchPage()
        for i = 1, #this.toggleItems do
            local toggleNode = this.toggleItems[i]
            toggleNode:SetIsOn(index == i)
        end
    end
end

this.before_active = function()
    this.curSelectPage = this.curSelectPage or 1
    this.SwitchPage()
    SCNJData.RefreshRewardRed()
end

this.SwitchPage = function()
    SetActive(this.normalGroup, this.curSelectPage ~= SCNJConst.RewardType.AllServerFireProgress)
    SetActive(this.allServerGroup, this.curSelectPage == SCNJConst.RewardType.AllServerFireProgress)
    if this.curSelectPage == SCNJConst.RewardType.AllServerFireProgress then
        local hotData = SCNJData.GetCurServerHotData()
        this.phaseNum.text = tostring(hotData.hotLevel)
        local maxExp = SCNJConst.HotExpPercentBase
        local percentNum = hotData.hotExp / maxExp
        percentNum = math.min(percentNum, 1)
        this.phaseProgress.text = string.format("%.0f%%", percentNum * 100)
        this.progressFill.sizeDelta = Vector2(percentNum * 891, this.progressFill.sizeDelta.y)
        local colorBG, colorFill = this.GetProcessColor()
        this.progressImage.color = colorBG
        this.progressFillImage.color = colorFill
        this.RefreshAllServerScroll()
    else
        this.RefreshNormalScroll()
    end
end

this.GetProcessColor = function()
    local curHotLevelData = SCNJData.GetCurServerHotData()
    local curHotLevel = curHotLevelData.hotLevel
    local colorHexBG, colorHexFill = "", ""
    if curHotLevel == 1 then
        colorHexBG, colorHexFill = "#979797", "#A9BE5C"
    else
        local index = (curHotLevel - 1) % #this.progressColors
        if index == 0 then
            index = #this.progressColors
        end
        local data = this.progressColors[index]
        colorHexBG, colorHexFill = data[1], data[2]
    end
    local unityColorBG = this.HexToRGBA(colorHexBG)
    local unityColorFill = this.HexToRGBA(colorHexFill)
    return unityColorBG, unityColorFill
end

function this.HexToRGBA(hexColor)
    local cleanHex = string.gsub(hexColor, "#", "")
    local len = string.len(cleanHex)
    if len ~= 6 and len ~= 8 then
        print("错误：无效的16进制颜色格式，需为6位(RGB)或8位(RGBA)")
        return nil
    end
    local r = tonumber(string.sub(cleanHex, 1, 2), 16)
    local g = tonumber(string.sub(cleanHex, 3, 4), 16)
    local b = tonumber(string.sub(cleanHex, 5, 6), 16)
    local a = len == 8 and tonumber(string.sub(cleanHex, 7, 8), 16) or 255
    print(r, g, b, a)
    if not (r and g and b and a) then
        return UnityEngine.Color(0, 0, 0, 0)
    end
    return UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
end

this.RefreshNormalScroll = function()
    this.normalScrollUI:Clear(false)
    local allDatas = SCNJData.GetRewardDatas(this.curSelectPage)
    local scrollDatas = {}
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.callbackGetReward = this.GetReward
        local scrollData = UIScrollData.GetData(this.narmalItem, "SCNJRewardNormalItem", 976, 136, data)
        table.insert(scrollDatas, scrollData)
    end
    this.normalScrollUI:SetParams(976, 601)
    this.normalScrollUI:SetData(scrollDatas, true)
end

this.RefreshAllServerScroll = function()
    this.allServerScrollUI:Clear(false)
    local allDatas = SCNJData.GetRewardDatas(this.curSelectPage)
    local scrollDatas = {}
    local len = #allDatas
    local index = 0
    local itemLen = 0
    local groupCount = 5
    while index < len do
        itemLen = index + groupCount > len and len - index or groupCount
        local groupData = {}
        groupData.item = this.allServerItem
        groupData.list = {}
        for i = 1, itemLen do
            if i + index <= len then
                local data = allDatas[i + index]
                data.callbackGetReward = this.GetReward
                table.insert(groupData.list, data)
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen
        local scrollData = UIScrollData.GetData(this.allServerItemGroup, "SCNJAllServerItemGroup", 953.5, 175, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.allServerScrollUI:SetParams(953.5, 507)
    this.allServerScrollUI:SetData(scrollDatas, true)
end



this.GetReward = function(item)
    if item == nil then
        return
    end
    if item.data.RewardType == SCNJConst.RewardType.AllServerFireProgress then
        this.OnGetCallback()
    elseif item.data.RewardType == SCNJConst.RewardType.FireProgress then
        local data = {}
        data.Id = {}
        table.insert(data.Id, SCNJConst.TeamRelayID)
        ApiMgr.Request("teamRelay/teamRelayRewards", data, true, this.OnGetCallback, nil, true)
    else
        DataExHelper.EX_GetAward(item.data.questData.id, this.OnGetCallback)
    end
end

this.OnGetCallback = function(result)
    if this.curSelectPage == SCNJConst.RewardType.AllServerFireProgress then
        this.RefreshAllServerScroll()
    elseif this.curSelectPage == SCNJConst.RewardType.FireProgress then
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("开始游戏请求失败，错误码：" .. tostring(res.code))
            return
        end
        local resultData = res.result
        local rewardItemDatas = {}
        if type(resultData) == "table" and type(resultData.Rewards) == "table" and type(resultData.Rewards.Items) == "table" then
            for i, v in pairs(resultData.Rewards.Items) do
                local item = {ID = v.id, Count = v.count}
                table.insert(rewardItemDatas, item)
            end
            this.RefreshNormalScroll()
            LuaMgr.ShowItemGetPanel(rewardItemDatas)
        end
    else
        this.RefreshNormalScroll()
    end
    SCNJData.CheckRed()
    SCNJData.RefreshRewardRed()
    RedMgr.Singleton:RefreshOtherViewModel(UIName.SCNJHomePanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        this.BatchInitNodeItem()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.vmBehaviour = vm.behaviour
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("SCNJAllServerItemGroup")
        UIScrollView.ClearItem("SCNJRewardNormalItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)