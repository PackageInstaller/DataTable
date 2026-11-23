








SSYXRewardItem = {}
SSYXRewardItem.__index = SSYXRewardItem

local objs = {
    uiButton = {path = "", type = UITool.Button},
    uiItem = {path = "Item", type = UITool.Transform},
    uiItemImg = {path = "Item", type = UITool.Image},
    uiIcon = {path = "Item/Icon", type = UITool.Image},
    uiCountText = {path = "Item/Count/Text", type = UITool.Text},
    uiCount = {path = "Item/Count", type = UITool.GameObject}
}

SSYXRewardItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXRewardItem)
    self.gameObject = obj
    self.transform = self.gameObject.transform
    UITool.Parse(self.gameObject, self, objs)
    local callback = function()
        LuaMgr.ShowLuaPanel(UIName.SSYXGoodsTipsPopup, self.data)
    end
    LuaMgr.AddClick(self.uiButton, callback)
    return self
end

function SSYXRewardItem:SetData(data)
    self.data = data
    self:SetData1(self.data.ID, self.data.Count, 1, 1)
end

function SSYXRewardItem:SetData1(id, count, showType, scale)
    self.id = id
    if self.data.IsInBag == true then
        local config = ConfigMgr.Config.itemMap[id]
        if self.data.NeedSetRare == true then
            self.uiItemImg.sprite = LuaMgr.GetSprite("ItemRare", "itemRare" .. config.rare)
        end
        local texture = GetItemTexture(self.data.ID)
        local sprite = LuaMgr.Texture2DToSprite(texture)
        self.uiIcon.sprite = sprite
    else
        self.uiIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, self.data.Icon)
    end
    if showType == ItemShowType.NONE then
        self.uiCount:SetActive(false)
    else
        self.uiCountText.text = LuaMgr.NumFormat(count)
        self.uiCount:SetActive(count >= 0)
    end
    self.uiItem.localScale = Vector3(scale, scale, 1)
end

function SSYXRewardItem:Clear()
    if self.gameObject ~= nil then
        self.gameObject:SetActive(false)
    end
end

function SSYXRewardItem:Destroy()
    self.transform = nil
    if self.gameObject ~= nil then
        LuaMgr.DestroyGO(self.gameObject)
        self.gameObject = nil
    end
end