





PhotoItemModel = {}

PhotoItemModel.__index = PhotoItemModel

function PhotoItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, PhotoItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.picTexture = self.gameObject:GetComponent("RawImage")
    return self
end

function PhotoItemModel:SetData(data)
    self.data = data
    if DataMgr.Player.characters[self.data] ~= nil then
        self.picTexture.color = UnityEngine.Color(1,1,1,1)
    else
        self.picTexture.color = UnityEngine.Color(0.18,0.18,0.18,1)
    end
    local config = ConfigMgr.Config.GroupPhotoConfigMap[self.data]
    if config ~= nil then
        local position = config.Position
        self.transform.anchoredPosition = Vector2(position[1],position[2])
        local widthHeight = config.WidthHeight
        self.transform.sizeDelta = Vector2(widthHeight[1],widthHeight[2])
    end
    self.picTexture.texture = ConfigHelper.GetHeroDrawingTexture(self.data,self.data.."001")
    self.gameObject:SetActive(true)
end

function PhotoItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function PhotoItemModel:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end