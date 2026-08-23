local var_0_1 = g.core.config.passive_skill_info
local var_0_2 = g.core.const.ConstMgr.WeddingConst
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.weddingData
local var_0_5 = g.core.config.attribute_info
local var_0_6 = g.core.model.User.knightsData
local var_0_7 = g.core.config.wedding_vow_info
local WeddingSuccessPop = class("WeddingSuccessPop", require("app.fairyGUI.wedding.UI_WeddingSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "WeddingSuccessPop",
		pkgPath = "ui/wedding/wedding",
		isFullScreen = true,
		pkgName = "wedding"
	}, ...)
end)

function WeddingSuccessPop:ctor(arg_2_1)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_6:getKnight(arg_2_1)
	end

	self._attrDataList = {}
	self._advId = self._knightStruct:getAdvanceId()
	self._vowInfo = var_0_7.get(self._advId)

	self.m_enterTransition:play()
	self:initView()
	self:_playFeedEffect()
end

function WeddingSuccessPop:_playFeedEffect()
	self.m_effFeedback:setScale(display.height / 750)
	self.m_effFeedback:addEffectSpine({
		anim = "play",
		name = "eff_ui_wedding_feedback",
		remove = false,
		isLoop = true
	})
	self.m_effTitle:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_uptitle",
		anim = "play",
		isLoop = false
	})
end

function WeddingSuccessPop:initView()
	self:showAtCenter()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_passiveIcon:addClickListener(handler(self, self._onClickSkillIcon))
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))

	if self._vowInfo.skin > 0 then
		self.m_knightPicComp:updateKnight({
			skinId = self._vowInfo.skin
		})
	else
		local var_4_1 = {}

		var_4_1.resId = self._knightStruct:getResInfo().painted_id

		self.m_knightPicComp:updateKnight(var_4_1)
	end

	self.m_knightPicComp:setAlphaRect(var_0_3.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 400)
end

function WeddingSuccessPop:_onRenderAttrList(arg_5_1, arg_5_2)
	local var_5_0 = self._attrDataList[arg_5_1 + 1]
	local var_5_1, var_5_2 = g.core.lang:getAttr(self._attrDataList[arg_5_1 + 1].info.id, self._attrDataList[arg_5_1 + 1].value)

	var_5_1 = var_5_0.target == var_0_2.ATTR_TARGET.ALL and g.core.lang:get(2071, {
		name = var_5_1
	}) or g.core.lang:get(412007, {
		knightName = self._knightStruct:getName(),
		attrName = var_5_1
	})

	arg_5_2:getChild("attrNameText"):setText(var_5_1)
	arg_5_2:getChild("attrValueText"):setText(var_5_2)
end

function WeddingSuccessPop:onLoad()
	self:updateView()
end

function WeddingSuccessPop:updateView()
	self._attrDataList = {}

	local var_7_0, var_7_1, var_7_2 = var_0_4:getCurFavorAttrList(self._knightStruct:getAdvanceId())

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(self._attrDataList, {
			info = var_0_5.get(iter_7_0),
			value = iter_7_1,
			target = var_0_2.ATTR_TARGET.KNIGHT
		})
	end

	for iter_7_2, iter_7_3 in pairs(var_7_1) do
		table.insert(self._attrDataList, {
			info = var_0_5.get(iter_7_2),
			value = iter_7_3,
			target = var_0_2.ATTR_TARGET.ALL
		})
	end

	for iter_7_4, iter_7_5 in pairs(var_7_2) do
		table.insert(self._attrDataList, {
			info = var_0_5.get(iter_7_4),
			value = iter_7_5,
			target = var_0_2.ATTR_TARGET.ALL
		})
	end

	self.m_attrList:setNumItems(#self._attrDataList)

	local var_7_3 = var_0_4:getCurFavorInfo(self._advId).level

	self.m_levelText:setText(g.core.lang:get(100535, {
		lv = var_7_3
	}))

	local var_7_4 = var_0_1.get(var_0_4:getWeddingVowInfo(self._advId)["skill_" .. var_7_3])

	self.m_passiveIcon:updateIcon({
		isPassive = true,
		skillId = var_7_4.id
	})
	self.m_skillName:setText(g.core.lang:get(201029, {
		name = var_7_4.name
	}))
	self.m_skillDesc:setText((g.core.utils.String.formatPassiveSkillDesc(var_7_4.passive_skill_value)))
end

function WeddingSuccessPop:_onClickSkillIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightWeddingSkillTip").new({
		knightStruct = self._knightStruct
	}), {
		touchDisappear = true
	})
end

function WeddingSuccessPop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function WeddingSuccessPop:onRemoved()
	local var_10_0 = self._knightStruct

	if var_0_4:getWeddingVowInfo(self._advId).skin > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.KnightShowTimePop").new({
			isNew = true,
			num = 1,
			skinId = var_0_4:getWeddingVowInfo(self._advId).skin,
			callBack = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
					knightStruct = var_10_0
				}, true, true)
			end
		}), {
			ignoreTouch = true
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_MAIN_POP, {
			knightStruct = self._knightStruct
		}, true, true)
	end
end

return WeddingSuccessPop
