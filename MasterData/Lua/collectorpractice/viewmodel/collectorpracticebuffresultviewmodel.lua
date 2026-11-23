




require("CollectorPractice/ViewModel/BuffGroupViewModel")
require("CollectorPractice/ViewModel/BuffItemViewModel")
require("CollectorPractice/ViewModel/BuffTitleModel")

local this = {
    vm = nil,level_1 = nil,level_2 = nil,callBack = nil,
    scrollView = nil,buffsData = nil,
    itemTemplate = nil,groupTemplate = nil,titleTemplate = nil,
    tableInsert = table.insert,tableSort = table.sort,
}

local data = {
    levelIcon_1 = DefaultSprite,levelIcon_2 = DefaultSprite,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SendBuff()
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Content/BuffScroll").gameObject)
        this.itemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.groupTemplate = vm.behaviour.transform:Find("template/BuffGroup").gameObject
        this.titleTemplate = vm.behaviour.transform:Find("template/BuffTitle").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.scrollView:Clear(false)
        UIScrollView.ClearItem("BuffGroupViewModel")
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("BuffTitleModel")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    this.level_1 = this.vm.behaviour.Params[0]
    this.level_2 = this.vm.behaviour.Params[1]
    this.callBack = this.vm.behaviour.Params[2]
    this.buffsData = this.vm.behaviour.Params[3]
    this.InitLevelSprite()
    this.InitBuffView()
end

this.InitLevelSprite = function()
    this.vm.data.levelIcon_1 = LuaMgr.GetSprite("AreaMapRes",this.GetRating(this.level_1))
    this.vm.data.levelIcon_2 = LuaMgr.GetSprite("AreaMapRes",this.GetRating(this.level_2))
end

this.InitBuffView = function()

    local tempList = {{},{}}
    local tempItem = nil
    if not TableIsNull(this.buffsData) then
        for i = 1, #this.buffsData do
            tempItem = ConfigMgr.Config.InternBuffMap[this.buffsData[i]]
            this.tableInsert(tempList[tempItem.Type],tempItem)
        end
    end
    for i = 1, #tempList do
        this.tableSort(tempList[i],this.SortBuff)
    end
    
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local index = nil
    local groupData = nil
    local length = nil
    local groupItem = nil
    for i = 1, #tempList do
        index = 1
        groupData = {}
        groupData.item = this.titleTemplate
        if i == 1 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7113"].NameLan) end
        if i == 2 then groupData.titleStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7114"].NameLan) end
        scrollData = UIScrollData.GetData(this.titleTemplate,"BuffTitleModel",716,34,groupData)
        this.tableInsert(scrollDatas,scrollData)

        length = #tempList[i]
        while (index <= length) do
            groupData = {}
            groupData.item = this.itemTemplate
            groupData.buff = {}
            for j = 1, 2 do
                if tempList[i][index + j - 1] ~= nil then
                    groupItem = tempList[i][index + j - 1]
                    groupItem.lock = false
                    this.tableInsert(groupData.buff,groupItem)
                end
            end
            scrollData = UIScrollData.GetData(this.groupTemplate,"BuffGroupViewModel",716,132 + 10,groupData)
            this.tableInsert(scrollDatas,scrollData)
            index = index + 2
        end
    end
    this.scrollView:SetParams(716,384)
    this.scrollView:SetPadding(0, 0, -20, -10)
    this.scrollView:SetData(scrollDatas, true)
end
this.SendBuff = function()
    local tempData = {}
    tempData["BufferIds"] = this.buffsData
    ApiMgr.Request("practice/upBuffer", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            if this.callBack ~= nil then
                this.callBack()
            end
            LuaMgr.HidePanel(UIName.CollectorPracticeBuffResultViewModel)
        end
    end,nil,true)
end
this.GetRating = function(index)
    local vaIcon = nil
    if index == 3 then
        vaIcon = "ui_zqzb_pj_S"
    elseif index == 2 then
        vaIcon = "ui_zqzb_pj_A"
    elseif index == 1 then
        vaIcon = "ui_zqzb_pj_B"
    end
    return vaIcon
end
this.SortBuff = function(item1,item2)
    return item1.Id < item2.Id
end
return vm({
    data = data,
    command = command,
    hook = hook
})