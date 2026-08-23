local DebugConst = require("app.view.module.debug.const.DebugConst")
local DebugMainLayer = class("DebugMainLayer", require("app.fairyGUI.debug.UI_DebugMainLayer"), function()
	return fgui.GComponent:create({
		resName = "DebugMainLayer",
		pkgPath = "ui/debug/debug",
		isFullScreen = true,
		pkgName = "debug"
	}, ...)
end)

function DebugMainLayer:ctor(arg_2_1)
	self._tabList = DebugConst.TAB_CONFIG
	self._curSelIndex = 0
	self._holderList = {}
	self._lastShowComp = nil

	self:_initListView()
	self:_initView()
end

function DebugMainLayer:_initView()
	self:addBg("bg/warriors/bg_lzzm_weidayiwusuipian.jpg")
	self.m_topBarComp:setDefaultResNum(0)
	self.m_tabList:setNumItems(#self._tabList)
	self.m_tabList:setSelectedIndex(0)
	self:_onTabListClickItem()
	self.m_switchBtn:addClickListener(handler(self, self._onSwitchBtnClicked))
end

function DebugMainLayer:_initListView()
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onRenderTabList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
end

function DebugMainLayer:_onRenderTabList(arg_5_1, arg_5_2)
	arg_5_2:setTitle(self._tabList[arg_5_1 + 1].title)
end

function DebugMainLayer:_onTabListClickItem()
	local var_6_0 = self.m_tabList:getSelectedIndex() + 1

	if self._curSelIndex ~= var_6_0 then
		self._curSelIndex = var_6_0

		self:_updateCompHolder()
	end
end

function DebugMainLayer:_updateCompHolder()
	if self._lastShowComp then
		self._lastShowComp:setVisible(false)
	end

	if not self._holderList[self._curSelIndex] then
		local var_7_0 = fgui.UIPackage:createObject("debug", self._tabList[self._curSelIndex].comp, self)

		var_7_0:setSize(display.width, display.height)
		self.m_holderComp:addChild(var_7_0)

		self._holderList[self._curSelIndex] = var_7_0
	else
		self._holderList[self._curSelIndex]:setVisible(true)
		self._holderList[self._curSelIndex]:onLoad()
	end

	self._lastShowComp = self._holderList[self._curSelIndex]
end

function DebugMainLayer:_onSwitchBtnClicked()
	local var_8_0 = self.m_isHideTabController:getSelectedIndex() == 1 and 0 or 1

	self.m_isHideTabController:setSelectedIndex(var_8_0)

	if self._holderList[self._curSelIndex] and self._holderList[self._curSelIndex].onChangeSize then
		self._holderList[self._curSelIndex]:onChangeSize(var_8_0)
	end
end

function DebugMainLayer:onUnload()
	if self._holderList[self._curSelIndex] then
		self._holderList[self._curSelIndex]:onUnload()
	end

	g.core.layer.LayerManager:getRoot():hidePopup()
end

return DebugMainLayer
