EventStoryItem = {};

EventStoryItem.__index = EventStoryItem;
local objs = {
    btnBg = { path = "root/bg", type = "Button" },
    txtDes= { path = "root/bg/des", type = "Text" },
    rawCostIcon={ path = "root/bg/icon", type = "RawImage" },
    txtCostCount={ path = "root/bg/count", type = "Text" },
};

function EventStoryItem.New()
    local self = {};
    setmetatable(self, EventStoryItem);
    return self;
end

function EventStoryItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    LuaMgr.AddClick(self.btnBg, function()
        if self.data.callBack~=nil then
            self.data.callBack(self.data.index);
        end
    end);
end


function EventStoryItem:SetData(data)
    self.data = data.data;
    self.txtDes.text=self.data.des;
    local path=ConfigHelper.GetItemHomeIconPath(self.data.cost.id)
    self.rawCostIcon.texture=LuaMgr.GetTexture(path)
    local countStr=self.data.isMatch and self.data.cost.count
            or string.format(LuaMgr.GetLangText("EventStoryItem_0"),self.data.cost.count);
    self.txtCostCount.text=LuaMgr.GetLangText("EventStoryItem_1")..countStr;
end


function EventStoryItem:Clear()
    self.data = nil;

end

function EventStoryItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end