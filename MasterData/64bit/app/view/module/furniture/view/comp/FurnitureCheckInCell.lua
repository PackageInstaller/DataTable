local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local FurnitureStayInfoPop = require("app.view.module.furniture.view.pop.FurnitureStayInfoPop")
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_3 = g.core.model.User.furnitureData
local FurnitureCheckInCell = class("FurnitureCheckInCell", require("app.fairyGUI.furniture.UI_FurnitureCheckInCell"))

function FurnitureCheckInCell:ctor()
	self._dormId = 0
	self._dormKnightList = {}

	self.m_cdBar:setMax(100)
	self.m_allDischargeBtn:addClickListener(handler(self, self._onClickAllDisChargeBtn))
	self.m_bathCrockStateBtn:addClickListener(handler(self, self._onClickBathCrockStateBtn))
	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onCheckInItemRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickKnightListItem))
end

function FurnitureCheckInCell:updateCell(arg_2_1)
	self._dormId = arg_2_1
	self._dormKnightList = var_0_3:getCheckInKnightIdsWithDormId(arg_2_1)

	self.m_floorTxt:setText(g.core.lang:get(112509, {
		floor = g.core.lang:get(100 + tonumber(arg_2_1))
	}))
	self.m_stayCountTxt:setText(#self._dormKnightList)
	self.m_maxNumTxt:setText(g.core.lang:get(112532, {
		num = var_0_3:getCheckInCountLimit(arg_2_1)
	}))
	self.m_knightList:setNumItems(var_0_0.FURNITURE_KNIGHT_MAX)

	if var_0_3:isDormUnlocked(arg_2_1) then
		local var_2_0 = var_0_3:getFurnitureInfo(arg_2_1, var_0_0.FURNITURE_TYPE.BATH_CROCK)
		local var_2_1 = var_0_3:getBathCrockState(var_2_0)

		self.m_bathCrockStateController:setSelectedIndex(var_2_1)

		if var_2_1 == var_0_0.BATH_CROCK_STATE.CD then
			self.m_cdBar:setValue((var_2_0:getCDProgress()))
		end

		self.m_unlockedController:setSelectedIndex(1)
	else
		self.m_lockTipTxt:setText((var_0_3:getDormUnlockConditionDesc(arg_2_1)))
		self.m_unlockedController:setSelectedIndex(0)
	end
end

function FurnitureCheckInCell:_onCheckInItemRenderer(arg_3_1, arg_3_2)
	arg_3_1 = arg_3_1 + 1

	arg_3_2:updateCell(arg_3_1, self._dormId, self._dormKnightList[arg_3_1])
end

function FurnitureCheckInCell:_onClickKnightListItem(arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1:getDataValue() + 1

	if var_4_0 > var_0_3:getCheckInCountLimit(self._dormId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(112511, {
			level = var_0_3:getUnlockLevelByCount(self._dormId, var_4_0)
		}))
	else
		self:addPopup(FurnitureStayInfoPop.new(self._dormId))
	end
end

function FurnitureCheckInCell:_onClickAllDisChargeBtn()
	if #var_0_3:getCheckInKnightIdsWithDormId(self._dormId) > 0 then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(112507),
			desc = g.core.lang:get(112508),
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_FurnitureRoom_PlaceKnight({
					knight_id = {
						{
							room_id = self._dormId,
							knight_id = {
								0,
								0,
								0,
								0,
								0
							}
						}
					}
				})
			end)
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(112522))
	end
end

function FurnitureCheckInCell:_onClickBathCrockStateBtn()
	local var_7_0 = var_0_3:getBathCrockState((var_0_3:getFurnitureInfo(self._dormId, var_0_0.FURNITURE_TYPE.BATH_CROCK)))

	if var_7_0 == var_0_0.BATH_CROCK_STATE.CAN_USE then
		self:dispatchCompEvent("EVENT_GOTO_DRESS_MODE", {
			openDress = false,
			dormId = self._dormId
		})
		g.core.module.ModuleManager:popModule()
	elseif var_7_0 == var_0_0.BATH_CROCK_STATE.NOT_PLACED then
		if var_0_3:getCanPlaceFurnitureCount(var_0_0.FURNITURE_TYPE.BATH_CROCK) > 0 then
			self:dispatchCompEvent("EVENT_GOTO_DRESS_MODE", {
				openDress = true,
				dormId = self._dormId
			})
			g.core.module.ModuleManager:popModule()
		else
			g.core.module.ModuleManager:popModule()
			g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
				tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.FLUSH_TAB_TYPE,
				shopType = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.FURNITURE
			})
		end
	elseif var_7_0 == var_0_0.BATH_CROCK_STATE.CD then
		-- block empty
	end
end

return FurnitureCheckInCell
