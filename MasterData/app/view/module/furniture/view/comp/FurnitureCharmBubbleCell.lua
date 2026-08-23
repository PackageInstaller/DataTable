local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.friendData
local FurnitureCharmBubbleCell = class("FurnitureCharmBubbleCell", require("app.fairyGUI.furniture.UI_FurnitureCharmBubbleCell"))

function FurnitureCharmBubbleCell:ctor()
	self._uid = 0

	self.m_clickLoader:addClickListener(handler(self, self._onClickUserName))
end

function FurnitureCharmBubbleCell:_onClickUserName()
	if self._uid > 0 then
		local var_2_0 = tonumber(var_0_1:getTime())

		if var_2_0 - var_0_2:getFriendRoomConnectTime() >= 3 then
			g.core.network.GameNetProxy:send_C2S_FurnitureRoom_FriendGetInfo({
				friend_id = self._uid
			})
			var_0_2:setFriendRoomConnectTime(var_2_0)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(309184))
		end
	end
end

function FurnitureCharmBubbleCell:updateBubbleCell(arg_3_1)
	if not arg_3_1 or not next(arg_3_1) then
		self._uid = 0

		return
	end

	local var_3_0 = ""

	if arg_3_1.clientTime then
		self._uid = 0
		var_3_0 = g.core.lang:get(112557, {
			name = "",
			desc = var_0_1:getDate(arg_3_1.clientTime)
		})
	else
		self._uid = arg_3_1.uid

		local var_3_1 = arg_3_1.name or ""

		self.m_userNameText:setText(var_3_1)

		if arg_3_1.op_type == var_0_0.BUBBLE_TYPE.LOOK then
			var_3_0 = g.core.lang:get(112557, {
				name = var_3_1,
				desc = g.core.lang:get(112555)
			})
		elseif arg_3_1.op_type == var_0_0.BUBBLE_TYPE.CHARM then
			var_3_0 = g.core.lang:get(112557, {
				name = var_3_1,
				desc = g.core.lang:get(112556)
			})
		elseif arg_3_1.op_type == var_0_0.BUBBLE_TYPE.CLEAN then
			var_3_0 = g.core.lang:get(112557, {
				name = var_3_1,
				desc = g.core.lang:get(112558)
			})
		end
	end

	self.m_typeText:setText(var_3_0, nil, true)
end

return FurnitureCharmBubbleCell
