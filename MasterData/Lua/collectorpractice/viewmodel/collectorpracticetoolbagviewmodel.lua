



local this = {
    vm = nil,
    CurrentMap = nil,
    Paneltype = nil,
    ParamsData = nil,
    showUse=true,
    selectBuild = nil,
    panelType =    {
        tipes = 1,
        taskPanel = 2,
        rewardPanel = 3,
    },
    nowEventToolsId="",
}
this.GALLERY_PAth = "Assets/_BundleResources/Images/ItemIcons/itemicon_%s.png";
this.SelectIndex = nil
local closefun = nil
local data = {
    showItemPanel = false,
    itemIcon = DefaultTexture,
    itemName = "",
    itemDescription = "",
    itemCount = "",
    buildTexture = DefaultTexture,
    showTaskList = false,
    showRewardList = false,
    CardPartItemList = {
        {
            id = "",
            Name = "",
            icon = DefaultTexture,
            partItems = false,
            TalentName = "",
        }

    },
    collectorTaskList = {
        {
            id = "",
            name = "",
            canGet = false,
            alreadyget = false,
            openGroup = true,
            numCard1 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard2 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard3 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard4 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard5 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard6 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard7 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard8 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard9 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
            numCard10 = { pos = Vector3.zero, scale = Vector3.zero, active = true, get = false, unget = false },
        }

    },
    isUse=true,

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CollectorPracticeToolBagViewModel)
        end
    },
    closeItemShow = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.CollectorPracticeToolBagViewModel)
        end
    },
    useItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.useItem();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm

    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.Paneltype = vm.behaviour.Params[0]
            this.ParamsData = vm.behaviour.Params[1]
            closefun = vm.behaviour.Params[2]

            if vm.behaviour.Params.Length>3 then
                this.showUse=vm.behaviour.Params[3]
            else
                this.showUse=true
            end

            if this.Paneltype == this.panelType.tipes then
                this.ShowItemMessage()

                local eventItem=ConfigMgr.Config.EventToolsMap[this.ParamsData.ID];
                if eventItem~=nil then
                    this.nowEventToolsId=eventItem.ToolEventId;
                else
                    LuaDebug.error("EventToolsMap is null by "..this.ParamsData.ID);
                end

            elseif this.Paneltype == this.panelType.taskPanel then
                this.InitTaskState()
            elseif this.Paneltype == this.panelType.rewardPanel then
                this.RwardThreeSelectOne()
            end
        end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.vm.data.showTaskList = false
            this.vm.data.showItemPanel = false
            this.vm.data.showRewardList = false
            LuaMgr.RemoveTimer(TimerConst.DelayClose)

            if closefun~=nil then
                closefun()
                closefun = nil;
            end
        end
    end,
    After_deactive = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.vm.data.RewardItemList[this.SelectIndex].select = false
        end
    end,
}

this.useItem = function()
local data={};
    data.id=this.ParamsData.ID;
    data.count=1;
    data.choices=nil;
    ApiMgr.Request("use_item", data, true,
    function(result)
        local re = json.decode(result)
if re.code == 0 then
            CollectorPracticeEvent.OpenMiniGameByEventId(this.nowEventToolsId,true,false)
            CollectorPracticeMainSceneViewModel.succssfulfun();
        else
            print("使用道具服务器返回失败了 : "..this.ParamsData.ID);
        end

        LuaMgr.HidePanel(UIName.CollectorPracticeToolBagViewModel)
        
        end, nil, true)

end

this.ShowItemMessage = function()
    local itemdata = this.ParamsData
    if itemdata == nil then
        return
    end
    local configData = ConfigMgr.Config.itemMap[itemdata.ID]
    this.vm.data.showItemPanel = true
    local icon = LuaMgr.GetTexture(string.format(this.GALLERY_PAth, itemdata.ID));

    if icon == nil then
        icon=  ActivityMgr.GetItemTexture(itemdata.ID);
    end
    
    this.vm.data.itemIcon = icon
    
    this.vm.data.itemName = LuaMgr.GetLangText(configData.nameLan)
    this.vm.data.itemDescription = LuaMgr.GetLangText(configData.DescriptionLan)
    this.vm.data.itemCount = itemdata.Count

    if not this.showUse then
        this.vm.data.isUse=false
        return
    end
    
    
    if ConfigMgr.Config.EventToolsMap[itemdata.ID].ToolEventId~=nil and ConfigMgr.Config.EventToolsMap[itemdata.ID].ToolEventId~="" then
        this.vm.data.isUse=true
    else
        this.vm.data.isUse=false
    end
end


this.InitTaskState = function()
    this.vm.data.showTaskList = true
    local realNeedtemplist = {}
    local taskId = this.ParamsData.eventId
    local eventConfig = ConfigMgr.Config.missionMap[taskId]
    local typeData = eventConfig.condition1[1].ElementID
    local BulildName = nil
    for index, value in pairs(ConfigMgr.Config.InternEventKV) do
        if value.EventType == tonumber(typeData) then
            BulildName = value.Model
        end
    end
    this.vm.data.buildTexture = LuaMgr.GetTexture(string.format("Images/CollectorBuilding/%s.png", BulildName))
    local taskItem = {
        id = this.ParamsData.eventId,
        name = this.ParamsData.eventText,
        canGet = this.ParamsData.current >= this.ParamsData.target and not this.ParamsData.status,
        alreadyget = this.ParamsData.status,
        openGroup = not this.ParamsData.status,
        numCard1 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard2 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard3 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard4 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard5 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard6 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard7 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard8 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard9 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
        numCard10 = { pos = Vector3.zero, scale = Vector3.zero, active = false, get = false, unget = false },
    }
    local target = this.ParamsData.target
    local current = this.ParamsData.current
    local posGrop = CollectorPracticeHelper.TaskposGropData[target]
    for index = 1, target, 1 do
        local carditem = "numCard" .. index
        taskItem[carditem].unget = true
        taskItem[carditem].get = current >= index
        taskItem[carditem].scale = Vector3(CollectorPracticeHelper.TaskscaleData[target], CollectorPracticeHelper.TaskscaleData[target], CollectorPracticeHelper.TaskscaleData[target])
        taskItem[carditem].pos = posGrop[index]
        taskItem[carditem].active = true
    end
    table.insert(realNeedtemplist, taskItem)
    this.vm.data.collectorTaskList = realNeedtemplist
end


this.RwardThreeSelectOne = function()
    this.vm.data.showRewardList = true
    local tempt = {}
    for key, value in pairs(this.ParamsData) do
        local telentName = LuaMgr.GetLangText(ConfigMgr.Config.OriginsTalentMap[value.Origins].OtNameLan)
        local goodsName = LuaMgr.GetLangText(value.name);
        local viewData =        {
            id = key,
            TalentName = telentName,
            Name = goodsName,
            icon = LuaMgr.GetTexture(string.format("Images/CollectorGallery/%s.png", key))
        }
        table.insert(tempt, viewData)
    end
    this.vm.data.CardPartItemList = tempt
end

return vm({
    data = data,
    command = command,
    hook = hook
})