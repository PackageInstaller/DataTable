local var_0_0 = class("CapturePictureSlotModule", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.staticContext = {}
	arg_3_0.runtimeCtx = {
		id = -1
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
	arg_4_0:AddListener()
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:OnSectionClick()
	end)
end

function var_0_0.OnSectionClick(arg_7_0)
	local var_7_0 = arg_7_0.staticContext.clickCallback

	if var_7_0 then
		var_7_0(arg_7_0.runtimeCtx.id)
	end
end

function var_0_0.RegisterClickCallback(arg_8_0, arg_8_1)
	arg_8_0.staticContext.clickCallback = arg_8_1
end

function var_0_0.RenderView(arg_9_0, arg_9_1)
	if arg_9_1 ~= nil then
		arg_9_0.runtimeCtx.id = arg_9_1.id
		arg_9_0.runtimeCtx.mainActivityId = arg_9_1.mainActivityId

		local var_9_0 = CaptureGameData:CheckSectionTaskComplete(arg_9_0.runtimeCtx.mainActivityId, arg_9_0.runtimeCtx.id)

		arg_9_0.description_.text = ActivitySwimSkinSubSectionCfg[arg_9_1.id].description

		SetActive(arg_9_0.pictureImg_, var_9_0)
		arg_9_0:UnbindRedPoint()
		arg_9_0:BindRedPoint()
		arg_9_0.emptyObj_:SetActive(false)
		arg_9_0.contentObj_:SetActive(true)
	else
		arg_9_0.runtimeCtx.id = nil
		arg_9_0.runtimeCtx.mainActivityId = nil

		arg_9_0:UnbindRedPoint()
		arg_9_0.emptyObj_:SetActive(true)
		arg_9_0.contentObj_:SetActive(false)
	end
end

function var_0_0.BindRedPoint(arg_10_0)
	local var_10_0 = {
		RedPointConst.CAPTURE_GAME_UNLOCK_STAGE,
		"_",
		0,
		[3] = arg_10_0.runtimeCtx.id
	}

	manager.redPoint:bindUIandKey(arg_10_0.noticeContainer_.transform, table.concat(var_10_0))
end

function var_0_0.UnbindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.noticeContainer_.transform)
end

function var_0_0.Exit(arg_12_0)
	arg_12_0:UnbindRedPoint()
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
