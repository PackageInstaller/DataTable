require("ViewModel/SongShiYouXin/ViewItem/SSYXBuildListItem")
local objs = {
    buildItem = {path = "template/BuildItem", type = UITool.GameObject},
    mainBuildToggleObj = {path = "root/Left/ToggleGroup/MainBuildToggle", type = UITool.GameObject},
    makeBuildToggleObj = {path = "root/Left/ToggleGroup/MakeBuildToggle", type = UITool.GameObject},
    buildListObj = {path = "root/Middle/ScrollView", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    addWidth = math.max(addWidth, 78)
    this.screenWidith = LuaMgr.GetScreenWidth() - addWidth
    this.buildListUI = UIScrollView.New(this.buildListObj)
    this.mainBuildToggle = CommonToggleItem.New(this.mainBuildToggleObj, nil, false, 1, this.OnClickToggleCallback)
    this.makeBuildToggle = CommonToggleItem.New(this.makeBuildToggleObj, nil, false, 2, this.OnClickToggleCallback)
    this.curSelectIndex = SSYXConst.MainSceneIndex
    this.mainBuildToggle.toggle.isOn = true
    this.mainBuildToggle:SetIsOn(true)
    RedMgr.Singleton:RegisterViewModel(UIName.SSYXBuildListPanel)
end

this.before_active = function()
    this.RefreshBuildList()
end

this.RefreshBuildList = function()
    this.buildListUI:Clear()
    local scrollDatas = {}
    local itemWidth = 376
    local allDatas = SSYXData.GetAllBuildData(this.curSelectIndex)
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.Index = i
        data.OnClickCreateBtn = this.OnClickCreateBtn
        local scrollData = UIScrollData.GetData(this.buildItem, "SSYXBuildListItem", itemWidth, 508, data)
        table.insert(scrollDatas, scrollData)
    end
    this.buildListUI:SetParams(this.screenWidith, 508)
    this.buildListUI:SetData(scrollDatas, true)
end

this.OnClickToggleCallback = function(index, value)
    if value == true then
        this.curSelectIndex = index
        this.RefreshBuildList()
    end
end



this.OnClickCreateBtn = function(item)
    LuaMgr.Back()
    local data = item.data
    SSYXData.SetBuildTempData(data)
    local func = function()
        LuaMgr.ShowLuaPanel(UIName.SSYXBuildCreatePopup, data)
    end
    LuaMgr.NextFrame(func)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("SSYXBuildListItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)