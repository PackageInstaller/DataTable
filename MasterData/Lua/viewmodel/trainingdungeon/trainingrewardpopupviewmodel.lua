

local color1 = UnityEngine.Color(87/255.0, 98/255.0, 97/255.0, 1)
local color2 = UnityEngine.Color(136/255.0, 141/255.0, 135/255.0, 1)


local this = {
    vm=nil,
    data= {
        seriesID = "",
        curSelectType = 1,
        starRewardList = {},
        dungeonRewardList = {},
        isSendRequest = false,
    }
};

local data = {
    seriesName = "",
    showStarReward = false,
    showDungeonReward = false,

    showStarRewardRed = false,
    showDungeonRewardRed = false,

    starRewardAlpha = 1.0,
    dungeonRewardAlpha = 1.0,
    
    rewardList = {{title = "", titleColor = color1, process = "", processSlider = 1.0, rewardContentAnchPos = Vector2(0, 0), canvasAlpha = 1.0,
                   isReceived = false, isNotReceived = false, isCanGet = false, isProgress = false, isHorizontal = false, showSlider = false,
                   isStar = false, isDungeon = false, dungeonIndex = "", indexAplha = 1.0, rewardAlpha = 1.0, animationName = "",
                   rewardList = {{}}}},
}

local command = {
    rewardTypeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            if index == this.data.curSelectType then
                return
            end
            this.data.curSelectType = index
            this.data.isSendRequest = false
            this.Refresh(true)
        end
    },

    rewardItemBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            local index = tonumber(param) + 1
            if this.vm.data.rewardList[index].isCanGet then
                if this.data.isSendRequest then
                    return
                end
                local askData = {
                    AwardId = this.vm.data.rewardList[index].id
                }
                this.data.isSendRequest = true
                ApiMgr.Request("training/getRewards", askData, true, function(result)
                    local re=json.decode(result);
                    local data=json.encode(re.result.Rewards);
                    LuaMgr.ShowItemRewared(data);
                    this.Refresh()
                    LuaMgr.InvokeUIEventListeners(UIEventConst.TrainingGetReward)
                    this.data.isSendRequest = false
                end, function()
                    this.data.isSendRequest = false
                end, true);
            elseif this.vm.data.rewardList[index].isProgress then
                if this.data.curSelectType == 1 then
                    this.Close()
                elseif this.data.curSelectType == 2 then
                    this.data.OnClickDungeonProgressBtn(index)
                    this.Close()
                end
                this.Refresh()
            end
        end
    },
    
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            this.Close()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.data.seriesID = vm.behaviour.Params[0]
        this.data.OnClickDungeonProgressBtn = vm.behaviour.Params[1]
        this.Refresh()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.TrainingRewardItemShowDelay);
    end,
    before_destroy=function(vm)
        this.data=nil;
    end
}

this.Refresh = function()
    local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap
    local curTrainingSeriesCfg = cfgTrainingSeries[this.data.seriesID]
    if curTrainingSeriesCfg == nil then
        return
    end
    this.vm.data.seriesName = LuaMgr.GetLangText(curTrainingSeriesCfg.NameLan)
    this.RefreshRewardList()
    this.SetCurShowRewardList()

    this.vm.data.showStarRewardRed = HeroRedDataHelper.GetTrainingStarRewardRed(this.data.seriesID) > 0
    this.vm.data.showDungeonRewardRed = HeroRedDataHelper.GetTrainingDungeonRewardRed(this.data.seriesID) > 0
end

this.RefreshRewardList = function()
    local trainingAwardCfgs = ConfigMgr.Config.TrainingAwardMap
    local cfgTrainingDungeonGroups = ConfigMgr.Config.TrainingCpointMap
    local trainingRecords = DataMgr.Player.TrainingRecords
    local trainingRewards = DataMgr.Player.TrainingRewards
    local starRewardTempList = {}
    local dungeonRewardTempList = {}
    
    local totalGetStarCount = 0
    for k, v in pairs(trainingRecords) do
        local dungeonGroupCfg = cfgTrainingDungeonGroups[k]
        if dungeonGroupCfg.SeriesId == this.data.seriesID then
            totalGetStarCount = totalGetStarCount + v.StarCount
        end
    end
    
    for k, v in pairs(trainingAwardCfgs) do
        if v.SeriesId == this.data.seriesID then
            local isReceived = trainingRewards[k] ~= nil
            local item = {
                id = v.Id,
                title = LuaMgr.GetLangText(v.DescLan),
                rewardList = this.GetRewardList(v.Award),
                rewardContentAnchPos = Vector2(0, 0),
                isReceived = isReceived,
                isCanGet = false,
                isProgress = false,
                isStar = v.Type == 1,
                isDungeon = v.Type == 2,
                isHorizontal = false,
                animationName = "ani_TrainingRewardPopupPanel_allReward_002",
                canvasAlpha = 0.0,
            }
            if v.Award ~= nil and #v.Award > 4 then
                item.isHorizontal = true
            end

            if isReceived then
                item.indexAplha = 0.5
                item.rewardAlpha = 0.15
                item.titleColor = color2
            else
                item.indexAplha = 1.0
                item.rewardAlpha = 1.0
                item.titleColor = color1
            end
            
            if item.isStar then
                if not isReceived then
                    item.isCanGet = totalGetStarCount >= v.Parameter
                    item.isProgress = totalGetStarCount < v.Parameter
                    item.process = string.format("<color=#262429>%d</color>/%d",totalGetStarCount, v.Parameter)
                    item.processSlider = totalGetStarCount / v.Parameter
                    item.showSlider = true
                end
                table.insert(starRewardTempList, item)
            elseif item.isDungeon then
                if not isReceived then
                    item.isCanGet = trainingRecords[tostring(v.Parameter)] ~= nil
                    item.isProgress = trainingRecords[tostring(v.Parameter)] == nil
                    item.process = "<color=#262429>0</color>/1"
                    item.processSlider = 0
                    item.showSlider = false
                end
                table.insert(dungeonRewardTempList, item)
            end
        end
    end
    table.sort(starRewardTempList, this.rewardItemListSort)
    table.sort(dungeonRewardTempList, function(a, b) return a.id < b.id end)

    for i = 1, #dungeonRewardTempList do
        dungeonRewardTempList[i].dungeonIndex = i < 10 and "0" .. tostring(i) or tostring(i)
    end
    table.sort(dungeonRewardTempList, this.rewardItemListSort)

    this.data.starRewardList = starRewardTempList
    this.data.dungeonRewardList = dungeonRewardTempList
end

this.SetCurShowRewardList = function()
    this.vm.data.showStarReward = this.data.curSelectType == 1
    this.vm.data.showDungeonReward = this.data.curSelectType == 2
    if this.data.curSelectType == 1 then
        this.vm.data.starRewardAlpha = 1.0
        this.vm.data.dungeonRewardAlpha = 0.6
        this.vm.data.rewardList = this.data.starRewardList
    elseif this.data.curSelectType == 2 then
        this.vm.data.starRewardAlpha = 0.6
        this.vm.data.dungeonRewardAlpha = 1.0
        this.vm.data.rewardList = this.data.dungeonRewardList
    end

    local rewardItemIndex = 1
    LuaMgr.AddTimer(TimerConst.TrainingRewardItemShowDelay, function()
        if rewardItemIndex > #this.vm.data.rewardList then
            LuaMgr.RemoveTimer(TimerConst.TrainingRewardItemShowDelay);
            return
        end
        this.vm.data.rewardList[rewardItemIndex].animationName = "ani_TrainingRewardPopupPanel_allReward_001"
        this.vm.data.rewardList[rewardItemIndex].canvasAlpha = 1.0
        rewardItemIndex = rewardItemIndex + 1
    end, 0.03, -1, false);
end

this.GetRewardList = function(award)
    local list = {}
    if award ~= nil and #award > 0 then
        for i = 1, #award do
            local rewardItem = ConfigMgr.Config.itemMap[award[i].id];
            local goods = {
                id = rewardItem.id,
                count = tostring(award[i].count),
                rareSort = rewardItem.rare,
                rare = ActivityMgr.GetRareSprite(rewardItem.rare),
                icon = ActivityMgr.GetItemTexture(rewardItem.id),
                showType = ItemShowType.NONE,
                sizeDelta = Vector2(128,128),
                scale = Vector3(0.52, 0.52, 1),
                isClick = true,
                isCount = true,
                isShow = false,
            }
            table.insert(list, goods)
        end
    end

    table.sort(list, this.RewardItemSort);
    return list
end


this.RewardItemSort = function(a, b)
    return a.rareSort > b.rareSort;
end

this.rewardItemListSort = function(a, b)
    if a.isReceived ~= b.isReceived then
        return not a.isReceived 
    end
    return a.id < b.id
end

this.Close = function()
    LuaMgr.HidePanel(UIName.TrainingRewardPopupViewModel);
end

return vm({
    data = data,
    command = command,
    hook = hook
})