




SingleAttrItemModel = {}
SingleAttrItemModel.__index = SingleAttrItemModel
local objs = {
    a_Attr = {path = "A_Attr",type = "GameObject"},
    a_attrName = {path = "A_Attr/AttrName",type = "Text"},
    a_attrNum = {path = "A_Attr/AttrNum",type = "Text"},
    
    n_Attr = {path = "N_Attr",type = "GameObject"},
    n_attrName = {path = "N_Attr/AttrName",type = "Text"},
    n_attrNum = {path = "N_Attr/AttrNum",type = "Text"},
}

SingleAttrItemModel.New = function(container)
    local self = {}
    setmetatable(self, SingleAttrItemModel)
    self.prefabPath = "Assets/_BundleResources/UI/HeroSpeciality/SingleAttrItem.prefab"
    self.object = LuaMgr.GetPrefab(self.prefabPath)
    LuaMgr.AddPrefabRefCount(self.prefabPath)
    self.object.transform:SetParent(container, false)
    self.rectTransform = self.object.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    return self
end

function SingleAttrItemModel:SetData(index,attrName,attrValue,attrType,isActive)
    self.index = index
    self.isActive = isActive
    SetActive(self.a_Attr,isActive)
    self.a_attrName.text = attrName
    self.a_attrNum.text = "+"..attrValue..attrType
    
    SetActive(self.n_Attr,not isActive)
    self.n_attrName.text = attrName
    self.n_attrNum.text = "+"..attrValue..attrType
    self.object.gameObject:SetActive(true)
end

function SingleAttrItemModel:Hide()
    self.object.gameObject:SetActive(false)
end

function SingleAttrItemModel:Clear()
    self.index = nil
    self.isActive = nil
    self.rectTransform = nil
    LuaMgr.RemovePrefabRefCount(self.prefabPath)
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
    self.prefabPath = nil
end