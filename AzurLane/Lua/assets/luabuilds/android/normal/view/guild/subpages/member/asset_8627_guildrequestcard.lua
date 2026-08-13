class = var_0_10000

local var_0_0 = var_0_10000("GuildRequestCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0.tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.Find(var_1_0, "frame/request_info/name")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTF = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "frame/request_info/level")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTF = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0.tf
	local var_1_7 = var_2.Find(var_1_6, "frame/request_info/date")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.dateTF = var_1_8(var_1_7, var_4(var_1_10005))

	local var_1_9 = arg_1_0.tf
	local var_1_10 = var_2.Find(var_1_9, "frame/request_content/Text")
	local var_1_11 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.msg = var_1_11(var_1_10, var_4(var_1_10005))

	local var_1_12 = arg_1_0.tf
	local var_1_13 = var_2.Find(var_1_12, "frame/shipicon/icon")
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconTF = var_1_14(var_1_13, var_4(var_1_10005))

	local var_1_15 = arg_1_0.tf

	arg_1_0.starsTF = var_2.Find(var_1_15, "frame/shipicon/stars")

	local var_1_16 = arg_1_0.tf

	arg_1_0.circle = var_2.Find(var_1_16, "frame/shipicon/frame")

	local var_1_17 = arg_1_0.tf

	arg_1_0.starTF = var_2.Find(var_1_17, "frame/shipicon/stars/star")

	local var_1_18 = arg_1_0.tf

	arg_1_0.rejectBtn = var_2.Find(var_1_18, "frame/refuse_btn")

	local var_1_19 = arg_1_0.tf

	arg_1_0.accpetBtn = var_2.Find(var_1_19, "frame/accpet_btn")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0:Clear()

	arg_2_0.requestVO = arg_2_1
	arg_2_0.nameTF.text = arg_2_1.player.name

	local var_2_0 = arg_2_0.levelTF

	var_2_0.text = "Lv." .. arg_2_1.player.level
	getOfflineTimeStamp = var_2_0

	local var_2_1 = var_2_0(arg_2_1.timestamp)

	arg_2_0.dateTF.text = var_2_1
	arg_2_0.msg.text = arg_2_1.content

	local var_2_2 = arg_2_1.player

	AttireFrame = var_4

	local var_2_3 = var_4.attireFrameRes
	local var_2_4 = var_2_2
	local var_2_5 = var_2_2.id

	getProxy = var_1_10007
	PlayerProxy = var_1_10008

	local var_2_6 = var_1_10007(var_1_10008)
	local var_2_7 = var_2_5 == var_7.getRawData(var_2_6).id

	AttireConst = var_7

	local var_2_8 = var_2_3(var_2_4, var_2_7, var_7.TYPE_ICON_FRAME, var_2_2.propose)

	PoolMgr = var_2_4

	local var_2_9 = var_2_4.GetInstance()

	var_5.GetPrefab(var_2_9, "IconFrame/" .. var_2_8, var_2_8, true, function(arg_3_0)
		IsNil = var_2_10001

		if var_2_10001(arg_2_0.tf) then
			return
		end

		if arg_2_0.circle then
			arg_3_0.name = var_2_8
			findTF = var_1

			local var_3_0 = var_1(arg_3_0.transform, "icon")
			local var_3_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_3_1(var_3_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			var_3(arg_3_0, arg_2_0.circle, false)
		else
			PoolMgr = var_1

			local var_3_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_3_2, "IconFrame/" .. var_2_8, var_2_8, arg_3_0)
		end

		return
	end)

	pg = var_5

	if var_5.ship_data_statistics[arg_2_1.player.icon] then
		local var_2_10 = arg_2_1.player
		local var_2_11 = var_6.getPainting(var_2_10)

		LoadSpriteAsync = var_2_10

		var_2_10("qicon/" .. var_2_11, function(arg_4_0)
			arg_2_0.iconTF.sprite = arg_4_0

			return
		end)

		for iter_2_0 = arg_2_0.starsTF.childCount, var_5.star - 1 do
			cloneTplTo = var_1_10012

			var_1_10012(arg_2_0.starTF, arg_2_0.starsTF)
		end

		for iter_2_1 = 1, var_7 do
			local var_2_12 = arg_2_0.starsTF
			local var_2_13 = var_12.GetChild(var_2_12, iter_2_1 - 1)

			setActive = var_2_12

			var_2_12(var_2_13, iter_2_1 <= var_5.star)
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	if arg_5_0.circle.childCount > 0 then
		local var_5_0 = arg_5_0.circle
		local var_5_1 = var_1.GetChild(var_5_0, 0).gameObject.name

		PoolMgr = var_3

		local var_5_2 = var_3.GetInstance()

		var_3.ReturnPrefab(var_5_2, "IconFrame/" .. var_5_1, var_5_1, var_1.gameObject)
	end

	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:Clear()

	return
end

return var_0_0
