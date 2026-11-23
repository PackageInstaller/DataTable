SelectCharacter_WheelItem = {};

SelectCharacter_WheelItem.__index = SelectCharacter_WheelItem;
local objs = {
    rawIcon={ path = "root/Icon", type = "RawImage" },
    imgRare = { path = "root/Frame", type = "Image" },
    btnIcon={path = "root/Icon", type = "Button"}
}

function SelectCharacter_WheelItem.New()
    local self = {};
    setmetatable(self, SelectCharacter_WheelItem);
    return self;
end

function SelectCharacter_WheelItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnIcon,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index)
        end
    end)
end

function SelectCharacter_WheelItem:SetData(pdata)
    self.data = pdata.data;
    self.rawIcon.texture=self.data.icon;
    local imageRare = self.data.rare >= 5 and 4 or self.data.rare
    self.imgRare.sprite=LuaMgr.GetSprite("CommonRes","ui_home_kbn_tx"..imageRare);
    
end

function SelectCharacter_WheelItem:Clear()
    self.data = nil;
end

function SelectCharacter_WheelItem:Destroy()
    self.rawIcon=nil;
    self.imgRare =nil;
    self.btnIcon=nil;
    LuaMgr.DestroyImmediateGO(self.gameObject);
end