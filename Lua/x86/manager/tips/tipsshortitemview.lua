local var_0_0 = class("TipsShortItemView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()

	arg_1_0.isFree_ = false
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.text_ = arg_2_0.transform_:Find("Text"):GetComponent("Text")
	arg_2_0.levelImg_ = arg_2_0.transform_:Find("levelImg"):GetComponent("Image")
	arg_2_0.levelImgGo_ = arg_2_0.transform_:Find("levelImg").gameObject
	arg_2_0.levelText_ = arg_2_0.transform_:Find("levelText"):GetComponent("Text")
	arg_2_0.levelTextGo_ = arg_2_0.transform_:Find("levelText").gameObject
	arg_2_0.icon_ = arg_2_0.transform_:Find("icon"):GetComponent("Image")
	arg_2_0.iconGo_ = arg_2_0.transform_:Find("icon").gameObject
end

function var_0_0.IsFree(arg_3_0)
	return arg_3_0.isFree_
end

function var_0_0.SetFree(arg_4_0, arg_4_1)
	arg_4_0.isFree_ = arg_4_1
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:SetFree(false)

	arg_5_0.text_.text = arg_5_1

	arg_5_0:RefreshTips(arg_5_2, arg_5_3)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0.transform_:SetAsLastSibling()

	arg_5_0.transform_.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(arg_5_0.gameObject_, Vector3(1.5, 0.1, 1), 0.1)
	LeanTween.scale(arg_5_0.gameObject_, Vector3.one, 0.1):setDelay(0.1)
	arg_5_0:EndDisplay()
end

function var_0_0.EndDisplay(arg_6_0)
	LeanTween.scale(arg_6_0.gameObject_, Vector3(1, 0.1, 1), 0.1):setDelay(1.5)

	local var_6_0

	var_6_0 = LeanTween.scale(arg_6_0.gameObject_, Vector3.zero, 0.1):setDelay(1.6):setOnComplete(System.Action(function()
		arg_6_0:FinishAction()
		var_6_0:setOnComplete(nil)
	end))
end

function var_0_0.FinishAction(arg_8_0)
	arg_8_0.data_:Finish()
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.FastFinish(arg_9_0)
	LeanTween.cancel(arg_9_0.gameObject_)
end

function var_0_0.RefreshTips(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = TipsCfg[arg_10_1]

	if var_10_0.type == 2 then
		arg_10_0.levelText_.text = ""

		SetActive(arg_10_0.iconGo_, false)
		SetActive(arg_10_0.levelImgGo_, true)
		SetActive(arg_10_0.levelTextGo_, false)

		arg_10_0.levelImg_.sprite = getSprite("Atlas/Tips", var_10_0.pic1)

		arg_10_0.levelImg_:SetNativeSize()
	elseif TipsCfg[arg_10_1].type == 3 then
		arg_10_0.levelText_.text = arg_10_2 or ""

		local var_10_1 = var_10_0.pic1 ~= ""

		SetActive(arg_10_0.iconGo_, true)
		SetActive(arg_10_0.levelImgGo_, var_10_1)
		SetActive(arg_10_0.levelTextGo_, true)

		if var_10_1 then
			arg_10_0.levelImg_.sprite = getSprite("Atlas/Tips", var_10_0.pic1)

			arg_10_0.levelImg_:SetNativeSize()
		end

		arg_10_0.icon_.sprite = getSprite("Atlas/Tips", var_10_0.pic2)

		arg_10_0.icon_:SetNativeSize()
	end
end

function var_0_0.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)

	arg_11_0.transform_ = nil
	arg_11_0.gameObject_ = nil
	arg_11_0.levelText_ = nil
	arg_11_0.levelImg_ = nil
	arg_11_0.text_ = nil
	arg_11_0.iconGo_ = nil
	arg_11_0.icon_ = nil
	arg_11_0.levelTextGo_ = nil
	arg_11_0.levelImgGo_ = nil
end

return var_0_0
