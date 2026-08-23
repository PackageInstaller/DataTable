local var_0_0 = g.core.model.User.gmPassCardData
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = g.core.const.ConstMgr.SpineConst
local PassCardNewPreviewPop = class("PassCardNewPreviewPop", require("app.fairyGUI.newPassCard.UI_PassCardNewPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "PassCardNewPreviewPop",
		pkgPath = "ui/newPassCard/newPassCard",
		isFullScreen = false,
		pkgName = "newPassCard"
	}, ...)
end)

function PassCardNewPreviewPop:ctor()
	self:getView():setSize(display.width, display.height)
	self.m_closePnl:addClickListener(handler(self, self.closePnl))
	self:showAtCenter()
	self:initPassCardPreview()
	self.m_enterTransition:play()
end

function PassCardNewPreviewPop:initPassCardPreview()
	local var_3_0 = var_0_0:getActivityCfg()

	self._knightSpine = DrawKnight.new({
		scale = 1,
		isShowBg = false,
		isAlphaNode = true,
		resId = g.core.config.knight_base_info.get(var_3_0.show).painted_id
	})

	self._knightSpine:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:addChild(self._knightSpine)
	self.m_artifactLoader:setIcon(g.core.common.Path:getArtifactPic(g.core.config.artifact_info.get(var_3_0.show_2).res_id))

	self._normalList, self._payList = var_0_0:getAllPassCardAwards()

	self.m_normalList:setVirtual()
	self.m_normalList:setItemRenderer(handler(self, self.onItemNormalRenderer))
	self.m_normalList:setNumItems(#self._normalList)
	self.m_payList:setVirtual()
	self.m_payList:setItemRenderer(handler(self, self.onItemPayRenderer))
	self.m_payList:setNumItems(#self._payList)
end

function PassCardNewPreviewPop:closePnl()
	if not self._close then
		self._close = true

		self.m_backTransition:play(handler(self, self.onFinishClose))
	end
end

function PassCardNewPreviewPop:onFinishClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PassCardNewPreviewPop:onItemNormalRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._normalList[arg_6_1 + 1])
end

function PassCardNewPreviewPop:onItemPayRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._payList[arg_7_1 + 1])
end

return PassCardNewPreviewPop
