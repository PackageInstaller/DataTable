local BilliardGameHeroBuffItem = class("BilliardGameHeroBuffItem", ReduxView)

function BilliardGameHeroBuffItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameHeroBuffItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.buffController_ = self.buffControllerEx_:GetController("bufficon")
end

function BilliardGameHeroBuffItem:AddUIListener()
	return
end

function BilliardGameHeroBuffItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function BilliardGameHeroBuffItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = BilliardBuffCfg[arg_5_2]

	if arg_5_3 > 0 then
		SetActive(self.buffTimeGo_, true)

		self.buffTimeText_.text = arg_5_3
	else
		SetActive(self.buffTimeGo_, false)
	end

	self.buffImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_SummerPub/BilliardGame/buff/" .. var_5_0.buff_icon)
	self.buffNameText_.text = var_5_0.name
	self.buffDescText_.text = var_5_0.buff_desc

	if var_5_0.is_debuff == 1 then
		self.buffController_:SetSelectedIndex(1)
	else
		self.buffController_:SetSelectedIndex(0)
	end
end

function BilliardGameHeroBuffItem:Dispose()
	BilliardGameHeroBuffItem.super.Dispose(self)
end

return BilliardGameHeroBuffItem
