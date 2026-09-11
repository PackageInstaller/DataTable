local CultureGravureEquipPopView = class("CultureGravureEquipPopView", ReduxView)

function CultureGravureEquipPopView:UIName()
	return "Widget/System/Hero/HeroCultureGravurepopUI"
end

function CultureGravureEquipPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CultureGravureEquipPopView:Init()
	self:InitUI()
	self:AddListeners()

	self.equipPreviewList_ = LuaList.New(handler(self, self.IndexItem), self.previewListGo_, CultureGravureEquipPopItem)
end

function CultureGravureEquipPopView:InitUI()
	self:BindCfgUI()
end

function CultureGravureEquipPopView:AddListeners()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		if self.params_.index and self.params_.index ~= 0 then
			if CultureGravureAction.EquipByEquiptID(self.heroId_, self.selectId_) then
				self:UpdateData(self.params_.index)
				self:Back()
				ShowTips("EQUIP_BIND")
			else
				ShowTips("ERROR_NO_EQUIP")
			end
		else
			CultureGravureAction.EquipByList(self.heroId_, self.params_.recommendIdList)
			self:Back()
		end
	end)
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function CultureGravureEquipPopView:OnEnter()
	self.heroId_ = self.params_.heroId
	self.stateList_ = self.params_.stateList
	self.equiptDataList_ = {}

	self:UpdateData(self.params_.index)
	self.equipPreviewList_:StartScroll(#self.equiptDataList_)
end

function CultureGravureEquipPopView:UpdateData(arg_9_1)
	local var_9_0 = HeroTools.GetHeroEquipS(self.heroId_)

	if arg_9_1 and arg_9_1 ~= 0 then
		table.insert(self.equiptDataList_, {
			equipedData = EquipData:GetEquipData(var_9_0[arg_9_1].equip_id),
			recommendData = EquipData:GetEquipData(CultureGravureAction.GetRecommendEquip(self.heroId_, self.params_.recommendIdList[arg_9_1]).id),
			state = self.stateList_[arg_9_1]
		})

		self.selectId_ = self.params_.recommendIdList[arg_9_1]
	else
		local var_9_1 = CultureGravureAction.GetRecommendEquipList(self.heroId_, self.params_.recommendIdList)

		for iter_9_0 = 1, 6 do
			table.insert(self.equiptDataList_, {
				equipedData = EquipData:GetEquipData(var_9_0[iter_9_0].equip_id),
				recommendData = EquipData:GetEquipData(var_9_1[iter_9_0].equip_id),
				state = self.stateList_[iter_9_0]
			})
		end
	end
end

function CultureGravureEquipPopView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.equiptDataList_[arg_10_1], (self.params_.index ~= 0 or nil) and (self.params_.index or arg_10_1))
end

function CultureGravureEquipPopView:Dispose()
	self.equipPreviewList_:Dispose()
	CultureGravureEquipPopView.super.Dispose(self)
end

return CultureGravureEquipPopView
