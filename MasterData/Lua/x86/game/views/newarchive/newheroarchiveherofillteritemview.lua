local NewHeroArchiveHeroFillterItemView = class("NewHeroArchiveHeroFillterItemView", ReduxView)

function NewHeroArchiveHeroFillterItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function NewHeroArchiveHeroFillterItemView:Init()
	self:InitUI()
end

function NewHeroArchiveHeroFillterItemView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function NewHeroArchiveHeroFillterItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			if self.lock_ then
				if self.type_ == 1 then
					ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_RACE"))
				elseif self.type_ == 2 then
					ShowTips(GetTips("HERO_HEART_CHAIN_SUPER_PLOT_UNLOCK_RACE"))
				end

				return
			end

			self.clickHandler_(self.id_, self.index)
		end
	end)
end

function NewHeroArchiveHeroFillterItemView:SetClickCallBack(arg_6_1)
	self.clickHandler_ = arg_6_1
end

function NewHeroArchiveHeroFillterItemView:OnTop()
	return
end

function NewHeroArchiveHeroFillterItemView:SetData(arg_8_1, arg_8_2)
	self.data_ = arg_8_1
	self.id_ = arg_8_1.id
	self.index_ = arg_8_2

	self:RefreshUI(1)
end

function NewHeroArchiveHeroFillterItemView:ResetData()
	self.data_ = nil
end

function NewHeroArchiveHeroFillterItemView:RefreshUI(arg_10_1, arg_10_2)
	local var_10_0

	self.type_ = arg_10_1

	if arg_10_1 == 1 then
		var_10_0 = ArchiveData:GetContinuousHeartArchiveListByType(self.id_)
	elseif arg_10_1 == 2 then
		var_10_0 = ArchiveData:GetContinuousSuperHeartArchiveListByType(self.id_)
	end

	if table.isEmpty(var_10_0) then
		self.stateController:SetSelectedState("lock")

		self.lock_ = true
	elseif self.index_ == arg_10_2 then
		self.stateController:SetSelectedState("selected")

		self.lock_ = false
	elseif self.index_ ~= arg_10_2 then
		self.stateController:SetSelectedState("unselected")

		self.lock_ = false
	end

	self.img_.sprite = getSprite("Atlas/CampItemAtlas", self.data_.icon)
end

function NewHeroArchiveHeroFillterItemView:OnExit()
	return
end

function NewHeroArchiveHeroFillterItemView:Dispose()
	NewHeroArchiveHeroFillterItemView.super.Dispose(self)
end

return NewHeroArchiveHeroFillterItemView
