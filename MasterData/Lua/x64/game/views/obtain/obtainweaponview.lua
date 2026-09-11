local ObtainWeaponView = class("ObtainWeaponView", ObtainBaseView)

function ObtainWeaponView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
end

function ObtainWeaponView:Init()
	self:InitUI()
	ObtainWeaponView.super.Init(self)
end

function ObtainWeaponView:InitUI()
	self:BindCfgUI()

	self.weaponImg_.immediate = true
	self.starController_ = ControllerUtil.GetController(self.starControllerTrs_, "star")
	self.AdaptImg_ = self:FindCom("AdaptImage", nil, self.weaponImg_.transform)
end

function ObtainWeaponView:Show(arg_4_1)
	self.item = arg_4_1

	local var_4_0 = arg_4_1.id

	if self.gameObject_ then
		SetActive(self.gameObject_, true)
	end

	if arg_4_1.draw_rebate and arg_4_1.draw_rebate ~= 0 then
		SetActive(self.rebateGo_, true)

		self.rebateLab_.text = "x" .. arg_4_1.draw_rebate
	else
		SetActive(self.rebateGo_, false)
	end

	if self.playableDirector_ then
		self.playableDirector_:Evaluate()
		self.playableDirector_:Play()
	end

	self:SetInfo(var_4_0)
end

function ObtainWeaponView:SetInfo(arg_5_1)
	if not ItemCfg[arg_5_1] or not WeaponServantCfg[arg_5_1] then
		return
	end

	self.weaponImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. arg_5_1

	self.AdaptImg_:AdaptImg()

	self.nameText_.text = ItemTools.getItemName(arg_5_1)
	self.camp_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[WeaponServantCfg[arg_5_1].race].icon)

	local var_5_0 = math.min(ItemCfg[arg_5_1].display_rare, 5)

	self.starController_:SetSelectedIndex(var_5_0)

	if var_5_0 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_5_0 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end
end

function ObtainWeaponView:GetTimeLineEndTime()
	return 2.5
end

function ObtainWeaponView:Hide()
	ObtainWeaponView.super.Hide(self)

	self.weaponImg_.sprite = nil
end

return ObtainWeaponView
