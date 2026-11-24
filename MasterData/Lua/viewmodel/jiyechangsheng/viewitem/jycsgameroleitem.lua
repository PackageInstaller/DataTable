



JYCSGameRoleItem = {}
JYCSGameRoleItem.__index = JYCSGameRoleItem

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    anim = {path = "", type = UITool.Animator},
    image1 = {path = "player/Image1", type = UITool.GameObject},
    image2 = {path = "player/Image2", type = UITool.GameObject},
    image3 = {path = "player/Image3", type = UITool.GameObject},
    image4 = {path = "player/Image4", type = UITool.GameObject}
}

JYCSGameRoleItem.New = function(obj)

    local self = {}
    setmetatable(self, JYCSGameRoleItem)
    self.gameObject = obj
    self:Init()
    return self
end

function JYCSGameRoleItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function JYCSGameRoleItem:SetData(data)
end

function JYCSGameRoleItem:SetRoleDirect(index)
    self.curDirect = index
    for i = 1, 4 do
        local name = "image" .. i
        SetActive(self[name], false)
    end
    local curName = "image" .. index
    SetActive(self[curName], true)
end

function JYCSGameRoleItem:GetRoleDirect()
    return self.curDirect
end

function JYCSGameRoleItem:SetTransPos(pos)
    self:ClearMoveTween()
    self.rectTrans.anchoredPosition = pos
end

function JYCSGameRoleItem:MoveToPos(pos, duration, animName, callback)
    self:ClearMoveTween()
    if animName ~= nil and animName ~= "" then
        self:PlayAnim(animName)
    end
    if duration == nil or duration <= 0 then
        self.rectTrans.anchoredPosition = pos
        if callback ~= nil then
            callback()
        end
        return
    end
    self.moveTween = DOTWeen.To(
        function()
            return self.rectTrans.anchoredPosition
        end,
        function(value)
            self.rectTrans.anchoredPosition = value
        end,
        pos,
        duration
    )
    self.moveTween.onComplete = function()
        self.moveTween = nil
        if callback ~= nil then
            callback()
        end
    end
end

function JYCSGameRoleItem:ClearMoveTween()
    if self.moveTween ~= nil then
        self.moveTween.onComplete = nil
        self.moveTween:Kill()
        self.moveTween = nil
    end
end

function JYCSGameRoleItem:PlayAnim(name)
    if self.anim ~= nil and name ~= nil and name ~= "" then
        self.anim:Play(name, 0, 0)
    end
end

function JYCSGameRoleItem:ClearItems()
    self:ClearMoveTween()
end

function JYCSGameRoleItem:Clear()
    self:ClearItems()
end

function JYCSGameRoleItem:Destroy()
    self:Clear()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end