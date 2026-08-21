-- chunkname: @IQIGame\\Module\\SignIn\\SignInModule.lua

SignInModule = {
	CurDateState = false,
	CurMonthDay = 0,
	isGetMothCardAward = false,
	CurMonth = 0,
	MonthSignDay = 0
}

function SignInModule.Reload(SignPod)
	SignInModule.CurDateState = SignPod.state
	SignInModule.MonthSignDay = SignPod.day

	SignInModule.GetAllSignData()
end

function SignInModule.GetSignInCfg(index)
	return CfgSignTable[index]
end

function SignInModule.GetAllSignData()
	SignInModule.SignCfgData = {}

	if tonumber(SignInModule.CurMonth % 2) == 0 then
		for k, v in pairsCfg(CfgSignTable) do
			if v.Type == 2 then
				table.insert(SignInModule.SignCfgData, v)
			end
		end
	else
		for k, v in pairsCfg(CfgSignTable) do
			if v.Type == 1 then
				table.insert(SignInModule.SignCfgData, v)
			end
		end
	end

	table.sort(SignInModule.SignCfgData, function(a, b)
		return a.Day < b.Day
	end)
end

function SignInModule.GetItemShow(itemAwards)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemAwards)
end

function SignInModule.GetMonthHasDay()
	local year = os.date("%Y", PlayerModule.GetServerTime())
	local month = os.date("%m", PlayerModule.GetServerTime())
	local dayAmount = os.date("%d", os.time({
		day = 0,
		year = year,
		month = month + 1
	}))

	SignInModule.CurMonthDay = dayAmount
	SignInModule.CurMonth = month
end

function SignInModule.Sign()
	net_sign.sign(SignInModule.MonthSignDay + 1)
end

function SignInModule.BuyMonthCard()
	local monthCardShopData = ShopModule.GetAllItemsWithShopType(Constant.ShopType.MonthCard.Type)[1]

	if monthCardShopData == nil and not UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_MONTHCARD) then
		NoticeModule.ShowNotice(19001)

		return
	end

	if not monthCardShopData.isBuy then
		NoticeModule.ShowNoticeByType(1, SignInUIApi:GetMonthCardByLimit())

		return
	end

	ShopModule.BuyItem(monthCardShopData, 1)
end

function SignInModule.SignNotify(signPod)
	SignInModule.Reload(signPod)
	EventDispatcher.Dispatch(EventID.SignInNotify)
end

function SignInModule.BuyMonthCardResult()
	return
end

function SignInModule.SignResult(signPOD, itemShowPODS)
	SignInModule.SignNotify(signPOD)
	SignInModule.GetItemShow(itemShowPODS)
end
