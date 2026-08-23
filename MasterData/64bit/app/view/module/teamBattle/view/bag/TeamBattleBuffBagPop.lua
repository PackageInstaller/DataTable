local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleBuffBagPop = class("TeamBattleBuffBagPop", require("app.fairyGUI.teamBattle.UI_TeamBattleBuffBagPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleBuffBagPop",
		pkgName = "teamBattle"
	})
end)

function TeamBattleBuffBagPop:ctor()
	self:showAtCenter()

	self._curSel = 0
	self._buffList = nil

	self:_initRegisterUI()
end

function TeamBattleBuffBagPop:_initRegisterUI()
	self.m_attrBtn:addClickListener(handler(self, self._onBuffAttrClick))
	self.m_buffList:setVirtual()
	self.m_buffList:setItemRenderer(handler(self, self._onBuffItemList))
	self.m_buffList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeSelect))
end

function TeamBattleBuffBagPop:onLoad()
	self:updateView()
end

function TeamBattleBuffBagPop:_onBuffItemList(arg_5_1, arg_5_2)
	arg_5_2:updateBuffIcon(self._buffList[arg_5_1 + 1])
end

function TeamBattleBuffBagPop:updateView()
	self._buffList = var_0_0:getMapData():getBuffIdList()

	if #self._buffList == 0 then
		self.m_isBuffEmptyController:setSelectedIndex(1)
	else
		self.m_isBuffEmptyController:setSelectedIndex(0)
		self.m_buffList:setNumItems(#self._buffList)
		self.m_buffList:setSelectedIndex(0)
		self:_onChangeSelect(true)
	end
end

function TeamBattleBuffBagPop:_onChangeSelect(arg_7_1)
	local var_7_0 = self.m_buffList:getSelectedIndex()

	if not arg_7_1 and self._curSel == var_7_0 then
		return
	end

	self._curSel = var_7_0

	self:updateBuffDetail()
end

function TeamBattleBuffBagPop:updateBuffDetail()
	local var_8_0 = var_0_0:getMapData():getBuffInfo(self._buffList[self._curSel + 1])

	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_8_0.image))
	self.m_nameBgLoader:setURL(g.core.common.Path:getBuffNameQuality(var_8_0.quality))
	self.m_nameTxt:setText(var_8_0.name)
	self.m_descComp:setTitle(var_8_0.des)
end

function TeamBattleBuffBagPop:_onBuffAttrClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.teamBattle.view.bag.TeamBattleBuffAttrPop").new()))
end

return TeamBattleBuffBagPop
