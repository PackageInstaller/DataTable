local ObtainSkinView = class("ObtainSkinView", ObtainBaseView)

function ObtainSkinView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform
end

function ObtainSkinView:Init()
	self:InitUI()
	ObtainSkinView.super.Init(self)
end

function ObtainSkinView:InitUI()
	self:BindCfgUI()

	self.dlcImg_.immediate = true
	self.portrait_.immediate = true
	self.AdaptImg_ = self:FindCom("AdaptImage", nil, self.portrait_.transform)
end

function ObtainSkinView:SetInfo(arg_4_1, arg_4_2)
	local var_4_0 = SkinCfg[arg_4_1] or SkinCfg[ItemCfg[arg_4_1].param[1]]

	self.obtainsParams_ = arg_4_2

	local var_4_1 = ShopTools.GetGoodsIdBySkinId(arg_4_1)

	if HeroTools.GetHasOwnedSkin(var_4_0.id) then
		self.limitTimeText_.text = GetTips("ALREADY_GET")
	elseif ItemCfg[arg_4_1].time then
		self.limitTimeText_.text = string.format(GetTips("SKIN_LIMIT_TIME"), ItemCfg[arg_4_1].time[2][1])
	end

	SetActive(self.limitTimeGo_, ItemCfg[arg_4_1].time ~= nil)
	SetActive(self.dlcGo_, self.obtainsParams_.HasDlc)

	if self.obtainsParams_.HasDlc then
		local var_4_2
		local var_4_3 = HomeSceneSettingCfg[self.obtainsParams_.dlcCfg.param[1]]
		local var_4_4 = HomeSceneSettingData:GetUsedState(HomeSceneSettingCfg[self.obtainsParams_.dlcCfg.param[1]].id) == SceneConst.HOME_SCENE_TYPE.UNLOCK

		if var_4_4 then
			self.leftTimeText_.text = GetTips("ALREADY_GET")
		elseif self.obtainsParams_.dlcCfg.time then
			var_4_2 = string.format(GetTips("SKIN_LIMIT_TIME"), self.obtainsParams_.dlcCfg.time[2][1])
			self.leftTimeText_.text = var_4_2
		end

		self.dlcNameText_.text = GetI18NText(self.obtainsParams_.dlcCfg.name)
		self.dlcImg_.spriteSync = "TextureConfig/Item_l/" .. var_4_3.id

		SetActive(self.leftTimeText_.gameObject, var_4_2 ~= nil)
		SetActive(self.get1content_, var_4_2 ~= nil)
		SetActive(self.dlcGo_, not var_4_4)
	end

	if not var_4_0 then
		return
	end

	self.portrait_.spriteSync = "TextureConfig/Character/Portrait/" .. var_4_0.id
	self.heroNameTxt_.text = HeroTools.GetHeroFullName(var_4_0.hero)

	self.AdaptImg_:AdaptImg()

	self.name_.text = GetI18NText(var_4_0.name)

	if var_4_1 then
		local var_4_6 = getShopCfg(var_4_1)

		if var_4_6.give_back_list and #var_4_6.give_back_list > 0 and self.obtainsParams_.isBuy then
			SetActive(self.itemGo_, true)
		else
			SetActive(self.itemGo_, false)

			return
		end

		self.itemNameTxt_.text = ItemTools.getItemName(var_4_6.give_back_list[1].id) .. "x" .. var_4_6.give_back_list[1].num
		self.itemIcon_.sprite = ItemTools.getItemSprite(var_4_6.give_back_list[1].id)
	else
		SetActive(self.itemGo_, false)
	end
end

function ObtainSkinView:GetTimeLineEndTime()
	return 6.27
end

function ObtainSkinView:Hide()
	ObtainSkinView.super.Hide(self)

	self.portrait_.sprite = nil
end

return ObtainSkinView
