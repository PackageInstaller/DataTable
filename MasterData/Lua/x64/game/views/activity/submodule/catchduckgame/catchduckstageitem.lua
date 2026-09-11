local CatchDuckStageItem = class("CatchDuckStageItem", ReduxView)

function CatchDuckStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CatchDuckStageItem:Init()
	self:InitUI()
	self:AddUIListeners()

	self.statusController_ = self.itemCon_:GetController("status")
	self.selectController_ = self.itemCon_:GetController("sel")
	self.isSelect_ = false
end

function CatchDuckStageItem:InitUI()
	self:BindCfgUI()
end

function CatchDuckStageItem:AddUIListeners()
	self:AddBtnListener(self.btnSelect_, nil, function()
		self:selectCallBack_(self.stageData_, self.index_)
	end)
end

function CatchDuckStageItem:SetSelectCallBack(arg_6_1)
	self.selectCallBack_ = arg_6_1
end

function CatchDuckStageItem:SelectItem(arg_7_1)
	self.isSelect_ = arg_7_1

	self.selectController_:SetSelectedState(self.isSelect_ and "on" or "off")
end

function CatchDuckStageItem:RefreshUI(arg_8_1, arg_8_2)
	self.statusController_:SetSelectedState(arg_8_1.isComplete and "complete" or arg_8_1.isLock and "lock" or "unlock")

	if arg_8_1.isEndless then
		if arg_8_1.score then
			self.textScore_.text = arg_8_1.score or GetTips("NO_DUCK_DATA")
		end
	end

	self.textName_.text = BattleCatchDuckStageCfg[arg_8_1.stage_id].name
	self.stageData_ = arg_8_1
	self.index_ = arg_8_2
end

function CatchDuckStageItem:RefreshSelect(arg_9_1)
	return
end

function CatchDuckStageItem:Dispose()
	CatchDuckStageItem.super.Dispose(self)
end

return CatchDuckStageItem
