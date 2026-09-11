local TrainInfoPropertyItem = class("TrainInfoPropertyItem", ReduxView)

function TrainInfoPropertyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function TrainInfoPropertyItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()
end

function TrainInfoPropertyItem:AddUIListener()
	return
end

function TrainInfoPropertyItem:SetData(arg_4_1, arg_4_2)
	if self.animator_ then
		self.animator_.enabled = false

		SetActive(self.effectGo_, false)
	end

	self.value_.text = arg_4_1
	self.total_.text = "/" .. arg_4_2
	self.bar_.value = arg_4_1 / arg_4_2
end

function TrainInfoPropertyItem:PlayAddAnim()
	if self.animator_ then
		self.animator_.enabled = false
		self.animator_.enabled = true
	end
end

function TrainInfoPropertyItem:Dispose()
	TrainInfoPropertyItem.super.Dispose(self)
end

return TrainInfoPropertyItem
