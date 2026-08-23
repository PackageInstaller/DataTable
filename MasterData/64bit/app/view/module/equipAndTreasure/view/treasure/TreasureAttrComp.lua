local var_0_0 = require("app.view.module.equipAndTreasure.const.ETConst").POSITION_TYPE
local var_0_1 = g.core.model.User.treasureData
local var_0_2 = g.core.config.treasure_info
local TreasureAttrComp = class("TreasureAttrComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureAttrComp"), function()
	return fgui.GComponent:create({
		resName = "TreasureAttrComp",
		pkgPath = "ui/equipAndTreasure/equipAndTreasure",
		pkgName = "equipAndTreasure"
	})
end)

function TreasureAttrComp:ctor()
	self.selectPositionData = nil

	self:_initView()
end

function TreasureAttrComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_LUCK, handler(self, self._onRcvTreasureLock), self)
end

function TreasureAttrComp:updateView(arg_4_1)
	local var_4_0 = arg_4_1.selectPositionData or {}
	local var_4_1 = var_4_0.pos

	self._selectPositionData = var_4_0

	if not arg_4_1.isOther then
		self.m_isOtherController:setSelectedIndex(0)

		self._treaData = var_0_1:getTreasureDataByPos(var_4_1)

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, true, {
			redPointComp = self.m_changeBtn,
			customData = {
				type = var_4_0.positionType,
				index = var_4_0.knightPos
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, true, {
			redPointComp = self.m_devRedPointComp,
			customData = {
				index = var_4_0.knightPos
			}
		})
	else
		self.m_isOtherController:setSelectedIndex(1)

		self._treaData = g.core.model.User.playerInfoData:getTreasureByPos(var_4_1)
	end

	local var_4_2 = var_0_2.get(self._treaData.base_id)

	self.m_nameText:setText(var_4_2.name or "")
	self.m_attrComp:updateView(self._treaData, arg_4_1.isOther)
	self.m_isLockController:setSelectedIndex(0)

	local var_4_4 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_TREASURE,
		value = var_4_2.id
	})

	if var_4_4 then
		self.m_qualityLoader:setURL("ui://text_new/" .. "pic_pinzhi_" .. (var_4_4.quality or 1) + 1)

		if var_4_4.quality >= 3 then
			self.m_isLockController:setSelectedIndex(self._treaData.lock and 2 or 1)
			self:_setLockBtnBg(self._treaData.lock)
		end
	end
end

function TreasureAttrComp:_initView()
	self.m_masterBtn:addClickListener(handler(self, self._onClickMaster))
	self.m_changeBtn:addClickListener(handler(self, self._onClickChange))
	self.m_unloadBtn:addClickListener(handler(self, self._onClickUnload))
	self.m_devBtn:addClickListener(handler(self, self._onClickDevelop))
	self.m_lockBtn:addClickListener(handler(self, self._onClickTreasureLock))
end

function TreasureAttrComp:_onClickMaster()
	self:dispatchCompEvent("on_click_master")
end

function TreasureAttrComp:_onClickChange()
	self:dispatchCompEvent("on_open_treasure_dialog")
end

function TreasureAttrComp:_onClickUnload()
	if self._selectPositionData.sid then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			pos = 0,
			tp = 4,
			id = self._selectPositionData.sid
		})
	end
end

function TreasureAttrComp:_onClickDevelop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TREASURE_DEVELOP, self._selectPositionData)
end

function TreasureAttrComp:_onClickTreasureLock()
	g.core.network.GameNetProxy:send_C2S_Treasure_Luck({
		ids = {
			self._treaData.id
		}
	})
end

function TreasureAttrComp:_onRcvTreasureLock()
	local var_11_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._treaData.id)

	self.m_isLockController:setSelectedIndex(var_11_0.lock and 2 or 1)
	self:_setLockBtnBg(var_11_0.lock)
	g.core.module.ModuleManager:tip(g.core.lang:get(var_11_0.lock and 202056 or 202055))
end

function TreasureAttrComp:_setLockBtnBg(arg_12_1)
	local var_12_0 = self.m_lockBtn:getChild("bgLoader")

	if var_12_0 then
		var_12_0:setAlpha(arg_12_1 and 1 or 0.5)
	end
end

return TreasureAttrComp
