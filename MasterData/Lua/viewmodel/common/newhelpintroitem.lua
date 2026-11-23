





NewHelpIntroItem = {}

NewHelpIntroItem.__index = NewHelpIntroItem

local objs = {
    numImg = {path = "Num",type = "Image"},
    numText = {path = "Num/Text",type = "Text"},
}

function NewHelpIntroItem.New(prefab, parent)
    local self = {}
    setmetatable(self, NewHelpIntroItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.text = self.gameObject:GetComponent("Text")
    UITool.Parse(self.gameObject, self, objs)
    return self
end

function NewHelpIntroItem:SetData(data,num,helpType)
    self.data = data
    self.num = num
    self.helpType = helpType
    
    local numColor,textColor = nil,nil
    if helpType == 1 then
        self.gameObject.transform.sizeDelta = Vector2(466,self.gameObject.transform.sizeDelta.y)
        numColor = UnityEngine.Color(145 / 255, 124 / 255, 102 / 255, 1)
        textColor = UnityEngine.Color(1, 1, 1, 1)
    elseif helpType == 2 then
        self.gameObject.transform.sizeDelta = Vector2(312,self.gameObject.transform.sizeDelta.y)
        numColor = UnityEngine.Color(141 / 255, 72 / 255, 58 / 255, 1)
        textColor = UnityEngine.Color(38 / 255, 36 / 255, 51 / 255, 1)
    end
    self.numImg.color = numColor
    self.text.color = textColor
    self.text.text = data
    self.numText.text = num
    self.gameObject:SetActive(true)
end

function NewHelpIntroItem:Clear()
    self.data = nil
    self.num = nil
    self.helpType = nil
    self.gameObject:SetActive(false)
end

function NewHelpIntroItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end