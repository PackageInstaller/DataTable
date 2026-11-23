MiniBattle4BuffGroupItem = {};

MiniBattle4BuffGroupItem.__index = MiniBattle4BuffGroupItem;

local objs = {
    BuffClickBtn_1 = { path = "Group/BuffItem_1", type = "UIButtonClick" },
    BuffClickBtn_2 = { path = "Group/BuffItem_2", type = "UIButtonClick" },
    BuffName_1 = { path = "Group/BuffItem_1/Text", type = "Text" },
    BuffName_2 = { path = "Group/BuffItem_2/Text", type = "Text" },
}

function MiniBattle4BuffGroupItem.New()
    local self = {};
    setmetatable(self, MiniBattle4BuffGroupItem);
    return self;
end

function MiniBattle4BuffGroupItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem_1 = function()
        LuaMgr.ShowLuaPanel(UIName.MiniBattle4BuffCardInfoPopup, self.data.cardId_1);
    end
    self.OnClickItem_2 = function()
        LuaMgr.ShowLuaPanel(UIName.MiniBattle4BuffCardInfoPopup, self.data.cardId_2);
    end
    LuaMgr.AddClick(self.BuffClickBtn_1, self.OnClickItem_1);
    LuaMgr.AddClick(self.BuffClickBtn_2, self.OnClickItem_2);
end


function MiniBattle4BuffGroupItem:SetData(pdata)
    self.data = pdata.data;
    
    self.BuffName_1.text = self.data.name_1;
    self.BuffName_2.text = self.data.name_2;
    SetActive(self.BuffClickBtn_2.gameObject, not IsNullOrEmpty(self.data.cardId_2))
    SetActive(self.gameObject, true)
end

function MiniBattle4BuffGroupItem:Clear()
    self.data = nil;
end

function MiniBattle4BuffGroupItem:Destroy()
    if (self.OnClickItem_1 ~= nil) then
        LuaMgr.RemoveClick(self.BuffClickBtn_1, self.OnClickItem_1);
        self.OnClickItem_1 = nil;
    end
    if (self.OnClickItem_2 ~= nil) then
        LuaMgr.RemoveClick(self.BuffClickBtn_2, self.OnClickItem_2);
        self.OnClickItem_2 = nil;
    end
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end