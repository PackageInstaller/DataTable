local var_0_0 = class("GuideTalkItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)

	if arg_3_0.controllerEx_ then
		arg_3_0.heroController = arg_3_0.controllerEx_:GetController("hero")
		arg_3_0.reverseController = arg_3_0.controllerEx_:GetController("reverse")
		arg_3_0.nameController = arg_3_0.controllerEx_:GetController("name")
	end
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.scrollrect_ then
		arg_4_0.scrollrect_.normalizedPosition = Vector2(0, 1)
	end

	arg_4_0.textCom_.text = arg_4_1.talk_content

	local var_4_0, var_4_1 = arg_4_2:GetNarratorInfo()

	if arg_4_0.dialogNameText_ then
		arg_4_0.dialogNameText_.text = var_4_0
	end

	if arg_4_0.dialogHeadImg_ then
		if string.isNullOrEmpty(arg_4_2.talk_icon_path) then
			arg_4_0.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", var_4_1))
		else
			arg_4_0.dialogHeadImg_.sprite = pureGetSpriteWithoutAtlas(arg_4_2.talk_icon_path .. var_4_1)
		end
	end

	if arg_4_0.controllerEx_ then
		if arg_4_1.has_icon == 1 then
			arg_4_0.heroController:SetSelectedState("hide")
			arg_4_0.reverseController:SetSelectedState(arg_4_1.has_name == 1 and "notname" or "nothero")
			arg_4_0.nameController:SetSelectedState("nothero")
		else
			local var_4_2 = arg_4_1.is_reversed == 0 or arg_4_1.is_reversed == nil

			arg_4_0.heroController:SetSelectedState(var_4_2 and "left" or "right")
			arg_4_0.reverseController:SetSelectedState(var_4_2 and "left" or "right")

			if arg_4_1.has_name == 1 then
				arg_4_0.nameController:SetSelectedState("hide")
			else
				arg_4_0.nameController:SetSelectedState(var_4_2 and "left" or "right")
			end
		end
	end
end

function var_0_0.Hide(arg_5_0)
	SetActive(arg_5_0.gameObject_, false)
end

function var_0_0.Show(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
