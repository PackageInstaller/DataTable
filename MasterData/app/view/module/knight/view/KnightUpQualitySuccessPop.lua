local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.lang
local KnightUpQualitySuccessPop = class("KnightUpQualitySuccessPop", require("app.fairyGUI.knight.UI_KnightUpQualitySuccessPop"), function()
	return fgui.GComponent:create({
		resName = "KnightUpQualitySuccessPop",
		pkgPath = "ui/knight/knight",
		isFullScreen = true,
		pkgName = "knight"
	}, ...)
end)

function KnightUpQualitySuccessPop:ctor(arg_2_1)
	self._data = arg_2_1
	self._isCanClose = false
	self._knight = nil
	self._isInitBg = false

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClick))
	self:showAtCenter()
end

function KnightUpQualitySuccessPop:onLoad()
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
			title = var_0_2:get(201103),
			englishTitle = var_0_2:get(201104),
			item = {
				alphaDistance = 200,
				type = 2,
				res = {
					isAlphaNode = true,
					isShowBg = true,
					knight = self._knight
				},
				alphaRect = cc.rect(-250, 0, 430, 0)
			},
			quality = self._knight:getBaseInfo().quality
		})
	end

	self:updateComp()

	if self.m_enterTransition then
		self.m_enterTransition:setHook("upGrade", handler(self, self._onPlayEnterSpineEff))
		self.m_enterTransition:setHook("uptop", handler(self, self._onUpPopSpineEff))
		self.m_enterTransition:play()
	end
end

function KnightUpQualitySuccessPop:_onPlayEnterSpineEff()
	self.m_effPlaceHolder:addEffectSpine({
		remove = true,
		name = "eff_ui_uniteToken_upGrade",
		isLoop = false,
		anim = "play_" .. self._knight:getBaseInfo().quality + 1
	})
end

function KnightUpQualitySuccessPop:_onUpPopSpineEff()
	self.m_effuptop:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_uptop",
		isLoop = false,
		anim = "play_" .. self._knight:getBaseInfo().quality + 1
	})
end

function KnightUpQualitySuccessPop:updateComp()
	if self._knight then
		local var_6_0 = self._knight:getBaseInfo()
		local var_6_1, var_6_2 = var_0_0:getQualityTxtAndBg(var_6_0.quality - 1 <= 0 and 0 or var_6_0.quality - 1)
		local var_6_3, var_6_4 = var_0_0:getQualityTxtAndBg(var_6_0.quality)

		self.m_preQuality:getChild("qualityTxt"):setText(var_6_1)
		self.m_curQuality:getChild("qualityTxt"):setText(var_6_3)

		if var_6_2 then
			self.m_preQuality:getChild("qulityBg"):setURL(var_6_2)
		end

		if var_6_4 then
			self.m_curQuality:getChild("qulityBg"):setURL(var_6_4)
		end

		self.m_curQuality:getController("qualityFontSize"):setSelectedIndex(var_6_3 == "SSR" and 1 or 0)

		local var_6_5, var_6_6, var_6_7 = var_0_1:getCurAttrByQuality((g.core.config.role_quality_info.get((var_0_1:getMainKnightQualityId()))))
		local var_6_8 = {}

		table.insert(var_6_8, {
			type = 1,
			value = var_6_6[1],
			value2 = var_6_5[1]
		})
		table.insert(var_6_8, {
			type = 2,
			value = var_6_6[2],
			value2 = var_6_5[2]
		})
		table.insert(var_6_8, {
			type = 3,
			value = var_6_6[3],
			value2 = var_6_5[3]
		})
		table.insert(var_6_8, {
			type = 4,
			value = var_6_6[4],
			value2 = var_6_5[4]
		})

		for iter_6_0, iter_6_1 in ipairs(var_6_8) do
			iter_6_1.isShowAnima = true
			iter_6_1.iconType = 2

			self["m_attr" .. iter_6_0]:updateAttr(iter_6_1)
		end
	end
end

function KnightUpQualitySuccessPop:_onClick()
	g.core.module.ModuleManager:popComponent()
end

return KnightUpQualitySuccessPop
