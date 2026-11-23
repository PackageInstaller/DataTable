require("Tools/UITool")
require("ViewModel/TeamRelay2/TeamRelay2DelegateResultItem")

local objs = {
    resultContainerTr = { path = "root/Middle/Group/ScrollView/Viewport/Content", type = UITool.Transform },
    resultItemTemplate = { path = "template/ResultItem", type = UITool.GameObject },
}
local this = {
    vm = nil,
    resultList = nil,
    coroutine = nil,
}

local data = {
    totalScore = "",
    leftCountTips = "",
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.Back()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour, this, objs);
        this.resultList = UIListView.New(this.resultContainerTr);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack)

        this.InitParameter()
        this.RefreshData()
        this.PlayAnim()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.resultList:Clear();
        if this.coroutine ~= nil then
            coroutine_runner.stop(this.coroutine)
        end
    end,
    before_destroy = function(vm)
        UIListView.ClearItem("TeamRelay2DelegateResultItem")
    end
}

this.InitParameter = function()
    this.singleScore = this.vm.behaviour.Params[0]
    this.count = this.vm.behaviour.Params[1]
end

this.RefreshData = function()
    this.resultList:Clear();
    local listDataList = {};
    for i = 1, this.count do
        local listData = UIListData.GetData(this.resultItemTemplate, "TeamRelay2DelegateResultItem", {
            index = i,
            value = this.singleScore,
            animBool = false,
        });
        table.insert(listDataList, listData);
    end
    this.resultList:SetData(listDataList);
    this.vm.data.totalScore = this.singleScore * this.count
    local leftCount, limitCount = TeamRelay2Mgr.GetAllLeftChallengeCount()
    this.vm.data.leftCountTips = string.format(LuaMgr.GetLangText("TeamRelay2DelegateResultViewModel_0"), leftCount, limitCount)
end

this.PlayAnim = function()
    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
    end
    this.coroutine = coroutine_runner.start(function()
        coroutine_runner.wait(0.1)
        local len = #this.resultList.dataList
        for i = 1, len do
            this.resultList.dataList[i].data.animBool = true
            if this.resultList.itemMap[i] ~= nil then
                SetActive(this.resultList.itemMap[i].animGo, true)
                coroutine_runner.wait(0.1)
            end
        end
    end)
end

return vm({
    data = data,
    command = command,
    hook = hook
})