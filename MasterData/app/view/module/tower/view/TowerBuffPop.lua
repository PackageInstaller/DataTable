local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerData
local var_0_2 = 80
local TowerBuffPop = class("TowerBuffPop", require("app.fairyGUI.tower.UI_TowerBuffPop"), function()
	return fgui.GComponent:create({
		resName = "TowerBuffPop",
		pkgPath = "ui/tower/tower",
		isFullScreen = false,
		pkgName = "tower"
	}, ...)
end)

function TowerBuffPop:ctor(arg_2_1)
	self._stageType = arg_2_1
	self._buffList = {}
	self._curInfo = {}
	self.m_buffListComp = self.m_showComp:getChild("buffList")

	local var_2_0, var_2_1 = var_0_1:getCurTowerIdByType(self._stageType)

	self._stageInfo = var_0_0.get(var_2_1)

	self:showAtCenter()
	self:initView()
end

function TowerBuffPop:initView()
	self.m_showComp:getChild("groupBuffDesc"):setText(self._stageInfo.details)
	self.m_buffListComp:setIniter(self)
	self.m_buffListComp:setItemRenderer(handler(self, self._onRendererBuffList))
end

function TowerBuffPop:_onRendererBuffList(arg_4_1, arg_4_2)
	arg_4_2:getChild("passCount"):setText(self._buffList[arg_4_1 + 1].clear_num)
	arg_4_2:getChild("buffDesc"):setText(self._buffList[arg_4_1 + 1].description)

	if self._curInfo.id == self._buffList[arg_4_1 + 1].id then
		arg_4_2:getController("isLight"):setSelectedIndex(0)
	else
		arg_4_2:getController("isLight"):setSelectedIndex(1)
	end
end

function TowerBuffPop:onLoad()
	self:updateView()
end

function TowerBuffPop:updateView()
	local var_6_0, var_6_1 = var_0_1:getTowerBuffInfo(self._stageType)

	self._buffList = var_6_1
	self._curInfo = var_6_0 or {}

	self.m_buffListComp:setNumItems(#var_6_1)
	self.m_buffListComp:setSize(self.m_buffListComp:getSize().width, var_0_2 * #var_6_1)
end

return TowerBuffPop
