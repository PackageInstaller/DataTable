local IlluServantManualItem = class("IlluServantManualItem", ReduxView)

function IlluServantManualItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluServantManualItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluServantManualItem:InitUI()
	self:BindCfgUI()

	self.iconImg_.immediate = true
	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
	self.raceController_ = ControllerUtil.GetController(self.transform_, "race")
	self.rareController_ = ControllerUtil.GetController(self.transform_, "rare")
end

function IlluServantManualItem:RefreshUI(arg_4_1)
	self.info_ = arg_4_1
	self.ID_ = arg_4_1.id
	self.nameText_.text = GetI18NText(arg_4_1.name)
	self.iconImg_.spriteSync = "TextureConfig/WeaponServant/IlluServant/" .. self.ID_

	if arg_4_1.isUnlock then
		self.controller_:SetSelectedState("unlock")

		self.view_ = IllustratedData:GetIsView(self.ID_, 3)

		manager.redPoint:SetRedPointIndependent(self.transform_, self.view_ == 0)
	else
		self.controller_:SetSelectedState("lock")
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end

	self.raceController_:SetSelectedState(WeaponServantCfg[self.ID_].race)
	self.rareController_:SetSelectedState(WeaponServantCfg[self.ID_].starlevel)
end

function IlluServantManualItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.info_.isUnlock and self.view_ == 0 then
			IllustratedAction.ViewIllustration(self.ID_, CollectConst.SERVANT)
		end

		self:Go("/showServantView", {
			stage = 5,
			state = "onlydetail",
			id = self.ID_
		})
	end)
end

function IlluServantManualItem:Dispose()
	IlluServantManualItem.super.Dispose(self)
end

return IlluServantManualItem
