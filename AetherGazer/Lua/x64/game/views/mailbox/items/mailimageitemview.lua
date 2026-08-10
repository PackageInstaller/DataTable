local var_0_0 = class("MailImageItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onResize_ = arg_1_2

	arg_1_0:InitUI()
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
		if arg_4_0.data_.event_type > 0 then
			local var_5_0 = arg_4_0.data_.event_type

			if var_5_0 == 1 and arg_4_0.data_.event_arg ~= "" then
				OperationAction.OpenNormalUrl(arg_4_0.data_.event_arg)
			elseif var_5_0 == 2 and arg_4_0.data_.event_arg ~= "" then
				local var_5_1 = string.split(arg_4_0.data_.event_arg, ",")
				local var_5_2 = {}

				for iter_5_0, iter_5_1 in ipairs(var_5_1) do
					table.insert(var_5_2, tonumber(iter_5_1) or iter_5_1)
				end

				JumpTools.JumpToPage2(var_5_2)
			end
		end
	end)
	arg_4_0.richText_:AddListener(function(arg_6_0, arg_6_1)
		if arg_6_0 == 1 then
			OperationAction.OpenNormalUrl(arg_6_1)
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

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.data_ = arg_8_1

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.data_.text

	if var_9_0 then
		arg_9_0.richText_.text = var_9_0
	end

	arg_9_0:GetImageByUrl(arg_9_0.data_.image, function(arg_10_0, arg_10_1)
		if arg_10_0 ~= arg_9_0.data_.image then
			return
		end

		if arg_9_0.gameObject_ == nil then
			return
		end

		arg_9_0.bg_.sprite = arg_10_1

		arg_9_0.bg_:SetNativeSize()

		if arg_9_0.onResize_ ~= nil then
			arg_9_0.onResize_()
		end

		arg_9_0:AddListeners()
	end)
	SetActive(arg_9_0.gameObject_, true)
end

function var_0_0.GetImageByUrl(arg_11_0, arg_11_1, arg_11_2)
	if string.find(arg_11_1, "game://") then
		local var_11_0 = string.gsub(arg_11_1, "game://", "")

		getSpriteWithoutAtlasAsync(var_11_0, function(arg_12_0)
			arg_11_2(arg_11_1, arg_12_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite("mail", arg_11_0.data_.image, function(arg_13_0)
			arg_11_2(arg_11_1, arg_13_0)
		end)
	end
end

function var_0_0.GetHeight(arg_14_0)
	return arg_14_0.bg_.transform.rect.height
end

return var_0_0
