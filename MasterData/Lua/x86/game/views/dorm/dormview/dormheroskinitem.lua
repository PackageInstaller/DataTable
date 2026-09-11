local DormHeroSkinItem = class("DormHeroSkinItem", ReduxView)

function DormHeroSkinItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormHeroSkinItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController = ControllerUtil.GetController(self.transform_, "name")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function DormHeroSkinItem:AddUIListener()
	self.onClickCom_ = self:FindCom("OnClickDownListener")

	self.onClickCom_.onValueChanged:AddListener(function()
		if self.hasFlag then
			if self.clickFunc then
				self.clickFunc(self.skinID)
			end
		else
			ShowTips(string.format(GetTips("DORM_HERO_SKIN_NULL"), SkinCfg[self.skinID].name))
		end
	end)
end

function DormHeroSkinItem:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self.skinID = arg_5_1
	self.iconImg_.sprite = DormHeroTools.GetBackHomeHeroSkinIcon(arg_5_1)
	self.skinName.text = SkinCfg[arg_5_1].name

	self.selectController:SetSelectedState("normal")

	if DormHeroTools:isUnlock(self.skinID) then
		self.hasFlag = true

		if DormData:GetHeroTemplateInfo(arg_5_2):GetHeroCurSkinID(arg_5_2) == self.skinID then
			self.stateController:SetSelectedState("using")
		else
			self.stateController:SetSelectedState("normal")
		end

		if arg_5_1 == arg_5_3 then
			self.selectController:SetSelectedState("select")
		end
	else
		self.hasFlag = false

		self.stateController:SetSelectedState("lock")
	end
end

function DormHeroSkinItem:RegisterClickCallBack(arg_6_1)
	if arg_6_1 then
		self.clickFunc = arg_6_1
	end
end

function DormHeroSkinItem:Dispose()
	self.onClickCom_.onValueChanged:RemoveAllListeners()
	DormHeroSkinItem.super.Dispose(self)
end

return DormHeroSkinItem
