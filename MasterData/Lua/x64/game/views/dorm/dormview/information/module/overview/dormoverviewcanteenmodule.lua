DormOverviewModuleBase = import("game.views.dorm.DormView.Information.Module.overview.DormOverviewModuleBase")

local DormOverviewCanteenModule = class("DormOverviewCanteenModule", DormOverviewModuleBase)

function DormOverviewCanteenModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/overview/canteenSubPanel"
end

function DormOverviewCanteenModule:InitUI()
	self:BindCfgUI()
	self:AddListener()
	self:InitView()

	self.isIn = false
end

function DormOverviewCanteenModule:InitView()
	self.heroList = {}

	for iter_3_0 = 1, 3 do
		self.heroList[iter_3_0] = DormOverviewCanteenHeroItem.New(self["heroItem" .. iter_3_0])
	end

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.taskScroll_, DormOverviewCanteenTaskModule)
	self.soldController1 = self.foodController1:GetController("soldout")
	self.soldController2 = self.foodController2:GetController("soldout")
end

function DormOverviewCanteenModule:OnEnter()
	self.isIn = true
	self.receiveAwardDirty = false

	SetActive(self.effectObj_, false)
	manager.redPoint:bindUIandKey(self.awardBtn_.transform, RedPointConst.CANTEEN_MAX)
	manager.redPoint:bindUIandKey(self.taskTrs_, RedPointConst.CANTEEN_DISPATCH_NONE)
end

function DormOverviewCanteenModule:OnExit()
	self.isIn = false
	self.receiveAwardDirty = false

	SetActive(self.effectObj_, false)
	manager.redPoint:unbindUIandKey(self.awardBtn_.transform, RedPointConst.CANTEEN_MAX)
	manager.redPoint:unbindUIandKey(self.taskTrs_, RedPointConst.CANTEEN_DISPATCH_NONE)
end

function DormOverviewCanteenModule:AddListener()
	self:AddBtnListenerScale(self.awardBtn_, nil, function()
		local var_7_0, var_7_1 = CanteenData:GetAutoNextAwardTime()

		if CanteenData:GetAutoAwardNum() == 0 then
			ShowTips("CANTEEN_ADMITTED_NULL")

			return
		end

		self.receiveAwardDirty = true

		CanteenAction:ReceiveCanteenAutoAward(DormConst.CANTEEN_ID)
	end)
	self:AddBtnListenerScale(self.menuBtn_, nil, function()
		JumpTools.OpenPageByJump("/chooseSignFoodView")
	end)
	self:AddBtnListener(self.taskBtnMask, nil, function()
		saveData("DormTaskRedpoint", "lastClickTime", manager.time:GetServerTime())
		JumpTools.OpenPageByJump("/dormTaskDispatchView", {
			roomID = DormConst.CANTEEN_ID
		})
	end)
end

function DormOverviewCanteenModule:RegisterEvents()
	self:RegistEventListener(DORM_RESTAURANT_UPDATE_FINISH, handler(self, self.OnRewardUpdate))
	self:RegistEventListener(BACKHOME_CATEEN_AWARD_UPDATE, handler(self, self.OnRewardUpdate))
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, handler(self, self.RenderHeroItem))
end

function DormOverviewCanteenModule:Render()
	self:RenderHeroItem()
	self:RenderCanteenMenu()
	self:RenderAward()
	self:RenderTask()
	DormRedPointTools:UpdateCanteenNotify()
end

function DormOverviewCanteenModule:RenderHeroItem()
	self.jobList = {}

	for iter_12_0, iter_12_1 in ipairs(DormEnum.RestaurantJobToClientMap) do
		table.insert(self.jobList, iter_12_0)
	end

	for iter_12_2 = 1, 3 do
		self.heroList[iter_12_2]:RefreshUI(self.jobList[iter_12_2])
	end
end

function DormOverviewCanteenModule:RenderCanteenMenu()
	self.signFoodList = CanteenFoodData:GetChooseFoodList() or {}

	for iter_13_0 = 1, 2 do
		if self.signFoodList[iter_13_0] then
			SetActive(self["foodItem" .. iter_13_0], true)

			self["foodIcon" .. iter_13_0].sprite = CanteenTools.GetFoodSprite(self.signFoodList[iter_13_0])

			local var_13_0 = CanteenFoodData:GetSignFoodInfo(self.signFoodList[iter_13_0])

			self["soldController" .. iter_13_0]:SetSelectedState(var_13_0.soldNum >= var_13_0.sellNum and "on" or "off")
		else
			SetActive(self["foodItem" .. iter_13_0], false)
		end
	end
end

function DormOverviewCanteenModule:RenderTask()
	self.taskList = {}

	for iter_14_0, iter_14_1 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		local var_14_0 = CanteenEntrustData:GetEntrustByPos(iter_14_1[2])

		if var_14_0 and var_14_0.id > 0 then
			table.insert(self.taskList, var_14_0)
		end
	end

	self.scrollHelper:StartScroll(#self.taskList)
end

function DormOverviewCanteenModule:RenderAward()
	local var_15_0 = CanteenData:GetAutoAwardNum() or 0

	self.awardNum = var_15_0
	self.awardTotalTxt.text = string.format("%d<size=26><color=#767878>/%d</color></size>", var_15_0, (DormSkillData:GetInComeStorageMax()))
end

function DormOverviewCanteenModule:OnRewardUpdate()
	if (self.awardNum or 0) ~= (CanteenData:GetAutoAwardNum() or 0) then
		self:RenderAward()

		if self.receiveAwardDirty and self.isIn then
			self.receiveAwardDirty = false

			SetActive(self.effectObj_, true)
			self.awardAnim_:Play("Get")
		end
	end
end

function DormOverviewCanteenModule:indexItem(arg_17_1, arg_17_2)
	arg_17_2:Render(self.taskList[arg_17_1])
end

function DormOverviewCanteenModule:Dispose()
	self.scrollHelper:Dispose()

	for iter_18_0 = 1, 3 do
		self.heroList[iter_18_0]:Dispose()
	end

	self.heroList = nil

	DormOverviewCanteenModule.super.Dispose(self)
end

return DormOverviewCanteenModule
