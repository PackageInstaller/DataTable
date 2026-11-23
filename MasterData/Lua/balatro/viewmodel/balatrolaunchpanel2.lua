







require("Balatro/ViewModel/BalatroLaunchRewardItem")
BalatroLaunchPanel = {}
BalatroLaunchPanel.__index = BalatroLaunchPanel

local this = {

    itemObjs = {},
    itemDatas = {}
}
local objs = {
    rewardItemPrefab = {path = "template/RewardItem", type = BalatroUtil.GameObject},
    btnStartGame = {path = "root/Middle/ChangeObj/btnStartGame", type = BalatroUtil.Button},
    progressImg = {path = "root/Middle/ChangeObj/RewardItemScroll/Viewport/Content/Progress", type = BalatroUtil.Image},
    scrollView = {path = "root/Middle/ChangeObj/RewardItemScroll", type = BalatroUtil.ScrollRect},
    txtTotalScore = {path = "root/Middle/ChangeObj/txtTotalScore", type = BalatroUtil.Text},
    txtTotalScore1 = {path = "root/Middle/ChangeObj/txtTotalScore/txtTotalScore1", type = BalatroUtil.Text},
    limitTimeObj = {path = "root/Middle/ChangeObj/LimitTime", type = BalatroUtil.GameObject},
    limitTimeText = {path = "root/Middle/ChangeObj/LimitTime/LimitTimeTxt", type = BalatroUtil.Text}
}

this.before_awake = function()
    RedMgr.Singleton:FrushRedCondition("15054")
end

this.before_active = function()
    this.vm.data.activeIsRunning = ActivityMgr.ActivityRuning(ActivityKey.BalatroBrand)
    if #this.itemObjs == 0 and this.vm.data.activeIsRunning == true then
        local rewardConfigs = ConfigMgr.Config.BalatroCharges
        local configLen = #rewardConfigs
        for i = 1, configLen do
            local itemObj = BalatroLaunchRewardItem.New(this.rewardItemPrefab, this.scrollView.content)
            table.insert(this.itemObjs, itemObj)
            itemObj:SetClickItemCallback(this.OnGetReward)
        end
    end
    this.Refresh()
end

this.OnStartGame = function()
    BalatroUtil.PlaySound(5)
    LuaMgr.ShowLuaPanel(UIName.BalatroMainViewModel)
end

this.Refresh = function()
    SetActive(this.limitTimeObj, false)
    if this.vm.data.activeIsRunning == false then
        return
    end
    SetActive(this.limitTimeObj, true)
    local config = nil
    for key, value in pairs(ConfigMgr.Config.activityGroup) do
        if value.key == "BalatroBrand" then
            config = value
            break
        end
    end
    if config == nil then
        return
    end
    local prefix = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15014")
    local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20043")
    local startM, startD = string.match(config.startTime, "%d+-(%d+)-(%d+)")
    local endM, endD, endTime = string.match(config.endTime, "%d+-(%d+)-(%d+) (.+)")
    local txt1 = prefix
    local txt2 = string.format(tips, startM, startD, "-")
    local txt3 = string.format(tips, endM, endD, " " .. endTime)
    this.limitTimeText.text = string.format("%s%s%s", txt1, txt2, txt3)
    this.txtTotalScore.text = BalatroUtil.ToScientific(DataMgr.Player.Balatro.TotalScore)
    this.txtTotalScore1.text = BalatroUtil.ToScientific(DataMgr.Player.Balatro.TotalScore)
    local rewardConfigs = ConfigMgr.Config.BalatroCharges
    this.itemDatas = {}
    local canGetCount = 0
    for key, configData in pairs(rewardConfigs) do
        if configData then
            local tempData = {}
            tempData.id = configData.Id
            tempData.condition = configData.Condition
            if configData.RechargeItem ~= nil and type(configData.RechargeItem) == BalatroUtil.LuaDataType.Table then
                tempData.goodsData = configData.RechargeItem[1]
            end
            if DataMgr.Player.Balatro ~= nil and DataMgr.Player.Balatro.RewardRecords ~= nil and type(DataMgr.Player.Balatro.RewardRecords) ~= BalatroUtil.LuaDataType.Function and DataMgr.Player.Balatro.RewardRecords[tempData.id] ~= nil then
                tempData.getStatus = BalatroUtil.RewardStatus.Got
                canGetCount = canGetCount + 1
            elseif DataMgr.Player.Balatro ~= nil and DataMgr.Player.Balatro.TotalScore >= tempData.condition then
                tempData.getStatus = BalatroUtil.RewardStatus.CanGet
                canGetCount = canGetCount + 1
            else
                tempData.getStatus = BalatroUtil.RewardStatus.None
            end
            table.insert(this.itemDatas, tempData)
        end
    end
    this.progressImg.fillAmount = canGetCount / #rewardConfigs
    table.sort(this.itemDatas, this.SortRewardData)
    for index, itemData in pairs(this.itemDatas) do
        local itemObj = this.itemObjs[index]
        if itemObj ~= nil then
            itemObj:SetData(itemData, index)
        end
    end
end

this.SortRewardData = function(data1, data2)
    return data1.id > data2.id
end


this.OnGetReward = function(item)
    if item:GetGotStatus() == BalatroUtil.RewardStatus.None then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20037")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local callback = function(result)
        local re = json.decode(result)
        if re.code == 0 then
            item:SetGetStatus(BalatroUtil.RewardStatus.Got)
            BalatroDataMgr.CheckRedDot()
            local rewared = json.encode(re.result)
            LuaMgr.ShowItemRewared(rewared, this.Refresh)
        end
    end
    local data = {
        Id = item.data.id
    }
    ApiMgr.Request("balatro/reward", data, true, callback, nil, true)
end

local data = {
    activeIsRunning = false
}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.btnStartGame, this.OnStartGame)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.btnStartGame, this.OnStartGame)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)