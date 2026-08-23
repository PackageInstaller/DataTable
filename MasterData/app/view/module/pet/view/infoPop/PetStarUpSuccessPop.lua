local var_0_1 = g.core.const.ConstMgr.PetConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.lang
local PetStarUpSuccessPop = class("PetStarUpSuccessPop", require("app.fairyGUI.pet.UI_PetStarUpSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "PetStarUpSuccessPop",
		pkgPath = "ui/pet/pet",
		isFullScreen = true,
		pkgName = "pet"
	}, ...)
end)

function PetStarUpSuccessPop:ctor(arg_2_1)
	self._data = arg_2_1
	self._pet = nil
	self._starNum = 0
	self._isInitBg = nil
	self._skill1InitialPosX = self.m_skillGroup1:getX()

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
	self:showAtCenter()
end

function PetStarUpSuccessPop:onLoad()
	if self._data then
		if self._data.advId then
			self._pet = var_0_3:getPetByAdvanceId(self._data.advId)
		elseif self._data.pet then
			self._pet = self._data.pet
		elseif self._data.petId then
			self._pet = var_0_3:getPetByBaseId(self._data.petId)
		elseif self._data.petSid then
			self._pet = var_0_3:getPetBySid(self._data.petSid)
		end
	end

	if not self._isInitBg then
		self._isInitBg = true

		self.m_bgComp:initData({
			title = var_0_4:get(201105),
			englishTitle = var_0_4:get(201106),
			item = {
				alphaDistance = 320,
				type = 4,
				res = {
					isAlphaNode = true,
					isShowBg = true,
					pet = self._pet
				},
				alphaRect = cc.rect(-250, 0, 400, 0)
			},
			quality = self._pet:getCfg().quality
		})
	end

	self:updateComp()

	if self.m_enterTransition then
		self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
		self.m_enterTransition:setHook("starup", handler(self, self._onPlayStarSpineEff))
		self.m_enterTransition:setHook("starline", handler(self, self.playStarLineEff))
		self.m_enterTransition:play()
	end
end

function PetStarUpSuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_uniteToken_upGrade",
		isLoop = false,
		anim = "play_" .. self._pet:getCfg().quality + 1
	})
end

function PetStarUpSuccessPop:_onPlayStarSpineEff()
	self.m_starComp:addEffectToStars(self._starNum, self._starNum, {
		remove = true,
		name = "eff_ui_knight_upstar",
		isLoop = false,
		anim = "play",
		eventHandler = handler(self, self._onStarPlayFinish)
	})
end

function PetStarUpSuccessPop:playStarLineEff()
	self.m_effStarLine:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_upstarline",
		anim = "play",
		isLoop = false
	})
end

function PetStarUpSuccessPop:_onStarPlayFinish(arg_7_1)
	if arg_7_1.eventData and arg_7_1.eventData.name == "cut" then
		self.m_starComp:initStar({
			gap = 0,
			style = 2,
			type = 1,
			index = 4,
			num = self._starNum
		})
	end
end

function PetStarUpSuccessPop:updateComp()
	if self._pet then
		local var_8_0 = self._pet:getCfg()

		self._starNum = self._pet:getStarNum()

		self.m_starComp:initStar({
			gap = 0,
			style = 2,
			type = 1,
			index = 4,
			num = self._starNum - 1
		})

		local var_8_1, var_8_2, var_8_3 = var_0_2:getQualityTxtAndBg(var_8_0.quality)
		local var_8_5 = var_8_0.star
		local var_8_6

		if not var_8_0.star then
			var_8_5 = 0
			var_8_6 = {
				isPassive = true,
				skillType = "PetActive"
			}
		end

		var_8_6.preSkillId = g.core.config.pet_info.get(var_8_0.advance_id + var_8_5 - 1).passive_skill_1
		var_8_6.skillId = var_8_0.passive_skill_1

		self.m_skill1:updateIcon(var_8_6)
		self.m_skill1Level:setText(g.core.config.skill_info.get(var_8_6.skillId).level)

		local var_8_7 = self._pet:getStarAttrArr(var_8_0.id)
		local var_8_8 = self._pet:getStarAttrArr(var_8_0.id - 1)

		for iter_8_0 = 1, var_0_1.ATTR_NUM do
			if var_8_7[iter_8_0] then
				self["m_attr" .. iter_8_0]:updateAttr({
					isAll = true,
					iconType = 2,
					isShowAnima = true,
					type = var_8_7[iter_8_0].type,
					value = var_8_7[iter_8_0].baseValue - var_8_8[iter_8_0].baseValue
				})
			else
				self["m_attr" .. iter_8_0]:setVisible(false)
			end
		end
	end
end

function PetStarUpSuccessPop:_isShowSkill(arg_9_1)
	if arg_9_1 and arg_9_1.skillId and arg_9_1.preSkillId ~= arg_9_1.skillId then
		return true
	end

	return false
end

function PetStarUpSuccessPop:_onClick()
	g.core.module.ModuleManager:popComponent()
end

return PetStarUpSuccessPop
