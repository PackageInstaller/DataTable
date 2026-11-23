SpringCampPrepareConditionItem = {};

SpringCampPrepareConditionItem.__index = SpringCampPrepareConditionItem;

local objs = {
    winBg = { path = "WinBg", type = "GameObject" },
    loseBg = { path = "LoseBg", type = "GameObject" },
    content = { path = "Content", type = "Text" },
};

function SpringCampPrepareConditionItem.New()
    local self = {};    
    setmetatable(self, SpringCampPrepareConditionItem);
    return self;
end

function SpringCampPrepareConditionItem:Init()    
    UITool.Parse(self.gameObject, self, objs);
end

function SpringCampPrepareConditionItem:SetData(data)
    SetActive(self.winBg, data.data.type == "0");
    SetActive(self.loseBg, data.data.type == "1");
    self.content.text = data.data.content;
end

function SpringCampPrepareConditionItem:Clear()
end

function SpringCampPrepareConditionItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end