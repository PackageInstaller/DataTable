local DrawRolePoolContainer = class("DrawRolePoolContainer", DrawBasePool)

function DrawRolePoolContainer:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.poolId = arg_1_2
	self.showId = arg_1_3

	self:CreatePoolGo(arg_1_1)
end

function DrawRolePoolContainer:CreatePoolGo(arg_2_1)
	if self:TryCreateOldRolePoolGo(arg_2_1) then
		return
	end

	self:TryCreateNewRolePoolGo(arg_2_1)
end

function DrawRolePoolContainer:TryCreateOldRolePoolGo(arg_3_1)
	local var_3_0 = Asset.Load("Widget/System/Pool/pool_" .. self.showId)

	if not var_3_0 then
		return false
	end

	self.poolView_ = DrawNormalSelectPool.New(GameObject.Instantiate(var_3_0, arg_3_1), self.poolId, self.showId)

	return true
end

function DrawRolePoolContainer:TryCreateNewRolePoolGo(arg_4_1)
	local var_4_0 = Asset.Load("Widget/System/Pool/pool_convention_mult")

	if not var_4_0 then
		return false
	end

	self.poolView_ = DrawRolePool.New(GameObject.Instantiate(var_4_0, arg_4_1), self.poolId, self.showId)

	return true
end

function DrawRolePoolContainer:Dispose()
	self.poolView_:Dispose()
	DrawRolePoolContainer.super.Dispose(self)
end

function DrawRolePoolContainer:Refresh(arg_6_1)
	self:CallPoolViewFunc("Refresh", arg_6_1)
end

function DrawRolePoolContainer:SetActive(arg_7_1)
	self:CallPoolViewFunc("SetActive", arg_7_1)
end

function DrawRolePoolContainer:UpdateView()
	self:CallPoolViewFunc("UpdateView")
end

function DrawRolePoolContainer:SetVideoTrack(arg_9_1, arg_9_2)
	self:CallPoolViewFunc("SetVideoTrack", arg_9_1, arg_9_2)
end

function DrawRolePoolContainer:ShowCountDownText(arg_10_1)
	self:CallPoolViewFunc("ShowCountDownText", arg_10_1)
end

function DrawRolePoolContainer:CirMovieStatusChange(arg_11_1)
	self:CallPoolViewFunc("CirMovieStatusChange", arg_11_1)
end

function DrawRolePoolContainer:SetCountDownText(arg_12_1)
	self:CallPoolViewFunc("SetCountDownText", arg_12_1)
end

function DrawRolePoolContainer:ShowRightPanel()
	return self:CallPoolViewFunc("ShowRightPanel")
end

function DrawRolePoolContainer:GetPoolId()
	return self.poolId
end

function DrawRolePoolContainer:GetShowId()
	return self.showId
end

function DrawRolePoolContainer:CallPoolViewFunc(arg_16_1, ...)
	if self.poolView_ and self.poolView_[arg_16_1] then
		return self.poolView_[arg_16_1](self.poolView_, ...)
	end
end

return DrawRolePoolContainer
