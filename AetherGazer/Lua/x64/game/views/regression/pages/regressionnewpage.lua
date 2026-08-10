local var_0_0 = class("RegressionNewPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/ReturnUI/RegressionNewUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Adapt(arg_4_0)
	local var_4_0 = arg_4_0.m_contentTransform.rect.size
	local var_4_1 = arg_4_0.m_rectTransform.rect.size
	local var_4_2 = var_4_0.x / var_4_1.x

	arg_4_0.m_rectTransform.sizeDelta = Vector2.New(var_4_0.x, var_4_1.y * var_4_2)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.SetData(arg_7_0)
	local var_7_0 = RegressionData:GetUrl()

	SetForceShowQuanquan(true)
	arg_7_0:GetImageByUrl(var_7_0, function(arg_8_0, arg_8_1)
		SetForceShowQuanquan(false)

		if arg_8_0 ~= var_7_0 then
			return
		end

		if arg_7_0.gameObject_ == nil then
			return
		end

		arg_7_0.m_bg.sprite = arg_8_1

		arg_7_0.m_bg:SetNativeSize()
		arg_7_0:Adapt()
	end)
end

function var_0_0.GetImageByUrl(arg_9_0, arg_9_1, arg_9_2)
	if string.find(arg_9_1, "game://") then
		local var_9_0 = string.gsub(arg_9_1, "game://", "")

		getSpriteWithoutAtlasAsync(var_9_0, function(arg_10_0)
			arg_9_2(arg_9_1, arg_10_0)
		end)
	else
		BulletinBoardMgr.inst:GetSprite("mail", arg_9_1, function(arg_11_0)
			arg_9_2(arg_9_1, arg_11_0)
		end)
	end
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
