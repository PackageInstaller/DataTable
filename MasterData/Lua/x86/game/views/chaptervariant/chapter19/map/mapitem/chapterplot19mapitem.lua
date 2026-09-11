local ChapterPlot19MapItem = class("ChapterPlot19MapItem", ReduxView)

function ChapterPlot19MapItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_1), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.stateController_ = self.controllerEx_:GetController("break")
	self.fogController_ = self.controllerEx_:GetController("smoke")
	self.lineController_ = self.controllerEx_:GetController("line")

	if self.animator_ then
		self.animator_.enabled = false
	end
end

function ChapterPlot19MapItem:Dispose()
	ChapterPlot19MapItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterPlot19MapItem:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function ChapterPlot19MapItem:PlayAnimator(arg_4_1)
	if arg_4_1 then
		self.mainAnimator_:Play("operation_bg_vermap02", 0, 0)
	else
		self.mainAnimator_:Play("map_noise", 0, 0)
	end

	self.mainAnimator_:Update(0)
end

function ChapterPlot19MapItem:SetSelectState(arg_5_1)
	if self.stateController_ == nil then
		return
	end

	self.stateController_:SetSelectedIndex(arg_5_1)
end

function ChapterPlot19MapItem:SetFogState(arg_6_1)
	if self.fogController_ == nil then
		return
	end

	if arg_6_1 then
		self.fogController_:SetSelectedState("state1")
	else
		self.fogController_:SetSelectedState("state0")
	end
end

function ChapterPlot19MapItem:SetLineState(arg_7_1)
	if self.lineController_ == nil then
		return
	end

	if arg_7_1 then
		self.lineController_:SetSelectedState("state0")
	else
		self.lineController_:SetSelectedState("state1")
	end
end

function ChapterPlot19MapItem:PlayFogAnimator()
	if self.animator_ then
		self.animator_.enabled = true
	end
end

return ChapterPlot19MapItem
