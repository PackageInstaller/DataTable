local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local EquipDevelopLayer = require("app.view.module.equipAndTreasure.view.equip.EquipDevelopLayer")
local EquipDetailComp = class("EquipDetailComp", require("app.fairyGUI.equipAndTreasure.UI_EquipDetailComp"), function()
	return fgui.GComponent:create({
		resName = "EquipDetailComp",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	})
end)
local ETData = require("app.view.module.equipAndTreasure.model.ETData")

function EquipDetailComp:ctor()
	self._selectPositionData = nil
	self._equipPos = nil
	self._id = nil
	self._knightPos = nil
	self._isCheckNotify = true

	self:_initView()
end

function EquipDetailComp:_initView()
	self.m_masterBtn:addClickListener(handler(self, self._onClickMaster))
	self.m_oneKeyEquipStrengthenBtn:addClickListener(handler(self, self._onClickOneKeyEquipStrengthen))
	self.m_changeBtn:addClickListener(handler(self, self._onClickChange))
	self.m_unloadBtn:addClickListener(handler(self, self._onClickUnload))
	self.m_devBtn:addClickListener(handler(self, self._onClickDevelop))
	self:onPlayEnterTransition()
end

function EquipDetailComp:updateView(arg_4_1)
	self._selectPositionData = ETData.selectPositionData

	if not self._selectPositionData then
		return
	end

	self._equipPos = self._selectPositionData.pos
	self._knightPos = self._selectPositionData.knightPos

	if not arg_4_1 then
		self.m_isOtherController:setSelectedIndex(0)

		self._id = g.core.model.User.equipmentData:getEquipIdByPos(self._equipPos)
		self._equipData = g.core.model.User.equipmentData:getEquipBySid(self._id)

		if self._equipPos ~= 0 then
			self._equipSuits = g.core.model.User.equipmentData:getEquipSuitByEquipPos(self._equipPos)
		else
			self._equipSuits[1] = self._equipData
		end

		self.m_oneKeyEquipStrengthenBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.EQUIP_STRENGTHEN_QUICK))

		self._equipType = self._equipData:getCfg().type or 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_devRedPointComp,
			customData = {
				id = self._id
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_oneKeyEquipStrengthenBtn,
			customData = {
				id = self._id
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_changeBtn,
			customData = {
				index = self._knightPos,
				type = self._equipType
			}
		})
	else
		self.m_isOtherController:setSelectedIndex(1)

		self._equipData = g.core.model.User.playerInfoData:getEquipmentByPos(self._equipPos)
	end

	self.m_attrComp:updateView(self._equipData, self._knightPos, arg_4_1)

	local var_4_0 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = self._equipData:getCfg().id
	})

	self.m_nameText:setText(var_4_0.name or "")
	self.m_qualityImg:setURL("ui://text_new/" .. "pic_pinzhi_" .. math.clamp(var_4_0.quality or 0, g.core.const.ConstMgr.QUALITY_TYPE.NONE, g.core.const.ConstMgr.QUALITY_TYPE.MR) + 1)
end

function EquipDetailComp:_onClickMaster()
	self:dispatchCompEvent("on_click_master")
end

function EquipDetailComp:_onClickOneKeyEquipStrengthen()
	self._isCheckNotify = true

	if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_EQUIP_ONE_KEY_STRENGTHEN, false) then
		self:onOneKeyStrengthen()
	else
		local var_6_0 = require("app.view.base.pop.BaseConfirmPop").new

		g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(201590),
			onConfirm = handler(self, self.onOneKeyStrengthen),
			onCancel = function()
				return
			end,
			tip = {
				isChecked = true,
				txt = g.core.lang:get(201591)
			},
			onCheck = handler(self, self._onCheckClickNotify)
		})))
	end
end

function EquipDetailComp:onOneKeyStrengthen()
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_EQUIP_ONE_KEY_STRENGTHEN, self._isCheckNotify, false)

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		return
	end

	local var_8_0 = g.core.model.User:getLevel() * 2
	local var_8_1 = {
		id = {},
		times = {}
	}
	local var_8_2 = 0
	local var_8_3 = {}
	local var_8_4 = g.core.model.User.resourceData:getCoin()
	local var_8_5 = false

	for iter_8_0 = 1, 10 do
		local var_8_6 = 0
		local var_8_7 = 0

		for iter_8_1, iter_8_2 in ipairs(self._equipSuits) do
			local var_8_8 = var_8_3[iter_8_1] or iter_8_2:getServerData().level

			if var_8_0 > var_8_8 then
				local var_8_9 = math.ceil(iter_8_2:getOnceStrengthCost(var_8_8))

				if var_8_4 >= var_8_2 + var_8_9 then
					var_8_3[iter_8_1] = var_8_8 + 1
					var_8_2 = var_8_2 + var_8_9
				else
					var_8_6 = var_8_6 + 1
					var_8_7 = var_8_7 + 1
				end
			else
				var_8_6 = var_8_6 + 1
			end
		end

		if var_8_7 > 0 then
			var_8_5 = true
		end

		if var_8_6 >= #self._equipSuits then
			break
		end
	end

	for iter_8_3, iter_8_4 in ipairs(self._equipSuits) do
		if var_8_3[iter_8_3] then
			table.insert(var_8_1.id, iter_8_4:getServerData().id)
			table.insert(var_8_1.times, var_8_3[iter_8_3] - iter_8_4:getServerData().level)
		end
	end

	if next(var_8_1.id) then
		g.core.network.GameNetProxy:send_C2S_Equipment_Upgrade(var_8_1)
	elseif var_8_5 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 3,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = g.core.model.User.resourceData:getCoin()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201514))
	end
end

function EquipDetailComp:_onCheckClickNotify(arg_9_1)
	self._isCheckNotify = arg_9_1
end

function EquipDetailComp:_onClickChange()
	self:dispatchCompEvent("on_open_equip_dialog")
end

function EquipDetailComp:_onClickUnload()
	g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
		tp = 3,
		pos = 0,
		id = self._equipData:getServerData().id
	})
end

function EquipDetailComp:_onClickDevelop()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 1, self._id)
	end
end

function EquipDetailComp:onPlayEnterTransition()
	self.m_attrComp:getChild("glyphComp"):getTransition("enter"):play()
	self.m_attrComp:getChild("refineComp"):getTransition("enter"):play()
	self.m_attrComp:getChild("strengthComp"):getTransition("enter"):play()
	self.m_attrComp:getChild("suitTitleComp"):getTransition("enter"):play()
	self.m_attrComp:getChild("resonanceComp"):getTransition("enter"):play()
end

function EquipDetailComp:onPlayBackTransition()
	self.m_backTransition:play()
end

return EquipDetailComp
