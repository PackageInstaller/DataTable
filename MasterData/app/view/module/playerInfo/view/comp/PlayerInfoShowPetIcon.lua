local PlayerInfoShowPetIcon = class("PlayerInfoShowPetIcon", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowPetIcon"))

function PlayerInfoShowPetIcon:ctor()
	self._petStruct = nil

	self:initView()
	self.m_starComp:initStar({
		num = 0,
		style = 2,
		index = 3,
		gap = -8,
		max = 7
	})
end

function PlayerInfoShowPetIcon:initView()
	self:addClickListener(handler(self, self._onClickIcon))
end

function PlayerInfoShowPetIcon:_onClickIcon()
	if self._petStruct == nil then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
		petStruct = self._petStruct
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

function PlayerInfoShowPetIcon:updatePetIcon(arg_4_1)
	if arg_4_1 == nil then
		self.m_isEmptyController:setSelectedIndex(1)

		local var_4_0, var_4_1 = g.core.common.Path:getEquipIconQualityBg1(0)

		self.m_qualityLoader:setURL(var_4_1)
		self:setOpaque(false)
	else
		self.m_isEmptyController:setSelectedIndex(0)

		local var_4_2, var_4_3 = g.core.common.Path:getEquipIconQualityBg1(arg_4_1:getQuality())

		self.m_qualityLoader:setURL(var_4_3)

		self._petStruct = arg_4_1

		self:setIcon(g.core.common.Path:getPetTeamIcon(arg_4_1:getCfg().resource))
		self.m_starComp:setStarNum(arg_4_1:getStarNum())
		self.m_rankText:setText(g.core.lang:get(2050, {
			level = arg_4_1:getBigSmallStage()
		}))
		self:setOpaque(true)
	end
end

return PlayerInfoShowPetIcon
