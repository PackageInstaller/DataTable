local WeaponModuleGodInfoView = class("WeaponModuleGodInfoView", ReduxView)

function WeaponModuleGodInfoView:UIName()
	return "Widget/System/Hero_module/HeroModuleGodPopUI"
end

function WeaponModuleGodInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponModuleGodInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponModuleGodInfoView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.curIndex_, getAstrolabeID(self.effectList_[arg_4_1], 0))
	arg_4_2:SetSelectCallBack(self.selectStageItemHandler_)
end

function WeaponModuleGodInfoView:InitUI()
	self:BindCfgUI()

	self.curIndex_ = 1
	self.selectStageItemHandler_ = handler(self, self.OnSelectStageItem)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, WeaponModuleGodItem)
end

function WeaponModuleGodInfoView:OnSelectStageItem(arg_6_1)
	self.curIndex_ = arg_6_1

	self.list_:Refresh()
	self:RefreshDes()
end

function WeaponModuleGodInfoView:RefreshDes()
	local var_7_0 = getAstrolabeID(self.effectList_[self.curIndex_], 0)

	self.nameText1_.text = GetI18NText(HeroAstrolabeCfg[var_7_0].suit_name) .. "·" .. GetI18NText(HeroAstrolabeCfg[var_7_0].name)
	self.nameText2_.text = GetI18NText(HeroAstrolabeCfg[var_7_0].suit_name) .. "·" .. GetI18NText(HeroAstrolabeCfg[var_7_0].name)
	self.frontDesText_.text = GetCfgDescription(AstrolabeEffectCfg[var_7_0].desc[1], 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.frontcontentTrans_)

	local var_7_1

	for iter_7_0, iter_7_1 in pairs(AstrolabeEffectCfg[var_7_0].equip_orange_desc) do
		if iter_7_1[1] == 0 and iter_7_1[3] == self.effectList_[self.curIndex_] then
			var_7_1 = iter_7_1[2]
		end
	end

	self.nextDesText_.text = GetCfgDescription(var_7_1, 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.nextcontentTrans_)
end

function WeaponModuleGodInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function WeaponModuleGodInfoView:OnEnter()
	self.effectList_ = self.params_.effectList
	self.heroID_ = self.params_.heroID
	self.curIndex_ = 1

	if #self.effectList_ > 1 then
		SetActive(self.listGo_, true)
		self.list_:StartScroll(#self.effectList_)
	else
		SetActive(self.listGo_, false)
	end

	self:RefreshDes()
end

function WeaponModuleGodInfoView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	WeaponModuleGodInfoView.super.Dispose(self)
end

return WeaponModuleGodInfoView
