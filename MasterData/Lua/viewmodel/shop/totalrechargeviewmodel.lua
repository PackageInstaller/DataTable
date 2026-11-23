

local this = {
    vm=nil,
    data={
        taskList = {
            target = 0,
            status = 0,
            config = nil,
        },
        postTaskID = "",
        curSelectTaskIndex = -1,
    }
};

local data = {
    taskList = {
        {
            indexSprite = DefaultSprite,
            targetStr = "",
            rewardList = {{id = "", count = 0}},
            isProgress = false,
            isCanGet = false,
            isFinish = false,
            isSelect = false,
            showRewardTexture = false,
            rewardTexture = DefaultTexture,
        }
    },
    sliderValue = 0.0,
    progressText = "",
    curIndexSprite = DefaultSprite,
    curShowResourceIcon = DefaultTexture,
    curTaskTarget = "",
    
    showPopup_1 = false,
    popup1Desc = "",
    popup1GoodsName = "",
    
    showPopup_2 = false,
    
    showMiddle = false,

    cumulativeRecharge = false,
    cumulativeRechargeText = "",
    rechargeInfo = false,
    cumulativeRechargeTipText = "",
}

local command = {
    RechargeBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FeatureManager.GotoViewModel("1210")
        end
    },
    taskBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            if this.data.taskList[index].status ~= 3 then
                return
            end
            local taskConfig = this.data.taskList[index].config
            if taskConfig.RewardType then

                this.ShowPopup_1(taskConfig)
            else

                local param = {ID = taskConfig.ID}
                ApiMgr.Request("accumulatedrecharge/get_reward", param, true,function(result)
                    local re=json.decode(result);
                    local data=json.encode(re.result);
                    LuaMgr.ShowItemRewared(data);
                    this.ParseData();
                end, nil, true, false)
            end
        end
    },
    popup1MaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.vm.data.showPopup_2 then
                this.vm.data.showPopup_2 = false
            else
                this.vm.data.showPopup_1 = false
            end
        end
    },
    popup1CancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showPopup_1 = false
        end
    },
    popup1ConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.CheckPopupInfo() then
                this.vm.data.showPopup_2 = true
            end
        end
    },
    popup2CancelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.showPopup_2 = false
        end
    },
    popup2ConfirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local data = {
                ID = this.data.postTaskID,
                name = this.nameInputField.text,
                address = this.addressInputField.text,
                phone = this.phoneInputField.text,
                order = this.data.postOrder
            }
            ApiMgr.Request("accumulatedrecharge/post",data,true,function(result)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("TotalRechargeViewModel_0"), this.ParseData);
            end, nil, true, true)
            this.vm.data.showPopup_2 = false
        end
    },
    taskItemClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            this.SetCurSelectTaskInfo(index)
        end
    },
    rechargeInfoTipCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, ConfigMgr.LangGlobal("31156"));
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.nameInputField = vm.behaviour.transform:Find("root/Middle/Popup/Popup1/Name/InputField"):GetComponent("InputField");
        this.phoneInputField = vm.behaviour.transform:Find("root/Middle/Popup/Popup1/Phone/InputField"):GetComponent("InputField");
        this.addressInputField = vm.behaviour.transform:Find("root/Middle/Popup/Popup1/Address/InputField"):GetComponent("InputField");
    end,
    
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.vm.data.showMiddle = false
        local data = {}
        data.DeviceID = LuaMgr.GetToken()
        ApiMgr.Request("heartbeat",data,true,function(result)
            this.ParseData()
            this.vm.data.showMiddle = true
        end, nil, true, false)
    end,

    before_deactive = function(vm)
    end,

    before_destroy = function(vm)
        this.vm.data = nil;
        this.vm.behaviour = nil;
        this.vm = nil;
        this.data=nil;
    end,
}

this.ParseData = function()
    this.RefreshTaskListData()
    this.SetTaskList()
    this.SetCurProgressTaskInfo()

    this.vm.data.showPopup_1 = false
    this.vm.data.showPopup_2 = false
    HeroRedDataHelper.FrushMainShopRed()
    

    this.CumulativeRechargeDisplay()
    this.CumulativeRechargeInfo()
end

this.CumulativeRechargeDisplay = function()
    this.vm.data.cumulativeRechargeText = ""
    local nowTime = LuaMgr.Timestamp()
    local startTime = ConfigMgr.Config.constants.CumulativeRechargeDisplayTimeStart
    local entTime = ConfigMgr.Config.constants.CumulativeRechargeDisplayTimeEnd
    if nowTime >= startTime and nowTime < entTime then
        ApiMgr.Request("get_recharge_amount",{},true,function(result)
            local re = json.decode(result)
            if re.code == 0 then
                local amount = math.floor(re.result.total / 100)
                this.vm.data.cumulativeRechargeText = string.format(ConfigMgr.LangGlobal("29715"),amount)
                this.vm.data.cumulativeRecharge = true
            end
        end, nil, true)
    else
        this.vm.data.cumulativeRecharge = false
    end
end

this.CumulativeRechargeInfo = function()
    local nowTime = LuaMgr.Timestamp()
    local startTime = ConfigMgr.Config.constants.RewardChangeDisplayTimeStart
    local entTime = ConfigMgr.Config.constants.RewardChangeDisplayTimeEnd
    if nowTime >= startTime and nowTime < entTime then
        this.vm.data.cumulativeRechargeTipText = ConfigMgr.LangGlobal("31157")
        this.vm.data.rechargeInfo = true
    else
        this.vm.data.rechargeInfo = false
    end
end

this.RefreshTaskListData = function()
    local rechargeCfgMap = ConfigMgr.Config.AccumulatedRechargeMap
    local rechargeData = DataMgr.Player.accumulatedRecharge
    this.data.taskList = {}
    for k, v in pairs(rechargeCfgMap) do
        local taskData = {
            config = v,
            target = v.Condition1[1].Count,
        }
        if (not IsNull(rechargeData.reward) and rechargeData.reward[k] ~= nil) or (not IsNull(rechargeData.order) and rechargeData.order[k] ~= nil) then
            taskData.status = 1
        elseif not IsNull(rechargeData.finish) and rechargeData.finish[k] ~= nil then
            taskData.status = 3
        else
            taskData.status = 2
        end
        table.insert(this.data.taskList, taskData)
    end
    table.sort(this.data.taskList, function(a, b)
        if a.config.Order ~= b.config.Order then
            return a.config.Order < b.config.Order
        end

        return a.target < b.target
    end)
    for i, v in ipairs(this.data.taskList) do
        this.data.taskList[i].index = i
    end
    table.sort(this.data.taskList, function(a, b)
        if a.status ~= b.status then
            return a.status > b.status
        end

        if a.config.Order ~= b.config.Order then
            return a.config.Order < b.config.Order
        end

        return a.target < b.target
    end)
end

this.SetTaskList = function()
    local list = {}
    for i, v in ipairs(this.data.taskList) do
        local taskItem = {
            indexSprite = LuaMgr.GetSprite("Shop",  v.index >= 10 and "ui_jk_txt_dj_xsz" .. v.index or "ui_jk_txt_dj_xsz0" .. v.index),
            targetStr = tostring(v.target),
            rewardList = this.GetRewardItemList(v.config.RechargeItem),
            isProgress = v.status == 2,
            isCanGet = v.status == 3,
            isFinish = v.status == 1,
            isSelect = false,
            showRewardTexture = v.config.RewardType,
        }
        if taskItem.showRewardTexture then
            taskItem.rewardTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ShopIcons/%s.png", v.config.Showresource2))
        end
        table.insert(list, taskItem)
    end
    this.vm.data.taskList = list
end

this.SetCurSelectTaskInfo = function(index)
    if this.data.curSelectTaskIndex == index then
        return
    end
    if this.data.curSelectTaskIndex > 0 then
        this.vm.data.taskList[this.data.curSelectTaskIndex].isSelect = false
    end
    this.data.curSelectTaskIndex = index
    this.vm.data.taskList[this.data.curSelectTaskIndex].isSelect = true
    this.vm.data.curShowResourceIcon = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/ShopIcons/%s.png",  this.data.taskList[this.data.curSelectTaskIndex].config.ShowResource1))
    this.vm.data.curTaskTarget = tostring(this.data.taskList[this.data.curSelectTaskIndex].target)
end

this.SetCurProgressTaskInfo = function()
    local totalRecharge = math.floor(DataMgr.Player.accumulatedRecharge.total / 100)
    local curIndex = #this.data.taskList
    local curTaskData = nil
    for i, v in ipairs(this.data.taskList) do
        if v.target > totalRecharge then
            curTaskData = v
            curIndex = v.index
            break
        end
    end
    if curTaskData == nil then
        for i, v in ipairs(this.data.taskList) do
            if v.index == #this.data.taskList then
                curTaskData = v
                break
            end
        end
    end
    
    this.vm.data.curIndexSprite = LuaMgr.GetSprite("Shop", curIndex >= 10 and "ui_jk_txt_dj_sz" .. curIndex or "ui_jk_txt_dj_sz0" .. curIndex)
    this.vm.data.sliderValue = totalRecharge / curTaskData.target * 100
    this.vm.data.progressText = string.format(LuaMgr.GetLangText("TotalRechargeViewModel_1"), totalRecharge, curTaskData.target)
    this.SetCurSelectTaskInfo(curIndex)
end

this.ShowPopup_1 = function(taskCfg)
    this.data.postTaskID = taskCfg.ID
    this.data.postOrder = ""
    local orderData = DataMgr.Player.accumulatedRecharge.order
    local taskOrderData = nil
    if not IsNull(orderData) then
        taskOrderData = orderData[taskCfg.ID]
    end
    if taskOrderData == nil then
        this.nameInputField.text = ""
        this.phoneInputField.text = ""
        this.addressInputField.text = ""
    else
        this.nameInputField.text = taskOrderData.name
        this.phoneInputField.text = taskOrderData.phone
        this.addressInputField.text = taskOrderData.address
        this.data.postOrder = taskOrderData.order
    end
    this.vm.data.popup1Desc = string.format(LuaMgr.GetLangText("TotalRechargeViewModel_2"), taskCfg.Condition1[1].Count)
    this.vm.data.popup1GoodsName = LuaMgr.GetLangText(taskCfg.ShowLan)
    this.vm.data.showPopup_1 = true
end

this.CheckPopupInfo = function()
    local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7002"].NameLan)
    if IsNullOrEmpty(this.nameInputField.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil);
        return false
    end
    
    tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7004"].NameLan)
    if IsNullOrEmpty(this.phoneInputField.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil);
        return false
    else
        local phoneStr = string.match(this.phoneInputField.text,"[1][3-9]%d%d%d%d%d%d%d%d%d")
        if phoneStr == nil or phoneStr ~= this.phoneInputField.text then
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil);
            return false
        end
    end
    tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7001"].NameLan)
    if IsNullOrEmpty(this.addressInputField.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil);
        return false
    end
    
    return true
end

this.GetRewardItemList = function(rewards)
    local tempRewardLis = {}
    if IsNull(rewards) then
        return tempRewardLis
    end
    for i = 1, #rewards do
        local itemRare = ConfigMgr.Config.itemMap[rewards[i].id].rare
        local rewardItem = {
            id = rewards[i].id,count = LuaMgr.NumFormat(rewards[i].count),isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(rewards[i].id),
            scale = Vector3.one,
            sizeDelta=Vector2(128,128),
            isClick = true}
        table.insert(tempRewardLis, rewardItem)
    end



    return tempRewardLis
end

return vm({
    data = data,
    command = command,
    hook = hook
})