local var_0_1 = g.core.model.User.equipmentData
local InfoEquipDetailPop = class("InfoEquipDetailPop", require("app.fairyGUI.infoPop.UI_InfoEquipDetailPop"), function()
	return fgui.GComponent:create({
		resName = "InfoEquipDetailPop",
		isFullScreen = true,
		pkgName = "infoPop"
	})
end)

function InfoEquipDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	self._data = arg_2_1
	self._equipPos = arg_2_1.pos
	self._state = arg_2_1.state
	self._sid = arg_2_1.id
	self._knightPos = arg_2_1.knightPos
	self._baseId = arg_2_1.baseId
end

function InfoEquipDetailPop:onLoad()
	if self._data then
		self:_updateView()
	end
end

function InfoEquipDetailPop:_updateView()
	local var_4_0
	local var_4_2
	local var_4_3 = "InfoEquipAttrComp"

	if self._data.isEquipFrag then
		var_4_3 = "InfoEquipFragAttrComp"
		var_4_2 = fgui.UIPackage:createObject("infoPop", "InfoProgressComp")

		var_4_2:updateShow(self._data)
		var_4_2:setPivot(0, 1, true)
		var_4_2:setVisible(true)
	else
		var_4_0 = var_0_1:getEquipBySid(self._sid)
		self._equipData = var_4_0
	end

	local var_4_4 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = self._baseId
	})
	local var_4_5 = self._data.isEquipFrag and var_4_4.info or var_4_0:getCfg()
	local var_4_6 = fgui.UIPackage:createObject("base_new", "BaseEquipBigIconComp")

	var_4_6:setPivot(0.5, 0.5, true)
	var_4_6:updateIcon({
		id = var_4_5.id,
		icon = var_4_4.pic,
		equip = var_4_0
	})
	self.m_infoPopBase:setPopView({
		quality = var_4_4.quality,
		tabParam = {
			{
				package = "infoPop",
				title = g.core.lang:get(201557),
				compName = var_4_3
			},
			{
				package = "infoPop",
				compName = "InfoEquipSuitComp",
				title = g.core.lang:get(201558)
			}
		},
		commonParam = {
			equipData = var_4_0,
			baseId = self._baseId,
			pos = self._knightPos
		},
		itemComp = var_4_6,
		nameComp = var_4_2
	})
end

return InfoEquipDetailPop
