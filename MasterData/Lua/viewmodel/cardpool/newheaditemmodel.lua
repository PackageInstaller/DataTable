





NewHeadItemModel = {}

NewHeadItemModel.__index = NewHeadItemModel
local objs = {
    headIcon = {path = "HeadIcon",type = "RawImage"},
    rare = {path = "Rare",type = "Image"},
    name = {path = "Name",type = "Text"},
}

function NewHeadItemModel.New()
    local self = {}
    setmetatable(self, NewHeadItemModel)
    return self
end

function NewHeadItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function NewHeadItemModel:SetData(data)
    self.transform.anchoredPosition = Vector2(11, self.transform.anchoredPosition.y)
    self.data = data.data.data
    if self.data == "" then return end
    local config = ConfigMgr.Config.characterTable[self.data]
    if config == nil then return end
    self.headIcon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(self.data,self.data.."001"))
    self.rare.sprite = LuaMgr.GetSprite("AreaMapRes","ui_dzr_tx"..config.rare)
    self.name.text = LuaMgr.GetLangText(config.namelan)
    self.gameObject:SetActive(true)
end

function NewHeadItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function NewHeadItemModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end