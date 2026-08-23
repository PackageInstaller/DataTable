local BaseCommonInfoPop = class("BaseCommonInfoPop", require("app.fairyGUI.base_new.UI_BaseCommonInfoPop"))

function BaseCommonInfoPop:ctor()
	self._childParams = {}
	self._childComp = {}
	self._curSelectedIndex = 1

	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClicked))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRenderer))
	self.m_lightLoader:setURL("pic/base_new/bg_xx_guang.png")
	self.m_closeBtn:setClickFunc(handler(self, self.playExitAnim))
end

function BaseCommonInfoPop:onLoad()
	self:newScheduleOnce(handler(self, self._onPlayOpenAnim), 0)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_HUD_OPEN)
end

function BaseCommonInfoPop:_onPlayOpenAnim()
	self.m_openTransition:play()
end

function BaseCommonInfoPop:_onTabItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._childParams[arg_4_1 + 1].title)
end

function BaseCommonInfoPop:setPopView(arg_5_1)
	self.m_qualityLoader:setURL(g.core.common.Path:getInfoPopQualityLine(arg_5_1.quality or 1))

	self._childParams = arg_5_1.tabParam or {}
	self._commonParam = arg_5_1.commonParam

	self.m_tabList:setNumItems(#self._childParams)
	self.m_tabList:setSelectedIndex(0)
	self:_updateChildPanel()

	if arg_5_1.icon then
		self.m_iconLoader:setURL(arg_5_1.icon.res)
		self.m_iconLoader:setAlpha(arg_5_1.icon.alpha or 1)
		self.m_iconLoader:setScale(arg_5_1.icon.scale or 1)
	end

	if arg_5_1.iconComp then
		self.m_iconComp = arg_5_1.iconComp

		self.m_placeHolderIconComp:addChild(arg_5_1.iconComp)
	end

	if arg_5_1.nameComp then
		self._nameComp = arg_5_1.nameComp

		self.m_placeHolderNameComp:addChild(arg_5_1.nameComp)
	end

	if arg_5_1.itemComp then
		self._itemComp = arg_5_1.itemComp

		self.m_placeHolderItemComp:addChild(arg_5_1.itemComp)

		if arg_5_1.itemCompPos then
			self._itemComp:setPosition(arg_5_1.itemCompPos)
		end
	end

	if arg_5_1.leftComp then
		self._leftNode = arg_5_1.leftComp

		self.m_leftComp:addChild(self._leftNode)
	end
end

function BaseCommonInfoPop:setIconData(arg_6_1)
	self.m_iconLoader:setURL(arg_6_1.res)
	self.m_iconLoader:setAlpha(arg_6_1.alpha or 1)
	self.m_iconLoader:setScale(arg_6_1.scale or 1)
end

function BaseCommonInfoPop:getNameComp()
	return self._nameComp
end

function BaseCommonInfoPop:getItemComp()
	return self._itemComp
end

function BaseCommonInfoPop:updateCompCustomComp(arg_9_1, arg_9_2)
	if self._childComp[arg_9_1] and self._childComp[arg_9_1].customUpdate then
		self._childComp[arg_9_1]:customUpdate(arg_9_2)
	end
end

function BaseCommonInfoPop:_updateChildPanel()
	for iter_10_0, iter_10_1 in pairs(self._childComp) do
		iter_10_1:setVisible(false)
	end

	if self._childComp[self._curSelectedIndex] then
		self._childComp[self._curSelectedIndex]:setVisible(true)
	else
		self._childComp[self._curSelectedIndex] = fgui.UIPackage:createObject(self._childParams[self._curSelectedIndex].package, self._childParams[self._curSelectedIndex].compName)

		if self._childComp[self._curSelectedIndex].updateShow then
			self._childComp[self._curSelectedIndex]:updateShow(self._commonParam, self._childParams[self._curSelectedIndex].selfParam)
		end

		self.m_placeHolderComp:addChild(self._childComp[self._curSelectedIndex])
	end
end

function BaseCommonInfoPop:_onTabClicked()
	local var_11_0 = self.m_tabList:getSelectedIndex() + 1

	if self._curSelectedIndex ~= var_11_0 then
		self._curSelectedIndex = var_11_0

		self:_updateChildPanel()
	end
end

function BaseCommonInfoPop:onCloseAnimEnd()
	g.core.module.ModuleManager:popComponent()
end

function BaseCommonInfoPop:playExitAnim()
	self.m_closeTransition:play(handler(self, self.onCloseAnimEnd))
end

return BaseCommonInfoPop
