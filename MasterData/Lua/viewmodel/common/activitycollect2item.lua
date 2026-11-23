




ActivityCollect2Item = {}
ActivityCollect2Item.__index = ActivityCollect2Item

local objs = {
    icon = {path = "Bg/Icon", type = "Image"},
    name = {path = "Bg/Name", type = "Text"},
    desc = {path = "Bg/Desc", type = "Text"},
    progress = {path = "Bg/Progress", type = "Text"},
    canvasGroup = {path = "Bg", type = "CanvasGroup"}
}

function ActivityCollect2Item.New()
    local self = {}
    setmetatable(self, ActivityCollect2Item)
    return self
end

function ActivityCollect2Item:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityCollect2Item:SetData(pdata)
    local cache = pdata.data
    self.data = cache.data
    self.icon.sprite = self.data.icon
    self.name.text = tostring(self.data.name)
    self.desc.text = tostring(self.data.remark)
    self.progress.text = tostring(cache.progress)
    self.canvasGroup.alpha = cache.isFinish and 0.6 or 1

    SetActive(self.gameObject, true)
end

function ActivityCollect2Item:Hide()
    SetActive(self.gameObject, false)
end

function ActivityCollect2Item:Clear()
    self.data = nil
end

function ActivityCollect2Item:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.icon = nil
    self.name = nil
    self.desc = nil
    self.progress = nil
    self.canvasGroup = nil
end