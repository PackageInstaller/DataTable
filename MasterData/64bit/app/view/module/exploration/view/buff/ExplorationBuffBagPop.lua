local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationBuffBagPop = class("ExplorationBuffBagPop", require("app.fairyGUI.exploration.UI_ExplorationBuffBagPop"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		resName = "ExplorationBuffBagPop"
	})
end)

function ExplorationBuffBagPop:ctor(arg_2_1)
	self:showAtCenter()

	self._curSel = 0
	self._buffList = {}

	self:_initBtn()
	self:_initListView()
end

function ExplorationBuffBagPop:onLoad()
	self:updateView()
end

function ExplorationBuffBagPop:_initBtn()
	self.m_attrBtn:addClickListener(handler(self, self._onBuffAttrClick))
end

function ExplorationBuffBagPop:_initListView()
	self.m_buffList:setVirtual()
	self.m_buffList:setItemRenderer(handler(self, self._onBuffItemList))
	self.m_buffList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeSelect))
end

function ExplorationBuffBagPop:_onBuffItemList(arg_6_1, arg_6_2)
	arg_6_2:updateBuffIcon(self._buffList[arg_6_1 + 1], var_0_0.BUFF.SELECT_TYPE)
end

function ExplorationBuffBagPop:updateView()
	self._buffList = g.core.model.User.explorationData:getEventBuffList()

	if #self._buffList == 0 then
		self.m_isBuffEmptyController:setSelectedIndex(1)
	else
		self.m_isBuffEmptyController:setSelectedIndex(0)
		self.m_buffList:setNumItems(#self._buffList)
		self.m_buffList:setSelectedIndex(0)
		self:_onChangeSelect(true)
	end
end

function ExplorationBuffBagPop:_onChangeSelect(arg_8_1)
	local var_8_0 = self.m_buffList:getSelectedIndex()

	if not arg_8_1 and self._curSel == var_8_0 then
		return
	end

	self._curSel = var_8_0

	self:updateBuffDetail()
end

function ExplorationBuffBagPop:updateBuffDetail()
	local var_9_0 = g.core.config.exploration_buff_info.get(self._buffList[self._curSel + 1])

	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_9_0.image))
	self.m_nameBgLoader:setURL(g.core.common.Path:getBuffNameQuality(var_9_0.quality))
	self.m_nameTxt:setText(var_9_0.name)
	self.m_descComp:setTitle(var_9_0.des)
end

function ExplorationBuffBagPop:_onBuffAttrClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.buff.ExplorationBuffAttrPop").new({})))
end

return ExplorationBuffBagPop
