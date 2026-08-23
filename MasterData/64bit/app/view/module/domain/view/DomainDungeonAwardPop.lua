local var_0_0 = g.core.model.User.domainData
local DomainDungeonAwardPop = class("DomainDungeonAwardPop", require("app.fairyGUI.domainDungeon.UI_DomainDungeonAwardPop"), function()
	return fgui.GComponent:create({
		resName = "DomainDungeonAwardPop",
		pkgName = "domainDungeon",
		pkgPath = "ui/domainDungeon/domainDungeon"
	}, ...)
end)

function DomainDungeonAwardPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self.m_clickBg:setSize(display.width, display.height)
	self:showAtCenter()

	self._items = {}
	self._closeCallBack = arg_2_1.callBack
	self._awards = arg_2_1.award or {}
	self._dungeonId = arg_2_1.dungeonId

	if arg_2_1.autoDisappear then
		self:_autoDisappearPop()
	else
		self.m_clickBg:addClickListener(handler(self, self._onCloseClick))
	end

	self.m_awardList:setIniter(self)
	self.m_awardList:setItemRenderer(handler(self, self._onItemRender))
	self.m_awardList:setNumItems(#self._awards)
	self.m_titleBg:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_gxhdbtdi.png"))
	self.m_tipsBgImg:setURL(var_0_0:getDungeonResource(self._dungeonId, "pic_mnly_gxhdjldi.png"))
	self.m_bgEff:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_domainDungeon_panel_" .. self._dungeonId
	})
	self.m_enterTransition:setHook("showTitleEff", handler(self, self._onTitleStart))
	self.m_enterTransition:play(handler(self, self._onPlayAnimEnd))
end

function DomainDungeonAwardPop:_onPlayAnimEnd()
	for iter_3_0 = 1, #self._awards do
		self:_showItem(self._items[iter_3_0], iter_3_0 - 1)
	end
end

function DomainDungeonAwardPop:_onTitleStart()
	self.m_titleEff:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_domainDungeon_title_" .. self._dungeonId
	})
end

function DomainDungeonAwardPop:_showItem(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1

	self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(arg_5_2 * 0.05), (fgui.FCallFunc:create(function()
		var_5_0:playIconEffect({
			isLoop = false,
			name = "eff_ui_domainDungeon_icon_" .. self._dungeonId
		}, 0.08)
		var_5_0:setVisible(true)
	end)))))
end

function DomainDungeonAwardPop:_onItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._awards[arg_7_1 + 1])
	arg_7_2:setVisible(false)
	table.insert(self._items, arg_7_2)
end

function DomainDungeonAwardPop:_onCloseClick()
	self:stopAllFGActions()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

function DomainDungeonAwardPop:_autoDisappearPop()
	self:runFGAction((fgui.FSequence:create(fgui.FDelayTime:create(1.5 + math.min(1, 10) * 0.05), fgui.FSpawn:create({
		fgui.FFadeOut:create(0.3),
		fgui.FMoveBy:create(0.5, cc.p(0, -80))
	}), fgui.FCallFunc:create(function()
		self:_onCloseClick()
	end))))
end

return DomainDungeonAwardPop
