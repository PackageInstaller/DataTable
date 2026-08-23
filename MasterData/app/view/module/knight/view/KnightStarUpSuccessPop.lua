local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.lang
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local KnightStarUpSuccessPop = class("KnightStarUpSuccessPop", require("app.fairyGUI.knight.UI_KnightStarUpSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "KnightStarUpSuccessPop",
		pkgPath = "ui/knight/knight",
		isFullScreen = true,
		pkgName = "knight"
	}, ...)
end)

function KnightStarUpSuccessPop:ctor(arg_2_1)
	self._data = arg_2_1
	self._knight = nil
	self._starNum = 0
	self._skill1InitialPosX = self.m_skillGroup1:getX()

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
	self:showAtCenter()
end

function KnightStarUpSuccessPop:onLoad()
	if self._data ~= nil then
		if self._data.knightAdvId then
			self._knight = var_0_1:getKnight({
				advance_id = self._data.knightAdvId
			})
		elseif self._data.knight then
			self._knight = self._data.knight
		elseif self._data.knightId then
			self._knight = var_0_1:getKnight({
				base_id = self._data.knightId
			})
		elseif self._data.knightSid then
			self._knight = var_0_1:getKnight({
				id = self._data.knightSid
			})
		end
	end

	if not self._isInitBg then
		self._isInitBg = true

		self.m_bgComp:initData({
			title = var_0_2:get(201105),
			englishTitle = var_0_2:get(201106),
			item = {
				alphaDistance = 320,
				type = 2,
				res = {
					isAlphaNode = true,
					isShowBg = true,
					knight = self._knight
				},
				alphaRect = cc.rect(-250, 0, 400, 0)
			},
			quality = self._knight:getBaseInfo().quality
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

function KnightStarUpSuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_uniteToken_upGrade",
		isLoop = false,
		anim = "play_" .. self._knight:getBaseInfo().quality + 1
	})
end

function KnightStarUpSuccessPop:_onPlayStarSpineEff()
	self.m_starComp:addEffectToStars(self._starNum, self._starNum, {
		remove = true,
		name = "eff_ui_knight_upstar",
		isLoop = false,
		anim = "play",
		eventHandler = handler(self, self._onStarPlayFinish)
	})
end

function KnightStarUpSuccessPop:playStarLineEff()
	self.m_effStarLine:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_upstarline",
		anim = "play",
		isLoop = false
	})
end

function KnightStarUpSuccessPop:_onStarPlayFinish(arg_7_1)
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

function KnightStarUpSuccessPop:updateComp()
	if self._knight then
		local var_8_0 = self._knight:getBaseInfo()

		self._starNum = self._knight:getStarLv()

		self.m_starComp:initStar({
			gap = 0,
			style = 2,
			type = 1,
			index = 4,
			num = self._starNum - 1
		})

		local var_8_1, var_8_2, var_8_3 = var_0_0:getQualityTxtAndBg(var_8_0.quality)
		local var_8_4 = var_8_0.star
		local var_8_5 = ""
		local var_8_7

		if var_8_0["star_talent_" .. var_8_0.star] > 0 then
			var_8_7 = g.core.config.talent_skill_info.get(var_8_0["star_talent_" .. var_8_0.star])
			var_8_5 = g.core.lang:getFormatLongText(var_8_7.description, 30)

			if var_8_5 == "0" then
				var_8_5 = g.core.lang:get(201011)
			end
		else
			local var_8_9 = g.core.lang:get(201011)
		end

		self.m_talentTitle:setText("【" .. ((var_8_7 or nil) and (var_8_7.name or "")) .. "】")
		self.m_talentDesc:setText(var_8_5)
		self.m_talentGroup:setVisible(var_8_5 ~= "" and true or false)
		self.m_bloodGroup:setVisible(false)

		local var_8_10 = self:_getSkillData(self._knight, var_8_0)

		self.m_skillPosController:setSelectedIndex(#var_8_10)

		for iter_8_0 = 1, #var_8_10 do
			local var_8_11 = {}

			var_8_11 = var_8_10[iter_8_0].isPassive and g.core.config.passive_skill_info.get(var_8_10[iter_8_0].skillId) or g.core.config.skill_info.get(var_8_10[iter_8_0].skillId)

			self["m_skill" .. iter_8_0]:updateIcon(var_8_10[iter_8_0])
			self["m_skill" .. tostring(iter_8_0) .. "Level"]:setText(var_8_11.level)
		end

		for iter_8_1, iter_8_2 in ipairs((self._knight:getCurStarAttr(var_8_4))) do
			iter_8_2.isShowAnima = true
			iter_8_2.iconType = 2

			self["m_attr" .. iter_8_1]:updateAttr(iter_8_2)
		end

		self:_checkSkillGroupAdapt(var_8_10)
		KnightVoiceCommon.playVoice({
			voiceType = "growup_sound",
			knight = self._knight
		})

		local var_8_12 = var_0_1:getCurStarActiveTalent(self._knight)

		if var_8_12 then
			self._exData = var_8_12
		end
	end
end

function KnightStarUpSuccessPop:_getSkillData(arg_9_1, arg_9_2)
	local var_9_0, var_9_1

	if not arg_9_2 then
		do return {} end

		var_9_0 = {}
		var_9_1 = var_0_3.get(arg_9_2.advance_id + arg_9_2.star - 1) or {}
	end

	if arg_9_2.quality >= var_0_4.UR then
		local var_9_2 = {
			preSkillId = var_9_1.common_id,
			skillId = arg_9_2.common_id
		}

		if self:_isShowSkill(var_9_2) then
			table.insert(var_9_0, var_9_2)
		end

		local var_9_3 = {
			preSkillId = var_9_1.active_skill_id,
			skillId = arg_9_2.active_skill_id
		}

		if self:_isShowSkill(var_9_3) then
			table.insert(var_9_0, var_9_3)
		end

		if arg_9_2.energy_skill_id then
			local var_9_4 = {
				preSkillId = var_9_1.energy_skill_id,
				skillId = arg_9_2.energy_skill_id
			}

			if self:_isShowSkill(var_9_4) then
				table.insert(var_9_0, var_9_4)
			end
		end

		local var_9_5 = {
			isPassive = true,
			preSkillId = var_9_1.advanced_passive_skill_id_1,
			skillId = arg_9_2.advanced_passive_skill_id_1
		}

		if var_9_5.skillId > 0 and self:_isShowSkill(var_9_5) then
			table.insert(var_9_0, var_9_5)
		end
	else
		local var_9_6 = {
			preSkillId = var_9_1.common_id,
			skillId = arg_9_2.common_id
		}

		if self:_isShowSkill(var_9_6) then
			table.insert(var_9_0, var_9_6)
		end

		local var_9_7 = {
			preSkillId = var_9_1.active_skill_id,
			skillId = arg_9_2.active_skill_id
		}

		if self:_isShowSkill(var_9_7) then
			table.insert(var_9_0, var_9_7)
		end
	end

	return var_9_0
end

function KnightStarUpSuccessPop:_isShowSkill(arg_10_1)
	if arg_10_1 and arg_10_1.skillId and arg_10_1.preSkillId ~= arg_10_1.skillId then
		return true
	end

	return false
end

function KnightStarUpSuccessPop:_onClick()
	if self._exData then
		self:showExPage()

		return
	end

	KnightVoiceCommon.stopVoice()
	g.core.module.ModuleManager:popComponent()
end

function KnightStarUpSuccessPop:showExPage()
	if self._exData then
		self.m_skillExIcon:updateKnightAdvExIcon(nil, self._exData.talentSkillCfg)
		self.m_talentSkillName:setText(g.core.lang:get(201029, {
			name = self._exData.talentSkillCfg.name
		}))
		self.m_talentSkillDesc:setText(self._exData.talentSkillCfg.description)
		self.m_stateController:setSelectedIndex(1)

		self._exData = nil
	end
end

function KnightStarUpSuccessPop:_checkSkillGroupAdapt(arg_13_1)
	if #arg_13_1 == 2 then
		self.m_skillGroup1:setX(self._skill1InitialPosX - (display.width - CC_DESIGN_RESOLUTION.width) / 20)
		self.m_skillGroup2:setX(self._skill1InitialPosX - (display.width - CC_DESIGN_RESOLUTION.width) / 20 + 210)
	elseif #arg_13_1 == 1 then
		self.m_skillGroup1:setX(990 + (display.width - CC_DESIGN_RESOLUTION.width))
	end
end

return KnightStarUpSuccessPop
