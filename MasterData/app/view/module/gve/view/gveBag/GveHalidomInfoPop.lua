local var_0_0 = g.core.model.User.gveDataMgr:getGveBagData()
local GveHalidomComposePop = require("app.view.module.gve.view.gveBag.GveHalidomComposePop")
local GveHalidomInfoPop = class("GveHalidomInfoPop", require("app.fairyGUI.gve.UI_GveHalidomInfoPop"), function()
	return fgui.GComponent:create({
		resName = "GveHalidomInfoPop",
		pkgPath = "ui/gve/gve",
		pkgName = "gve"
	}, ...)
end)

function GveHalidomInfoPop:ctor(arg_2_1)
	var_0_0 = g.core.model.User.gveDataMgr:getGveBagData()
	self._halidom = arg_2_1
	self._attrList = {}

	self:showAtCenter()
	self:_initView()
	self:updateView()
end

function GveHalidomInfoPop:_initView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_decomposeBtn:addClickListener(handler(self, self._onClickDecomposeBtn))
	self.m_composeBtn:addClickListener(handler(self, self._onClickComposeBtn))
	self.m_equipBtn:addClickListener(handler(self, self._onClickEquipBtn))
end

function GveHalidomInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP, self._onRecHalidomEquip, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_FASTDECOMPOSITION, self._onRevDecomposeUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_DECOMPOSITION, self._onRevDecomposeUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_MERGE, self._onRecHalidomCompose, self)
end

function GveHalidomInfoPop:updateView()
	local var_5_0 = self._halidom:getNum()
	local var_5_1 = self._halidom:getLevel()
	local var_5_2 = self._halidom:getBranch()

	if self._halidom:getIsEquip() then
		self.m_viewStatusController:setSelectedIndex(0)
	elseif var_5_0 > 0 then
		if var_5_1 == var_0_0:getCoreHalidomLevel() and not next((var_0_0:getEquipHalidomByPosition((self._halidom:getPosition())))) and var_5_2 == var_0_0:getCoreHalidomBranch() then
			self.m_viewStatusController:setSelectedIndex(2)
		else
			self.m_viewStatusController:setSelectedIndex(1)
		end
	else
		self.m_viewStatusController:setSelectedIndex(3)
	end

	self._attrList = var_0_0:getAttrList(self._halidom)

	self.m_attrList:setNumItems(#self._attrList)
	self.m_nameText:setText((self._halidom:getName()))
	self.m_numText:setText(var_5_0)
	self.m_levelText:setText(g.core.lang:get(100535, {
		lv = var_5_1
	}))
	self.m_icon:setURL((g.core.common.Path:getHalidomById((self._halidom:getIcon()))))
	self.m_bgIcon:setURL((g.core.common.Path:getHalidomResourceById(var_0_0:getBranchCfgByBranchId(var_5_2).big_grey_icon)))
end

function GveHalidomInfoPop:_onListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateAttr(self._attrList[arg_6_1 + 1])
end

function GveHalidomInfoPop:_onListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateAttr(self._attrList[arg_7_1 + 1])
end

function GveHalidomInfoPop:_onClickDecomposeBtn()
	local var_8_0 = {
		title = g.core.lang:get(309148)
	}
	local var_8_1 = {
		num = self._halidom:getRecyclePrice()
	}

	var_8_1.resIcon = "ui://gve/icon_pshc_shengwucailiao"
	var_8_0.desc = g.core.lang:get(309147, var_8_1)
	var_8_0.onConfirm = handler(self, function()
		g.core.network.GameNetProxy:send_C2S_GVE_Halidom_Decomposition({
			decomposition_config_id = self._halidom:getId()
		})
	end)
	var_8_0.confirmText = g.core.lang:get(1160)
	var_8_0.cancelText = g.core.lang:get(1037)

	self:addPopup(require("app.view.base.pop.BaseConfirmPop").new(var_8_0), {
		ignoreTouch = true
	})
end

function GveHalidomInfoPop:_onClickComposeBtn()
	self:addPopup(GveHalidomComposePop.new(self._halidom))
end

function GveHalidomInfoPop:_onClickEquipBtn()
	g.core.network.GameNetProxy:send_C2S_GVE_Halidom_Equip({
		config_id = self._halidom:getId()
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveHalidomInfoPop:_onRecHalidomEquip()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveHalidomInfoPop:_onRevDecomposeUp()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.module.ModuleManager:tip(g.core.lang:get(309157))
end

function GveHalidomInfoPop:_onRecHalidomCompose()
	self:updateView()
end

return GveHalidomInfoPop
