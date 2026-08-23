local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.common.Path
local RecruitTipKnightBtn = class("RecruitTipKnightBtn", require("app.fairyGUI.recruit.UI_RecruitTipKnightBtn"))

function RecruitTipKnightBtn:ctor()
	self._classical = 0
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._info = nil

	self.m_bgLoader:addClickListener(handler(self, self._onClickSearchBtn))

	if not self.m_elementLoader then
		return
	end

	self.m_elementLoader:addClickListener(handler(self, self._onClickElemDetail))
	self.m_elementLoader1:addClickListener(handler(self, self._onClickElemDetail))
end

function RecruitTipKnightBtn:updateComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = arg_2_1.knight_id
	})

	if arg_2_2 then
		self.m_knightComp:removeChildren()

		local var_2_0 = DrawKnight.new({
			isShowBg = true,
			baseId = arg_2_1.knight_id
		})

		var_2_0:setScale(arg_2_1.scale)
		var_2_0:setPosition((cc.p(arg_2_1.x, arg_2_1.y)))
		self.m_knightComp:addChild(var_2_0)

		if arg_2_1.knight_id == 510030 then
			var_2_0:setBgScale(0.45)
		end
	else
		self:setIcon((g.core.common.Path:getRecruitShowKnightIconById(arg_2_1.knightBgId)))
		self.m_icon:setPosition(cc.p(self._midPos.x + arg_2_1.x, self._midPos.y + arg_2_1.y))
	end

	self.m_nameText:setText(self._info.name)
	self.m_nameText1:setText(self._info.name)

	if arg_2_4 then
		self.m_showFeatureController:setSelectedIndex(arg_2_4.feature ~= "0" and 1 or 0)
		self.m_featureText1:setText(arg_2_4.feature)
	else
		self.m_showFeatureController:setSelectedIndex(0)
	end

	local var_2_1 = self._info.quality

	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_qualityTextLoader1:setURL(var_0_1:getQualityArtTxtURLNew(var_2_1))

	if not arg_2_5 then
		self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBg(var_2_1))
	else
		self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBgByParam({
			quality = var_2_1,
			package = arg_2_5
		}))
	end

	self:setKnightElementIcon()

	if self.m_isElementLeaderController then
		self.m_isElementLeaderController:setSelectedIndex(arg_2_6 == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN and 1 or 0)
	end
end

function RecruitTipKnightBtn:updateCompByKnightId(arg_3_1)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = arg_3_1
	})

	self:setIcon("ui://recruit/" .. arg_3_1)
	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBg(self._info.quality))
	self.m_icon:setPosition(self._midPos)
	self:setKnightElementIcon()
end

function RecruitTipKnightBtn:setKnightElementIcon()
	self._classical = 0

	if not self.m_elementLoader then
		return
	end

	if self._info and self._info.info and self._info.info.classical and self._info.info.classical ~= 0 then
		self._classical = self._info.info.classical
		self._knightCfg = self._info.info

		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._classical))
		self.m_elementLoader1:setURL(g.core.common.Path:getKnightElementIcon(self._classical))
	else
		self.m_elementLoader:setURL("")
		self.m_elementLoader1:setURL("")
	end
end

function RecruitTipKnightBtn:_onPressTouchBegin(arg_5_1)
	arg_5_1:captureTouch()
end

function RecruitTipKnightBtn:_onPressTouchEnd(arg_6_1)
	self:_onClickSearchBtn()
end

function RecruitTipKnightBtn:_onClickSearchBtn()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

function RecruitTipKnightBtn:_onClickElemDetail()
	if self._classical == 0 or not self._knightCfg then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseClassicalDetailPop").new({
		classical = self._classical,
		knightCfg = self._knightCfg
	})))
end

return RecruitTipKnightBtn
