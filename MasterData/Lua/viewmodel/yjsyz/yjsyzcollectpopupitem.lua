




YJSYZCollectPopupItem = {}
YJSYZCollectPopupItem.__index = YJSYZCollectPopupItem

local objs = {
    icon = {path = "Bg/Image/Icon", type = "Image"},
    name = {path = "Bg/Name", type = "Text"},
    desc = {path = "Bg/Desc", type = "Text"},
    progress = {path = "Bg/Progress", type = "Text"},
    canvasGroup = {path = "Bg", type = "CanvasGroup"}
}

function YJSYZCollectPopupItem.New()
    local self = {}
    setmetatable(self, YJSYZCollectPopupItem)
    return self
end

function YJSYZCollectPopupItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function YJSYZCollectPopupItem:SetData(pdata)
    local cache = pdata.data
    self.data = cache.data
    self.icon.sprite = self.data.icon
    self.name.text = tostring(self.data.name)
    self.desc.text = tostring(self.data.remark)
    self.progress.text = tostring(cache.progress)
    self.canvasGroup.alpha = cache.isFinish and 0.6 or 1


end

function YJSYZCollectPopupItem:Hide()

end

function YJSYZCollectPopupItem:Clear()
    self.data = nil
end

function YJSYZCollectPopupItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.icon = nil
    self.name = nil
    self.desc = nil
    self.progress = nil
    self.canvasGroup = nil
end