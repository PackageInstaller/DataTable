local var_0_0 = class("QWorldBookletPhotoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.jumpBtn_, nil, function()
		local var_7_0 = QuanzhouPhotoCfg[arg_5_0.params_.photoId]
		local var_7_1 = var_7_0.enity_id

		SandPlayTakePhotoTools.TrackPhoto(var_7_1, var_7_0.thing_id)

		if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_7_1) then
			gameContext:SetUrlAndParams("/springPreheatBlank/qworldMainHome")
			JumpTools.GoToSystem("/qWorldMaxMapView", {
				selectEntity = var_7_1
			})
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = QWorldBookletTools.CheckPhotoUnlock(arg_8_0.params_.photoId)
	local var_8_1 = QuanzhouPhotoCfg[arg_8_0.params_.photoId]

	if var_8_0 then
		arg_8_0.lockController_:SetSelectedState("unlock")

		if var_8_1.id == 2005 then
			arg_8_0.photoImg_.spriteAsync = "TextureConfig/SandPlay_QuanZhou/QuanZhou_CollectBook/MainPlot_05"
		else
			arg_8_0.photoImg_.spriteAsync = var_8_1.pic
		end

		arg_8_0.descText_.text = var_8_1.desc
	else
		arg_8_0.previewImg_.spriteAsync = var_8_1.pre_pic

		arg_8_0.lockController_:SetSelectedState("lock")
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
