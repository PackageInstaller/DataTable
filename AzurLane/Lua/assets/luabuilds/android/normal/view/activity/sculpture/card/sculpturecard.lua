class = var_0_10000

local var_0_0 = var_0_10000("SculptureCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1
	arg_1_0.go = arg_1_1.gameObject

	local var_1_0 = arg_1_1:Find("name/Image")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.nameImg = var_1_1(var_1_0, var_4(var_1_10005))

	local var_1_2 = arg_1_1:Find("role")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.roleImg = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_1:Find("mask/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.consumeTxt = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_1:Find("mask/icon")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.consumeIcon = var_1_7(var_1_6, var_4(var_1_10005))
	arg_1_0.finishBtn = arg_1_1:Find("btns/finish")
	arg_1_0.continueBtn = arg_1_1:Find("btns/continue")
	arg_1_0.presentedBtn = arg_1_1:Find("btns/presented")
	arg_1_0.lockBtn = arg_1_1:Find("mask")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activity = arg_2_2
	arg_2_0.id = arg_2_1

	local var_2_0 = arg_2_2
	local var_2_1 = arg_2_2.GetSculptureState(var_2_0, arg_2_1)

	SculptureActivity = var_2_0

	if var_2_1 < var_2_0.STATE_UNLOCK then
		arg_2_0:UpdateConsume()
	end

	arg_2_0:UpdateName()
	arg_2_0:UpdateRole(var_2_1)
	arg_2_0:UpdateBtns(var_2_1)

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_2.GetSculptureState(var_3_0, arg_3_0.id)

	arg_3_0:UpdateBtns(var_3_1)
	arg_3_0:UpdateRole(var_3_1)

	return
end

function var_0_0.UpdateConsume(arg_4_0)
	local var_4_0 = arg_4_0.activity
	local var_4_1, var_4_2 = var_1._GetComsume(var_4_0, arg_4_0.id)

	arg_4_0.consumeTxt.text = var_4_2

	local var_4_3 = var_4_1

	pg = var_1_10004

	local var_4_4 = var_1_10004.activity_workbench_item[var_4_3]
	local var_4_5 = arg_4_0.consumeIcon

	LoadSprite = var_1_10006
	var_4_5.sprite = var_1_10006("props/" .. var_4_4.icon)
	rtf = var_4_5

	local var_4_6 = var_4_5(arg_4_0.consumeIcon.gameObject)

	Vector2 = var_6
	var_4_6.sizeDelta = var_6(60, 60)

	return
end

function var_0_0.UpdateName(arg_5_0)
	local var_5_0 = arg_5_0.activity
	local var_5_1 = var_1.GetResorceName(var_5_0, arg_5_0.id)
	local var_5_2 = arg_5_0.nameImg

	GetSpriteFromAtlas = var_3
	var_5_2.sprite = var_3("ui/SculptureUI_atlas", var_5_1 .. "_title")

	local var_5_3 = arg_5_0.nameImg

	var_2.SetNativeSize(var_5_3)

	return
end

function var_0_0.UpdateRole(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_2.GetResorceName(var_6_0, arg_6_0.id)

	SculptureActivity = var_6_0

	local var_6_2

	if arg_6_1 == var_6_0.STATE_FINSIH then
		var_6_2 = arg_6_0.roleImg
		var_6_2.sprite = nil
		setActive = var_6_2

		var_6_2(arg_6_0.roleImg.gameObject, false)
		arg_6_0:LoadChar(var_6_1)
	else
		SculptureActivity = var_6_2

		if var_6_2.STATE_UNLOCK <= arg_6_1 then
			var_6_1 = var_6_1 .. "_gray"
		end

		LoadSpriteAtlasAsync = var_3

		var_3("SculptureRole/" .. var_6_1, nil, function(arg_7_0)
			if arg_6_0.exited then
				return
			end

			arg_6_0.roleImg.sprite = arg_7_0

			local var_7_0 = arg_6_0.roleImg

			var_1.SetNativeSize(var_7_0)

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

	PoolMgr = var_2

	local var_8_0 = var_2.GetInstance()

	var_2.GetSpineChar(var_8_0, "takegift_" .. arg_8_1, true, function(arg_9_0)
		local var_9_0 = arg_9_0.transform

		var_1.SetParent(var_9_0, arg_8_0.roleImg.gameObject.transform.parent)

		local var_9_1 = arg_9_0.transform

		Vector3 = var_9_0
		var_9_1.localScale = var_9_0(0.8, 0.8, 0)

		local var_9_2 = arg_9_0.transform

		Vector3 = var_2
		var_9_2.localPosition = var_2(0, -180, 0)

		local var_9_3 = arg_9_0
		local var_9_4 = arg_9_0.GetComponent

		typeof = var_3
		SpineAnimUI = var_4

		local var_9_5 = var_9_4(var_9_3, var_3(var_4))

		var_1.SetAction(var_9_5, "take_wait_" .. arg_8_1, 0)

		arg_8_0.charGo = arg_9_0

		return
	end)

	arg_8_0.charName = arg_8_1

	return
end

function var_0_0.ClearChar(arg_10_0)
	if arg_10_0.charName and arg_10_0.charGo then
		PoolMgr = var_1

		local var_10_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_10_0, arg_10_0.charName, arg_10_0.charGo)

		arg_10_0.charName = nil
		arg_10_0.charGo = nil
	end

	return
end

function var_0_0.UpdateBtns(arg_11_0, arg_11_1)
	setActive = var_1_10002

	local var_11_0 = arg_11_0.finishBtn

	SculptureActivity = var_1_10004

	var_1_10002(var_11_0, arg_11_1 == var_1_10004.STATE_FINSIH)

	setActive = var_1_10002

	local var_11_1 = arg_11_0.continueBtn

	SculptureActivity = var_4

	if var_4.STATE_UNLOCK <= arg_11_1 then
		SculptureActivity = var_4

		local var_11_2

		if not (arg_11_1 < var_4.STATE_JOINT) then
			var_11_2 = false
		else
			var_11_2 = true
		end

		var_1_10002(var_11_1, var_11_2)

		setActive = var_1_10002

		local var_11_3 = arg_11_0.presentedBtn

		SculptureActivity = var_11_2

		var_1_10002(var_11_3, arg_11_1 == var_11_2.STATE_JOINT)

		setActive = var_1_10002

		local var_11_4 = arg_11_0.lockBtn

		SculptureActivity = var_4

		var_1_10002(var_11_4, arg_11_1 < var_4.STATE_UNLOCK)

		return
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.exited = true

	arg_12_0:ClearChar()

	return
end

return var_0_0
