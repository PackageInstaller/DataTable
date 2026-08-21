local var_0_0 = class("FriendCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = tf(arg_1_1)
	arg_1_0.nameTF = arg_1_0.tf:Find("frame/request_info/name_bg/Text"):GetComponent(typeof(Text))
	arg_1_0.iconTF = arg_1_0.tf:Find("icon/icon_bg/icon"):GetComponent(typeof(Image))
	arg_1_0.circle = arg_1_0.tf:Find("icon/icon_bg/frame")
	arg_1_0.starList = UIItemList.New(arg_1_0.tf:Find("icon/icon_bg/stars"), arg_1_0.tf:Find("icon/icon_bg/stars/star"))
	arg_1_0.manifestoTF = arg_1_0.tf:Find("frame/request_content/Text"):GetComponent(typeof(Text))
	arg_1_0.resumeBtn = arg_1_0.tf:Find("resume_btn")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0:clear()

	arg_2_0.friendVO = arg_2_1
	arg_2_0.nameTF.text = arg_2_1.name

	local var_2_1 = Ship.New({
		configId = arg_2_1.icon
	})

	LoadSpriteAsync("qicon/" .. var_2_1:getPrefab(), function(arg_3_0)
		arg_2_0.iconTF.sprite = arg_3_0

		return
	end)

	local var_2_2 = arg_2_1.id == getProxy(PlayerProxy):getRawData().id
	local var_2_3 = AttireFrame.attireFrameRes(arg_2_1, var_2_2, AttireConst.TYPE_ICON_FRAME, arg_2_1.propose)

	PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_2_3, var_2_3, true, function(arg_4_0)
		if IsNil(arg_2_0.tf) then
			return
		end

		if arg_2_0.circle then
			arg_4_0.name = var_2_3
			findTF(arg_4_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

			setParent(arg_4_0, arg_2_0.circle, false)
		else
			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_2_3, var_2_3, arg_4_0)
		end

		return
	end)
	arg_2_0.starList:align((var_2_1:getStar()))

	return
end

function var_0_0.clear(arg_5_0)
	if arg_5_0.circle.childCount > 0 then
		local var_5_0 = arg_5_0.circle:GetChild(0).gameObject

		PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_5_0.name, var_5_0.name, var_5_0)
	end

	return
end

function var_0_0.dispose(arg_6_0)
	pg.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:clear()

	return
end

return var_0_0
