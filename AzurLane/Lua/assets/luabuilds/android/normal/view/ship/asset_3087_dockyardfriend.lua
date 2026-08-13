class = var_0_10000

local var_0_0 = var_0_10000("DockyardFriend")

var_0_0.DetailType0 = 0
var_0_0.DetailType1 = 1
var_0_0.DetailType2 = 2

local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.Find(var_1_0, "content/request_info/name")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTF = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "content/request_info/lv_bg/lv/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTF = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0.tf
	local var_1_7 = var_2.Find(var_1_6, "content/icon_contaon/icon")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconTF = var_1_8(var_1_7, var_4(var_1_10005))

	local var_1_9 = arg_1_0.tf

	arg_1_0.starsTF = var_2.Find(var_1_9, "content/icon_contaon/stars")

	local var_1_10 = arg_1_0.tf

	arg_1_0.starTF = var_2.Find(var_1_10, "content/icon_contaon/stars/star")

	local var_1_11 = arg_1_0.tf
	local var_1_12 = var_2.Find(var_1_11, "content/date")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.date = var_1_13(var_1_12, var_4(var_1_10005))

	local var_1_14 = arg_1_0.tf
	local var_1_15 = var_2.Find(var_1_14, "content/request_content/bg/Text")
	local var_1_16 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.manifestoTF = var_1_16(var_1_15, var_4(var_1_10005))

	local var_1_17 = arg_1_0.tf

	arg_1_0.powerTF = var_2.Find(var_1_17, "content/item/value")

	local var_1_18 = arg_1_0.tf

	arg_1_0.propose = var_2.Find(var_1_18, "content/icon_contaon/propose")

	local var_1_19 = arg_1_0.tf

	arg_1_0.content = var_2.Find(var_1_19, "content")

	local var_1_20 = arg_1_0.tf

	arg_1_0.detail = var_2.Find(var_1_20, "detail")
	findTF = var_2
	arg_1_0.detailLayoutTr = var_2(arg_1_0.detail, "layout")

	local var_1_21 = arg_1_0.tf

	arg_1_0.quit = var_2.Find(var_1_21, "quit_button")
	findTF = var_2
	arg_1_0.selectedGo = var_2(arg_1_0.tf, "selected").gameObject

	local var_1_22 = arg_1_0.selectedGo

	var_2.SetActive(var_1_22, false)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.shipVO ~= arg_2_1 then
		arg_2_0.shipVO = arg_2_1
		tobool = var_3

		if var_3(arg_2_1) then
			arg_2_0.friendVO = arg_2_2[arg_2_1.playerId]

			arg_2_0:flush()
			arg_2_0:flushDetail()
		end

		setActive = var_4

		var_4(arg_2_0.content, var_3)

		setActive = var_4

		var_4(arg_2_0.quit, not var_3)
	end

	return
end

function var_0_0.updateSelected(arg_3_0, arg_3_1)
	arg_3_0.selected = arg_3_1

	local var_3_0 = arg_3_0.selectedGo

	var_2.SetActive(var_3_0, arg_3_0.selected)

	if arg_3_0.selected then
		if not arg_3_0.selectedTwId then
			LeanTween = var_2

			local var_3_1 = var_2.alpha(arg_3_0.selectedGo.transform, 1, var_0_1)
			local var_3_2 = var_2.setFrom(var_3_1, 0)
			local var_3_3 = var_2.setEase

			LeanTweenType = var_4

			local var_3_4 = var_3_3(var_3_2, var_4.easeInOutSine)

			arg_3_0.selectedTwId = var_2.setLoopPingPong(var_3_4).uniqueId
		end
	elseif arg_3_0.selectedTwId then
		LeanTween = var_2

		var_2.cancel(arg_3_0.selectedTwId)

		arg_3_0.selectedTwId = nil
	end

	return
end

function var_0_0.flush(arg_4_0)
	if arg_4_0.shipVO then
		pg = var_1

		local var_4_0 = var_1.ship_data_statistics[arg_4_0.shipVO.configId]

		LoadSpriteAsync = var_2

		local var_4_1 = "qicon/"
		local var_4_2 = arg_4_0.shipVO

		var_2(var_4_1 .. var_4.getPainting(var_4_2), function(arg_5_0)
			arg_4_0.iconTF.sprite = arg_5_0

			return
		end)

		setActive = var_2

		local var_4_3 = arg_4_0.propose
		local var_4_4 = arg_4_0.shipVO

		var_2(var_4_3, var_4.ShowPropose(var_4_4))

		for iter_4_0 = arg_4_0.starsTF.childCount, var_4_0.star - 1 do
			cloneTplTo = var_1_10007

			var_1_10007(arg_4_0.starTF, arg_4_0.starsTF)
		end

		for iter_4_1 = 1, var_2 do
			local var_4_5 = arg_4_0.starsTF
			local var_4_6 = var_7.GetChild(var_4_5, iter_4_1 - 1)

			setActive = var_4_5

			var_4_5(var_4_6, iter_4_1 <= var_4_0.star)
		end
	end

	if arg_4_0.friendVO then
		arg_4_0.nameTF.text = arg_4_0.friendVO.name
		arg_4_0.levelTF.text = arg_4_0.friendVO.level

		local var_4_7 = arg_4_0.manifestoTF
		local var_4_8

		if not arg_4_0.friendVO.manifesto then
			var_4_8 = ""
		end

		var_4_7.text = var_4_8

		local var_4_9 = arg_4_0.friendVO.online

		Friend = var_4_8

		if var_4_9 == var_4_8.ONLINE then
			local var_4_10 = arg_4_0.date

			i18n = var_2
			var_4_10.text = var_2("word_online")
		else
			local var_4_11 = arg_4_0.date

			getOfflineTimeStamp = var_2
			var_4_11.text = var_2(arg_4_0.friendVO.preOnLineTime)
		end
	end

	return
end

function var_0_0.updateDetail(arg_6_0, arg_6_1)
	arg_6_0.detailType = arg_6_1

	arg_6_0:flushDetail()

	return
end

function var_0_0.flushDetail(arg_7_0)
	local var_7_0 = arg_7_0.shipVO

	tobool = var_1_10002

	local var_7_1

	if var_1_10002(var_7_0) and arg_7_0.detailType > var_0_0.DetailType0 then
		var_7_1 = var_7_0:getShipProperties()

		local var_7_2 = {
			"name"
		}

		AttributeType = var_1_10005
		var_7_2[2] = var_1_10005.Durability
		AttributeType = var_5
		var_7_2[3] = var_5.Cannon
		AttributeType = var_5
		var_7_2[4] = var_5.Torpedo
		AttributeType = var_5
		var_7_2[5] = var_5.Air
		AttributeType = var_5
		var_7_2[6] = var_5.AntiAircraft
		AttributeType = var_5
		var_7_2[7] = var_5.ArmorType
		AttributeType = var_5
		var_7_2[8] = var_5.Reload
		AttributeType = var_5
		var_7_2[9] = var_5.Dodge

		local var_7_3 = var_7_0:getShipCombatPower()

		for iter_7_0 = 1, 6 do
			local var_7_4 = arg_7_0.detailLayoutTr
			local var_7_5 = var_10.GetChild(var_7_4, iter_7_0 - 1)
			local var_7_6 = var_10.GetChild(var_7_5, 0)
			local var_7_7 = var_11.GetComponent(var_7_6, "Text")
			local var_7_8 = var_10:GetChild(1)
			local var_7_9 = var_12.GetComponent(var_7_8, "Text")

			if arg_7_0.detailType == var_0_0.DetailType1 then
				local var_7_10

				if iter_7_0 == 1 then
					TextAnchor = var_13
					var_7_7.alignment = var_13.MiddleCenter
					var_7_10 = arg_7_0.shipVO
					var_7_7.text = var_13.getName(var_7_10)
					var_7_9.text = ""
				else
					local var_7_11 = var_7_2[iter_7_0]

					AttributeType = var_7_10
					var_7_7.text = var_7_10.Type2Name(var_7_11)
					tostring = var_14
					math = var_1_10015
					var_7_9.text = var_14(var_1_10015.floor(var_7_1[var_7_11]))
				end
			elseif arg_7_0.detailType == var_0_0.DetailType2 then
				local var_7_12

				if iter_7_0 == 6 then
					var_7_12 = "<color=#A9F548FF>"
					i18n = var_7_13
					var_7_7.text = var_7_12 .. var_7_13("word_synthesize_power") .. "</color>"
					tostring = var_7_12
					var_7_9.text = var_7_12(var_7_3)
				elseif iter_7_0 == 5 then
					var_7_12 = "<color=#A9F548FF>"
					i18n = var_7_13
					var_7_7.text = var_7_12 .. var_7_13("word_level") .. "</color>"
					var_7_9.text = "Lv." .. arg_7_0.shipVO.level
				else
					local var_7_13

					if iter_7_0 == 1 then
						TextAnchor = var_7_12
						var_7_7.alignment = var_7_12.MiddleCenter
						var_7_13 = var_7_0
						var_7_7.text = var_7_0.getShipArmorName(var_7_13)
						var_7_9.text = ""
					elseif iter_7_0 == 4 then
						AttributeType = var_7_12

						local var_7_14 = var_7_12.Type2Name

						AttributeType = var_7_13
						var_7_7.text = var_7_14(var_7_13.Expend)
						var_7_13 = var_7_0

						local var_7_15 = var_7_0.getBattleTotalExpend(var_7_13)

						tostring = var_7_13
						math = var_1_10015
						var_7_9.text = var_7_13(var_1_10015.floor(var_7_15))
					else
						local var_7_16 = var_7_2[iter_7_0 + 6]

						AttributeType = var_7_13
						var_7_7.text = var_7_13.Type2Name(var_7_16)
						tostring = var_14
						math = var_1_10015
						var_7_9.text = var_14(var_1_10015.floor(var_7_1[var_7_16]))
					end
				end
			end
		end
	end

	setActive = var_7_1

	var_7_1(arg_7_0.detail, var_2 and arg_7_0.detailType > var_0_0.DetailType0)

	return
end

function var_0_0.clear(arg_8_0)
	if arg_8_0.selectedTwId then
		LeanTween = var_1

		var_1.cancel(arg_8_0.selectedTwId)

		arg_8_0.selectedTwId = nil
	end

	return
end

return var_0_0
