local EquipBreakThroughMaterialTaskItem = class("EquipBreakThroughMaterialTaskItem", ReduxView)

function EquipBreakThroughMaterialTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "status")
	self.uiList_ = LuaList.New(handler(self, self.RefreshRewardItem), self.uiList_, CommonItem)
end

function EquipBreakThroughMaterialTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_REWARD_TIPS"),
				OkCallback = function()
					self:ClickItem()
				end
			})
		else
			self:ClickItem()
		end
	end)
end

function EquipBreakThroughMaterialTaskItem:ClickItem()
	EquipBreakThroughMaterialAction.SendReceiveReward({
		self.taskID_
	}, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			manager.notify:Invoke(EQUIP_BREAK_THROUGH_REWARD)
		end
	end)
end

function EquipBreakThroughMaterialTaskItem:Dispose()
	EquipBreakThroughMaterialTaskItem.super.Dispose(self)
	self.uiList_:Dispose()

	self.uiList_ = nil
end

function EquipBreakThroughMaterialTaskItem:SetData(arg_8_1)
	local var_8_0 = EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialData:GetSelectModeID()].reward_list[arg_8_1]

	self.rewardList_ = var_8_0

	self.uiList_:StartScroll(#var_8_0)

	self.descText_.text = GetI18NText(EquipBreakThroughMaterialTaskCfg[arg_8_1].des)
	self.taskID_ = arg_8_1

	self:RefreshBtn()
end

function EquipBreakThroughMaterialTaskItem:RefreshRewardItem(arg_9_1, arg_9_2)
	arg_9_2:RefreshData({
		id = self.rewardList_[arg_9_1][1],
		number = self.rewardList_[arg_9_1][2]
	})
	arg_9_2:RegistCallBack(function(arg_10_0)
		ShowPopItem(POP_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		})
	end)
end

function EquipBreakThroughMaterialTaskItem:RefreshBtn()
	local var_11_0 = EquipBreakThroughMaterialData:GetTaskList()[self.taskID_]

	if table.keyof(EquipBreakThroughMaterialData:GetReceivedList(), self.taskID_) then
		self.controller_:SetSelectedState("haveGet")
	elseif var_11_0.currentValue >= var_11_0.targetValue then
		self.controller_:SetSelectedState("canGet")
	else
		self.controller_:SetSelectedState("cannotGet")
	end
end

return EquipBreakThroughMaterialTaskItem
