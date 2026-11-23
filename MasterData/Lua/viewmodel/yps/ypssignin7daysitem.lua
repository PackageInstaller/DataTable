















YPSSignIn7DaysItem = {}
YPSSignIn7DaysItem.__index = YPSSignIn7DaysItem
YPSSignIn7DaysItem.ColorLight = UnityEngine.Color(167, 177, 224)
YPSSignIn7DaysItem.ColorDark = UnityEngine.Color(29, 25, 19)
local objs = {
    getBtn = {path = "", type = "Button"},
    animator = {path = "", type = UITool.Animator},
    canGet = {path = "CanGet", type = "GameObject"},
    already = {path = "Already", type = "GameObject"},
    icon = {path = "Icon", type = "Image"},
    dayTextLight = {path = "NameLight", type = "Text"},
    dayTextDark = {path = "NameDark", type = "Text"},
    effectObj = {path = "vfx", type = UITool.GameObject}
}

function YPSSignIn7DaysItem.New(obj, callback)

    local self = {}
    setmetatable(self, YPSSignIn7DaysItem)
    self.gameObject = obj
    self.callback = callback
    self:Init()
    return self
end

function YPSSignIn7DaysItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.getCommand = function()
        if self.callback ~= nil then
            self.callback(self)
        end
    end
    LuaMgr.AddClick(self.getBtn, self.getCommand)
end

function YPSSignIn7DaysItem:PlayAnim(isEnable)
    self.animator.enabled = isEnable
    SetActive(self.effectObj, isEnable)
    if isEnable == true then
        self.animator:Play("ani_YPSSignIn7DaysPanel_day", -1, 0)
    end
end

function YPSSignIn7DaysItem:SetData(data)
    self.data = data
    SetActive(self.canGet, self.data.state == 2)
    SetActive(self.already, self.data.state == 3)
    SetActive(self.dayTextLight.gameObject, self.data.state == 2)
    SetActive(self.dayTextDark.gameObject, self.data.state ~= 2)
    self.dayTextLight.text = self.data.dayName
    self.dayTextDark.text = self.data.dayName
    if self.data.state == 2 then
        self.icon.sprite = LuaMgr.GetSprite("YPS", "ui_hd_wps_qd_a0" .. self.data.index)
    else
        self.icon.sprite = LuaMgr.GetSprite("YPS", "ui_hd_wps_qd_b0" .. self.data.index)
    end
    self:RefreshSibling()
end

function YPSSignIn7DaysItem:RefreshSibling()
    if self.data.state == 2 then
        self.gameObject.transform:SetAsLastSibling()
    end
end

function YPSSignIn7DaysItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function YPSSignIn7DaysItem:Destroy()
    if (self.getCommand ~= nil) then
        LuaMgr.RemoveClick(self.getBtn, self.getCommand)
        self.getCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end