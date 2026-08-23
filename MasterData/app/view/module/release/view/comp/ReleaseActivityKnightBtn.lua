local var_0_0 = g.core.common.Path
local DrawKnight = require("app.view.common.DrawKnight")
local ReleaseActivityKnightBtn = class("ReleaseActivityKnightBtn", require("app.fairyGUI.release.UI_ReleaseActivityKnightBtn"))

function ReleaseActivityKnightBtn:ctor()
	self._knightSpine = nil

	self.m_bgLoader:addClickListener(handler(self, self._onClickSelf))
	self.m_elementLoader:addClickListener(handler(self, self._onClickElemDetail))
end

function ReleaseActivityKnightBtn:updateKnightBtn()
	local var_2_0 = g.core.model.User.releaseActivityData:getActivityReleaseDisplayCfg()

	self._info = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_KNIGHT,
		value = var_2_0.role
	})

	self.m_nameText:setText(self._info.name)
	self.m_qualityTextLoader:setURL(var_0_0:getQualityArtTxtURLNew(self._info.quality))
	self.m_bgLoader:setURL(var_0_0:getRecruitQualitySquareBg(self._info.quality))

	if self._info and self._info.info and self._info.info.classical and self._info.info.classical ~= 0 then
		self._classical = self._info.info.classical
		self._knightCfg = self._info.info

		self.m_elementLoader:setURL(var_0_0:getKnightElementIcon(self._classical))
	else
		self.m_elementLoader:setURL("")
	end

	if not self._knightSpine then
		self._knightSpine = DrawKnight.new({
			isAlphaNode = true,
			scale = 1,
			resId = var_2_0.role,
			isShowBg = checkbool(var_2_0.is_show_bg == 1)
		})

		self.m_knightComp:addChild(self._knightSpine)

		local var_2_1 = self.m_knightComp:getPosition()

		self.m_knightComp:setPosition(var_2_1.x + var_2_0.pos_x, var_2_1.y + var_2_0.pos_y)
		self._knightSpine:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	end
end

function ReleaseActivityKnightBtn:_onClickSelf()
	g.core.common.GlobalFunc.pushInfoPop(self._info)
end

function ReleaseActivityKnightBtn:_onClickElemDetail()
	if self._classical == 0 or not self._knightCfg then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.BaseClassicalDetailPop").new({
		classical = self._classical,
		knightCfg = self._knightCfg
	})))
end

return ReleaseActivityKnightBtn
