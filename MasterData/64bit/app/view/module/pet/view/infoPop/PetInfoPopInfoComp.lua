local var_0_0 = g.core.module.ModuleManager
local PetSkillDescTip = require("app.view.module.tip.view.PetSkillDescTip")
local PetLinkSkillDescTip = require("app.view.module.tip.view.PetLinkSkillDescTip")
local PetInfoPopInfoComp = class("PetInfoPopInfoComp", require("app.fairyGUI.pet.UI_PetInfoPopInfoComp"))

function PetInfoPopInfoComp:ctor()
	self._baseInfo = nil
	self._star = nil
	self._advId = nil

	self.m_skill1:addClickListener(handler(self, self._onSkill1Click))
	self.m_skill2:addClickListener(handler(self, self._onSkill2click))
	self.m_skill3:addClickListener(handler(self, self._onSkill3Click))
end

function PetInfoPopInfoComp:_onSkill1Click()
	var_0_0:pushPopup(PetSkillDescTip.new({
		isPassive = true,
		skillId = self._baseInfo.passive_skill_1,
		star = self._star,
		petAdvId = self._advId
	}), {
		touchDisappear = true
	})
end

function PetInfoPopInfoComp:_onSkill2click()
	if self._skillTip2 then
		var_0_0:pushPopup(PetSkillDescTip.new(self._skillTip2), {
			touchDisappear = true
		})
	end
end

function PetInfoPopInfoComp:_onSkill3Click()
	var_0_0:pushPopup(PetLinkSkillDescTip.new({
		isPassive = true,
		skillType = 113,
		skillId = self._baseInfo.link_passive_skill_1,
		star = self._star,
		petAdvId = self._advId
	}), {
		touchDisappear = true
	})
end

function PetInfoPopInfoComp:updateShow(arg_5_1)
	self._baseInfo = arg_5_1:getCfg()
	self._advId = arg_5_1:getAdvanceId()
	self._star = arg_5_1:getStarNum()

	local var_5_0 = arg_5_1:getCurLvAttrArr()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_0 <= 5 then
			self["m_attr" .. iter_5_0]:updateAttr(iter_5_1)
		end
	end

	if #var_5_0 < 5 then
		for iter_5_2 = #var_5_0 + 1, 5 do
			self["m_attr" .. iter_5_2]:setVisible(false)
		end
	end

	self.m_skill1:updateIcon({
		isPassive = true,
		skillType = "PetActive",
		skillId = self._baseInfo.passive_skill_1
	})

	local var_5_1 = arg_5_1:getPassiveArr()

	if var_5_1.id > 0 then
		local var_5_2 = var_5_1.id

		self.m_skill2:updateIcon({
			isPassive = true,
			skillType = "PetPassive",
			skillId = var_5_1.id
		})
		self.m_skill2:setGrayed(not var_5_1.isActive and arg_5_1:isOwn())

		self._skillTip2 = {
			isPassive = true,
			skillType = 117,
			skillId = var_5_2,
			petAdvId = self._baseInfo.advance_id
		}
	end

	if self._baseInfo.describe then
		self.m_descText:setText(self._baseInfo.describe, true)
	end
end

return PetInfoPopInfoComp
