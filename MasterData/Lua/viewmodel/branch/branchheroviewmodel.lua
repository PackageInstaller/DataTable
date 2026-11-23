





local this = {vm = nil,storyId = nil,heroId = nil,branchData = nil,
              novelConfig = nil,battleConfig = nil,groupId = nil,
              tableInsert = table.insert,questGroup = nil,
              novelItems = nil,battleItems = nil,heroCover = nil,
              dungeonName = nil,introText = nil,tipText = nil,rewardRoot = nil,
              gotoBtnText = nil,completeObj = nil,questEvents = nil,
              heroPath = "Assets/_BundleResources/Images/BranchHero/details_",
              iconPath = "Assets/_BundleResources/Images/BranchHero/event_",
              namePath = "Assets/_BundleResources/Images/BranchHero/name_",
              novelIndex = nil,nowNovelId = "",reward = nil,rewardBtn = nil,rewardRed = nil,
              novelAnimators = nil,novelAnimName = "ani_BranchHeroPanel_novel_002",
              battleAnimators = nil,battleAnimName = "ani_BranchHeroPanel_battle_002",
}

local data = {

}

local command = {
    novelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            local lockState = this.GetState(this.novelConfig[index].before)
            if lockState then
                this.PopupTipStr(this.novelConfig[index])
            else
                if this.novelIndex ~= index then
                    this.SetNovelChoose(index)
                end
            end
        end
    },
    novelGotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.PlayNovel(this.nowNovelId,
                    function()
                        LuaMgr.ShowLuaPanel("BranchHeroViewModel",HeroParameter.branchId,HeroParameter.branchHeroId,HeroParameter.branchGroupId)
                    end)
        end
    },
    battleCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param)
            local tempData = this.battleConfig[index]
            local lockState = this.GetState(tempData.before)
            if lockState then
                this.PopupTipStr(tempData)
            else
                LuaMgr.SetAreaBattleType(BattleType.Branch)
                BattlePrepareMgr.EnterBattlePrepare(tempData.param, tempData.param, 3)
            end
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.activityData ~= nil then
                LuaMgr.ShowLuaPanel(UIName.BranchHeroRewardViewModel,this.storyId,this.groupId)
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.heroCover = this.vm.behaviour.transform:Find("root/Middle/HeroCover"):GetComponent("RawImage")
        this.dungeonName = this.vm.behaviour.transform:Find("root/Middle/Popup/Dungeon/Name"):GetComponent("Text")
        this.introText = this.vm.behaviour.transform:Find("root/Middle/Popup/IntroText"):GetComponent("Text")
        this.tipText = this.vm.behaviour.transform:Find("root/Middle/Popup/Text"):GetComponent("Text")
        this.rewardRoot = this.vm.behaviour.transform:Find("root/Middle/Popup/Reward"):GetComponent("ScrollRect")
        this.gotoBtnText = this.vm.behaviour.transform:Find("root/Middle/Popup/GotoBtn/Text"):GetComponent("Text")
        this.rewardBtn = this.vm.behaviour.transform:Find("root/Middle/RewardBtn").gameObject
        this.rewardRed = this.vm.behaviour.transform:Find("root/Middle/RewardBtn/Red").gameObject
        this.completeObj = this.vm.behaviour.transform:Find("root/Middle/Popup/CompleteObj").gameObject
        
        local itemLayer = this.vm.behaviour.transform:Find("root/Middle/Novel"):GetComponent("Transform")
        this.GetNovelNode(itemLayer)
        itemLayer = this.vm.behaviour.transform:Find("root/Middle/Battle"):GetComponent("Transform")
        this.GetBattleNode(itemLayer)
        this.tipText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15002"].NameLan)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.storyId = vm.behaviour.Params[0]
        this.heroId = vm.behaviour.Params[1]
        this.questGroup = vm.behaviour.Params[2]
        this.GetStoryConfig()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.BranchHeroRedUpDate, this.UpDateRed)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.BranchHeroRedUpDate, this.UpDateRed)
    this.novelConfig = nil
    this.battleConfig = nil
    if this.reward ~= nil then
        for i = 1, #this.reward do
            this.reward[i]:Clear()
        end
        this.reward = nil
    end
end


this.InitParameter = function()
    this.novelIndex = -1
    this.branchData = DataMgr.Player.branch.children.Reg1001.children[this.storyId]
    this.heroCover.texture = LuaMgr.GetTexture(this.heroPath..this.heroId..".png")
    
this.groupId = "group."..this.questGroup
    this.activityData = DataMgr.Player.variables[this.groupId]
    

    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(tonumber(this.questGroup))
    
    if this.activityData ~= nil then
        local time = this.activityData.expireTime - LuaMgr.Timestamp()
        SetActive(this.rewardBtn,time > 0)
        if time > 0 then
            SetActive(this.rewardRed,this.Reward())
        end
    else
        SetActive(this.rewardBtn,false)
        print("活动数据为空  Story1+"..this.groupId)
    end
    
    this.InitNovelItem()
    this.InitBattleItem()
end


this.InitNovelItem = function()
    local lockState = nil
    local iconTexture,nameTexture = nil,nil
    local tempIndex = nil
    local complete = nil
    for i = 1, #this.novelConfig do
        lockState = this.GetState(this.novelConfig[i].before)
        SetActive(this.novelItems[i].lock,lockState)
        SetActive(this.novelItems[i].normal,not lockState)
        SetActive(this.novelItems[i].choose,false)
        if not lockState then
            iconTexture = LuaMgr.GetTexture(this.iconPath..this.novelConfig[i].param..".png")
            nameTexture = LuaMgr.GetTexture(this.namePath..this.novelConfig[i].param..".png")
            this.novelItems[i].normalIcon.texture = iconTexture
            this.novelItems[i].chooseIcon.texture = iconTexture
            this.novelItems[i].normalName.texture = nameTexture
            this.novelItems[i].chooseName.texture = nameTexture
            this.novelAnimators[i]:Play(this.novelAnimName,0,0)
        end

        if not lockState and tempIndex == nil then
            complete = this.IsCompletedChapter(this.novelConfig[i].param)
            if not complete then
                tempIndex = i
            end
        end
    end
    if tempIndex == nil then

        for i = 1, #this.novelConfig do
            lockState = this.GetState(this.novelConfig[i].before)
            complete = this.IsCompletedChapter(this.novelConfig[i].param)
            if not lockState and complete then
                tempIndex = i
            end
        end
    end

    if tempIndex == nil then
        tempIndex = 1
    end
    command.novelCommand.execute(nil,tempIndex)
end

this.SetNovelChoose = function(index)
    if this.novelIndex ~= -1 then
        SetActive(this.novelItems[this.novelIndex].normal,true)
        SetActive(this.novelItems[this.novelIndex].choose,false)
    end
    this.novelIndex = index
    this.nowNovelId = this.novelConfig[this.novelIndex].param
    SetActive(this.novelItems[this.novelIndex].normal,false)
    SetActive(this.novelItems[this.novelIndex].choose,true)
    this.SetNovelDetails()
end

this.SetNovelDetails = function()
    local tempData = this.novelConfig[this.novelIndex]
    local config = ConfigMgr.Config.narrativeMap[tempData.param]
    if config == nil then return end
    this.SetNovelReward(config.fixedDropShow)
    this.dungeonName.text = LuaMgr.GetLangText(config.nameLan)
    this.introText.text = LuaMgr.GetLangText(config.narraDesLan)
    local complete = this.IsCompletedChapter(tempData.param)
    if complete then
        this.gotoBtnText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15004"].NameLan)
    else
        this.gotoBtnText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15003"].NameLan)
    end
    SetActive(this.completeObj,complete)
end

this.SetNovelReward = function(rewardStr)
    this.rewardRoot.horizontalNormalizedPosition = 0.0
    local temp = NumTool.split(rewardStr,";")
    if temp == nil or #temp <= 0 then return end
    if this.reward == nil then this.reward = {} end
    local itemConfig = nil
    for i = 1, #temp do
        if #this.reward < i then
            this.tableInsert(this.reward,GoodsDataItem.New(this.rewardRoot.content))
        end
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[temp[i]])
        itemConfig["count0"] = "0"
        this.reward[i]:SetData(i,itemConfig,1,false,Vector3(0.75,0.75,0.75),false,true)
    end
    for i = #temp + 1, #this.reward do
        this.reward[i]:Hide()
    end
end


this.InitBattleItem = function()
    local lockState = nil
    local tempConfig,tempData = nil,nil
    local starState = nil
    local challengeCount = 0
    local completeCount = 0
    for i = 1, #this.battleConfig do
        this.battleAnimators[i]:Play("ani_BranchHeroPanel_battle_001",0,0)
        lockState = this.GetState(this.battleConfig[i].before)
        
        tempConfig = ConfigMgr.Config.dungeonMap[this.battleConfig[i].param]
        this.battleItems[i].nameText.text = LuaMgr.GetLangText(tempConfig.NameLan)
        
        tempData = DataMgr.Player.dungeonRecords[tempConfig.id]
        challengeCount = ConfigAreaMgr.GetChallengeCountById(this.battleConfig[i].param)
        completeCount = PlayerAreaMgr.GetChallengeCompleteCountById(this.battleConfig[i].param)

        local normalBool = not lockState and tempData ~= nil and tempData.historyRating ~= "" and completeCount >= 0 and completeCount < challengeCount
SetActive(this.battleItems[i].normalState,normalBool)
        local perfectBool = not lockState and tempData ~= nil and challengeCount == completeCount
SetActive(this.battleItems[i].perfectState,perfectBool)

        starState = not lockState and challengeCount >= 1
        SetActive(this.battleItems[i].star_1,starState)
        starState = tempData ~= nil and challengeCount >= 1 and completeCount >= 1
        SetActive(this.battleItems[i].star_active_1,starState)

        starState = not lockState and challengeCount >= 2
        SetActive(this.battleItems[i].star_2,starState)
        starState = tempData ~= nil and challengeCount >= 2 and completeCount >= 2
        SetActive(this.battleItems[i].star_active_2,starState)

        starState = not lockState and challengeCount >= 3
        SetActive(this.battleItems[i].star_3,starState)
        starState = tempData ~= nil and challengeCount >= 3 and completeCount >= 3
        SetActive(this.battleItems[i].star_active_3,starState)
        
        local animBool = UnityEngine.PlayerPrefs.HasKey("branchAnim"..this.battleConfig[i].ID)
        SetActive(this.battleItems[i].lock,not animBool or lockState)

        if not lockState then
            if not animBool then
                this.battleAnimators[i]:Play(this.battleAnimName,0,0)
                UnityEngine.PlayerPrefs.SetString("branchAnim"..this.battleConfig[i].ID,1)
            end
        end
    end
end


this.GetState = function(before)
    if before == "" then
        return false
    else

        local beforeData = nil
        for i = 1, #this.novelConfig do
            if this.novelConfig[i].ID == before then
                beforeData = this.novelConfig[i]
                break
            end
        end

        if beforeData == nil then
            for i = 1, #this.battleConfig do
                if this.battleConfig[i].ID == before then
                    beforeData = this.battleConfig[i]
                    break
                end
            end
        end
        if beforeData == nil then return true end
        if beforeData.type == "1" then
            return not this.IsCompletedChapter(beforeData.param)
        elseif beforeData.type == "2" then

            local dungeon = DataMgr.Player.dungeonRecords[beforeData.param]
            return dungeon == nil or dungeon.historyRating == ""
        end
    end
    return true
end

this.Reward = function()
    local tempData = nil
    for i = 1, #this.questEvents do
        if this.questEvents[i].text == this.storyId then
            tempData = DataMgr.Player.quests[this.questEvents[i].id]
            if tempData.state == 2 and this.questEvents[i].progress == tempData.progress then
                return true
            end
        end
    end
    return false
end

this.UpDateRed = function(args)
    SetActive(this.rewardRed,this.Reward())
end

this.PopupTipStr = function(config)
    local tipStr,tipName = "",""
    for i = 1, #this.novelConfig do
        if this.novelConfig[i].ID == config.before then
            tipName = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[this.novelConfig[i].param].nameLan)
            tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan),tipName)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            return
        end
    end
    for i = 1, #this.battleConfig do
        if this.battleConfig[i].ID == config.before then
            tipName = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[this.battleConfig[i].param].NameLan)
            tipStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10001"].NameLan),tipName)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            return
        end
    end
end
this.IsCompletedChapter = function(id)
    local len = #DataMgr.Player.completedChapters
    for i = 1, len do
        if (DataMgr.Player.completedChapters[i] == id) then
            return true
        end
    end
    return false
end
this.GetStoryConfig = function()
    this.novelConfig = {}
    this.battleConfig = {}
    local tempData = nil
    for i = 1, #ConfigMgr.Config.branchEventList do
        if ConfigMgr.Config.branchEventList[i].storyID == this.storyId then
            tempData = ConfigMgr.Config.branchEventList[i]
            if tempData.type == "1" then
this.tableInsert(this.novelConfig,tempData)
            elseif tempData.type == "2" then
this.tableInsert(this.battleConfig,tempData)
            end
        end
    end
end

this.GetNovelNode = function(transform)
    local novel = {
        lock = {path = "Lock",type = "GameObject"},
        normal = {path = "Normal",type = "GameObject"},
        normalIcon = {path = "Normal",type = "RawImage"},
        normalName = {path = "Normal/Name",type = "RawImage"},
        choose = {path = "Choose",type = "GameObject"},
        chooseIcon = {path = "Choose",type = "RawImage"},
        chooseName = {path = "Choose/Name",type = "RawImage"},
    }
    this.novelItems = {}
    this.novelAnimators = {}
    local object,item = nil,{}
    for i = 1, transform.childCount do
        object = transform:Find("Novel_"..i - 1)
        if object ~= nil then
            item = {}
            UITool.Parse(object,item,novel)
            this.tableInsert(this.novelAnimators,object:GetComponent("Animator"))
            this.tableInsert(this.novelItems,item)
        end
    end
    novel,object,item = nil,nil,nil
end
this.GetBattleNode = function(transform)
    local battle = {
        lock = {path = "Lock",type = "GameObject"},
        nameText = {path = "Name/Text",type = "Text"},
        normalState = {path = "State/Normal",type = "GameObject"},
        perfectState = {path = "State/Perfect",type = "GameObject"},
        
        star_1 = {path = "Star/Star1",type = "GameObject"},
        star_active_1 = {path = "Star/Star1/Active",type = "GameObject"},
        star_2 = {path = "Star/Star2",type = "GameObject"},
        star_active_2 = {path = "Star/Star2/Active",type = "GameObject"},
        star_3 = {path = "Star/Star3",type = "GameObject"},
        star_active_3 = {path = "Star/Star3/Active",type = "GameObject"},
    }
    this.battleItems = {}
    this.battleAnimators = {}
    local object,item = nil,{}
    for i = 1, transform.childCount do
        object = transform:Find("Battle_"..i - 1)
        if object ~= nil then
            item = {}
            UITool.Parse(object,item,battle)
            this.tableInsert(this.battleAnimators,object:GetComponent("Animator"))
            this.tableInsert(this.battleItems,item)
        end
    end
    battle,object,item = nil,nil,nil
end
return vm({
    data = data,
    command = command,
    hook = hook
})