
Block_UnLockProgressItem = {};

Block_UnLockProgressItem.__index = Block_UnLockProgressItem;
local objs = {
    imgIcon={ path = "root/icon", type = "Image" },
    imgFillAmount={ path = "root/slider/fillAmount", type = "Image" },
    txtValue={ path = "root/sliderValue", type = "Text" },
};

function Block_UnLockProgressItem.New(parent)
    local self = {};
    setmetatable(self, Block_UnLockProgressItem);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/UnLockProgressItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self:Init();
    return self;
end

function Block_UnLockProgressItem:Init()
    UITool.Parse(self.gameObject, self, objs);

end

function Block_UnLockProgressItem:SetData(gridId,data)
    self.data=data;
    self.imgFillAmount.fillAmount=data;
    self.txtValue.text=string.format("%.1f%%",data*100);
end

function Block_UnLockProgressItem:Clear()
   self.data=nil;
end

function Block_UnLockProgressItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end