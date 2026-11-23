require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
local objs = {
    maskBtn = {path = "root/Mask", type = UITool.Button},
    itemPrefab = {path = "template/ItemPrefab", type = UITool.GameObject},
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
    itemParent = {path = "root/Middle/ItemParent", type = UITool.Transform},
    productObj = {path = "root/Middle/ProduceGroup/Product", type = UITool.GameObject},
    productTitle = {path = "root/Middle/Title", type = UITool.Text},
    mainTitle = {path = "root/Middle/ProduceGroup/_TitleBG1/Title", type = UITool.Text}
}

local this = {

    cosumeMatItems = {},

    productItem = nil
}

this.before_awake = function()
    for i = 1, 3 do
        local obj = LuaMgr.InstantiateGO(this.itemPrefab, this.itemParent, false)
        local item = SSYXMakeMatItem.New(obj)
        table.insert(this.cosumeMatItems, item)
        SetActive(obj, false)
    end
    this.productItem = SSYXMakeMatItem.New(this.productObj)
end

this.before_active = function()
    this.maxProduceCount = this.itemData.MaxOutputNum
    this.minProduceCount = 1
    this.selectCount = this.minProduceCount
    this.count.text = tostring(this.selectCount)
    local buildData = SSYXData.GetBuildDataByID(this.buildID)
    if buildData.Config.Type == SSYXConst.SceneBuildType.BaseMatProduce then
        this.productTitle.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30010")
        this.mainTitle.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30011")
    else
        this.productTitle.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30014")
        this.mainTitle.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30016")
    end
    this.RefreshItem()
end

this.RefreshItem = function()
    local consumeDatas = this.GetConsumeDatas()
    for i = 1, 3 do
        local consumeData = consumeDatas[i]
        local matItem = this.cosumeMatItems[i]
        if consumeData then
            local ownerNum = SSYXData.GetItemCountByID(consumeData.ID)
            local needCount = consumeData.Count * this.selectCount
            if ownerNum >= needCount then
                consumeData.NumText = string.format("%d/%d", ownerNum, needCount)
            else
                consumeData.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerNum, needCount)
            end
            matItem:SetData(consumeData)
            SetActive(matItem.gameObject, true)
        else
            SetActive(matItem.gameObject, false)
        end
    end
    local productData = this.GetProductData()
    productData.NumText = tostring(productData.Count * this.selectCount)
    this.productItem:SetData(productData)
    local lanText1 = LuaMgr.GetLangText(SSYXConst.LanText.LanText36)
    local totalSecond = this.itemData.OutputTime * this.selectCount
    local h, m, s = GetTimeHMS2(totalSecond)
    local hourText = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27113"), h)
    this.commonText1.text = string.format(lanText1, hourText)

    local lanText2 = LuaMgr.GetLangText(SSYXConst.LanText.LanText37)
    this.commonText2.text = string.format(lanText2, this.selectCount)
    this.SetBtnIconColor(this.addBtn.interactable, this.subBtn.interactable)
end

this.GetProductData = function()
    if this.productData == nil then
        this.productData = table.CopyNoMeta(this.itemData.ContentProduction)
    end
    return this.productData
end

this.GetConsumeDatas = function()
    if this.consumDatas == nil then
        this.consumDatas = {}
        for i = 1, #this.itemData.Consume do
            table.insert(this.consumDatas, table.CopyNoMeta(this.itemData.Consume[i]))
        end
    end
    return this.consumDatas
end

this.OnClickMinCountBtn = function()
    if this.selectCount == this.minProduceCount then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30033")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.selectCount = this.minProduceCount
    this.count.text = tostring(this.selectCount)
    this.subBtn.interactable = false
    this.addBtn.interactable = true
    this.RefreshItem()
end

this.OnClickMaxCountBtn = function()
    if this.selectCount == this.maxProduceCount then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30032")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.selectCount = this.maxProduceCount
    this.count.text = tostring(this.selectCount)
    this.subBtn.interactable = true
    this.addBtn.interactable = false
    this.RefreshItem()
end

this.OnClickSubBtn = function()
    if this.selectCount > 1 then
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

this.OnClickLeftBtn = function()
    LuaMgr.HidePanel(UIName.SSYXProducePopup)
end

this.OnClickRightBtn = function()
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        LuaMgr.HidePanel(UIName.SSYXProducePopup)
        if this.confirmCallback then
            this.confirmCallback()
        end
    end
    local data = {}
    data.BuildId = this.buildID
    data.Choose = this.selectID - 1
    data.Count = this.selectCount
    ApiMgr.Request("operateBuild/startProduce", data, true, onSucc, nil, true)
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
        this.buildID = data.BuildID
        this.itemData = data.ItemData
        this.selectID = data.SelectID
        this.confirmCallback = data.ConfirmCallback
        this.before_active()
    end,
    before_deactive = function(vm)
        this.consumDatas = nil
        this.productData = nil
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