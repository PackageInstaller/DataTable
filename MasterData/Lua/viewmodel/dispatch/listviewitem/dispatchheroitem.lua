


















DispatchHeroItem = {}
DispatchHeroItem.__index = DispatchHeroItem
DispatchHeroItem.SelectSiteSpites = {}
local SelectSiteSpitesPrefix = "ui_ty_kp_xz_zzdw_sz%d"
local AtlasName = "LongTermDispatch"
local objs = {
    button = {path = "", type = UITool.Button},
    heroHeadObj = {path = "CharacterHead", type = UITool.GameObject},
    avaterImage = {path = "CharacterHead/Avatar", type = UITool.RawImage},
    jobImage = {path = "CharacterHead/Job", type = UITool.Image},
    levelText = {path = "CharacterHead/AllText/LvValue", type = UITool.Text},
    selectedObj = {path = "CharacterHead/SelectedStatus", type = UITool.GameObject},
    quality2 = {path = "CharacterHead/Quality/Cheng", type = UITool.RectTransform},
    quality3 = {path = "CharacterHead/Quality/Lan", type = UITool.RectTransform},
    quality4 = {path = "CharacterHead/Quality/Lv", type = UITool.RectTransform},
    tempHeroSiteImg = {path = "CharacterHead/SelectedStatus/Site", type = UITool.Image}
}

DispatchHeroItem.New = function(prefab, parent, scale, clickCallback, noInstantiate)

    local self = {}
    setmetatable(self, DispatchHeroItem)
    if prefab ~= nil then
        self:Init(prefab, parent, scale, clickCallback, noInstantiate)
    end
    return self
end

function DispatchHeroItem:Init(prefab, parent, scale, clickCallback, noInstantiate)
    if self.gameObject == nil then
        if noInstantiate == true then
            self.gameObject = prefab
        else
            self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
        end
    end
    if scale == nil then
        scale = 0.85
    end
    self.gameObject.transform.localScale = Vector3(scale, scale, scale)
    UITool.Parse(self.gameObject, self, objs)
    if clickCallback ~= nil then
        self.clickCallback = clickCallback
        local clickBtn = function()
            self.clickCallback(self)
        end
        LuaMgr.AddClick(self.button, clickBtn)
    end
    SetActive(self.selectedObj, false)
    SetActive(self.quality2.gameObject, false)
    SetActive(self.quality3.gameObject, false)
    SetActive(self.quality4.gameObject, false)
end

function DispatchHeroItem:SetData(data)
    if IsNull(self.gameObject) == false then
        SetActive(self.gameObject, true)
    end
    self.data = data.data
    if self.data == nil and data ~= nil then
        self.data = data
    end
    local heroId = self.data.id or self.data.heroID
    SetActive(self.selectedObj, false)
    self:SetItem(heroId)
end

function DispatchHeroItem:SetData1(data)
    self.data = data
    SetActive(self.gameObject, true)
    SetActive(self.heroHeadObj, self.data ~= nil)
    SetActive(self.selectedObj, false)
    if self.data == nil then
        return
    end
    local heroId = self.data.heroID
    self:SetItem(heroId)
end

function DispatchHeroItem:SetItem(heroId)
    self.heroID = heroId
    local heroConfig = ConfigMgr.Config.characterTable[heroId]
    self.jobImage.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. heroConfig.job)
    self.levelText.text = tostring(DataMgr.Player.characters[heroId].level)
    self.avaterImage.texture = LuaMgr.GetTexture(string.format("Character/%s/Avatar/%s.png", heroId, DataMgr.Player.characters[heroId].curSkin))
    local rare = HeroMgr.GetHeroNowRare(heroConfig.id)
    self:SetRare(rare)
    local isSelected = self.data.selected == true and self.data.selectIndex ~= nil and self.data.selectIndex > 0
    SetActive(self.selectedObj, isSelected)
    self:SetSelected(isSelected)
end


function DispatchHeroItem:SetSelected(selected)
    SetActive(self.selectedObj, selected)
    if selected == true and self.data.selectIndex ~= nil then
        self.tempHeroSiteImg.sprite = self:GetSiteSprite(self.data.selectIndex)
    end
end

function DispatchHeroItem:GetSiteSprite(site)
    local sprite = LuaMgr.GetSprite(AtlasName, string.format(SelectSiteSpitesPrefix, site))
    DispatchHeroItem.SelectSiteSpites[site] = sprite
    return sprite
end

function DispatchHeroItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function DispatchHeroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end

function DispatchHeroItem:SetRare(rare)
    SetActive(self.quality2.gameObject, false)
    SetActive(self.quality3.gameObject, false)
    SetActive(self.quality4.gameObject, false)
    if self["quality" .. rare] ~= nil then
        SetActive(self["quality" .. rare].gameObject, true)
    elseif rare == 5 then

        SetActive(self["quality4"].gameObject, true)
    else
        LuaDebug.error("DispatchHeroItem:SetRare Error|" .. (rare or 0) .. "|" .. (self.heroID or ""))
    end
end