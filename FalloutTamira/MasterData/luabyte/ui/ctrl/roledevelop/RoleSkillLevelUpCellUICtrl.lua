local RoleSkillLevelUpCellUICtrl = BaseClass("RoleSkillLevelUpCellUICtrl", UIBaseComponent)
local M = RoleSkillLevelUpCellUICtrl

function M:SetData(data)
    if data == nil then
        self._view:SetActive(false)
        return
    end
    self.data = data
    self._view.icon:SetPic(data.icon)
    self._view.nowLevelText:SetText(tostring(data.skillLevel - 1))
    self._view.nextLevelText:SetText(tostring(data.skillLevel))
    self._view.name:SetText(data.skillName)
    self._view.UIState:SetState(2)
end

function M:SetCurrent()
    self._view.UIState:SetState(1)
    self._view.nowLevelText:SetText(tostring(self.data.skillLevel))
end

function M:Select(b)
    self._view.select:SetActive(b)
end

return M
