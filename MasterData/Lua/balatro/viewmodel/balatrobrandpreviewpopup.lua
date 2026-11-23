







require("Balatro/ViewModel/BalatroBrandPreviewItem")
local objs = {
    itemTemplete = {path = "template/Prefab", type = BalatroUtil.GameObject},
    exitBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    scrollViewObj = {path = "root/Middle/ScrollView", type = BalatroUtil.GameObject},
    scrollViewContent = {path = "root/Middle/ScrollView/Viewport/Content", type = BalatroUtil.Transform},
    titleText = {path = "root/Middle/TitleText", type = BalatroUtil.Text}
}

local this = {
    previewType = BalatroUtil.BrandPreviewType.None,

    allPreviewItems = {}
}

this.before_awake = function()
    LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
    local count = math.max(BalatroConstVal.MaxBalatroBrandCount, BalatroConstVal.MaxPropsBrandCount)
    for i = 1, count do
        local item = BalatroBrandPreviewItem.New(this.itemTemplete, this.scrollViewContent)
        table.insert(this.allPreviewItems, item)
    end
end

this.before_active = function()
    if this.previewType == BalatroUtil.BrandPreviewType.BalatroBrand then
        this.RefreshBalatrData()
    elseif this.previewType == BalatroUtil.BrandPreviewType.PropsBrand then
        this.RefreshPropsData()
    end
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandPreviewPopup)
end

this.RefreshBalatrData = function()
    local text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20039")
    this.titleText.text = text
    local allBrandDatas = BalatroDataMgr.GetUsingBalatroLst()
    if allBrandDatas == nil then
        for i = 1, BalatroConstVal.MaxBalatroBrandCount do
            local item = this.allPreviewItems[i]
            SetActive(item.gameObject, false)
        end
        return
    end
    for i = 1, BalatroConstVal.MaxBalatroBrandCount do
        local item = this.allPreviewItems[i]
        if i <= #allBrandDatas then
            SetActive(item.gameObject, true)
            local data = allBrandDatas[i]
            item:SetData(data, BalatroUtil.BrandPreviewType.BalatroBrand)
        else
            SetActive(item.gameObject, false)
        end
    end
end

this.RefreshPropsData = function()
    local text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20040")
    this.titleText.text = text
    local tempDataDic = BalatroDataMgr.GetPropsBrandDatas()
    if tempDataDic == nil then
        for i = 1, BalatroConstVal.MaxPropsBrandCount do
            local item = this.allPreviewItems[i]
            SetActive(item.gameObject, false)
        end
        return
    end

    local allBrandDatas = {}
    for key, value in pairs(tempDataDic) do
        table.insert(allBrandDatas, value)
    end
    for i = 1, BalatroConstVal.MaxPropsBrandCount do
        local item = this.allPreviewItems[i]
        if i <= #allBrandDatas then
            SetActive(item.gameObject, true)
            local data = allBrandDatas[i]
            item:SetData(data, BalatroUtil.BrandPreviewType.PropsBrand)
        else
            SetActive(item.gameObject, false)
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params and vm.behaviour.Params.Length > 0 then
            this.previewType = vm.behaviour.Params[0].previewType
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        for key, value in pairs(this.allPreviewItems) do
            value:Destroy()
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)