





ActivityCollectItem = {}
ActivityCollectItem.__index = ActivityCollectItem

local objs = {
    icon = {path = "Bg/Icon", type = "Image"},
    name = {path = "Bg/Name", type = "Text"},
    desc = {path = "Bg/Desc", type = "Text"},
    progress = {path = "Bg/Progress", type = "Text"},
    canvasGroup = {path = "Bg", type = "CanvasGroup"},
    darkBg = {path = "Bg/Dark", type = "GameObject"},
}

function ActivityCollectItem.New()
    local self = {}
    setmetatable(self, ActivityCollectItem)
    return self
end

function ActivityCollectItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function ActivityCollectItem:SetData(pdata)
    local cache = pdata.data
    self.data = cache.data
    self.icon.sprite = self.data.icon
    self.name.text = tostring(self.data.name)
    self.desc.text = tostring(self.data.remark)
    self.progress.text = tostring(cache.progress)
    SetActive(self.darkBg, cache.isFinish ~= true)
    SetActive(self.gameObject, true)
end

function ActivityCollectItem:Hide()
    SetActive(self.gameObject, false)
end

function ActivityCollectItem:Clear()
    self.data = nil
end

function ActivityCollectItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.icon = nil
    self.name = nil
    self.desc = nil
    self.progress = nil
    self.canvasGroup = nil
end