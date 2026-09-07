local IslandBuildPage = class("IslandBuildPage")

function IslandBuildPage:Ctor(arg_1_1, arg_1_2)
	self.buildPanel = arg_1_1
	self.activityId = ActivityConst.ISLAND_TASK_ID

	if pg.activity_template[self.activityId].config_client.pt_id and pg.activity_template[self.activityId].config_client.pt_id > 0 then
		self.ptId = pg.activity_template[self.activityId].config_client.pt_id
		self.ptName = pg.player_resource[self.ptId].name
	end

	self.buffs = pg.activity_template[self.activityId].config_client.buff
	self.maxNum = self.buffs[#self.buffs].pt[1]

	setActive(self.buildPanel, false)

	self.pointProgressText = findTF(self.buildPanel, "progressContent/progress")
	self.pointProgressSlider = findTF(self.buildPanel, "slider")
	self.pointStarTpl = findTF(self.buildPanel, "levelStar/starTpl")
	self.pointAdd = findTF(self.buildPanel, "add")
	self.pointLevelStar = findTF(self.buildPanel, "levelStar")
	self.pointStarTfs = {}

	for iter_1_0 = 1, #self.buffs do
		local var_1_0 = tf(Instantiate(self.pointStarTpl))

		SetParent(var_1_0, self.pointLevelStar)
		setActive(var_1_0, true)
		setText(findTF(var_1_0, "bg/text"), iter_1_0)
		setImageSprite(findTF(var_1_0, "img"), LoadSprite(IslandTaskScene.ui_atlas, "img_level_" .. iter_1_0))

		var_1_0.anchoredPosition = Vector3(self.buffs[iter_1_0].pt[1] / self.maxNum * self.pointLevelStar.sizeDelta.x, 0, 0)

		table.insert(self.pointStarTfs, var_1_0)

		if iter_1_0 == 1 then
			setActive(var_1_0, false)
		end
	end

	setText(findTF(self.buildPanel, "levelNum/text"), i18n(IslandTaskScene.island_build_level))
	setText(findTF(self.buildPanel, "levelBuff/text"), i18n(IslandTaskScene.island_build_level))
	setText(findTF(self.buildPanel, "buildDesc"), i18n(IslandTaskScene.island_build_desc))
	self:updatePoint()

	return
end

function IslandBuildPage:updatePoint()
	local var_2_0 = 0

	var_2_0 = self.ptId and (getProxy(PlayerProxy):getData()[self.ptName] or 0) or self:getNum()

	if var_2_0 > self.maxNum then
		var_2_0 = self.maxNum
	end

	local var_2_2 = self:getBuildLv(var_2_0)

	for iter_2_0 = 1, #self.pointStarTfs do
		if iter_2_0 <= var_2_2 then
			setActive(findTF(self.pointStarTfs[iter_2_0], "img"), true)
			setActive(findTF(self.pointStarTfs[iter_2_0], "lock"), false)

			GetComponent(self.pointStarTfs[iter_2_0], typeof(CanvasGroup)).alpha = 1
		else
			setActive(findTF(self.pointStarTfs[iter_2_0], "img"), false)
			setActive(findTF(self.pointStarTfs[iter_2_0], "lock"), true)

			GetComponent(self.pointStarTfs[iter_2_0], typeof(CanvasGroup)).alpha = 0.5
		end
	end

	for iter_2_1 = 1, #self.buffs[var_2_2].benefit do
		local var_2_3 = findTF(self.buildPanel, "add/" .. iter_2_1)

		if PLATFORM_CODE == PLATFORM_JP then
			findTF(var_2_3, "img").sizeDelta = Vector2(450, 70)

			setText(findTF(var_2_3, "text_jp"), pg.benefit_buff_template[self.buffs[var_2_2].benefit[iter_2_1]].desc)
		else
			setText(findTF(var_2_3, "text"), pg.benefit_buff_template[self.buffs[var_2_2].benefit[iter_2_1]].desc)
		end
	end

	setSlider(self.pointProgressSlider, 0, self.maxNum, var_2_0)
	setText(findTF(self.buildPanel, "levelNum/num"), "Lv." .. var_2_2)
	setText(findTF(self.buildPanel, "levelBuff/num"), "Lv." .. var_2_2)
	self:setProgressText()

	return
end

function IslandBuildPage:getBuildLv(arg_3_1)
	local var_3_0 = 1

	for iter_3_0 = #self.buffs, 1, -1 do
		var_3_0 = arg_3_1 >= self.buffs[iter_3_0].pt[1] and var_3_0 < iter_3_0 and iter_3_0 or var_3_0
	end

	return var_3_0
end

function IslandBuildPage:setProgressText()
	setText(self.pointProgressText, setColorStr(self:getNum(), "#C2695B") .. setColorStr("/" .. self.maxNum, "#9D6B59"))

	return
end

function IslandBuildPage:getNum()
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2):GetBuildingLevelSum()
end

function IslandBuildPage:setActive(arg_6_1)
	setActive(self.buildPanel, arg_6_1)

	return
end

function IslandBuildPage:dispose()
	return
end

return IslandBuildPage
