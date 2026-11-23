YPSMedalItem = {};

YPSMedalItem.__index = YPSMedalItem;

local objs = {   
    icon = { path = "Bg/Icon", type = "Image" },
    name = { path = "Bg/Name", type = "Text" },
    desc = { path = "Bg/Desc", type = "Text" },
    progress = { path = "Bg/Progress", type = "Text" },
    canvasGroup = { path = "Bg", type = "CanvasGroup" },
}

function YPSMedalItem.New()
    local self = {};
    setmetatable(self, YPSMedalItem);
    return self;
end

function YPSMedalItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function YPSMedalItem:SetData(pdata)
    local cache = pdata.data
    self.data = cache.data
    self.icon.sprite = self.data.icon
    self.name.text = tostring(self.data.name)
    self.desc.text = tostring(self.data.remark)
    self.progress.text = tostring(cache.progress)
    self.canvasGroup.alpha = cache.isFinish and 1 or 0.5
    
    SetActive(self.gameObject, true)
end

function YPSMedalItem:Hide()
    SetActive(self.gameObject, false)
end

function YPSMedalItem:Clear()
    self.data = nil
end

function YPSMedalItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject) 
    self.icon = nil
    self.name = nil
    self.desc = nil
    self.progress = nil
    self.canvasGroup = nil
end