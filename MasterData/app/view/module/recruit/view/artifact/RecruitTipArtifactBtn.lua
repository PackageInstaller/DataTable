local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.common.Path
local RecruitTipArtifactBtn = class("RecruitTipArtifactBtn", require("app.fairyGUI.recruitArtifact.UI_RecruitTipArtifactBtn"))

function RecruitTipArtifactBtn:ctor()
	self.m_icon = self:getChild("icon")
	self._midPos = self.m_icon:getPosition()
	self._info = nil

	self:addClickListener(handler(self, self._onClickSearchBtn))
end

function RecruitTipArtifactBtn:updateComp(arg_2_1, arg_2_2, arg_2_3)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ARTIFACT,
		value = arg_2_1.knight_id
	})

	if false then
		self.m_knightComp:removeChildren()

		local var_2_0 = DrawKnight.new({
			isShowBg = true,
			baseId = arg_2_1.knight_id
		})

		var_2_0:setScale(0.8)
		var_2_0:setPosition(cc.p(arg_2_1.x, arg_2_1.y))
		self.m_knightComp:addChild(var_2_0)
	else
		local var_2_1 = g.core.config.artifact_info.get(arg_2_1.knight_id)
		local var_2_2 = g.core.common.Path:getArtifactPic(var_2_1.res_id)

		self:setIcon((({
			[600150] = true,
			[600160] = true
		})[arg_2_1.knight_id] or nil) and g.core.common.Path:getRecruitShowArtifactIconById(var_2_1.res_id))

		if arg_2_3 then
			self.m_icon:setPosition(cc.p(self._midPos.x + arg_2_1.x, self._midPos.y + arg_2_1.y))
		end
	end

	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBg(self._info.quality))
end

function RecruitTipArtifactBtn:updateCompByKnightId(arg_3_1)
	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ARTIFACT,
		value = arg_3_1
	})

	self:setIcon(g.core.common.Path:getArtifactPic(g.core.config.artifact_info.get(arg_3_1).res_id))
	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_1:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_1:getRecruitQualitySquareBg(self._info.quality))
	self.m_icon:setPosition(self._midPos)
end

function RecruitTipArtifactBtn:_onPressTouchBegin(arg_4_1)
	arg_4_1:captureTouch()
end

function RecruitTipArtifactBtn:_onPressTouchEnd(arg_5_1)
	self:_onClickSearchBtn()
end

function RecruitTipArtifactBtn:_onClickSearchBtn()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

return RecruitTipArtifactBtn
