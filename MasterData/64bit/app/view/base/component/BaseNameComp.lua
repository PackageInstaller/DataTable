local BaseNameComp = class("BaseNameComp", require("app.fairyGUI.base_new.UI_BaseNameComp"))

function BaseNameComp:ctor()
	self.m_elementLoader:addClickListener(handler(self, self._onClickElemDetail))
	self.m_otherElementLoader:addClickListener(handler(self, self._onClickElemDetail))
end

function BaseNameComp:updateNameComp(arg_2_1)
	self._classical = 0

	self.m_nameTxt:setText(arg_2_1.name)
	self.m_quality:setURL(g.core.common.Path:getKnightNameQualityBg(arg_2_1.quality))

	if arg_2_1.level then
		self.m_levelTxt:setVisible(true)
		self.m_qualityIcon:setVisible(false)
		self.m_levelTxt:setText("Lv." .. arg_2_1.level)
	else
		self.m_levelTxt:setVisible(false)
		self.m_qualityIcon:setVisible(true)
		self.m_qualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(arg_2_1.quality))
		self.m_otherQualityIcon:setURL(g.core.common.Path:getQualityArtTxtURL(arg_2_1.quality))

		if arg_2_1.classical and arg_2_1.classical ~= 0 then
			self._classical = arg_2_1.classical
			self._knightCfg = arg_2_1.knightCfg

			self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._classical))
			self.m_otherElementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._classical))
		else
			self.m_elementLoader:setURL("")
			self.m_otherElementLoader:setURL("")
		end
	end

	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = arg_2_1.starTag,
		max = arg_2_1.maxStar,
		num = arg_2_1.curStar
	})

	if arg_2_1.addNum then
		self.m_addTxt:setText("+" .. arg_2_1.addNum)
	else
		self.m_addTxt:setText("")
	end
end

function BaseNameComp:setStarVisible(arg_3_1)
	if arg_3_1 then
		self.m_hideStarController:setSelectedIndex(0)
	else
		self.m_hideStarController:setSelectedIndex(1)
	end
end

function BaseNameComp:_onClickElemDetail()
	if self._classical == 0 or not self._knightCfg then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseClassicalDetailPop").new({
		classical = self._classical,
		knightCfg = self._knightCfg
	})))
end

return BaseNameComp
