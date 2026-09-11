local ObtainBaseView = class("ObtainBaseView", BaseView)

function ObtainBaseView:Init()
	return
end

function ObtainBaseView:OnClick()
	if not self.playableDirector_ then
		return true
	end

	if self.playableDirector_.time == 0 or self.playableDirector_.time >= self:GetTimeLineEndTime() then
		return true
	else
		self.playableDirector_.time = self:GetTimeLineEndTime()

		self.playableDirector_:Evaluate()

		return false
	end
end

function ObtainBaseView:Skip2End()
	if self.playableDirector_ then
		self.playableDirector_.time = self:GetTimeLineEndTime()
	end
end

function ObtainBaseView:HideShareUI(arg_4_1)
	if self.rebateGo_ then
		SetActive(self.rebateGo_, false)
	end
end

function ObtainBaseView:ShowShareUI(arg_5_1)
	if self.rebateGo_ and arg_5_1.draw_rebate and arg_5_1.draw_rebate ~= 0 then
		SetActive(self.rebateGo_, true)
	end
end

function ObtainBaseView:Show(arg_6_1, arg_6_2)
	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	if self.playableDirector_ then
		self.playableDirector_:Evaluate()
		self.playableDirector_:Play()
	end

	self:SetInfo(arg_6_1.id, arg_6_2)
end

function ObtainBaseView:Hide()
	if self.gameObject_ then
		SetActive(self.gameObject_, false)
	end
end

function ObtainBaseView:SetInfo()
	return
end

function ObtainBaseView:GetTimeLineEndTime()
	return 0
end

function ObtainBaseView:OnObtainHeroMovieAnimtionEvent()
	return
end

function ObtainBaseView:NeedHandleInput()
	return false
end

function ObtainBaseView:NeedHideShare()
	return false
end

function ObtainBaseView:NeedGaussianBg()
	return false
end

return ObtainBaseView
