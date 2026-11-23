require("GuoBao/GuoBaoRewardItem")

local this = {
    rewardsList = nil,
};

local objs = {
    container = { path = "root/Middle/Container", type = "Transform" },
    rewardItem = { path = "template/RewardItem", type = "GameObject" },
    rewardsSVContent = { path = "root/Middle/Rewards/ScrollView/Viewport/Content", type = "RectTransform" },
    rewardsNone = { path = "root/Middle/Rewards/None", type = "GameObject" },
    rewardsReceiveGO = { path = "root/Middle/Rewards/Receive", type = "GameObject" },
    rewardsReceiveBtn = { path = "root/Middle/Rewards/Receive", type = "Button" },
    rewardsReceiveLockGO = { path = "root/Middle/Rewards/ReceiveLock", type = "GameObject" },
    rewardsReceiveLockBtn = { path = "root/Middle/Rewards/ReceiveLock", type = "Button" },
    fzqkBtn = { path = "root/Left/FZQK", type = "Button" },
    fzqkTimeGO = { path = "root/Left/FZQK/Time", type = "GameObject" },
    fzqkTime = { path = "root/Left/FZQK/Time/Text", type = "Text" },
    bzssBtn = { path = "root/Left/BZSS", type = "Button" },
    brjnBtn = { path = "root/Left/BRJN", type = "Button" },
    brjnTimeGO = { path = "root/Left/BRJN/Time", type = "GameObject" },
    brjnTime = { path = "root/Left/BRJN/Time/Text", type = "Text" },
    brjnNew = { path = "root/Left/BRJN/New", type = "GameObject" },
    sxyzBtn = { path = "root/Left/SXYZ", type = "Button" },
    sxyzTimeGO = { path = "root/Left/SXYZ/Time", type = "GameObject" },
    sxyzTime = { path = "root/Left/SXYZ/Time/Text", type = "Text" },
};


this.OnBack = function()
    GuoBaoMgr.SetFirstPage(false);
    LuaMgr.GoToHome(UIName.GuoBaoMainViewModel, nil, false);
end


this.SetData = function()
    GuoBaoScene.SetBuildings();
    GuoBaoScene.SetBuildingInfos(this.container);
    this.SetRewards();
    LuaMgr.AddTimer(TimerConst.GuoBaoSceneTime, this.OnSceneTime, 1, -1, true);
end


this.OnSceneTime = function()
    this.SetFZQKTime();
    this.SetBRJNTime();
    this.SetSXYZTime();
end


this.SetFZQKTime = function()
    local variable = DataMgr.Player.variables["group.3021"];
    if (variable ~= nil) then
        local time = variable.startTime - LuaMgr.Timestamp();
        if (time > 0) then
            local d,h,m = GetTimeDHM(time);
            local timeStr = "";
            if (not IsNullOrEmpty(d)) then
                timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
            else
                if (not IsNullOrEmpty(h)) then
                    timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
                end
                if (not IsNullOrEmpty(m)) then
                    timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
                end
            end
            this.fzqkTime.text = timeStr .. LuaMgr.GetLangText("GuoBaoViewModel_0");
            SetActive(this.fzqkTimeGO, true);
            return;
        end
    end
    SetActive(this.fzqkTimeGO, false);
end


this.SetBRJNTime = function()
    local time = ConfigGuoBaoMgr.GetEventUnlockTime(2);
    if (time > 0) then
        local d,h,m = GetTimeDHM(time);
        local timeStr = "";
        if (not IsNullOrEmpty(d)) then
            timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
        else
            if (not IsNullOrEmpty(h)) then
                timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
            end
            if (not IsNullOrEmpty(m)) then
                timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
            end
        end
        this.brjnTime.text = timeStr .. LuaMgr.GetLangText("GuoBaoViewModel_1");
        SetActive(this.brjnTimeGO, true);
        SetActive(this.brjnNew, false);
    else
        SetActive(this.brjnTimeGO, false);
        SetActive(this.brjnNew, PlayerGuoBaoMgr.IsPaintingNew());
    end
end


this.SetSXYZTime = function()
    local time = ConfigGuoBaoMgr.GetEventUnlockTime(3);
    if (time > 0) then
        local d,h,m = GetTimeDHM(time);
        local timeStr = "";
        if (not IsNullOrEmpty(d)) then
            timeStr = timeStr .. string.format("%s%s", d, ConfigMgr.LangGlobal("10365"));
        else
            if (not IsNullOrEmpty(h)) then
                timeStr = timeStr .. string.format("%s%s", h, ConfigMgr.LangGlobal("10366"));
            end
            if (not IsNullOrEmpty(m)) then
                timeStr = timeStr .. string.format("%s%s", m, ConfigMgr.LangGlobal("10367"));
            end
        end
        this.sxyzTime.text = timeStr .. LuaMgr.GetLangText("GuoBaoViewModel_2");
        SetActive(this.sxyzTimeGO, true);
    else
        SetActive(this.sxyzTimeGO, false);
    end
end


this.SetRewards = function()
    this.rewardsList:Clear();
    local rewards = PlayerGuoBaoMgr.GetBuildingRewards();
    local len = #rewards;
    if (len > 0) then
        local listDatas = {};
        for i = 1, len do
            local listData = UIListData.GetData(this.rewardItem, "GuoBaoRewardItem", rewards[i]);
            table.insert(listDatas, listData);
        end
        this.rewardsList:SetData(listDatas);
        SetActive(this.rewardsReceiveGO, true);
        SetActive(this.rewardsReceiveLockGO, false);
        SetActive(this.rewardsNone, false);
    else
        SetActive(this.rewardsReceiveGO, false);
        SetActive(this.rewardsReceiveLockGO, true);
        SetActive(this.rewardsNone, true);
    end
end


this.OnClickReceive = function()
    PlayerGuoBaoMgr.SimulatedShopReward(this.SimulatedShopRewardResponse);
end


this.SimulatedShopRewardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if (not IsNull(data.result)) then
            local reward = json.encode(data.result);
            LuaMgr.ShowItemRewared(reward);
        end
    end
    this.SetRewards();
end


this.OnClickReceiveLock = function()
    
end


this.OnClickFZQK = function()
    if (PlayerGuoBaoMgr.IsFZQKUnlock()) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoDrawViewModel);
    end
end


this.OnClickBZSS = function()
    PlayerGuoBaoMgr.SimulatedShopWishList();
end


this.OnClickBRJN = function()
    if (ConfigGuoBaoMgr.IsEventUnlock(2)) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoPaintingViewModel);
    end
end


this.OnClickSXYZ = function()
    if (ConfigGuoBaoMgr.IsEventUnlock(3)) then
        LuaMgr.ShowLuaPanel(UIName.GuoBaoSupperzzleViewModel);
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.rewardsList = UIListView.New(this.rewardsSVContent);
        LuaMgr.AddClick(this.rewardsReceiveBtn, this.OnClickReceive);
        LuaMgr.AddClick(this.rewardsReceiveLockBtn, this.OnClickReceiveLock);
        LuaMgr.AddClick(this.fzqkBtn, this.OnClickFZQK);
        LuaMgr.AddClick(this.bzssBtn, this.OnClickBZSS);
        LuaMgr.AddClick(this.brjnBtn, this.OnClickBRJN);
        LuaMgr.AddClick(this.sxyzBtn, this.OnClickSXYZ);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.GuoBaoSceneTime);
        this.rewardsList:Clear();
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.rewardsReceiveBtn, this.OnClickReceive);
        LuaMgr.RemoveClick(this.rewardsReceiveLockBtn, this.OnClickReceiveLock);
        LuaMgr.RemoveClick(this.fzqkBtn, this.OnClickFZQK);
        LuaMgr.RemoveClick(this.bzssBtn, this.OnClickBZSS);
        LuaMgr.RemoveClick(this.brjnBtn, this.OnClickBRJN);
        LuaMgr.RemoveClick(this.sxyzBtn, this.OnClickSXYZ);
        GuoBaoScene.ClearBuildingInfos();
        UIListView.ClearItem("GuoBaoRewardItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})