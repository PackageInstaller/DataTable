local RegressionCardTaskContent = class("RegressionCardTaskContent", (import("game.views.regressionNew.pageViews.RegressionTaskContent")))

function RegressionCardTaskContent:InitNode()
	self.selectIndex = nil

	self:AddBtnListener(self.goBtn_, nil, function()
		self.isGoToDraw = true

		JumpTools.GoToSystem("/draw", {
			poolId = self.drawList[self.selectIndex].poolId
		}, ViewConst.SYSTEM_ID.DRAW)
	end)

	self.selectPoolList = LuaList.New(handler(self, self.IndexItem), self.poolList_, RegressionSelectPoolItem)
	self.poolSelectStateController = self.controller_:GetController("poolSelectState")
end

function RegressionCardTaskContent:GetSelectParams()
	if not self.isGoToDraw then
		return nil, nil
	end

	self.isGoToDraw = false

	return 1, 3
end

function RegressionCardTaskContent:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.drawList[arg_4_1].poolId)
	arg_4_2:RegistCallBack(handler(self, self.OnItemClick))

	if self.selectIndex == arg_4_1 then
		arg_4_2:UpdateSelectState(true)
	end
end

function RegressionCardTaskContent:OnItemClick(arg_5_1)
	if self.selectIndex == arg_5_1 then
		return
	end

	if self.selectIndex then
		local var_5_0 = self.selectPoolList:GetItemByIndex(self.selectIndex)

		if var_5_0 then
			var_5_0:UpdateSelectState(false)
		end
	end

	self.selectIndex = arg_5_1

	local var_5_1 = self.selectPoolList:GetItemByIndex(self.selectIndex)

	if var_5_1 then
		var_5_1:UpdateSelectState(true)
	end

	self:UpdateSelectPoolUI()
end

function RegressionCardTaskContent:UpdateSelectPoolUI()
	if #self.drawList == 0 then
		return
	end

	self:AddPoolTimer(self.drawList[self.selectIndex].poolId)

	self.heronameTxt_.text = HeroTools.GetHeroFullName(DrawPoolCfg[self.drawList[self.selectIndex].poolId].unoption_up_items[1][1])

	self:RefreshRoleImage(DrawPoolCfg[self.drawList[self.selectIndex].poolId].unoption_up_items[1][1])
end

function RegressionCardTaskContent:RefreshRoleImage(arg_7_1)
	self.poolpictureImg_.spriteSync = "TextureConfig/Character/Portrait/" .. arg_7_1

	self.poolpictureImg_:SetNativeSize()

	self.campiconImg_.sprite = HeroTools.GetRaceIcon(HeroCfg[arg_7_1].race)
end

function RegressionCardTaskContent:AddPoolTimer(arg_8_1)
	if self.poolTimer then
		self.poolTimer:Stop()

		self.poolTimer = nil
	end

	local var_8_0 = ActivityData:GetActivityData(self.drawList[self.selectIndex].actID).stopTime

	self.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0))
	self.poolTimer = Timer.New(function()
		self.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_8_0))
	end, 1, -1)

	self.poolTimer:Start()
end

function RegressionCardTaskContent:RefreshUI()
	self.descTxt_.text = GetTips("NEW_REGRESSION_DRAW_TASK_DESC")

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(iter_10_1) then
			if ActivityDrawPoolCfg[iter_10_1] then
				for iter_10_2, iter_10_3 in ipairs(ActivityDrawPoolCfg[iter_10_1].config_list) do
					if DrawPoolCfg[iter_10_3].pool_show_type == 6 then
						table.insert(var_10_0, {
							poolId = iter_10_3,
							actID = iter_10_1
						})
					end
				end
			end
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		local var_11_0 = DrawPoolCfg[arg_11_0.poolId]
		local var_11_1 = DrawPoolCfg[arg_11_1.poolId]

		if DrawPoolCfg[arg_11_0.poolId].order == DrawPoolCfg[arg_11_1.poolId].order then
			return arg_11_0.poolId > arg_11_1.poolId
		else
			return var_11_0.order < var_11_1.order
		end
	end)

	if #var_10_0 == 1 then
		self.poolSelectStateController:SetSelectedState("hide")
	else
		self.poolSelectStateController:SetSelectedState("show")
	end

	self.drawList = var_10_0

	self.selectPoolList:StartScroll(#self.drawList)
	self:OnItemClick(self.selectIndex or 1)

	self.cardnumtxt_.text = string.format(GetTips("NEW_REGRESSION_DRAW_TASK_PROGRESS_DESC"), TaskData2:GetTask(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.REGRESSION_DRAW][1]).progress)
end

function RegressionCardTaskContent:Dispose()
	self.selectIndex = nil

	if self.poolTimer then
		self.poolTimer:Stop()

		self.poolTimer = nil
	end

	if self.selectPoolList then
		self.selectPoolList:Dispose()

		self.selectPoolList = nil
	end

	RegressionCardTaskContent.super.Dispose(self)
end

return RegressionCardTaskContent
