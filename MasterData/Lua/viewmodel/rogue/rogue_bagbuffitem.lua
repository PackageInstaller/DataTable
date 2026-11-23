Rogue_BagBuffItem = {};

Rogue_BagBuffItem.__index = Rogue_BagBuffItem;

local objs = { 
    rootBtn = { path = "root", type = "Button" },
    bgImg = { path = "root/bg", type = "Image" },
    iconImg = { path = "root/bg/icon", type = "Image" },
    nameTxt = { path = "root/namebg/Text", type = "Text" },
    selectObj = { path = "root/select", type = "GameObject" },
};

function Rogue_BagBuffItem.New()
    local self = {};
    setmetatable(self, Rogue_BagBuffItem);
    return self;
end

function Rogue_BagBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.maskTf = self.rootBtn.transform:Find("Mask")
    self.OnClickItem = function()
        if (self.data.index~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.rootBtn, self.OnClickItem);
end

function Rogue_BagBuffItem:SetData(data)
    self.data = data.data;
    self.bgImg.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..self.data.rare)
    self.iconImg.sprite=LuaMgr.GetSprite("BuffIcon",self.data.icon)
    self.nameTxt.text=self.data.name;
    self:SetSelect(self.data.isOn)
    if self.maskTf ~= nil then
        SetActive(self.maskTf.gameObject, self.data.isLock)
    end
    SetActive(self.gameObject, true);
end

function Rogue_BagBuffItem:SetSelect(isOn)
    SetActive(self.selectObj,isOn);
end

function Rogue_BagBuffItem:Clear()
    self.data = nil;
    SetActive(self.gameObject, false);
end

function Rogue_BagBuffItem:Destroy()
    LuaMgr.RemoveClick(self.rootBtn, self.OnClickItem);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end