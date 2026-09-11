local NewWarChessHome = class("NewWarChessHome", ReduxView)
local var_0_1 = {
	"Normal",
	"MoreThenCurMovePoint",
	"MoreThenMax"
}

function NewWarChessHome:UIName()
	return "UI/NewWarChess/NewWarChessMain"
end

function NewWarChessHome:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessHome:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessHome:InitUI()
	self:BindCfgUI()

	self.taskList_ = LuaList.New(handler(self, self.indexItem), self.taskListGo_, NewWarChessHomeTaskItem)
	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.diceList_ = LuaList.New(handler(self, self.IndexDiceItem), self.diceListGo_, NewWarChessDiceItem)
	self.isShowingBuff_ = false
	self.curShowBuffIndex_ = 0
	self.buffList_ = LuaList.New(handler(self, self.IndexBuffItem), self.buffList_, NewWarChessBuffItem)
	self.clickBuffHandler_ = handler(self, self.OnClickBuff)
	self.moveController_ = ControllerUtil.GetController(self.moveTrans_, "state")
	self.moveState_ = var_0_1[1]
	self.curCost_ = 0
end

function NewWarChessHome:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskIDList_[arg_5_1])
end

function NewWarChessHome:IndexDiceItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.diceDataList_[arg_6_1])
	arg_6_2:SetClickCallBack(function(arg_7_0)
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_CHECK_DICE_TO_MOVEPOINT"), arg_6_2.dicePoint_, arg_6_2.dicePoint_),
			OkCallback = function()
				local var_8_0 = arg_6_2.dicePoint_

				NewWarChessAction.DiceToMovePoint(arg_6_2.dicePoint_, function()
					local var_9_0 = math.floor(var_8_0 * (NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_TO_MOVE_POINT_TIMES") / 1000))

					NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", var_9_0)
					manager.NewChessManager:CreateTips({
						tipsType = NewChessConst.TIPS_TYPE.SWITCH,
						tipsText = string.format(GetTips("ACTIVITY_NEW_WARCHESS_DICE_TO_MOVEPOINT"), var_8_0, var_9_0),
						tipsDiceNum = var_8_0
					})
					NewWarChessData:RemoveDice({
						arg_6_2.dicePoint_
					})
					self:RefreshDiceList()
				end)
			end
		})
	end)
end

function NewWarChessHome:IndexBuffItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.curShowBuffIndex_, self.buffEntityList_[arg_10_1])
	arg_10_2:SetClickCallBack(self.clickBuffHandler_)
end

function NewWarChessHome:OnClickBuff(arg_11_1, arg_11_2, arg_11_3)
	if self.isShowingBuff_ then
		SetActive(self.buffInfoGo_, false)

		self.curShowBuffIndex_ = 0

		self.buffList_:Refresh()

		self.isShowingBuff_ = false
	else
		SetActive(self.buffInfoGo_, true)

		self.curShowBuffIndex_ = arg_11_1
		self.buffInfoNameText_.text = arg_11_2
		self.buffInfoDesText_.text = arg_11_3

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoContentTrans_)

		self.isShowingBuff_ = true
	end
end

function NewWarChessHome:OnEnter()
	self.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))

	local var_12_0 = NewWarChessData:GetExploreValue((NewWarChessData:GetCurrentWarChessMapID()))

	self.exploreValueText_.text = var_12_0 .. "%"
	self.exploreValueImage_.fillAmount = var_12_0 / 100

	SetActive(self.lookatBtn_.gameObject, false)
	SetActive(self.buffInfoGo_, false)

	self.curShowBuffIndex_ = 0
	self.isShowingBuff_ = false

	self:RefreshDiceList()
	self:RefreshTaskList()
	self:RefreshBuffList()
	self:BindRedPoint()
end

function NewWarChessHome:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].activity)
end

function NewWarChessHome:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].activity)
end

function NewWarChessHome:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		NewChessTools.ExitNewChessScene(false)
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())
		}
	})
end

function NewWarChessHome:AddUIListener()
	self:AddBtnListener(self.useItemBtn_, nil, function()
		JumpTools.OpenPageByJump("newWarChessPopItemView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity()
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = NewWarChessData:GetCurrentMainActivity(),
			activityIDList = {
				NewWarChessData:GetCurrentActivity()
			}
		})
	end)
	self:AddBtnListener(self.lookatBtn_, nil, function()
		NewChessLuaBridge.LookAtPlayer()
		manager.NewChessManager:ClearEndPoint()
		SetActive(self.lookatBtn_.gameObject, false)
	end)
	self:AddBtnListener(self.moveBtn_, nil, function()
		if self.moveState_ == var_0_1[1] then
			manager.NewChessManager:StartMoveToCaChePath()
		elseif self.moveState_ == var_0_1[2] then
			ShowTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_DEFICIENCY")
		elseif self.moveState_ == var_0_1[3] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("ACTIVITY_NEW_WARCHESS_MOVEPOINT_COST_MORETHEN_MAX"), NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1]),
				OkCallback = function()
					manager.NewChessManager:StartMoveToCaChePath()
				end
			})
		end
	end)
	self:AddBtnListener(self.farClickBtn_, nil, function()
		if self.farClickFun_ then
			self.farClickFun_()

			self.farClickFun_ = nil

			self.statusController_:SetSelectedState("normal")
		end
	end)
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("newWarChessHeroView")
	end)
	self:AddBtnListener(self.buffinfoBtn_, nil, function()
		if self.isShowingBuff_ then
			self.isShowingBuff_ = false
			self.curShowBuffIndex_ = 0

			SetActive(self.buffInfoGo_, false)
			self.buffList_:Refresh()
		end
	end)
end

function NewWarChessHome:OnNewChessHomeUpdateState(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	if arg_26_1 == NewChessConst.HOME_STATUS.NORMAL then
		self.statusController_:SetSelectedState("normal")

		self.curCost_ = 0
	elseif arg_26_1 == NewChessConst.HOME_STATUS.MOVING then
		self.statusController_:SetSelectedState("moving")

		self.curCost_ = 0
	elseif arg_26_1 == NewChessConst.HOME_STATUS.READY then
		self.statusController_:SetSelectedState("ready")

		self.curCost_ = arg_26_2
		self.costText_.text = arg_26_2

		self:RefreshMoveCost()

		self.moveTrans_.localPosition = Vector3.New(arg_26_3 / Screen.width * manager.ui.canvasSize_.x, arg_26_4 / Screen.height * manager.ui.canvasSize_.y)
	elseif arg_26_1 == NewChessConst.HOME_STATUS.FARCLICK then
		self.statusController_:SetSelectedState("farClick")

		self.farClickFun_ = arg_26_5
		self.curCost_ = 0
		self.farClickTrans_.localPosition = Vector3.New(arg_26_3 / Screen.width * manager.ui.canvasSize_.x, arg_26_4 / Screen.height * manager.ui.canvasSize_.y)
	end
end

function NewWarChessHome:RefreshMoveCost()
	if self.curCost_ > 0 then
		local var_27_0 = NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")
		local var_27_1 = NewChessTools.GetNewWarChessGameSetting("new_warchess_single_move_point_max", NewWarChessData:GetCurrentMainActivity())[1]

		if var_27_0 < self.curCost_ or var_27_1 < self.curCost_ then
			if var_27_0 < self.curCost_ then
				self.moveState_ = var_0_1[2]
			elseif var_27_1 < self.curCost_ then
				self.moveState_ = var_0_1[3]
			end

			self.moveController_:SetSelectedState("lock")
		else
			self.moveState_ = var_0_1[1]

			self.moveController_:SetSelectedState("normal")
		end
	end
end

function NewWarChessHome:OnNewWarChessBuffUpDate()
	self:RefreshBuffList()
end

function NewWarChessHome:OnNewWarChessExploreValueUpdate(arg_29_1)
	self.exploreValueText_.text = arg_29_1 .. "%"
	self.exploreValueImage_.fillAmount = arg_29_1 / 100
end

function NewWarChessHome:RefreshTaskList()
	self.taskIDList_ = {}

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs((manager.NewChessManager.taskManager_:GetTaskList())) do
		if NewWarChessTaskPoolCfg[iter_30_0].type == NewChessConst.TASKTYPE.MAIN then
			table.insert(self.taskIDList_, iter_30_0)
		else
			table.insert(var_30_0, iter_30_0)
		end
	end

	for iter_30_2, iter_30_3 in pairs(var_30_0) do
		table.insert(self.taskIDList_, iter_30_3)
	end

	self.taskList_:StartScroll(#self.taskIDList_)

	if #self.taskIDList_ > 2 then
		self.taskListImg_.raycastTarget = true
		self.taskListScroll_.enabled = true
	else
		self.taskListImg_.raycastTarget = false
		self.taskListScroll_.enabled = false
	end
end

function NewWarChessHome:RefreshBuffList()
	self.buffEntityList_ = manager.NewChessManager.buffManager_:GetActiveBuffEntityList()

	self.buffList_:StartScroll(#self.buffEntityList_)
end

function NewWarChessHome:OnDiceUpdate()
	self:RefreshDiceList()
end

function NewWarChessHome:RefreshDiceList()
	self.diceDataList_ = NewWarChessData:GetDiceContinuousList()

	self.diceList_:StartScroll(#self.diceDataList_)
end

function NewWarChessHome:OnCurMovePointUpdate()
	self.curMovePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT"))

	self:RefreshMoveCost()
end

function NewWarChessHome:OnTaskUpdate()
	self:RefreshTaskList()
end

function NewWarChessHome:OnNewWarChessCameraMove(arg_36_1)
	SetActive(self.lookatBtn_.gameObject, arg_36_1)
end

function NewWarChessHome:OnBehind()
	manager.windowBar:HideBar()
end

function NewWarChessHome:OnExit()
	manager.windowBar:HideBar()
	NewWarChessData:ClearDiceContinuousList()
	self:UnBindRedPoint()
	self.taskList_:StopRender()
	self.diceList_:StopRender()
	self.buffList_:StopRender()
end

function NewWarChessHome:Dispose()
	NewWarChessHome.super.Dispose(self)

	if self.taskList_ then
		self.taskList_:Dispose()

		self.taskList_ = nil
	end

	if self.diceList_ then
		self.diceList_:Dispose()

		self.diceList_ = nil
	end

	if self.buffList_ then
		self.buffList_:Dispose()

		self.buffList_ = nil
	end

	self.clickBuffHandler_ = nil
end

return NewWarChessHome
