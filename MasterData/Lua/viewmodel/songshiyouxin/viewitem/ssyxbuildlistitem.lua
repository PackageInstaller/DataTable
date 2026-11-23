



















SSYXBuildListItem = {}
SSYXBuildListItem.__index = SSYXBuildListItem

local objs = {
    groupObj = {path = "Group", type = UITool.GameObject},
    groupCanvas = {path = "Group", type = UITool.CanvasGroup},
    groupRect = {path = "Group", type = UITool.RectTransform},
    hadObj = {path = "Group/HadObj", type = UITool.GameObject},
    hadIcon = {path = "Group/HadObj/Icon", type = UITool.Image},
    hadName = {path = "Group/HadObj/Name", type = UITool.Text},
    hadNum = {path = "Group/HadObj/Num", type = UITool.Text},
    canCreateObj = {path = "Group/CanCreateObj", type = UITool.GameObject},
    canCreateIcon = {path = "Group/CanCreateObj/Icon", type = UITool.Image},
    canCreateName = {path = "Group/CanCreateObj/Name", type = UITool.Text},
    canCreateNum = {path = "Group/CanCreateObj/Num", type = UITool.Text},
    createBtn = {path = "Group/CanCreateObj/CreateBtn", type = UITool.Button},
    createBtnName = {path = "Group/CanCreateObj/CreateBtn/BtnName", type = UITool.Text},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    lockIcon = {path = "Group/LockObj/Icon", type = UITool.Image},
    lockName = {path = "Group/LockObj/Name", type = UITool.Text},
    unlockDesc = {path = "Group/LockObj/Condition", type = UITool.Text}
}

SSYXBuildListItem.New = function()

    local self = {}
    setmetatable(self, SSYXBuildListItem)
    return self
end

function SSYXBuildListItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickCreate = function()
        if self.data.OnClickCreateBtn ~= nil then
            self.data.OnClickCreateBtn(self)
        end
    end
    LuaMgr.AddClick(self.createBtn, self.OnClickCreate)
end

function SSYXBuildListItem:SetData(data)
    self.data = data.data
    SetActive(self.hadObj, false)
    SetActive(self.canCreateObj, false)
    SetActive(self.lockObj, false)
    if (self.data.IsUnlock == true and self.data.IsCreated == false) or self.data.CanCreate == true then
        SetActive(self.canCreateObj, true)
        if self.data.Config.UnlockType == SSYXConst.BuildUnlockType.Buy then
            self.createBtnName.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText1)
        elseif self.data.Config.UnlockType == SSYXConst.BuildUnlockType.Level then
            self.createBtnName.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText2)
        end
        local spriteName = string.format("%d_Light", self.data.ID)
        self.canCreateIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
        self.canCreateName.text = LuaMgr.GetLangText(self.data.Config.NameLan)
        self.canCreateNum.text = "0/1"
    elseif self.data.IsCreated == true then
        SetActive(self.hadObj, true)
        local spriteName = string.format("%d_Light", self.data.ID)
        self.hadIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
        self.hadName.text = LuaMgr.GetLangText(self.data.Config.NameLan)
        self.hadNum.text = "1/1"
    elseif self.data.IsUnlock == false then
        SetActive(self.lockObj, true)
        local spriteName = string.format("%d_Dark", self.data.ID)
        self.lockIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
        self.lockName.text = LuaMgr.GetLangText(self.data.Config.NameLan)
        if self.data.Config.UnlockType == SSYXConst.BuildUnlockType.Level then
            local langText = LuaMgr.GetLangText(SSYXConst.LanText.LanText3)
            local preBuildConfig = SSYXData.GetBuildDataByID(self.data.Config.UnlockConditions[1]).Config
            local preBuildName = LuaMgr.GetLangText(preBuildConfig.NameLan)
            self.unlockDesc.text = string.format(langText, preBuildName, self.data.Config.UnlockConditions[2])
        end
    end
    if self.tween ~= nil then
        self.tween:Kill(false)
        self.tween = nil
    end
    SetActive(self.groupObj, false)
    local callBack = function()
        SetActive(self.groupObj, true)
    end
    self.tweenSquence = DOTWeen:Sequence()
    self.tweenSquence:AppendInterval(self.data.Index * 0.08):OnComplete(callBack)
end

function SSYXBuildListItem:ClearItems()
    self.groupCanvas.alpha = 1
    self.groupRect.anchoredPosition = Vector2.zero
end

function SSYXBuildListItem:Clear()
    self:ClearItems()
end

function SSYXBuildListItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end