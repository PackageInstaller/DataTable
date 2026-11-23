CrisisContract2MedalItem = {};

CrisisContract2MedalItem.__index = CrisisContract2MedalItem;

local objs = {
    bg_1 = { path = "Group/Bg1", type = "GameObject" },
    bg_2 = { path = "Group/Bg2", type = "GameObject" },
    icon = { path = "Group/Icon", type = "Image" },
    name = { path = "Group/Name", type = "Text" },
    desc = { path = "Group/Desc", type = "Text" },
    progress = { path = "Group/Progress", type = "Text" },
    canvasGroup = { path = "", type = "CanvasGroup" },
}

function CrisisContract2MedalItem.New()
    local self = {};
    setmetatable(self, CrisisContract2MedalItem);
    return self;
end

function CrisisContract2MedalItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end

function CrisisContract2MedalItem:SetData(pdata)
    self.data = pdata.data
    SetActive(self.bg_1, self.data.isFinish)
    SetActive(self.bg_2, not self.data.isFinish)
    self.icon.sprite = self.data.icon
    self.name.text = tostring(self.data.name)
    self.desc.text = tostring(self.data.remark)
    self.progress.text = tostring(self.data.progress)
    self.canvasGroup.alpha = self.data.isFinish and 1 or 0.7
    
    SetActive(self.gameObject, true)
end

function CrisisContract2MedalItem:Hide()
    SetActive(self.gameObject, false)
end

function CrisisContract2MedalItem:Clear()
    self.data = nil
end

function CrisisContract2MedalItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.bg_1 = nil
    self.bg_2 = nil
    self.icon = nil
    self.name = nil
    self.desc = nil
    self.progress = nil
    self.canvasGroup = nil
end