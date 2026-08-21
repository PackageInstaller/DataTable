local var_0_0 = class("DockyardFriend")

var_0_0.DetailType0 = 0
var_0_0.DetailType1 = 1
var_0_0.DetailType2 = 2

local var_0_1 = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.nameTF = arg_1_0.tf:Find("content/request_info/name"):GetComponent(typeof(Text))
	arg_1_0.levelTF = arg_1_0.tf:Find("content/request_info/lv_bg/lv/Text"):GetComponent(typeof(Text))
	arg_1_0.iconTF = arg_1_0.tf:Find("content/icon_contaon/icon"):GetComponent(typeof(Image))
	arg_1_0.starsTF = arg_1_0.tf:Find("content/icon_contaon/stars")
	arg_1_0.starTF = arg_1_0.tf:Find("content/icon_contaon/stars/star")
	arg_1_0.date = arg_1_0.tf:Find("content/date"):GetComponent(typeof(Text))
	arg_1_0.manifestoTF = arg_1_0.tf:Find("content/request_content/bg/Text"):GetComponent(typeof(Text))
	arg_1_0.powerTF = arg_1_0.tf:Find("content/item/value")
	arg_1_0.propose = arg_1_0.tf:Find("content/icon_contaon/propose")
	arg_1_0.content = arg_1_0.tf:Find("content")
	arg_1_0.detail = arg_1_0.tf:Find("detail")
	arg_1_0.detailLayoutTr = findTF(arg_1_0.detail, "layout")
	arg_1_0.quit = arg_1_0.tf:Find("quit_button")
	arg_1_0.selectedGo = findTF(arg_1_0.tf, "selected").gameObject

	arg_1_0.selectedGo:SetActive(false)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.shipVO ~= arg_2_1 then
		arg_2_0.shipVO = arg_2_1

		local var_2_0 = tobool(arg_2_1)

		if var_2_0 then
			arg_2_0.friendVO = arg_2_2[arg_2_1.playerId]

			arg_2_0:flush()
			arg_2_0:flushDetail()
		end

		setActive(arg_2_0.content, var_2_0)
		setActive(arg_2_0.quit, not var_2_0)
	end

	return
end

function var_0_0.updateSelected(arg_3_0, arg_3_1)
	arg_3_0.selected = arg_3_1

	arg_3_0.selectedGo:SetActive(arg_3_0.selected)

	if arg_3_0.selected then
		arg_3_0.selectedTwId = arg_3_0.selectedTwId or LeanTween.alpha(arg_3_0.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif arg_3_0.selectedTwId then
		LeanTween.cancel(arg_3_0.selectedTwId)

		arg_3_0.selectedTwId = nil
	end

	return
end

function var_0_0.flush(arg_4_0)
	if arg_4_0.shipVO then
		local var_4_0 = pg.ship_data_statistics[arg_4_0.shipVO.configId]

		LoadSpriteAsync("qicon/" .. arg_4_0.shipVO:getPainting(), function(arg_5_0)
			arg_4_0.iconTF.sprite = arg_5_0

			return
		end)
		setActive(arg_4_0.propose, arg_4_0.shipVO:ShowPropose())

		for iter_4_0 = arg_4_0.starsTF.childCount, var_4_0.star - 1 do
			cloneTplTo(arg_4_0.starTF, arg_4_0.starsTF)
		end

		for iter_4_1 = 1, arg_4_0.starsTF.childCount do
			setActive(arg_4_0.starsTF:GetChild(iter_4_1 - 1), iter_4_1 <= var_4_0.star)
		end
	end

	if arg_4_0.friendVO then
		arg_4_0.nameTF.text = arg_4_0.friendVO.name
		arg_4_0.levelTF.text = arg_4_0.friendVO.level
		arg_4_0.manifestoTF.text = arg_4_0.friendVO.manifesto or ""
		arg_4_0.date.text = arg_4_0.friendVO.online == Friend.ONLINE and i18n("word_online") or getOfflineTimeStamp(arg_4_0.friendVO.preOnLineTime)
	end

	return
end

function var_0_0.updateDetail(arg_6_0, arg_6_1)
	arg_6_0.detailType = arg_6_1

	arg_6_0:flushDetail()

	return
end

function var_0_0.flushDetail(arg_7_0)
	local var_7_0 = tobool(arg_7_0.shipVO)

	if var_7_0 and arg_7_0.detailType > var_0_0.DetailType0 then
		local var_7_1 = arg_7_0.shipVO:getShipProperties()
		local var_7_2 = arg_7_0.shipVO:getShipCombatPower()

		for iter_7_0 = 1, 6 do
			local var_7_3 = arg_7_0.detailLayoutTr:GetChild(iter_7_0 - 1)
			local var_7_4 = var_7_3:GetChild(0):GetComponent("Text")
			local var_7_5 = var_7_3:GetChild(1):GetComponent("Text")

			if arg_7_0.detailType == var_0_0.DetailType1 then
				if iter_7_0 == 1 then
					var_7_4.alignment = TextAnchor.MiddleCenter
					var_7_4.text = arg_7_0.shipVO:getName()
					var_7_5.text = ""
				else
					var_7_4.text = AttributeType.Type2Name(({
						"name",
						AttributeType.Durability,
						AttributeType.Cannon,
						AttributeType.Torpedo,
						AttributeType.Air,
						AttributeType.AntiAircraft,
						AttributeType.ArmorType,
						AttributeType.Reload,
						AttributeType.Dodge
					})[iter_7_0])
					var_7_5.text = tostring(math.floor(var_7_1[var_7_6]))
				end
			elseif arg_7_0.detailType == var_0_0.DetailType2 then
				if iter_7_0 == 6 then
					var_7_4.text = "<color=#A9F548FF>" .. i18n("word_synthesize_power") .. "</color>"
					var_7_5.text = tostring(var_7_2)
				elseif iter_7_0 == 5 then
					var_7_4.text = "<color=#A9F548FF>" .. i18n("word_level") .. "</color>"
					var_7_5.text = "Lv." .. arg_7_0.shipVO.level
				elseif iter_7_0 == 1 then
					var_7_4.alignment = TextAnchor.MiddleCenter
					var_7_4.text = arg_7_0.shipVO:getShipArmorName()
					var_7_5.text = ""
				elseif iter_7_0 == 4 then
					var_7_4.text = AttributeType.Type2Name(AttributeType.Expend)
					var_7_5.text = tostring(math.floor((arg_7_0.shipVO:getBattleTotalExpend())))
				else
					var_7_4.text = AttributeType.Type2Name(({
						"name",
						AttributeType.Durability,
						AttributeType.Cannon,
						AttributeType.Torpedo,
						AttributeType.Air,
						AttributeType.AntiAircraft,
						AttributeType.ArmorType,
						AttributeType.Reload,
						AttributeType.Dodge
					})[iter_7_0 + 6])
					var_7_5.text = tostring(math.floor(var_7_1[var_7_7]))
				end
			end
		end
	end

	setActive(arg_7_0.detail, var_7_0 and arg_7_0.detailType > var_0_0.DetailType0)

	return
end

function var_0_0.clear(arg_8_0)
	if arg_8_0.selectedTwId then
		LeanTween.cancel(arg_8_0.selectedTwId)

		arg_8_0.selectedTwId = nil
	end

	return
end

return var_0_0
