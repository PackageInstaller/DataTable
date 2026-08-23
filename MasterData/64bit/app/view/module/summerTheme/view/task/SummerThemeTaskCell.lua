local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.common.ServerTime
local SummerThemeTaskCell = class("SummerThemeTaskCell", require("app.fairyGUI.summerTheme.UI_SummerThemeTaskCell"))

function SummerThemeTaskCell:ctor(arg_1_1)
	self._curState = 0
	self._curTaskId = 0
	self._curRouteId = 0
	self._activeThemeValue = 0
	self._curActionId = 0
	self._curActionVal = 0
	self._awardsArr = {}

	self.m_receiveBtn:addClickListener(handler(self, self._onBtnClick))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)

	self._goBtnTrans = self.m_receiveBtn:getTransition("go")
	self._getBtnTrans = self.m_receiveBtn:getTransition("get")
end

function SummerThemeTaskCell:refreshTaskCell(arg_2_1, arg_2_2, arg_2_3)
	self._activeThemeValue = arg_2_2
	self._activityValues = arg_2_3 or {
		arg_2_2
	}

	local var_2_0 = arg_2_1:getBaseInfo()

	self._curState = arg_2_1:getTaskStatus()
	self._curTaskId = var_2_0.id
	self._curRouteId = var_2_0.route_id
	self._curActionId = var_2_0.action_id
	self._curActionVal = var_2_0.num

	self.m_drawStateController:setSelectedIndex(self._curState)
	self.m_name:setText(var_2_0.name)
	self.m_descText:setText((g.core.lang:getByString(var_2_0.des, {
		num = var_2_0.num
	})))

	self._awardsArr = arg_2_1:getTaskAwardInfo()

	self.m_awardList:setNumItems(#self._awardsArr)
	self.m_destinNumText:setText("/" .. var_2_0.num)

	local var_2_1 = arg_2_1:getCurDoingNum()

	if var_2_1 > var_2_0.num then
		self.m_curProgressText:setText(var_2_0.num)
	else
		self.m_curProgressText:setText(var_2_1)
	end

	if self._curState == 4 then
		local var_2_2, var_2_3, var_2_4, var_2_5 = var_0_1:getLeftTimeParts((arg_2_1:getTaskStarTime()))

		if var_2_2 == 0 and (var_2_3 > 0 or var_2_4 > 0 or var_2_5 > 0) then
			self.m_lockDesc:setText(g.core.lang:get(405709))
		else
			self.m_lockDesc:setText(g.core.lang:get(405710, {
				time = var_2_2
			}))
		end
	end

	self._getBtnTrans:stop()
	self._goBtnTrans:stop()

	if self._curState == 2 then
		self._getBtnTrans:play(-1, 0)
	elseif self._curState == 1 then
		self._goBtnTrans:play(-1, 0)
	end
end

function SummerThemeTaskCell:_onAwardRenderer(arg_3_1, arg_3_2)
	local var_3_0 = self._awardsArr[arg_3_1 + 1] or {}

	var_3_0.scaleIndex = 3
	var_3_0.hideNum = false

	arg_3_2:updateIcon(var_3_0)
end

function SummerThemeTaskCell:_onBtnClick()
	local var_4_0 = g.core.model.User.themeData:getThemeData(self._activeThemeValue)

	if self._curState == 2 then
		var_4_0:getTaskData():requestTaskAward(self._curTaskId)
	elseif self._curState == 1 and self._curRouteId > 0 then
		if self._curActionId == 4002 then
			if #self._activityValues > 1 then
				g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.mergeTheme.SummerThemeBossSelectLayer").new({
					activityValues = self._activityValues,
					activeThemeValue = self._activeThemeValue
				})))

				return
			end

			local var_4_1 = var_4_0:getBossData():getBossOpenState()

			if var_4_1 == var_0_0.THEME_STATE_TYPE.UNOPEN then
				g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

				return
			elseif var_4_1 == var_0_0.THEME_STATE_TYPE.FINISH then
				g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

				return
			end
		elseif self._curActionId == 4001 then
			local var_4_2 = var_4_0:getDungeonData():getThemeDungeonChapters() or {}
			local var_4_3 = var_4_2[self._curActionVal]

			if not var_4_2[self._curActionVal] or g.core.common.ServerTime:getTime() < var_4_3.chapterOpenTime then
				g.core.module.ModuleManager:tip((g.core.lang:get(405724)))

				return
			end

			g.core.module.ModuleManager:pushModule(g.view.entrance.SUMMER_THEME_DUNGEON, {
				themeValue = self._activeThemeValue,
				chapterId = var_4_3.chapterId
			})

			return
		end

		g.view.entrance.ModuleGotoProxy:gotoModule(self._curRouteId)
	end
end

return SummerThemeTaskCell
