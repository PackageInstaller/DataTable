local SettingConst = require("app.view.module.setting.const.SettingConst")
local SettingMainLayer = class("SettingMainLayer", require("app.fairyGUI.setting.UI_SettingMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/setting/setting",
		resName = "SettingMainLayer",
		pkgName = "setting"
	}, ...)
end)

function SettingMainLayer:ctor(arg_2_1)
	self._tabIdx = arg_2_1 or 0
	self._enterTrans = self:getView():getTransition("enter")
	self._backTrans = self:getView():getTransition("back")

	self._backTrans:setHook("start", handler(self, self._playBackAction))
	self:_init()
	self:_addListeners()
end

function SettingMainLayer:_init()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._tabInfo = SettingConst.TAB_INFO
	self._subComps = {}
	self._curComp = nil

	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_tabList:setNumItems(#self._tabInfo)
end

function SettingMainLayer:_onTabItemRender(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._tabInfo[arg_4_1 + 1].name)
end

function SettingMainLayer:_addListeners()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))
end

function SettingMainLayer:onLoad()
	self.m_tabList:setSelectedIndex(self._tabIdx)
	self:_onTabItemClick()
	self._enterTrans:play()
end

function SettingMainLayer:_playBackAction()
	self._curComp:playBackAction()
end

function SettingMainLayer:onUnload()
	return
end

function SettingMainLayer:_onTabItemClick(arg_9_1)
	local var_9_0 = self.m_tabList:getSelectedIndex()

	if var_9_0 == self._selectedIndex then
		return
	end

	self._selectedIndex = var_9_0

	self:_updateSubComp(true)
end

function SettingMainLayer:_updateSubComp(arg_10_1)
	if arg_10_1 and self._curComp then
		self._curComp:onHide()
	end

	local var_10_0 = self._tabInfo[self._selectedIndex + 1]
	local var_10_1 = self._subComps[self._tabInfo[self._selectedIndex + 1].compName]

	if not self._subComps[self._tabInfo[self._selectedIndex + 1].compName] then
		var_10_1 = require("app.view.module.setting.view." .. var_10_0.compName).new()

		self:getView():addChildAt(var_10_1, 0)

		self._subComps[var_10_0.compName] = var_10_1
	end

	var_10_1:onShow()

	self._curComp = var_10_1
end

return SettingMainLayer
