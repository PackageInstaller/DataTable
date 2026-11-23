Rogue_ExploreEventItem = {};

Rogue_ExploreEventItem.__index = Rogue_ExploreEventItem;

local objs = { 
    bgBtn = { path = "root/BG", type = "Button" },
    titleTxt = { path = "root/BG/content/title", type = "Text" },
    infoTxt = { path = "root/BG/content/info", type = "Text" },
};

function Rogue_ExploreEventItem.New()
    local self = {};
    setmetatable(self, Rogue_ExploreEventItem);
    return self;
end

function Rogue_ExploreEventItem:Init()
    UITool.Parse(self.gameObject, self, objs);
    self.OnClickItem = function()
        if (self.data.index~=nil  and self.data.callBack ~= nil) then
            self.data.callBack(self.data.index)
        end
    end
    LuaMgr.AddClick(self.bgBtn, self.OnClickItem);
end

function Rogue_ExploreEventItem:SetData(data)
    self.data = data.data;
    local titles=NumTool.split(self.data.title,"|")
    if #titles>1 then
        SetActive(self.infoTxt.gameObject,true);
        self.titleTxt.text=titles[1];
        self.infoTxt.text=titles[2];
    else
        SetActive(self.infoTxt.gameObject,false);
        self.titleTxt.text=self.data.title;
    end
end


function Rogue_ExploreEventItem:Clear()
    self.data = nil;
end

function Rogue_ExploreEventItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end