local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local HandBookKnightComp = class("HandBookKnightComp", require("app.fairyGUI.handBook.UI_HandBookKnightText"))
local var_0_2 = 196
local var_0_3 = {
	[0] = cc.c3b(200, 200, 200),
	cc.c3b(56, 135, 215),
	cc.c3b(144, 81, 192),
	cc.c3b(229, 139, 79),
	cc.c3b(229, 139, 79),
	(cc.c3b(229, 139, 79))
}

function HandBookKnightComp:ctor()
	self._data = nil
	self._advId = 0
	self._animEndCall = nil

	self.m_btnDetail:addClickListener(handler(self, self._onShowDetail))
end

function HandBookKnightComp:setData(arg_2_1, arg_2_2, arg_2_3)
	self._data = arg_2_1
	self._advId = arg_2_1.data.advId

	if arg_2_1.bookInfo then
		self.m_bookValueTxt:setText(arg_2_1.bookInfo.score)
	else
		self.m_bookValueTxt:setText(0)
	end

	self.m_levelController:setSelectedIndex(arg_2_1.data.level)
	self.m_nameTxt:setText(arg_2_1.name)

	local var_2_0 = arg_2_1.data.quality
	local var_2_1, var_2_2 = g.core.common.Path:getKnightHandBookCardQualityBg(arg_2_1.data.quality)

	self.m_qualityLeft:setURL(var_2_1)
	self.m_qualityRight:setURL(var_2_2)
	self.m_englishName:setColor(var_0_3[var_2_0])
	self.m_englishName:setText("ECHO")

	local var_2_4 = var_2_0 < var_0_0.UR

	self.m_englishName:setVisible(var_2_0 < var_0_0.UR)
	self.m_englishLoader:setVisible(not var_2_4)

	if var_2_0 >= var_0_0.UR then
		self.m_englishLoader:setURL("ui://handBook/pic_tj_tujianpinzhi_" .. var_2_0 + 1)
	end

	if self.m_activeEffHolder then
		self.m_activeEffHolder:removeAllEffect()
	end

	if arg_2_2 and arg_2_2 == self._advId and arg_2_1.data.level == 0 then
		self._animEndCall = arg_2_3

		self:playUpgradeEff()
	end

	local var_2_5 = self.m_nameTxt:getSize().width

	if var_2_5 > var_0_2 then
		self.m_nameTxt:setScaleX(var_0_2 / var_2_5)
	end

	local var_2_6 = arg_2_1.data

	self.m_activedController:setSelectedIndex(1)

	if var_2_6.curState == 1 then
		self.m_noticeController:setSelectedIndex(1)
		self.m_activedController:setSelectedIndex(0)
		self.m_knightLoader:setURL(arg_2_1.res)
		self.m_knightLoader:setGloaderColor(true, cc.vec3(0.49, 0.49, 0.49))
	elseif var_2_6.curState == 3 then
		local var_2_7 = g.core.model.User.handBookData:getBookInfoByIdAndLevel(var_2_6.advId, g.core.model.User.handBookData:getKnightBookLevel(var_2_6.advId) + 1)

		if g.core.model.User.bagData:getOwnNum(var_2_7.cost_type, var_2_7.cost_value) >= var_2_7.cost_size then
			self.m_noticeController:setSelectedIndex(1)
		else
			self.m_noticeController:setSelectedIndex(0)
		end

		self.m_knightLoader:setURL(arg_2_1.res)
		self.m_knightLoader:setGloaderColor(false, cc.vec3(0.49, 0.49, 0.49))
	else
		self.m_noticeController:setSelectedIndex(0)
		self.m_knightLoader:setURL(arg_2_1.res)

		if var_2_6.curState == 0 then
			self.m_activedController:setSelectedIndex(0)
			self.m_knightLoader:setGloaderColor(true, cc.vec3(0.49, 0.49, 0.49))
		else
			self.m_knightLoader:setGloaderColor(false, cc.vec3(0.49, 0.49, 0.49))
		end
	end
end

function HandBookKnightComp:playUpgradeEff()
	self.m_activeEffHolder:addEffectSpine({
		name = "eff_ui_handbook_activate",
		isLoop = false,
		eventHandler = handler(self, self.onSpineHandler)
	})
end

function HandBookKnightComp:onSpineHandler(arg_4_1)
	if arg_4_1.type == "complete" then
		if self._animEndCall then
			self._animEndCall()
		end

		self._animEndCall = nil
	end
end

function HandBookKnightComp:playEnterAnim()
	self.m_enterTransition:play()
end

function HandBookKnightComp:_onShowDetail()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
		knightAdvId = self._advId
	}), {
		withoutAni = true
	})
end

return HandBookKnightComp
