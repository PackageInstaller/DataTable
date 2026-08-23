local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.model.User
local FurnitureChooseBathPersonnelPop = class("FurnitureChooseBathPersonnelPop", require("app.fairyGUI.furniture.UI_FurnitureChooseBathPersonnelPop"), function()
	return fgui.GComponent:create({
		resName = "FurnitureChooseBathPersonnelPop",
		pkgPath = "ui/furniture/furniture",
		isFullScreen = true,
		pkgName = "furniture"
	}, ...)
end)

function FurnitureChooseBathPersonnelPop:ctor(arg_2_1)
	self._dormId = arg_2_1
	self._choseKnightId = 0
	self._checkInList = var_0_1.furnitureData:getCheckInKnightIdsWithDormId(arg_2_1)

	self.m_touchComp:addClickListener(handler(self, self._onClose))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_listView:setIniter()
	self.m_listView:setItemRenderer(handler(self, self._onListItemRenderer))
	self.m_listView:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickListItem))
end

function FurnitureChooseBathPersonnelPop:onLoad()
	self.m_listView:setNumItems(var_0_0.FURNITURE_KNIGHT_MAX)
end

function FurnitureChooseBathPersonnelPop:_onClose()
	g.core.module.ModuleManager:popModule()
end

function FurnitureChooseBathPersonnelPop:_onClickConfirmBtn()
	if not self._dormId then
		-- block empty
	elseif not self._choseKnightId or self._choseKnightId == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(112545))
	else
		local var_5_0 = var_0_1.knightsData:getKnightById(self._choseKnightId)
		local var_5_1 = var_5_0:getMaxMobility()

		if var_5_1 <= 0 then
			return
		elseif var_5_1 <= var_5_0:getMobilityVal() then
			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(112543),
				desc = g.core.lang:get(112544),
				onConfirm = handler(self, self._sendRoleToBathReq)
			})))
		else
			self:_sendRoleToBathReq()
		end
	end
end

function FurnitureChooseBathPersonnelPop:_sendRoleToBathReq()
	local var_6_0 = var_0_1.furnitureData:getFurnitureInfo(self._dormId, var_0_0.FURNITURE_TYPE.BATH_CROCK)

	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Bath({
		room_id = self._dormId,
		knight_id = self._choseKnightId,
		bathtbu_id = var_6_0.furniture_id,
		x = var_6_0.x,
		y = var_6_0.y,
		level = var_0_0.SVR_DEFINITION_LEVEL.FLOOR_FURNITURE
	})
	self:_onClose()
end

function FurnitureChooseBathPersonnelPop:_onClickListItem(arg_7_1)
	self._choseKnightId = self._checkInList[arg_7_1:getDataValue() + 1]
end

function FurnitureChooseBathPersonnelPop:_onListItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._checkInList[arg_8_1 + 1])
end

return FurnitureChooseBathPersonnelPop
