require("ViewModel/CrisisContract3/CrisisContract3DiffAdditionItem")

local this = {
    vm = nil,
    additionList = {
        {
            name = "",
            desc = "",
            isActivated = false,
        }
    },
    scrollView = nil,
    coroutine_key = nil,
}

local data = {}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CrisisContract3DiffAdditionPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/ScrollView").gameObject)
        this.itemTemplate = vm.behaviour.transform:Find("template/AdditionItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        
        this.curScore = vm.behaviour.Params[0]
        this.SetAdditionList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.scrollView:Clear(false)
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract3DiffAdditionItem")
    end,
}

this.SetAdditionList = function()
    local buffReinfMap = ConfigMgr.Config.Contract3BuffReinfMap
    local additionList = {}
    for k, v in pairs(buffReinfMap) do
        table.insert(additionList, {
            credit = v.Credit,
            name = LuaMgr.GetLangText("CrisisContract3DiffAdditionPopup_0") .. v.Credit,
            desc  = LuaMgr.GetLangText(v.BuffDescLan),
            isActivated = false,
        })
    end
    table.sort(additionList, function(a, b) return a.credit < b.credit end)
    for i = #additionList, 1, -1 do
        if this.curScore >= additionList[i].credit then
            additionList[i].isActivated = true
            break
        end
    end
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    for i, v in ipairs(additionList) do
        groupData = v
        groupData.index = i
        scrollData = UIScrollData.GetData(this.itemTemplate, "CrisisContract3DiffAdditionItem", 840, 91, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(840, 360)
    this.scrollView:SetData(scrollDatas, true)

    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.scrollView.dataList do
            this.scrollView.dataList[i].data.animBool = true
            if this.scrollView.itemMap[i] ~= nil then
                SetActive(this.scrollView.itemMap[i].animatorObj, true)
            end
            coroutine_runner.wait(0.05)
        end
    end)
    
end

return vm({
    data = data,
    command = command,
    hook = hook
})