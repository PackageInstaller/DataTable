





require("CollectorPractice/ViewModel/BuffGroupViewModel")
require("CollectorPractice/ViewModel/BuffItemViewModel")

local this = {
    vm = nil,isPreview = false,scrollView = nil,callBack = nil,
    itemTemplate = nil,groupTemplate = nil,buffList = nil,
    tableInsert = table.insert,tableSort = table.sort,labelType = nil,
    level_1 = nil,level_2 = nil,formatCount = "      (%d/%d)",
    autoCount = nil,buffCount = nil,deBuffCount = nil,coroutine_key = nil,
    autoChooseCount = nil,playerChooseCount = nil,deBuffChooseCount = nil,
    cacheBuff = nil,isChoose = false,isCanGoto = false,
}

local data = {
    labelObj = false,label_add_choose = false,label_subtract_choose = false,
    controlsObj = false,confirmObj = false,tip_add = false,tip_subtract = false,
    tipText = "",levelIcon_1 = DefaultSprite,levelIcon_2 = DefaultSprite,
    add_text = "",subtract_text = "",closeObj = false,
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CollectorPracticeBuffViewModel)
        end
    },
    label_add_Command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.labelType = 1
            this.SwitchViewState()
        end
    },
    label_subtract_command = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.labelType = 2
            this.SwitchViewState()
        end
    },
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ConfirmBuff()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.itemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.groupTemplate = vm.behaviour.transform:Find("template/BuffGroup").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/Content/BuffScroll").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        this.SetLanguageText()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        this.scrollView:Clear(false)
        UIScrollView.ClearItem("BuffGroupViewModel")
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()




end


this.InitParameter = function()
    this.isCanGoto = false

    this.isPreview = this.vm.behaviour.Params[0]
    this.level_1 = this.vm.behaviour.Params[1]
    this.level_2 = this.vm.behaviour.Params[2]
    this.callBack = this.vm.behaviour.Params[3]

    this.GetBuffConfig()

    this.cacheBuff = this.GetNowBuff()
    if not this.isPreview then
        this.InitLevelSprite()
        this.CalculateBuffCount()
        if  this.autoCount > 0 or this.buffCount > 0 then
            this.labelType = 1
        else
            this.labelType = 2
        end
        this.isChoose = this.autoCount <= 0 and (this.buffCount > 0 or this.deBuffCount > 0)
    else

        this.labelType = 1
        this.isChoose = false
    end
    this.InitViewState()
    this.SwitchViewState()

    if not this.isPreview then
        if this.autoCount > 0 then
            this.AutoChooseBuff()
            this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7135"].NameLan),this.autoCount)
        else
            if this.playerChooseCount < this.buffCount then
                this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7110"].NameLan),this.buffCount)
            elseif this.deBuffChooseCount < this.deBuffCount then
                this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7111"].NameLan),this.deBuffCount)
            end
        end
    end
end

this.InitLevelSprite = function()
    this.vm.data.levelIcon_1 = LuaMgr.GetSprite("AreaMapRes",this.GetRating(this.level_1))
    this.vm.data.levelIcon_2 = LuaMgr.GetSprite("AreaMapRes",this.GetRating(this.level_2))
end



this.CalculateBuffCount = function()
    this.autoCount,this.buffCount,this.deBuffCount = 0,0,0
    this.autoChooseCount = 0
    this.playerChooseCount = 0
    this.deBuffChooseCount = 0
    local levelList = {this.level_1,this.level_2}
    for i = 1, #levelList do
        if levelList[i] == 1 then
            this.deBuffCount = this.deBuffCount + 1
        elseif levelList[i] == 2 then
            this.autoCount = this.autoCount + 1
        elseif levelList[i] == 3 then
            this.buffCount = this.buffCount + 1
        end
    end
    this.UpdateBuffCount()
end

this.UpdateBuffCount = function()
    local str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7113"].NameLan)
    local count = this.autoChooseCount + this.playerChooseCount
    this.vm.data.add_text = str..string.format(this.formatCount,count,this.autoCount + this.buffCount)
    str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7114"].NameLan)
    count = this.deBuffChooseCount
    this.vm.data.subtract_text = str..string.format(this.formatCount,count,this.deBuffCount)
end


this.AutoChooseBuff = function()
    this.isChoose = false
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    local indexList = this.ListShuffle()
    local indexRow,indexColu = nil,nil
    this.coroutine_key = coroutine_runner.start(function()
        coroutine_runner.wait(0.3)
        for i = 1, #indexList do
            indexRow = math.ceil(indexList[i] / 3)
            indexColu = indexList[i] % 3 == 0 and 3 or indexList[i] % 3
            for j = 1, 3 do
                for k = 1, 3 do
                    if j == indexRow and k == indexColu then
                        this.scrollView.itemMap[j].itemList[k]:OpenChoose()
                    else
                        if this.scrollView.itemMap[j] ~= nil then
                            if this.scrollView.itemMap[j].itemList[k] ~= nil then
                                this.scrollView.itemMap[j].itemList[k]:CloseChoose()
                            end
                        end
                    end
                end
            end
            coroutine_runner.wait(0.15)
        end
        coroutine_runner.wait(0.2)

        this.scrollView.itemMap[indexRow].itemList[indexColu]:OpenLock()
        this.scrollView.itemMap[indexRow].itemList[indexColu].auto = true
        this.tableInsert(this.cacheBuff[1],this.scrollView.dataList[indexRow].data.buff[indexColu].Id)
        this.autoChooseCount = this.autoChooseCount + 1
        this.UpdateBuffCount()
        if this.autoChooseCount < this.autoCount then
            this.AutoChooseBuff()
        else
            this.vm.data.confirmObj = true
        end
    end)
end
this.ListShuffle = function()
    local list = {}
    local isContain = false
    for i = 1, #this.buffList[1] do
        isContain = this.CacheBuffContain(this.buffList[1][i].Id)
        if not isContain then
            this.tableInsert(list,i)
        end
    end
    local maxIndex = #list
    local index = nil
    local length = 100
    math.randomseed(tostring(os.time()):reverse():sub(1, 9))
    while length > 0 do
        index = math.random(1,maxIndex)
        if list[index] ~= nil then
            list[maxIndex],list[index] = list[index],list[maxIndex]
        end
        length = length - 1
    end
    return list
end


this.InitViewState = function()
    this.vm.data.confirmObj = false
    this.vm.data.tip_add = false
    this.vm.data.tip_subtract = false
    this.vm.data.labelObj = this.isPreview
    this.vm.data.controlsObj = not this.isPreview
    this.vm.data.closeObj = this.isPreview
end

this.SwitchViewState = function()
    this.vm.data.tip_add = not this.isPreview and this.labelType == 1
    this.vm.data.tip_subtract = not this.isPreview and this.labelType == 2
    this.vm.data.label_add_choose = this.labelType == 1
    this.vm.data.label_subtract_choose = this.labelType == 2
    this.SetBuffViewData()
end

this.SetBuffViewData = function()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    
    local index = 1
    local indexRow = 1
    local tempList = this.buffList[this.labelType]
    if tempList == nil then
        return
    end
    local tempItem = nil
    while (index <= #tempList) do
        groupData = {}
        groupData.item = this.itemTemplate
        groupData.buff = {}
        groupData.indexRow = indexRow
        groupData.call = this.ChooseBuffItem
        groupData.isPreview = this.isPreview
        for i = 1, 3 do
            if tempList[index + i - 1] ~= nil then
                tempItem = tempList[index + i - 1]
                tempItem.lock = this.CacheBuffContain(tempList[index + i - 1].Id)
                this.tableInsert(groupData.buff,tempItem)
            end
        end
        scrollData = UIScrollData.GetData(this.groupTemplate,"BuffGroupViewModel",1040,132 + 15,groupData)
        this.tableInsert(scrollDatas,scrollData)
        index = index + 3
        indexRow = indexRow + 1
    end
    this.scrollView:SetParams(1040,484)
    this.scrollView:SetPadding(0, 0, -10, 0)
    this.scrollView:SetData(scrollDatas, true)
end

this.ConfirmBuff = function()
    this.vm.data.confirmObj = false
    if not this.isCanGoto then
        this.isChoose = true
        if this.buffCount > this.playerChooseCount then

            this.labelType = 1
            this.SwitchViewState()
            this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7110"].NameLan),this.buffCount)
            return
        elseif this.deBuffCount > this.deBuffChooseCount then

            this.labelType = 2
            this.SwitchViewState()
            this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7111"].NameLan),this.deBuffCount)
            return
        else

            this.isCanGoto = true
            this.labelType = 1
            this.vm.data.confirmObj = false
            this.buffCount = this.buffCount + 1
            this.SwitchViewState()
            this.vm.data.tipText = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7112"].NameLan),1)
            this.UpdateBuffCount()
        end
    else

        local buffs = this.GetAllBuff()
        LuaMgr.ShowLuaPanel(UIName.CollectorPracticeBuffResultViewModel,this.level_1,this.level_2,this.callBack,buffs)
        LuaMgr.HidePanel(UIName.CollectorPracticeBuffViewModel)
    end
end


this.ChooseBuffItem = function(type,indexRow,indexColu)
    if not this.isChoose then
        this.OpenTip("7138")
        return
    end
    if type == nil or indexRow == nil or indexColu == nil then return end
    local id = this.scrollView.dataList[indexRow].data.buff[indexColu].Id
    local isContain,i,j = this.CacheBuffContain(id)
    if isContain then
        if type == 1 then
            this.playerChooseCount = this.playerChooseCount - 1
        elseif type == 2 then
            this.deBuffChooseCount = this.deBuffChooseCount - 1
        end
        table.remove(this.cacheBuff[i],j)
        this.scrollView.itemMap[indexRow].itemList[indexColu].auto = nil
        this.scrollView.itemMap[indexRow].itemList[indexColu]:CloseChoose()
    else
        if type == 1 then
            if this.playerChooseCount == this.buffCount then
                this.OpenTip("7136")
                return
            else
                this.playerChooseCount = this.playerChooseCount + 1
            end
        elseif type == 2 then
            if this.deBuffChooseCount == this.deBuffCount then
                this.OpenTip("7136")
                return
            else
                this.deBuffChooseCount = this.deBuffChooseCount + 1
            end
        end
        this.tableInsert(this.cacheBuff[type],id)
        this.scrollView.itemMap[indexRow].itemList[indexColu].auto = false
        this.scrollView.itemMap[indexRow].itemList[indexColu]:OpenChoose()
    end
    if type == 1 then
        this.vm.data.confirmObj = this.playerChooseCount == this.buffCount
    elseif type == 2 then
        this.vm.data.confirmObj = this.deBuffChooseCount == this.deBuffCount
    end
    this.UpdateBuffCount()
end


this.GetNowBuff = function()
    local tempList = {{},{}}
    local tempItem = nil
    if not TableIsNull(DataMgr.Player.practices.buffIds) then
        for i = 1, #DataMgr.Player.practices.buffIds do
            tempItem = ConfigMgr.Config.InternBuffMap[DataMgr.Player.practices.buffIds[i]]
            this.tableInsert(tempList[tempItem.Type],tempItem.Id)
        end
    end
    return tempList
end

this.GetAllBuff = function()
    local tempList = {}
    for i = 1, #this.cacheBuff do
        for j = 1, #this.cacheBuff[i] do
            this.tableInsert(tempList,this.cacheBuff[i][j])
        end
    end
    return tempList
end

this.CacheBuffContain = function(id)
    for i = 1, #this.cacheBuff do
        for j = 1, #this.cacheBuff[i] do
            if this.cacheBuff[i][j] == id then
                return true,i,j
            end
        end
    end
    return false,0,0
end

this.OpenTip = function(langId)
    local str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal[langId].NameLan)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,str)
end

this.GetBuffConfig = function()
    if this.buffList == nil or #this.buffList <= 0 then
        this.buffList = {}
        for key, value in pairs(ConfigMgr.Config.InternBuffMap) do
            if value.MapId == DataMgr.Player.practicesStage.MapId then
                if this.buffList[value.Type] == nil then
                    this.buffList[value.Type] = {}
                end
                this.tableInsert(this.buffList[value.Type],value)
            end
        end
        for key, value in pairs(this.buffList) do
            this.tableSort(value,this.SortBuff)
        end
    end
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