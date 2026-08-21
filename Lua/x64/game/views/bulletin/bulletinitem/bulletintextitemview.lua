local var_0_0 = class("BulletinTextItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:SetViewProp("bulletinID", arg_1_2)
	arg_1_0:SetViewProp("contentIndex", arg_1_3)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()
	arg_1_0:RefreshUI()
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
			BulletinAction.OpenOperationUrl(arg_5_1)
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

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.richText_.text = GetI18NText(arg_7_0:GetContent(arg_7_0:GetViewProp("bulletinID"), arg_7_0:GetViewProp("contentIndex")).text)

	SetActive(arg_7_0.gameObject_, true)
end

function var_0_0.GetContent(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = SettingData:GetCurrentLanguage()

	for iter_8_0, iter_8_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_8_1.id == arg_8_1 then
			if var_8_0 and iter_8_1.i18n_info_content[var_8_0] then
				return iter_8_1.i18n_info_content[var_8_0][arg_8_2]
			else
				return iter_8_1.content[arg_8_2]
			end
		end
	end
end

return var_0_0
