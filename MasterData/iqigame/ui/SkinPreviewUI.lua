-- chunkname: @IQIGame\\UI\\SkinPreviewUI.lua

local SkinPreviewUI = {}

SkinPreviewUI = Base:Extend("SkinPreviewUI", "IQIGame.Onigao.UI.SkinPreviewUI", SkinPreviewUI)

local SkinItemCell = require("IQIGame.UI.Skin.SkinItemCell")

function SkinPreviewUI:OnInit()
	self.closeUIButton = self.CloseBtn:GetComponent("Button")
	self.centerStaticImage = self.SkinImg:GetComponent("Image")
	self.headIconImage = self.HeadImg:GetComponent("Image")
	self.ForceBgImage = self.ForceBg:GetComponent("Image")

	function self.DelegateCloseBtn()
		UIModule.CloseSelf(self)
	end

	function self.DelegateOnLoadSpineAssetSuccessCallback(owner, assetName, asset, duration, userData)
		self:LoadSpineAssetSuccessCallBack(asset)
	end
end

function SkinPreviewUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.closeUIButton = nil
	self.centerStaticImage = nil
	self.headIconImage = nil
	self.ForceBgImage = nil
	self.skeletonAnimation = nil
end

function SkinPreviewUI:OnOpen(userData)
	local staticSkinCid, spineSkinCid = self:InitializeSkinData(userData)

	if staticSkinCid == nil and spineSkinCid == nil then
		logError("SkinPreviewUI:OnOpen : userData is invalid.")
		UIModule.CloseSelf(self)

		return
	end

	self:RefreshStaticImageShow(staticSkinCid)
	self:RefreshSpineShow(spineSkinCid)
	self:RefreshOtherInfoShow(staticSkinCid ~= nil and staticSkinCid or spineSkinCid)
end

function SkinPreviewUI:OnClose(userData)
	AssetUtil.UnloadAsset(self)

	if self.curSkinItemCell ~= nil then
		self.curSkinItemCell:Dispose()

		self.curSkinItemCell = nil
	end

	self:DestroySpines()
end

function SkinPreviewUI:OnAddListeners()
	self.closeUIButton.onClick:AddListener(self.DelegateCloseBtn)
end

function SkinPreviewUI:OnRemoveListeners()
	self.closeUIButton.onClick:RemoveListener(self.DelegateCloseBtn)
end

function SkinPreviewUI:InitializeSkinData(skinData)
	if skinData == nil then
		return nil, nil
	end

	local staticSkinCid, spineSkinCid

	for _, skinCid in pairs(skinData) do
		if SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid) then
			if staticSkinCid ~= nil then
				logError("SkinPreviewUI:InitializeSkinData : 皮肤预览页面包含了多个 静态立绘皮肤 数据，但此页面目前仅支持预览一个.")
			end

			staticSkinCid = skinCid
		elseif SkinModule.IsSpineSkinBySkinCid(skinCid) then
			if spineSkinCid ~= nil then
				logError("SkinPreviewUI:InitializeSkinData : 皮肤预览页面包含了多个 Spine皮肤 数据，但此页面目前仅支持预览一个.")
			end

			spineSkinCid = skinCid
		end
	end

	return staticSkinCid, spineSkinCid
end

function SkinPreviewUI:RefreshStaticImageShow(staticSkinCid)
	LuaUtility.SetGameObjectShow(self.SkinImg, staticSkinCid ~= nil)
	LuaUtility.SetGameObjectShow(self.HeadImg, staticSkinCid ~= nil)
	LuaUtility.SetGameObjectShow(self.ForceBg, staticSkinCid ~= nil)
	LuaUtility.SetGameObjectShow(self.SkinItem, staticSkinCid ~= nil)

	if staticSkinCid ~= nil then
		AssetUtil.LoadImage(self, SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(staticSkinCid, Constant.SkinImageType.HeroResourcesVerticalDraw), self.centerStaticImage, function()
			self.centerStaticImage:SetNativeSize()
			LuaUtility.SetImageRectTransformPivot(self.centerStaticImage:GetComponent(typeof(UnityEngine.RectTransform)), self.centerStaticImage)
		end)
		AssetUtil.LoadImage(self, SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(staticSkinCid, Constant.SkinImageType.HeroResourcesHead), self.headIconImage)

		self.curSkinItemCell = SkinItemCell.New(self.SkinItem, nil)

		local skinPOD = SkinModule.GenerateSkinPOD(nil, nil, nil, staticSkinCid)

		self.curSkinItemCell:Refresh(0, skinPOD)
		self.curSkinItemCell:OnSelectCallBack(true)
		self.curSkinItemCell:SetVisible(true)
	end
end

function SkinPreviewUI:RefreshSpineShow(spineSkinCid)
	LuaUtility.SetGameObjectShow(self.NoneState, spineSkinCid == nil)
	LuaUtility.SetGameObjectShow(self.NormalState, spineSkinCid ~= nil)
	self:DestroySpines()

	if spineSkinCid ~= nil then
		local heroSkinData = CfgHeroSkinTable[spineSkinCid]
		local elementEntityCid = heroSkinData.BattleEntityID

		if elementEntityCid >= 0 then
			local elementEntityConfig = CfgElementEntityTable[elementEntityCid]
			local path = BattleApi:GetSpinePrefabUrl(elementEntityConfig.PrefabName)

			AssetUtil.LoadAsset(self, path, self.DelegateOnLoadSpineAssetSuccessCallback)
		end
	end
end

function SkinPreviewUI:RefreshOtherInfoShow(skinCid)
	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)
	local heroCid = SkinModule.GetHeroCidBySkinCid(skinCid)
	local heroConfig = CfgHeroTable[heroCid]

	LuaUtility.SetText(self.RoleName, heroConfig.Name)
	LuaUtility.SetText(self.SkinInfo, skinConfig.SkinDesc)

	if heroConfig ~= nil and heroConfig.Forces > 0 then
		LuaUtility.SetGameObjectShow(self.ForceBg, true)

		local heroForceImgPath = WarlockApi:GetForceImgPath(heroConfig.Forces)

		AssetUtil.LoadImage(self, heroForceImgPath, self.ForceBgImage)
	else
		LuaUtility.SetGameObjectShow(self.ForceBg, false)
	end
end

function SkinPreviewUI:DestroySpines()
	if self.SpineParent ~= nil then
		local childCount = LuaUtility.GetChildCount(self.SpineParent.transform)

		for childIndex = 0, childCount - 1 do
			local childTransform = self.SpineParent.transform:GetChild(childIndex)

			if childTransform ~= nil then
				GameObject.Destroy(childTransform.gameObject)
			end
		end
	end

	if self.playSpineAnimationCustomCoroutine ~= nil and not self.playSpineAnimationCustomCoroutine.isComplete then
		self.playSpineAnimationCustomCoroutine:Stop()
	end

	self.playSpineAnimationCustomCoroutine = nil
end

function SkinPreviewUI:LoadSpineAssetSuccessCallBack(asset)
	if self.gameObject == nil then
		return
	end

	self:CreatSpine(asset)
end

function SkinPreviewUI:CreatSpine(spineAsset)
	local obj = GameObject.Instantiate(spineAsset)

	obj.transform:SetParent(self.SpineParent.transform, false)
	LuaUtility.SetScaleWithTransform(obj.transform, 100, 100, 100)

	obj.transform:GetChild(0).gameObject.layer = 5
	obj.transform:GetChild(0):GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = self.UIController:GetComponent("Canvas").sortingOrder + 1

	local spineGo = EntityUtility.GetBattleUnitEntitySpineRoot(obj)
	local roleEffect = LuaCodeInterface.GameObjectGetOrAddComponent(spineGo, typeof(RoleEffect))

	roleEffect:SetEnable(false)

	self.skeletonAnimation = obj:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)
	self.playSpineAnimationCustomCoroutine = SkinModule.GeneratePlaySpineAnimationCoroutine(self.skeletonAnimation)

	self.playSpineAnimationCustomCoroutine:Start()
end

function SkinPreviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkinPreviewUI:GetPreloadAssetPaths()
	return nil
end

function SkinPreviewUI:IsManualShowOnOpen(userData)
	return false
end

function SkinPreviewUI:GetBGM(userData)
	return nil
end

function SkinPreviewUI:OnPause()
	return
end

function SkinPreviewUI:OnResume()
	return
end

function SkinPreviewUI:OnCover()
	return
end

function SkinPreviewUI:OnReveal()
	return
end

function SkinPreviewUI:OnRefocus(userData)
	return
end

function SkinPreviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkinPreviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkinPreviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkinPreviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return SkinPreviewUI
