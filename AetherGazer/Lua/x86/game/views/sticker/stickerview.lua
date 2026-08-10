local var_0_0 = class("StickerView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.btn_ = {}
	arg_3_0.img_ = {}
	arg_3_0.sizeCon_ = {}
	arg_3_0.stateCon_ = {}
	arg_3_0.cfg_ = StickViewTemplateCfg[arg_3_0.id_]

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.cfg_.range_list) do
		arg_3_0.btn_[iter_3_0] = arg_3_0["btn_" .. iter_3_0]
		arg_3_0.sizeCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0.btn_[iter_3_0].transform, "size")
		arg_3_0.stateCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0.btn_[iter_3_0].transform, "state")
		arg_3_0.img_[iter_3_0] = {}

		for iter_3_2 = 1, 3 do
			arg_3_0.img_[iter_3_0][iter_3_2] = arg_3_0["img_" .. iter_3_0 .. "_" .. iter_3_2]
		end
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.btn_) do
		arg_4_0:AddBtnListener(iter_4_1, nil, function()
			if arg_4_0.clickFunc_ then
				arg_4_0.clickFunc_(arg_4_0.info_[iter_4_0], iter_4_0)
			end
		end)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.info_ = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1)
	local var_7_0 = true

	arg_7_0.isEditor_ = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.cfg_.range_list) do
		local var_7_1 = arg_7_0.info_[iter_7_0]

		if arg_7_0.cfg_.range_list[iter_7_0][2][1] < var_7_1.size then
			var_7_1.size = arg_7_0.cfg_.range_list[iter_7_0][2][1]
		end

		arg_7_0.sizeCon_[iter_7_0]:SetSelectedState(var_7_1.size)
		arg_7_0.stateCon_[iter_7_0]:SetSelectedState(var_7_1.stickerID > 0 and "active" or "add")
		SetActive(arg_7_0.btn_[iter_7_0].gameObject, arg_7_0.isEditor_ or var_7_1.stickerID > 0)

		if var_7_1.stickerID > 0 then
			var_7_0 = false
			arg_7_0.img_[iter_7_0][var_7_1.size].sprite = ItemTools.getItemSprite(var_7_1.stickerID, {
				size = var_7_1.size
			})

			arg_7_0.img_[iter_7_0][var_7_1.size]:SetNativeSize()
		end
	end

	SetActive(arg_7_0.nothingGo_, not arg_7_0.isEditor_ and var_7_0)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.RegistClickFunc(arg_9_0, arg_9_1)
	arg_9_0.clickFunc_ = arg_9_1
end

function var_0_0.OnExit(arg_10_0)
	SetActive(arg_10_0.gameObject_, false)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
