require("Parkour/ParkourLevelItem")

local this = {
    scrollView = nil,
    scrollWidth = 0,
    levelIndex = 0,
    levelDatas = nil,
};

local objs = {

    levelItem = { path = "template/LevelItem", type = "GameObject" },
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
};


this.SetData = function()
    this.SetLevelList();
end


this.GetLevelList = function()
    local list = {};
    local parkourLevelMap = ConfigMgr.Config.DHParkourLevelMap;
    for _, v in pairs(parkourLevelMap) do
        table.insert(list, v);
    end
    table.sort(list, this.OnLevelSort);
    return list;
end


this.OnLevelSort = function(a, b)
    return string.lower(a.LevelID) < string.lower(b.LevelID);
end


this.SetLevelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    this.scrollWidth = 1280 + addWidth;
    this.scrollView:Clear(false);
    local level;
    local scrollData;
    local scrollDatas = {};
    local len = #this.levelDatas;
    local index = 0;
    for i = 1, len do
        level = this.levelDatas[i];
        scrollData = UIScrollData.GetData(this.levelItem, "ParkourLevelItem", 333, 428, {config=level, num=i});
        table.insert(scrollDatas, scrollData);
        if (index == 0 and this.IsUnlock(level) and not this.IsPass(level)) then
            index = i;
        end
    end
    this.scrollView:SetParams(this.scrollWidth, 500);
    this.scrollView:SetPadding(67, 0, 0, 0);
    this.scrollView:SetData(scrollDatas, true);
    if (this.levelIndex > 0) then
        this.scrollView:MoveToIndex(this.levelIndex);
    else
        this.scrollView:MoveToIndex(index);
    end
end


this.IsUnlock = function(level)
    if (level.UnlockType == 1) then
        if (IsNullOrEmpty(level.Unlock_1)) then return true end

        local status = DataMgr.Player.DunHuang.ParkourMap[level.Unlock_1];
        return not IsNull(status) and status == 1;
    elseif (level.UnlockType == 2) then
        return LuaMgr.Timestamp() > level.Unlock_2;
    end
    return true;
end


this.IsPass = function(level)
    local status = DataMgr.Player.DunHuang.ParkourMap[level.LevelID];
    return not IsNull(status) and status == 1;
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        this.levelDatas = this.GetLevelList();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.RemoveNormalPanel(UIName.ParkourViewModel);
        LuaMgr.RemoveNormalPanel(UIName.ParkourResultViewModel);
        this.SetData();
    end,
    before_deactive = function(vm)
        this.showList = nil;
        this.scrollView:Clear(true);
    end,
    before_destroy = function()
        UIScrollView.ClearItem("ParkourLevelItem");
        this.levelDatas = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})