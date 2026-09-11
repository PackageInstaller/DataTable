local EquipBreakThroughMaterialTaskView = class("EquipBreakThroughMaterialTaskView", ReduxView)

function EquipBreakThroughMaterialTaskView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapScoreExchangeUI"
end

function EquipBreakThroughMaterialTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipBreakThroughMaterialTaskView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.receiveAllBtn_.transform, "name")
	self.taskList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, EquipBreakThroughMaterialTaskItem)
	self.updateHandler_ = handler(self, self.UpdateBreakThroughData)
	self.receiveHandler_ = handler(self, self.RefreshUI)
end

function EquipBreakThroughMaterialTaskView:OnEnter()
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, self.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_REWARD, self.receiveHandler_)
	self:RefreshUI()
end

function EquipBreakThroughMaterialTaskView:OnExit()
	self:StopTimer()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, self.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_REWARD, self.receiveHandler_)
end

function EquipBreakThroughMaterialTaskView:Dispose()
	EquipBreakThroughMaterialTaskView.super.Dispose(self)
	self.taskList_:Dispose()

	self.taskList_ = nil
	self.updateHandler_ = nil
	self.receiveHandler_ = nil
end

function EquipBreakThroughMaterialTaskView:AddListeners()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		if #EquipBreakThroughMaterialData:GetCanReceiveList() <= 0 then
			return
		end

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

function EquipBreakThroughMaterialTaskView:ClickItem()
	EquipBreakThroughMaterialAction.SendReceiveReward(EquipBreakThroughMaterialData:GetCanReceiveList(), function(arg_11_0)
		self:RefreshUI()
	end)
end

function EquipBreakThroughMaterialTaskView:RefreshUI()
	if #EquipBreakThroughMaterialData:GetCanReceiveList() > 0 then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end

	self.taskList_:StartScroll(#EquipBreakThroughMaterialTaskCfg.all)

	self.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	self:AddTimer()
end

function EquipBreakThroughMaterialTaskView:RefreshItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(EquipBreakThroughMaterialData:GetSortRewardList()[arg_13_1])
end

function EquipBreakThroughMaterialTaskView:UpdateBreakThroughData()
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function EquipBreakThroughMaterialTaskView:AddTimer()
	self:StopTimer()

	local var_15_0 = EquipBreakThroughMaterialData:GetRefreshTimestamp()

	self.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_15_0))
	self.timer_ = Timer.New(function()
		self.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(var_15_0))
	end, 1, -1)

	self.timer_:Start()
end

function EquipBreakThroughMaterialTaskView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return EquipBreakThroughMaterialTaskView
