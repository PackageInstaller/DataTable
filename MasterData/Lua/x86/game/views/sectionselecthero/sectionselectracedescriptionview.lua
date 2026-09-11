local SectionSelectRaceDescriptionView = class("SectionSelectRaceDescriptionView", ReduxView)

function SectionSelectRaceDescriptionView:UIName()
	return "Widget/System/Formation/FormationGodPopUPUI"
end

function SectionSelectRaceDescriptionView:UIParent()
	return manager.ui.uiPop.transform
end

function SectionSelectRaceDescriptionView:Init()
	self:InitUI()
	self:AddListener()
end

function SectionSelectRaceDescriptionView:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function SectionSelectRaceDescriptionView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function SectionSelectRaceDescriptionView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.itemList) do
		iter_7_1:Dispose()
	end

	SectionSelectRaceDescriptionView.super.Dispose(self)
end

function SectionSelectRaceDescriptionView:OnEnter()
	self.raceID_ = self.params_.raceID
	self.sameCamp_ = self.params_.sameCamp
	self.raceIDList_ = self:GetRaceIDList()

	for iter_8_0, iter_8_1 in ipairs(self.raceIDList_) do
		if not self.itemList[iter_8_0] then
			local var_8_0 = Object.Instantiate(self.godlistnewGo_, self.contentTrs_)

			SetActive(var_8_0, true)

			self.itemList[iter_8_0] = self:GetItemClass().New(var_8_0)
		end

		self.itemList[iter_8_0]:SetData(self.raceIDList_[iter_8_0], self.raceID_ == self.raceIDList_[iter_8_0], self.sameCamp_)
	end

	self.contentTrs_.localPosition = Vector3(self.contentTrs_.localPosition.x, 0, 0)

	TimeTools.StartAfterSeconds(0.1, function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end, {})
end

function SectionSelectRaceDescriptionView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.raceIDList_[arg_10_1], self.raceID_ == self.raceIDList_[arg_10_1], self.sameCamp_)
end

function SectionSelectRaceDescriptionView:GetRaceIDList()
	local var_11_0 = clone(RaceEffectCfg.all)

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		if arg_12_0 == self.raceID_ then
			return true
		end

		if arg_12_1 == self.raceID_ then
			return false
		end

		return arg_12_0 < arg_12_1
	end)

	return var_11_0
end

function SectionSelectRaceDescriptionView:GetItemClass()
	return SectionSelectRaceDescriptionItem
end

return SectionSelectRaceDescriptionView
