local UserConst = require("app.view.module.user.const.UserConst")
local UserTabBattleCfgData = require("app.view.module.user.model.UserTabBattleCfgData")
local UserTabCfgData = require("app.view.module.user.model.UserTabCfgData")
local UserMainLayer = class("UserMainLayer", require("app.fairyGUI.user.UI_UserMainLayer"), function()
	return fgui.GComponent:create({
		resName = "UserMainLayer",
		pkgPath = "ui/user/user",
		isFullScreen = true,
		pkgName = "user"
	}, ...)
end)

function UserMainLayer:ctor(arg_2_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._inBattle = arg_2_1 and arg_2_1.inBattle

	if self._inBattle then
		self._selectedIndex = UserConst.TAB_INDEX_BATTLE.QUALITY or UserConst.TAB_INDEX.ACCOUNT_INFO
	end

	if arg_2_1 and arg_2_1.route and arg_2_1.route1 then
		self._selectedIndex = arg_2_1.route1
	end

	if self._inBattle then
		self._UserTabCfgData = UserTabBattleCfgData or UserTabCfgData
	end

	self._subComps = {}
	self._curComp = nil

	if self._inBattle then
		self._usedTabList = self.m_tabBattleList or self.m_tabList
	end

	self.m_tabList:setVisible(not self._inBattle)

	if self._inBattle then
		self.m_topBar:setTitle(g.core.lang:get(105533))
	end

	self.m_tabBattleList:setVisible(self._inBattle)
	self._usedTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))

	if self._inBattle then
		self.m_topBar:setReturnCallBack(handler(self, self._battleRemoveSelf))
		self.m_topBar.m_homeBtn:setVisible(false)
	end

	if g.core.platform.PlatformProxy:isChannelOfChina() and g.core.platform.PlatformProxy:getCurChannel().name == require("app.core.platform.const.ChannelConst").ChannelNames.HUAWEI and g.core.platform.ServerListProxy:isTesting() then
		self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemClick))
		self.m_tabList:setNumItems(3)
	end
end

function UserMainLayer:onLoad()
	g.core.common.GlobalFunc.checkAvatarId()
	g.core.common.GlobalFunc.checkFrameId()
	g.core.common.GlobalFunc.checkUserLimitTitle()
	g.core.model.User.accountAutheData:getPhoneState()
	self._usedTabList:setSelectedIndex(self._selectedIndex)
	self:_updateSubComp()
	self:_updateAllTabRed()
end

function UserMainLayer:_battleRemoveSelf()
	self:removeSelf()
end

function UserMainLayer:_onTabItemClick()
	local var_5_0 = self._usedTabList:getSelectedIndex()

	if self._UserTabCfgData[var_5_0].isUnLock() then
		if var_5_0 == self._selectedIndex then
			return
		end

		self._selectedIndex = var_5_0

		self:_updateSubComp()
	else
		self._usedTabList:setSelectedIndex(self._selectedIndex)
	end

	self:_updateAllTabRed()
end

function UserMainLayer:_updateAllTabRed()
	for iter_6_0, iter_6_1 in ipairs((self._usedTabList:getChildren())) do
		iter_6_1:updateRedPoint()
	end
end

function UserMainLayer:_updateSubComp()
	if self._curComp then
		self._curComp:setVisible(false)

		if self._curComp.playHide then
			self._curComp:playHide()
		end
	end

	if not self._subComps[self._selectedIndex] then
		self:_createComp()
	end

	self._curComp = self._subComps[self._selectedIndex]

	self._curComp:setVisible(true)
	self._curComp.m_enterTransition:play()

	if self._curComp.updateComp then
		self._curComp:updateComp()
	end
end

function UserMainLayer:_createComp()
	local var_8_0 = fgui.UIPackage:createObject(self._UserTabCfgData[self._selectedIndex].packageName, self._UserTabCfgData[self._selectedIndex].resName, self)

	self._subComps[self._selectedIndex] = var_8_0

	var_8_0:setPivot(0.5, 0.5, true)
	var_8_0:setPosition(display.width / 2, display.height / 2)
	var_8_0:setSize(display.size)

	for iter_8_0, iter_8_1 in ipairs(self._UserTabCfgData[self._selectedIndex].adaptiveStyle) do
		var_8_0:addRelation(self, iter_8_1, true)
	end

	self:getView():addChildAt(var_8_0, 0)
end

return UserMainLayer
