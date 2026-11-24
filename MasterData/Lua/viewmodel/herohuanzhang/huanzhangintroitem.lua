





HuanZhangIntroItem = {}
HuanZhangIntroItem.__index = HuanZhangIntroItem
local objs = {
    tag_1 = {path = "Tag1",type = "GameObject"},
    tagText_1 = {path = "Tag1/Text",type = "Text"},
    tag_2 = {path = "Tag2",type = "GameObject"},
    tagText_2 = {path = "Tag2/Text",type = "Text"},
    tag_3 = {path = "Tag3",type = "GameObject"},
    tagText_3 = {path = "Tag3/Text",type = "Text"},
}

HuanZhangIntroItem.New = function(prefab,container)
    local self = {}
    setmetatable(self, HuanZhangIntroItem)
    self.container = container
    self.object = LuaMgr.InstantiateGO(prefab, container, false)
    self.transform = self.object.transform
    self.rectTransform = self.transform:GetComponent("RectTransform")
    UITool.Parse(self.object,self,objs)
    return self
end

function HuanZhangIntroItem:SetData(data,isTag)
    self.data = data
    local selfText = self.transform:GetComponent("Text")
    local strList = Split(self.data,"|")
    selfText.text = strList[1]
    if isTag then
        self.transform.sizeDelta = Vector2(selfText.preferredWidth,24)
    else
        self.transform.sizeDelta = Vector2(460,selfText.preferredHeight)
    end
    SetActive(self.tag_1,#strList > 1)
    self.tagText_1.text = #strList > 1 and strList[2] or ""
    SetActive(self.tag_2,#strList > 2)
    self.tagText_2.text = #strList > 2 and strList[3] or ""
    SetActive(self.tag_3,#strList > 3)
    self.tagText_3.text = #strList > 3 and strList[4] or ""
    self.object.gameObject:SetActive(true)
end

function HuanZhangIntroItem:Hide()
    self.data = nil
    self.object.gameObject:SetActive(false)
end

function HuanZhangIntroItem:Clear()
    self.data = nil
    self.transform = nil
    LuaMgr.DestroyImmediateGO(self.object)
    self.object = nil
end