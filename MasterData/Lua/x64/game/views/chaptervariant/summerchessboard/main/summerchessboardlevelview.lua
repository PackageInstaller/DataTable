local SummerChessBoardLevelView = class("SummerChessBoardLevelView", ReduxView)

function SummerChessBoardLevelView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_chessSelectPopUI"
end

function SummerChessBoardLevelView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerChessBoardLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerChessBoardLevelView:InitUI()
	self:BindCfgUI()

	self.leftController_ = self.leftControllerEx_:GetController("able")
	self.rightController_ = self.rightControllerEx_:GetController("able")
	self.stateController_ = self.ControllerEx_:GetController("showState")
	self.tipsController_ = self.tipsControllerexcollection_:GetController("state")
	self.taskList_ = LuaList.New(handler(self, self.IndexTaskItem), self.uiList_, SummerChessBoardLevelTaskItem)
end

function SummerChessBoardLevelView:IndexTaskItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskDataList[arg_5_1])
end

function SummerChessBoardLevelView:AddUIListener()
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.curIndex_ <= 1 then
			return
		else
			self.curIndex_ = self.curIndex_ - 1

			self:RefreshUI()
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.curIndex_ >= #self.levelCfgList_ then
			return
		else
			self.curIndex_ = self.curIndex_ + 1

			self:RefreshUI()
		end
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_9_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()

		if var_9_0 == 0 or var_9_0 == self.levelCfgList_[self.curIndex_] then
			self.params_.selectLevelID = self.levelCfgList_[self.curIndex_]

			ChessBoardTools.EnterChessMap(self.levelCfgList_[self.curIndex_])
		else
			ChessBoardTools.ChessBoardMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CHESSBOARD_ENTER_NEW_MAP"), GetI18NText(ChessBoardLevelCfg[var_9_0].name_level)),
				OkCallback = function()
					self.params_.selectLevelID = self.levelCfgList_[self.curIndex_]

					ChessBoardTools.EnterChessMap(self.levelCfgList_[self.curIndex_])
				end
			})
		end
	end)
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SummerChessBoardLevelView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.activityName_.text = ActivityCfg[self.activityID_].remark
	self.levelCfgList_ = ChessBoardLevelCfg.get_id_list_by_activity[self.activityID_]

	self:DefaultSelect()
	self:RefreshUI()
end

function SummerChessBoardLevelView:DefaultSelect()
	local var_13_0 = self.params_.selectLevelID or 0

	if var_13_0 ~= 0 then
		local var_13_1 = table.indexof(self.levelCfgList_, var_13_0)

		if var_13_1 then
			self.curIndex_ = var_13_1

			return
		end
	end

	self.curIndex_ = #self.levelCfgList_

	local var_13_2 = false

	for iter_13_0, iter_13_1 in ipairs(self.levelCfgList_ or {}) do
		if iter_13_1 == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
			self.curIndex_ = iter_13_0
			var_13_2 = true

			break
		end
	end

	if not var_13_2 then
		for iter_13_2, iter_13_3 in ipairs(self.levelCfgList_ or {}) do
			if not self:CheckIsFinishLevel(iter_13_3) then
				self.curIndex_ = iter_13_2

				break
			end
		end
	end

	if self.curIndex_ == nil then
		self.curIndex_ = 1
	end
end

function SummerChessBoardLevelView:OnTop()
	JumpTools.RefreshGaussianBg()
	manager.windowBar:HideBar()
end

function SummerChessBoardLevelView:OnExit()
	manager.windowBar:HideBar()
end

function SummerChessBoardLevelView:OnExitInput()
	JumpTools.Back()

	return true
end

function SummerChessBoardLevelView:RefreshUI()
	self.levelName_.text = ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].name_level
	self.levelImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_ChessBoard/" .. ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].background_level)

	if self.curIndex_ <= 1 then
		self.leftController_:SetSelectedState("false")
		self.rightController_:SetSelectedState("true")
	elseif self.curIndex_ >= #self.levelCfgList_ then
		self.leftController_:SetSelectedState("true")
		self.rightController_:SetSelectedState("false")
	else
		self.leftController_:SetSelectedState("true")
		self.rightController_:SetSelectedState("true")
	end

	self:RefreshTaskUI()
end

function SummerChessBoardLevelView:RefreshTaskUI()
	self.taskDataList = SummerChessBoardData:CallFun("GetTaskIDListInLevelID", self.activityID_, SummerChessBoardTools.GetTaskIDByChessBoardID(self.activityID_), self.levelCfgList_[self.curIndex_])

	self.taskList_:StartScroll(#self.taskDataList)

	local var_18_0 = HistoryData:GetHistoryData(tonumber(ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].unlock_condition))
	local var_18_1 = 0

	if ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].eventpool_id > 0 and ChessBoardEventPoolCfg[ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].eventpool_id] ~= nil then
		for iter_18_0, iter_18_1 in pairs(ChessBoardEventPoolCfg[ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].eventpool_id].player_params) do
			if iter_18_1[1] == 10001 then
				var_18_1 = iter_18_1[2]
			end
		end
	end

	if var_18_1 > 0 then
		if PlayerData:GetStoryList()[var_18_1] == true then
			self.stateController_:SetSelectedState("normal")

			if self.levelCfgList_[self.curIndex_] == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
				self.tipsController_:SetSelectedState("playing")
			elseif self:CheckIsFinishLevel(self.levelCfgList_[self.curIndex_]) then
				self.tipsController_:SetSelectedState("finish")
			else
				self.tipsController_:SetSelectedState("empty")
			end
		elseif ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].unlock_condition == 0 or var_18_0 then
			self.stateController_:SetSelectedState("normal")

			if self.levelCfgList_[self.curIndex_] == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
				self.tipsController_:SetSelectedState("playing")
			elseif self:CheckIsFinishLevel(self.levelCfgList_[self.curIndex_]) then
				self.tipsController_:SetSelectedState("finish")
			else
				self.tipsController_:SetSelectedState("empty")
			end
		else
			self.stateController_:SetSelectedState("lock")
			self.tipsController_:SetSelectedState("lock")

			self.lockdescText_.text = ConditionCfg[tonumber(ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].unlock_condition)].desc

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.unlockContentTrans_)
		end
	elseif ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].unlock_condition == 0 or var_18_0 then
		self.stateController_:SetSelectedState("normal")

		if self.levelCfgList_[self.curIndex_] == ChessBoardData:GetCurrentPlayingChessBoardLevelID() then
			self.tipsController_:SetSelectedState("playing")
		elseif self:CheckIsFinishLevel(self.levelCfgList_[self.curIndex_]) then
			self.tipsController_:SetSelectedState("finish")
		else
			self.tipsController_:SetSelectedState("empty")
		end
	else
		self.stateController_:SetSelectedState("lock")
		self.tipsController_:SetSelectedState("lock")

		self.lockdescText_.text = ConditionCfg[tonumber(ChessBoardLevelCfg[self.levelCfgList_[self.curIndex_]].unlock_condition)].desc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.unlockContentTrans_)
	end
end

function SummerChessBoardLevelView:CheckIsFinishLevel(arg_19_1)
	for iter_19_0, iter_19_1 in pairs((SummerChessBoardData:CallFun("GetTaskIDListInLevelID", self.activityID_, SummerChessBoardTools.GetTaskIDByChessBoardID(self.activityID_), arg_19_1))) do
		if AssignmentCfg[iter_19_1].need > TaskData2:GetTask(iter_19_1).progress then
			return false
		end
	end

	return true
end

function SummerChessBoardLevelView:Dispose()
	if self.taskList_ then
		self.taskList_:Dispose()

		self.taskList_ = nil
	end

	self.super.Dispose(self)
end

return SummerChessBoardLevelView
