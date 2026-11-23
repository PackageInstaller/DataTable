










SSYXEmployeeItem = {}
SSYXEmployeeItem.__index = SSYXEmployeeItem

local objs = {
    button = {path = "", type = UITool.Button},
    animator = {path = "", type = UITool.Animator},
    canvasGroup = {path = "Group", type = UITool.CanvasGroup},
    gourpRect = {path = "Group", type = UITool.RectTransform},
    heroIcon = {path = "Group/HeroIcon", type = UITool.RawImage},
    heroRare = {path = "Group/HeroRare", type = UITool.Image},
    employing = {path = "Group/Employing", type = UITool.GameObject},
    additonFlag = {path = "Group/UpgradeFlag", type = UITool.GameObject}
}

SSYXEmployeeItem.New = function()

    local self = {}
    setmetatable(self, SSYXEmployeeItem)
    return self
end

function SSYXEmployeeItem:Init()

    self.wordItems = {}
    for i = 1, 2 do
        local wordItemName = "WordItem" .. i
        local path = string.format("Group/WordParent/%s", wordItemName)
        objs[wordItemName] = {path = path, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    for i = 1, 2 do
        local wordItemObjName = "WordItem" .. i
        local worldItem = SSYXWordItem.New(self[wordItemObjName], false)
        SetActive(self[wordItemObjName], false)
        self.wordItems[i] = worldItem
    end
    self.OnClickItem = function()
        if self.data == nil then
            return
        end
        if self.data.OnClickCallback ~= nil then
            self.data.OnClickCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem)
end

function SSYXEmployeeItem:SetData(data)
    self.data = data.data
    self.animator:Play("ani_ui_SSYXEmployPopup_EmployeeItem", 0, 0)
    if self.data == nil then
        LuaDebug.error("SSYXEmployeeItem:SetData data is nil")
        return
    end
    local headIconPath = ConfigHelper.GetCharacterAvatarPath(self.data.ID, self.data.ID .. "001")
    self.heroIcon.texture = LuaMgr.GetTexture(headIconPath)
    local imageRare = self.data.Rare >= 5 and 4 or self.data.Rare
    self.heroRare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. imageRare)
    local isEmploying = SSYXData.IsEmploying(self.data.ID)
    SetActive(self.additonFlag, isEmploying == false and self.data.CanAddition == true)
    SetActive(self.employing, isEmploying == true)
    local wordDatas = SSYXData.GetEmployeeWordDatas(self.data.ID)
    for i = 1, 2 do
        local item = self.wordItems[i]
        local wordData = wordDatas[i]
        if wordData ~= nil then
            SetActive(item.gameObject, true)
            local tempData = table.CopyNoMeta(wordData)
            tempData.IsEmployee = true
            item:SetData(tempData)
        else
            SetActive(item.gameObject, false)
        end
    end
end

function SSYXEmployeeItem:ClearItems()
    self.canvasGroup.alpha = 1
    self.gourpRect.anchoredPosition = Vector2.zero
end

function SSYXEmployeeItem:Clear()
    self:ClearItems()
end

function SSYXEmployeeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end