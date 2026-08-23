local EquipResonanceTalentCell = class("EquipResonanceTalentCell", require("app.fairyGUI.equipAndTreasure.UI_EquipResonanceTalentCell"))

function EquipResonanceTalentCell:ctor()
	self:addClickListener(handler(self, self._onClickInfoBtn))
end

function EquipResonanceTalentCell:_onClickInfoBtn()
	self:dispatchCompEvent("EquipResonance_talentSkill")
end

return EquipResonanceTalentCell
