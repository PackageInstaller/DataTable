local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.monster_team_info
local var_0_2 = g.core.config.pet_info
local var_0_3 = g.core.const.ConstMgr.PetConst
local var_0_4 = g.core.model.User.gveDataMgr
local var_0_5 = g.core.model.User.gveDataMgr:getGveFormationData()
local GveFormationPetIcon = class("GveFormationPetIcon", require("app.fairyGUI.gve.UI_GveFormationPetIcon"))

function GveFormationPetIcon:ctor()
	var_0_5 = var_0_4:getGveFormationData()
	self._unLock = true
	self._isDrag = false
	self._petPos = 0
	self._petInfo = {}
	self._tokenData = {}
	self._unLockText = nil
	self._isOther = false

	self.m_starGroupComp:initStar({
		gap = -2,
		style = 2,
		index = 3,
		num = 0,
		max = var_0_3.STAR_MAX
	})
	self:addClickListener(handler(self, self._onClick))
end

function GveFormationPetIcon:setPetPos(arg_2_1)
	self._petPos = arg_2_1
end

function GveFormationPetIcon:getPetPos()
	return self._petPos
end

function GveFormationPetIcon:updatePetFormatIcon(arg_4_1)
	if arg_4_1 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_petLoader:setURL(var_0_0:getPetIcon(arg_4_1:getCfg().resource))
		self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(arg_4_1:getQuality()))
		self.m_rankText:setText(arg_4_1:getAdvCfg().stage)
		self.m_starGroupComp:setStarNum(arg_4_1:getStarNum())
		self.m_hasStarController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(1)
		self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))
	end
end

function GveFormationPetIcon:updateMonsterIcon(arg_5_1)
	if arg_5_1.isBossInfo then
		if arg_5_1.monsterIndex == 0 then
			self:_updateMonsterByTeamId(arg_5_1.info.boss_team, arg_5_1.info)
		else
			self:_updateMonsterByTeamId(arg_5_1.info["guard_" .. arg_5_1.monsterIndex], arg_5_1.info)
		end
	else
		local var_5_0 = var_0_2.fetch(arg_5_1.info["pet_" .. self._petPos])

		if var_5_0 then
			self._petInfo = var_5_0

			self.m_petLoader:setURL(var_0_0:getPetIcon(var_5_0.resource))
			self.m_starGroupComp:setStarNum(var_5_0.star)
			self.m_rankText:setText(0)
			self.m_hasStarController:setSelectedIndex(1)
			self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(var_5_0.quality))
			self.m_isEmptyController:setSelectedIndex(0)
		else
			self._petInfo = nil

			self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))
			self.m_isEmptyController:setSelectedIndex(1)
		end
	end
end

function GveFormationPetIcon:_updateMonsterByTeamId(arg_6_1)
	local var_6_0 = var_0_2.fetch(var_0_1.get(arg_6_1, 1)["pet_" .. self._petPos])

	if var_6_0 then
		self._petInfo = var_6_0

		self.m_petLoader:setURL(var_0_0:getPetIcon(var_6_0.resource))
		self.m_starGroupComp:setStarNum(var_6_0.star)
		self.m_rankText:setText(0)
		self.m_hasStarController:setSelectedIndex(1)
		self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(var_6_0.quality))
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self._petInfo = nil

		self.m_qualityBar:setURL(var_0_0:getMulTeamLeftVerticalQualityBarURL(0))
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function GveFormationPetIcon:onDragStart()
	self._isDrag = true

	self.m_petLoader:setAlpha(0.5)
end

function GveFormationPetIcon:onDragEnd()
	self.m_petLoader:setAlpha(1)
	self:newScheduleOnce(handler(self, function()
		self._isDrag = false
	end), 0.03)
end

function GveFormationPetIcon:_onClick()
	if not self._isDrag and self._unLock and not self._isOther then
		self:dispatchCompEvent("gve_formation_click_add_pet", {
			pos = self._petPos
		})
	elseif not self._isDrag then
		if self._isOther and self._petInfo ~= nil then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.pet.view.infoPop.PetInfoPop").new({
				petAdvId = self._petInfo.advance_id
			}), {
				touchDisappear = true,
				hideContinue = true
			})
		elseif not self._unLock and self._unLockText then
			g.core.module.ModuleManager:tip(self._unLockText)
		end
	end
end

function GveFormationPetIcon:setIsOtherStyle(arg_11_1)
	self._isOther = arg_11_1 == true

	self:setVisible(not self._isOther or self._petInfo ~= nil)
end

function GveFormationPetIcon:isOther()
	return self._isOther
end

function GveFormationPetIcon:checkRedPoint()
	if self._isOther then
		self.m_redPointComp:setShow(false)

		return
	end

	if self.m_isEmptyController:getSelectedIndex() == 1 then
		if var_0_5:isHasPetCanUp() then
			self.m_redPointComp:setShow(true)
		else
			self.m_redPointComp:setShow(false)
		end
	else
		self.m_redPointComp:setShow(false)
	end
end

return GveFormationPetIcon
