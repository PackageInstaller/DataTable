









JZQWGameActivateObjItem = {}
JZQWGameActivateObjItem.__index = JZQWGameActivateObjItem

JZQWGameActivateObjItem.Scale = Vector3(0.83, 0.83, 1)
local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    statusImage = {path = "", type = UITool.Image},
    nameText = {path = "TextName", type = UITool.Text},
    button = {path = "", type = UITool.Button},
    canActivateFlag = {path = "CanActivateFlag", type = UITool.GameObject}
}
JZQWGameActivateObjItem.DebugColor = {
    UnityEngine.Color.white,
    UnityEngine.Color.red,
    UnityEngine.Color.blue,
    UnityEngine.Color.green
}

JZQWGameActivateObjItem.New = function(obj)

    local self = {}
    setmetatable(self, JZQWGameActivateObjItem)
    self.gameObject = obj
    self:Init()
    return self
end

function JZQWGameActivateObjItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickButton = function()
        if self.data.OnClickActivateObj ~= nil then
            self.data.OnClickActivateObj(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickButton)
    self.gameObject.transform.localScale = JZQWGameActivateObjItem.Scale
end

function JZQWGameActivateObjItem:SetData(data)
    self.data = data
    self.rectTrans.anchoredPosition = self.data:GetPos()
    if self.data.Config.Type == JZQWConst.ActivateType.NPC then
        self.gameObject.transform:SetAsFirstSibling()
    end
    self:Refresh()

    SetActive(self.gameObject, self.data.IsShow == true)
    if self.data.Config.InteractType < 1 then
        self.button.interactable = false
        SetActive(self.nameText.gameObject, false)
        SetActive(self.canActivateFlag, false)
        self.statusImage.raycastTarget = false
    else
        self.button.interactable = true
        SetActive(self.nameText.gameObject, true)
        SetActive(self.canActivateFlag, true)
        self.statusImage.raycastTarget = true
    end
end

function JZQWGameActivateObjItem:Refresh()
    local statusName = self.data:GetStatusImageName()
    if statusName == nil then
        self.statusImage.sprite = nil

        self.statusImage.color = JZQWGameActivateObjItem.DebugColor[self.data.Status] or JZQWGameActivateObjItem.DebugColor[1]
    else
        self.statusImage.sprite = LuaMgr.GetSprite(JZQWConst.GameAtlasName, statusName)
        if IsNull(self.statusImage.sprite) then

            self.statusImage.color = JZQWGameActivateObjItem.DebugColor[self.data.Status] or JZQWGameActivateObjItem.DebugColor[1]
        else

        end
    end
    self.statusImage:SetNativeSize()
    self.nameText.text = LuaMgr.GetLangText(self.data.Config.NameLan)
    SetActive(self.gameObject, self.data.IsShow == true)
end

function JZQWGameActivateObjItem:GetRealSize()
    self.realSizeX = self.rectTrans.sizeDelta.x * JZQWConst.GameObjScale
    self.realSizeY = self.rectTrans.sizeDelta.y * JZQWConst.GameObjScale
    return self.realSizeX, self.realSizeY
end

function JZQWGameActivateObjItem:SetArrowVisible(visible)
    local bShow = visible and (self.data.Config.InteractType > 0)
    SetActive(self.canActivateFlag, bShow)
    SetActive(self.nameText.gameObject, bShow)
end

function JZQWGameActivateObjItem:ClearItems()
end

function JZQWGameActivateObjItem:Clear()
    self:ClearItems()
end

function JZQWGameActivateObjItem:Destroy()
    LuaMgr.RemoveClick(self.button, self.OnClickButton)
    self:Clear()
end