class = var_0_10000

local var_0_0 = var_0_10000("FriendCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.go = arg_1_1
	tf = var_2
	arg_1_0.tf = var_2(arg_1_1)

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.Find(var_1_0, "frame/request_info/name_bg/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTF = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "icon/icon_bg/icon")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconTF = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0.tf

	arg_1_0.circle = var_2.Find(var_1_6, "icon/icon_bg/frame")
	UIItemList = var_2

	local var_1_7 = var_2.New
	local var_1_8 = arg_1_0.tf
	local var_1_9 = var_3.Find(var_1_8, "icon/icon_bg/stars")
	local var_1_10 = arg_1_0.tf

	arg_1_0.starList = var_1_7(var_1_9, var_4.Find(var_1_10, "icon/icon_bg/stars/star"))

	local var_1_11 = arg_1_0.tf
	local var_1_12 = var_2.Find(var_1_11, "frame/request_content/Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10
	arg_1_0.manifestoTF = var_1_13(var_1_12, var_4(var_1_10))

	local var_1_14 = arg_1_0.tf

	arg_1_0.resumeBtn = var_2.Find(var_1_14, "resume_btn")

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0:clear()

	arg_2_0.friendVO = arg_2_1

	local var_2_0 = arg_2_0.nameTF

	var_2_0.text = arg_2_1.name
	pg = var_2_0

	local var_2_1 = var_2_0.ship_data_statistics[arg_2_1.icon]

	Ship = var_3

	local var_2_2 = var_3.New({
		configId = arg_2_1.icon
	})

	LoadSpriteAsync = var_4

	local var_2_3 = "qicon/"
	local var_2_4 = var_2_2

	var_4(var_2_3 .. var_2_2.getPrefab(var_2_4), function(arg_3_0)
		arg_2_0.iconTF.sprite = arg_3_0

		return
	end)

	AttireFrame = var_4

	local var_2_5 = var_4.attireFrameRes
	local var_2_6 = arg_2_1
	local var_2_7 = arg_2_1.id

	getProxy = var_2_4
	PlayerProxy = var_1_10008

	local var_2_8 = var_2_4(var_1_10008)
	local var_2_9 = var_2_7 == var_7.getRawData(var_2_8).id

	AttireConst = var_7

	local var_2_10 = var_2_5(var_2_6, var_2_9, var_7.TYPE_ICON_FRAME, arg_2_1.propose)

	PoolMgr = var_2_6

	local var_2_11 = var_2_6.GetInstance()

	var_5.GetPrefab(var_2_11, "IconFrame/" .. var_2_10, var_2_10, true, function(arg_4_0)
		IsNil = var_2_10001

		if var_2_10001(arg_2_0.tf) then
			return
		end

		if arg_2_0.circle then
			arg_4_0.name = var_2_10
			findTF = var_1

			local var_4_0 = var_1(arg_4_0.transform, "icon")
			local var_4_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_4_1(var_4_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			var_3(arg_4_0, arg_2_0.circle, false)
		else
			PoolMgr = var_1

			local var_4_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_4_2, "IconFrame/" .. var_2_10, var_2_10, arg_4_0)
		end

		return
	end)

	local var_2_12 = var_2_2:getStar()
	local var_2_13 = arg_2_0.starList

	var_6.align(var_2_13, var_2_12)

	return
end

function var_0_0.clear(arg_5_0)
	if arg_5_0.circle.childCount > 0 then
		local var_5_0 = arg_5_0.circle
		local var_5_1 = var_1.GetChild(var_5_0, 0).gameObject

		PoolMgr = var_5_0

		local var_5_2 = var_5_0.GetInstance()

		var_2.ReturnPrefab(var_5_2, "IconFrame/" .. var_5_1.name, var_5_1.name, var_5_1)
	end

	return
end

function var_0_0.dispose(arg_6_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:clear()

	return
end

return var_0_0
