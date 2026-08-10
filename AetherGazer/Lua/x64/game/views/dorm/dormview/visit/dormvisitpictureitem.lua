local var_0_0 = class("DormVisitPictureItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.praiseController = arg_2_0.controller_:GetController("praise")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.downloadHandler = handler(arg_3_0, arg_3_0.OnDownloadDone)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.roomBtn_, nil, function()
		arg_4_0:OnGotoClick()
	end)
	manager.notify:RegistListener(SDK_DOWNLOAD_IMG, arg_4_0.downloadHandler)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0.loading_, true)

	arg_6_0.userID = arg_6_1
	arg_6_0.type = arg_6_2

	local var_6_0 = DormVisitTools:GetTemplateExhibitList(arg_6_0.type)[arg_6_0.userID]

	if not var_6_0 then
		Debug.LogError("未获取到参观信息")

		return
	end

	local var_6_1 = SDKDonwloadUrlToLocalPath(var_6_0.picture_link)

	arg_6_0.localSavePath = manager.share:GetSavePathByModule("room_edit") .. var_6_1 .. ".jpg"

	SDKDownloadImage(var_6_0.picture_link, arg_6_0.localSavePath)

	arg_6_0.viewNum_.text = var_6_0.visitNum
	arg_6_0.praiseNum_.text = var_6_0.likeNum
	arg_6_0.houseName_.text = var_6_0.nick

	if var_6_0.todayLikeNum then
		arg_6_0.praiseController:SetSelectedState("off")
	else
		arg_6_0.praiseController:SetSelectedState("on")
	end
end

function var_0_0.OnDownloadDone(arg_7_0, arg_7_1)
	if arg_7_0.localSavePath and arg_7_1.code == 1 and arg_7_1.path == arg_7_0.localSavePath and arg_7_0.gameObject_.activeInHierarchy then
		BulletinBoardMgr.inst:GetFocalSpriteCustom(arg_7_1.path, function(arg_8_0)
			if not isNil(arg_8_0) then
				arg_7_0.bgImg_.sprite = arg_8_0

				SetActive(arg_7_0.loading_, false)
			end
		end)
	end
end

function var_0_0.OnGotoClick(arg_9_0)
	SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
		backhome_source = 2
	})
	DormAction:AskSingleFurTemplateExhibit(arg_9_0.userID)
end

function var_0_0.Dispose(arg_10_0)
	manager.notify:RemoveListener(SDK_DOWNLOAD_IMG, arg_10_0.downloadHandler)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
