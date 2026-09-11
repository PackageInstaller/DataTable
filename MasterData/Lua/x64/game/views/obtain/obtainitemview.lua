local ObtainItemView = class("ObtainItemView", ObtainBaseView)

function ObtainItemView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function ObtainItemView:Init()
	self:InitUI()
	ObtainItemView.super.Init(self)
end

function ObtainItemView:InitUI()
	self:BindCfgUI()

	self.starController_ = ControllerUtil.GetController(self.starControllerTrs_, "star")
	self.effect_ = self:FindCom("Effect_distortion_add", "", self.rareEffect_)
end

function ObtainItemView:SetInfo(arg_4_1)
	local var_4_0 = ItemCfg[arg_4_1]

	if not ItemCfg[arg_4_1] then
		return
	end

	self.iconImage_.sprite = ItemTools.getItemSprite(arg_4_1)
	self.itemName_.text = ItemTools.getItemName(arg_4_1)

	local var_4_1 = math.min(var_4_0.display_rare, 5)

	self.starController_:SetSelectedIndex(var_4_1)

	if var_4_1 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_4_1 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	local var_4_2 = var_4_0.display_rare or 0
	local var_4_3 = var_4_2 <= 3 and Color.New(0.2588235, 0.6078432, 1) or var_4_2 == 4 and Color.New(0.9333333, 0, 1) or Color.New(1, 0.7411765, 0.1764706)

	self.nameBg_.color = var_4_3
	self.effect_._MainColor = var_4_3
end

function ObtainItemView:GetTimeLineEndTime()
	return 0.8
end

return ObtainItemView
