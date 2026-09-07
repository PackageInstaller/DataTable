local AprilFoolBulinSubView = class("AprilFoolBulinSubView", import("view.base.BaseSubPanel"))

function AprilFoolBulinSubView:Ctor(arg_1_1, arg_1_2)
	AprilFoolBulinSubView.super.Ctor(self, arg_1_1)

	self.pieceId = arg_1_2

	return
end

function AprilFoolBulinSubView:getUIName()
	return "AprilFoolBulinSubView"
end

function AprilFoolBulinSubView:OnInit()
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	if not var_3_0 or var_3_0:isEnd() then
		self:Destroy()

		return
	end

	local var_3_1 = pg.activity_event_picturepuzzle[var_3_0.id]

	assert(pg.activity_event_picturepuzzle[var_3_0.id], "Can't Find activity_event_picturepuzzle 's ID : " .. var_3_0.id)

	self.bulin = self._tf:Find("bulin")

	onButton(self, self.bulin, function()
		local var_4_0 = self.pieceId

		pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
			cmd = 2,
			actId = var_3_0.id,
			id = self.pieceId,
			callback = function()
				local var_5_0 = var_3_1.awards[table.indexof(var_3_1.pickup_picturepuzzle, var_4_0)]

				assert(var_5_0, "Cant Find Award of PieceID " .. var_4_0)
				self:emit(BaseUI.ON_ACHIEVE, {
					{
						type = var_5_0[1],
						id = var_5_0[2],
						count = var_5_0[3]
					}
				})
				self:Destroy()

				return
			end
		})

		return
	end)

	return
end

function AprilFoolBulinSubView:SetPosition(arg_6_1)
	setAnchoredPosition(self._tf, arg_6_1)

	return
end

function AprilFoolBulinSubView:SetParent(arg_7_1)
	setParent(self._tf, arg_7_1)

	return
end

function AprilFoolBulinSubView:ShowAprilFoolBulin(arg_8_1, arg_8_2)
	local var_8_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	if not var_8_2 or var_8_2:isEnd() then
		return
	end

	local var_8_3 = pg.activity_event_picturepuzzle[var_8_2.id]

	if not pg.activity_event_picturepuzzle[var_8_2.id] then
		return
	end

	local var_8_4 = var_8_3.pickup_picturepuzzle[table.indexof(var_8_3.pickup_views, self.__cname)]

	if not var_8_4 or table.contains(var_8_2.data2_list, var_8_4) then
		return
	end

	local var_8_5 = _G[var_8_2:getConfig("config_client").subView]

	if not var_8_5 then
		return
	end

	local var_8_6 = var_8_5.New(self, var_8_4)

	var_8_6:Load()

	if arg_8_1 then
		var_8_6.buffer:SetParent(arg_8_1)
	end

	if arg_8_2 then
		var_8_6.buffer:SetPosition(arg_8_2)
	end

	return var_8_6
end

function AprilFoolBulinSubView:OnDestroy()
	existCall(self.destroyCall)

	self.destroyCall = nil

	return
end

return AprilFoolBulinSubView
