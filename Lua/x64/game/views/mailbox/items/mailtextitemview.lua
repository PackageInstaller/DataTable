local var_0_0 = class("MailTextItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onResize_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:RemoveListeners()
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0.richText_ = arg_3_0:FindCom("RichText", "")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0.richText_:AddListener(function(arg_5_0, arg_5_1)
		if arg_5_0 == "1" then
			OperationAction.OpenNormalUrl(arg_5_1)
		elseif arg_5_0 == "2" then
			local var_5_0 = string.split(arg_5_1, ",")
			local var_5_1 = {}

			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				table.insert(var_5_1, tonumber(iter_5_1) or iter_5_1)
			end

			JumpTools.JumpToPage2(var_5_1)
		end
	end)
end

function var_0_0.RemoveListeners(arg_6_0)
	arg_6_0.richText_:RemoveAllListeners()
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.data_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = string.gsub(arg_8_0.data_.text, "\\n", "\n")

	arg_8_0.richText_.text = var_8_0

	local var_8_1 = arg_8_0:GetTextHeight()

	arg_8_0.transform_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, var_8_1)
	SetActive(arg_8_0.gameObject_, true)

	if arg_8_0.onResize_ ~= nil then
		arg_8_0.onResize_()
	end
end

function var_0_0.GetTextHeight(arg_9_0)
	local var_9_0 = arg_9_0.transform_.rect.size
	local var_9_1 = arg_9_0.gameObject_:GetComponent(typeof(Text))
	local var_9_2 = var_9_1:GetGenerationSettings(var_9_0)
	local var_9_3 = 1 / var_9_1.pixelsPerUnit

	return var_9_1.cachedTextGenerator:GetPreferredHeight(var_9_1.text, var_9_2) * var_9_3
end

function var_0_0.GetHeight(arg_10_0)
	return arg_10_0:GetTextHeight()
end

return var_0_0
