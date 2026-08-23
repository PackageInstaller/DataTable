local BaseTreasureSpAttrComp = class("BaseTreasureSpAttrComp", require("app.fairyGUI.base_new.UI_BaseTreasureSpAttrComp"))

function BaseTreasureSpAttrComp:update(arg_1_1)
	local var_1_0 = g.core.config.treasure_info.get(arg_1_1.data.value)

	self.m_qualityIcon:setURL((g.core.common.Path:getQualityArtTxtURLNew(var_1_0.quality)))
	self.m_iconComp:update({
		name = "",
		iconUrl = g.core.common.Path:getTreasurePicById(var_1_0.res_id)
	})
	self.m_nameText:setText(var_1_0.name)

	local var_1_1 = g.core.model.User.treasureData:getAddTreasure(arg_1_1.data.value)

	self.m_scoreText:setText((g.core.model.User.treasureData:getTreasureSpecialAttrsScore(var_1_1.id)))

	local var_1_2 = g.core.model.User.treasureData:getTreasureSpecialAttrsList(var_1_1.id)

	for iter_1_0 = 1, 2 do
		if var_1_2[iter_1_0] then
			var_1_2[iter_1_0].withoutPlus1 = false
			var_1_2[iter_1_0].customBg = g.core.common.Path:getAttrQualityBgByQuality(var_1_2[iter_1_0].attrPoolInfo.quality or 1)

			self["m_attrComp" .. iter_1_0]:updateAttr(var_1_2[iter_1_0])
			self["m_attrComp" .. iter_1_0]:setVisible(true)
		else
			self["m_attrComp" .. iter_1_0]:setVisible(false)
		end
	end

	self._serverId = var_1_1.id
	self._baseId = arg_1_1.data.value

	self.m_iconComp:addClickListener(handler(self, self._onClickImg))
end

function BaseTreasureSpAttrComp:_onClickImg()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.TreasureInfoPop").new({
		id = self._baseId,
		onlyId = self._serverId
	}), {
		hideContinue = true,
		touchDisappear = true
	})
end

function BaseTreasureSpAttrComp:playAnimate()
	self.m_enterTransition:play()
	self.m_iconComp.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_common_singlereward",
		scale = 1,
		isLoop = false
	})
end

return BaseTreasureSpAttrComp
