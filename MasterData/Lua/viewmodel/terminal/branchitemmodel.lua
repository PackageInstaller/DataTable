




require("ViewModel/Terminal/BranchNumModel")

BranchItemModel = {}

BranchItemModel.__index = BranchItemModel

local objs = {
    icon = {path = "Icon", type = "RawImage"},
    nameText = {path = "Name", type = "Text"},
    numRoot = {path = "NumRoot",type = "Transform"}
}

function BranchItemModel.New()
    local self = {}
    setmetatable(self, BranchItemModel)
    return self
end

function BranchItemModel:Init()
    self.itemList = {}
    UITool.Parse(self.gameObject, self, objs)
end

function BranchItemModel:SetData(data)
    self.data = data.data
    local path = Path.BranchPlotPath..self.data.branch.Icon..".png"
    self.icon.texture = LuaMgr.GetTexture(path)
    self.nameText.text = LuaMgr.GetLangText(self.data.branch.BranchNameLan)
    self:SetNumRoot()
    self.gameObject:SetActive(true)
end

function BranchItemModel:SetNumRoot()
    if self.data.branch.BranchPlotId == nil or #self.data.branch.BranchPlotId == 0 then return end
    for i = 1, #self.data.branch.BranchPlotId do
        if #self.itemList < i then
            table.insert(self.itemList,BranchNumModel.New(self.data.item,self.numRoot))
        end
        self.itemList[i]:SetData(i,self.data.branch.BranchPlotId[i])
    end
end

function BranchItemModel:Clear()
    self.data = nil
    for i = 1, #self.itemList do
        self.itemList[i]:Clear()
    end
    self.gameObject:SetActive(false)
end

function BranchItemModel:Destroy()
    for i = 1, #self.itemList do
        self.itemList[i]:Destroy()
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.itemList = nil
    self.gameObject = nil
end