local CommonFilterBottom = class("CommonFilterBottom", ReduxView)

function CommonFilterBottom:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonFilterBottom:Init()
	self:InitUI()
	self:AddListeners()
end

function CommonFilterBottom:InitUI()
	self:BindCfgUI()

	self.emptyController_ = self.emptyCon_:GetController("empty")
	self.filterItmeList_ = {}
end

function CommonFilterBottom:Refresh(arg_4_1)
	self.filterInfoList_ = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(self.filterInfoList_) do
		local var_4_0 = self.filterItmeList_[iter_4_0]

		if self.filterItmeList_[iter_4_0] == nil then
			var_4_0 = CommonFilterBottomItem.New((Object.Instantiate(self.filterItemGo_, self.filterContent_)))

			var_4_0:RegistCallBack(function(arg_5_0)
				if self.itemClickCallback then
					self.itemClickCallback(arg_5_0)
				end
			end)

			self.filterItmeList_[iter_4_0] = var_4_0
		end

		var_4_0:Refresh(iter_4_1)
	end

	for iter_4_2 = #self.filterInfoList_ + 1, #self.filterItmeList_ do
		SetActive(self.filterItmeList_[iter_4_2].gameObject_, false)
	end

	local var_4_1 = #self.filterInfoList_ == 0

	self.emptyController_:SetSelectedState(tostring(#self.filterInfoList_ == 0))
	SetActive(self.gameObject_, not var_4_1)
end

function CommonFilterBottom:AddListeners()
	self:AddBtnListener(self.clearBtn_, nil, function()
		if self.clearCallback then
			self.clearCallback()
		end
	end)
end

function CommonFilterBottom:RegisteClearBtnListener(arg_8_1)
	self.clearCallback = self.clearCallback or arg_8_1
end

function CommonFilterBottom:RegisteItemClickListener(arg_9_1)
	self.itemClickCallback = self.itemClickCallback or arg_9_1
end

function CommonFilterBottom:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.filterItmeList_) do
		iter_10_1:Dispose()
	end

	self.filterItmeList_ = nil

	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	CommonFilterBottom.super.Dispose(self)
end

return CommonFilterBottom
