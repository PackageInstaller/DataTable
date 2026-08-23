local var_0_0 = 0.3
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.petsData
local PetInfoComp = class("PetInfoComp", require("app.fairyGUI.pet.UI_PetInfoComp"))

function PetInfoComp:ctor()
	self._petStruct = nil

	self.m_level:enableRich()
	self.m_skillTitle:addClickListener(handler(self, self._onClickSkillTitle))
	self.m_skillIcon_1:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_skillIcon_2:addClickListener(handler(self, self._onClickSkillIcon))
end

function PetInfoComp:updateView(arg_2_1)
	self._petStruct = var_0_2:getPetBySid(arg_2_1.data.sid)

	self:_updateView()
end

function PetInfoComp:_updateView()
	if not self._petStruct then
		return
	end

	local var_3_0 = self._petStruct
	local var_3_1 = self._petStruct:getLevel()
	local var_3_2 = self._petStruct:getCfg()
	local var_3_3 = ""

	if var_3_1 < 10 then
		var_3_3 = "00"
	elseif var_3_1 < 100 then
		var_3_3 = "0"
	end

	self.m_subLevel:setText(var_3_3)
	self.m_level:setText(var_3_1)
	self.m_maxLevel:setText("/" .. var_3_0:getMaxLevel())

	local var_3_4

	if g.core.model.User:getMaxLevel() <= var_3_0:getLevel() then
		self.m_maxLevel:setText("Max")
		self.m_maxLevel:setVisible(true)
		self.m_maxLvController:setSelectedIndex(1)
	else
		self.m_maxLevel:setVisible(false)
		self.m_levelUpComp:updateComp(var_3_0)
		self.m_maxLvController:setSelectedIndex(0)

		var_3_4 = {}
	end

	var_3_4.cur = var_3_0:getExp()
	var_3_4.max = var_3_0:getCurLvMaxExp()

	self.m_expProgBar:setPercent(var_3_4)
	self.m_attrComp:updateComp((var_3_0:getCurLvAttrArr()))
	self.m_skillIcon_1:updateIcon({
		isPassive = true,
		skillType = "PetActive",
		skillId = var_3_2.passive_skill_1
	})

	local var_3_5 = var_3_0:getPassiveSkillId()

	self.m_skillIcon_2:setGrayed(var_3_0:getAdvCfg().skill_1 == 0)
	self.m_skillIcon_2:updateIcon({
		isPassive = true,
		skillType = "PetPassive",
		skillId = var_3_5
	})

	local var_3_6 = var_3_0:isLinkSkillActive()
end

function PetInfoComp:_onClickSkillTitle()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 223
	}), {
		touchDisappear = true
	})
end

function PetInfoComp:_onClickSkillIcon(arg_5_1)
	local var_5_0 = arg_5_1:getSender()
	local var_5_1
	local var_5_3 = self._petStruct:getCfg()
	local var_5_4

	if var_5_0 == self.m_skillIcon_1 then
		var_5_1 = var_5_3.passive_skill_1
		var_5_4 = 6
	elseif var_5_0 == self.m_skillIcon_2 then
		var_5_1 = self._petStruct:getPassiveSkillId()
		var_5_4 = 117
	else
		var_5_1 = var_5_3.link_passive_skill_1
		var_5_4 = 113
	end

	local var_5_5 = self._petStruct:getAdvanceId()

	var_0_1:pushPopup((var_5_0 == self.m_skillIcon_3 and require("app.view.module.tip.view.PetLinkSkillDescTip") or require("app.view.module.tip.view.PetSkillDescTip")).new({
		isPassive = true,
		petAdvId = var_5_5,
		skillId = var_5_1,
		star = self._petStruct:getStarNum(),
		skillType = var_5_4
	}), {
		touchDisappear = true
	})
end

function PetInfoComp:onS2CPetLvUp(arg_6_1)
	if not self._petStruct then
		return
	end

	self.m_barEffDadComp:removeAllEffect()
	self.m_barEffDadComp:addEffectSpine({
		isLoop = false,
		name = "eff_ui_petLineUp_timeline",
		scale = 0.95
	})

	local var_6_0 = {}
	local var_6_1 = fgui.FDelayTime:create(var_0_0)

	if arg_6_1 then
		self.m_expProgBar:setPercent({
			max = 100,
			tween = true,
			cur = 100,
			dur = var_0_0
		})
		table.insert(var_6_0, var_6_1:clone())
		table.insert(var_6_0, (fgui.FCallFunc:create(handler(self, function()
			self.m_expProgBar:setPercent({
				max = 100,
				tween = false,
				cur = 0
			})
		end))))
	end

	local var_6_2 = self._petStruct:getExp()
	local var_6_3 = self._petStruct:getCurLvMaxExp()

	table.insert(var_6_0, (fgui.FCallFunc:create(handler(self, function()
		self.m_expProgBar:setPercent({
			tween = true,
			cur = var_6_2,
			max = var_6_3,
			dur = var_0_0
		})
	end))))
	table.insert(var_6_0, var_6_1)
	table.insert(var_6_0, (fgui.FCallFunc:create(handler(self, function()
		self:_updateView()
		self:dispatchCompEvent("CompEventExpUpAniEnd", arg_6_1)
	end))))
	self:runFGAction(fgui.FSequence:create(var_6_0))
end

return PetInfoComp
