local var_0_0 = class("XH3rdFlipCardClueItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.clueId = arg_3_1.detail_id
	arg_3_0.name = arg_3_1.name
	arg_3_0.icon_path = arg_3_1.icon_path
	arg_3_0.picture = arg_3_1.picture
	arg_3_0.activityId = arg_3_2
	arg_3_0.flipCardCfg = FlipCardCfg[arg_3_0.activityId]
	arg_3_0.isGetted = XH3rdFlipCardData:CheckClueIsGetted(arg_3_0.clueId)
	arg_3_0.isViewed = XH3rdFlipCardData:CheckClueIsViewed(arg_3_0.clueId)

	manager.redPoint:bindUIandKey(arg_3_0.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_3_0.activityId, arg_3_0.clueId))
	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.transform_, "clue")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.checkBtn_, nil, function()
		XH3rdFlipCardAction:sendViewClueRequest(arg_5_0.activityId, arg_5_0.clueId)
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.titleText_.text = arg_7_0.name

	if arg_7_0.isGetted then
		arg_7_0.lockController:SetSelectedState("unlock")
	else
		arg_7_0.lockController:SetSelectedState("lock")
	end

	if arg_7_0.picture and arg_7_0.picture ~= "" and arg_7_0.flipCardCfg.clue_icon_path and arg_7_0.flipCardCfg.clue_icon_path ~= "" then
		arg_7_0.img_.sprite = pureGetSpriteWithoutAtlas(arg_7_0.flipCardCfg.clue_icon_path .. arg_7_0.picture)
	end
end

function var_0_0.Dispose(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_8_0.activityId, arg_8_0.clueId))
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.SetReveivedHandler(arg_9_0, arg_9_1)
	arg_9_0.onReceived_ = arg_9_1
end

return var_0_0
