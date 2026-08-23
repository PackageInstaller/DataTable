local GameEntertainDevConfig = require("app.view.module.gameEntertainment.model.GameEntertainDevConfig")
local GameEntertainmentLayer = class("GameEntertainmentLayer", require("app.fairyGUI.gameEntertainment.UI_GameEntertainmentLayer"), function()
	return fgui.GComponent:create({
		resName = "GameEntertainmentLayer",
		pkgPath = "ui/gameEntertainment/gameEntertainment",
		isFullScreen = true,
		pkgName = "gameEntertainment"
	})
end)

function GameEntertainmentLayer:ctor(arg_2_1)
	self._tabListData = {}
	self._gameListData = {}
	self._childComps = {}
	self._curSelectedTabIndex = 1

	if arg_2_1 and arg_2_1.route then
		self._curSelectedTabIndex = arg_2_1.route2 or 1
	end

	self:_init()
end

function GameEntertainmentLayer:_init()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(88)
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
end

function GameEntertainmentLayer:onLoad()
	self:_updateContent()
end

function GameEntertainmentLayer:_updateContent()
	self:_updateTabList()
	self:_updateGameContent()
end

function GameEntertainmentLayer:_updateTabList()
	self._tabListData = GameEntertainDevConfig:getTabList()

	self.m_tabList:setNumItems(#self._tabListData)
	self.m_tabList:setSelectedIndex(self._curSelectedTabIndex - 1)
end

function GameEntertainmentLayer:_updateGameContent(arg_7_1)
	if self._curComp then
		self._curComp:setVisible(false)

		self._curComp = nil
	end

	if not self._childComps[self._tabListData[self._curSelectedTabIndex].type] then
		local var_7_0 = fgui.UIPackage:createObject(self._tabListData[self._curSelectedTabIndex].packageName, self._tabListData[self._curSelectedTabIndex].resName, self)

		var_7_0:setSize(display.size)

		self._childComps[self._tabListData[self._curSelectedTabIndex].type] = var_7_0

		self.m_contentNode:addChild(var_7_0)
	end

	self._curComp = self._childComps[self._tabListData[self._curSelectedTabIndex].type]

	self._curComp:setVisible(true)
	self._curComp:updateContent({
		tabType = self._tabListData[self._curSelectedTabIndex].type,
		isSwitchTab = arg_7_1
	})
end

function GameEntertainmentLayer:_onTabListItemRenderer(arg_8_1, arg_8_2)
	if self._tabListData[arg_8_1 + 1] then
		arg_8_2:setTitle(self._tabListData[arg_8_1 + 1].title)
		arg_8_2:setShowData(self._tabListData[arg_8_1 + 1].iconRes)
	end
end

function GameEntertainmentLayer:_onTabListClickItem(arg_9_1, arg_9_2)
	local var_9_0 = self.m_tabList:getSelectedIndex()

	if self._curSelectedTabIndex ~= var_9_0 + 1 then
		self._curSelectedTabIndex = var_9_0 + 1

		self:_updateGameContent(true)
	end
end

return GameEntertainmentLayer
