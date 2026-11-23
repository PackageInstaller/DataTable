local this = {
    vm = nil,
    data = {
        dungeonRewardList = {}
    },
}

local data={
    taskList = {
        {
            dungeonId = "",
            animaName="";
            name = "",
            getRewardBtn = false,
            progressBtn = false,
            finished = false,
            rewardList = {
                {
                    id = "",
                    count = 0,
                }
            },
        }
    },
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.TrainingTowerStageRewardPopup)
        end
    },
    taskGetRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local askData={DungeonIds = {this.vm.data.taskList[index].dungeonId}}
            ApiMgr.Request("tower2/getStageRewards",askData,true,function(result)
                this.OnGetReward(result);
            end,nil,true);
        end
    },
    taskGetAllRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local dungeonIdList = {}
            for i, v in ipairs(this.vm.data.taskList) do
                if v.status == 1 then
                    table.insert(dungeonIdList, v.dungeonId)
                end
            end
            if #dungeonIdList == 0 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,ConfigMgr.LangGlobal("21119"))
                return
            end
            local askData={DungeonIds = dungeonIdList}
            ApiMgr.Request("tower2/getStageRewards",askData,true,function(result)
                this.OnGetReward(result);
            end,nil,true);
        end
    },
}


local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.data.dungeonRewardList = vm.behaviour.Params[0];
            if #this.data.dungeonRewardList == 0 then
                LuaMgr.HidePanel(UIName.TrainingTowerStageRewardPopup)
                return
            end
            this.ParseData();
        end
    end,
   
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    
    before_destroy=function()
    end
}

this.ParseData = function()
    local towerStageRewards = DataMgr.Player.TowerStageRewards
    local dungeonCfgMap = ConfigMgr.Config.dungeonMap
    local list = {}
    for i, v in ipairs(this.data.dungeonRewardList) do
        local dungeonId = v.dungeonId
        local dungeonCfg = dungeonCfgMap[dungeonId]
        local itemRare = ConfigMgr.Config.itemMap[v.reward.id].rare
        local taskItem = {
            id = dungeonCfg.id,
            dungeonId = dungeonId,
            animaName="";
            name = LuaMgr.GetLangText(dungeonCfg.NameLan),
            getRewardBtn = towerStageRewards[dungeonId] ~= nil and towerStageRewards[dungeonId],
            progressBtn = towerStageRewards[dungeonId] == nil,
            finished = towerStageRewards[dungeonId] ~= nil and not towerStageRewards[dungeonId],
            rewardList = {},
        }
        table.insert(taskItem.rewardList, ConfigHelper.CreateGoodsItem(v.reward.id, v.reward.count,0.5,true,true))
        if taskItem.getRewardBtn then
            taskItem.status = 1
        elseif taskItem.progressBtn then
            taskItem.status = 2
        elseif taskItem.finished then
            taskItem.status = 3
        end
        table.insert(list, taskItem)
    end
    table.sort(list, function(a, b)
        if a.status ~= b.status then
            return a.status < b.status
        end
        return a.id<b.id
    end)
    this.vm.data.taskList = list
end

this.OnGetReward=function(result)
    local re=json.decode(result);
    local data=json.encode(re.result.Rewards);
    LuaMgr.ShowItemRewared(data);

    TrainingTowerHelper.GetTowerStageRewardsRedCount(function(trainingTowerRed)
        RedMgr.Singleton:UpdateClientRedData("15101", trainingTowerRed);
        RedMgr.Singleton:Refresh();
    end)
    
    this.ParseData()
end

return vm({
    data = data,
    command = command,
    hook = hook
})