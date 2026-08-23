local PrimaryShowPop = class("PrimaryShowPop", require("app.fairyGUI.recruitKnight.UI_PrimaryShowPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgName = "recruitKnight",
		pkgPath = "ui/recruitKnight/recruitKnight",
		resName = "PrimaryShowPop"
	})
end)

function PrimaryShowPop:ctor(arg_2_1)
	self.rewardInfos = arg_2_1

	self:_init()
end

function PrimaryShowPop:_init()
	self.m_topBarComp:updateTopRes({})
	self.m_topBarComp:setTitle(g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY).name)
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemProvider(handler(self, self._setListItemProvider))
	self.m_rewardList:setItemRenderer(handler(self, self._onListItemRender))
	self.m_rewardList:doFairyBatching(false)

	self._playAnim = true
end

function PrimaryShowPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_RECRUIT_NOVICETENAWARD, handler(self, self._closeSelf), self)
	self.m_rewardList:setNumItems(#self.rewardInfos)

	self._playAnim = false
end

function PrimaryShowPop:_setListItemProvider(arg_5_1)
	return (arg_5_1 + 1) % 2 == 0 and "ui://recruitKnight/PrimaryShowPopBigCell" or arg_5_1 + 1 ~= #self.rewardInfos - 1 and "ui://recruitKnight/PrimaryShowPopCell" or "ui://recruitKnight/PrimaryShowPopRightCell"
end

function PrimaryShowPop:_onListItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self.rewardInfos[arg_6_1 + 1].awards, arg_6_1 + 1, self._playAnim)
end

function PrimaryShowPop:_closeSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PrimaryShowPop
