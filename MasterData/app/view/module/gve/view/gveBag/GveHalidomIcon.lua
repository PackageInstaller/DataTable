local var_0_0 = g.core.model.User.gveDataMgr:getGveBagData()
local var_0_1 = g.core.model.User.gveDataMgr:getGveTaskData()
local GveHalidomStruct = require("app.view.module.gve.model.struct.GveHalidomStruct")
local GveHalidomInfoPop = require("app.view.module.gve.view.gveBag.GveHalidomInfoPop")
local GveHalidomComposePop = require("app.view.module.gve.view.gveBag.GveHalidomComposePop")
local var_0_5 = g.core.const.ConstMgr.GveConst
local var_0_6 = g.core.const.ConstMgr.GveConst.HALIDOM_STATUS
local GveHalidomIcon = class("GveHalidomIcon", require("app.fairyGUI.gve.UI_GveHalidomIcon"))

function GveHalidomIcon:ctor(arg_1_1)
	var_0_0 = g.core.model.User.gveDataMgr:getGveBagData()
	var_0_1 = g.core.model.User.gveDataMgr:getGveTaskData()
	self._position = nil
	self._status = var_0_6.CAN_NOT_EUIP
	self._isFromDevLayer = false
	self._effectNode = nil

	self:_initView()
end

function GveHalidomIcon:_initView()
	self:addClickListener(handler(self, self._onTouchHalidom))
end

function GveHalidomIcon:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_EQUIP, handler(self, self._onRecEquip), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_HALIDOM_LEVELUP, handler(self, self._onRecLevelUp), self)
end

function GveHalidomIcon:updateView(arg_4_1, arg_4_2)
	self._position = arg_4_1
	self._isFromDevLayer = arg_4_2

	local var_4_0 = var_0_0:getEquipHalidomByPosition(self._position)

	if var_4_0 and next(var_4_0) then
		self._halidom = var_4_0
	else
		local var_4_1 = var_0_0:getCoreHalidomBranch()
		local var_4_2 = var_0_0:getCoreHalidomLevel()
		local var_4_3 = var_0_0:getCommonHalidomByPBL(self._position, var_4_1, var_4_2)

		if var_4_3 and next(var_4_3) then
			self._halidom = var_4_3
		else
			local var_4_4 = {
				num = 0
			}

			var_4_4.id = var_0_0:getHalidomIdByPBL(self._position, var_4_1, var_4_2)
			self._halidom = GveHalidomStruct.new(var_4_4, false)
		end
	end

	self.m_icon:setURL(self._position == 0 and g.core.common.Path:getHalidomById((self._halidom:getIcon())) or g.core.common.Path:getHalidomById((self._halidom:getIcon())))
	self.m_maskIcon:setURL((g.core.common.Path:getHalidomById((self._halidom:getBackIcon()))))

	self._status = var_0_0:getPositionStatus(self._position)

	self:removeEffect()

	if self._position == 0 then
		if not var_0_0:isFullLevel() and var_0_0:canCoreHalidomLevelUp() and self._halidom:getNeedTaskLevel() <= var_0_1:getPrivilegeLevel() then
			self.m_statusController:setSelectedIndex(4)

			local var_4_7 = var_0_0:getCoreHalidomBranch()

			if var_4_7 == 0 then
				self._effectNode = self.m_effAdvance:addEffectSpine({
					remove = false,
					name = "eff_ui_gveBag_yueliangAdvance",
					anim = "play",
					isLoop = true
				})
			elseif var_4_7 == 1 then
				self._effectNode = self.m_effAdvance:addEffectSpine({
					remove = false,
					name = "eff_ui_gveBag_taiyangAdvance",
					anim = "play",
					isLoop = true
				})
			elseif var_4_7 == 2 then
				self._effectNode = self.m_effAdvance:addEffectSpine({
					remove = false,
					name = "eff_ui_gveBag_xingzuoAdvance",
					anim = "play",
					isLoop = true
				})
			elseif var_4_7 == 3 then
				self._effectNode = self.m_effAdvance:addEffectSpine({
					remove = false,
					name = "eff_ui_gveBag_xingxingAdvance",
					anim = "play",
					isLoop = true
				})
			end
		else
			self.m_statusController:setSelectedIndex(3)
		end
	elseif self._status == var_0_6.CAN_NOT_EUIP then
		self.m_statusController:setSelectedIndex(0)
	elseif self._status == var_0_6.CAN_EUIP then
		self.m_statusController:setSelectedIndex(1)
	elseif self._status == var_0_6.CAN_COMPOSE then
		self.m_statusController:setSelectedIndex(2)
	elseif self._status == var_0_6.HAVE_EQUIP then
		self.m_statusController:setSelectedIndex(3)
	end

	self._attrList = var_0_0:getAttrList(self._halidom)

	if self._position == 0 or not next(self._attrList) then
		self:setAttrGroupState(false)
	else
		self.m_attrNumController:setSelectedIndex(#self._attrList == 2 and 1 or 0)
		self:setAttrGroupState(true)
		self.m_lvTxt:setText("Lv." .. self._halidom:getLevel())

		for iter_4_0 = 1, 2 do
			self["m_attrIcon" .. iter_4_0]:setVisible(false)
		end

		self.m_attrBg:setURL(var_0_5.GVE_HALIDOM_ATTR_BG[var_0_0:getCoreHalidomBranch()])

		for iter_4_1, iter_4_2 in ipairs(self._attrList) do
			self["m_attrIcon" .. iter_4_1]:setURL((g.core.common.Path:getAttrIcon(iter_4_2.type, false)))
			self["m_attrIcon" .. iter_4_1]:setVisible(true)
		end
	end
end

function GveHalidomIcon:setAttrGroupState(arg_5_1)
	self.m_attrGroup:setVisible(arg_5_1)
end

function GveHalidomIcon:removeEffect()
	if self._effectNode then
		self._effectNode:removeFromParent()

		self._effectNode = nil
	end
end

function GveHalidomIcon:_onTouchHalidom()
	if self._position == 0 then
		if var_0_1:getPrivilegeLevel() < self._halidom:getNeedTaskLevel() then
			return
		end

		if not var_0_0:canCoreHalidomLevelUp() then
			return
		end

		local var_7_0 = var_0_0:isFullLevel()
		local var_7_1 = var_0_0:getCoreHalidomLevel()
		local var_7_2 = var_0_0:getCoreHalidomBranch()

		if var_7_1 == var_0_0:getSelectBranchLimitLevel() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_BRANCH, {
				levelUp = true
			})
		elseif var_7_0 then
			-- block empty
		else
			local var_7_3 = var_0_0:getHalidomIdByPBL(0, var_7_2, var_7_1 + 1)

			if var_7_3 ~= 0 and var_0_0:canCoreHalidomLevelUp() then
				g.core.network.GameNetProxy:send_C2S_GVE_Halidom_LevelUp({
					merge_config_id = var_7_3
				})
			end
		end
	elseif self._status == var_0_6.CAN_NOT_EUIP then
		g.core.module.ModuleManager:pushPopup(GveHalidomComposePop.new(self._halidom))
	elseif self._status == var_0_6.CAN_EUIP then
		g.core.module.ModuleManager:pushPopup(GveHalidomInfoPop.new(self._halidom))
	elseif self._status == var_0_6.CAN_COMPOSE then
		g.core.module.ModuleManager:pushPopup(GveHalidomComposePop.new(self._halidom, self._isFromDevLayer))
	elseif self._status == var_0_6.HAVE_EQUIP then
		g.core.module.ModuleManager:pushPopup(GveHalidomInfoPop.new(self._halidom))
	end
end

function GveHalidomIcon:receiveCompEvent(arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}
end

function GveHalidomIcon:_onRecEquip(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if tolua.isnull(self) then
		return
	end

	if arg_9_4.config_id == self._halidom:getId() then
		local var_9_0 = var_0_0:getCoreHalidomBranch()

		if var_9_0 == 0 then
			self.m_effEquip:addEffectSpine({
				remove = true,
				name = "eff_ui_gveBag_equip",
				isLoop = false,
				anim = "play4",
				eventHandler = handler(self, self.onAnimationEnd)
			})
		elseif var_9_0 == 1 then
			self.m_effEquip:addEffectSpine({
				remove = true,
				name = "eff_ui_gveBag_equip",
				isLoop = false,
				anim = "play",
				eventHandler = handler(self, self.onAnimationEnd)
			})
		elseif var_9_0 == 2 then
			self.m_effEquip:addEffectSpine({
				remove = true,
				name = "eff_ui_gveBag_equip",
				isLoop = false,
				anim = "play3",
				eventHandler = handler(self, self.onAnimationEnd)
			})
		elseif var_9_0 == 3 then
			self.m_effEquip:addEffectSpine({
				remove = true,
				name = "eff_ui_gveBag_equip",
				isLoop = false,
				anim = "play2",
				eventHandler = handler(self, self.onAnimationEnd)
			})
		end
	end
end

function GveHalidomIcon:onAnimationEnd()
	g.core.module.ModuleManager:showFeedBackTipsPop({
		title = g.core.lang:get(300021),
		showComp = fgui.UIPackage:createObject("gve", "GveHalidomUpLevelTip")
	})
end

function GveHalidomIcon:_onRecLevelUp(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self.m_effAdvance:removeChildren()
end

function GveHalidomIcon:addCoreHalidomEffect()
	return
end

return GveHalidomIcon
