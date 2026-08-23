local NewSlgMoveComp = class("NewSlgMoveComp")
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMoveComp:ctor()
	self._compBannerInfo = self:getChild("Comp_bannerInfo")
	self._btnMove = self:getChild("Btn_move")
	self._freeBtn = self:getChild("freeBtn")

	self._btnMove:addClickListener(handler(self, self._onClickBtnMove))
	self._freeBtn:addClickListener(handler(self, self._onClickBtnMove))

	self._txtName = self:getChild("Txt_name")
	self._txtPos = self:getChild("Txt_pos")
	self._txtTip = self:getChild("Txt_tip")
	self._txtCd = self:getChild("Txt_cd")
	self._stateCtrl = self:getController("c1")
	self._isEnough = false
	self._canMove = false
end

function NewSlgMoveComp:updateView(arg_2_1)
	self._data = arg_2_1
	self._forceMove = arg_2_1.forceMove or false
	self._canMove = arg_2_1.canMove or false

	self._txtPos:setText(g.core.lang:get(428985, {
		x = self._data.pos.x,
		y = self._data.pos.y
	}))
	self._txtName:setText(arg_2_1.name or "")
	self._compBannerInfo:updateView({
		bannerType = var_0_2.SLGBannerType.TERRAIN,
		res = g.core.common.Path:getNewSlgSiegeTerrain(arg_2_1.pic)
	})

	local var_2_0 = var_0_1:getMoveHomeFreeTime()
	local var_2_1 = var_0_1:getMoveHomeCDTime()

	if (var_0_1:getLastMoveHomeTime() or 0) > 0 then
		var_2_0 = 0
	end

	local var_2_2 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_0_2.MOVE_HOME_ITEM_ID)

	self._btnMove:updateCost(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = var_0_2.MOVE_HOME_ITEM_ID
	}), var_2_0 > 0 and 0 or 1, var_2_2)

	self._isEnough = var_2_0 > 0 or var_2_2 >= 1

	if self._forceMove then
		self._canMove = true
		self._isEnough = true
	end

	self._btnMove:setTitle(g.core.lang:get(428805))

	if not self._canMove then
		self._stateCtrl:setSelectedIndex(2)

		if var_0_1:isSameProvinceGID((var_0_1:getProvinceGIdByRC(arg_2_1.pos.x, arg_2_1.pos.y))) then
			self._txtTip:setText(g.core.lang:get(428808))
		else
			self._txtTip:setText(g.core.lang:get(428807))
		end
	elseif var_2_0 > 0 or var_2_1 > 0 then
		self:newSchedule(handler(self, self._updateLeftTime), 1)
		self:_updateLeftTime()

		if var_2_0 > 0 and var_2_1 <= 0 then
			self._freeBtn:setTitle(g.core.lang:get(428804))
			self._stateCtrl:setSelectedIndex(3)
		else
			self._stateCtrl:setSelectedIndex(1)
		end
	else
		self._stateCtrl:setSelectedIndex(0)
	end

	self:getTransition("enter"):play()
end

function NewSlgMoveComp:_updateLeftTime()
	local var_3_0 = var_0_1:getMoveHomeFreeTime()

	if (var_0_1:getLastMoveHomeTime() or 0) > 0 then
		var_3_0 = 0
	end

	local var_3_1 = var_0_1:getMoveHomeCDTime()

	if (var_3_1 > 0 and var_3_1 or var_3_0) > 0 then
		local var_3_2 = g.core.common.ServerTime:secondToHMSString(var_3_1 > 0 and var_3_1 or var_3_0)

		self._txtCd:setText((var_3_1 > 0 or nil) and (g.core.lang:get(428802, {
			time = var_3_2
		}) or g.core.lang:get(428803, {
			time = var_3_2
		})))
	else
		self:cancelSchedule(self._updateLeftTime)
		self._stateCtrl:setSelectedIndex(0)
		self._btnMove:removeAllEffect()
		self._btnMove:setTitle(g.core.lang:get(428805))
		self:updateView(self._data)
	end
end

function NewSlgMoveComp:_onClickBtnMove()
	if self._canMove then
		if g.core.model.User.newSlgData:getSName() == "S2" then
			local var_4_0 = var_0_1:getOccupiedCities()

			if var_0_1:getProvinceCfgByGID((var_0_1:getProvinceGIdByRC(self._data.pos.x, self._data.pos.y))).level == 2 then
				if #var_4_0 == 0 then
					self:doubleCheckMove()
				else
					local var_4_1 = false

					for iter_4_0, iter_4_1 in ipairs(var_4_0) do
						if g.core.config.new_slg_province_info.get(g.core.config.new_slg_city_info.get(iter_4_1).city_state).level == 2 then
							self:doMoveAction()

							var_4_1 = true

							break
						end
					end

					if not var_4_1 then
						self:doubleCheckMove()
					end
				end
			else
				self:doMoveAction()
			end
		else
			self:doMoveAction()
		end
	end

	self:setVisible(false)
end

function NewSlgMoveComp:doubleCheckMove()
	g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
		title = g.core.lang:get(429054),
		desc = g.core.lang:get(429055),
		onConfirm = handler(self, self.doMoveAction)
	})
end

function NewSlgMoveComp:doMoveAction()
	local var_6_0 = var_0_1:getMoveHomeCDTime()

	if var_6_0 > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428802, {
			time = g.core.common.ServerTime:secondToHMSString(var_6_0)
		}))

		return
	end

	if self._isEnough then
		if not var_0_1:isAllTeamIdle() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428806))
		else
			g.core.network.GameNetProxy:send_C2S_NewSlg_MoveHome({
				path = self._data.path,
				target_pos = self._data.pos
			})
		end
	else
		local var_6_1 = {}

		var_6_1.name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_2.MOVE_HOME_ITEM_ID
		}).info.name

		g.core.module.ModuleManager:tip(g.core.lang:get(428998, var_6_1))
	end
end

return NewSlgMoveComp
