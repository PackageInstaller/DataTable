local var_0_0 = class("AttireDescPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.icon = findTF(arg_1_0._tf, "icon")
	arg_1_0.frame = findTF(arg_1_0._tf, "frame")
	arg_1_0.chatContainer = findTF(arg_1_0._tf, "chatContainer")
	arg_1_0.conditionTF = findTF(arg_1_0._tf, "condition")
	arg_1_0.nameTxt = findTF(arg_1_0._tf, "name/Text"):GetComponent(typeof(Text))
	arg_1_0.stateTxt = findTF(arg_1_0._tf, "get_info/lock"):GetComponent(typeof(Text))
	arg_1_0.timeTxt = findTF(arg_1_0._tf, "get_info/time"):GetComponent(typeof(Text))
	arg_1_0.conditionTxt = findTF(arg_1_0._tf, "condition/Text"):GetComponent(typeof(Text))
	arg_1_0.applyBtn = findTF(arg_1_0._tf, "apply_btn")
	arg_1_0.applyingBtn = findTF(arg_1_0._tf, "applying_btn")
	arg_1_0.getBtn = findTF(arg_1_0._tf, "get_btn")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:UpdateIconDesc(arg_2_1, arg_2_2)

	arg_2_0.nameTxt.text = HXSet.hxLan(arg_2_1:getConfig("name"))

	local var_2_0 = arg_2_1:isOwned()
	local var_2_1 = var_2_0 and i18n("word_got") or i18n("word_not_get")

	arg_2_0.stateTxt.text = setColorStr(var_2_1, var_2_0 and "#3DC6FFFF" or "#a5afdf")

	local var_2_2 = arg_2_1:expiredType()

	arg_2_0:RemoveTimer()

	if var_2_0 and var_2_2 then
		arg_2_0:AddTimer(arg_2_1, arg_2_2)
	elseif var_2_0 and not var_2_2 then
		arg_2_0.timeTxt.text = ""
	elseif not var_2_0 then
		arg_2_0.timeTxt.text = ""
	end

	arg_2_0.conditionTxt.text = HXSet.hxLan(arg_2_1:getConfig("desc"))

	local var_2_3 = arg_2_1:getState()
	local var_2_4 = arg_2_2:getAttireByType(arg_2_1:getType()) == arg_2_1.id

	setActive(arg_2_0.applyBtn, var_2_3 == AttireFrame.STATE_UNLOCK and not var_2_4)
	setActive(arg_2_0.applyingBtn, var_2_3 == AttireFrame.STATE_UNLOCK and var_2_4)
	setActive(arg_2_0.getBtn, var_2_3 == AttireFrame.STATE_LOCK)

	return
end

function var_0_0.UpdateIconDesc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:getType() == AttireConst.TYPE_ICON_FRAME
	local var_3_1 = arg_3_1:getType() == AttireConst.TYPE_CHAT_FRAME

	if arg_3_0.loadedIcon and arg_3_0.loadedIconTF then
		if var_3_1 then
			arg_3_0.loadedIconTF.transform:Find("Text"):GetComponent(typeof(Text)).supportRichText = false
		end

		PoolMgr.GetInstance():ReturnPrefab(arg_3_0.loadedIcon:getIcon(), arg_3_0.loadedIcon.id, arg_3_0.loadedIconTF)
	end

	if var_3_0 then
		arg_3_0.startList = arg_3_0.startList or UIItemList.New(findTF(arg_3_0._tf, "stars"), findTF(arg_3_0._tf, "stars/tpl"))

		PoolMgr.GetInstance():GetPrefab(arg_3_1:getIcon(), arg_3_1:getConfig("id"), true, function(arg_4_0)
			arg_3_0.loadedIcon = arg_3_1
			arg_3_0.loadedIconTF = arg_4_0

			setParent(arg_4_0, arg_3_0.frame, false)

			return
		end)

		local var_3_2 = arg_3_2:GetFlagShip()

		LoadSpriteAsync("qicon/" .. var_3_2:getPrefab(), function(arg_5_0)
			arg_3_0.icon:GetComponent(typeof(Image)).sprite = arg_5_0

			return
		end)
		arg_3_0.startList:align(var_3_2:getStar())
	elseif var_3_1 then
		PoolMgr.GetInstance():GetPrefab(arg_3_1:getIcon(), arg_3_1:getConfig("id") .. "_self", true, function(arg_6_0)
			arg_3_0.loadedIcon = arg_3_1
			arg_3_0.loadedIconTF = arg_6_0

			setParent(arg_6_0, arg_3_0.chatContainer, false)

			tf(arg_6_0).localPosition = Vector3(0, 0, 0)
			findTF(arg_6_0, "Text"):GetComponent(typeof(Text)).supportRichText = true

			setText(findTF(arg_6_0, "Text"), arg_3_1:getConfig("desc"))

			return
		end)
	end

	setActive(arg_3_0.conditionTF, not var_3_1)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:getExpiredTime()

	arg_7_0.timer = Timer.New(function()
		local var_8_0 = var_7_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 > 0 then
			arg_7_0.timeTxt.text = "/ " .. attireTimeStamp(var_8_0)
		else
			arg_7_0:Update(arg_7_1, arg_7_2)
			arg_7_0:RemoveTimer()
		end

		return
	end, 1, -1)

	arg_7_0.timer:Start()
	arg_7_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()

	return
end

return var_0_0
