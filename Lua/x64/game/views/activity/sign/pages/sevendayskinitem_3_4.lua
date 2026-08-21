local var_0_0 = class("SevenDaySkinItem_3_4", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "receive")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.state_ == 1 or arg_4_0.isResign_ then
			if arg_4_0.receiveFunc_ then
				arg_4_0.receiveFunc_()
			end
		else
			ShowPopItem(POP_ITEM, arg_4_0.item_)
		end
	end)
end

function var_0_0.RefreshView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.stateCon_:SetSelectedIndex(arg_6_2)

	arg_6_0.state_ = arg_6_2
	arg_6_0.isResign_ = arg_6_3

	SetActive(arg_6_0.redGo_, arg_6_0.state_ == 1 and not arg_6_0.isResign_)
	SetActive(arg_6_0.resignGo_, arg_6_0.isResign_)

	arg_6_0.item_ = arg_6_1

	local var_6_0 = arg_6_1[1]
	local var_6_1 = arg_6_1[2]

	arg_6_0.numTxt_.text = var_6_1

	SetActive(arg_6_0.numGo_, var_6_1 >= 1)

	if ItemCfg[var_6_0].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_6_0)
	else
		arg_6_0.icon_.sprite = ItemTools.getItemSprite(var_6_0)
	end
end

function var_0_0.RegisterClickFunc(arg_7_0, arg_7_1)
	arg_7_0.receiveFunc_ = arg_7_1
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
