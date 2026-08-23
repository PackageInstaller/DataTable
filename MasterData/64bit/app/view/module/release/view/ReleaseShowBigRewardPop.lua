local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseShowBigRewardPop = class("ReleaseShowBigRewardPop", require("app.fairyGUI.release.UI_ReleaseShowBigRewardPop"), function()
	return fgui.GComponent:create({
		resName = "ReleaseShowBigRewardPop",
		pkgName = "release",
		pkgPath = "ui/release/release"
	}, ...)
end)

function ReleaseShowBigRewardPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_touchArea:setSize(display.width, display.height)
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))

	self._extraAwards = arg_2_1

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRendererAsync1(handler(self, self._onAwardItemRender), 0.1, false)
	self:_updateMainView()
end

function ReleaseShowBigRewardPop:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateShowItem(self._extraAwards[arg_3_1 + 1])
end

function ReleaseShowBigRewardPop:_updateMainView()
	self.m_descTxt:setText(g.core.lang:get(433002, {
		drawTime = var_0_0:getBigAwardsUseTime()
	}))
	self.m_awardList:setNumItems(#self._extraAwards)
end

function ReleaseShowBigRewardPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ReleaseShowBigRewardPop
