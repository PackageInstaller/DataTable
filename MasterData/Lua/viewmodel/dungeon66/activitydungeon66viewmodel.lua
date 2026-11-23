local this = {
    rewardItem = nil,
};

local objs = {
    gotoBtn = { path = "root/Middle/Group/Goto", type = "Button" },
    timeText = { path = "root/Middle/Group/Time/Text", type = "Text" },
    rewardItemTF = { path = "root/Middle/Group/Reward/Item", type = "Transform" },
};


this.SetData = function()
    local summerCamp = DataExHelper.GetDataExByTag(ActivityKey.SummerCamp);
    if (summerCamp == nil) then return end
    
    local time = summerCamp.expireTime - LuaMgr.Timestamp();
    local timeStr = "";
    local d, h, m = GetTimeDHM(time);
    if (not IsNullOrEmpty(d)) then
        timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
    end
    if (not IsNullOrEmpty(h)) then
        timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
    end
    if (not IsNullOrEmpty(m)) then
        timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
    end
    this.timeText.text = string.format(timeStr);
    this.SetReward();
end


this.SetReward = function()
    if (this.rewardItem == nil) then
        this.rewardItem = GoodsDataItem.New(this.rewardItemTF);
    end
    local itemId = "";
    local itemCount = 0;
    local curSeriesId=TrainingCampMgr.GetCurWheelSeriesID();
    local rewardDatas = TrainingCampMgr.GetCampRewards(curSeriesId);
    local len = #rewardDatas;
    for i = 1, len do
        local award = rewardDatas[i].Award;
        if (not IsNull(award) and #award > 0) then
            itemId = award[1].id;
            itemCount = itemCount + award[1].count;
        end
    end
    if (not IsNullOrEmpty(itemId)) then
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemId]);
        itemData.count0 = itemCount;
        this.rewardItem:SetData(1, itemData, 1, false, Vector3(0.56, 0.56, 1));
        this.rewardItem:SetIconBg(false);
    end
end


this.OnClickGoto = function()
    LuaMgr.ShowLuaPanel(UIName.Dungeon66LevelViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.gotoBtn, this.OnClickGoto);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        this.SetData();
    end,
    before_deactive = function(vm)
        if (this.rewardItem ~= nil) then
            this.rewardItem:Clear();
            this.rewardItem = nil;
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.gotoBtn, this.OnClickGoto);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})