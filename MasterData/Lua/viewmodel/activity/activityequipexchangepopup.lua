







require("ViewModel/CommonRewardItem")

local objs = {
    commonItemPrefab = {path = "template/CommonItemPrefab", type = UITool.GameObject},
    canntGetObj = {path = "root/Middle/Group/Reward/CanntGetBtn", type = UITool.GameObject},
    rewardPreview = {path = "root/Middle/Group/Reward/RewardPreview", type = UITool.GameObject},
    recordObj = {path = "root/Middle/RecordObj", type = UITool.GameObject},
    recordScrollView = {path = "root/Middle/RecordObj/Group/ScrollView", type = UITool.ScrollRect},
    progress = {path = "root/Middle/Group/ProgressGroup/Progress", type = UITool.Image},
    descTxt = {path = "root/Middle/Group/DownTimeBG/DescTxt", type = UITool.Text},
    goalText = {path = "root/Middle/Group/ProgressGroup/GoalText", type = UITool.Text},
    progressText = {path = "root/Middle/Group/ProgressGroup/ProgressText", type = UITool.Text},
    gotoBtn = {path = "root/Middle/Group/GotoBtn", type = UITool.Button},
    canGetBtn = {path = "root/Middle/Group/Reward/CanGetBtn", type = UITool.Button},
    maskCloseBtn = {path = "root/Middle/RecordObj", type = UITool.Button},
    lookRecordBtn = {path = "root/Middle/Group/Reward/LookRecordBtn", type = UITool.Button}
}

local this = {
    taskDescLang = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23695"),
    itemName = ""
}

this.before_awake = function()
    this.scrollView = UIScrollView.New(this.recordScrollView)
    SetActive(this.recordObj, false)
    local langText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23694")
    local itemConfig = ConfigMgr.Config.itemMap["3105"]
    this.itemName = LuaMgr.GetLangText(itemConfig.nameLan)
    this.descTxt.text = string.format(langText, this.itemName)

    this.rewardPreviewItem = CommonRewardItem.New(this.rewardPreview, true, 1)
    this.rewardItemCfg = ConfigMgr.Config.constants.ExchangeEquipTaskReward[1]
    local data = this.rewardItemCfg
    this.rewardPreviewItem:SetData1(data)
end

this.before_active = function()
    local exchangeTimes = 0
    local totalCostCount = 0
    if DataMgr.Player.EquipExchange ~= nil then
        exchangeTimes = DataMgr.Player.EquipExchange.exchangeTotal
        totalCostCount = DataMgr.Player.EquipExchange.total
    end
    local totalPhaseCount = #ConfigMgr.Config.constants.ExchangeEquipTasks

    local exchangedCount = 0
    local curPhase = 0
    this.recordListDatas = {}
    if this.rewardItemCfg == nil then
        this.rewardItemCfg = ConfigMgr.Config.constants.ExchangeEquipTaskReward[1]
    end
    for i = 1, exchangeTimes do
        local singleGoalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[i]
        if i > totalPhaseCount then
            singleGoalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[totalPhaseCount]
        end
        exchangedCount = exchangedCount + singleGoalCount
        curPhase = i + 1
        local data = this.rewardItemCfg
        table.insert(this.recordListDatas, #this.recordListDatas + 1, data)
    end

    curPhase = math.min(curPhase, totalPhaseCount)
    curPhase = math.max(curPhase, 1)
    local goalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[curPhase]
    local costCount = totalCostCount - exchangedCount
    this.progressText.text = string.format("%d/%d", costCount, goalCount)
    this.progress.fillAmount = costCount / goalCount
    SetActive(this.canntGetObj, costCount < goalCount)
    this.goalText.text = string.format(this.taskDescLang, this.itemName, goalCount)
    local redNum = 0
    if costCount >= goalCount then
        redNum = 1
    end
    RedMgr.Singleton:UpdateClientRedData("16816", redNum)
    RedMgr.Singleton:Refresh()
end

this.RefreshRecordList = function()
    this.scrollView:Clear()
    local scrollDatas = {}
    local datas = this.recordListDatas
    local len = #datas
    for i = 1, len do
        local scrollData = UIScrollData.GetData(this.commonItemPrefab, "CommonRewardItem", 155, 200, datas[i])
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(800, 200)
    this.scrollView:SetPadding(20, 20, 0, 0)
    this.scrollView:SetData(scrollDatas, true)
end

this.OnClickGotoBtn = function()
    FeatureManager.GotoPanel("1019")
end

this.OnClickCanGetBtn = function()
    local onSuccess = function(res)
        local data = json.decode(res)
        if data.code == 0 then
            local rewared = json.encode(data.result.Rewards)
            LuaMgr.ShowItemRewared(rewared, this.before_active)
        end
    end
    local data = {}
    ApiMgr.Request("equipexchange/getRewards", data, true, onSuccess, nil, true)
end

this.OnClickLookRecordBtn = function()
    this.RefreshRecordList()
    SetActive(this.recordObj, true)
end

this.OnClickMaskCloseBtn = function()
    SetActive(this.recordObj, false)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.gotoBtn, this.OnClickGotoBtn)
        LuaMgr.AddClick(this.canGetBtn, this.OnClickCanGetBtn)
        LuaMgr.AddClick(this.lookRecordBtn, this.OnClickLookRecordBtn)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickMaskCloseBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.gotoBtn, this.OnClickGotoBtn)
        LuaMgr.RemoveClick(this.canGetBtn, this.OnClickCanGetBtn)
        LuaMgr.RemoveClick(this.lookRecordBtn, this.OnClickLookRecordBtn)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickMaskCloseBtn)
        UIScrollView.ClearItem("CommonRewardItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)