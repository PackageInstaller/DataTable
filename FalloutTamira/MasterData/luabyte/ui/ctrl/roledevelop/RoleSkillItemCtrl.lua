--技能养成中的ITEM CTRL
local RoleSkillItemCtrl = BaseClass("RoleSkillItemCtrl")
local M = RoleSkillItemCtrl

function M:__init(view)
    self._view = view
    if self._view.toggle then
        self._view.toggle:OnToggleClick(Bind(self, self._OnClickItem))
    else
        Logger.LogError("toggle is nil " .. self._view.gameObject.name)
    end

end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

--- 战中技能
function M:SetBattleSkillInfo(data, selectFun)
    if not data then
        self._view:SetActive(false)
        return
    else
        self._view:SetActive(true)
    end
    local battleLevel = data.battleLevel
    self.isOpen = data.isOpen
    self.data = data
    self._view.icon:SetPic(battleLevel.icon)
    self._view.skillName:SetText(battleLevel.skillName)
    self._view.skillLv:SetText(tostring(data.battleLevel.skillLevel))
    self._selectFun = selectFun
    if self._view.upGo then
        self._view.upGo:SetActive(battleLevel.skillUpType > 0)
    end
    if self._view.tfTips then
        self._view.tfTips:SetActive(battleLevel.skillUpType == 1)
    end

    self._view.tfLock:SetActive(not self.isOpen)
end

---普通攻击，觉醒技能
function M:SetAtkInfo(data, selectFun)
    self.isOpen = data.isOpen
    self.data = data
    local skill = data.battleLevel
    self._view.icon:SetPic(skill.icon)
    self._view.skillName:SetText(skill.name)
    if self._view.skillLv then
        local lv = skill.level == 0 and 1 or skill.level
        self._view.skillLv:SetText(tostring(lv))
    end
    self._selectFun = selectFun
    if self._view.upGo then
        self._view.upGo:SetActive(skill.skillUpType > 0)
    end
    self._view.tfLock:SetActive(not self.isOpen)
    self._view.tfTips:SetActive(false)
end

--- 边舱技能
function M:SetOtakuSkill(data, selectFun)
    if not data then
        self._view:SetActive(false)
        return
    else
        self._view:SetActive(true)
    end
    self.isOpen = data.isOpen
    self.data = data
    local skill = data.battleLevel
    self._view.icon:SetPic(skill.icon)
    self._view.skillName:SetText(skill.name)
    if self._view.skillLv then
        local lv = skill.level == 0 and 1 or skill.level
        self._view.skillLv:SetText(tostring(lv))
    end
    self._selectFun = selectFun
    if self._view.upGo then
        self._view.upGo:SetActive(skill.skillUpType > 0)
    end

    if self._view.tfTips then
        self._view.tfTips:SetActive(data.skillUpType == 1)
    end
    self._view.tfLock:SetActive(not self.isOpen)
end

function M:_OnClickItem(isOn)
    if isOn then
        if self._selectFun then
            self._selectFun(self.data, self._view.toggle, self)
        end
    else
        if self._selectFun then
            self._selectFun()
        end
    end
end

function M:SetActive(value)
    self._view:SetActive(value)
end

return RoleSkillItemCtrl
