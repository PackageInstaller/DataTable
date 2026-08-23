local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local PreciousMainLayer = class("PreciousMainLayer", require("app.fairyGUI.precious.UI_PreciousMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/precious/precious",
		resName = "PreciousMainLayer",
		pkgName = "precious"
	}, ...)
end)

function PreciousMainLayer:ctor()
	self:addBg("bg/precious/bg_gzp_guizhongpinbg.jpg", nil, nil, 1)

	self._group = 0
	self._suitListData = {}
	self._tabData = {}

	self:_initRegisterUI()
end

function PreciousMainLayer:_initRegisterUI()
	self.m_topBar:setResInfoById(var_0_1.PRECIOUS_HELP_ID)
	self.m_recruitBtn:addClickListener(handler(self, self._onClickRecruitBtn))
	self.m_recycleBtn:addClickListener(handler(self, self._onClickRecycleBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
	self.m_siftBtn:setSelected(false)
	self.m_siftBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onBtnSiftChanged))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabListChanged))
	self.m_suitList:setVirtual()
	self.m_suitList:setItemRenderer(handler(self, self._onSuitListItemRender))
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.PRECIOUS)
end

function PreciousMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onS2CPreciousFragmentCompose), self)
	self:_updateMainView()
end

function PreciousMainLayer:_updateMainView()
	self.m_curNumTxt:setText(#var_0_0:getOwnPreciousList())
	self.m_maxNumTxt:setText("/" .. #var_0_0:getPreciousList())

	self._tabData = var_0_0:getGroupNameList()

	self.m_tabList:setNumItems(#self._tabData)
	self.m_tabList:resizeToFit(#self._tabData)
	self.m_tabList:setSelectedIndex(self._group)

	local var_5_0, var_5_1 = var_0_0:getSiftMarkIdx()

	self._suitListData = var_0_0:getPreciousSuitListByFilter({
		group = self._group,
		quality = var_5_0,
		activate = var_5_1
	})

	self.m_suitList:setNumItems(#self._suitListData)
	self.m_isEmptyController:setSelectedIndex(next(self._suitListData) and 0 or 1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_recruitBtn:getChild("redPointComp"),
		customData = {}
	})
end

function PreciousMainLayer:_onTabListItemRender(arg_6_1, arg_6_2)
	arg_6_2:setTitle(self._tabData[arg_6_1 + 1].name)
end

function PreciousMainLayer:_onSuitListItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateMainCell(self._suitListData[arg_7_1 + 1])
end

function PreciousMainLayer:_onTouchBegin(arg_8_1)
	local var_8_0 = arg_8_1:getInput():getTouch():getLocation()

	if not self.m_siftComp:containPoint(var_8_0) and not self.m_siftBtn:containPoint(var_8_0) then
		self:_hideSiftComp()
	end
end

function PreciousMainLayer:_hideSiftComp()
	self.m_siftComp:setVisible(false)
	self.m_siftBtn:setSelected(false)
end

function PreciousMainLayer:receiveCompEvent(arg_10_1)
	if arg_10_1 == "SAVE_QUALITY_ACTIVATE_IDX" then
		local var_10_0, var_10_1 = var_0_0:getSiftMarkIdx()

		self:_hideSiftComp()
		self:_updateMainView()
	end
end

function PreciousMainLayer:_onTabListChanged()
	local var_11_0 = self.m_tabList:getSelectedIndex()

	if self._group == var_11_0 then
		return
	end

	self._group = var_11_0

	self:_updateMainView()
end

function PreciousMainLayer:_onBtnSiftChanged()
	self.m_siftComp:setVisible((self.m_siftBtn:isSelected()))
end

function PreciousMainLayer:_onClickRecruitBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, {
		route1 = g.core.const.ConstMgr.RecruitConst.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE,
		route2 = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.PRECIOUS
	})
end

function PreciousMainLayer:_onClickRecycleBtn()
	local var_14_0 = require("app.view.base.infoPop.FragSellPop").new(g.core.model.User.preciousData:getCanSellPreciousFragDataList(), {
		fragNameId = 421228,
		qualityArr = g.core.const.ConstMgr.QUALITY_TYPE.SELL_POP_QUALITY_ARRAY[g.core.const.ConstMgr.QUALITY_TYPE.NEW_QUALITY_CTRL.PRECIOUS],
		title = g.core.lang:get(421230)
	})

	self:addListen(var_14_0)
	g.core.module.ModuleManager:pushPopup(var_14_0)
end

function PreciousMainLayer:_onS2CPreciousFragmentCompose(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = g.core.config.fragment_info.get(arg_15_4.id)

	if var_15_0 then
		local var_15_1 = {
			callBack = handler(self, self._updateMainView),
			awards = {
				{
					type = var_15_0.fragment_type,
					value = var_15_0.fragment_value,
					size = arg_15_4.num
				}
			}
		}

		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.PreciousShowPop").new(var_15_1), var_15_1)
	end
end

function PreciousMainLayer:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

return PreciousMainLayer
