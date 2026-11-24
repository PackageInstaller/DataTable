HeroCardItemSeason = {}
setmetatable(HeroCardItemSeason, {__index = HeroCardItem})
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
    SeasonalObj = {path = "AnimRoot/Seasonal", type = UITool.GameObject},
    SeasonalLevel = {path = "AnimRoot/Seasonal/SeasonalLevel", type = UITool.Text},
    seasonBattle4Lock = { path = "AnimRoot/SeasonBattle4Lock", type = UITool.GameObject },


    sImage = { path = "AnimRoot/SImage", type = UITool.GameObject },
    sBag = { path = "AnimRoot/SBg", type = UITool.GameObject },
    sImage2 = { path = "AnimRoot/Seasonal/SImage", type = UITool.GameObject },
}

HeroCardItemSeason.New = function(container)
    local self = {}
    setmetatable(self, {__index = HeroCardItemSeason})
    self.container = container
    self.prefabPath = "Assets/_BundleResources/UI/Common/HeroCardItemSeason.prefab"
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

function HeroCardItemSeason:SetSeasonal()
    if self.sImage then
        self.sImage:SetActive(false)
    end
    if self.sBag then
        self.sBag:SetActive(false)
    end
    if self.sImage2 then
        self.sImage2:SetActive(false)
    end

    local heroID = SeasonSLGMapMgr.GetSpecialHeroID()
    if not heroID or  heroID ~= self.data.id then
        return
    end

    self.sImage:SetActive(true)
    self.sBag:SetActive(true)
    self.sImage2:SetActive(true)
end


function HeroCardItemSeason:SetData(index, data, state,seasonal)
   HeroCardItem.SetData(self,index, data, state,true)
   self:SetSeasonal()
end