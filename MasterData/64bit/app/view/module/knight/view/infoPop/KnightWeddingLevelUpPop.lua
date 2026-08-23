local var_0_0 = g.core.const.ConstMgr.WeddingConst
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.model.User.weddingData
local var_0_3 = g.core.config.attribute_info
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.config.passive_skill_info
local KnightWeddingLevelUpPop = class("KnightWeddingLevelUpPop", require("app.fairyGUI.knight.UI_KnightWeddingLevelUpPop"), function()
	return fgui.GComponent:create({
		resName = "KnightWeddingLevelUpPop",
		pkgName = "knight",
		isFullScreen = true,
		pkgPath = "ui/knight/knight"
	}, ...)
end)

function KnightWeddingLevelUpPop:ctor(arg_2_1)
	if arg_2_1.knightStruct then
		self._knightStruct = arg_2_1.knightStruct
	elseif arg_2_1 then
		self._knightStruct = var_0_4:getKnight(arg_2_1)
	end

	self._attrDataList = {}
	self._advId = self._knightStruct:getAdvanceId()
	self._curInfo = var_0_2:getCurFavorInfo(self._advId)

	self:initView()
	self:_playFeedEffect()
end

function KnightWeddingLevelUpPop:_playFeedEffect()
	self.m_effFeedback:setScale(display.height / 750)
	self.m_effFeedback:addEffectSpine({
		name = "eff_ui_wedding_feedback",
		anim = "play",
		remove = false,
		isLoop = true
	})
	self.m_effTitle:addEffectSpine({
		name = "eff_ui_knight_uptitle",
		remove = true,
		anim = "play",
		isLoop = false
	})
end

function KnightWeddingLevelUpPop:initView()
	self:showAtCenter()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_touchComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_knightPicComp:updateKnight({
		resId = self._knightStruct:getResInfo().painted_id
	})
	self.m_knightPicComp:setAlphaRect(var_0_1.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 400)
end

function KnightWeddingLevelUpPop:_onRenderAttrList(arg_5_1, arg_5_2)
	local var_5_0 = self._attrDataList[arg_5_1 + 1]
	local var_5_1, var_5_2 = g.core.lang:getAttr(self._attrDataList[arg_5_1 + 1].info.id, self._attrDataList[arg_5_1 + 1].value)

	var_5_1 = var_5_0.target == var_0_0.ATTR_TARGET.ALL and g.core.lang:get(2071, {
		name = var_5_1
	}) or g.core.lang:get(412007, {
		knightName = self._knightStruct:getName(),
		attrName = var_5_1
	})

	arg_5_2:getChild("attrNameText"):setText(var_5_1)
	arg_5_2:getChild("attrValueText"):setText(var_5_2)
end

function KnightWeddingLevelUpPop:onLoad()
	self:updateView()
end

function KnightWeddingLevelUpPop:updateView()
	self._attrDataList = {}

	local var_7_0, var_7_1, var_7_2 = var_0_2:getCurFavorAttrList(self._knightStruct:getAdvanceId())

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		table.insert(self._attrDataList, {
			info = var_0_3.get(iter_7_0),
			value = iter_7_1,
			target = var_0_0.ATTR_TARGET.ALL
		})
	end

	for iter_7_2, iter_7_3 in pairs(var_7_2) do
		table.insert(self._attrDataList, {
			info = var_0_3.get(iter_7_2),
			value = iter_7_3,
			target = var_0_0.ATTR_TARGET.ALL
		})
	end

	self.m_attrList:setNumItems(#self._attrDataList)
	self.m_levelText:setText(g.core.lang:get(100535, {
		lv = self._curInfo.level
	}))

	local var_7_3 = var_0_5.get(var_0_2:getWeddingVowInfo(self._advId)["skill_" .. self._curInfo.level])

	self.m_passiveIcon:updateIcon({
		isPassive = true,
		skillId = var_7_3.id
	})
	self.m_skillLevelText:setText(g.core.lang:get(100535, {
		lv = var_7_3.level
	}))
	self.m_skillName:setText(g.core.lang:get(410615, {
		name = var_7_3.name
	}))
	self.m_skillDesc:setText((g.core.utils.String.formatPassiveSkillDesc(var_7_3.passive_skill_value)))
end

function KnightWeddingLevelUpPop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return KnightWeddingLevelUpPop
