local var_0_0 = class("ChessBoardSmallMapSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.selectType_ = arg_4_1
	arg_4_0.selectID_ = arg_4_2
	arg_4_0.callBack_ = arg_4_3

	arg_4_0:UpdateView()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.callBack_ then
			arg_5_0.callBack_(arg_5_0.selectType_, arg_5_0.selectID_)
		end
	end)
end

function var_0_0.UpdateView(arg_7_0)
	if arg_7_0.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
		local var_7_0 = ChessBoardHexCfg[arg_7_0.selectID_]

		arg_7_0.text_.text = var_7_0.name
		arg_7_0.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_7_0.small_map_icon_nobg)
	elseif arg_7_0.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
		if arg_7_0.selectID_ == 0 then
			local var_7_1 = ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId]

			arg_7_0.text_.text = ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_hero_name")
			arg_7_0.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_7_1.chessboard_hero_small_map_icon)
		else
			local var_7_2 = ChessBoardNPCPoolCfg[arg_7_0.selectID_]

			arg_7_0.text_.text = var_7_2.name
			arg_7_0.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", var_7_2.small_map_icon)
		end
	elseif arg_7_0.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
		local var_7_3 = ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_speciality_icon")

		for iter_7_0, iter_7_1 in pairs(var_7_3) do
			if iter_7_1[1] == arg_7_0.selectID_ then
				arg_7_0.text_.text = GetTips(iter_7_1[3])
				arg_7_0.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", iter_7_1[2])

				break
			end
		end
	end
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.SetParent(arg_9_0, arg_9_1)
	arg_9_0.transform_.parent = arg_9_1
end

function var_0_0.RefreshSelect(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.selectType_ == arg_10_1 and arg_10_0.selectID_ == arg_10_2 then
		arg_10_0.controller_:SetSelectedState("on")
	else
		arg_10_0.controller_:SetSelectedState("off")
	end
end

function var_0_0.FixScaleAndPos(arg_11_0)
	arg_11_0.transform_.localScale = Vector3(1, 1, 1)
	arg_11_0.transform_.localPosition = Vector3(arg_11_0.transform_.localPosition.x, arg_11_0.transform_.localPosition.y, 0)
end

function var_0_0.Dispose(arg_12_0)
	Object.Destroy(arg_12_0.gameObject_)

	arg_12_0.callBack_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
