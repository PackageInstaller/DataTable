local RoleGeneEffectItemCtrl = BaseClass("RoleGeneEffectItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = RoleGeneEffectItemCtrl



function M:SetState(state)
    self._view.state:SetState(state)
end

function M:SetActive(b)
    self._view:SetActive(b)
end

function M:Update(id, curNum, nextNum)
    local attr = ConfigHelper.GetCfgByLua("attribute", id)
    if not attr then 
        Logger.Logger("attribute id : ".. id " is nil ")
    end
    local curValue = tostring(curNum)
    local nextValue = tostring(nextNum)

    self._view.icon:SetPic(attr.icon)
    self._view.nameText:SetText(attr.name)
    self._view.number:SetText(curValue)
    self._view.upNumber:SetText(nextValue)
    self:ShowPanel()
end


function M:Init()
end


return RoleGeneEffectItemCtrl
