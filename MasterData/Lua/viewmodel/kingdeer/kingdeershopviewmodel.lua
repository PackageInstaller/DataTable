







require("ViewModel/KingDeer/KingDeerShopGroup")
local objs = {
    prefabItem = {path = "template/ShopItem", type = UITool.GameObject},
    prefabGroup = {path = "template/ShopItemGroup", type = UITool.GameObject},
    scrollViewObj = {path = "root/Middle/ScrollView", type = BalatroUtil.GameObject},
    scrollViewContent = {path = "root/Middle/ScrollView/Viewport/Content", type = BalatroUtil.Transform},
    characterDrawing = {path = "root/Middle/Character/Group/Body", type = UITool.DrawingAdjustTool},
    spineCharacter = {path = "root/Middle/Character/Group/Body", type = UITool.UISpineCharacter}
}

local this = {}

this.before_awake = function()
    this.scrollView = UIScrollView.New(this.scrollViewObj.gameObject)
    this.SetCharacter()
end

this.before_active = function()
    this.InitUI()
end

this.before_destroy = function()
    if (this.characterMsg ~= nil) then
        this.characterMsg:Clear()
    end
end

this.InitUI = function()
    if ActivityMgr.ActivityRuning(ActivityKey.KingDeerActivity) == false then
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15901")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
        return
    end
    this.scrollView:Clear()
    local rewardDatas = this.GetRewardDatas()
    if rewardDatas ~= nil then
        this.rewardDatas = rewardDatas
    end
    if this.rewardDatas == nil then
        return
    end
    local datasLen = #this.rewardDatas
    local rowMaxCount = 4
    local rows = 0
    if datasLen % rowMaxCount == 0 then
        rows = math.floor(datasLen / rowMaxCount)
    else
        rows = math.floor(datasLen / rowMaxCount) + 1
    end
    local groupWidth, groupHight = 808, 280
    local scrollDatas = {}
    for i = 1, rows do
        local groupData = {}
        groupData.item = this.prefabItem
        groupData.list = {}
        groupData.itemCount = rowMaxCount
        groupData.index = i
        local lastPos = (i - 1) * rowMaxCount
        for j = 1, rowMaxCount do
            local tempDatas = this.rewardDatas[lastPos + j]
            if tempDatas ~= nil then
                table.insert(groupData.list, tempDatas)
            end
        end
        local scrollData = UIScrollData.GetData(this.prefabGroup, "KingDeerShopGroup", groupWidth, groupHight, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(this.scrollWidth, 520)
    this.scrollView:SetData(scrollDatas, true)
end

this.GetRewardDatas = function()
    local rewardDatas = {}
    local allQuests = KingDeerData.GetShopData()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.KingDeerActivity)
    if activityData == nil or allQuests == nil then
        LuaDebug.error("KingDeerShopViewModel 活动数据配置有误")
        return
    end
    local curTime = LuaMgr.Timestamp()
    local quests = DataMgr.Player.quests
    local len = #allQuests

    for i = 1, len do
        local questConfig = allQuests[i].config
        local startTime = questConfig.startTime * 60 + activityData.startTime
        local endTime = questConfig.endTime * 60 + activityData.startTime
        local tempData = {}
        if (curTime >= startTime and curTime <= endTime) then
            local questData = quests[questConfig.id]
            tempData.questConfig = questConfig
            tempData.progress = questData.progress
            table.insert(rewardDatas, tempData)
        end
    end
    local sortFunc = function(data1, data2)
        local isFull1 = data1.progress >= data1.questConfig.progress
        local isFull2 = data2.progress >= data2.questConfig.progress
        if isFull1 == true and isFull2 == false then
            return false
        elseif isFull1 == false and isFull2 == true then
            return true
        end
        return data1.questConfig.sort < data2.questConfig.sort
    end
    table.sort(rewardDatas, sortFunc)
    return rewardDatas
end

this.SetCharacter = function()
    local characterId = "V0117"
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, characterId .. "001")
    if path ~= "" then
        this.characterDrawing.Sprite = path
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
        LuaMgr.AddUIEventListener(UIEventConst.KingDeerShopRefresh, this.InitUI)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.KingDeerShopRefresh, this.InitUI)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("KingDeerShopGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)