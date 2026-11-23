require("ViewModel/CrisisContract2/CrisisContract2MedalItem")

local this = {
    vm = nil,
    medalList = {},
    scrollView = nil,
}

local data = {
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CrisisContract2MedalPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Group/ScrollView").gameObject)
        this.itemTemplate = vm.behaviour.transform:Find("template/MedalItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.medalList = vm.behaviour.Params[0]
        this.SetMedalList()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.scrollView:Clear(false)
    end,
    before_destroy = function(vm)
        this = nil
        UIScrollView.ClearItem("CrisisContract2MedalItem")
    end,
}

this.SetMedalList = function()
    local curScore = CrisisContract4Mgr.GetTotalScore()
    this.scrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local groupData = nil
    for i, v in ipairs(this.medalList) do
        groupData = v
        groupData.isFinish = curScore >= v.target
        groupData.progress = string.format(LuaMgr.GetLangText("CrisisContract2MedalPopup_0"), curScore, v.target)
        groupData.index = i
        scrollData = UIScrollData.GetData(this.itemTemplate, "CrisisContract2MedalItem", 818, 100, v)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(818, 360)
    this.scrollView:SetData(scrollDatas, true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})