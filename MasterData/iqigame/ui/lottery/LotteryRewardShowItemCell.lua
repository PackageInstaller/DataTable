-- chunkname: @IQIGame\\UI\\Lottery\\LotteryRewardShowItemCell.lua

local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnTipsClick()
		if self.showTipsItemCid ~= nil then
			local itemData = ItemData.CreateByCIDAndNumber(self.showTipsItemCid, 0)

			ItemModule.OpenTipByData(itemData, true, true)
		end
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnTipsClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnTipsClick)
end

function m:SetData(itemData)
	self.showTipsItemCid = nil
	self.itemData = itemData
	self.itemCfg = CfgItemTable[self.itemData.srcId]
	self.isHeroType = self.itemCfg.ItemTypes == Constant.ItemType.Hero
	self.isSkillType = self.itemCfg.ItemTypes == Constant.ItemType.Skill
	self.isDestinyseatType = self.itemCfg.ItemTypes == Constant.ItemType.Item and self.itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Item].LifeCore
	self.showTipsItemCid = self.itemCfg.Id

	self:RefreshShow()
end

function m:RefreshShow()
	LuaUtility.SetGameObjectShow(self.CommonItem, self.isHeroType or self.isSkillType)
	LuaUtility.SetGameObjectShow(self.DebrisItem, false)
	LuaUtility.SetGameObjectShow(self.RepeatItem, self.isDestinyseatType)
	LuaUtility.SetGameObjectShow(self.heroRepeatItem, false)
	LuaUtility.SetGameObjectShow(self.heroDebrisItem, false)
	LuaUtility.SetGameObjectShow(self.skillMask, self.isSkillType)
	LuaUtility.SetGameObjectShow(self.Tag, self.itemData.itemShowPODs[1].tag == 1)
	LuaUtility.SetGameObjectShow(self.HeroImg, self.isHeroType)
	LuaUtility.SetGameObjectShow(self.SkillImg, not self.isHeroType)
	LuaUtility.SetGameObjectShow(self.HeroElement, self.isHeroType)
	LuaUtility.SetGameObjectShow(self.HeroPerofession, self.isHeroType)

	if self.isHeroType then
		self:RefreshHeroData()
	elseif self.isSkillType then
		self:RefreshItemData()
	end

	if self.itemCfg.Quality >= 5 then
		coroutine.start(function()
			coroutine.wait(CfgUtil.publicParametersData.lotteryResultGlodBoxTime)
			self:PlaySSREffect()
		end)
	end
end

function m:RefreshHeroData()
	self.showTipsItemCid = nil

	local herocid = self.itemCfg.ActionParams[1]
	local herocfg = CfgHeroTable[herocid]
	local path = SkinModule.GetHeroDefaultSkinImgPath(herocid, Constant.SkinImageType.HeroLotteryResources)

	self:LoadImg(path, self.HeroImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.RoleElement), herocfg.Elements), self.HeroElement:GetComponent("Image"))
	LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.LotteryQuality), herocfg.Quality), self.HeroFrame:GetComponent("Image"))

	path = LotteryUIApi:GetHeroProfessionImg(2, herocfg.Profession)

	self:LoadImg(path, self.HeroPerofession:GetComponent("Image"))
	UGUIUtil.SetText(self.HeroName, herocfg.Name)
	self.HeroStar:GetComponent("SimpleStarComponent"):UpdateView(herocfg.Quality, 0)

	local itemShowPODs = self.itemData.itemShowPODs

	if self.itemData.srcId ~= self.itemData.itemShowPODs[1].cid then
		LuaUtility.SetGameObjectShow(self.heroRepeatItem, true)
		self:RefreshRepeatInfo()
	end
end

function m:RefreshItemData()
	LuaUtility.SetText(self.HeroName, self.itemCfg.Name)
	LuaUtility.LoadImage(self, string.format(CfgUtil.GetCfgResourceUrl(Constant.Resource.LotteryQuality), self.itemCfg.Quality), self.HeroFrame:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.BigIcon), self.SkillImg:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.SkillImg)
	end)
	self.HeroStar:GetComponent("SimpleStarComponent"):UpdateView(self.itemCfg.Quality, 0)
end

function m:RefreshRepeatInfo()
	local repeatItemCfg = CfgItemTable[self.itemData.itemShowPODs[1]]

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(repeatItemCfg.Icon), self.RepeatIImg:GetComponent("Image"))
	LuaUtility.SetText(self.repeatHeroNameText, repeatItemCfg.Name)
	UGUIUtil.SetText(self.heroRepeatNumText, self.itemData.itemShowPODs[1].num)
end

function m:PlaySSREffect()
	if not self.effectSSR then
		local effectObject = GameObject.Instantiate(self.mainView.effectSSRResult, self.View.transform)

		LuaUtility.SetAnchoredPositionWithRectTransform(effectObject.transform:GetComponent("RectTransform"), 0, 0)
		LuaUtility.SetGameObjectShow(effectObject, false)
		LuaUtility.SetGameObjectShow(effectObject, true)

		self.effectSSR = effectObject
	else
		LuaUtility.SetGameObjectShow(self.effectSSR, true)
	end
end

function m:ShowEffect(quality)
	return
end

function m:StopEffect()
	return
end

function m:LoadImg(path, imgcom)
	AssetUtil.LoadImage(self, path, imgcom, self.LoadImageSucessCallBack, nil, imgcom)
end

function m:LoadImageSucessCallBack(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:SetItemRotation()
	local z = math.random(-10, 10)

	self.View.transform.localRotation = Quaternion.Euler(0, 0, z)
end

function m:RefreshItemRotation()
	self.View.transform.localRotation = Quaternion.Euler(0, 0, 0)
end

function m:Show()
	self.View:SetActive(true)
	LuaUtility.PlayDoTweenWithGameObject(self.ContentParent)
end

function m:Hide()
	self.View:SetActive(false)

	if self.effectSSR then
		LuaUtility.SetGameObjectShow(self.effectSSR, false)
	end
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
