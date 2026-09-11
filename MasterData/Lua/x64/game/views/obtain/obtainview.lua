local ObtainOathRingView = require("game.views.obtain.ObtainOathRingView")
local ObtainView = class("ObtainView", ReduxView)
local var_0_2 = "OBTAIN_HERO_MOVIE"

function ObtainView:OnCtor()
	self.load = {}
end

function ObtainView:UIName()
	return "Widget/System/ObtainUI/ObtainUI"
end

function ObtainView:UIParent()
	return manager.ui.uiPop.transform
end

function ObtainView:Load(arg_4_1)
	local var_4_0 = self.load[arg_4_1] or Asset.Load(arg_4_1)

	self.load[arg_4_1] = var_4_0

	return var_4_0
end

function ObtainView:Create(arg_5_1, arg_5_2, arg_5_3)
	local var_5_1
	local var_5_2

	if arg_5_1 == ItemConst.ITEM_TYPE.HERO then
		var_5_1 = arg_5_2 == 2 and "Widget/System/ObtainUI/ObtainHeroSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/ObtainHeroAUI" or "Widget/System/ObtainUI/ObtainHeroBUI"
		var_5_2 = ObtainHeroView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		var_5_1 = arg_5_2 == 2 and "Widget/System/ObtainUI/ObtainWeaponSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/ObtainWeaponAUI" or "Widget/System/ObtainUI/ObtainWeaponBUI"
		var_5_2 = ObtainWeaponView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.HERO_SKIN then
		var_5_1 = arg_5_2 == 2 and "Widget/System/ObtainUI/Skin/ObtainSkinSUI" or arg_5_2 == 1 and "Widget/System/ObtainUI/Skin/ObtainSkinAUI" or "Widget/System/ObtainUI/Skin/ObtainSkinBUI"
		var_5_2 = ObtainSkinView
	elseif arg_5_1 == var_0_2 then
		var_5_1 = "Widget/System/ObtainUI/HeroMovie/ObtainHeroMovieUI"
		var_5_2 = ObtainHeroMovieView
	elseif arg_5_1 == ItemConst.ITEM_TYPE.SCENE then
		var_5_1 = "Widget/System/ObtainUI/Skin/ObtainDLCUI"
		var_5_2 = ObtainDLCView
	elseif arg_5_3.sub_type == ItemConst.ITEM_SUB_TYPE.OATH_RING then
		var_5_1 = "Widget/System/Recharge/RechargeOathRingPopUI"
		var_5_2 = ObtainOathRingView
	else
		Debug.LogError("获取道具")

		var_5_1 = "Widget/System/ObtainUI/ObtainItemUI"
		var_5_2 = ObtainItemView
	end

	local var_5_3 = var_5_2.New(self:Load(var_5_1), self.content_, self.context)

	var_5_3:Init()

	return var_5_3
end

function ObtainView:Init()
	self:InitUI()
	self:AddListeners()

	self.context = {
		obtainView = self
	}
end

function ObtainView:InitUI()
	self:BindCfgUI()

	self.list = {}

	SetActive(self.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	self.showSkipHandler = handler(self, self.ShowSkipBtn)
	self.refreshShareHandler = handler(self, self.RefreshShareBtn)
end

function ObtainView:ShowSkipBtn()
	if self.goSkip_ and self.skipHandler then
		SetActive(self.goSkip_, not self:GetIsHaveUnWatchHero())
	end
end

function ObtainView:RefreshShareBtn()
	self:SetShareBtnHide(self.hideShare)
end

function ObtainView:SetShareBtnHide(arg_10_1)
	self.hideShare = arg_10_1

	SetActive(self.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG) and not arg_10_1)
end

function ObtainView:AddListeners()
	if self.maskBtn_ then
		self:AddBtnListener(self.maskBtn_, nil, handler(self, self.OnMaskBtnClick))
	end

	if self.skipBtn_ then
		self:AddBtnListener(self.skipBtn_, nil, handler(self, self.OnSkipBtnClick))
	end

	self:AddBtnListener(self.buttonShare_, nil, function()
		local var_12_0 = self.itemList[self.index]

		self.cur:Skip2End()

		if self.timer_ then
			self.timer_:Stop()
		end

		local var_12_1 = self.goShare_.activeSelf
		local var_12_2 = self.goSkip_.activeSelf

		self.timer_ = Timer.New(function()
			self.timer_:Stop()

			self.timer_ = nil

			manager.share:Share(function()
				SetActive(self.goShare_, false)
				SetActive(self.goSkip_, false)
				self.cur:HideShareUI(var_12_0)
			end, function()
				SetActive(self.goShare_, var_12_1)
				SetActive(self.goSkip_, var_12_2)
				self.cur:ShowShareUI(var_12_0)
			end, function()
				return
			end)
		end, 0.066, 1)

		self.timer_:Start()
	end)
end

function ObtainView:OnMaskBtnClick()
	if self.cur and self.cur:OnClick() then
		self:DoNext()
	end
end

function ObtainView:Back()
	ObtainView.super.Back(self)
end

function ObtainView:OnSkipBtnClick()
	self:Back()

	if self.skipHandler then
		self.skipHandler()
	end
end

function ObtainView:DoEnd()
	if self.index <= #self.itemList then
		self.index = #self.itemList + 1
	end

	self:DoNext()
end

function ObtainView:DoNext()
	if self.cur then
		self.cur:Hide()
	end

	self.index = self.index + 1

	if self.index > #self.itemList then
		self:Back()

		if self.doNextHandler then
			self.doNextHandler()
		end
	else
		local var_21_0 = self.itemList[self.index]
		local var_21_1

		if ItemWillConvert(self.itemList[self.index]) then
			var_21_1 = var_21_0.convert_from.id or var_21_0.id
		end

		local var_21_2 = ItemCfg[var_21_1]
		local var_21_3 = ItemCfg[var_21_1].type

		if ItemCfg[var_21_1].type ~= ItemConst.ITEM_TYPE.HERO and var_21_3 ~= ItemConst.ITEM_TYPE.WEAPON_SERVANT and var_21_3 ~= ItemConst.ITEM_TYPE.HERO_SKIN and var_21_3 ~= ItemConst.ITEM_TYPE.SCENE then
			var_21_3 = 0
		end

		if not var_21_2 then
			self:DoNext()
		else
			local var_21_5 = var_21_2.display_rare >= 5 and 2 or var_21_2.display_rare >= 4 and 1 or 0
			local var_21_6 = var_21_3 .. "_" .. (var_21_2.display_rare >= 5 and 2 or var_21_2.display_rare >= 4 and 1 or 0)

			if var_21_3 == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[var_21_1] then
				var_21_3 = var_0_2
				var_21_6 = var_0_2

				if not (getData(DrawConst.WATCH_TAG, tostring(var_21_1)) or false) then
					SetActive(self.goSkip_, false)
					SetActive(self.goShare_, false)
				end
			end

			self.list[var_21_6] = self.list[var_21_6] or self:Create(var_21_3, var_21_5, var_21_2)
			self.cur = self.list[var_21_6]

			self.cur:Show(var_21_0, self.obtainsParams)
			SetActive(self.maskBtn_, not self.cur:NeedHandleInput())
			self:SetShareBtnHide(self.cur:NeedHideShare())
			manager.ui:SetUISeparateRender((self.cur:NeedGaussianBg()))
		end
	end
end

function ObtainView:SetGaussionBg(arg_22_1)
	local var_22_0 = false

	if self.cur then
		var_22_0 = self.cur:NeedGaussianBg()
	end

	ObtainView.super.SetGaussionBg(self, var_22_0)

	return var_22_0
end

function ObtainView:GetIsHaveUnWatchHero()
	if #self.itemList > 0 then
		for iter_23_0 = self.index + 1, #self.itemList do
			if ItemCfg[self.itemList[iter_23_0].id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[self.itemList[iter_23_0].id] then
				if not (getData(DrawConst.WATCH_TAG, tostring(self.itemList[iter_23_0].id)) or false) then
					return true
				end
			end
		end
	end

	return false
end

function ObtainView:OnEnter()
	self.doNextHandler = self.params_.doNextHandler
	self.skipHandler = self.params_.skipHandler
	self.itemList = self.params_.itemList
	self.skipStart = self.params_.skipStart
	self.obtainsParams = self.params_.obtainsParams
	self.index = 0

	if self.goSkip_ and self.skipHandler then
		SetActive(self.goSkip_, not self:GetIsHaveUnWatchHero())
	else
		SetActive(self.goSkip_, false)
	end

	if manager.windowBar:GetIsShow() then
		self.barList = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	else
		self.barList = nil
	end

	self:DoNext()
end

function ObtainView:OnExit()
	if self.cur then
		self.cur:Hide()

		self.cur = nil
	end

	if self.barList then
		manager.windowBar:SwitchBar(self.barList)
	end

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ObtainView:Dispose()
	for iter_26_0, iter_26_1 in pairs(self.list) do
		iter_26_1:Dispose()
	end

	self.list = {}

	for iter_26_2, iter_26_3 in pairs(self.load) do
		Asset.Unload(iter_26_2)
	end

	self.load = nil

	ObtainView.super.Dispose(self)
end

function ObtainView:OnObtainHeroMovieAnimtionEvent()
	for iter_27_0, iter_27_1 in pairs(self.list) do
		iter_27_1:OnObtainHeroMovieAnimtionEvent()
	end
end

return ObtainView
