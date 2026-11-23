









HMWYEmployeeItem = {}
HMWYEmployeeItem.__index = HMWYEmployeeItem

local objs = {
    button = { path = "", type = UITool.Button },
    animator = { path = "", type = UITool.Animator },
    canvasGroup = { path = "Group", type = UITool.CanvasGroup },
    gourpRect = { path = "Group", type = UITool.RectTransform },
    heroIcon = { path = "Group/HeroIcon", type = UITool.RawImage },
    textLv = { path = "Group/Image/TextLv", type = UITool.Text },
    heroRare = { path = "Group/HeroRare", type = UITool.Image },
    employing = { path = "Group/Employing", type = UITool.GameObject },
    lock = { path = "Group/Lock", type = UITool.GameObject },
}

HMWYEmployeeItem.New = function()

    local self = {}
    setmetatable(self, HMWYEmployeeItem)
    return self
end

function HMWYEmployeeItem:Init()
    UITool.Parse(self.gameObject, self, objs)
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

function HMWYEmployeeItem:SetData(data)
    self.data = data.data

    if self.data == nil then
        LuaDebug.error("HMWYEmployeeItem:SetData data is nil")
        return
    end
    local headIconPath = ConfigHelper.GetCharacterAvatarPath(self.data.id, self.data.id .. "001")
    self.heroIcon.texture = LuaMgr.GetTexture(headIconPath)
    local rare = HeroMgr.GetHeroNowRare(self.data.id)
    self.heroRare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. rare)
    self.textLv.text = "Lv" .. self.data.level
    SetActive(self.employing, self.data.lockByEventId ~= nil)
    SetActive(self.lock, not self.data.unlock)
end

function HMWYEmployeeItem:ClearItems()
    self.canvasGroup.alpha = 1
    self.gourpRect.anchoredPosition = Vector2.zero
end

function HMWYEmployeeItem:Clear()
    self:ClearItems()
end

function HMWYEmployeeItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end