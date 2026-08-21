local var_0_0 = class("SculptureCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1
	arg_1_0.go = arg_1_1.gameObject
	arg_1_0.nameImg = arg_1_1:Find("name/Image"):GetComponent(typeof(Image))
	arg_1_0.roleImg = arg_1_1:Find("role"):GetComponent(typeof(Image))
	arg_1_0.consumeTxt = arg_1_1:Find("mask/Text"):GetComponent(typeof(Text))
	arg_1_0.consumeIcon = arg_1_1:Find("mask/icon"):GetComponent(typeof(Image))
	arg_1_0.finishBtn = arg_1_1:Find("btns/finish")
	arg_1_0.continueBtn = arg_1_1:Find("btns/continue")
	arg_1_0.presentedBtn = arg_1_1:Find("btns/presented")
	arg_1_0.lockBtn = arg_1_1:Find("mask")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activity = arg_2_2
	arg_2_0.id = arg_2_1

	local var_2_0 = arg_2_2:GetSculptureState(arg_2_1)

	if var_2_0 < SculptureActivity.STATE_UNLOCK then
		arg_2_0:UpdateConsume()
	end

	arg_2_0:UpdateName()
	arg_2_0:UpdateRole(var_2_0)
	arg_2_0:UpdateBtns(var_2_0)

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	local var_3_0 = arg_3_0.activity:GetSculptureState(arg_3_0.id)

	arg_3_0:UpdateBtns(var_3_0)
	arg_3_0:UpdateRole(var_3_0)

	return
end

function var_0_0.UpdateConsume(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0.activity:_GetComsume(arg_4_0.id)

	arg_4_0.consumeTxt.text = var_4_1
	arg_4_0.consumeIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_4_0].icon)
	rtf(arg_4_0.consumeIcon.gameObject).sizeDelta = Vector2(60, 60)

	return
end

function var_0_0.UpdateName(arg_5_0)
	arg_5_0.nameImg.sprite = GetSpriteFromAtlas("ui/SculptureUI_atlas", arg_5_0.activity:GetResorceName(arg_5_0.id) .. "_title")

	arg_5_0.nameImg:SetNativeSize()

	return
end

function var_0_0.UpdateRole(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.activity:GetResorceName(arg_6_0.id)

	if arg_6_1 == SculptureActivity.STATE_FINSIH then
		arg_6_0.roleImg.sprite = nil

		setActive(arg_6_0.roleImg.gameObject, false)
		arg_6_0:LoadChar(var_6_0)
	else
		if arg_6_1 >= SculptureActivity.STATE_UNLOCK then
			var_6_0 = var_6_0 .. "_gray"
		end

		LoadSpriteAtlasAsync("SculptureRole/" .. var_6_0, nil, function(arg_7_0)
			if arg_6_0.exited then
				return
			end

			arg_6_0.roleImg.sprite = arg_7_0

			arg_6_0.roleImg:SetNativeSize()

			return
		end)
	end

	return
end

function var_0_0.LoadChar(arg_8_0, arg_8_1)
	if arg_8_0.charName == arg_8_1 then
		return
	end

	arg_8_0:ClearChar()
	PoolMgr.GetInstance():GetSpineChar("takegift_" .. arg_8_1, true, function(arg_9_0)
		arg_9_0.transform:SetParent(arg_8_0.roleImg.gameObject.transform.parent)

		arg_9_0.transform.localScale = Vector3(0.8, 0.8, 0)
		arg_9_0.transform.localPosition = Vector3(0, -180, 0)

		arg_9_0:GetComponent(typeof(SpineAnimUI)):SetAction("take_wait_" .. arg_8_1, 0)

		arg_8_0.charGo = arg_9_0

		return
	end)

	arg_8_0.charName = arg_8_1

	return
end

function var_0_0.ClearChar(arg_10_0)
	if arg_10_0.charName and arg_10_0.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(arg_10_0.charName, arg_10_0.charGo)

		arg_10_0.charName = nil
		arg_10_0.charGo = nil
	end

	return
end

function var_0_0.UpdateBtns(arg_11_0, arg_11_1)
	setActive(arg_11_0.finishBtn, arg_11_1 == SculptureActivity.STATE_FINSIH)
	setActive(arg_11_0.continueBtn, arg_11_1 >= SculptureActivity.STATE_UNLOCK and arg_11_1 < SculptureActivity.STATE_JOINT)
	setActive(arg_11_0.presentedBtn, arg_11_1 == SculptureActivity.STATE_JOINT)
	setActive(arg_11_0.lockBtn, arg_11_1 < SculptureActivity.STATE_UNLOCK)

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.exited = true

	arg_12_0:ClearChar()

	return
end

return var_0_0
