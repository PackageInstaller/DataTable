require("ViewModel/TeamTower/TeamTowerRewardItem")
local this = 
{
    vm = nil,
    RewardScrollView = nil,
    RewardItemTemplate = nil,
    GoodsItemTemplate = nil,
    rewardList = {},
}
local data =
{
    
}

local command = {
    GetAllCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local ids = {};
            for i, v in pairs(TeamTowerMgr.GetTeamTowerData().Reward) do
                if v == 0 then
                    table.insert(ids,i)
                end
            end
            if #ids > 0 then
                TeamTowerMgr.GetReward(ids,this.GetRewardSuccess,nil);
            end
        end
    },
    CloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.TeamTowerRewardPopUp)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.RewardScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
        this.RewardItemTemplate = vm.behaviour.transform:Find("template/RewardItem").gameObject
        this.GoodsItemTemplate = vm.behaviour.transform:Find("template/GoodsItem").gameObject
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.RefreshView()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("TeamTowerRewardItem")
    end
}

this.RefreshView = function()
    this.RewardScrollView:Clear(false)
    local scrollData, scrollDatas = {}, {}
    local curFloor = tonumber(TeamTowerMgr.GetCurChallengeTowerId())
    local configs = ConfigMgr.Config.TeamTowerFloorMap;
    for i, v in pairs(configs) do
        if not IsNull(v.Reward) and #v.Reward > 0 then
            local floor = tonumber(v.Id)
            local data = {
                rewardState = floor >= curFloor and 0.5 or TeamTowerMgr.GetRewardState(v.Id),
                config = v,
                success = this.GetRewardSuccess,
                goodItem = this.GoodsItemTemplate
            }
            scrollData = UIScrollData.GetData(this.RewardItemTemplate, "TeamTowerRewardItem", 756, 84, data)
            table.insert(scrollDatas, scrollData)
        end
    end
    table.sort(scrollDatas, function(a, b)
        if a.data.rewardState == b.data.rewardState then
            return tonumber(a.data.config.Id) < tonumber(b.data.config.Id)
        else
            return a.data.rewardState < b.data.rewardState
        end
    end)
    this.RewardScrollView:SetParams(756, 270)
    this.RewardScrollView:SetData(scrollDatas, true)
end

this.GetRewardSuccess = function(result)
    local re=json.decode(result);
    local data=json.encode(re.result);
    LuaMgr.ShowItemRewared(data);
    this.RefreshView()
    HeroRedDataHelper.CheckTeamTowerRed()
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})