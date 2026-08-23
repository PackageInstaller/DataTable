local var_0_0 = g.core.model.User.releaseActivityData
local DrawKnight = require("app.view.common.DrawKnight")
local ReleaseActivityPreviewPop = class("ReleaseActivityPreviewPop", require("app.fairyGUI.release.UI_ReleaseActivityPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "ReleaseActivityPreviewPop",
		pkgPath = "ui/release/release",
		pkgName = "release"
	}, ...)
end)

function ReleaseActivityPreviewPop:ctor()
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()

	self._releaseInfo = var_0_0:getReleaseInfo()
	self._spinnerId = var_0_0:getSpinnerId()

	self:_initPreviewList()
	self.m_topBarComp:setTitle(self._releaseInfo.name)
	self.m_previewList:setVirtual()
	self.m_previewList:doFairyBatching(false)
	self.m_previewList:setItemRenderer(handler(self, self._onPreviewItemRender))
end

function ReleaseActivityPreviewPop:_initPreviewList()
	self._previewData = var_0_0:getReleaseSpinnerInfoByGroup(self._releaseInfo.spinner_group)
	self._previewList = {}

	for iter_3_0, iter_3_1 in pairs(self._previewData) do
		table.insert(self._previewList, iter_3_1)
	end
end

function ReleaseActivityPreviewPop:_onPreviewItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._previewList[arg_4_1 + 1])
end

function ReleaseActivityPreviewPop:onLoad()
	if not self._knightSpine then
		local var_5_0 = var_0_0:getActivityReleaseDisplayCfg()

		self._knightSpine = DrawKnight.new({
			isAlphaNode = true,
			scale = 1,
			resId = var_5_0.role,
			isShowBg = checkbool(var_5_0.is_show_bg == 1)
		})

		self.m_knightComp:addChild(self._knightSpine)

		local var_5_1 = self.m_knightComp:getPosition()

		self.m_knightComp:setPosition(var_5_1.x + var_5_0.pos_x, var_5_1.y + var_5_0.pos_y)
		self._knightSpine:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	end

	self.m_previewList:setNumItems(#self._previewList)
	self.m_previewList:scrollToView(self:getScorllIdx())
	self.m_previewList:transitionShowCells("enter_left", 0.03, 1)
end

function ReleaseActivityPreviewPop:getScorllIdx()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(self._previewList) do
		if iter_6_1.id == self._spinnerId then
			var_6_0 = iter_6_0

			break
		end
	end

	return math.max(var_6_0 - 1, 0)
end

return ReleaseActivityPreviewPop
