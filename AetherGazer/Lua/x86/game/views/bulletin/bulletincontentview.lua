local var_0_0 = class("BulletinContentView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.bulletinItem_ = {}

	arg_1_0:InitUI()
end

function var_0_0.SetBulletInId(arg_2_0, arg_2_1)
	arg_2_0:SetViewProp("bulletinID", arg_2_1)
	arg_2_0:RefreshContent()
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.timer_ ~= nil then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end

	for iter_5_0 = #arg_5_0.bulletinItem_, 1, -1 do
		arg_5_0.bulletinItem_[iter_5_0]:Dispose()

		arg_5_0.bulletinItem_[iter_5_0] = nil
	end

	arg_5_0.bulletinItem_ = nil
	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.itemParent_ = arg_6_0.gameObject_
end

function var_0_0.RefreshContent(arg_7_0)
	SetActive(arg_7_0.itemParent_.gameObject, false)

	for iter_7_0 = #arg_7_0.bulletinItem_, 1, -1 do
		arg_7_0.bulletinItem_[iter_7_0]:Dispose()

		arg_7_0.bulletinItem_[iter_7_0] = nil
	end

	for iter_7_1, iter_7_2 in ipairs(arg_7_0:GetContent(arg_7_0:GetViewProp("bulletinID"))) do
		if iter_7_2.itemType == 1 then
			local var_7_0 = Object.Instantiate(arg_7_0.imageItem_, arg_7_0.itemParent_.transform)

			table.insert(arg_7_0.bulletinItem_, BulletinImageItemView.New(var_7_0, arg_7_0:GetViewProp("bulletinID"), iter_7_1))
		elseif iter_7_2.itemType == 2 then
			local var_7_1 = Object.Instantiate(arg_7_0.textItem_, arg_7_0.itemParent_.transform)

			table.insert(arg_7_0.bulletinItem_, BulletinTextItemView.New(var_7_1, arg_7_0:GetViewProp("bulletinID"), iter_7_1))
		elseif iter_7_2.itemType == 4 then
			local var_7_2 = Object.Instantiate(arg_7_0.titleItem_, arg_7_0.itemParent_.transform)

			table.insert(arg_7_0.bulletinItem_, BulletinTitleItemView.New(var_7_2, arg_7_0:GetViewProp("bulletinID"), iter_7_1))
		end
	end

	if arg_7_0.timer_ ~= nil then
		arg_7_0.timer_:Stop()
	end

	arg_7_0.timer_ = TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.itemParent_.transform)
		SetActive(arg_7_0.itemParent_.gameObject, true)
	end, {})
end

function var_0_0.SwitchBulletinPage(arg_9_0, arg_9_1)
	arg_9_0:SetViewProp("bulletinID", arg_9_1)
	arg_9_0:RefreshContent()
end

function var_0_0.GetContent(arg_10_0, arg_10_1)
	local var_10_0 = manager.time:GetServerTime()
	local var_10_1 = SettingData:GetCurrentLanguage()

	for iter_10_0, iter_10_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_10_1.id == arg_10_1 and var_10_0 < iter_10_1.endTime then
			if var_10_1 and iter_10_1.i18n_info_content[var_10_1] then
				return iter_10_1.i18n_info_content[var_10_1]
			else
				return iter_10_1.content
			end
		end
	end

	return {}
end

return var_0_0
