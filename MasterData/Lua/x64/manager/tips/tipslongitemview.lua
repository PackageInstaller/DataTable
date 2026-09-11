local TipsLongItemView = class("TipsLongItemView")

function TipsLongItemView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()

	self.isFree_ = false
end

function TipsLongItemView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
end

function TipsLongItemView:IsFree()
	return self.isFree_
end

function TipsLongItemView:SetFree(arg_4_1)
	self.isFree_ = arg_4_1
end

function TipsLongItemView:RefreshUI(arg_5_1)
	self:SetFree(false)

	self.text_.text = arg_5_1

	self.transform_:SetAsLastSibling()
	self.ani_:Play("UItips", -1, 0)
	SetActive(self.gameObject_, true)
	self:EndDisplay()
end

function TipsLongItemView:EndDisplay()
	local var_6_0

	var_6_0 = LeanTween.scale(self.gameObject_, Vector3.one, 0.1):setDelay(1.1):setOnComplete(System.Action(function()
		self:FinishAction()
		var_6_0:setOnComplete(nil)
	end))
end

function TipsLongItemView:FinishAction()
	self.data_:Finish()
	SetActive(self.gameObject_, false)
end

function TipsLongItemView:FastFinish()
	LeanTween.cancel(self.gameObject_)
end

function TipsLongItemView:Dispose()
	self:FastFinish()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return TipsLongItemView
