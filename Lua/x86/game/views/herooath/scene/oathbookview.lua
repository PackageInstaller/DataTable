local var_0_0 = class("OathBookView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return OathTools.GetOathBookPrefab(arg_1_0.params_.heroID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListeners()

	arg_3_0.showReBtnController_ = arg_3_0.controller_:GetController("showReBtn")
	arg_3_0.showShareBtnController_ = arg_3_0.controller_:GetController("shareBtn")
	arg_3_0.sharePanel_ = OathShareView.New(arg_3_0.goSharePanel_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:OnClickCloseBtn()
	end)
	arg_4_0:AddBtnListener(arg_4_0.reBtn_, nil, function()
		local var_6_0 = WeddingCfg[arg_4_0.heroID]

		OathLaunchScene(var_6_0.wedding_scene, arg_4_0.heroID, var_6_0.skin_id, OathConst.OATH_SCENE_MODE.BOOK_RE)
	end)
	arg_4_0:AddBtnListener(arg_4_0.shareBtn_, nil, function()
		arg_4_0:OnClickShareBtn()
	end)
end

function var_0_0.OnClickShareBtn(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:GetScreenCorners(arg_8_0.contentRect_)
	local var_8_2 = var_8_1.x - var_8_0.x
	local var_8_3 = var_8_1.y - var_8_0.y

	WaitRenderFrameUtil.inst.StartScreenShot(function()
		arg_8_0.sharePanel_:OnBookShareSnape(var_8_0.x, var_8_0.y, var_8_2, var_8_3)

		local var_9_0

		if GameToSDK.IsPCPlatform() then
			var_9_0 = arg_8_0.sharePanel_.imageShotPc_.transform:GetComponent("RectTransform")
		else
			arg_8_0.sharePanel_.imageShot_:SetNativeSize()

			var_9_0 = arg_8_0.sharePanel_.imageShot_.transform:GetComponent("RectTransform")
		end

		var_9_0.sizeDelta = Vector2(arg_8_0.contentRect_.sizeDelta.x, arg_8_0.contentRect_.sizeDelta.y)
	end)
end

function var_0_0.GetScreenCorners(arg_10_0, arg_10_1)
	if arg_10_0.corners == nil then
		arg_10_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	local var_10_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_10_1:GetWorldCorners(arg_10_0.corners)

	local var_10_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_10_0, arg_10_0.corners[0])
	local var_10_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_10_0, arg_10_0.corners[2])

	return var_10_1, var_10_2
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.sharePanel_ then
		arg_11_0.sharePanel_:Dispose()

		arg_11_0.sharePanel_ = nil
	end

	arg_11_0.super.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.heroID = arg_12_0.params_.heroID

	arg_12_0.sharePanel_:SetData(OathConst.OATH_SHARE_TYPE.BOOK, arg_12_0.heroID)

	arg_12_0.isMainViewEnter = arg_12_0.params_.isMainViewEnter or false

	arg_12_0:RefreshUI()
	arg_12_0.sharePanel_:OnEnter()
end

function var_0_0.RefreshUI(arg_13_0)
	if arg_13_0.isMainViewEnter then
		arg_13_0.showReBtnController_:SetSelectedState("show")
		arg_13_0.showShareBtnController_:SetSelectedState("show")
	else
		arg_13_0.showReBtnController_:SetSelectedState("hide")
		arg_13_0.showShareBtnController_:SetSelectedState("hide")
	end

	arg_13_0.adminImg_.sprite = OathTools.GetOathHeadSprite(OathConst.OATH_ADMIN_ID)
	arg_13_0.roleImg_.sprite = OathTools.GetOathHeadSprite(WeddingCfg[arg_13_0.heroID].skin_id)

	arg_13_0.adminImg_:SetNativeSize()
	arg_13_0.roleImg_:SetNativeSize()

	local var_13_0 = PlayerData:GetPlayerInfo()

	arg_13_0.adminText_.text = var_13_0.nick
	arg_13_0.roleText_.text = GetI18NText(HeroCfg[arg_13_0.heroID].suffix)
	arg_13_0.descText_.text = GetI18NText(WeddingCfg[arg_13_0.heroID].wedding_book_desc)
	arg_13_0.timeText_.text = manager.time:DescCTime(OathCollectionContentData:GetOathTime(arg_13_0.heroID), "!%Y/%m/%d")

	if arg_13_0.params_ and not isNil(arg_13_0.params_.sprite) then
		arg_13_0.imageBg_.sprite = arg_13_0.params_.sprite
		arg_13_0.params_.sprite = nil
	else
		local var_13_1

		if GameToSDK.IsEditorPlatform() then
			var_13_1 = OathCollectionContentData:GetWeddingPhotoUrl(arg_13_0.params_.heroID)

			if var_13_1 then
				var_13_1 = manager.share:GetSavePathByModule("oath") .. string.format("picture_%s_%s.jpg", USER_ID, arg_13_0.params_.heroID)

				BulletinBoardMgr.inst:GetFocalSpriteCustom(var_13_1, function(arg_14_0)
					if not isNil(arg_14_0) then
						arg_13_0.imageBg_.sprite = arg_14_0
					end
				end)
			end
		else
			var_13_1 = OathCollectionContentAction.FetchWeddingPhotoFromRemote(arg_13_0.heroID, function(arg_15_0)
				if not isNil(arg_15_0) then
					arg_13_0.imageBg_.sprite = arg_15_0
				end
			end)
		end

		if not var_13_1 or isNil(arg_13_0.imageBg_.sprite) then
			arg_13_0.imageBg_.sprite = getSpriteWithoutAtlas("TextureConfig/Hero_Oath/Photo/" .. WeddingCfg[arg_13_0.heroID].skin_id)
		end
	end

	if arg_13_0.imageBg_ and arg_13_0.imageBg_.sprite then
		local var_13_2 = arg_13_0.imageBg_.sprite.rect.width
		local var_13_3 = arg_13_0.imageBg_.sprite.rect.height
		local var_13_4 = arg_13_0.maskNodeRect_.rect.width
		local var_13_5 = arg_13_0.maskNodeRect_.rect.height
		local var_13_6 = 1

		if var_13_2 / var_13_3 > 1.7777777777777777 then
			var_13_6 = var_13_5 / var_13_3
		else
			var_13_6 = var_13_4 / var_13_2
		end

		arg_13_0.imageBg_.transform.localScale = Vector3.one * var_13_6

		arg_13_0.imageBg_:SetNativeSize()
	end
end

function var_0_0.OnExit(arg_16_0)
	return
end

function var_0_0.OnClickCloseBtn(arg_17_0)
	arg_17_0:Back()

	if manager.windowBar:GetWhereTag() == "Oath" then
		OathToLuaBridge.OathExitScene()
	end
end

function var_0_0.Cacheable(arg_18_0)
	return false
end

return var_0_0
