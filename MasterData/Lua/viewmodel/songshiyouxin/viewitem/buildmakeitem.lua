require("ViewModel/SongShiYouXin/ViewItem/SSYXMakeMatItem")
















BuildMakeItem = {}
BuildMakeItem.__index = BuildMakeItem

local objs = {
    animRoot = {path = "", type = UITool.Animator},
    unlockObj = {path = "Group/UnlockObj", type = UITool.GameObject},
    makingObj = {path = "Group/UnlockObj/MakingObj", type = UITool.GameObject},
    makingObjText = {path = "Group/UnlockObj/MakingObj/Text", type = UITool.Text},
    makeBtn = {path = "Group/UnlockObj/MakeBtn", type = UITool.Button},
    makeBtnText = {path = "Group/UnlockObj/MakeBtn/Text", type = UITool.Text},
    unlockProductIcon = {path = "Group/UnlockObj/ProductItem/ProductIcon", type = UITool.Image},
    productName = {path = "Group/UnlockObj/ProductItem/ProductName", type = UITool.Text},
    makeNeedTime = {path = "Group/UnlockObj/MakeNeedTime", type = UITool.Text},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    lockProductIcon = {path = "Group/LockObj/ProductIcon", type = UITool.Image},
    unlockText = {path = "Group/LockObj/UnlockText", type = UITool.Text}
}

BuildMakeItem.New = function()

    local self = {}
    setmetatable(self, BuildMakeItem)

    self.matItems = {}
    return self
end

function BuildMakeItem:Init()
    for i = 1, 3 do
        local matObjName = "MatItem" .. i
        local path = string.format("Group/UnlockObj/MatParent/%s", matObjName)
        objs[matObjName] = {path = path, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
    for i = 1, 3 do
        local matObjName = "MatItem" .. i
        local matItem = SSYXMakeMatItem.New(self[matObjName])
        self.matItems[i] = matItem
        SetActive(matItem.gameObject, false)
    end
    self.OnClickMakeBtn = function()
        if self.data == nil then
            return
        end
        if self.data.MakeCallback ~= nil then
            self.data.MakeCallback(self)
        end
    end
    LuaMgr.AddClick(self.makeBtn, self.OnClickMakeBtn)
end

function BuildMakeItem:SetData(data)
    self.data = data.data
    for i = 1, 3 do
        local consumeData = self.data.Consume[i]
        if consumeData ~= nil then
            SetActive(self.matItems[i].gameObject, true)
            self.matItems[i]:SetData(consumeData)
        else
            SetActive(self.matItems[i].gameObject, false)
        end
    end
    SetActive(self.unlockObj, self.data.IsUnlock == true)
    SetActive(self.lockObj, self.data.IsUnlock == false)
    SetActive(self.makingObj, self.data.IsMaking == true)
    SetActive(self.makeBtn.gameObject, self.data.IsMaking == false)
    if self.data.IsUnlock == true then
        self.animRoot.enabled = false
        self.unlockProductIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, self.data.IconName)
        self.productName.text = LuaMgr.GetLangText(SSYXData.GetItemConfig(self.data.ContentProduction.ID).NameLan)
        local h, m, s = GetTimeHMS(self.data.OutputTime)
        self.makeNeedTime.text = string.format("%s:%s", h, m)
    else
        self.animRoot.enabled = true
        self.lockProductIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, self.data.IconName)
        self.unlockText.text = self.data.UnlockDesc
        self.animRoot:Play("ani_SSYXBuildInfoPanel_MakeItem_001")
    end
    self:SetTitle()
end

function BuildMakeItem:SetTitle()
    self.makingObjText.text = LuaMgr.GetLangText(self.data.makingObjText)
    self.makeBtnText.text = LuaMgr.GetLangText(self.data.makeBtnText)
end

function BuildMakeItem:ClearItems()
end

function BuildMakeItem:Clear()
    self:ClearItems()
end

function BuildMakeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end