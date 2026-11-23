require("ViewModel/ZhiXiangLiu/ViewItem/ZXLChooseItemGroup")

local objs = {
    groupItem = {path = "template/Group", type = UITool.GameObject},
    matItem = {path = "template/Item", type = UITool.GameObject},
    closeBtn = {path = "root/Mask", type = UITool.Button},
    maskCloseBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    cancelBtn = {path = "root/Middle/ChooseGroup/CancelBtn", type = UITool.Button},
    confirmBtn = {path = "root/Middle/ChooseGroup/ConfirmBtn", type = UITool.Button},
    chooseDesc = {path = "root/Middle/ChooseGroup/Desc", type = UITool.Text},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this.RefreshMatList()
    this.RefreshChooseCount()
end

this.RefreshMatList = function()
    this.scrollViewUI:Clear(false)
    local itemLen
    local scrollDatas = {}
    this.allDatas = ZXLData.GetAllGlassMatDatas()
    local len = #this.allDatas
    local index = 0
    local choosedDataDic = ZXLData.GetTempChoosedMatDatas()
    while index < len do
        itemLen = index + 4 > len and len - index or 4
        local groupData = {}
        groupData.item = this.matItem
        groupData.list = {}
        for i = 1, itemLen do
            if i + index <= len then
                local tempData = this.allDatas[i + index]
                tempData.isChoosed = choosedDataDic[tempData.ID] ~= nil
                tempData.clickCallback = this.OnClickItemCallback
                table.insert(groupData.list, tempData)
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen
        local scrollData = UIScrollData.GetData(this.groupItem, "ZXLChooseItemGroup", 830, 192, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollViewUI:SetParams(830, 296)
    this.scrollViewUI:SetData(scrollDatas, true)
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.ZXLGlassChooseMatPopup)
    ZXLData.ClearTempChoosedMatData()
end

this.OnClickCancelBtn = function()
    this.OnClickCloseBtn()
end

this.OnClickConfirmBtn = function()
    if this.closeCallback ~= nil then
        local choosedDataDic = ZXLData.GetTempChoosedMatDatas()
        local goalGlassData = ZXLData.GetGlassGoalByMat(choosedDataDic)
        if goalGlassData ==nil then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29409")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        this.closeCallback(choosedDataDic)
    end
    this.OnClickCloseBtn()
end



this.OnClickItemCallback = function(item)
    local choosedDataCount = NumTool.GetLen(ZXLData.GetTempChoosedMatDatas())
    if item.data.isChoosed == false and choosedDataCount >= 3 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29410")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
    elseif item.data.isChoosed == false then
        item:SetChoosed(true)
        ZXLData.SetTempChoosedMatData(item.data.ID, item.data)
        this.RefreshChooseCount()
    else
        item:SetChoosed(false)
        ZXLData.SetTempChoosedMatData(item.data.ID)
        this.RefreshChooseCount()
    end
end

this.RefreshChooseCount = function ()
    local choosedDataCount = NumTool.GetLen(ZXLData.GetTempChoosedMatDatas())
    local descLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29401")
    this.chooseDesc.text = string.format(descLan, choosedDataCount, 3)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirmBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        local params = vm.behaviour.Params[0]
        this.closeCallback = params.chooseCallback
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirmBtn)
        UIScrollView.ClearItem("ZXLChooseItemGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)