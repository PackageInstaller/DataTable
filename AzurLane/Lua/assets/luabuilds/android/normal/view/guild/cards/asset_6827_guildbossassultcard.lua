class = var_0_10000

local var_0_0 = var_0_10000("GuildBossAssultCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0._tr = var_1_10002(arg_1_1)
	arg_1_0._go = arg_1_1
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tr, "mask")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.mask = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tr, "icon/icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tr, "info/shipname")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.shipNameTxt = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0._tr, "info/username")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.userNameTxt = var_1_7(var_1_6, var_4(var_1_10005))
	findTF = var_2

	local var_1_8 = var_2(arg_1_0._tr, "info/lv/Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_9(var_1_8, var_4(var_1_10005))
	UIItemList = var_2

	local var_1_10 = var_2.New

	findTF = var_1_8

	local var_1_11 = var_1_8(arg_1_0._tr, "info/stars")

	findTF = var_4
	arg_1_0.startList = var_1_10(var_1_11, var_4(arg_1_0._tr, "info/stars/star_tpl"))
	findTF = var_2
	arg_1_0.recommendBtn = var_2(arg_1_0._tr, "info/recom_btn")

	local var_1_12 = arg_1_0.recommendBtn

	arg_1_0.recommendBtnMark = var_2.Find(var_1_12, "mark")
	findTF = var_2
	arg_1_0.viewEquipmentBtn = var_2(arg_1_0._tr, "info/view_equipment")
	findTF = var_2
	arg_1_0.tag = var_2(arg_1_0._tr, "tag")

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shipNameTxt.text = arg_2_2:getName()
	arg_2_0.ship = arg_2_2
	arg_2_0.member = arg_2_1
	arg_2_0.levelTxt.text = arg_2_2.level

	local var_2_0 = arg_2_2:getMaxStar()
	local var_2_1 = arg_2_2:getStar()
	local var_2_2 = arg_2_0.startList

	var_5.make(var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_3_2:Find("star_tpl"), arg_3_1 <= var_2_1)
		end

		return
	end)

	local var_2_3 = arg_2_0.startList

	var_5.align(var_2_3, var_2_0)

	local var_2_4 = arg_2_0.userNameTxt

	i18n = var_2_3
	var_2_4.text = var_2_3("guild_ship_from") .. arg_2_1.name
	LoadSpriteAsync = var_2_4

	var_2_4("shipYardIcon/" .. arg_2_2:getPainting(), function(arg_4_0)
		if arg_2_0._tr then
			arg_2_0.icon.sprite = arg_4_0
		end

		return
	end)

	local var_2_5 = arg_2_2:rarity2bgPrint()
	local var_2_6 = false

	if #var_2_5 > 1 then
		string = var_7

		if var_7.sub(var_2_5, 1, 1) == "1" then
			var_2_6 = true
		else
			string = var_7
			var_2_5 = var_7.sub(var_2_5, 2, 1)
		end
	end

	local var_2_7 = arg_2_0

	arg_2_0.LoadMetaEffect(var_2_7, var_2_6)

	local var_2_8 = arg_2_0.mask

	GetSpriteFromAtlas = var_2_7
	var_2_8.sprite = var_2_7("ui/GuildBossAssultUI_atlas", var_2_5)
	setActive = var_2_8

	var_2_8(arg_2_0.recommendBtnMark, arg_2_2.guildRecommand)

	setActive = var_2_8

	var_2_8(arg_2_0.tag, arg_2_2.guildRecommand)

	getProxy = var_2_8
	GuildProxy = var_8

	local var_2_9 = var_2_8(var_8)
	local var_2_10 = var_7.getRawData(var_2_9)
	local var_2_11 = var_7.getSelfDuty(var_2_10)

	setActive = var_2_10

	local var_2_12 = arg_2_0.recommendBtn

	GuildMember = var_10

	var_2_10(var_2_12, var_10.IsAdministrator(var_2_11))

	return
end

local var_0_1 = "meta_huoxing"

function var_0_0.LoadMetaEffect(arg_5_0, arg_5_1)
	if arg_5_0.loading then
		arg_5_0.destoryMetaEffect = not arg_5_1

		return
	end

	if arg_5_1 and not arg_5_0.metaEffect then
		arg_5_0.loading = true
		PoolMgr = var_2

		local var_5_0 = var_2.GetInstance()

		var_2.GetUI(var_5_0, var_0_1, true, function(arg_6_0)
			arg_5_0.loading = nil

			if arg_5_0.destoryMetaEffect then
				local var_6_0 = arg_5_0

				var_1.RemoveMetaEffect(var_6_0)

				arg_5_0.destoryMetaEffect = nil
			else
				local var_6_1 = arg_5_0

				var_6_1.metaEffect = arg_6_0
				SetParent = var_6_1

				var_6_1(arg_5_0.metaEffect, arg_5_0._tr)

				setActive = var_6_1

				var_6_1(arg_6_0, true)
			end

			return
		end)
	elseif not arg_5_1 and arg_5_0.metaEffect then
		arg_5_0:RemoveMetaEffect()
	elseif arg_5_0.metaEffect then
		setActive = var_2

		var_2(arg_5_0.metaEffect, true)
	end

	return
end

function var_0_0.RemoveMetaEffect(arg_7_0)
	if arg_7_0.metaEffect then
		PoolMgr = var_1

		local var_7_0 = var_1.GetInstance()

		var_1.ReturnUI(var_7_0, var_0_1, arg_7_0.metaEffect)

		arg_7_0.metaEffect = nil
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveMetaEffect()

	arg_8_0.destoryMetaEffect = true

	return
end

return var_0_0
