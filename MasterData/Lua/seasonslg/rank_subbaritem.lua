
Rank_SubBarItem = {};

Rank_SubBarItem.__index = Rank_SubBarItem;
local objs = {
    txtName1 = { path = "root/off/Text", type = "Text" },
    txtName2 = { path = "root/on/Text", type = "Text" },
    btnBar= { path = "root/off", type = "Button" },
    uiGray={ path = "root/off", type = "UIGray" },

};

function Rank_SubBarItem.New()
    local self = {};
    setmetatable(self, Rank_SubBarItem);
    return self;
end

function Rank_SubBarItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBar,function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end)
end


function Rank_SubBarItem:SetData(data)
    self.data=data.data;
    self.txtName1.text=self.data.name;
    self.txtName2.text=self.data.name;
    SetActive(self.txtName1.transform.parent.gameObject,not self.data.isOn);
    SetActive(self.txtName2.transform.parent.gameObject, self.data.isOn);
    self.uiGray.IsGray=not self.data.isUnlock or self.data.isEnd;
end

function Rank_SubBarItem:Clear()
    self.data=nil;
end

function Rank_SubBarItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end