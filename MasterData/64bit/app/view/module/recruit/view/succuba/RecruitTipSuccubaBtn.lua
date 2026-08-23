local DrawSuccuba = require("app.view.common.DrawSuccuba")
local var_0_1 = g.core.common.Path
local RecruitTipSuccubaBtn = class("RecruitTipSuccubaBtn", require("app.fairyGUI.recruitSuccuba.UI_RecruitTipSuccubaBtn"))

function RecruitTipSuccubaBtn:ctor()
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._info = nil

	self.m_bgLoader:addClickListener(handler(self, self._onClickSearchBtn))
end

function RecruitTipSuccubaBtn:updateComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_SUCCUBA,
		value = arg_2_1.knight_id
	})

	if arg_2_2 then
		self.m_knightComp:removeChildren()

		local var_2_0 = DrawSuccuba.new({
			resId = arg_2_1.knight_id
		})

		var_2_0:setScale(arg_2_1.scale)
		var_2_0:setPosition((cc.p(arg_2_1.x, arg_2_1.y)))
		self.m_knightComp:addChild(var_2_0)
	else
		self:setIcon((g.core.common.Path:getRecruitShowSuccubaIconById(arg_2_1.knightBgId)))
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
end

function RecruitTipSuccubaBtn:updateCompByKnightId(arg_3_1)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_SUCCUBA,
		value = arg_3_1
	})

	self:setIcon("ui://recruit/" .. arg_3_1)
	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBg(self._info.quality))
	self.m_icon:setPosition(self._midPos)
end

function RecruitTipSuccubaBtn:_onPressTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitTipSuccubaBtn:_onPressTouchEnd(arg_5_1)
	self:_onClickSearchBtn()
end

function RecruitTipSuccubaBtn:_onClickSearchBtn()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

return RecruitTipSuccubaBtn
