require("ViewModel/Rogue/Rogue_TeamHeroItem")

local this = {
    vm = nil,
    characterUIList = nil,
    characterCardItem = nil,
    curSelectTeamId = -1,
    characterList = {},
    customCharacterList = {},
    teamMaxCharacterCount = 0,
};

local data = {
    teamList = { { teamId = 0, teamName = "", select = false } },
    teamName = "",
    teamNameSize = 32,
    teamDesc = "",
    tips = "",
    chooseCustomTeam = false,
    characterListAnchoredPos = Vector2.zero,
    recommendChaList = { { icon = DefaultTexture, level = "", job = DefaultSprite, rare = DefaultSprite } },
    recommendDescStr = "",
    showRecommend = false,
    bagItemList = { { id = "", icon = DefaultSprite, bg = DefaultSprite, goodsItem = { { id = "", count = 0 } }, isBuff = false, isItem = false } },
}

local command = {
    teamItemBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local teamId = this.vm.data.teamList[index].teamId
            this.ChooseTeam(teamId)
        end
    },

    customTeamBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.ChooseTeam(0)
        end
    },

    BagItemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            local bagItemData = this.vm.data.bagItemList[index]
            if bagItemData.isBuff then
                LuaMgr.ShowLuaPanel(UIName.RogueBuffInfoPopup, bagItemData.id)
            end
        end
    },

    startBtn = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if TableIsNull(this.characterList) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26233"))
                return
            end
            local param = {
                RogueLevel = RogueMgr.RogueLevel,
                DefaultTeamId = this.curSelectTeamId,
                Characters = this.characterList
            }
            if NumTool.GetLen(RogueMgr.DefaultBuffList) > 0 then
                param.GlobalBuffIds = {}
                for k, v in pairs(RogueMgr.DefaultBuffList) do
                    table.insert(param.GlobalBuffIds, v)
                end
            end
            RogueMgr.OnAskExploreStart(param, function(result)
                PlayerPrefs.SetInt(DataMgr.Player.uid .. "RogueLastSelectTeamId", this.curSelectTeamId);
                if this.curSelectTeamId == 0 then
                    local characterListStr = this.characterList[1]
                    for i = 2, #this.characterList do
                        characterListStr = string.format("%s;%s", characterListStr, this.characterList[i])
                    end
                    PlayerPrefs.SetString(DataMgr.Player.uid .. "RogueCustomTeamCharacterList", characterListStr);
                end
                RogueExploreMgr.Init();
            end)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        local characterListTr = vm.behaviour.transform:Find("root/Middle/TeamInfo/CharacterList"):GetComponent("RectTransform")
        this.characterCardItem = vm.behaviour.transform:Find("template/CharacterItem").gameObject
        this.characterUIList = UIListView.New(characterListTr);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        BattlePrepareMgr.Clear()
        LuaMgr.SetShowRogueCharacterData(true)
        this.curSelectTeamId = -1
        this.teamMaxCharacterCount = ConfigMgr.Config.RogueConstants.RogueInitialHeroes
        local defaultSelectTeamId = PlayerPrefs.GetInt(DataMgr.Player.uid .. "RogueLastSelectTeamId", -1)
        if RogueMgr.ChooseTeamId ~= -1 then
            defaultSelectTeamId = RogueMgr.ChooseTeamId
        end
        this.InitCustomCharacterList()
        this.SetTeamList()

        if defaultSelectTeamId == -1 then
            defaultSelectTeamId = this.vm.data.teamList[1].teamId
        else
            local isFind = false
            for i, v in ipairs(this.vm.data.teamList) do
                if v.teamId == defaultSelectTeamId then
                    isFind = true
                end
            end
            if not isFind then
                defaultSelectTeamId = this.vm.data.teamList[1].teamId
            end
        end
        this.ChooseTeam(defaultSelectTeamId)
    end,
    before_deactive = function(vm)
        if this.cardUIList ~= nil then
            this.cardUIList:Clear();
        end
        LuaMgr.SetShowRogueCharacterData(false)
    end,
    before_destroy = function()
        UIListView.ClearItem("Rogue_TeamHeroItem")
    end
}

this.SetTeamList = function()
    local teamCount, teamIds = this.GetPresetTeamCount()
    local tempList = {}
    local coninitHeroCfgs = ConfigMgr.Config.RogueConinitHeroes
    local count = teamCount - #teamIds
    for i = 1, count do
        local teamCfg = coninitHeroCfgs[i]
        if not TableIsNull(teamCfg) then
            local item = {
                teamId = teamCfg.Id,
                teamName = LuaMgr.GetLangText(teamCfg.TeamLan),
                select = false,
                order = teamCfg.Order
            }
            table.insert(tempList, item)
        end
    end
    for i, teamCfg in ipairs(coninitHeroCfgs) do
        for j, v in ipairs(teamIds) do
            if teamCfg.Id == v then
                local item = {
                    teamId = teamCfg.Id,
                    teamName = LuaMgr.GetLangText(teamCfg.TeamLan),
                    select = false,
                    order = teamCfg.Order
                }
                table.insert(tempList, item)
            end
        end
    end

    table.sort(tempList, function(a, b)
        return a.order < b.order
    end)
    this.vm.data.teamList = tempList
end

this.ChooseTeam = function(teamId)
    if this.curSelectTeamId == teamId then
        return
    end
    this.curSelectTeamId = teamId
    if teamId == 0 then
        this.SetCustomTeam()
    else
        this.SetPresetTeam(teamId)
    end
    this.vm.data.chooseCustomTeam = teamId == 0
    for i, v in ipairs(this.vm.data.teamList) do
        v.select = v.teamId == teamId
    end
    RogueMgr.ChooseTeamId = teamId
end

this.SetPresetTeam = function(teamId)
    local presetTeamCfg = this.GetRogueConinitHeroCfgs(teamId)
    this.vm.data.teamName = LuaMgr.GetLangText(presetTeamCfg.TeamLan)
    this.vm.data.teamNameSize = 32
    this.vm.data.teamDesc = LuaMgr.GetLangText(presetTeamCfg.TeamDescLan)
    this.vm.data.tips = LuaMgr.GetLangText("RogueTeamViewModel_0")
    this.SetCharacterList(presetTeamCfg.Characters)
    this.SetRecommend(presetTeamCfg.Recommend, ConfigMgr.LangGlobal(tostring(presetTeamCfg.Desc)))
    this.SetBagItemList(presetTeamCfg.BuffId, presetTeamCfg.Item)
end

this.SetCustomTeam = function()
    this.vm.data.teamName = LuaMgr.GetLangText("RogueTeamViewModel_1")
    this.vm.data.teamNameSize = 48
    this.vm.data.teamDesc = ""
    this.vm.data.tips = string.format(LuaMgr.GetLangText("RogueTeamViewModel_2"), this.teamMaxCharacterCount)
    this.SetCharacterList(this.customCharacterList)
    this.SetRecommend()
    this.SetBagItemList(nil, ConfigMgr.Config.RogueConstants.RogueInitialSelfTeamsItem)
end

this.SetCharacterList = function(chaList)
    this.characterList = chaList
    this.characterUIList:Clear();
    local list = {}
    local heroDataList = table.Copy(RogueMgr.GetCharacterDatasByIDList(chaList));
    for i, v in ipairs(heroDataList) do
        local cfgCharacter = ConfigMgr.Config.characterTable[v.id];
        local cardItem = {
            index = i,
            characterData = {
                id = v.id,
                name = LuaMgr.GetLangText(cfgCharacter.namelan),
                level = v.level,
                star = v.star,
                rare = cfgCharacter.rare + (IsNull(v.brilliant) and 0 or v.brilliant.RareLevel),
                job = cfgCharacter.job,
                isHZ = not IsNull(v.brilliant) and v.brilliant.RareLevel > 0,
                isNoHZ = not IsNull(v.brilliant) and v.brilliant.RareLevel == 0,
                scale = 0.9,
            },
            onClick = this.OnClickCharacter
        }
        local cardData = UIListData.GetData(this.characterCardItem, "Rogue_TeamHeroItem", cardItem);
        table.insert(list, cardData);
    end
    for i = #list + 1, this.teamMaxCharacterCount do
        local cardItem = {
            index = i,
            onClick = this.OnClickCharacter
        }
        local cardData = UIListData.GetData(this.characterCardItem, "Rogue_TeamHeroItem", cardItem);
        table.insert(list, cardData);
    end
    this.characterUIList:SetData(list);
end

this.OnClickCharacter = function(index)
    local characterId = nil;
    if (index > 0) then
        characterId = this.characterList[index];
    elseif (#this.characterList > 0) then
        characterId = this.characterList[1];
    end
    if this.curSelectTeamId == 0 then

        HeroParameter.EmptyRogueParam();
        local selectMembers = this.characterList
        HeroParameter.SaveRogueParam(selectMembers, index == 0, this.teamMaxCharacterCount, characterId);
        FeatureManager.GotoPanel("1004");
    else
        RogueMgr.ShowCharacterDetailInfo(characterId)
    end
end

this.InitCustomCharacterList = function()
    this.customCharacterList = {}
    if HeroParameter.battleMembers ~= nil then
        local members = HeroParameter.battleMembers
        local member;
        local len = #members;
        for i = 1, len do
            member = members[i];
            if (not IsNullOrEmpty(member)) then
                table.insert(this.customCharacterList, member);
            end
        end
        RogueMgr.SetCustomTeamMembers(members)
    elseif RogueMgr.GetCustomTeamMembers() ~= nil then
        this.customCharacterList = RogueMgr.GetCustomTeamMembers()
    else
        local defaultCustomCharacterStr = PlayerPrefs.GetString(DataMgr.Player.uid .. "RogueCustomTeamCharacterList", "")
        if not IsNullOrEmpty(defaultCustomCharacterStr) then
            local chaList = NumTool.split(defaultCustomCharacterStr, ";")
            this.customCharacterList = chaList
        end
    end
end

this.SetRecommend = function(chaList, desc)
    if TableIsNull(chaList) then
        this.vm.data.showRecommend = false
        this.vm.data.characterListAnchoredPos = Vector2.zero
        return
    end
    local tempList = {}
    for i, v in ipairs(chaList) do
        local config = ConfigMgr.Config.characterTable[v];
        local tempRare = HeroMgr.GetHeroNowRare(config.id)
        local imageRare = tempRare >= 5 and 4 or tempRare
        local recommendCha = {
            icon = LuaMgr.GetTexture(HeroManager.GetCharacterAvatar(v)),
            job = LuaMgr.GetSprite("JobIcon", "job_" .. config.job),
            rare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. imageRare);
            level = ConfigMgr.Config.RogueConstants.RogueInitialHeroLevel
        }
        table.insert(tempList, recommendCha)
    end
    this.vm.data.recommendChaList = tempList
    this.vm.data.showRecommend = true
    this.vm.data.characterListAnchoredPos = Vector2(-156, 0)
    this.vm.data.recommendDescStr = desc
end

this.SetBagItemList = function(buffList, item)
    local tempList = {}
    if not TableIsNull(buffList) then
        for i, v in ipairs(buffList) do
            local buffCfg = ConfigMgr.Config.RogueBuffDescMap[v]
            if (buffCfg ~= nil) then
                local item = {
                    id = v,
                    icon = LuaMgr.GetSprite("BuffIcon", buffCfg.BuffIcon),
                    bg = LuaMgr.GetSprite("Rogue", "ui_xhyt_csqzxbfd_0" .. buffCfg.BuffQuality),
                    goodsItem = {},
                    isBuff = true,
                    isItem = false,
                }
                table.insert(tempList, item)
            end
        end
    end
    if not TableIsNull(item) and #item >= 2 then
        local itemId = item[1]
        local itemCount = item[2]
        local itemCfg = ConfigMgr.Config.itemMap[itemId]
        if (itemCfg ~= nil) then
            local item = {
                id = itemId,
                icon = DefaultSprite,
                bg = DefaultSprite,
                goodsItem = {
                    id = itemId,
                    count = LuaMgr.NumFormat(itemCount),
                    isCount = true,
                    rare = ActivityMgr.GetRareSprite(itemCfg.rare),
                    rareInt = itemCfg.rare,
                    icon = ActivityMgr.GetItemTexture(itemId),
                    scale = Vector3(0.84, 0.84, 0.84),
                    sizeDelta = Vector2(96, 96),
                    isClick = true
                },
                isBuff = false,
                isItem = true,
            }
            table.insert(tempList, item)
        end
    end

    this.vm.data.bagItemList = tempList
end

this.GetRogueConinitHeroCfgs = function(teamId)
    local teamCfg = nil
    local coninitHeroCfgs = ConfigMgr.Config.RogueConinitHeroes
    for i, v in ipairs(coninitHeroCfgs) do
        if v.Id == teamId then
            teamCfg = v
            break
        end
    end
    return teamCfg
end

this.GetPresetTeamCount = function()
    local teamCount = ConfigMgr.Config.RogueConstants.RogueInitialTeams
    local teamIds = {}
    local unlockTechIds = DataMgr.Player.RogueTech
    if IsNull(unlockTechIds) or TableIsNull(unlockTechIds) then
        return teamCount, teamIds
    end

    local techCfgs = ConfigMgr.Config.RogueTechs
    local tempList = {}
    for i, v in ipairs(techCfgs) do
        if unlockTechIds[v.Id] ~= nil and v.Type == 2 and not TableIsNull(v.Para) then
            if v.Para[1] == "RogueExtraTeams" then
                teamCount = teamCount + ConfigMgr.Config.RogueConstants.RogueExtraTeams
            elseif v.Para[1] == "Rogue2ExtraTeams1" then
                teamCount = teamCount + 1
                table.insert(teamIds, ConfigMgr.Config.RogueConstants.Rogue2ExtraTeams1)
            elseif v.Para[1] == "Rogue2ExtraTeams2" then
                teamCount = teamCount + ConfigMgr.Config.RogueConstants.Rogue2ExtraTeams2
            end
        end
    end
    return teamCount, teamIds
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})