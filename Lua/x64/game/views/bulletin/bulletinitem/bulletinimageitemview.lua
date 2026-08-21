local var_0_0 = class("BulletinImageItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:SetViewProp("bulletinID", arg_1_2)
	arg_1_0:SetViewProp("contentIndex", arg_1_3)
	arg_1_0:InitUI()
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
	arg_3_0.bg_ = arg_3_0:FindCom(typeof(Image), "")
	arg_3_0.richText_ = arg_3_0:FindCom("RichText", "RichText")
	arg_3_0.btn_ = arg_3_0:FindCom(typeof(Button), "")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0:GetContent(arg_4_0:GetViewProp("bulletinID"), arg_4_0:GetViewProp("contentIndex"))

		if var_5_0.event then
			local var_5_1 = var_5_0.event[1]

			if var_5_1 == 1 and var_5_0.event[2] ~= "" then
				BulletinAction.OpenOperationUrl(var_5_0.event[2])
			elseif var_5_1 == 2 and var_5_0.event[2] ~= "" then
				local var_5_2 = string.split(var_5_0.event[2], ",")
				local var_5_3 = {}

				for iter_5_0, iter_5_1 in ipairs(var_5_2) do
					table.insert(var_5_3, tonumber(iter_5_1) or iter_5_1)
				end

				JumpTools.JumpToPage2(var_5_3)
			end
		end
	end)
	arg_4_0.richText_:AddListener(function(arg_6_0, arg_6_1)
		if arg_6_0 == 1 then
			BulletinAction.OpenOperationUrl(arg_6_1)
		elseif arg_6_0 == 2 then
			local var_6_0 = string.split(arg_6_1, ",")
			local var_6_1 = {}

			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				table.insert(var_6_1, tonumber(iter_6_1) or iter_6_1)
			end

			JumpTools.JumpToPage2(var_6_1)
		end
	end)
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0.btn_.onClick:RemoveAllListeners()
	arg_7_0.richText_:RemoveAllListeners()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0:GetContent(arg_8_0:GetViewProp("bulletinID"), arg_8_0:GetViewProp("contentIndex"))
	local var_8_1 = var_8_0.text

	if var_8_1 then
		arg_8_0.richText_.text = GetI18NText(var_8_1)
	end

	SetForceShowQuanquan(true)
	arg_8_0:GetImageByUrl(var_8_0.spriteUrl, function(arg_9_0, arg_9_1)
		SetForceShowQuanquan(false)

		if arg_9_0 ~= var_8_0.spriteUrl then
			return
		end

		if arg_8_0.gameObject_ == nil then
			return
		end

		arg_8_0.bg_.sprite = arg_9_1

		arg_8_0.bg_:SetNativeSize()
		arg_8_0:AddListeners()
	end)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.GetImageByUrl(arg_10_0, arg_10_1, arg_10_2)
	if string.find(arg_10_1, "game://") then
		local var_10_0 = string.gsub(arg_10_1, "game://", "")

		getSpriteWithoutAtlasAsync(var_10_0, function(arg_11_0)
			arg_10_2(arg_10_1, arg_11_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite(arg_10_0:GetViewProp("bulletinID"), arg_10_1, function(arg_12_0)
			arg_10_2(arg_10_1, arg_12_0)
		end)
	end
end

function var_0_0.GetContent(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SettingData:GetCurrentLanguage()

	for iter_13_0, iter_13_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_13_1.id == arg_13_1 then
			if var_13_0 and iter_13_1.i18n_info_content[var_13_0] then
				return iter_13_1.i18n_info_content[var_13_0][arg_13_2]
			else
				return iter_13_1.content[arg_13_2]
			end
		end
	end
end

return var_0_0
