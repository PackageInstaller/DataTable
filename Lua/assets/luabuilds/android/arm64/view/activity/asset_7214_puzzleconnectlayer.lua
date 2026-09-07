local PuzzleConnectLayer = class("PuzzleConnectLayer", import("..base.BaseUI"))

PuzzleConnectLayer.OPEN_DETAIL = "open detail panel"
PuzzleConnectLayer.OPEN_MENU = "open menu panel"
PuzzleConnectLayer.OPEN_GAME = "open game panel"

function PuzzleConnectLayer:getUIName()
	return "PuzzleConnectUI"
end

function PuzzleConnectLayer:didEnter()
	self.menuPanel = PuzzleConnectMenu.New(findTF(self._tf, "ad/menu"), self)
	self.detailPanel = PuzzleConnectDetail.New(findTF(self._tf, "ad/detail"), self)
	self.gamePanel = PuzzleConnectGame.New(findTF(self._tf, "ad/game"), self)
	self.panelDic = {
		self.menuPanel,
		self.detailPanel,
		self.gamePanel
	}

	self:bind(PuzzleConnectLayer.OPEN_DETAIL, function(arg_3_0, arg_3_1)
		self:show(self.menuPanel)
		self:show(self.detailPanel, true)

		if arg_3_1 then
			self.detailPanel:setData(arg_3_1)

			self._activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT)

			self.detailPanel:setActivity(self._activity)
		end

		return
	end)
	self:bind(PuzzleConnectLayer.OPEN_MENU, function(arg_4_0, arg_4_1)
		self:show(self.menuPanel)

		return
	end)
	self:bind(PuzzleConnectLayer.OPEN_GAME, function(arg_5_0, arg_5_1)
		self:show(self.gamePanel)

		if arg_5_1 then
			self.gamePanel:setData(arg_5_1)
		end

		return
	end)
	self:show(self.menuPanel)

	self._activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT)

	if self._activity then
		self.menuPanel:setData((self._activity:getConfig("config_data")))
	else
		self.menuPanel:setData({
			1,
			2,
			3,
			4,
			5,
			6,
			7
		})
	end

	if PlayerPrefs.GetInt("puzzle_connect_first_" .. tostring(getProxy(PlayerProxy):getPlayerId())) ~= 1 then
		pg.NewStoryMgr.GetInstance():Play("WEIXIANFAMINGPOJINZHONGWEITUO1", function()
			PlayerPrefs.SetInt("puzzle_connect_first_" .. tostring(getProxy(PlayerProxy):getPlayerId()), 1)

			return
		end)
	end

	self:updateActivity()

	return
end

function PuzzleConnectLayer:show(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(self.panelDic) do
		if iter_7_1 == arg_7_1 then
			iter_7_1:show()
		elseif not arg_7_2 then
			iter_7_1:hide()
		end
	end

	return
end

function PuzzleConnectLayer:updateActivity()
	self._activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLE_CONNECT)

	if self._activity then
		local var_8_0 = self._activity:getConfig("config_data")

		self.menuPanel:setActivity(self._activity)
		self.detailPanel:setActivity(self._activity)
		self.gamePanel:setActivity(self._activity)

		local var_8_1 = getProxy(PlayerProxy)
		local var_8_3 = self._activity:getDayIndex()

		for iter_8_0 = 1, #var_8_0 do
			if iter_8_0 <= var_8_3 then
				if not table.contains(self._activity.data3_list, var_8_0[iter_8_0]) then
					if not table.contains(self._activity.data1_list, var_8_0[iter_8_0]) and iter_8_0 == 0 + 1 then
						if pg.activity_tolove_jigsaw[var_8_0[iter_8_0]].need[3] <= var_8_1:getData():getResource(pg.activity_tolove_jigsaw[var_8_0[iter_8_0]].need[2]) then
							self:emit(PuzzleConnectMediator.CMD_ACTIVITY, {
								index = 1,
								config_id = var_8_0[iter_8_0]
							})
						end
					end
				else
					-- block empty
				end
			end
		end
	end

	return
end

function PuzzleConnectLayer:initEvent()
	return
end

function PuzzleConnectLayer:willExit()
	self.detailPanel:dispose()
	self.menuPanel:dispose()
	self.gamePanel:dispose()

	return
end

return PuzzleConnectLayer
