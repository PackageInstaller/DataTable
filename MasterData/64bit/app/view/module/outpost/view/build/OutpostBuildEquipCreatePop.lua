local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local OutpostBuildEquipCreatePop = class("OutpostBuildEquipCreatePop", require("app.fairyGUI.outpost.UI_OutpostBuildEquipCreatePop"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostBuildEquipCreatePop"
	}, ...)
end)

function OutpostBuildEquipCreatePop:ctor(arg_2_1)
	self._struct = arg_2_1.struct
	self._confirmCb = arg_2_1.onConfirm
	self._maxNum = arg_2_1.maxNum or 9999
	self._ownNum = arg_2_1.ownNum or 0
	self._curNumber = 1

	self:showAtCenter()
	self.m_buildCreateBtn:addClickListener(handler(self, self._onConfirmClick))
	self.m_subAddNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = self._maxNum,
		callback = handler(self, self._onNumberChange)
	})

	self._cfg = self._struct:getCfg()

	if self._cfg.equip_type ~= var_0_0.EquipType.ARMS then
		self.m_equip:setVisible(false)
	else
		self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. self._cfg.profession)
		self.m_equip:setVisible(true)
	end

	self.m_equipIcon:updateEquip(self._struct)
	self.m_createNameTxt:setText(self._cfg.name)
	self.m_iconBefore:setURL(g.core.common.Path:getOutpostEquipBookIcon(self._cfg.drawing_res))
	self.m_equipIcon:addClickListener(handler(self, self._onEquipBtnClicked))
	self.m_qualityLoader:setURL(g.core.common.Path:getQualityLineByQuality(self._struct:getQuality() + 1))
end

function OutpostBuildEquipCreatePop:_onNumberChange(arg_3_1)
	self._curNumber = arg_3_1

	self:reCalcCostNum()
end

function OutpostBuildEquipCreatePop:reCalcCostNum()
	for iter_4_0, iter_4_1 in ipairs((self._struct:getProductGoods())) do
		local var_4_0 = {
			type = iter_4_1.type,
			size = iter_4_1.size * self._curNumber,
			info = g.core.config.outpost_item_info.get(iter_4_1.value)
		}

		var_4_0.ownNum = var_0_1:getBagData():getOwnNum(iter_4_1.value)

		self["m_costItem" .. iter_4_0]:updateIconShow(var_4_0)
	end
end

function OutpostBuildEquipCreatePop:_checkCost()
	local var_5_0 = true

	for iter_5_0, iter_5_1 in ipairs((self._struct:getProductGoods())) do
		if iter_5_1.size * self._curNumber > var_0_1:getBagData():getOwnNum(iter_5_1.value) then
			var_5_0 = false

			break
		end
	end

	return var_5_0
end

function OutpostBuildEquipCreatePop:_onConfirmClick()
	if not self:_checkCost() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432650))

		return
	end

	if self._confirmCb then
		self._confirmCb({
			num = self._curNumber
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Weapon)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function OutpostBuildEquipCreatePop:_onEquipBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightSuitDetailPop").new({
		struct = self._struct
	})))
end

return OutpostBuildEquipCreatePop
