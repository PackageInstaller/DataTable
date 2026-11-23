




MaterialItem = {}
MaterialItem.__index = MaterialItem
local countColor = "<color=#FF0000>%d</color>"
local objs = {
    rare = {path = "Rare",type = "Image"},
    icon = {path = "Icon",type = "RawImage"},
    countText = {path = "Count/Text",type = "Text"},
    goodsBtn = {path = "Icon",type = "UIButtonClick"},
}

MaterialItem.New = function(container)
    local self = {}
    setmetatable(self, MaterialItem)
    self.container = container
    self.prefabPath = "Assets/_BundleResources/UI/Common/MaterialItem.prefab"
    self.object = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.transform = self.object.transform
    self.transform:SetParent(container, false)
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    

    self.GoodsCommand = function()

        if self.needCount > DataHelper.GetItemCountById(self.itemId) then
            HeroParameter.SaveTarItem(self.itemId,self.needCount - DataHelper.GetItemCountById(self.itemId))
        end
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,self.itemId,true,true,true,0,self.needCount);
    end
    LuaMgr.AddClick(self.goodsBtn,self.GoodsCommand)
    return self
end

function MaterialItem:SetData(index,itemId,needCount,scale)
    self.index = index
    self.itemId = itemId
    self.needCount = needCount
    self.rectTransform.localScale = Vector3(scale,scale,1)
    self:RefreshGoodsData()
    
    self.object.gameObject:SetActive(true)
end


function MaterialItem:RefreshGoodsData()
    local rare = ConfigMgr.Config.itemMap[self.itemId].rare
    local haveCount = DataHelper.GetItemCountById(self.itemId)
    if haveCount < self.needCount then
        haveCount = string.format(countColor,LuaMgr.NumFormat(haveCount))
    else
        haveCount = LuaMgr.NumFormat(haveCount)
    end
    self.rare.sprite = GetRareSprite(rare)
    self.icon.texture = GetItemTexture(self.itemId)
    self.countText.text = haveCount.."/"..LuaMgr.NumFormat(self.needCount)
end

function MaterialItem:Hide()
    self.itemId = ""
    self.object.gameObject:SetActive(false)
end

function MaterialItem:Clear()
    self.container = nil
    self.rectTransform = nil
    self.rare = nil
    self.icon = nil
    self.goodsBtn = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end