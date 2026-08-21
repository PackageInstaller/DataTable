local var_0_0 = class("DrawInfoCommonItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()

	arg_1_0.upCon_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("UP")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnBg_, nil, function()
		local var_3_0 = DrawItemCfg[arg_2_0.itemId].item_id

		if arg_2_0.isHero then
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				hid = var_3_0
			})
		else
			arg_2_0:Go("/showServantView", {
				stage = 5,
				state = "onlydetail",
				id = var_3_0
			})
		end
	end)
end

function var_0_0.RefreshData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.item then
		arg_4_0.item:Dispose()

		arg_4_0.item = nil
	end

	arg_4_0:Show(true)

	arg_4_0.item = CommonItemView.New(arg_4_0.commonItem)
	arg_4_0.isHero = arg_4_2
	arg_4_0.itemId = arg_4_1

	local var_4_0 = DrawItemCfg[arg_4_1]

	if var_4_0 == nil then
		Debug.LogError(string.format("配置表 DrawItemCfg 找不到 id : %s ", arg_4_1))

		return
	end

	local var_4_1 = var_4_0.item_id or 0

	if arg_4_2 then
		arg_4_0.item:SetData({
			id = var_4_1
		})
	else
		arg_4_0.item:SetData({
			id = var_4_1
		})
	end
end

function var_0_0.RefreshUp(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 and #arg_5_1 > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if arg_5_0.itemId == iter_5_1 then
				arg_5_0.upCon_:SetSelectedIndex(1)

				break
			end
		end
	else
		arg_5_0.upCon_:SetSelectedIndex(0)
	end

	if not arg_5_2 then
		arg_5_0.upCon_:SetSelectedIndex(0)
	end
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	if arg_7_0.item then
		arg_7_0.item:Dispose()
		Object.Destroy(arg_7_0.item.gameObject_)

		arg_7_0.item = nil
	end

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

return var_0_0
