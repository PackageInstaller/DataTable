Rogue_BagBuffTypeItem = {};

Rogue_BagBuffTypeItem.__index = Rogue_BagBuffTypeItem;

local objs = { 
    iconImg = { path = "root/icon", type = "Image" },
    bgBtn={ path = "root/BG", type = "Button" },
    selectObj={ path = "root/BG/select", type = "GameObject" },
};

function Rogue_BagBuffTypeItem.New()
    local self = {};
    setmetatable(self, Rogue_BagBuffTypeItem);
    return self;
end

function Rogue_BagBuffTypeItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.type~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.type)
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.OnClickItem);
end


function Rogue_BagBuffTypeItem:SetData(data)
    self.data = data.data;
    self.iconImg.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_lscksxicon_0"..self.data.type)
    self:SetSelect(self.data.isOn);
end

function Rogue_BagBuffTypeItem:SetSelect(isOn)
    SetActive(self.selectObj,isOn);
end

function Rogue_BagBuffTypeItem:Clear()
    self.data = nil;
end

function Rogue_BagBuffTypeItem:Destroy()
    LuaMgr.RemoveClick(self.bgBtn, self.OnClickItem);
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end