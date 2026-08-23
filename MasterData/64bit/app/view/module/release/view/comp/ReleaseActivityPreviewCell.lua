local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityPreviewCell = class("ReleaseActivityPreviewCell", require("app.fairyGUI.release.UI_ReleaseActivityPreviewCell"))

function ReleaseActivityPreviewCell:ctor()
	self._noramlAwards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function ReleaseActivityPreviewCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon({
		type = self._noramlAwards[arg_2_1 + 1].type,
		value = self._noramlAwards[arg_2_1 + 1].value,
		size = self._noramlAwards[arg_2_1 + 1].size
	})
end

function ReleaseActivityPreviewCell:updateCell(arg_3_1)
	self._spinnerId = var_0_0:getSpinnerId()

	self.m_bgLoader:setURL(g.core.common.Path:getReleaseActivityPreviewBg(arg_3_1.quality))
	self.m_titleLoader:setURL(g.core.common.Path:getReleaseActivityTitle(arg_3_1.quality))
	self.m_isCurSpinnerController:setSelectedIndex(arg_3_1.id == self._spinnerId and 1 or 0)

	local var_3_0 = var_0_0:getSpinnerBigAwardInfo(arg_3_1.spinner_prize_group)

	self._goods = g.core.common.Goods:convert({
		type = var_3_0.type,
		value = var_3_0.value
	})

	self.m_bigAwardIcon:updateIcon(self._goods)
	self.m_nameTxt:setText(self._goods.name)

	self._noramlAwards = var_0_0:getSpinnerNormalAwardInfo(arg_3_1.spinner_prize_group)

	self.m_awardList:setNumItems(#self._noramlAwards)
end

return ReleaseActivityPreviewCell
