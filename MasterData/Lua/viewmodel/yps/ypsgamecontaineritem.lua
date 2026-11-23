YPSGameContainerItem = {};

YPSGameContainerItem.__index = YPSGameContainerItem;

local objs = {
    anim = { path = "", type = "Animator" },
    button = { path = "", type = "Button" },
    group = { path = "Group", type = "GameObject" },
    iconTF = { path = "Group/Icon", type = "Transform" },
    icon = { path = "Group/Icon", type = "RawImage" },    
    textT = { path = "Group/Text", type = "Text" },
}

function YPSGameContainerItem.New(prefab, parent)
    local self = {};
    setmetatable(self, YPSGameContainerItem);
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false);
    self.transform = self.gameObject.transform:GetComponent("RectTransform");
    self.index = 0;   
    UITool.Parse(self.gameObject, self, objs);
    self.tween = nil;
    self.OnClickItem = function()
        if (self.data.callback ~= nil) then
            self.data.callback()
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem);
    return self;
end

function YPSGameContainerItem:SetData(index, data)
    self.index = index;
    self.data = data
    self.config = data.config
    self:SetIcon(self.config.Icon);   
    self:ShowItem(true);
    self:SetLight(false);  
    self.textT.text = self.config.Id
end

function YPSGameContainerItem:SetIcon(resId)
    self.icon.texture = YPSGameMgr.GetTexture(resId);
end

function YPSGameContainerItem:ShowItem(bShow)
    SetActive(self.group, bShow)
    self.button.enabled = bShow;  
end



function YPSGameContainerItem:SetLight(status)    
    self.anim.enabled = status;
end

function YPSGameContainerItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.button, self.OnClickItem);
        self.OnClickItem = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end