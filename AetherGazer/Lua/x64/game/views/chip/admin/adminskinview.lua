local var_0_0 = class("AdminSkinView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Administrators/AdministratorsAppearanceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemA = AdminSkinItem.New(arg_3_0.itemLeft_, 100102)
	arg_3_0.itemB = AdminSkinItem.New(arg_3_0.itemRight_, 1001)
	arg_3_0.isLeft = false
	arg_3_0.isRight = true
	arg_3_0.curSkinID = 1001
	arg_3_0.controller = arg_3_0.controllerEx_:GetController("btn")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.leftBtn_, nil, function()
		if arg_4_0.isLeft then
			arg_4_0.anim_:Play("AdministratorsAppearanceUI_b", 0, 0)

			arg_4_0.isLeft = false
			arg_4_0.isRight = true

			arg_4_0.itemA:Refresh(false)
			arg_4_0.itemB:Refresh(true)

			arg_4_0.curSkinID = 1001

			manager.heroRaiseTrack:SetModelState(arg_4_0.curSkinID)
			arg_4_0:RefreshUI()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.rightBtn_, nil, function()
		if arg_4_0.isRight then
			arg_4_0.anim_:Play("AdministratorsAppearanceUI_a", 0, 0)

			arg_4_0.isLeft = true
			arg_4_0.isRight = false

			arg_4_0.itemA:Refresh(true)
			arg_4_0.itemB:Refresh(false)

			arg_4_0.curSkinID = 100102

			manager.heroRaiseTrack:SetModelState(arg_4_0.curSkinID)
			arg_4_0:RefreshUI()
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.useBtn_, nil, function()
		local var_7_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

		if arg_4_0.curSkinID ~= var_7_0 and var_7_0 ~= 0 then
			AdminSystemTools.SelectSkin(1001, arg_4_0.curSkinID)
			manager.heroRaiseTrack:RemainAni("", "Property_Break")
		end
	end)
end

function var_0_0.OnSelectSkin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RefreshUI()
end

function var_0_0.OnEnter(arg_9_0)
	manager.ui:SetMainCamera("admin_sys_skin")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_9_0.itemA:Refresh(arg_9_0.curSkinID ~= 1001)
	arg_9_0.itemB:Refresh(arg_9_0.curSkinID == 1001)
	arg_9_0:RefreshUI()
end

function var_0_0.CameraEnter(arg_10_0)
	local var_10_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		8,
		1
	})
	manager.heroRaiseTrack:SetModelState(var_10_0 == arg_10_0.curSkinID and var_10_0 or arg_10_0.curSkinID)
end

function var_0_0.RefreshUI(arg_11_0)
	SetActive(arg_11_0.leftBtn_.gameObject, arg_11_0.isLeft)
	SetActive(arg_11_0.rightBtn_.gameObject, arg_11_0.isRight)

	local var_11_0 = SkinCfg[arg_11_0.curSkinID]

	arg_11_0.titleText_.text = GetI18NText(var_11_0.name)
	arg_11_0.descText_.text = GetI18NText(var_11_0.desc)

	arg_11_0.itemA:Refresh(arg_11_0.curSkinID ~= 1001)
	arg_11_0.itemB:Refresh(arg_11_0.curSkinID == 1001)

	local var_11_1 = AdminSystemTools.HeroUsingSkinInfo(1001)

	arg_11_0.controller:SetSelectedIndex(arg_11_0.curSkinID == var_11_1 and 1 or 0)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
	arg_12_0.super.OnExit(arg_12_0)
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.scrollHelper_ then
		arg_13_0.scrollHelper_:Dispose()

		arg_13_0.scrollHelper_ = nil
	end

	arg_13_0.itemA:Dispose()
	arg_13_0.itemB:Dispose()

	arg_13_0.itemA = nil
	arg_13_0.itemB = nil

	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
