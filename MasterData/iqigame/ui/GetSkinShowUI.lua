-- chunkname: @IQIGame\\UI\\GetSkinShowUI.lua

local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local GetSkinShowUI = {
	ReplaceItemList = {}
}

GetSkinShowUI = Base:Extend("GetSkinShowUI", "IQIGame.Onigao.UI.GetSkinShowUI", GetSkinShowUI)

function GetSkinShowUI:OnInit()
	self.roleDisplayView = CommonRoleDisplayView.New(self.RoleDisplayViewRoot, Constant.DynamicSkinShowPosition.GetHero)

	function self.delegateConfirmBtnClick()
		self:OnConfirmBtnClick()
	end
end

function GetSkinShowUI:GetPreloadAssetPaths()
	return nil
end

function GetSkinShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GetSkinShowUI:IsManualShowOnOpen(userData)
	return false
end

function GetSkinShowUI:GetBGM(userData)
	return nil
end

function GetSkinShowUI:OnOpen(userData)
	self.skinCid = userData.skinCid

	local heroSkinConfig = CfgHeroSkinTable[self.skinCid]
	local heroConfig = CfgHeroTable[heroSkinConfig.HeroId]

	self:OpenHeroShow(heroConfig)
	LuaUtility.SetText(self.goHeroDesc, heroSkinConfig.SkinDesc)
	self.roleDisplayView:Show(self.skinCid)
	self:__ShowUISpine(heroSkinConfig.UIEntityID)
	self:ShowReplaceItem(userData.itemPod)
end

function GetSkinShowUI:OnClose(userData)
	self:__ReleaseUISpine()
	self:HideEffect()
end

function GetSkinShowUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.delegateConfirmBtnClick)
end

function GetSkinShowUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateConfirmBtnClick)
end

function GetSkinShowUI:OnPause()
	return
end

function GetSkinShowUI:OnResume()
	return
end

function GetSkinShowUI:OnCover()
	return
end

function GetSkinShowUI:OnReveal()
	return
end

function GetSkinShowUI:OnRefocus(userData)
	return
end

function GetSkinShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GetSkinShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GetSkinShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GetSkinShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GetSkinShowUI:OnDestroy()
	self.roleDisplayView:Dispose()
	self:__ReleaseUISpine()
	self:HideEffect()
	AssetUtil.UnloadAsset(self)
end

function GetSkinShowUI:OpenHeroShow(herocfg)
	local path = UIGlobalApi.GetImagePath(herocfg.ElementsIcon)
	local propertyImg = self.PropertyImg:GetComponent("Image")

	AssetUtil.LoadImage(self, path, propertyImg, function()
		propertyImg:SetNativeSize()
	end)

	path = LotteryUIApi:GetHeroProfessionImg(1, herocfg.Profession)

	local professionImg = self.ProfessionImg:GetComponent("Image")

	AssetUtil.LoadImage(self, path, professionImg, function()
		professionImg:SetNativeSize()
	end)
	self.heroStar:GetComponent("SimpleStarComponent"):UpdateView(herocfg.Quality, 0)
	UGUIUtil.SetText(self.goHeroName, herocfg.Name)
	UGUIUtil.SetText(self.goEnName, herocfg.EnglishName)
	self:ShowEffect(herocfg.Quality)

	if herocfg ~= nil and herocfg.Forces > 0 then
		LuaUtility.SetGameObjectShow(self.ForceImgObj, true)

		local heroForceImgPath = WarlockApi:GetForceImgPath(herocfg.Forces)

		AssetUtil.LoadImage(self, heroForceImgPath, self.ForceImgObj:GetComponent("Image"))
	else
		LuaUtility.SetGameObjectShow(self.ForceImgObj, false)
	end
end

function GetSkinShowUI:OnConfirmBtnClick()
	UIModule.Close(Constant.UIControllerName.GetSkinShowUI)
end

function GetSkinShowUI:ShowEffect(quality)
	self:HideEffect()

	local canvasSortingOrder = self.EffectPoint:GetComponent("Canvas").sortingOrder

	self.effectID = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetImgShowEffect(quality), 50000, 0, self.EffectPoint, canvasSortingOrder)
end

function GetSkinShowUI:HideEffect()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)

		self.effectID = nil
	end
end

function GetSkinShowUI:__ReleaseUISpine()
	if self.uniqueEntityID == 0 then
		return
	end

	if self.uniqueEntityID == nil then
		return
	end

	EntityUtility.HideEntityByEntityID(self.uniqueEntityID)

	self.uniqueEntityID = 0
end

function GetSkinShowUI:__ShowUISpine(uiEntityCid)
	self:__ReleaseUISpine()

	self.uniqueEntityID = EntityUtility.GetHeroUIEntityByUIEntityCid(uiEntityCid, self.SpineRoot.transform, Vector3.zero, function(_entityComponent)
		local previewSpine = _entityComponent.gameObject
		local skeletonGraphic = previewSpine:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

		skeletonGraphic:Initialize(true)
		skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
	end)
end

function GetSkinShowUI:ShowReplaceItem(itemPod)
	for i = 1, #self.ReplaceItemList do
		self.ReplaceItemList[i]:SetActive(false)
	end

	self.ReplaceParent:SetActive(true)

	local obj

	for i = 1, 1 do
		if itemPod.srcId ~= 0 and itemPod.srcId ~= nil then
			obj = self.ReplaceItemList[i]

			if obj == nil then
				obj = UnityEngine.Object.Instantiate(self.ReplaceItemPrefab)

				obj.transform:SetParent(self.ReplaceParent.transform, false)

				self.ReplaceItemList[i] = obj
			end

			obj:SetActive(true)
			self:SetReplaceItemData(obj, itemPod)
		end
	end
end

function GetSkinShowUI:SetReplaceItemData(obj, data)
	local counttext = obj.transform:Find("CountText").gameObject

	UGUIUtil.SetText(counttext, LotteryUIApi:GetRepeatText(2, data.num))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[data.cid].Icon), obj.transform:Find("Icon"):GetComponent("Image"))
end

function GetSkinShowUI:__LoadNativeSizeImg(path, imgComponent)
	AssetUtil.LoadImage(self, path, imgComponent, self.__OnLoadImageSucess, nil, {
		imgCom = imgComponent
	})
end

function GetSkinShowUI.__OnLoadImageSucess(assetName, asset, duration, userData)
	userData.imgCom.gameObject:SetActive(true)
	userData.imgCom:SetNativeSize()
end

return GetSkinShowUI
