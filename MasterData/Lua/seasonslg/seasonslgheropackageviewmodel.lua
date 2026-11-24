require("ViewModel/Common/HeroCardGroupItemSeason")
local this = {vm = nil,jobType = nil,sortType = nil,sequenceType = nil,
              TableInsert = table.insert,TableSort = table.sort,scrollRect = nil,
              scrollIsReset = true, content = nil,groupTemplate = nil,
              heroData = nil, totalWidth = nil,isAttention = false,
              isRed = false,isRedChoose = false,isBatch = false,attentionList = nil,
              isBrilliant = false}

local data = {
    animName = "",alpha = 0.0,
    rareBtn = false,rareBtnOrder = Vector3.zero,
    levelBtn = false,levelBtnOrder = Vector3.zero,
    batchBool = false,batchText = "",
    attentionText = "",brilliantText = "",
    redBool = false,redChoose = false,redNum = "",
    redPost = Vector2.zero,batchRoot = false,
    clearBtnText = "",saveBtnText = "",tipText = "",
    brilliantChoose = false,
}

local command = {
    levelSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sortType == HeroSortType.Level then
                if this.sequenceType == SequenceType.FromBigToSmall then
                    this.sequenceType = SequenceType.FromSmallToBig
                else
                    this.sequenceType = SequenceType.FromBigToSmall
                end
            else
                this.sortType = HeroSortType.Level
                this.sequenceType = SequenceType.FromBigToSmall
            end
            HeroParameter.scrollPosition = true
            this.CreateHeroItem()
        end
    },
    rareSortCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.sortType == HeroSortType.Rare then
                if this.sequenceType == SequenceType.FromBigToSmall then
                    this.sequenceType = SequenceType.FromSmallToBig
                else
                    this.sequenceType = SequenceType.FromBigToSmall
                end
            else
                this.sortType = HeroSortType.Rare
                this.sequenceType = SequenceType.FromBigToSmall
            end
            HeroParameter.scrollPosition = true
            this.CreateHeroItem()
        end
    },
    featureCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            HeroParameter.SaveListParam(this.jobType,this.sortType,this.sequenceType,true,1)

            LuaMgr.ShowLuaPanel(UIName.SeasonSLGHeroFilterSortViewModel)
        end
    },
    attentionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if this.isBatch and this.isAttention then
                return
            end
            if this.isAttention then
                this.isAttention = false
                UnityEngine.PlayerPrefs.SetInt("HeroPackageAttention",0)
            else
                this.isAttention = true
                UnityEngine.PlayerPrefs.SetInt("HeroPackageAttention",1)
            end
            this.InitParameter()
            this.CreateHeroItem()
        end
    },
    batchCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.BatchOperate(not this.isBatch)
            if not this.isBatch then
                this.ClearHeroAllAttention()
            end
        end
    },
    saveCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SaveHeroAttention()
        end
    },
    clearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.ClearHeroAllAttention()
        end
    },
    redCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.isRedChoose = not this.isRedChoose
            HeroParameter.IsRed = this.isRedChoose
            this.vm.data.redChoose = this.isRedChoose
            this.CreateHeroItem()
        end
    },
    brilliantCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.isBrilliant = not this.isBrilliant
            HeroParameter.IsBrilliant = this.isBrilliant
            this.vm.data.brilliantChoose = this.isBrilliant
            this.CreateHeroItem()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.scrollRect = UIScrollView.New(vm.behaviour.transform:Find("root/HeroView").gameObject)
        this.content = vm.behaviour.transform:Find("root/HeroView/Viewport/Content")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.ScreenMonitorType("t_7");
        this.SetLanguageText()
        this.InitParameter()
        this.CreateHeroItem()
        this.vm.data.animName = "ani_HeroPackagePanel_root_001"
        LuaMgr.AddUIEventListener(UIEventConst.UpdateHeroList,this.FilterSortCallBack)
        LuaMgr.AddUIEventListener(UIEventConst.heroCardItemClick,this.ShowHeroManager)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.scrollRect:Clear(false)
        this.vm.data.alpha = 0.0
        this.vm.data.animName = ""
        LuaMgr.RemoveUIEventListener(UIEventConst.UpdateHeroList,this.FilterSortCallBack)
        LuaMgr.RemoveUIEventListener(UIEventConst.heroCardItemClick,this.ShowHeroManager)
    end,
    before_destroy = function(vm)
        this.DeletePanel()
        this = nil
    end,
}


this.InitParameter = function()
    this.totalWidth = LuaMgr.ScreenWidth()

    this.jobType = HeroParameter.paramBool and HeroParameter.jobType or CharacterJob.All
    this.sortType = HeroParameter.paramBool and HeroParameter.sortType or HeroSortType.Level
    this.sequenceType = HeroParameter.paramBool and HeroParameter.sequenceType or SequenceType.FromBigToSmall

    this.SetAttention()

    this.SetRed()

    this.SetBrilliant()
    this.BatchOperate(false)
end

this.SetAttention = function()
    this.isBatch = false
    if UnityEngine.PlayerPrefs.HasKey("HeroPackageAttention") then
        this.isAttention = UnityEngine.PlayerPrefs.GetInt("HeroPackageAttention") == 1
    else
        this.isAttention = false
    end
    this.vm.data.batchBool = this.isAttention
end

this.SetRed = function()
    local tempNum = PlayerCharacterMgr.GetHeroPackageRedNum()
    this.isRed = tempNum > 0
    if this.isRed then
        this.vm.data.redNum = tempNum
        this.vm.data.redPost = this.isAttention and Vector2(-587,-23.1) or Vector2(-495,-23.1)
    end
    this.vm.data.redBool = this.isRed
    if HeroParameter.IsRed == nil then
        this.isRedChoose = false
    else
        if tempNum <= 0 then
            this.isRedChoose = false
        else
            this.isRedChoose = HeroParameter.IsRed
        end
    end
    this.vm.data.redChoose = this.isRedChoose
end

this.SetBrilliant = function()
    if HeroParameter.IsBrilliant == nil then
        this.isBrilliant = false
    else
        this.isBrilliant = HeroParameter.IsBrilliant
    end
    this.vm.data.brilliantChoose = this.isBrilliant
end

this.SetLanguageText = function()
    this.vm.data.batchText = ConfigMgr.LangGlobal("2605")
    this.vm.data.attentionText = ConfigMgr.LangGlobal("2606")
    this.vm.data.clearBtnText = ConfigMgr.LangGlobal("2607")
    this.vm.data.saveBtnText = ConfigMgr.LangGlobal("2608")
    this.vm.data.brilliantText = ConfigMgr.LangGlobal("22605")
end


this.BatchOperate = function(isShow)
    this.isBatch = isShow
    HeroParameter.IsBatch = isShow
    if this.isBatch and this.isAttention then
        this.attentionList = {}
        local num = 0
        for i = 1, #this.heroData do
            if this.heroData[i].focus then
                num = num + 1
                this.heroData[i].choice = true
                this.attentionList[this.heroData[i].id] = true
            end
        end
        this.scrollRect:Refresh()
        local tipStr = ConfigMgr.LangGlobal("2609")
        this.vm.data.tipText = string.format(tipStr,num)
        this.vm.behaviour:UpdateTopBar("batchOperate", function()
            this.ClearHeroAllAttention()
            this.BatchOperate(false)
        end)
    else
        this.vm.behaviour:UpdateTopBar("heroList", function()
            HeroRedDataHelper.ClearCharacterRed()
            LuaMgr.Back()
        end)
    end
    this.vm.data.batchRoot = this.isBatch and this.isAttention
end

this.ChooseAttention = function(heroId)
    if IsNullOrEmpty(heroId) then return end
    if this.attentionList[heroId] == nil then
        this.attentionList[heroId] = true
    else
        this.attentionList[heroId] = not this.attentionList[heroId]
    end
    local num = 0
    for key,value in pairs(this.attentionList) do
        if value == true then
            num = num + 1
        end
    end
    local tipStr = ConfigMgr.LangGlobal("2609")
    this.vm.data.tipText = string.format(tipStr,num)
end

this.SaveHeroAttention = function()
    local tipStr = ConfigMgr.LangGlobal("2610")
    if TableIsNull(this.attentionList) then

        this.BatchOperate(false)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
    else
        local tempData = {}
        tempData["CharacterIds"] = this.attentionList

        ApiMgr.Request("set_character_focus", tempData,true,function(result)
            local re = json.decode(result)
            if re.code == 0 then

                this.attentionList = {}
                this.InitParameter()
                this.CreateHeroItem()
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            end
        end,nil,true)
    end
end

this.ClearHeroAllAttention = function()
    if not TableIsNull(this.attentionList) then
        for key,value in pairs(this.attentionList) do
            this.attentionList[key] = false
        end
        for i = 1, #this.heroData do
            this.heroData[i].choice = false
        end
        this.scrollRect:Refresh()
        local tipStr = ConfigMgr.LangGlobal("2609")
        this.vm.data.tipText = string.format(tipStr,0)
    end
end

this.CreateHeroItem = function()
    this.scrollRect.scrollRect:StopMovement()
    this.InitShowHero()
    this.HeroListSort()
    if this.groupTemplate == nil then
        this.groupTemplate = this.vm.behaviour.transform:Find("template/HeroCardGroupItem").gameObject
    end
    this.scrollRect:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    local tempIdList = {}
    while (index <= #this.heroData) do
        groupData = {}
        groupData.callBack = this.ChooseAttention
        groupData.hero = {}
        groupData.seasonal = true
        for i = 1, 2 do
            if this.heroData[index + i - 1] ~= nil then
                this.TableInsert(groupData.hero,this.heroData[index + i - 1])
                this.TableInsert(tempIdList,this.heroData[index + i - 1].id)
            end
        end
        scrollData = UIScrollData.GetData(this.groupTemplate,"HeroCardGroupItemSeason",144 + 7,625,groupData)
        this.TableInsert(scrollDatas,scrollData)
        index = index + 2
    end
    this.scrollRect:SetParams(this.totalWidth,625)
    if LuaMgr.GetScreenAddWidth() > 3 then
        this.scrollRect:SetPadding(60, 60, 0, 0)
    else
        this.scrollRect:SetPadding(0, 14, 0, 0)
    end
    if HeroParameter.paramBool then
        this.scrollIsReset = HeroParameter.scrollPosition
    else
        this.scrollIsReset = true
    end
    this.scrollRect:SetData(scrollDatas, this.scrollIsReset)
    HeroParameter.IsShowCharacterList = tempIdList
end

this.HeroListSort = function()
    if this.sortType == HeroSortType.Level then
        this.TableSort(this.heroData,this.LevelSort)
    elseif this.sortType == HeroSortType.Rare then
        this.TableSort(this.heroData,this.RareSort)
    elseif this.sortType == HeroSortType.Star then
        this.TableSort(this.heroData,this.StarSort)
    elseif this.sortType == HeroSortType.Time then
        this.TableSort(this.heroData,this.TimeSort)
    elseif this.sortType == HeroSortType.Friendly then
        this.TableSort(this.heroData,this.FriendlySort)
    end
    if this.isAttention then
        local tempList = {}
        for i = #this.heroData, 1, -1 do
            if this.heroData[i].focus then
                this.TableInsert(tempList,1,this.heroData[i])
                table.remove(this.heroData,i)
            end
        end
        for i = #tempList, 1, -1 do
            this.TableInsert(this.heroData,1,tempList[i])
        end

    end
    this.UpdateGuideSort()
    this.UpdateSortBtn()
end

this.UpdateSortBtn = function()
    this.vm.data.rareBtn = this.sortType == HeroSortType.Rare
    this.vm.data.levelBtn = this.sortType == HeroSortType.Level
    local vector = this.sequenceType == SequenceType.FromBigToSmall and Vector3.one or Vector3(1,-1,1)
    this.vm.data.rareBtnOrder = vector
    this.vm.data.levelBtnOrder = vector
end


this.FilterSortCallBack = function()
    HeroParameter.scrollPosition = true
    this.InitParameter()
    this.CreateHeroItem()
end

this.ShowHeroManager = function(args)
    local itemId = args[0]
    if itemId == nil then return end
    local index = nil
    local tempList = {}
    for i = 1, #this.heroData do
        if this.heroData[i].id == itemId then
            index = i
        end
        this.TableInsert(tempList,this.heroData[i].id)
    end
    HeroParameter.SaveListParam(this.jobType,this.sortType,this.sequenceType,false,index,tempList)
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGHeroUpLevelViewModel, itemId)
end


this.InitShowHero = function()

    this.heroData = {}
    local heroConfig = nil
    local brilliantKey = nil
    for key,value in pairs(DataMgr.Player.characters) do
        local isShow = true
        if this.isRedChoose and not PlayerCharacterMgr.HeroPackageRedContain(key) then
            isShow = false
        end
        heroConfig = ConfigMgr.Config.characterTable[key]
        if isShow and heroConfig ~= nil and this.isBrilliant then
            if TableIsNull(ConfigMgr.Config.BrilliantMap) then
                isShow = false
            else
                brilliantKey = key..heroConfig.rare
                if ConfigMgr.Config.BrilliantMap[brilliantKey] == nil then
                    isShow = false
                end
            end
        end
        if isShow and heroConfig ~= nil and (this.jobType == CharacterJob.All or this.jobType == heroConfig.job) then
            if heroConfig ~= nil and heroConfig.Switch == 0 and ConfigCharacterMgr.GetSeasonalHeroConfig(value.id) ~= nil then
                value.rare = heroConfig.rare
                value.name = LuaMgr.GetLangText(heroConfig.namelan)
                value.job = heroConfig.job
                value.choice = false
                value.num = 0
                this.TableInsert(this.heroData,value)
            end
        end
        if isShow and this.isBatch and this.isAttention then
            if this.attentionList[key] ~= nil then
                value.choice = this.attentionList[key]
            end
        end
    end
end


this.LevelSort = function(a,b)
    if a.level ~= b.level then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.LevelSortBigToSmall(a,b)
        else
            return HeroMgr.LevelSortSmallToBig(a,b)
        end
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.RareSort = function(a,b)
    if HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.RareSortBigToSmall(a,b)
        else
            return HeroMgr.RareSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.StarSort = function(a,b)
    if a.star ~= b.star then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.StarSortBigToSmall(a,b)
        else
            return HeroMgr.StarSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.TimeSort = function(a,b)
    if a.createTime ~= b.createTime then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.TimeSortEarlyToLate(a,b)
        else
            return HeroMgr.TimeSortLateToEarly(a,b)
        end
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.FriendlySort = function(a,b)
    if a.prestigeLevel ~= b.prestigeLevel then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.FriendlySortBigToSmall(a,b)
        else
            return HeroMgr.FriendlySortSmallToBig(a,b)
        end
    elseif a.prestige ~= b.prestige then
        if this.sequenceType == SequenceType.FromBigToSmall then
            return HeroMgr.FriendlyExpSortBigToSmall(a,b)
        else
            return HeroMgr.FriendlyExpSortSmallToBig(a,b)
        end
    elseif a.level ~= b.level then
        return HeroMgr.LevelSortBigToSmall(a,b)
    elseif a.star ~= b.star then
        return HeroMgr.StarSortBigToSmall(a,b)
    elseif HeroMgr.GetHeroRareSort(a.id) ~= HeroMgr.GetHeroRareSort(b.id) then
        return HeroMgr.RareSortBigToSmall(a,b)
    else
        return HeroMgr.HeroIdSort(a,b)
    end
end


this.UpdateGuideSort = function()
    if not LuaMgr.IsGuide() then return end
    local config = LuaMgr.GetNowConfig()
    if config == nil or config.Data == "" then return end
    for i = 1, #this.heroData do
        if this.heroData[i].id == config.Data then
            local item = this.heroData[i]
            table.remove(this.heroData,i)
            this.TableInsert(this.heroData,1,item)
            break
        end
    end
end

this.DeletePanel = function()
    UIScrollView.ClearItem("HeroCardGroupItemSeason")
end

return vm({
    data = data,
    command = command,
    hook = hook
})