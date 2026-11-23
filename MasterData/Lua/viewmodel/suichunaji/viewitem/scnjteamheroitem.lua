















SCNJTeamHeroItem = {}
SCNJTeamHeroItem.__index = SCNJTeamHeroItem
local objs = {
    bg = {path = "BG", type = UITool.GameObject},
    heroHeadObj = {path = "CharacterHead", type = UITool.GameObject},
    avaterImage = {path = "CharacterHead/Avatar", type = UITool.RawImage},
    jobImage = {path = "CharacterHead/Job", type = UITool.Image},
    levelText = {path = "CharacterHead/AllText/LvValue", type = UITool.Text},
    quality2 = {path = "CharacterHead/Quality/Cheng", type = UITool.RectTransform},
    quality3 = {path = "CharacterHead/Quality/Lan", type = UITool.RectTransform},
    quality4 = {path = "CharacterHead/Quality/Lv", type = UITool.RectTransform}
}

SCNJTeamHeroItem.New = function(prefab, scale)

    local self = {}
    setmetatable(self, SCNJTeamHeroItem)
    if prefab ~= nil then
        self:Init(prefab, scale)
    end
    return self
end

function SCNJTeamHeroItem:Init(prefab, scale)
    if self.gameObject == nil then
        self.gameObject = prefab
    end
    if scale == nil then
        scale = 0.85
    end
    self.gameObject.transform.localScale = Vector3(scale, scale, scale)
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.quality2.gameObject, false)
    SetActive(self.quality3.gameObject, false)
    SetActive(self.quality4.gameObject, false)
end

function SCNJTeamHeroItem:SetData(data)
    if IsNull(self.gameObject) == false then
        SetActive(self.gameObject, true)
    end
    self.data = data.data
    if self.data == nil and data ~= nil then
        self.data = data
    end
    local heroId = self.data.id or self.data.heroID
    self:SetItem()
end

function SCNJTeamHeroItem:SetData1(data)
    self.data = data
    SetActive(self.gameObject, true)
    SetActive(self.heroHeadObj, self.data ~= nil)
    if self.data == nil then
        return
    end
    self:SetItem()
end

function SCNJTeamHeroItem:SetItem()
    local heroId = self.data.heroID
    local uid = self.data.uid
    self.heroID = heroId
    local characterData = self.data.characterData
    if characterData == nil then
        return
    end
    local heroConfig = ConfigMgr.Config.characterTable[heroId]
    self.jobImage.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. heroConfig.job)
    self.levelText.text = tostring(characterData.level)
    self.avaterImage.texture = LuaMgr.GetTexture(string.format("Character/%s/Avatar/%s.png", heroId, characterData.curSkin))
    local rare = HeroMgr.GetHeroNowRare(heroConfig.id)
    self:SetRare(rare)
end

function SCNJTeamHeroItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function SCNJTeamHeroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end

function SCNJTeamHeroItem:SetRare(rare)
    SetActive(self.quality2.gameObject, false)
    SetActive(self.quality3.gameObject, false)
    SetActive(self.quality4.gameObject, false)
    if self["quality" .. rare] ~= nil then
        SetActive(self["quality" .. rare].gameObject, true)
    elseif rare == 5 then

        SetActive(self["quality4"].gameObject, true)
    else
        LuaDebug.error("SCNJTeamHeroItem:SetRare Error|" .. (rare or 0) .. "|" .. (self.heroID or ""))
    end
end