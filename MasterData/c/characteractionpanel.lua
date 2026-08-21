---@class CharacterActionPanel : CharacterActionPanel_Generate
---##################### 【CharacterActionPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CharacterActionPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CharacterActionPanel = require "CharacterActionPanel_Generate"

function CharacterActionPanel:InitLogic(data)
    ---@type BattleRole
    self._role = nil
    self._skills = {}
end

--function CharacterActionPanel:StartCreating(time)
--
--end

--function CharacterActionPanel:StartEnter(time)
--
--end

--function CharacterActionPanel:StartRemoving(time)
--
--end

--function CharacterActionPanel:StartExit(time)
--
--end

function CharacterActionPanel:OnOpen(data, initiative)
    if (initiative) then
        self._role = data.role
    end
    self:setSkill()
    self:enterActionState()
end

--function CharacterActionPanel:OnClose(initiative)
--
--end

--function CharacterActionPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function CharacterActionPanel:OnRefresh(data)
--
--end

function CharacterActionPanel:setSkill()
    self.skill1Btn:SetActive(true)
    self.skill2Btn:SetActive(false)
    self.skill3Btn:SetActive(false)
    self._skills = {}
    self._skills[1] = self._role.normalSkill
    local skillConfig = Config.GetSkillInfo(self._role.normalSkill)
    self.skill1Btn.nameTxt.text.text = skillConfig.name

    local baseSkills = self._role.roleConfig.baseSkill
    for index, skillId in ipairs(baseSkills) do
        self._skills[index + 1] = skillId
        local skillConfig1 = Config.GetSkillInfo(skillId)
        local btn = self[string.format("skill%sBtn", index + 1)]
        btn.nameTxt.text.text = skillConfig1.name
        if (skillConfig1.skillType == GE.SkillType.Active or skillConfig1.skillType == GE.SkillType.Preparatory) then
            btn.scaleButton.interactable = true
        else
            btn.scaleButton.interactable = false
        end
        btn:SetActive(true)
    end
end

function CharacterActionPanel:enterActionState()
    self.actionGroup:SetActive(true)
    self.chooseTargetGroup:SetActive(false)
    self.doSkillGroup:SetActive(false)
end

function CharacterActionPanel:enterChooseState()
    self.actionGroup:SetActive(false)
    self.chooseTargetGroup:SetActive(true)
    self.doSkillGroup:SetActive(false)
end

function CharacterActionPanel:enterDoSkillState()
    self.actionGroup:SetActive(false)
    self.chooseTargetGroup:SetActive(false)
    self.doSkillGroup:SetActive(true)
end

function CharacterActionPanel:doSkill()
    self._role:doAction(GE.ActionType.DoSkill)
end

--[[
/StandbyBtn onClick 
--]]
function CharacterActionPanel:standbyBtn_ScaleButton_onClick(standbyBtn)
    self._role:doAction(GE.ActionType.Standby)
end

--[[
/SkillBtns/Skill1Btn onClick 
--]]
function CharacterActionPanel:skill1Btn_ScaleButton_onClick(skill1Btn)
    self._role:selectSkill(self._skills[1])
    self:enterChooseState()
end

--[[
/SkillBtns/Skill2Btn onClick 
--]]
function CharacterActionPanel:skill2Btn_ScaleButton_onClick(skill2Btn)
    self._role:selectSkill(self._skills[2])
    self:enterChooseState()
end

--[[
/SkillBtns/Skill3Btn onClick 
--]]
function CharacterActionPanel:skill3Btn_ScaleButton_onClick(skill3Btn)
    self._role:selectSkill(self._skills[3])
    self:enterChooseState()
end

--[[
/DoSkillGroup/BackBtn onClick 
--]]
function CharacterActionPanel:backBtn_ScaleButton_onClick(backBtn)
    -- local battleCore = require "BattleCore"
	-- local battleMgr = battleCore:getBattleMgr()
	-- battleMgr:refreshRoleActionState(self._role)
    self._role:skillChooseTarget()
    self:enterChooseState()
end

--[[
/DoSkillGroup/ConfirmBtn onClick 
--]]
function CharacterActionPanel:confirmBtn_ScaleButton_onClick(confirmBtn)
    self:doSkill()
end

--[[
/ChooseTargetGroup/ChooseBackBtn onClick 
--]]
function CharacterActionPanel:chooseBackBtn_ScaleButton_onClick(chooseBackBtn)
    local battleCore = require "BattleCore"
	local battleMgr = battleCore:getBattleMgr()
	battleMgr:refreshRoleActionState(self._role)
    self:enterActionState()
end

return CharacterActionPanel
