local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.lang
local KnightMrCultiSuccessPop = class("KnightMrCultiSuccessPop", require("app.fairyGUI.knight.UI_KnightMrCultiSuccessPop"), function()
	return fgui.GComponent:create({
		pkgName = "knight",
		isFullScreen = true,
		pkgPath = "ui/knight/knight",
		resName = "KnightMrCultiSuccessPop"
	}, ...)
end)

function KnightMrCultiSuccessPop:ctor(arg_2_1)
	self._data = arg_2_1
	self._level = arg_2_1.level
	self._skillLevel = arg_2_1.skill_level
	self._knight = nil

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
	self:showAtCenter()
end

function KnightMrCultiSuccessPop:onLoad()
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

		local var_3_0 = {}

		if self._level then
			var_3_0.title = var_0_2:get(201118) or var_0_2:get(201119)
		end

		if self._level then
			var_3_0.englishTitle = var_0_2:get(201120) or var_0_2:get(201121)
		end

		var_3_0.item = {
			alphaDistance = 320,
			type = 2,
			res = {
				isShowBg = true,
				isAlphaNode = true,
				knight = self._knight
			},
			alphaRect = cc.rect(-250, 0, 400, 0)
		}
		var_3_0.quality = self._knight:getBaseInfo().quality

		self.m_bgComp:initData(var_3_0)
	end

	self:updateComp()

	if self.m_enterTransition then
		if self._level then
			self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
			self.m_enterTransition:play()
		else
			self.m_enter_state1Transition:play()
		end
	end
end

function KnightMrCultiSuccessPop:updateComp()
	local var_4_0 = self._level or self._skillLevel

	self.m_level:setText(var_4_0 - 1)
	self.m_levelAfter:setText(var_4_0)

	if self._level then
		self.m_stateController:setSelectedIndex(0)

		for iter_4_0, iter_4_1 in ipairs((self._knight:getSpSoulAttr(self._level - 1))) do
			iter_4_1.isShowAnima = true
			iter_4_1.iconType = 2

			self["m_attr" .. iter_4_0]:updateAttr(iter_4_1)
		end
	elseif self._skillLevel then
		self.m_stateController:setSelectedIndex(1)

		local var_4_2 = self._knight:getSpSupportSkills()[self._skillLevel]
		local var_4_3 = g.core.config.passive_skill_info.get(var_4_2.passive_skill)

		self.m_talentSkillName:setText(var_4_3.name)
		self.m_talentSkillDesc:setText((g.core.utils.String.formatSkillDesc(var_4_3.passive_skill_value)))
		self.m_skillComp:updateIcon({
			isPassive = true,
			skillId = var_4_2.passive_skill,
			star = var_4_2.level,
			knightAdvId = var_4_2.advance_id
		})
	end
end

function KnightMrCultiSuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		name = "eff_ui_uniteToken_upGrade",
		isLoop = false,
		remove = true,
		anim = "play_" .. self._knight:getBaseInfo().quality + 1
	})
end

function KnightMrCultiSuccessPop:_onClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return KnightMrCultiSuccessPop
