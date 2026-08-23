local var_0_0 = g.core.model.User.commonPassCardDataMgr
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_2 = g.core.const.ConstMgr.SpineConst
local CommonPassCardPreviewPop = class("CommonPassCardPreviewPop", require("app.fairyGUI.commonPassCard.UI_CommonPassCardPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "CommonPassCardPreviewPop",
		pkgPath = "ui/commonPassCard/commonPassCard",
		isFullScreen = false,
		pkgName = "commonPassCard"
	}, ...)
end)

function CommonPassCardPreviewPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)

	self._actId = arg_2_1.activityId

	self.m_closePnl:addClickListener(handler(self, self.closePnl))
	self:showAtCenter()
	self:initPassCardPreview()
	self.m_enterTransition:play()
end

function CommonPassCardPreviewPop:initPassCardPreview()
	self._commonPassCardData = var_0_0:getPassCardData(self._actId)

	local var_3_0 = self._commonPassCardData:getActivityCfg()

	self._knightSpine = DrawKnight.new({
		scale = 1,
		isShowBg = false,
		isAlphaNode = true,
		resId = g.core.config.knight_base_info.get(var_3_0.show).painted_id
	})

	self._knightSpine:setAlphaRect(var_0_2.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:addChild(self._knightSpine)
	self.m_artifactLoader:setIcon(g.core.common.Path:getArtifactPic(g.core.config.artifact_info.get(var_3_0.show_2).res_id))

	self._normalList, self._payList = self._commonPassCardData:getAllPassCardAwards()

	self.m_normalList:setVirtual()
	self.m_normalList:setItemRenderer(handler(self, self.onItemNormalRenderer))
	self.m_normalList:setNumItems(#self._normalList)
	self.m_payList:setVirtual()
	self.m_payList:setItemRenderer(handler(self, self.onItemPayRenderer))
	self.m_payList:setNumItems(#self._payList)
end

function CommonPassCardPreviewPop:closePnl()
	if not self._close then
		self._close = true

		self.m_backTransition:play(handler(self, self.onFinishClose))
	end
end

function CommonPassCardPreviewPop:onFinishClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function CommonPassCardPreviewPop:onItemNormalRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._normalList[arg_6_1 + 1])
end

function CommonPassCardPreviewPop:onItemPayRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._payList[arg_7_1 + 1])
end

return CommonPassCardPreviewPop
