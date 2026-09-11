local OathBookView = class("OathBookView", ReduxView)

function OathBookView:UIName()
	return OathTools.GetOathBookPrefab(self.params_.heroID)
end

function OathBookView:UIParent()
	return manager.ui.uiPop.transform
end

function OathBookView:Init()
	self:BindCfgUI()
	self:AddUIListeners()

	self.showReBtnController_ = self.controller_:GetController("showReBtn")
	self.showShareBtnController_ = self.controller_:GetController("shareBtn")
	self.sharePanel_ = OathShareView.New(self.goSharePanel_)
end

function OathBookView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:OnClickCloseBtn()
	end)
	self:AddBtnListener(self.reBtn_, nil, function()
		OathLaunchScene(WeddingCfg[self.heroID].wedding_scene, self.heroID, WeddingCfg[self.heroID].skin_id, OathConst.OATH_SCENE_MODE.BOOK_RE)
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		self:OnClickShareBtn()
	end)
end

function OathBookView:OnClickShareBtn()
	local var_8_0, var_8_1 = self:GetScreenCorners(self.contentRect_)
	local var_8_2 = var_8_1.x - var_8_0.x
	local var_8_3 = var_8_1.y - var_8_0.y

	WaitRenderFrameUtil.inst.StartScreenShot(function()
		self.sharePanel_:OnBookShareSnape(var_8_0.x, var_8_0.y, var_8_2, var_8_3)

		local var_9_0

		if GameToSDK.IsPCPlatform() then
			var_9_0 = self.sharePanel_.imageShotPc_.transform:GetComponent("RectTransform")
		else
			self.sharePanel_.imageShot_:SetNativeSize()

			var_9_0 = self.sharePanel_.imageShot_.transform:GetComponent("RectTransform")
		end

		var_9_0.sizeDelta = Vector2(self.contentRect_.sizeDelta.x, self.contentRect_.sizeDelta.y)
	end)
end

function OathBookView:GetScreenCorners(arg_10_1)
	if self.corners == nil then
		self.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	local var_10_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_10_1:GetWorldCorners(self.corners)

	return UnityEngine.RectTransformUtility.WorldToScreenPoint(var_10_0, self.corners[0]), (UnityEngine.RectTransformUtility.WorldToScreenPoint(var_10_0, self.corners[2]))
end

function OathBookView:Dispose()
	if self.sharePanel_ then
		self.sharePanel_:Dispose()

		self.sharePanel_ = nil
	end

	self.super.Dispose(self)
	self:RemoveAllListeners()
end

function OathBookView:OnEnter()
	self.heroID = self.params_.heroID

	self.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.BOOK, self.heroID)

	self.isMainViewEnter = self.params_.isMainViewEnter or false

	self:RefreshUI()
	self.sharePanel_:OnEnter()
end

function OathBookView:RefreshUI()
	if self.isMainViewEnter then
		self.showReBtnController_:SetSelectedState("show")
		self.showShareBtnController_:SetSelectedState("show")
	else
		self.showReBtnController_:SetSelectedState("hide")
		self.showShareBtnController_:SetSelectedState("hide")
	end

	self.adminImg_.sprite = OathTools.GetOathHeadSprite(OathConst.OATH_ADMIN_ID)
	self.roleImg_.sprite = OathTools.GetOathHeadSprite(WeddingCfg[self.heroID].skin_id)

	self.adminImg_:SetNativeSize()
	self.roleImg_:SetNativeSize()

	self.adminText_.text = PlayerData:GetPlayerInfo().nick
	self.roleText_.text = GetI18NText(HeroCfg[self.heroID].suffix)
	self.descText_.text = GetI18NText(WeddingCfg[self.heroID].wedding_book_desc)
	self.timeText_.text = manager.time:DescCTime(OathCollectionContentData:GetOathTime(self.heroID), "!%Y/%m/%d")

	if self.params_ and not isNil(self.params_.sprite) then
		self.imageBg_.sprite = self.params_.sprite
		self.params_.sprite = nil
	else
		local var_13_0

		if GameToSDK.IsEditorPlatform() then
			var_13_0 = OathCollectionContentData:GetWeddingPhotoUrl(self.params_.heroID)

			if var_13_0 then
				var_13_0 = manager.share:GetSavePathByModule("oath") .. string.format("picture_%s_%s.jpg", USER_ID, self.params_.heroID)

				BulletinBoardMgr.inst:GetFocalSpriteCustom(var_13_0, function(arg_14_0)
					if not isNil(arg_14_0) then
						self.imageBg_.sprite = arg_14_0
					end
				end)
			end
		else
			var_13_0 = OathCollectionContentAction.FetchWeddingPhotoFromRemote(self.heroID, function(arg_15_0)
				if not isNil(arg_15_0) then
					self.imageBg_.sprite = arg_15_0
				end
			end)
		end

		if not var_13_0 or isNil(self.imageBg_.sprite) then
			self.imageBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Hero_Oath/Photo/" .. WeddingCfg[self.heroID].skin_id)
		end
	end

	if self.imageBg_ and self.imageBg_.sprite then
		self.imageBg_.transform.localScale = Vector3.one * (self.imageBg_.sprite.rect.width / self.imageBg_.sprite.rect.height > 1.7777777777777777 and self.maskNodeRect_.rect.height / self.imageBg_.sprite.rect.height or self.maskNodeRect_.rect.width / self.imageBg_.sprite.rect.width)

		self.imageBg_:SetNativeSize()
	end
end

function OathBookView:OnExit()
	return
end

function OathBookView:OnClickCloseBtn()
	self:Back()

	if manager.windowBar:GetWhereTag() == "Oath" then
		OathToLuaBridge.OathExitScene()
	end
end

function OathBookView:Cacheable()
	return false
end

return OathBookView
