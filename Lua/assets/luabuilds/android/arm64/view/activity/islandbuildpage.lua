local var_0_0 = class("IslandBuildPage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.buildPanel = arg_1_1
	arg_1_0.activityId = ActivityConst.ISLAND_TASK_ID

	if pg.activity_template[arg_1_0.activityId].config_client.pt_id and pg.activity_template[arg_1_0.activityId].config_client.pt_id > 0 then
		arg_1_0.ptId = pg.activity_template[arg_1_0.activityId].config_client.pt_id
		arg_1_0.ptName = pg.player_resource[arg_1_0.ptId].name
	end

	arg_1_0.buffs = pg.activity_template[arg_1_0.activityId].config_client.buff
	arg_1_0.maxNum = arg_1_0.buffs[#arg_1_0.buffs].pt[1]

	setActive(arg_1_0.buildPanel, false)

	arg_1_0.pointProgressText = findTF(arg_1_0.buildPanel, "progressContent/progress")
	arg_1_0.pointProgressSlider = findTF(arg_1_0.buildPanel, "slider")
	arg_1_0.pointStarTpl = findTF(arg_1_0.buildPanel, "levelStar/starTpl")
	arg_1_0.pointAdd = findTF(arg_1_0.buildPanel, "add")
	arg_1_0.pointLevelStar = findTF(arg_1_0.buildPanel, "levelStar")
	arg_1_0.pointStarTfs = {}

	for iter_1_0 = 1, #arg_1_0.buffs do
		local var_1_0 = tf(Instantiate(arg_1_0.pointStarTpl))

		SetParent(var_1_0, arg_1_0.pointLevelStar)
		setActive(var_1_0, true)
		setText(findTF(var_1_0, "bg/text"), iter_1_0)
		setImageSprite(findTF(var_1_0, "img"), LoadSprite(IslandTaskScene.ui_atlas, "img_level_" .. iter_1_0))

		var_1_0.anchoredPosition = Vector3(arg_1_0.buffs[iter_1_0].pt[1] / arg_1_0.maxNum * arg_1_0.pointLevelStar.sizeDelta.x, 0, 0)

		table.insert(arg_1_0.pointStarTfs, var_1_0)

		if iter_1_0 == 1 then
			setActive(var_1_0, false)
		end
	end

	setText(findTF(arg_1_0.buildPanel, "levelNum/text"), i18n(IslandTaskScene.island_build_level))
	setText(findTF(arg_1_0.buildPanel, "levelBuff/text"), i18n(IslandTaskScene.island_build_level))
	setText(findTF(arg_1_0.buildPanel, "buildDesc"), i18n(IslandTaskScene.island_build_desc))
	arg_1_0:updatePoint()

	return
end

function var_0_0.updatePoint(arg_2_0)
	local var_2_0 = 0

	var_2_0 = arg_2_0.ptId and (getProxy(PlayerProxy):getData()[arg_2_0.ptName] or 0) or arg_2_0:getNum()

	if var_2_0 > arg_2_0.maxNum then
		var_2_0 = arg_2_0.maxNum
	end

	local var_2_2 = arg_2_0:getBuildLv(var_2_0)

	for iter_2_0 = 1, #arg_2_0.pointStarTfs do
		if iter_2_0 <= var_2_2 then
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_0], "img"), true)
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_0], "lock"), false)

			GetComponent(arg_2_0.pointStarTfs[iter_2_0], typeof(CanvasGroup)).alpha = 1
		else
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_0], "img"), false)
			setActive(findTF(arg_2_0.pointStarTfs[iter_2_0], "lock"), true)

			GetComponent(arg_2_0.pointStarTfs[iter_2_0], typeof(CanvasGroup)).alpha = 0.5
		end
	end

	for iter_2_1 = 1, #arg_2_0.buffs[var_2_2].benefit do
		local var_2_3 = findTF(arg_2_0.buildPanel, "add/" .. iter_2_1)

		if PLATFORM_CODE == PLATFORM_JP then
			findTF(var_2_3, "img").sizeDelta = Vector2(450, 70)

			setText(findTF(var_2_3, "text_jp"), pg.benefit_buff_template[arg_2_0.buffs[var_2_2].benefit[iter_2_1]].desc)
		else
			setText(findTF(var_2_3, "text"), pg.benefit_buff_template[arg_2_0.buffs[var_2_2].benefit[iter_2_1]].desc)
		end
	end

	setSlider(arg_2_0.pointProgressSlider, 0, arg_2_0.maxNum, var_2_0)
	setText(findTF(arg_2_0.buildPanel, "levelNum/num"), "Lv." .. var_2_2)
	setText(findTF(arg_2_0.buildPanel, "levelBuff/num"), "Lv." .. var_2_2)
	arg_2_0:setProgressText()

	return
end

function var_0_0.getBuildLv(arg_3_0, arg_3_1)
	local var_3_0 = 1

	for iter_3_0 = #arg_3_0.buffs, 1, -1 do
		var_3_0 = arg_3_1 >= arg_3_0.buffs[iter_3_0].pt[1] and var_3_0 < iter_3_0 and iter_3_0 or var_3_0
	end

	return var_3_0
end

function var_0_0.setProgressText(arg_4_0)
	setText(arg_4_0.pointProgressText, setColorStr(arg_4_0:getNum(), "#C2695B") .. setColorStr("/" .. arg_4_0.maxNum, "#9D6B59"))

	return
end

function var_0_0.getNum(arg_5_0)
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetBuildingLevelSum()
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	setActive(arg_6_0.buildPanel, arg_6_1)

	return
end

function var_0_0.dispose(arg_7_0)
	return
end

return var_0_0
