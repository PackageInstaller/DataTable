local TagTipHelper = class("TagTipHelper")

function TagTipHelper:FuDaiTagTip()
	triggerToggle(self, false)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(pg.pay_data_display.all) do
		if pg.pay_data_display[iter_1_1].type == 1 then
			if pg.TimeMgr.GetInstance():inTime(pg.pay_data_display[iter_1_1].time) and type(pg.pay_data_display[iter_1_1].time) == "table" then
				table.insert(var_1_0, pg.pay_data_display[iter_1_1])
			end
		end
	end

	if #var_1_0 > 0 then
		local function var_1_1(arg_2_0)
			table.sort(var_1_0, function(arg_3_0, arg_3_1)
				return pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_3_0.time[1]) > pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_3_1.time[1])
			end)

			local var_2_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_1_0[1].time[1])

			if arg_2_0[var_1_0[1].id] == nil and PlayerPrefs.GetInt("Ever_Enter_Mall_", 0) < var_2_0 then
				TagTipHelper.FudaiTime = var_2_0

				triggerToggle(self, true)
			end

			return
		end

		local var_1_2 = getProxy(ShopsProxy)
		local var_1_3 = var_1_2:getChargedList()

		if not var_1_3 then
			pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
				callback = function()
					var_1_3 = var_1_2:getChargedList()

					var_1_1(var_1_3)

					return
				end
			})
		else
			var_1_1(var_1_3)
		end
	end

	return
end

function TagTipHelper.SetFuDaiTagMark()
	if TagTipHelper.FudaiTime then
		PlayerPrefs.SetInt("Ever_Enter_Mall_", TagTipHelper.FudaiTime)
		PlayerPrefs.Save()

		TagTipHelper.FudaiTime = nil
	end

	return
end

function TagTipHelper:SkinTagTip()
	triggerToggle(self, false)

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((getProxy(ShipSkinProxy):GetAllSkins())) do
		if iter_6_1.type == Goods.TYPE_SKIN and type(iter_6_1:getConfig("time")) == "table" and iter_6_1.genre ~= ShopArgs.SkinShopTimeLimit then
			table.insert(var_6_0, pg.TimeMgr.GetInstance():parseTimeFromConfig(iter_6_1:getConfig("time")[1]))
		end
	end

	if #var_6_0 > 0 then
		table.sort(var_6_0, function(arg_7_0, arg_7_1)
			return arg_7_1 < arg_7_0
		end)

		local var_6_1 = var_6_0[1]
		local var_6_2 = var_6_0[1] > PlayerPrefs.GetInt("Ever_Enter_Skin_Shop_", 0)

		if var_6_2 then
			TagTipHelper.SkinTime = var_6_1
		end

		triggerToggle(self, var_6_2)
	end

	return
end

function TagTipHelper.SetSkinTagMark()
	if TagTipHelper.SkinTime then
		PlayerPrefs.SetInt("Ever_Enter_Skin_Shop_", TagTipHelper.SkinTime)
		PlayerPrefs.Save()

		TagTipHelper.SkinTime = nil
	end

	return
end

function TagTipHelper:MonthCardTagTip()
	triggerToggle(self, (MonthCardOutDateTipPanel.GetShowMonthCardTag()))

	return
end

function TagTipHelper:GiftPackagesTag()
	getProxy(ShopsProxy):GiftPackageRedDotTip(self, nil)

	return
end

function TagTipHelper:FreeGiftTag()
	local var_11_0 = getProxy(ShopsProxy)

	if not var_11_0:getChargedList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = function()
				if _.all(self, function(arg_13_0)
					return not IsNil(arg_13_0)
				end) then
					for iter_12_0, iter_12_1 in ipairs(self) do
						setActive(iter_12_1, var_11_0:checkHasFreeNormal())
					end
				end

				return
			end
		})
	else
		for iter_11_0, iter_11_1 in ipairs(self) do
			setActive(iter_11_1, var_11_0:checkHasFreeNormal())
		end
	end

	return
end

function TagTipHelper:FreeBuildTicketTip(arg_14_1)
	local var_14_0 = getProxy(ActivityProxy):IsShowFreeBuildMark(false)

	if var_14_0 then
		setActive(self, true)
		LoadImageSpriteAtlasAsync(Drop.New({
			type = DROP_TYPE_VITEM,
			id = var_14_0:getConfig("config_client")[1]
		}):getIcon(), "", self:Find("Image"))

		local var_14_1 = tostring(var_14_0.data1)

		if var_14_0.data1 < 10 then
			var_14_1 = var_14_1 .. " "
		end

		setText(self:Find("Text"), i18n("build_ticket_expire_warning", var_14_1))

		TagTipHelper.BuildMark = true
	else
		setActive(self, false)
	end

	return
end

function TagTipHelper:TecShipGiftTip()
	local var_15_0 = {
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		2008
	}
	local var_15_1 = 30 <= getProxy(PlayerProxy):getData().level
	local var_15_2 = PlayerPrefs.GetInt("Tec_Ship_Gift_Enter_Tag", 0) > 0
	local var_15_3 = false

	for iter_15_0, iter_15_1 in ipairs(pg.pay_data_display.all) do
		if table.contains(var_15_0, iter_15_1) then
			var_15_3 = true

			break
		end
	end

	if var_15_3 and var_15_1 and not var_15_2 then
		triggerToggle(self, true)
	else
		triggerToggle(self, false)
	end

	return
end

function TagTipHelper.SetFreeBuildMark()
	if TagTipHelper.BuildMark then
		local var_16_0 = getProxy(ActivityProxy):IsShowFreeBuildMark(false)

		if var_16_0 then
			PlayerPrefs.SetString("Free_Build_Ticket_" .. var_16_0.id, pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d"))
			PlayerPrefs.Save()
		end

		TagTipHelper.BuildMark = nil
	end

	return
end

return TagTipHelper
