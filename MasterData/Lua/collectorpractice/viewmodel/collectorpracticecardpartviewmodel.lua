



require("CollectorPractice/Common/CollectorCardPartGroup")
require("CollectorPractice/Common/CollectorCardPartItem")
local this = {
    vm = nil,
    cardListData = nil,
    keyList = { "data_1" },
    ListViewData = {},
    content = nil,
    scrollView = nil,
    Rankitem = nil,
    RankGroup = nil,
}
this.GALLERY_PAth = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
this.SelectIndex = nil
local testData = { { id = "101", count = 2 }, { id = "102", count = 2 }, { id = "103", count = 2 }, { id = "104", count = 2 }, { id = "105", count = 2 }, { id = "106", count = 2 } }
local data = {
    Panel = false,
    itemIcon = DefaultTexture,
    itemName = "",
    itemDescription = "",
    itemCount = "",
    CardPartItemList = {
        {
            id = "",
            name = "",
            icon = DefaultTexture,
            select = false,
            titleName = "",
        }

    }

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CollectorPracticeCardPartViewModel)
        end
    },
    closeItemShow = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CollectorPracticeCardPartViewModel)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.FindObject(vm)
    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.cardListData = vm.behaviour.Params[0]
            this.ScrollViewDataList()
            this.SetScrollView()
            if this.content == nil then
                this.FindObject(vm)
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.scrollView:Clear(true)
        end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("CollectorCardPartGroup")
        this.content = nil
        this.scrollView = nil
        this.Rankitem = nil
        this.RankGroup = nil
    end
}

this.Message = function()
    local itemdata = this.itemdata
    if itemdata == nil then
        return
    end
    local configData = ConfigMgr.Config.itemMap[itemdata.id]
    this.vm.data.Panel = true
    this.vm.data.itemIcon = LuaMgr.GetTexture(string.format(this.GALLERY_PAth, itemdata.id))
    this.vm.data.itemName = LuaMgr.GetLangText(configData.nameLan)
    this.vm.data.itemDescription = LuaMgr.GetLangText(configData.DescriptionLan)
    this.vm.data.itemCount = itemdata.count
end

this.FindObject = function(vm)
    this.content = vm.behaviour.transform:Find("root/Middle/CardPartListScroll/Viewport/ActiveContent")
    this.Rankitem = vm.behaviour.transform:Find("template/ConnectFourRankItem").gameObject
    this.RankGroup = vm.behaviour.transform:Find("template/ConnectFourRankGroup").gameObject
    this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/CardPartListScroll").gameObject)

end

this.ScrollViewDataList = function()
    this.ListViewData = {}
    for key, value in pairs(this.cardListData) do
        local telentName = LuaMgr.GetLangText(ConfigMgr.Config.OriginsTalentMap[value.Origins].OtNameLan)
        local goodsName = LuaMgr.GetLangText(value.name);
        local viewData =        {
            id = key,
            TalentName = telentName,
            Name = goodsName
        }
        table.insert(this.ListViewData, viewData)
    end
end


this.SetScrollView = function()
    local RankItemData
    local groupData
    local scrollData
    this.scrollView:Clear(false)
    local scrollDatas = {}
    local len = #this.ListViewData
    local index = 1
    while (index <= len) do
        groupData = {}
        groupData.item = this.Rankitem
        RankItemData = this.ListViewData[index]
        if (RankItemData ~= nil) then
            groupData[this.keyList[1]] = RankItemData
        end
        scrollData = UIScrollData.GetData(this.RankGroup, "CollectorCardPartGroup", 270, 432, groupData)
        table.insert(scrollDatas, scrollData)
        index = index + 1
    end
    this.scrollView:SetParams(1130, 460)
    this.scrollView:SetData(scrollDatas, true)
end
return vm({
    data = data,
    command = command,
    hook = hook
})