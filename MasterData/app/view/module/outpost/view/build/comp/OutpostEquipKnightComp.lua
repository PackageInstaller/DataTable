local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEquipKnightComp = class("OutpostEquipKnightComp", require("app.fairyGUI.outpost.UI_OutpostEquipKnightComp"))

function OutpostEquipKnightComp:ctor()
	self._buildType = var_0_0.BuildType.None
	self._pos = -1
	self._knight = nil
	self._equipList = nil

	self:_initComp()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function OutpostEquipKnightComp:_initComp()
	self.m_equipList:setVirtual(self)
	self.m_equipList:doFairyBatching(false)
	self.m_equipList:setItemRenderer(handler(self, self._onEquipItemRender))
	self.m_callBtn1:addClickListener(handler(self, self._onCallBtn1Clicked))
	self.m_callBtn2:addClickListener(handler(self, self._onCallBtn2Clicked))
end

function OutpostEquipKnightComp:setBuildType(arg_3_1)
	self._buildType = arg_3_1
end

function OutpostEquipKnightComp:updateKnightComp(arg_4_1, arg_4_2)
	self._knight = arg_4_1
	self._pos = arg_4_2

	self.m_knightComp:updateKnightWithStruct(arg_4_1)
	self:_getEquipList()

	if self._buildType == var_0_0.BuildType.WeaponShop then
		self.m_equipList:setNumItems(1)
		self.m_isArmorController:setSelectedIndex(0)
		self.m_callBtn1:setTitle(g.core.lang:get(432652))
	else
		self.m_equipList:setNumItems(2)
		self.m_isArmorController:setSelectedIndex(0)
		self.m_callBtn1:setTitle(g.core.lang:get(432679))
	end
end

function OutpostEquipKnightComp:_getEquipList()
	self._equipList = {}

	local var_5_0 = {
		[var_0_0.EquipType.ARMS] = 1
	}

	if self._buildType == var_0_0.BuildType.ArmorShop then
		var_5_0 = {
			[var_0_0.EquipType.UPPER_BODY_ARMOR] = 1,
			[var_0_0.EquipType.LOWER_BODY_ARMOR] = 2
		}
	end

	for iter_5_0, iter_5_1 in ipairs((self._knight:getEquipList())) do
		local var_5_1 = iter_5_1:getEquipType()

		if var_5_0[var_5_1] then
			self._equipList[var_5_0[var_5_1]] = iter_5_1
			var_5_0[var_5_1] = nil

			if not next(var_5_0) then
				break
			end
		end
	end
end

function OutpostEquipKnightComp:_onEquipItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateItemIcon(self._equipList[arg_6_1 + 1], (self._buildType ~= var_0_0.BuildType.WeaponShop or nil) and (arg_6_1 == 0 and var_0_0.EquipType.UPPER_BODY_ARMOR or var_0_0.EquipType.LOWER_BODY_ARMOR), self._knight:getCfg().profession)
end

function OutpostEquipKnightComp:_onCallBtn1Clicked()
	local var_7_0 = self._buildType == var_0_0.BuildType.WeaponShop and var_0_0.EquipType.ARMS or var_0_0.EquipType.UPPER_BODY_ARMOR

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_CALL_KNIGHT_TO_BUILD, false, 0, {
		knightId = self._knight:getServerId(),
		buildType = self._buildType,
		equipPos = var_7_0
	})

	local var_7_1, var_7_2 = g.core.model.User.outpostData:getBuildData():isInConsumptionBuilding(self._knight:getServerId())

	if var_7_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432646, {
			kName = self._knight:getCfg().name,
			bName = var_7_2:getBuildCfg().name
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432647))
	end

	self:dispatchCompEvent("callKnight", {
		sid = self._knight:getServerId(),
		pos = self._pos
	})
end

function OutpostEquipKnightComp:_onCallBtn2Clicked()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_CALL_KNIGHT_TO_BUILD, false, 0, {
		knightId = self._knight:getServerId(),
		buildType = self._buildType,
		equipPos = var_0_0.EquipType.LOWER_BODY_ARMOR
	})

	local var_8_0, var_8_1 = g.core.model.User.outpostData:getBuildData():isInConsumptionBuilding(self._knight:getServerId())

	if var_8_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432646, {
			kName = self._knight:getCfg().name,
			bName = var_8_1:getBuildCfg().name
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432647))
	end

	self:dispatchCompEvent("callKnight", {
		sid = self._knight:getServerId(),
		pos = self._pos
	})
end

function OutpostEquipKnightComp:playUpEffect()
	self.m_upTransition:play()
end

return OutpostEquipKnightComp
