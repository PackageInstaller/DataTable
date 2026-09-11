local StrongholdOperateBasePage = class("StrongholdOperateBasePage", ReduxView)

function StrongholdOperateBasePage:SetActive(arg_1_1)
	SetActive(self.gameObject_, arg_1_1)

	if arg_1_1 == self.active then
		return
	end

	self.active = arg_1_1

	if arg_1_1 then
		self:OnShow()
	else
		self:OnHide()
	end
end

function StrongholdOperateBasePage:OnShow()
	return
end

function StrongholdOperateBasePage:OnHide()
	return
end

function StrongholdOperateBasePage:Refresh(arg_4_1)
	return
end

return StrongholdOperateBasePage
