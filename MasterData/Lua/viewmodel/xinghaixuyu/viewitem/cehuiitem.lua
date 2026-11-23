






CeHuiItem = {}
CeHuiItem.__index = CeHuiItem

CeHuiItem.IconCache = {}

local objs = {
    group = {path = "Group", type = UITool.GameObject},
    icon = {path = "Group/Icon", type = UITool.Image},
    animator = {path = "Group/Icon", type = UITool.Animator},
    particle = {path = "Group/Icon/vfx_out/1", type = UITool.ParticleSystem}
}

function CeHuiItem.New(item, index)
    local self = {}
    setmetatable(self, CeHuiItem)
    self.gameObject = item
    self.index = index
    UITool.Parse(self.gameObject, self, objs)
    self.particleSpeed = self.particle.main.simulationSpeed
    return self
end

function CeHuiItem:SetIcon(id, isDobleSpeed, time)
    self.id = id
    self.animator.speed = isDobleSpeed == true and 2 or 1
    self.particle.main.simulationSpeed = isDobleSpeed == true and self.particleSpeed * 2 or self.particleSpeed
    if self.id ~= 0 then
        self.icon.sprite = LuaMgr.GetSprite("XingHaiXuYu", "ui_xzch_tiezhi" .. self.id)
        SetActive(self.icon.gameObject, true)
        self.animator:Play("ani_XingZhiCeHuiPanel_icon")
    else
        if isDobleSpeed == nil or time == nil then
            SetActive(self.icon.gameObject, false)
            return
        end
        self.animator:Play("ani_XingZhiCeHuiPanel_icon_out")

        if self.sequence ~= nil then
            self.sequence:Kill()
            self.sequence = nil
        end
        self.sequence = DOTWeen:Sequence()
        local func = function()
            SetActive(self.icon.gameObject, false)
        end
        self.sequence:AppendInterval(time):OnComplete(func)
    end
end