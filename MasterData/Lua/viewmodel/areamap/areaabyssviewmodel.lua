




require("ViewModel/AreaMap/BuildingItemModel")
require("ViewModel/AreaMap/DungeonItemModel")

local this = {
    vm = nil,tableInsert = table.insert,tableSort = table.sort,
    itemMap = nil,screenTotalWidth = nil,
    dungeonRoot = nil,isClick = nil,
    buildingRoot = nil,gotoBtn = nil,
    abyssConfig = nil,abyssMapConfig = nil,abyssDungeonConfig = nil,
    buildIndex = nil,dungeonIndex = nil,
    buildingView = nil,buildingTemplate = nil,
    dungeonView = nil,dungeonTemplate = nil,

    detailsRoot = nil,dungeonName = nil,
    perfect = nil,normal = nil, rateTip = nil,passTip = nil,
    canChallenge = nil,canChallengeLevel = nil,canChallengeText = nil,
    notChallenge = nil,notChallengeLevel = nil,notChallengeText = nil,
    rateList = nil,rateAward = nil,
    rewardContent = nil,rewardComplete = nil,
    challengeRoot = nil,icon_1Root = nil,icon_2Root = nil,countText = nil,
    levelFormat = "<color=#2fc2c9>  %d</color>",animator = nil,
    buildTransform = nil,buildBlockRoot = nil,buildScrollCenter,
    leftObj = nil,rightObj = nil,coroutine_key = nil,
}

local data = {
    switchObj = false,
    rewardList = {{rareIcon = DefaultSprite,itemIcon = DefaultTexture}},
    buildBlockList = {{icon = DefaultTexture,size = Vector2.zero,color = UnityEngine.Color(1,1,1,1),position = Vector2.zero,localScale = Vector3.zero,animName = ""}},
    buildList = {{buildTexture = DefaultTexture,sizeData = Vector2.zero}},
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if this.dungeonRoot.activeSelf then
                this.CloseDungeon()
            else
                LuaMgr.Back()
                HeroParameter.EmptyAbyssIndex()
            end
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            this.OpenDungeon()
        end
    },
    rateAwardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local index = tonumber(param)
            if this.rateAward ~= nil and this.rateAward[index] ~= nil then
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.rateAward[index].id,false,false,false)
            end
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local index = tonumber(param) + 1
            local id = this.vm.data.rewardList[index].itemId
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false)
        end
    },
    challengeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local key = this.abyssMapConfig[this.buildIndex].id
            local event = this.abyssDungeonConfig[key][this.dungeonIndex]
            HeroParameter.SaveAbyssIndex(this.buildIndex,this.dungeonIndex)
            LuaMgr.SetAreaBattleType(BattleType.Area)
            BattlePrepareMgr.EnterBattlePrepare(event.id,event.eventParam, 3)
        end
    },
    noChallengeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            local key = this.abyssMapConfig[this.buildIndex].id
            local event = this.abyssDungeonConfig[key][this.dungeonIndex]
            if this.GetDungeonLock(event) then
                local tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[event.unlockParam].NameLan)
                local tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12002"].NameLan),tipName)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end
    },
    leftCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if this.buildIndex - 1 <= 0 then
                return
            end
            this.SetSelectBuilding(this.buildIndex - 1)
        end
    },
    rightCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not this.isClick then return end
            if this.buildIndex + 1 > #this.abyssMapConfig then
                return
            end
            this.SetSelectBuilding(this.buildIndex + 1)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.animator = vm.behaviour.transform:GetComponent("Animator")

        this.buildingRoot = this.vm.behaviour.transform:Find("root/Middle/BuildingView").gameObject
        this.buildingView = UIScrollView.New(this.vm.behaviour.transform:Find("root/Middle/BuildingView/ScrollView").gameObject)
        this.buildingTemplate = this.vm.behaviour.transform:Find("template/BuildingItem").gameObject
        this.buildBlockRoot = this.vm.behaviour.transform:Find("root/Middle/BuildBlock").gameObject

        this.dungeonRoot = this.vm.behaviour.transform:Find("root/Left/Dungeon").gameObject
        this.dungeonView = UIScrollView.New(this.vm.behaviour.transform:Find("root/Left/Dungeon/DungeonView").gameObject)
        this.dungeonTemplate = this.vm.behaviour.transform:Find("template/DungeonItem").gameObject

        this.detailsRoot = this.vm.behaviour.transform:Find("root/Right/Details").gameObject
        this.dungeonName = this.vm.behaviour.transform:Find("root/Right/Details/Name/Text"):GetComponent("Text")
        this.perfect = this.vm.behaviour.transform:Find("root/Right/Details/Perfect").gameObject
        this.normal = this.vm.behaviour.transform:Find("root/Right/Details/Normal").gameObject
        this.rateTip = this.vm.behaviour.transform:Find("root/Right/Details/RateTip/Text"):GetComponent("Text")
        this.passTip = this.vm.behaviour.transform:Find("root/Right/Details/PassTip/Text"):GetComponent("Text")
        this.canChallenge = this.vm.behaviour.transform:Find("root/Right/Details/CanChallenge").gameObject
        this.canChallengeLevel = this.vm.behaviour.transform:Find("root/Right/Details/CanChallenge/Level"):GetComponent("Text")
        this.canChallengeText = this.vm.behaviour.transform:Find("root/Right/Details/CanChallenge/Text"):GetComponent("Text")
        this.notChallenge = this.vm.behaviour.transform:Find("root/Right/Details/NoChallenge").gameObject
        this.notChallengeLevel = this.vm.behaviour.transform:Find("root/Right/Details/NoChallenge/Level"):GetComponent("Text")
        this.notChallengeText = this.vm.behaviour.transform:Find("root/Right/Details/NoChallenge/Text"):GetComponent("Text")
        this.rewardContent = this.vm.behaviour.transform:Find("root/Right/Details/PassList/Scroll/Viewport/Content"):GetComponent("RectTransform")
        this.challengeRoot = this.vm.behaviour.transform:Find("root/Right/Details/Challenge").gameObject
        this.icon_1Root = this.vm.behaviour.transform:Find("root/Right/Details/Challenge/Icon_1").gameObject
        this.icon_2Root = this.vm.behaviour.transform:Find("root/Right/Details/Challenge/Icon_2").gameObject
        this.countText = this.vm.behaviour.transform:Find("root/Right/Details/Challenge/CountText"):GetComponent("Text")
        this.rewardComplete = this.vm.behaviour.transform:Find("root/Right/Details/PassList/Complete").gameObject
        
        this.leftObj = this.vm.behaviour.transform:Find("root/Left/LeftBtn").gameObject
        this.rightObj = this.vm.behaviour.transform:Find("root/Right/RightBtn").gameObject
        

        this.buildTransform = this.vm.behaviour.transform:Find("root/Middle/Build"):GetComponent("Transform")
        this.buildScrollCenter = this.vm.behaviour.transform:Find("root/Middle/Build/BuildView"):GetComponent("ScrollChildrenCenter")

        
        tempTrans = this.vm.behaviour.transform:Find("root/Right/Details/RateList"):GetComponent("Transform")
        this.GetRateNode(tempTrans)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        this.AddUIEvent()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        SetActive(this.dungeonRoot,false)
        SetActive(this.buildBlockRoot,false)
        SetActive(this.detailsRoot,false)
        this.buildIndex = nil
        this.dungeonIndex = nil
        this.vm.data.rewardList = {}
        this.vm.data.buildBlockList = {}
        this.vm.data.buildList = {}
        if this.coroutine_key ~= nil then
            coroutine_runner.stop(this.coroutine_key)
        end
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("DungeonItemModel")
        UIScrollView.ClearItem("BuildingItemModel")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.AbyssBuildingSelect, this.SetSelectBuildingEvent)
    LuaMgr.AddUIEventListener(UIEventConst.AbyssDungeonSelect, this.SetSelectDungeonEvent)
end
this.RemoveUIEvent = function()
    this.dungeonView:Clear(false)
    this.buildingView:Clear(false)
    LuaMgr.RemoveTimer(TimerConst.AreaAbyssClick)
    LuaMgr.RemoveUIEventListener(UIEventConst.AbyssBuildingSelect, this.SetSelectBuildingEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.AbyssDungeonSelect, this.SetSelectDungeonEvent)
end


this.InitParameter = function()
    local width = LuaMgr.GetScreenAddWidth()
    this.screenTotalWidth = 1280 + width
    this.GetAbyssConfig()
    this.GetAbyssDungeonConfig()
    this.SetLanguageText()
    SetActive(this.dungeonRoot,false)
    SetActive(this.buildBlockRoot,false)
    if HeroParameter.abyssBuildIndex ~= nil then
        this.isClick = true
        this.buildIndex = HeroParameter.abyssBuildIndex




        this.OpenDungeon()
    else
        this.vm.data.switchObj = true
        this.animator:Play("ani_ui_AreaAbyssPanel_root",0,0)
        this.GetBuildIndex()
        this.SetBuilding()
        this.SetBuildView()
        this.SetSelectBuilding(this.buildIndex)
    end
end


this.SetLanguageText = function()



    this.rateTip.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15600"].NameLan)
    this.passTip.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15601"].NameLan)
    this.canChallengeText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15603"].NameLan)
    this.notChallengeLevel.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15604"].NameLan)
    this.notChallengeText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15603"].NameLan)
end


this.GetBuildIndex = function()



    this.buildIndex = 1







end

this.GetDungeonIndex = function()
    local mapId = this.abyssMapConfig[this.buildIndex].id
    this.dungeonIndex = #this.abyssDungeonConfig[mapId]
    for i = 1, #this.abyssDungeonConfig[mapId] do
        if this.GetDungeonLock(this.abyssDungeonConfig[mapId][i]) then
            this.dungeonIndex = i == 1 and i or i - 1
            break
        end
    end
end


this.SetBuilding = function()
    this.isClick = false
    LuaMgr.AddTimer(TimerConst.AreaAbyssClick,function()
        this.isClick = true
        LuaMgr.RemoveTimer(TimerConst.AreaAbyssClick)
    end,1.3,1,false)
    this.buildingView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local config = nil
    for i = 1, #this.abyssMapConfig do
        config = this.abyssMapConfig[i]
        groupData = {}
        groupData.index = i
        groupData.item = this.buildingTemplate
        groupData.dungeon = this.abyssDungeonConfig[config.id]
        groupData.data = {id = config.id,area = config.area,lock = this.GetBuildLock(config),select = false}
        scrollData = UIScrollData.GetData(this.buildingTemplate,"BuildingItemModel",252 + 18,108,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.buildingView:SetParams(this.screenTotalWidth,130)
    this.buildingView:SetPadding(10,0,0,0)
    this.buildingView:SetData(scrollDatas, true)
    

    SetActive(this.buildingRoot,true)
end


this.SetBuildView = function()
    local tempList,tempItem = {},{}
    local path,texture,sizeData = nil,nil,nil
    for i = 1, #this.abyssMapConfig do
        path = Path.AbyssBuild_Path.."build_"..this.abyssMapConfig[i].id..".png"
        texture = LuaMgr.GetTexture(path)
        if texture ~= nil then
            sizeData = Vector2(texture.width,texture.height)
            tempItem = {buildTexture = texture,sizeData = sizeData}
            this.tableInsert(tempList,tempItem)
        end
    end
    this.vm.data.buildList = tempList
    this.buildScrollCenter:InitPageArray(#this.vm.data.buildList, false)
    if this.buildScrollCenter.scrollDragCallback == nil then
        this.buildScrollCenter.scrollDragCallback = this.OnScrollDragCallback
    end
    if this.buildScrollCenter.scrollEndCallback == nil then
        this.buildScrollCenter.scrollEndCallback = this.OnScrollEndCallback
    end
end


this.SetSelectBuildingEvent = function(args)
    if args.Length == 0 then return end
    local index = args[0]
    this.SetSelectBuilding(index)
end


this.SetSelectBuilding = function(index)
    local map = this.abyssMapConfig[index]
    if this.GetBuildLock(map) then
        local tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[map.unlockParam].NameLan)
        local tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["12002"].NameLan),tipName)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    end
    if this.buildingView.itemMap[this.buildIndex] ~= nil then
        this.buildingView.itemMap[this.buildIndex]:SetNum2()
    end
    this.buildingView.dataList[this.buildIndex].data.data.select = false
    this.buildIndex = index
    if this.buildingView.itemMap[this.buildIndex] == nil then
        this.buildingView:MoveToIndex(this.buildIndex)
    end
    this.buildingView.itemMap[this.buildIndex]:SetNum1()
    this.buildingView.dataList[this.buildIndex].data.data.select = true
    this.buildScrollCenter:SetCurrentPage(this.buildIndex - 1)
    


    
    SetActive(this.buildTransform.gameObject,true)
end

this.OnScrollEndCallback = function()
    local tempIndex = this.buildScrollCenter.GetCurrentPage + 1
    if tempIndex ~= this.buildIndex then
        this.SetSelectBuilding(tempIndex)
    end
    SetActive(this.leftObj,this.buildIndex > 1)
    SetActive(this.rightObj,this.buildIndex < #this.abyssMapConfig)
end

this.OnScrollDragCallback = function()
    SetActive(this.leftObj,false)
    SetActive(this.rightObj,false)
end


this.SetDungeon = function()
    local mapConfig = this.abyssMapConfig[this.buildIndex]
    this.dungeonView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local tempList,tempItem = {},{}
    local buildBlock,sizeData,pos = nil,nil,nil
    local dungeonStatus = nil
    for i = 1, #this.abyssDungeonConfig[mapConfig.id] do
        dungeonStatus = this.GetDungeonStatus(this.abyssDungeonConfig[mapConfig.id][i].eventParam)

        groupData = {}
        groupData.item = this.dungeonTemplate
        groupData.config = this.abyssDungeonConfig[mapConfig.id][i]
        groupData.data = {lock = this.GetDungeonLock(this.abyssDungeonConfig[mapConfig.id][i]),index = i,select = false,dungeonStatus = dungeonStatus}
        scrollData = UIScrollData.GetData(this.dungeonTemplate,"DungeonItemModel",152,116 - 3,groupData)
        this.tableInsert(scrollDatas,scrollData)

        buildBlock = LuaMgr.GetTexture(Path.AbyssBuild_Path.."build_"..mapConfig.id.."_"..i..".png")
        sizeData = Vector2(buildBlock.width,buildBlock.height)
        pos = TableIsNull(mapConfig.abyssCoord) and Vector2.zero or Vector2(mapConfig.abyssCoord[i][1],mapConfig.abyssCoord[i][2])
        tempItem = {icon = buildBlock,size = sizeData,position = pos,
                    color = dungeonStatus < 3 and UnityEngine.Color(1,1,1,1) or UnityEngine.Color(100/255,100/255,100/255,1),
                    localScale = Vector3.one,animName = "ani_BuildBlockItem_temp_002"}
        this.tableInsert(tempList,tempItem)
    end
    this.dungeonView:SetParams(155,634)
    this.dungeonView:SetPadding(0,0,-5,-20)
    this.dungeonView:SetData(scrollDatas, true)
    SetActive(this.dungeonRoot,true)
    
    this.vm.data.buildBlockList = tempList
    SetActive(this.buildBlockRoot,true)
    this.PlayBuildBlockAnim()
end

this.PlayBuildBlockAnim = function()
    if this.coroutine_key ~= nil then
        coroutine_runner.stop(this.coroutine_key)
    end
    this.coroutine_key = coroutine_runner.start(function()
        for i = 1, #this.vm.data.buildBlockList do
            this.vm.data.buildBlockList[i].animName = "ani_BuildBlockItem_temp_001"
            coroutine_runner.wait(0.03)
        end
    end)
end



this.GetDungeonStatus = function(eventParam)
    if IsNullOrEmpty(eventParam) then return end
    local dungeonData = DataMgr.Player.dungeonRecords[eventParam]
    local challengeCount = ConfigAreaMgr.GetChallengeCountById(eventParam)
    local completeCount = 0
    if challengeCount > 0 then
        completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(eventParam)
    end
    if dungeonData == nil or IsNullOrEmpty(dungeonData.historyRating) then
        return 3
    else
        if dungeonData.historyRating == "S" and challengeCount == completeCount then
            return 1
        else
            return 2
        end
    end
end


this.SetSelectDungeonEvent = function(args)
    if args.Length == 0 then return end
    local index = args[0]
    this.SetSelectDungeon(index)
end


this.SetSelectDungeon = function(index)
    if this.dungeonView.itemMap[this.dungeonIndex] ~= nil then
        this.dungeonView.itemMap[this.dungeonIndex]:SetSelect(false)
    end
    this.vm.data.buildBlockList[this.dungeonIndex].localScale = Vector3.one
    this.dungeonView.dataList[this.dungeonIndex].data.data.select = false
    this.dungeonIndex = index
    if this.dungeonView.itemMap[this.dungeonIndex] == nil then
        this.dungeonView:MoveToIndex(this.dungeonIndex)
    end
    this.dungeonView.itemMap[this.dungeonIndex]:SetSelect(true)
    this.dungeonView.dataList[this.dungeonIndex].data.data.select = true
    this.vm.data.buildBlockList[this.dungeonIndex].localScale = Vector3(1.2,1.2,1.2)
    this.SetDungeonDetails()
end


this.SetDungeonDetails = function()
    local key = this.abyssMapConfig[this.buildIndex].id
    local event = this.abyssDungeonConfig[key][this.dungeonIndex]
    local dungeonConfig = ConfigMgr.Config.dungeonMap[event.eventParam]
    local dungeonData = DataMgr.Player.dungeonRecords[event.eventParam]
    this.dungeonName.text = LuaMgr.GetLangText(dungeonConfig.NameLan)

    local statusNum = this.GetDungeonStatus(event.eventParam)
    SetActive(this.perfect,statusNum == 1)

    SetActive(this.normal,statusNum == 2)
    SetActive(this.canChallenge,not this.GetDungeonLock(event))
    SetActive(this.notChallenge,this.GetDungeonLock(event))
    local levelStr = string.format(this.levelFormat,dungeonConfig.levelShow)
    this.canChallengeLevel.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15602"].NameLan)..levelStr

    local showTexts = NumTool.split(LuaMgr.GetLangText(dungeonConfig.rateShowLan),";")
    local re = dungeonConfig.rateAward ~= json.null;
    this.rateAward = re and dungeonConfig.rateAward or {"","",""};
    local goodsConfig = nil
    local state = nil

    local rating = this.GetDungeonDecordRating(dungeonData)
    for i = 1, #this.rateList do
        state = rating ~= nil and i >= rating
        SetActive(this.rateList[i].rateNormal,not state)
        this.rateList[i].normalIntro.text = showTexts[i]
        SetActive(this.rateList[i].rateComplete,state)
        this.rateList[i].completeIntro.text = showTexts[i]
        if this.rateAward[i] ~= "" then
            goodsConfig = ConfigMgr.Config.itemMap[this.rateAward[i].id]
            this.rateList[i].goodsRare.sprite = LuaMgr.GetSprite("ItemRare","itemRare"..goodsConfig.rare)
            this.rateList[i].goodsIcon.texture = LuaMgr.GetTexture(Path.item_PATH.."itemicon_"..goodsConfig.id..".png")
        end
        SetActive(this.rateList[i].complete,state)
    end

    if dungeonConfig.firstDropShow ~= nil and dungeonConfig.firstDropShow ~= "" then
        local tempList = NumTool.split(dungeonConfig.firstDropShow, ';')
        local tempTab,tempItem = {},{}
        for i = 1, #tempList do
            goodsConfig = ConfigMgr.Config.itemMap[tempList[i]]
            tempItem = {rareIcon = LuaMgr.GetSprite("ItemRare","itemRare"..goodsConfig.rare),
                        itemIcon = LuaMgr.GetTexture(Path.item_PATH.."itemicon_"..goodsConfig.id..".png"),itemId = goodsConfig.id}
            this.tableInsert(tempTab,tempItem)
        end
        this.vm.data.rewardList = tempTab
        SetActive(this.rewardComplete,dungeonData ~= nil and not IsNullOrEmpty(dungeonData.historyRating))
    else
        this.vm.data.rewardList = {}
    end

    local challengeCount = ConfigAreaMgr.GetChallengeCountById(event.eventParam)
    if challengeCount > 0 then
        local completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(event.eventParam)
        SetActive(this.icon_1Root,challengeCount > completeCount)
        SetActive(this.icon_2Root,challengeCount == completeCount)
        this.countText.text = string.format("%s/%s", completeCount, challengeCount)
    end
    SetActive(this.challengeRoot,challengeCount > 0)
    this.rewardContent.anchoredPosition = Vector2.zero
    SetActive(this.detailsRoot,true)
end


this.OpenDungeon = function()
    this.animator:Play("ani_AreaAbyssPanel_root02",0,0)

    SetActive(this.buildingRoot,false)

    this.vm.data.switchObj = false
    SetActive(this.buildTransform.gameObject,false)
    this.GetDungeonIndex()
    this.SetDungeon()
    this.SetSelectDungeon(this.dungeonIndex)
end


this.CloseDungeon = function()
    this.animator:Play("ani_ui_AreaAbyssPanel_root",0,0)
    this.vm.data.switchObj = true
    SetActive(this.dungeonRoot,false)
    SetActive(this.buildBlockRoot,false)
    SetActive(this.detailsRoot,false)
    this.SetBuilding()
    this.SetBuildView()
    this.SetSelectBuilding(this.buildIndex)
end


this.GetAbyssConfig = function()
    for key,value in pairs(ConfigMgr.Config.areas) do
        if value.world == "abyss" then
            this.abyssConfig = value
            this.abyssMapConfig = ConfigMgr.Config.areaMapGroup[this.abyssConfig.area]
            return
        end
    end
end


this.GetAbyssDungeonConfig = function()
    local events = ConfigAreaMapMgr.GetAreaMapEvents(this.abyssConfig.area)
    this.abyssDungeonConfig = {}
    local value = nil
    for i = 1, #this.abyssMapConfig do
        value = this.abyssMapConfig[i]
        if this.abyssDungeonConfig[value.id] == nil then
            this.abyssDungeonConfig[value.id] = {}
        end
    end
    for i = 1, #events do
        if this.abyssDungeonConfig[events[i].groupId] ~= nil then
            this.tableInsert(this.abyssDungeonConfig[events[i].groupId],events[i])
        end
    end
    for k,v in pairs(this.abyssDungeonConfig) do
        this.tableSort(v,this.EventSort)
    end
end



this.GetBuildLock = function(buildInfo)
    if buildInfo == nil then return end
    if buildInfo.unlockType == 0 then
        return false
    end
    if buildInfo.unlockType == 1 then
        return DataMgr.Player.completedAreaEvents[buildInfo.unlockParam] == nil
    end
end




this.GetDungeonLock = function(dungeonInfo)
    if dungeonInfo == nil then return end
    if dungeonInfo.unlockType == 0 then
        return false
    end
    local event = DataMgr.Player.completedAreaEvents[dungeonInfo.unlockParam]
    if dungeonInfo.unlockType == 1 then
        return event == nil or event.completedRate == ""
    end
end


this.GetDungeonDecordRating = function(dungeonData)
    if dungeonData ~= nil then
        if dungeonData.historyRating == "S" then
            return 1
        elseif dungeonData.historyRating == "A" then
            return 2
        elseif dungeonData.historyRating == "B" then
            return 3
        end
    end
end













this.GetRateNode = function(rateTrans)

    local node = {
        rateNormal = {path = "Normal",type = "GameObject"},
        normalIntro = {path = "Normal/Text",type = "Text"},
        rateComplete = {path = "Complete",type = "GameObject"},
        completeIntro = {path = "Complete/Text",type = "Text"},
        goodsRare = {path = "Goods/Rare",type = "Image"},
        goodsIcon = {path = "Goods/Icon",type = "RawImage"},
        complete = {path = "Goods/Complete",type = "GameObject"},
    }
    this.rateList = {}
    local item,object = nil,nil
    for i = 1, rateTrans.childCount do
        item = {}
        object = rateTrans:Find(i).gameObject
        UITool.Parse(object,item,node)
        this.tableInsert(this.rateList,i,item)
    end
    node = nil
end


this.EventSort = function(item1,item2)
    if item1.order == item2.order then
        return item1.id < item2.id
    else
        return item1.order < item2.order
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})