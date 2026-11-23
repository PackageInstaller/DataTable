





local this = {
    vm = nil,
    groupId = nil,curIndex = 0,
    spineCharacter = nil,
    brilliantDungeonId = nil,brilliantGuidePictureIds = nil,
}

local data = {
    text_1 = "",text_2 = "",text_3 = "",bodyPath = "",
    heroList = {{heroPic = DefaultTexture,heroJob = DefaultSprite,heroRare = DefaultSprite,heroName = "",mask = false}},
    brilliantDungeonRewardRare = DefaultSprite,
    brilliantDungeonRewardIcon = DefaultTexture,
    brilliantDungeonRewardAlpha = 1.0,
    brilliantDungeonRewardCount = "",
    brilliantDungeonRewardReceived = false,
}

local command = {
    heroItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            if this.curIndex == index then
                return
            end
            this.curIndex = index
            this.UpdateSelect()
        end
    },
    brilliantDungeonCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local characterId = this.vm.data.heroList[this.curIndex].id
            local hzKey = DataMgr.Player.uid.."huanzhangReward"..characterId
            if not UnityEngine.PlayerPrefs.HasKey(hzKey) then
                UnityEngine.PlayerPrefs.SetString(hzKey)
                PlayerCharacterMgr.UpdateRedHuanZhangReward(ConfigCharacterMgr.GetInfo(characterId))
            end
            HeroParameter.SaveActivityKey(ActivityKey.HuanZhangActivity)
            BattlePrepareMgr.EnterBattlePrepare(this.brilliantDungeonId,this.brilliantDungeonId);
        end
    },
    brilliantDetailCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TableIsNull(this.brilliantGuidePictureIds) then
                return
            end
            local jsonData = json.encode(this.brilliantGuidePictureIds)
            LuaMgr.ShowLuaPanel(UIName.NewHelpViewModel, jsonData)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.spineCharacter = vm.behaviour.transform:Find("root/Middle/Character/Body"):GetComponent("UISpineCharacter");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
        if this.spineCharacter ~= nil then
            this.spineCharacter:Clear()
        end
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.SetLanguageText = function()
    this.vm.data.text_1 = ConfigMgr.LangGlobal("31205")
    this.vm.data.text_2 = ConfigMgr.LangGlobal("31206")
    this.vm.data.text_3 = ConfigMgr.LangGlobal("22625")
end


this.InitParameter = function()
    this.groupId = ActivityMgr.groupKeyList[ActivityKey.HuanZhangActivity]
    if IsNullOrEmpty(this.groupId) then return end

    if not ActivityMgr.ActivityRuning(ActivityKey.HuanZhangActivity) then
        return
    end
    this.curIndex = 1
    this.SetHeroList()
    this.UpdateSelect()
    this.UpdateRed()
end

this.SetHeroList = function()
    local tempConfig = ConfigHelper.GetCurCardPoolsData()
    if TableIsNull(tempConfig) then
        return
    end
    local length = #tempConfig
    local character = nil
    local brilliantKey = nil
    local configList = {}
    for i = 1, length do
        character = ConfigCharacterMgr.GetInfo(tempConfig[i].characterShow[1])
        if not TableIsNull(character) then
            brilliantKey = character.id..character.rare
            if ConfigMgr.Config.BrilliantMap[brilliantKey] ~= nil then
                table.insert(configList,character)
            end
        end
    end
    if TableIsNull(configList) then return end
    local tempData,tempList = nil,{}
    for i = 1, #configList do
        tempData = {heroPic = DefaultTexture,heroJob = DefaultSprite,heroRare = DefaultSprite,heroName = "",mask = false}
        tempData.heroPic = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(configList[i].id,"001"))
        tempData.heroJob = LuaMgr.GetSprite("JobIcon", "job_"..configList[i].job)
        tempData.heroRare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..configList[i].rare)
        tempData.heroName = LuaMgr.GetLangText(configList[i].namelan)
        tempData.id = configList[i].id
        table.insert(tempList,tempData)
    end
    this.vm.data.heroList = tempList
end

this.UpdateSelect = function()
    if this.curIndex <= 0 or this.curIndex > #this.vm.data.heroList then
        return
    end
    local characterId = this.vm.data.heroList[this.curIndex].id
    local characterSkinId = characterId.."001"
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId,characterSkinId)
    if path ~= "" then
        this.vm.data.bodyPath = path
    end
    this.UpdateHuanZhangReward()
    for i = 1, #this.vm.data.heroList do
        this.vm.data.heroList[i].mask = i ~= this.curIndex
    end
end

this.UpdateHuanZhangReward = function()
    local character = ConfigCharacterMgr.GetInfo(this.vm.data.heroList[this.curIndex].id)
    if TableIsNull(character) then
        return
    end
    local brilliantKey = character.id..character.rare
    local brilliantCfg = ConfigMgr.Config.BrilliantMap[brilliantKey]
    this.brilliantDungeonId = brilliantCfg.DungeonId
    this.brilliantGuidePictureIds = brilliantCfg.GuidePictureId
    local dungeonCfg = ConfigMgr.Config.dungeonMap[brilliantCfg.DungeonId]
    local firstRewardList = ConfigHelper.GetRewardListByDrop(dungeonCfg.firstDrop)
    local dungeonRecord = DataMgr.Player.dungeonRecords[brilliantCfg.DungeonId]
    local completed = dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating)
    if firstRewardList ~= nil and next(firstRewardList) ~= nil then
        local tempConfig = ConfigMgr.Config.itemMap[firstRewardList[1].id]
        this.vm.data.brilliantDungeonRewardRare = GetRareSprite(tempConfig.rare)
        this.vm.data.brilliantDungeonRewardIcon = GetItemTexture(firstRewardList[1].id)
        this.vm.data.brilliantDungeonRewardCount = firstRewardList[1].count
        this.vm.data.brilliantDungeonRewardReceived = completed
        this.vm.data.brilliantDungeonRewardAlpha = completed and 0.7 or 1.0
    end
end

this.UpdateRed = function()
    local red = 0
    for i = 1, #this.vm.data.heroList do
        if PlayerCharacterMgr.RedHuanZhangReward(this.vm.data.heroList[i].id) then
            red = red + 1
        end
    end
    RedMgr.Singleton:UpdateClientRedData("18301", red)
end

return vm({
    data = data,
    command = command,
    hook = hook
})