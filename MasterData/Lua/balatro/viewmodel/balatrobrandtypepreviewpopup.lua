







require("Balatro/ViewModel/BalatroBrandTypeItem")
local objs = {
    itemTemplete = {path = "template/BrandTypeItem", type = BalatroUtil.GameObject},
    exitBtn = {path = "root/Middle/ExitBtn", type = BalatroUtil.Button},
    scrollViewObj = {path = "root/Middle/ScrollView", type = BalatroUtil.GameObject},
    scrollViewContent = {path = "root/Middle/ScrollView/Viewport/Content", type = BalatroUtil.Transform}
}

local this = {
    scrollWidth = 844,
    scrollHeight = 444,
    itemHeight = 80
}

this.before_awake = function()
    this.scrollView = UIScrollView.New(this.scrollViewObj)
    LuaMgr.AddClick(this.exitBtn, this.OnClickBack)
end




this.SortBrandType = function(data1, data2)
    return data1:GetSortID() > data2:GetSortID()
end

this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.BalatroBrandTypePreviewPopup)
end

this.before_active = function()
    this.datas = {}
    local orginDatas = BalatroDataMgr.GetBrandTypeDatas()
    for key, value in pairs(orginDatas) do
        table.insert(this.datas, value)
    end
    table.sort(this.datas, this.SortBrandType)
    this.scrollView:Clear(false)
    local scrollDatas = {}
    local index = 1
    for key, value in pairs(this.datas) do
        local data = {}
        data.index = index
        data.brandTypeData = value
        data.clickCallback = this.ShowBrandTypeDetail
        local scrollData = UIScrollData.GetData(this.itemTemplete, "BalatroBrandTypeItem", this.scrollWidth, this.itemHeight, data)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    this.scrollView:SetParams(this.scrollWidth, this.scrollHeight)
    this.scrollView:SetData(scrollDatas, true)
end


this.ShowBrandTypeDetail = function(item)
    if not item then
        print(debug.traceback("this.ShowBrandTypeDetail"))
        return
    end
    local data = item:GetData()
    LuaMgr.ShowLuaPanel(UIName.BalatroBrandTypeDetailPopup, data)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.BalatroIntoCalView, this.OnClickBack)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack)
        this.scrollView:Clear(false)
        UIScrollView.ClearItem("BalatroBrandTypeItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)