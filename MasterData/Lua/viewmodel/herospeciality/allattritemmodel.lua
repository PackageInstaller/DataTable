





AllAttrItemModel = {}
AllAttrItemModel.__index = AllAttrItemModel
local objs = {
    attrIcon = {path = "AttrIcon",type = "Image"},
    attrName = {path = "AttrName",type = "Text"},
    attrValue = {path = "AttrValue",type = "Text"},
}

AllAttrItemModel.New = function(container)
    local self = {}
    setmetatable(self, AllAttrItemModel)
    self.prefabPath = "Assets/_BundleResources/UI/HeroSpeciality/AllAttrItem.prefab"
    self.object = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.object.transform:SetParent(container, false)
    self.rectTransform = self.object.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    return self
end

function AllAttrItemModel:SetData(index,attrDes)
    self.index = index
    self.attrName.text = attrDes.attrName
    self.attrValue.text = "+"..attrDes.attrValue..attrDes.attrType
    self.attrIcon.sprite = LuaMgr.GetSprite("AttributeIcon",attrDes.iconName)
    self.object.gameObject:SetActive(true)
end

function AllAttrItemModel:Hide()
    self.object.gameObject:SetActive(false)
end

function AllAttrItemModel:Clear()
    self.index = nil
    self.rectTransform = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
    self.prefabPath = nil
end