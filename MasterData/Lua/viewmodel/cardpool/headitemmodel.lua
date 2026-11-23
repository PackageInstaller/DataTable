





HeadItemModel = {}

HeadItemModel.__index = HeadItemModel

local objs = {
    heroIcon = {path = "HeroIcon", type = "RawImage"},
    rareSprite = {path = "Rare", type = "Image"},
    nameText = {path = "Name", type = "Text"},
    isNew = {path = "New", type = "GameObject"},
    isUp = {path = "IsUp", type = "GameObject"},
    button = {path = "HeroIcon", type = "Button"},
}

function HeadItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, HeadItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",self.data.cardID);
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
    return self
end

function HeadItemModel:SetData(data)
    self.data = data
    if self.data == "" then return end
    local config = ConfigMgr.Config.characterTable[self.data.cardID]
    self.heroIcon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data.cardID,self.data.cardID.."001"))
    self.rareSprite.sprite = LuaMgr.GetSprite("CardRareMask","nameRare_"..config.rare)
    self.nameText.text = LuaMgr.GetLangText(config.namelan)
    SetActive(self.isNew,self.data.isNew)
    SetActive(self.isUp,self.data.isUP)
    self.gameObject:SetActive(true)
end

function HeadItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function HeadItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end