




HeroItemModel = {}

HeroItemModel.__index = HeroItemModel

local objs = {
    bgButton = {path = "BgButton", type = "Button"},
    avatar = {path = "State/Avatar", type = "RawImage"},
    name = {path = "Name",type = "GameObject"},
    nameText = {path = "Name/Text",type = "Text"},
}

function HeroItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, HeroItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.bgCommand = function()
        if DataMgr.Player.characters[self.data.id] ~= nil then
            LuaMgr.InvokeUIEventListeners(UIEventConst.CollectionAvatarClick, self.data.id)
        end
    end
    LuaMgr.AddClick(self.bgButton,self.bgCommand)
    return self
end

function HeroItemModel:SetData(data)
    self.data = data
    local config = ConfigMgr.Config.characterTable[self.data.id]
    local tempData = DataMgr.Player.characters[self.data.id]
    if self.data.isRelics then
        self.avatar.texture = LuaMgr.GetTexture(Path.RelicsIconPath.."head_"..self.data.id..".png")
    else
        self.avatar.texture = LuaMgr.GetTexture(Path.Monster_PATH..self.data.id.."/Avatar/"..self.data.id.."001"..".png")
    end
    if tempData == nil then
        local material = LuaMgr.GetMaterial("Assets/_BundleResources/Shader/Res/Materials/UISpriteGray.mat")
        self.avatar.material = material
        self.avatar.color = UnityEngine.Color(1,1,1,75 / 255)
    else
        self.avatar.material = material
        self.avatar.color = UnityEngine.Color(1,1,1,1)
    end
    self.nameText.text = LuaMgr.GetLangText(config.namelan)
    SetActive(self.name,tempData ~= nil)
    self.gameObject:SetActive(true)
end

function HeroItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function HeroItemModel:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.bgButton, self.bgCommand)
        self.bgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end