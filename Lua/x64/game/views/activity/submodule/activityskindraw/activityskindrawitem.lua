local var_0_0 = class("ActivitySkinDrawItem", ReduxView)

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

	if arg_3_0.controllerEx_ then
		arg_3_0.getCon_ = arg_3_0.controllerEx_:GetController("get")
		arg_3_0.lockCon_ = arg_3_0.controllerEx_:GetController("lock")
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			id = arg_4_0.itemId_
		}, {
			showTotalCntIgnoreTimeValid = true
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.itemId_ = arg_7_1.itemId
	arg_7_0.count = arg_7_1.count

	if arg_7_0.getCon_ then
		arg_7_0.getCon_:SetSelectedState(tostring(arg_7_0.count <= 0))
	end

	if arg_7_2 then
		local var_7_0 = ActivityLimitedDrawPoolListCfg[arg_7_2]

		if var_7_0 then
			if var_7_0.pool_type == 1 then
				arg_7_0.imgReward_.sprite = getSprite(var_7_0.main_reward_picture[1], var_7_0.main_reward_picture[2])
			else
				arg_7_0.imgReward_.sprite = pureGetSpriteWithoutAtlas(var_7_0.main_reward_picture[1])
			end
		end
	else
		local var_7_1 = ItemCfg[arg_7_0.itemId_]

		arg_7_0.imgReward_.sprite = ItemTools.getItemSprite(arg_7_0.itemId_)
	end
end

function var_0_0.SetLock(arg_8_0, arg_8_1)
	if arg_8_0.lockCon_ then
		arg_8_0.lockCon_:SetSelectedState(arg_8_1 and "on" or "off")
	end
end

function var_0_0.Hide(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
