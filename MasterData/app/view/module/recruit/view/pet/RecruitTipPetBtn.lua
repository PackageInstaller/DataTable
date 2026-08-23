local DrawPet = require("app.view.common.DrawPet")
local var_0_1 = g.core.common.Path
local RecruitTipPetBtn = class("RecruitTipPetBtn", require("app.fairyGUI.recruitPet.UI_RecruitTipPetBtn"))

function RecruitTipPetBtn:ctor()
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._info = nil

	self:addClickListener(handler(self, self._onClickSearchBtn))
end

function RecruitTipPetBtn:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_PET,
		value = arg_2_1.knight_id
	})

	if arg_2_2 then
		self.m_knightComp:removeChildren()

		local var_2_0 = DrawPet.new({
			isShowBg = true,
			advId = arg_2_1.knight_id
		})

		var_2_0:setScale(arg_2_1.scale)
		var_2_0:setPosition((cc.p(arg_2_1.x, arg_2_1.y)))
		self.m_knightComp:addChild(var_2_0)

		if arg_2_1.knight_id == 510030 then
			var_2_0:setBgScale(0.45)
		end
	else
		self:setIcon((g.core.common.Path:getRecruitShowPetIconById(arg_2_1.knightBgId)))

		if arg_2_3 then
			self.m_icon:setPosition(cc.p(self._midPos.x + arg_2_1.x, self._midPos.y + arg_2_1.y))
		end
	end

	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualityDiamondBg(self._info.quality))
end

function RecruitTipPetBtn:updateCompByKnightId(arg_3_1)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_PET,
		value = arg_3_1
	})

	local var_3_0 = g.core.config.pet_info.get(arg_3_1)

	self:setIcon("ui://recruit/" .. arg_3_1)
	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualityDiamondBg(self._info.quality))
	self.m_icon:setPosition(self._midPos)
end

function RecruitTipPetBtn:_onPressTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitTipPetBtn:_onPressTouchEnd(arg_5_1)
	self:_onClickSearchBtn()
end

function RecruitTipPetBtn:_onClickSearchBtn()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

return RecruitTipPetBtn
