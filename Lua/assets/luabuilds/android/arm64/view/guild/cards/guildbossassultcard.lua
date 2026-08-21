local var_0_0 = class("GuildBossAssultCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tr = tf(arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.mask = findTF(arg_1_0._tr, "mask"):GetComponent(typeof(Image))
	arg_1_0.icon = findTF(arg_1_0._tr, "icon/icon"):GetComponent(typeof(Image))
	arg_1_0.shipNameTxt = findTF(arg_1_0._tr, "info/shipname"):GetComponent(typeof(Text))
	arg_1_0.userNameTxt = findTF(arg_1_0._tr, "info/username"):GetComponent(typeof(Text))
	arg_1_0.levelTxt = findTF(arg_1_0._tr, "info/lv/Text"):GetComponent(typeof(Text))
	arg_1_0.startList = UIItemList.New(findTF(arg_1_0._tr, "info/stars"), findTF(arg_1_0._tr, "info/stars/star_tpl"))
	arg_1_0.recommendBtn = findTF(arg_1_0._tr, "info/recom_btn")
	arg_1_0.recommendBtnMark = arg_1_0.recommendBtn:Find("mark")
	arg_1_0.viewEquipmentBtn = findTF(arg_1_0._tr, "info/view_equipment")
	arg_1_0.tag = findTF(arg_1_0._tr, "tag")

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.shipNameTxt.text = arg_2_2:getName()
	arg_2_0.ship = arg_2_2
	arg_2_0.member = arg_2_1
	arg_2_0.levelTxt.text = arg_2_2.level

	local var_2_0 = arg_2_2:getStar()

	arg_2_0.startList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("star_tpl"), arg_3_1 <= var_2_0)
		end

		return
	end)
	arg_2_0.startList:align((arg_2_2:getMaxStar()))

	arg_2_0.userNameTxt.text = i18n("guild_ship_from") .. arg_2_1.name

	LoadSpriteAsync("shipYardIcon/" .. arg_2_2:getPainting(), function(arg_4_0)
		if arg_2_0._tr then
			arg_2_0.icon.sprite = arg_4_0
		end

		return
	end)

	local var_2_1 = arg_2_2:rarity2bgPrint()
	local var_2_2 = false

	if #var_2_1 > 1 then
		if string.sub(var_2_1, 1, 1) == "1" then
			var_2_2 = true
		else
			var_2_1 = string.sub(var_2_1, 2, 1)
		end
	end

	arg_2_0:LoadMetaEffect(var_2_2)

	arg_2_0.mask.sprite = GetSpriteFromAtlas("ui/GuildBossAssultUI_atlas", var_2_1)

	setActive(arg_2_0.recommendBtnMark, arg_2_2.guildRecommand)
	setActive(arg_2_0.tag, arg_2_2.guildRecommand)
	setActive(arg_2_0.recommendBtn, GuildMember.IsAdministrator((getProxy(GuildProxy):getRawData():getSelfDuty())))

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

		PoolMgr.GetInstance():GetUI(var_0_1, true, function(arg_6_0)
			arg_5_0.loading = nil

			if arg_5_0.destoryMetaEffect then
				arg_5_0:RemoveMetaEffect()

				arg_5_0.destoryMetaEffect = nil
			else
				arg_5_0.metaEffect = arg_6_0

				SetParent(arg_5_0.metaEffect, arg_5_0._tr)
				setActive(arg_6_0, true)
			end

			return
		end)
	elseif not arg_5_1 and arg_5_0.metaEffect then
		arg_5_0:RemoveMetaEffect()
	elseif arg_5_0.metaEffect then
		setActive(arg_5_0.metaEffect, true)
	end

	return
end

function var_0_0.RemoveMetaEffect(arg_7_0)
	if arg_7_0.metaEffect then
		PoolMgr.GetInstance():ReturnUI(var_0_1, arg_7_0.metaEffect)

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
