local BaseSignPage = class("BaseSignPage", ReduxView)

function BaseSignPage:AutoGetReward()
	return
end

function BaseSignPage:SetActive(arg_2_1)
	SetActive(self.gameObject_, arg_2_1)

	if arg_2_1 then
		self:OnShow()
	else
		self:OnHide()
	end
end

function BaseSignPage:OnShow()
	return
end

function BaseSignPage:OnHide()
	return
end

return BaseSignPage
