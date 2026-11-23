




local this = {vm = nil}
local IconPath = "Assets/_BundleResources/Images/ItemIcons/itemicon_"
local groupFlower = "group.201"
local cfgCheckInQuest
local ActiveNetData
local CurrenDays
local CurrenDays
local PositionGroup = {
    Vector3(-237, 40, 0),
    Vector3(-71, -32, 0),
    Vector3(94, 40, 0),
    Vector3(258, -32, 0)
}
local data = {
    openTime = "",
    closeTime = "",
    itemList = {
        {
            itemId = "",
            object = false,
            equipRare = DefaultSprite,
            equipIcon = DefaultTexture,
            already = false,
            current = false,
            equipTrue = Vector3.zero,
            equipFalse = Vector3.zero,
            itemPos = Vector3.zero,
            number = ""
        }
    }
}

local command = {
    GotoBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.CheckNewYearOpen() then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ActivityNewYearViewModel_0"))
                return
            end
            LuaMgr.HidePanel(UIName.ActivityNewYearViewModel)
            ComData.newyearData = ActiveNetData
            LuaMgr.ShowLuaPanel(UIName.NewYearViewModel, ActiveNetData)
        end
    },
    ClickItemShow = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local goodsId = this.vm.data.itemList[param + 1].itemId
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, goodsId, true, true, true)
        end
    }
}
local hook = {
    before_awake = function(vm)
        this.vm = vm
        print("before_awake")
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.ParseData)
            LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, this.ParseData)
            LuaMgr.RemoveUIEventListener(UIEventConst.NewYearDataRefush, this.ParseData)
            LuaMgr.AddUIEventListener(UIEventConst.NewYearDataRefush, this.ParseData)
            this.ParseData()
        end     
    end,
    before_deactive = function(vm)
        print("before_deactive")
        LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, this.ParseData)
        LuaMgr.RemoveUIEventListener(UIEventConst.NewYearDataRefush, this.ParseData)
    end
}


this.ParseData = function()
    cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByText("NewYear")

    table.sort(
        cfgCheckInQuest,
        function(a, b)
            return tonumber(a.id) < tonumber(b.id)
        end
    )
    this.NetData()
end


this.NetData = function()
    local dataQuests = DataMgr.Player.quests
    local Netdata = {}
    for key, value in ipairs(cfgCheckInQuest) do


        table.insert(Netdata, dataQuests[value.id])
    end
    local groupId = ActivityMgr.groupKeyList[ActivityKey.XCHD]
    local dataGroup_flower = DataMgr.Player.variables[groupId]
    local startTime = dataGroup_flower.startTime
    local ShowstartTime = os.date("*t", dataGroup_flower.startTime)
    local ShowendTime = os.date("*t", dataGroup_flower.expireTime)
    local startTimeString = string.format("%d.%d", ShowstartTime.month, ShowstartTime.day)
    local endTimeString = string.format("%d.%d", ShowendTime.month, ShowendTime.day)
    this.vm.data.openTime = "1.1"
    this.vm.data.closeTime = "1.4"
    local NowTime = LuaMgr.Timestamp()
    CurrenDays = math.floor((NowTime-startTime)/86400)  +1
    ActiveNetData = {currentdays = CurrenDays, data = Netdata}
    this.initRewardData()
end

this.initRewardData = function()
    local tempList = {}
    for i, v in ipairs(cfgCheckInQuest) do
        local rewardItem = v.reward[1]
        if ConfigMgr.Config.itemMap == nil then
            return
        end
        local state = DataExHelper.Check_RewardState(v.id)

        local items = {
            itemId = tostring(rewardItem.id),
            object = true,
            equipRare = LuaMgr.GetSprite(
                "ItemRare",
                "itemRare" .. ConfigHelper.GetItemById(tostring(rewardItem.id)).rare
            ),
            already =DataMgr.Player.quests[v.id]~=nil and  DataMgr.Player.quests[v.id].state == 3,
            current = i == CurrenDays,
            equipIcon = LuaMgr.GetTexture(IconPath .. tostring(rewardItem.id) .. ".png"),
            equipTrue = Vector3(0.7, 0.7, 0.7),
            equipFalse = Vector3(0.7, 0.7, 0.7),
            rare = ConfigHelper.GetItemById(tostring(rewardItem.id)).rare,
            number = LuaMgr.NumFormat(rewardItem.count),
            itemPos = PositionGroup[i]
        }
        table.insert(tempList, items)
    end
    table.sort(
        tempList,
        function(a, b)
            return a.rare > b.rare
        end
    )
    this.vm.data.itemList = tempList
end
this.CheckNewYearOpen = function()
    return true
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)