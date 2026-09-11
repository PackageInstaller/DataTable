local CultureGravureAstroItem = class("CultureGravureAstroItem", ReduxView)

function CultureGravureAstroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureAstroItem:Init()
	self:InitUI()
	self:AddListeners()

	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.astroItems = {}

	for iter_2_0 = 1, 3 do
		self.astroItems[iter_2_0] = CultureGravureRecommendAstroItem.New(self["astro_" .. iter_2_0])
	end
end

function CultureGravureAstroItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.data_ = arg_3_2
	self.rate_ = arg_3_2.rate
	self.heroID_ = arg_3_3
	self.astroDataList_ = arg_3_2.list

	self:RefreshUI()
end

function CultureGravureAstroItem:AddListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		local var_5_0, var_5_1 = CultureGravureData:GetHasUnlockAllAstro(self.heroID_, self.astroDataList_)
		local var_5_2 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE)

		if not var_5_2 then
			JumpTools.OpenPageByJump("/astrolabeAdjust", {
				isEnter = true,
				heroId = self.heroID_,
				selectPos = {
					table.indexof(HeroCfg[self.heroID_].astrolabe, HeroAstrolabeCfg[var_5_1].hero_astrolabe_suit_id),
					HeroAstrolabeCfg[var_5_1].pos
				}
			})
		else
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.HERO_ASTROLABE, var_5_2))
		end
	end)
	self:AddBtnListener(self.equipBtn_, nil, function()
		AstrolabeAction.AstrolabeEquipByList(self.heroID_, self.astroDataList_)
	end)
end

function CultureGravureAstroItem:InitUI()
	self:BindCfgUI()
end

function CultureGravureAstroItem:SetClickCallBack(arg_8_1)
	self.callback = arg_8_1
end

function CultureGravureAstroItem:RefreshUI()
	self.rateText_.text = math.floor(self.rate_ / 100)

	self:RefreshAstroItem()
	self:RefreshState()
end

function CultureGravureAstroItem:RefreshAstroItem()
	for iter_10_0, iter_10_1 in ipairs(self.astroItems) do
		iter_10_1:SetData(iter_10_0, self.astroDataList_[iter_10_0], self.heroID_)
		iter_10_1:SetClickCallBack(self.callback, self.rightTrans_)
	end
end

function CultureGravureAstroItem:RefreshState()
	if CultureGravureData:GetHasEquippedAllAstro(self.heroID_, self.astroDataList_) then
		self.btnController_:SetSelectedState("equip")
	elseif CultureGravureData:GetHasUnlockAllAstro(self.heroID_, self.astroDataList_) then
		self.btnController_:SetSelectedState("had")
	else
		self.btnController_:SetSelectedState("get")
	end
end

function CultureGravureAstroItem:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.astroItems) do
		iter_12_1:Dispose()
	end

	self.astroItems = nil

	CultureGravureAstroItem.super.Dispose(self)
end

return CultureGravureAstroItem
