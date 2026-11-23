




HeroCardItem = {}
HeroCardItem.__index = HeroCardItem

local objs = {
    bgBtn = { path = "AnimRoot", type = UITool.Button },
    heroPic = { path = "AnimRoot/HeroPic", type = UITool.RawImage },
    heroRare = { path = "AnimRoot/HeroRare", type = UITool.Image },
    heroLevel = { path = "AnimRoot/HeroLevel", type = UITool.Text },
    heroJob = { path = "AnimRoot/HeroJob", type = UITool.Image },
    heroZZ = { path = "AnimRoot/HeroZZ", type = UITool.Image },
    heroZZText = { path = "AnimRoot/HeroZZ/Text", type = UITool.Text },
    heroName = { path = "AnimRoot/HeroName", type = UITool.Text },
    choice = { path = "AnimRoot/Choice", type = UITool.GameObject },
    numSprite = { path = "AnimRoot/Choice/NumSprite", type = UITool.Image },
    numScale = { path = "AnimRoot/Choice/NumSprite", type = UITool.GameObject },
    levelingMaskObj = { path = "AnimRoot/LevelingMask", type = UITool.GameObject },
    leveling = { path = "AnimRoot/Leveling/Text", type = UITool.Text },
    levelingPass = { path = "AnimRoot/LevelingPass/Text", type = UITool.Text },
    levelingJoint = { path = "AnimRoot/LevelingJoint", type = UITool.GameObject },
    trainingObj = { path = "AnimRoot/Training", type = UITool.GameObject },
    trainingText = { path = "AnimRoot/Training/Text", type = UITool.Text },
    red = { path = "AnimRoot/Red", type = UITool.GameObject },
    newRed = { path = "AnimRoot/NewRed", type = UITool.GameObject },
    tryActor = { path = "AnimRoot/TryActor", type = UITool.GameObject },
    attention = { path = "AnimRoot/Attention", type = UITool.GameObject },
    assisUidObj = { path = "AnimRoot/assisUidName", type = UITool.GameObject },
    assisUidName = { path = "AnimRoot/assisUidName/Text", type = UITool.Text },
    assisUidCount = { path = "AnimRoot/assisUidName/Count", type = UITool.Text },
    assisMaskObj = { path = "AnimRoot/assisMask", type = UITool.GameObject },
    assisMaskHeroCountObj = { path = "AnimRoot/assistMaskHeroCount", type = UITool.GameObject },
    dungeon66 = { path = "AnimRoot/Dungeon66", type = UITool.GameObject },
    springCamp = { path = "AnimRoot/SpringCamp", type = UITool.GameObject },
    springCampTeamIndex = { path = "AnimRoot/SpringCamp/teamIndex", type = UITool.Text },
    hzActive = { path = "AnimRoot/HZActive", type = UITool.GameObject },
    hzNotActive = { path = "AnimRoot/HZNotActive", type = UITool.GameObject },
    miniBattle = { path = "AnimRoot/MiniBattle", type = UITool.GameObject },
    crisisContract2 = { path = "AnimRoot/CrisisContract2", type = UITool.GameObject },
    crisisContract2Txt = { path = "AnimRoot/CrisisContract2/Text", type = UITool.Text },
    miniBattle2 = { path = "AnimRoot/MiniBattle2", type = UITool.GameObject },
    miniBattle3 = { path = "AnimRoot/MiniBattle3", type = UITool.GameObject },
    miniBattle4Lock = { path = "AnimRoot/MiniBattle4Lock", type = UITool.GameObject },
    miniBattle4Help = { path = "AnimRoot/MiniBattle4Help", type = UITool.GameObject },
    bossDummy3 = { path = "AnimRoot/BossDummy3", type = UITool.GameObject },
    bossDummy3Text = { path = "AnimRoot/BossDummy3/Text", type = UITool.Text },
    teamRelay = { path = "AnimRoot/TeamRelay", type = UITool.GameObject },
    teamRelay2 = { path = "AnimRoot/TeamRelay2", type = UITool.GameObject },
    teamRelay2Txt = { path = "AnimRoot/TeamRelay2/Text", type = UITool.Text },
    TeamTower = {path="AnimRoot/TeamTower",type=UITool.GameObject},
    TeamTowerTired = {path="AnimRoot/TeamTowerTired",type=UITool.GameObject},
    TeamTowerTxt = {path="AnimRoot/TeamTowerTired/TeamTowerText",type=UITool.Text},
}

HeroCardItem.New = function(container)
    local self = {}
    setmetatable(self, HeroCardItem)
    self.container = container
    self.prefabPath = "Assets/_BundleResources/UI/Common/HeroCardItem.prefab"
    self.object = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object, self, objs)
    LuaMgr.SetFont(self.rectTransform);

    self.HeroCommand = function()
        if HeroParameter.IsBatch then
            if self.callBack ~= nil then
                self.callBack(self.itemId)
                self.data.choice = not self.data.choice
                self:UpdateChooseAttention()
            end
        else
            if self.levelingMaskObj.activeSelf or self.trainingObj.activeSelf or self.assisMaskObj.activeSelf or self.assisMaskHeroCountObj.activeSelf or self.TeamTower.activeSelf or self.springCamp.activeSelf then
                return
            end
            if not self.state then
                HeroRedDataHelper.ClearCharacterRed(self.itemId)
                LuaMgr.InvokeUIEventListeners(UIEventConst.heroCardItemClick, self.itemId)
            else
                LuaMgr.InvokeUIEventListeners(UIEventConst.heroCardChoiceClick, self)
            end
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.HeroCommand)
    return self
end


function HeroCardItem:SetData(index, data, state)
    self.index = index
    self.data = data
    self.itemId = data.id
    self.state = state
    self.callBack = nil
    local tempRare = nil
    if (data.isActor) then
        local actorConfig = ConfigMgr.Config.actor[data.id];
        if (actorConfig ~= nil) then
            self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(actorConfig.CharacterId, actorConfig.SkinParam))
        end
        tempRare = data.rare
    else
        self.heroPic.texture = LuaMgr.GetTexture(HeroMgr.GetCharacterCard(data.id, data.curSkin))
        tempRare = HeroMgr.GetHeroNowRare(self.itemId)
    end
    self:UpdateCardAttention()
    self.heroLevel.text = data.level
    self.heroJob.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. data.job)
    self.heroName.text = data.name
    self.choice:SetActive(data.choice)

    self.leveling.transform.parent.gameObject:SetActive(data.isLeveling)
    self.levelingPass.transform.parent.gameObject:SetActive(false)
    self.levelingMaskObj:SetActive(false);
    self.levelingJoint:SetActive(false);
    if data.isLeveling then
        tempRare = data.rare
        local battleCount, reBattleCount = BattlePrepareMgr.MoreModGetCharacterBattleCount(data.characterId)
        local isBattleRecord = BattlePrepareMgr.MoreModCharacterHasBattleRecord(data.characterId);
        if reBattleCount == 0 and not isBattleRecord then
            self.levelingMaskObj:SetActive(true)
        end
        if isBattleRecord then
            self.levelingPass.transform.parent.gameObject:SetActive(true)
            self.levelingPass.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2703"].NameLan)
        end
        local tip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2702"].NameLan)
        local tipValue = reBattleCount > 0 and string.format("<color=#32d9ce><size=20>%s</size></color>", reBattleCount)
                or string.format("<color=#838383><size=20>%s</size></color>", reBattleCount)
        self.leveling.text = string.format(tip, tipValue)
        local isJoint = BattlePrepareMgr.LevelingWeek_CheckJointCharacter(data.id)
        self.levelingJoint:SetActive(isJoint);
    elseif data.isRogue then
        tempRare = RogueMgr.GetHeroNowRare(data.characterId)
    end

    SetActive(self.assisMaskHeroCountObj, false);
    SetActive(self.assisUidObj, data.isAssis)
    if data.isAssis then
        tempRare = HeroMgr.GetHeroNowRare(self.itemId, data.uid)
        self.assisUidName.text = data.uidName
        SetActive(self.assisMaskHeroCountObj, data.assistHeroCount == 0 or PlayerAssistMgr.RemainAssistCount() == 0);
        self.assisUidCount.text = string.format("<color=#eccc38>%s</color>/%s", data.assistHeroCount, ConfigMgr.Config.FriendConstants.PlayerBorrowLimit)
    end
    self:SetAssistIsMask(data.assisIsMask)
    if tempRare > 0 then
        local brilliantKey = self.itemId .. data.rare
        local brilliant = ConfigMgr.Config.BrilliantMap[brilliantKey]
        SetActive(self.hzActive, not TableIsNull(brilliant) and tempRare > 4 and not data.isLeveling)
        SetActive(self.hzNotActive, not TableIsNull(brilliant) and tempRare <= 4 and not data.isLeveling)
    end
    local imageRare = tempRare >= 5 and 4 or tempRare
    self.heroRare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. imageRare)

    self.trainingObj:SetActive(false)
    if HeroParameter.isTraining then
        if data.trainingGroupIndex ~= nil 
            and data.trainingGroupIndex > 0
            and HeroParameter.teamIndex > 0
            and HeroParameter.teamIndex ~= data.trainingGroupIndex then
            self.trainingObj:SetActive(true)
            local w = NumTool.GetMaxNum(data.trainingGroupIndex)
            self.trainingText.text = string.format(LuaMgr.GetLangText("HeroCardItem_6"), w)
        end








    end

    SetActive(self.dungeon66, false);
    if (HeroParameter.isDungeon66) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.dungeon66, uid ~= nil);
    end

    SetActive(self.springCamp, false);
    if (HeroParameter.activityKey == ActivityKey.SpringCamp) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.springCamp, uid ~= nil);
        if uid ~= nil then
            local teamId = HeroParameter.filterMemberTeamMap[data.id]
            if teamId ~= nil then
                self.springCampTeamIndex.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_3010" .. tostring(teamId))
            else
                SetActive(self.springCamp, false);
            end
        end
    end

    SetActive(self.miniBattle, false)
    if (HeroParameter.activityKey == ActivityKey.MiniBattle) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.miniBattle, uid ~= nil);
    end
    SetActive(self.crisisContract2, false)
    if (HeroParameter.activityKey == ActivityKey.crisiscontract2 or HeroParameter.activityKey == ActivityKey.crisiscontract3 or HeroParameter.activityKey == ActivityKey.TeamRelay3) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.crisisContract2, uid ~= nil);
        if uid ~= nil then
            local teamId = HeroParameter.filterMemberTeamMap[data.id]
            if teamId ~= nil then
                self.crisisContract2Txt.text = string.format(LuaMgr.GetLangText("HeroCardItem_2"), NumTool.GetMaxNum(tonumber(teamId)))
            end
        end
    end
    SetActive(self.miniBattle2, false)
    if (HeroParameter.activityKey == ActivityKey.MiniBattlenew) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.miniBattle2, uid ~= nil);
    end
    SetActive(self.miniBattle3, false)
    if (HeroParameter.activityKey == ActivityKey.DualBattle) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.miniBattle3, uid ~= nil);
    end
    SetActive(self.miniBattle4Lock, false)
    SetActive(self.miniBattle4Help, false)
    if (HeroParameter.activityKey == ActivityKey.DualBattle2) then
        local uid = HeroParameter.filterMembers[data.id];
        local plotId = HeroParameter.miniBattle4HelpActors ~= nil and HeroParameter.miniBattle4HelpActors[data.id] or nil
        SetActive(self.miniBattle4Lock, uid ~= nil);
        SetActive(self.miniBattle4Help, plotId ~= nil);
    end
    SetActive(self.bossDummy3, false)
    if (HeroParameter.activityKey == ActivityKey.BossDummy3 or HeroParameter.activityKey == ActivityKey.BossDummy4) then
        local uid = HeroParameter.filterMembers[data.id];
        self.bossDummy3Text.text = LuaMgr.GetLangText("HeroCardItem_4")
        SetActive(self.bossDummy3, uid ~= nil);
    end
    if (HeroParameter.activityKey == ActivityKey.BossDummy5) then
        local uid = HeroParameter.filterMembers[data.id];
        local index = BossDummy5Mgr.filterMembersMap[data.id]
        if index ~= nil then
            self.bossDummy3Text.text = string.format(LuaMgr.GetLangText("HeroCardItem_5"),index)
        end
        SetActive(self.bossDummy3, uid ~= nil);
    end

    SetActive(self.teamRelay, false)
    if (HeroParameter.activityKey == ActivityKey.TeamRelay) then
        local uid = HeroParameter.filterMembers[data.id];
        SetActive(self.teamRelay, uid ~= nil);
    end

    SetActive(self.teamRelay2, false)
    if (HeroParameter.activityKey == ActivityKey.TeamRelay2) then
        local uid = HeroParameter.filterMembers[data.id];
        if uid ~= nil then
            local teamId = HeroParameter.filterMemberTeamMap[data.id]
            if teamId ~= nil then
                self.teamRelay2Txt.text = string.format(LuaMgr.GetLangText("HeroCardItem_2"), NumTool.GetMaxNum(tonumber(teamId)))
            end
            SetActive(self.teamRelay2, true)
        else
            SetActive(self.teamRelay2, false)
        end
    end


    SetActive(self.TeamTower,false)
    SetActive(self.TeamTowerTired.gameObject, false)
    if HeroParameter.activityKey == ActivityKey.TeamTower then
       local tired = TeamTowerMgr.CheckCharacterTired(data.id)
       if tired == 0 then
           SetActive(self.TeamTower, true)
       else
           self.TeamTowerTxt.text = string.format(LuaMgr.GetLangText("HeroCardItem_3"),tostring(tired))
           SetActive(self.TeamTowerTired.gameObject, true)
       end
    end
    
    if data.num ~= 0 then
        self.numSprite.sprite = LuaMgr.GetSprite("NumberFont", data.num)
    end
    self.numScale:SetActive(data.num ~= 0)
    local zzLevel = data.star > 0 and data.star or -1;
    local zzStr = zzLevel > 0 and "<color=#262429>%s</color>" or "<color=#aca9a3>%s</color>"
    self.heroZZText.text = string.format(zzStr, HeroMgr.GetNumStr(math.abs(zzLevel)))
    self.heroZZ.sprite = LuaMgr.GetSprite("CommonRes", zzLevel > 0 and "ui_ty_kp_zz1" or "ui_ty_kp_zz2")

    if BattlePrepareMgr.isLeveling or data.isAssis then
        self.red:SetActive(false)
        self.newRed:SetActive(false)
    else
        self:UpdateRedPoint(data.isActor)
    end
    SetActive(self.tryActor, data.isActor == true);
    self.object.gameObject:SetActive(true)
end

function HeroCardItem:SetAssistIsMask(isOn)
    if isOn and self.assisMaskHeroCountObj.activeSelf then

        return
    end
    SetActive(self.assisMaskObj, isOn)
end

function HeroCardItem:UpdateRedPoint(isActor)
    local count = 0;
    if (not isActor) then
        count = PlayerCharacterMgr.RedUpLevel(self.itemId) == false and 0 or 1
        count = count + (PlayerCharacterMgr.RedZZ(self.itemId) == false and 0 or 1)
        count = count + (PlayerCharacterMgr.RedTalent(self.itemId) == false and 0 or 1)
        count = count + (PlayerCharacterMgr.RedSpeciality(self.itemId) == false and 0 or 1)
        count = count + (PlayerCharacterMgr.RedFriendly(self.itemId))
        count = count + PlayerCharacterMgr.ArchivesLanguageTipRed(self.itemId);
        count = count + (PlayerCharacterMgr.RedHuanZhang(self.itemId) == false and 0 or 1)
        count = count + (PlayerCharacterMgr.RedHuanZhangReward(self.itemId) == false and 0 or 1)
    end
    self.red:SetActive(count > 0)
    self.newRed:SetActive(HeroRedDataHelper.characterRedList[self.itemId] == 1 and not self.state)
end


function HeroCardItem:UpdateCardAttention()
    self.attention:SetActive(self.data.focus)
end

function HeroCardItem:UpdateChooseAttention()
    self.choice:SetActive(self.data.choice)
end

function HeroCardItem:CallBackFun(fun)
    self.callBack = fun
end

function HeroCardItem:Hide()
    self.data = nil
    self.itemId = ""
    self.callBack = nil
    self.object.gameObject:SetActive(false)
end

function HeroCardItem:Clear()
    if self.HeroCommand ~= nil then
        LuaMgr.RemoveClick(self.bgBtn, self.HeroCommand)
        self.HeroCommand = nil
    end
    self.container = nil
    self.rectTransform = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end 