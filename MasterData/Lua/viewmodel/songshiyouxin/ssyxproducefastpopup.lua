require("ViewModel/SongShiYouXin/ViewItem/SSYXProuceMatItem")
local objs = {
    itemPrefab = {path = "template/ItemPrefab", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    title = {path = "root/Middle/Title", type = UITool.Text},
    commonText1 = {path = "root/Middle/CommonText1", type = UITool.Text},
    commonText2 = {path = "root/Middle/CommonText2", type = UITool.Text},
    minCountBtn = {path = "root/Middle/MinCountBtn", type = UITool.Button},
    maxCountBtn = {path = "root/Middle/MaxCountBtn", type = UITool.Button},
    subBtn = {path = "root/Middle/SubBtn", type = UITool.Button},
    addBtn = {path = "root/Middle/AddBtn", type = UITool.Button},
    subBtnIcon = {path = "root/Middle/SubBtn/Icon", type = UITool.Image},
    addBtnIcon = {path = "root/Middle/AddBtn/Icon", type = UITool.Image},
    leftBtn = {path = "root/Middle/LeftBtn", type = UITool.Button},
    rightBtn = {path = "root/Middle/RightBtn", type = UITool.Button},
    count = {path = "root/Middle/Count", type = UITool.Text},
    itemParent = {path = "root/Middle/ItemParent", type = UITool.Transform}
}

local this = {

    fastProduceItems = {},

    lastSelectedItem = nil
}

this.before_awake = function()
    for i = 1, 4 do
        local item = LuaMgr.InstantiateGO(this.itemPrefab, this.itemParent, false)
        table.insert(this.fastProduceItems, SSYXProuceMatItem.New(item))
    end
    this.commonLanStr1 = LuaMgr.GetLangText(SSYXConst.LanText.LanText51)
    this.commonLanStr2 = LuaMgr.GetLangText(SSYXConst.LanText.LanText52)
end

this.before_active = function()
    this.maxProduceCount = 0
    this.minProduceCount = 0
    this.title.text = this.msgBoxTitle
    local datas = this.GetAllItemData()
    if #datas ~= #this.fastProduceItems then
        LuaDebug.error("this.RefreshItem 数据错误 32")
    end
    for i = 1, #datas do
        local item = this.fastProduceItems[i]
        local data = datas[i]
        data.NumText = string.format("%d/%s", 0, LuaMgr.NumFormat(data.Count))
        data.OnSelectItem = this.OnSelectItem
        item:SetData(data)
        item:SetSelectFlag(false)
    end
    this.selectCount = 0
    this.commonText1.text = ""
    this.commonText2.text = ""
    this.RefreshUI()
end

this.RefreshUI = function()
    this.count.text = tostring(this.selectCount)
    if this.maxProduceCount == this.minProduceCount then
        this.addBtn.interactable = false
        this.maxCountBtn.interactable = false
        this.subBtn.interactable = false
        this.minCountBtn.interactable = false
    else
        if this.selectCount == this.maxProduceCount then
            this.addBtn.interactable = false
            this.maxCountBtn.interactable = false
            this.subBtn.interactable = true
            this.minCountBtn.interactable = true
        elseif this.selectCount == this.minProduceCount then
            this.addBtn.interactable = true
            this.maxCountBtn.interactable = true
            this.subBtn.interactable = false
            this.minCountBtn.interactable = false
        else
            this.addBtn.interactable = true
            this.maxCountBtn.interactable = true
            this.subBtn.interactable = true
            this.minCountBtn.interactable = true
        end
    end
    this.SetBtnIconColor(this.addBtn.interactable, this.subBtn.interactable)
end

this.SetBtnIconColor = function(addInterActable, subInteractable)
    if addInterActable == true then
        this.addBtnIcon.color = UnityEngine.Color(1, 1, 1, 1)
    else
        local tempValue = 200 / 255
        this.addBtnIcon.color = UnityEngine.Color(tempValue, tempValue, tempValue, 128 / 255)
    end

    if subInteractable == true then
        this.subBtnIcon.color = UnityEngine.Color(1, 1, 1, 1)
    else
        local tempValue = 200 / 255
        this.subBtnIcon.color = UnityEngine.Color(tempValue, tempValue, tempValue, 128 / 255)
    end
end

this.RefreshItem = function()
    this.commonText1.text = ""
    this.commonText2.text = ""
    if this.lastSelectedItem == nil then
        return
    end
    local data = this.lastSelectedItem.data
    if data.IsInBag == true then
        local constConfig = ConfigMgr.Config.OperateConstants.CompleteImmediately1[1]
        data.NumText = string.format("%d/%s", this.selectCount * constConfig.count, LuaMgr.NumFormat(data.Count))
    else
        data.NumText = string.format("%d/%s", this.selectCount, LuaMgr.NumFormat(data.Count))
    end
    this.lastSelectedItem:SetData(data)
    this.RefreshUI()
    local h, _, _ = GetTimeHMS2(this.singleCanFastTime)
    this.commonText1.text = string.format(this.commonLanStr1, h * this.selectCount, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23715"))
    local productCount = math.floor(this.selectCount * this.singleCanFastTime / this.singleOutputTime)
    this.commonText2.text = string.format(this.commonLanStr2, productCount)
end

this.GetAllItemData = function()
    local datas = {}
    for i = 1, 3 do
        local id = tostring(27 + i)
        local data = {}
        data.ID = id
        data.Count = SSYXData.GetItemCountByID(id)
        data.IsInBag = false
        table.insert(datas, data)
    end

    local constConfig = ConfigMgr.Config.OperateConstants.CompleteImmediately1[1]
    local id = constConfig.id
    local data = {}
    data.ID = id
    data.Count = DataHelper.GetItemCountById(id)
    data.IsInBag = true
    data.Scale = Vector3(0.78, 0.78, 0)
    table.insert(datas, data)
    return datas
end



this.OnSelectItem = function(item)
    if this.lastSelectedItem ~= nil then
        this.lastSelectedItem:SetSelectFlag(false)
        this.lastSelectedItem.data.NumText = string.format("0/%d", this.lastSelectedItem.data.Count)
        this.lastSelectedItem:SetData(this.lastSelectedItem.data)
    end
    this.lastSelectedItem = item
    this.lastSelectedItem:SetSelectFlag(true)
    local curTime = LuaMgr.Timestamp()
    local buildData = this.buildData
    local makingIndex = buildData.ServerData.ProduceChoose or 0
    local allProductDatas = SSYXData.GetProductDatas(buildData.ID)
    local makingData = allProductDatas[makingIndex + 1]
    local startProduceTime = buildData.ServerData.ProduceTime or 0
    local remainProductTime = makingData.OutputTime * (buildData.ServerData.ProduceCount - 1)
    remainProductTime = math.max(remainProductTime, 0)
    local extraCdAdd = buildData.ServerData.ExtraCdAdd ~= nil and buildData.ServerData.ExtraCdAdd / 10000 or 0
    local singleSubTime = math.floor(makingData.OutputTime * extraCdAdd)
    local totalSubTime = buildData.ServerData.ProduceCount * singleSubTime
    local remainTime = makingData.OutputTime + startProduceTime - curTime + remainProductTime - totalSubTime
    this.singleRemainTime = makingData.OutputTime - singleSubTime
    this.singleOutputTime = makingData.OutputTime
    local itemData = this.lastSelectedItem.data
    local itemConfig = SSYXData.GetItemConfig(itemData.ID)
    local constConfig = ConfigMgr.Config.OperateConstants.CompleteImmediately1[1]
    local constTime = ConfigMgr.Config.OperateConstants.CompleteImmediately2
    if itemData.IsInBag == true then
        this.singleCanFastTime = constTime
    else
        this.singleCanFastTime = itemConfig.Effect
    end
    if itemData.IsInBag == true then
        local canFastCount = math.floor(itemData.Count / constConfig.count)
        if constTime > remainTime then
            this.maxProduceCount = 1
        else
            this.maxProduceCount = math.ceil(remainTime / constTime)
        end
        this.maxProduceCount = math.min(canFastCount, this.maxProduceCount)
    else
        if itemConfig.Effect > remainTime then
            this.maxProduceCount = 1
        else
            this.maxProduceCount = math.ceil(remainTime / itemConfig.Effect)
        end
        this.maxProduceCount = math.min(this.maxProduceCount, itemData.Count)
    end

    this.selectCount = 0
    this.commonText1.text = string.format(this.commonLanStr1, 0, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_23715"))
    this.RefreshUI()
end

this.OnClickMinCountBtn = function()
    this.selectCount = this.minProduceCount
    this.count.text = tostring(this.selectCount)
    this.RefreshItem()
end

this.OnClickMaxCountBtn = function()
    this.selectCount = this.maxProduceCount
    this.count.text = tostring(this.selectCount)
    this.RefreshItem()
end

this.OnClickSubBtn = function()
    if this.selectCount > 0 then
        this.selectCount = this.selectCount - 1
        this.count.text = tostring(this.selectCount)
    end
    if this.selectCount == this.minProduceCount then
        this.subBtn.interactable = false
    end
    this.addBtn.interactable = true
    this.RefreshItem()
end

this.OnClickAddBtn = function()
    if this.selectCount < this.maxProduceCount then
        this.selectCount = this.selectCount + 1
        this.count.text = tostring(this.selectCount)
    end
    if this.selectCount == this.maxProduceCount then
        this.addBtn.interactable = false
    end
    this.subBtn.interactable = true
    this.RefreshItem()
end

this.OnClickLeftBtn = function()
    LuaMgr.HidePanel(UIName.SSYXProduceFastPopup)
end

this.OnClickRightBtn = function()
    if this.lastSelectedItem == nil then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText40)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.selectCount == 0 then
        return
    end
    local id = this.lastSelectedItem.data.ID
    local useTyp = this.lastSelectedItem.data.IsInBag == true and 1 or 0
    local count = this.selectCount
    local typ = this.fastType
    local extraID = this.extraID
    this.ConfirmCallback = function()
        if this.confirmCallback ~= nil then
            this.confirmCallback()
        end
        LuaMgr.HidePanel(UIName.SSYXProduceFastPopup)
    end
    SSYXData.UseItem(id, useTyp, count, typ, extraID, this.ConfirmCallback)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskBtn, this.OnClickLeftBtn)
        LuaMgr.AddClick(this.minCountBtn, this.OnClickMinCountBtn)
        LuaMgr.AddClick(this.maxCountBtn, this.OnClickMaxCountBtn)
        LuaMgr.AddClick(this.subBtn, this.OnClickSubBtn)
        LuaMgr.AddClick(this.addBtn, this.OnClickAddBtn)
        LuaMgr.AddClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.AddClick(this.rightBtn, this.OnClickRightBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        local data = vm.behaviour.Params[0]
        this.buildData = data.BuildData
        this.fastType = data.FastType
        if this.fastType == 1 then
            this.extraID = data.OrderID
        else
            this.extraID = data.BuildID
        end
        this.msgBoxTitle = data.MsgBoxTitle or ""
        this.confirmCallback = data.ConfirmCallback
        this.singleNeedTime = data.NeedTime
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickLeftBtn)
        LuaMgr.RemoveClick(this.minCountBtn, this.OnClickMinCountBtn)
        LuaMgr.RemoveClick(this.maxCountBtn, this.OnClickMaxCountBtn)
        LuaMgr.RemoveClick(this.subBtn, this.OnClickSubBtn)
        LuaMgr.RemoveClick(this.addBtn, this.OnClickAddBtn)
        LuaMgr.RemoveClick(this.leftBtn, this.OnClickLeftBtn)
        LuaMgr.RemoveClick(this.rightBtn, this.OnClickRightBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)