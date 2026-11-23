SealEditor_Item = {};

SealEditor_Item.__index = SealEditor_Item;
local objs = {
  
    goItem_free={ path = "free", type = "GameObject" },
    goItem_active={ path = "active", type = "GameObject" },
    rawItem={ path = "active", type = "RawImage" },
    btn={path="btn",type="Button"};

}

function SealEditor_Item.New()
    local self = {};
    setmetatable(self, SealEditor_Item);
    self.isActive=false;
    return self;
end

function SealEditor_Item:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btn,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end




function SealEditor_Item:SetData(pdata)
    self.data = pdata.data
    self.transform.anchoredPosition=self.data.pos
    SetActive(self.goItem_free,not self.data.isActive)
    SetActive(self.goItem_active, self.data.isActive)
    if self.data.isActive then
        self.rawItem.texture=self.data.rawTexture;
        self.rawItem.transform.localScale=Vector3.one*self.data.scale;
    end
    
end



function SealEditor_Item:Clear()
    self.data = nil;
end

function SealEditor_Item:Destroy()
    self.goItem_free=nil;
    self.goItem_active=nil;
    self.rawItem=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end