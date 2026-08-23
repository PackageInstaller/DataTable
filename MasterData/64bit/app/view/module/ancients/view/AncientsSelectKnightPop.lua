local AncientsSelectKnightPop = class("AncientsSelectKnightPop", require("app.fairyGUI.ancients.UI_AncientsSelectKnightPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsSelectKnightPop",
		pkgName = "ancients",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)

function AncientsSelectKnightPop:ctor(arg_2_1)
	self._knightPos = 0
	arg_2_1 = arg_2_1 or {}

	self:getView():center(true)

	self._pos = arg_2_1.pos or 1
	self._selectKnightPos = arg_2_1.knightPos or 0
	self._units = arg_2_1.units or {}

	self.m_List_knight:setVirtual(self)
	self.m_List_knight:setItemRenderer(handler(self, self._onRenderListKnightCell))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
end

function AncientsSelectKnightPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_PETSETKNIGHT, handler(self, self._onRcvAncientPetSetKnight), self)
	self:_updateView()
end

function AncientsSelectKnightPop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "AncientsSelectKnightCell_onClickBtnLineUp" then
		self._knightPos = arg_4_2.knightPos or 0
	end
end

function AncientsSelectKnightPop:_updateView()
	self._showUnits = {}

	for iter_5_0, iter_5_1 in ipairs(self._units) do
		if g.core.config.knight_info.get(iter_5_1.base_id).type ~= 1 then
			table.insert(self._showUnits, iter_5_1)
		end
	end

	self.m_List_knight:setNumItems(#self._showUnits)
end

function AncientsSelectKnightPop:_onRenderListKnightCell(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._showUnits[arg_6_1 + 1], self._selectKnightPos)
end

function AncientsSelectKnightPop:_onRcvAncientPetSetKnight(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:popComponent()
end

function AncientsSelectKnightPop:_onClickConfirmBtn()
	if self._knightPos ~= 0 then
		local var_8_0

		for iter_8_0, iter_8_1 in ipairs(self._units) do
			if iter_8_1.id == self._knightPos then
				var_8_0 = iter_8_1
			end
		end

		if g.core.config.knight_info.get(var_8_0.base_id).quality ~= g.core.model.User.ancientsData:getEchoQualityByIndex(self._pos) and g.core.model.User.ancientsData:getPetEchoData(self._pos).main_user_id ~= g.core.model.User:getId() then
			g.core.module.ModuleManager:tip(g.core.lang:get(433375))

			return
		end
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_PetSetKnight({
		idx = self._pos,
		knight_id = self._knightPos
	})
end

return AncientsSelectKnightPop
