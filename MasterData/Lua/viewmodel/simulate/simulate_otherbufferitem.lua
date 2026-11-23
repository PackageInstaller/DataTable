Simulate_OtherBufferItem = {};

Simulate_OtherBufferItem.__index = Simulate_OtherBufferItem;

local objs = {
    goTag1={path="root/tag1",type="GameObject"},
    goTag2={path="root/tag2",type="GameObject"},
    btnBg={path="root/bg",type="Button"},
}



function Simulate_OtherBufferItem.New(parent)
    local self = {};
    setmetatable(self, Simulate_OtherBufferItem);
    local path="Assets/_BundleResources/UI/Simulate/otherBuff.prefab";
    self.gameObject = LuaMgr.GetPrefab(path);
    self.transform=self.gameObject.transform;
    if self.gameObject~=nil then
        self.gameObject.transform:SetParent(parent,false);
        self.gameObject.transform.localPosition = Vector3.zero;
        self.gameObject.transform.localScale=Vector3.one;
    end
    self:Init();
    return self;
end


function Simulate_OtherBufferItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg,function()
        if self.callBack~=nil then
            self.callBack();
        end
    end)
end


function Simulate_OtherBufferItem:SetData(type,pos,callBack)
    self.transform.anchoredPosition=Vector2(pos.x,pos.y+140);
    SetActive(self.goTag1,type==1)
    SetActive(self.goTag2,type==2)
    self.callBack=callBack;
end
    


function Simulate_OtherBufferItem:Clear()
end


function Simulate_OtherBufferItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
end

