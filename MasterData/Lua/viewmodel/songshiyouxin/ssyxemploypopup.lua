require("ViewModel/SongShiYouXin/SSYXEmployUIInfo")
require("ViewModel/SongShiYouXin/SSYXEmployUIWord")
require("ViewModel/SongShiYouXin/ViewItem/SSYXEmployeeItem")
local objs = {
    employeeItem = {path = "template/EmployeeItem", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    employeeList = {path = "root/Middle/EmployeeList/ScrollView", type = UITool.GameObject},
    employeeInfo = {path = "root/Middle/EmployeeInfo", type = UITool.GameObject},
    wordSelectGroup = {path = "root/Middle/WordSelectGroup", type = UITool.GameObject},
    filterBtn = {path = "root/Right/Group/FilterBtn", type = UITool.Button},
    sortBtn = {path = "root/Right/Group/SortBtn", type = UITool.Button},
    arrowIcon = {path = "root/Right/Group/SortBtn/ArrowIcon", type = UITool.Transform},
    messgeBox = {path = "root/Middle/MessgeBox", type = UITool.GameObject},
    msgBoxContent = {path = "root/Middle/MessgeBox/MsgContent", type = UITool.Text},
    msgBoxLeftBtn = {path = "root/Middle/MessgeBox/LeftBtn", type = UITool.Button},
    msgBoxRightBtn = {path = "root/Middle/MessgeBox/RightBtn", type = UITool.Button}
}

local this = {
    listWidth = 0
}

this.before_awake = function()
    this.employeeListUI = UIScrollView.New(this.employeeList)
    this.employeeInfoUI = SSYXEmployUIInfo.New(this.employeeInfo)
    this.wordSelectUI = SSYXEmployUIWord.New(this.wordSelectGroup)
    this.listWidth = LuaMgr.ScreenWidth()
end

this.before_active = function()
    SetActive(this.messgeBox, false)
    SetActive(this.employeeListUI.gameObject, true)
    SetActive(this.employeeInfoUI.gameObject, false)
    SetActive(this.wordSelectGroup.gameObject, false)
    local allDatas = SSYXData.GetAllSelectWordEmployeeDatas()
    this.RefefreshEmployeeList(allDatas)
end

this.OnSelectWorldEvent = function()
    local allDatas = SSYXData.GetAllSelectWordEmployeeDatas()
    this.RefefreshEmployeeList(allDatas)
end

this.RefefreshEmployeeList = function(allDatas)
    if allDatas == nil then
        allDatas = SSYXData.GetAllWordEmployeeDatas()
    end
    this.allEmployeeDatas = allDatas
    for key, data in pairs(this.allEmployeeDatas) do
        data.CanAddition = this.CheckCanAddition(data)
    end
    local isAscend = this.arrowIcon.localEulerAngles.z == 0
    if isAscend then
        table.sort(this.allEmployeeDatas, SSYXData.SortEmployeeDescendingByRare)
    else
        table.sort(this.allEmployeeDatas, SSYXData.SortEmployeeByRare)
    end
    this.employeeListUI:Clear()
    local scrollDatas = {}
    local itemWidth = 162.5
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickCallback = this.OnClickEmployeeItem
        data.OnEmployeeCallback = this.OnEmployeeCallback
        local scrollData = UIScrollData.GetData(this.employeeItem, "SSYXEmployeeItem", itemWidth, 208, data)
        table.insert(scrollDatas, scrollData)
    end
    this.employeeListUI:SetParams(this.listWidth, 208)
    this.employeeListUI:SetData(scrollDatas, true)
end

this.CheckCanAddition = function(employeeData)
    local canAddition = false
    for key, value in pairs(employeeData.Config.Entry) do
        if this.buildData.WordDic[value] ~= nil then
            canAddition = true
            break
        end
    end
    return canAddition
end



this.OnClickEmployeeItem = function(item)
    this.employeeInfoUI:SetData(item.data)
    if this.buildData.Config.Type == SSYXConst.SceneBuildType.BaseMatProduce then
        this.employeeInfoUI:SetEfficiencyTitle("LangGlobalLan_LangGlobal_name_30005")
    else
        this.employeeInfoUI:SetEfficiencyTitle("LangGlobalLan_LangGlobal_name_30006")
    end
    SetActive(this.employeeInfo, true)
    if this.wordSelectGroup.gameObject.activeSelf == true then
        SetActive(this.wordSelectGroup.gameObject, false)
    end
end

this.OpenMsgBox = function(content, callBack)
    SetActive(this.messgeBox, true)
    this.msgBoxContent.text = content
    this.OnMsgBoxConfirm = callBack
end



this.OnEmployeeCallback = function(item)
    this.lastEmployeeData = nil
    local employeeData = item.data
    if this.IsSelectSameEmployee(employeeData.ID) == true then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText26)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local gridIsEnough = this.EmployeeGridIsEnough()
    local callBack = nil
    if gridIsEnough == false then
        local validIndex = this.GetValidEmployeeGridIndex()
        this.lastEmployeeData = this.employeeDatas[validIndex].EmployingData
        callBack = function()
            local data = {}
            data.Employees = {}
            data.Employees[employeeData.ID] = this.buildData.ID
            data.Employees[this.lastEmployeeData.ID] = ""
            this.RequestEmployees(data)
        end
    else
        callBack = function()
            local data = {}
            data.Employees = {}
            data.Employees[employeeData.ID] = this.buildData.ID
            this.RequestEmployees(data)
        end
    end
    if this.isProduce == true then
        SetActive(this.employeeInfoUI.gameObject, false)
        local content = LuaMgr.GetLangText(SSYXConst.LanText.LanText29)
        this.OpenMsgBox(content, callBack)
    else
        callBack()
    end
end

this.RequestEmployees = function(data)
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        this.isProduce = SSYXData.GetIsMaking(this.buildData)
        local allDatas = SSYXData.GetAllSelectWordEmployeeDatas()
        this.RefefreshEmployeeList(allDatas)
        this.RefreshEmployeeDatas()
        LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXSelectEmployeeSucc)
        SetActive(this.employeeInfoUI.gameObject, false)
    end
    ApiMgr.Request("operateBuild/employees", data, true, onSucc, nil, true)
end

this.RefreshEmployeeDatas = function()
    this.employingDatas = SSYXData.GetEmployingDatas(this.buildData.ID)
    local datas = {}
    local curUnlockNum = this.EmployeeGridIsUnlock()
    for i = 1, 3 do
        local data = {}
        data.Index = i
        data.EmployingData = this.employingDatas[i]
        data.IsEmploying = data.EmployingData ~= nil
        data.IsUnlock = i <= curUnlockNum
        data.OnClickGridCallback = this.OnClickGridCallback
        table.insert(datas, data)
    end
    this.employeeDatas = datas
end

this.EmployeeGridIsUnlock = function()
    local curUnlockNum = 0
    local employmentQuantity = this.buildData.Config.EmploymentQuantity
    for i = 1, this.buildData.Level do
        curUnlockNum = curUnlockNum + employmentQuantity[i]
    end
    return curUnlockNum
end

this.EmployeeGridIsEnough = function()
    for i = 1, #this.employeeDatas do
        local employeeData = this.employeeDatas[i]
        if employeeData.IsUnlock == true and employeeData.EmployingData == nil then
            return true
        end
    end
    return false
end

this.IsSelectBeemploy = function(id)
    return this.IsSelectSameEmployee(id)
end

this.IsSelectSameEmployee = function(id)
    for i = 1, #this.employeeDatas do
        local employeeData = this.employeeDatas[i]
        if employeeData.EmployingData ~= nil and employeeData.EmployingData.ID == id then
            return true
        end
    end
    return false
end

this.GetValidEmployeeGridIndex = function()
    for i = 1, #this.employeeDatas do
        local employeeData = this.employeeDatas[i]
        if i == this.selectGridIndex and employeeData.IsUnlock == true then
            return i
        end
    end

    for i = 1, #this.employeeDatas do
        local employeeData = this.employeeDatas[i]
        if employeeData.IsUnlock == true then
            return i
        end
    end
    return nil
end

this.OnClickFilterBtn = function()
    SetActive(this.wordSelectGroup.gameObject, true)
    this.wordSelectUI:RefreshUI()
    if this.employeeInfo.activeSelf == true then
        SetActive(this.employeeInfo, false)
    end
end

this.OnClickSortBtn = function()
    local isAscend = this.arrowIcon.localEulerAngles.z == 0
    if isAscend then
        this.arrowIcon.localEulerAngles = Vector3(0, 0, 180)
        table.sort(this.allEmployeeDatas, SSYXData.SortEmployeeByRare)
    else
        this.arrowIcon.localEulerAngles = Vector3.zero
        table.sort(this.allEmployeeDatas, SSYXData.SortEmployeeDescendingByRare)
    end
    this.RefefreshEmployeeList(this.allEmployeeDatas)
end

this.OnClickMaskBtn = function()
    if this.employeeInfo.activeSelf == true then
        SetActive(this.employeeInfo, false)
    elseif this.wordSelectGroup.gameObject.activeSelf == true then
        SetActive(this.wordSelectGroup.gameObject, false)
    else
        LuaMgr.HidePanel(UIName.SSYXEmployPopup)
    end
end

this.OnClickMsgBoxLeftBtn = function()
    SetActive(this.messgeBox, false)
end

this.OnClickMsgBoxRightBtn = function()
    if this.OnMsgBoxConfirm ~= nil then
        this.OnMsgBoxConfirm()
        this.OnMsgBoxConfirm = nil
    end
    SetActive(this.messgeBox, false)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.filterBtn, this.OnClickFilterBtn)
        LuaMgr.AddClick(this.sortBtn, this.OnClickSortBtn)
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
        LuaMgr.AddClick(this.msgBoxLeftBtn, this.OnClickMsgBoxLeftBtn)
        LuaMgr.AddClick(this.msgBoxRightBtn, this.OnClickMsgBoxRightBtn)
        LuaMgr.AddUIEventListener(UIEventConst.SSYXSelectWord, this.OnSelectWorldEvent)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        local data = vm.behaviour.Params[0]
        this.employeeDatas = data.EmployeeDatas
        this.buildData = data.BuildData
        this.selectGridIndex = data.Index
        this.isProduce = SSYXData.GetIsMaking(this.buildData)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.filterBtn, this.OnClickFilterBtn)
        LuaMgr.RemoveClick(this.sortBtn, this.OnClickSortBtn)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
        LuaMgr.RemoveClick(this.msgBoxLeftBtn, this.OnClickMsgBoxLeftBtn)
        LuaMgr.RemoveClick(this.msgBoxRightBtn, this.OnClickMsgBoxRightBtn)
        LuaMgr.RemoveUIEventListener(UIEventConst.SSYXSelectWord, this.OnSelectWorldEvent)
        UIScrollView.ClearItem("SSYXEmployeeItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)