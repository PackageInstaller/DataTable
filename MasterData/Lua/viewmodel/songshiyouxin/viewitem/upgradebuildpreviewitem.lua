





UpgradeBuildPreviewItem = {}
UpgradeBuildPreviewItem.__index = UpgradeBuildPreviewItem

local objs = {
    name = {path = "Name", type = UITool.Text},
    upBeforeAttr = {path = "Group/UpBeforeAttr", type = UITool.Text},
    upAfterAttr = {path = "Group/UpAfterAttr", type = UITool.Text}
}

UpgradeBuildPreviewItem.New = function(obj)

    local self = {}
    setmetatable(self, UpgradeBuildPreviewItem)
    self.gameObject = obj
    self:Init()
    return self
end

function UpgradeBuildPreviewItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function UpgradeBuildPreviewItem:SetData(data)
    self.data = data
    if self.data.Name then
        self.name.text = self.data.Name
    end
    self.upBeforeAttr.text = self.data.UpBeforeAttr
    self.upAfterAttr.text = self.data.UpAfterAttr
end

function UpgradeBuildPreviewItem:ClearItems()
end

function UpgradeBuildPreviewItem:Clear()
    self:ClearItems()
end

function UpgradeBuildPreviewItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end