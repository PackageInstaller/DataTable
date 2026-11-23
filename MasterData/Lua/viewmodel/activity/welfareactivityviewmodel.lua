




local this = {
    vm = nil,
    tableInsert = table.insert,
    tableSort = table.sort,
    curIndex = 1,
}

local data = {
    itemButton = {{normal = false,choose = false,groupPos = Vector2.zero,name = ""}},
}

local command = {
    itemButtonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            if this.curIndex == index then return end
            this.SwitchActivityView(index)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.tableSort(ActivityMgr.welfareKeyList,function(a,b)
            return a.orderSum<b.orderSum;
        end)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.HidePanel(this.vm.data.itemButton[this.curIndex].panel)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitParameter = function()
    this.curIndex = -1
    this.vm.behaviour:UpdateTopBar("", this.OnBack)
    this.ItemButtonView()
    if #this.vm.data.itemButton >= 1 then
        this.SwitchActivityView(1)
    end
end


this.ItemButtonView = function()
    local tempList,tempItem = {},{}
    local isShowBtnBool,groupId = false,nil
    for i = 1, #ActivityMgr.welfareKeyList do
        if ActivityMgr.welfareKeyList[i].key == "cdkey" then
            isShowBtnBool = ActivityMgr.ActivityRuning(ActivityMgr.welfareKeyList[i].key)
        elseif ActivityMgr.welfareKeyList[i].key == "questionnaire" then
            isShowBtnBool = ActivityMgr.ActivityRuning(ActivityMgr.welfareKeyList[i].key)
        else
            groupId = ActivityMgr.groupKeyList[ActivityMgr.welfareKeyList[i].key]
            isShowBtnBool = DataMgr.Player.variables[groupId] ~= nil and
                    LuaMgr.Timestamp() < DataMgr.Player.variables[groupId].delTime
        end
        if isShowBtnBool then
            tempItem = {
                normal = true,choose = false,
                groupPos = i % 2 == 0 and Vector2(40,0) or Vector2(-40,0),
                name = ActivityMgr.welfareKeyList[i].name,
                panel = ActivityMgr.welfareKeyList[i].panel,
            }
            this.tableInsert(tempList,tempItem)
        end
    end
    this.vm.data.itemButton = tempList
end


this.SwitchActivityView = function(index)
    if this.curIndex >= 1 then
        this.vm.data.itemButton[this.curIndex].normal = true
        this.vm.data.itemButton[this.curIndex].choose = false
        LuaMgr.HidePanel(this.vm.data.itemButton[this.curIndex].panel)
    end
    this.curIndex = index
    this.vm.data.itemButton[index].normal = false
    this.vm.data.itemButton[index].choose = true
    LuaMgr.ShowLuaPanel(this.vm.data.itemButton[index].panel)
end

this.OnBack = function()
    LuaMgr.HidePanel(this.vm.data.itemButton[this.curIndex].panel)
    LuaMgr.Back()
end
return vm({
    data = data,
    command = command,
    hook = hook
})