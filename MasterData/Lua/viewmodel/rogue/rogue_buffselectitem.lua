Rogue_BuffSelectItem = {};

Rogue_BuffSelectItem.__index = Rogue_BuffSelectItem;

local objs = { 
    norBtn={ path = "root/nor", type = "Button" },
    goNor = { path = "root/nor", type = "GameObject" },
    goSelect = { path = "root/selet", type = "GameObject" },
    imgRare={ path = "root/rare", type = "Image" },
    imgIcon={ path = "root/rare/icon", type = "Image" },
    goNoGet={ path = "root/noget", type = "GameObject" },
    goPush= {path = "root/push", type = "GameObject" },
    txtName={path = "root/name", type = "Text" },
    txtDes={path = "root/ScrollView/Viewport/des", type = "Text" },
};

function Rogue_BuffSelectItem.New()
    local self = {};
    setmetatable(self, Rogue_BuffSelectItem);
    return self;
end

function Rogue_BuffSelectItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.index~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.norBtn, self.OnClickItem);
end

function Rogue_BuffSelectItem:SetData(data)
    self.data = data.data;
    self:SetSelect(self.data.isSelect)
    self.imgRare.sprite=LuaMgr.GetSprite("Rogue","ui_xhyt_csqzxbfd_0"..self.data.rare)
    self.imgIcon.sprite=LuaMgr.GetSprite("BuffIcon",self.data.iconName)
    self.txtName.text=self.data.name;
    self.txtDes.text=self.data.des;
    SetActive(self.goPush,self.data.isPush);
    SetActive(self.goNoGet,not self.data.isPush and self.data.isNoGet)
end

function Rogue_BuffSelectItem:SetSelect(isOn)
    SetActive(self.goSelect,isOn)
    SetActive(self.goNor,not isOn)
end

function Rogue_BuffSelectItem:Clear()
    self.data = nil;
end

function Rogue_BuffSelectItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end