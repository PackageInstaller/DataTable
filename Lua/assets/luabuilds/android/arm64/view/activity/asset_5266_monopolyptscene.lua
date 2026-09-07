local MonopolyPtScene = class("MonopolyPtScene", import("..base.BaseUI"))

MonopolyPtScene.story = false

local var_0_1 = 312011
local var_0_2 = 312010
local var_0_3 = "kaibaoxiang_boss"
local var_0_4 = "kaibaoxiang_putong"
local var_0_5 = "unknown3"

MonopolyPtScene.battle = false

local var_0_6 = {
	201211,
	401231,
	301051,
	101171
}
local var_0_7 = {
	201217,
	431232,
	331055,
	131171
}
local var_0_11 = "stand"
local var_0_14 = "dafuweng_run"
local var_0_15 = "dafuweng_touch"
local var_0_16 = "maoxian_baoxiang"
local var_0_17 = "maoxian_gold"
local var_0_18 = "maoxian_item"
local var_0_19 = "maoxian_oil"
local var_0_23 = "back"
local var_0_24 = "mid"
local var_0_25 = "front"
local var_0_27 = 1920
local var_0_29 = false
local var_0_30 = 0
local var_0_31 = {
	700,
	1400,
	2100,
	2800,
	3500,
	4200,
	4900,
	5600,
	6300,
	7000,
	9000,
	9650,
	10200,
	10900,
	11600,
	12300,
	13000,
	13800,
	14500,
	15430
}

function MonopolyPtScene:getUIName()
	return "MonopolyPtUI"
end

function MonopolyPtScene:init()
	self:initData()
	self:initUI()
	self:initEvent()
	self:activityDataUpdata()
	self:updataUI()
	self:initMap()

	return
end

function MonopolyPtScene:initMap()
	if self.useCount < 9 then
		self:createMap("ground_1")
	elseif self.useCount == 9 then
		self:createMap("ground_2")
		self:createMap("ground_3")
		self:createMap("ground_4")
	elseif self.useCount == 10 then
		self:createMap("ground_3")
		self:createMap("ground_4")
	elseif self.useCount > 9 and self.useCount < 19 then
		self:createMap("ground_4")
	elseif self.useCount == 19 then
		self:createMap("ground_5")

		if MonopolyPtScene.battle then
			LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
				local var_4_0 = self:getPtData()
				local var_4_1, var_4_2 = var_4_0:GetResProgress()

				pg.m02:sendNotification(GAME.ACT_NEW_PT, {
					cmd = 1,
					activity_id = var_4_0:GetId(),
					arg1 = var_4_2
				})

				return
			end))

			if self.baoxiangModel then
				local var_3_0 = self.baoxiangModel:GetComponent(typeof(SpineAnimUI))

				self:setModelAnim(var_3_0, "boss_kaiqi", 1, function()
					self:setModelAnim(var_3_0, "boss_kai", 0, nil)

					return
				end)
				self:changeCharAction(var_0_16, 1, nil)
			else
				self.baoxiangKai = true
			end

			if self.anims then
				self:changeCharAction(var_0_16, 1, nil)
			else
				self.charMaoxian = true
			end
		end
	elseif self.useCount >= 20 then
		self:createMap("ground_5")
	end

	if self.useCount > 0 then
		if MonopolyPtScene.battle and self.useCount >= 19 then
			self:updateMap(var_0_31[#var_0_31])
		else
			self:updateMap(var_0_31[self.useCount])
		end

		for iter_3_0 = 1, 20 do
			self.translate.anchoredPosition = Vector2(self.mid.anchoredPosition.x + self.distance, 0)

			if self.mapTf:InverseTransformPoint(self.translate.position).x <= var_0_27 - 600 then
				self:createMap()
			end
		end
	end

	if self.useCount == 0 and not MonopolyPtScene.story then
		setActive(self.btnStart, false)
		setActive(self.btnBack, false)
		setActive(self.btnMain, false)
		setActive(self.labelDropShip, false)
		pg.NewStoryMgr.GetInstance():Play(self:getStoryData(0), function()
			MonopolyPtScene.story = true

			setActive(self.btnStart, true)
			setActive(self.btnBack, true)
			setActive(self.btnMain, true)
			setActive(self.labelDropShip, false)
			self:updataUI()

			return
		end, true, true)
	end

	return
end

local var_0_32 = {
	1,
	1,
	1,
	2,
	3,
	4,
	4,
	4,
	5
}

function MonopolyPtScene:createMap(arg_7_1)
	self.mapIndexs = self.mapIndexs or Clone(var_0_32)

	if #self.mapIndexs == 0 then
		return
	end

	arg_7_1 = "ground_" .. table.remove(self.mapIndexs, 1)

	if arg_7_1 == "ground_2" or arg_7_1 == "ground_3" or arg_7_1 == "ground_5" then
		self.onceMap = self.onceMap or {}

		if table.contains(self.onceMap, arg_7_1) then
			return
		else
			table.insert(self.onceMap, arg_7_1)
		end
	end

	local var_7_0 = tf(Instantiate((findTF(self.groundTf, arg_7_1))))
	local var_7_1 = findTF(var_7_0, "back")

	SetParent(var_7_1, self.back)
	setActive(var_7_1, true)

	var_7_1.anchoredPosition = Vector2(self.distance, 0)

	var_7_1:SetAsFirstSibling()

	local var_7_2 = findTF(var_7_0, "mid")

	SetParent(var_7_2, self.mid)
	setActive(var_7_2, true)

	var_7_2.anchoredPosition = Vector2(self.distance, 0)

	local var_7_3 = findTF(var_7_0, "front")

	SetParent(var_7_3, self.front)
	setActive(var_7_3, true)

	var_7_3.anchoredPosition = Vector2(self.distance, 0)

	Destroy(var_7_0)

	self.distance = self.distance + var_7_0.sizeDelta.x

	if self.cellPos then
		self.cellPos:SetAsLastSibling()
	end

	if self.char then
		self.char:SetAsLastSibling()
	end

	if arg_7_1 == "ground_2" then
		self.housePosition = findTF(var_7_2, "house/img").position
	elseif arg_7_1 == "ground_5" then
		self.endPosition = findTF(var_7_2, "house/img").position
	end

	if arg_7_1 == "ground_2" then
		PoolMgr.GetInstance():GetSpineChar(Ship.New({
			configId = var_0_1,
			skin_id = var_0_2
		}):getPrefab(), true, function(arg_8_0)
			self.mingShimodel = arg_8_0
			self.mingShimodel.transform.localScale = Vector3(0.4, 0.4, 0.4)
			self.mingShimodel.transform.localPosition = Vector3.zero

			self.mingShimodel.transform:SetParent(findTF(var_7_2, "house/char"), false)
			self:setModelAnim(self.mingShimodel:GetComponent(typeof(SpineAnimUI)), var_0_11, 0, nil)

			return
		end)
	elseif arg_7_1 == "ground_5" then
		if self.useCount <= 19 and not MonopolyPtScene.battle then
			PoolMgr.GetInstance():GetSpineChar(var_0_5, true, function(arg_9_0)
				self.enemyModel = arg_9_0
				self.enemyModel.transform.localScale = Vector3(0.4, 0.4, 0.4)
				self.enemyModel.transform.localPosition = Vector3.zero

				self.enemyModel.transform:SetParent(findTF(var_7_2, "house/enemy"), false)
				self:setModelAnim(self.enemyModel:GetComponent(typeof(SpineAnimUI)), "normal", 0, nil)

				return
			end)
		else
			PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_10_0)
				self.baoxiangModel = arg_10_0
				self.baoxiangModel.transform.localScale = Vector3(0.3, 0.3, 0.3)
				self.baoxiangModel.transform.localPosition = Vector3.zero

				self.baoxiangModel.transform:SetParent(findTF(var_7_2, "house/baoxiang"), false)

				local var_10_0 = self.baoxiangModel:GetComponent(typeof(SpineAnimUI))

				if self.baoxiangKai then
					self.baoxiangKai = false

					local var_10_1 = self.baoxiangModel:GetComponent(typeof(SpineAnimUI))

					self:setModelAnim(var_10_1, "boss_kaiqi", 1, function()
						self:setModelAnim(var_10_1, "boss_kai", 0, nil)

						return
					end)
					self:changeCharAction(var_0_16, 1, nil)
				elseif self.useCount >= 20 then
					self:setModelAnim(var_10_0, "boss_kai", 0, nil)
				else
					self:setModelAnim(var_10_0, "boss_guan", 0, nil)
					setActive(self.baoxiangModel, false)
				end

				return
			end)
		end
	end

	return
end

function MonopolyPtScene:initData()
	self.distance = 0
	self.moveDistance = 0
	self.activityId = self.contextData.config_id
	self.leftCount = 0
	self.inAnimatedFlag = false
	self.lastBonusTimes = 0
	self.baoxiangCells = {}
	self.storys = pg.activity_template[self.activityId].config_client.story
	self.battles = pg.activity_template[self.activityId].config_client.battle
	self.awardsTimer = Timer.New(function()
		if self.awardTfs and #self.awardTfs > 0 then
			for iter_13_0 = #self.awardTfs, 1, -1 do
				self.awardTfs[iter_13_0].anchoredPosition.y = self.awardTfs[iter_13_0].anchoredPosition.y + 3

				if self.awardTfs[iter_13_0].anchoredPosition.y >= 150 then
					Destroy(table.remove(self.awardTfs, iter_13_0))
				else
					self.awardTfs[iter_13_0].anchoredPosition = self.awardTfs[iter_13_0].anchoredPosition
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	self.awardsTimer:Start()

	return
end

function MonopolyPtScene:initUI()
	self._ad = findTF(self._tf, "AD")
	self.char = findTF(self._ad, "map/mask/container/mid/char")
	self.btnStart = findTF(self._ad, "btnStart")
	self.btnBack = findTF(self._ad, "btnBack")
	self.labelCount = findTF(self._ad, "btnStart/txt")

	setActive(self.btnStart, true)

	self.btnMain = findTF(self._ad, "btnMain")
	self.labelDropShip = findTF(self._ad, "labelDropShip")
	self.mapTf = findTF(self._ad, "map")
	self.container = findTF(self._ad, "map/mask/container")
	self.back = findTF(self._ad, "map/mask/container/back")
	self.mid = findTF(self._ad, "map/mask/container/mid")
	self.front = findTF(self._ad, "map/mask/container/front")
	self.cellPos = findTF(self._ad, "map/mask/container/mid/posCell")
	self.tplCell = findTF(self._ad, "tplCell")
	self.mapCells = {}
	self.curCellIndex = nil
	self.translate = findTF(self.container, "translate")
	self.awardTf = findTF(self._ad, "awardTpl")
	self.awardParent = findTF(self.char, "award")
	self.groundTf = findTF(self._ad, "map/mask/container/ground")

	setActive(self.groundTf, false)

	self.models = {}
	self.anims = {}
	self.modelIds = {}
	self.clickModelTime = {}

	for iter_14_0 = 1, #var_0_6 do
		local var_14_0 = iter_14_0
		local var_14_1 = var_0_6[iter_14_0]

		PoolMgr.GetInstance():GetSpineChar(Ship.New({
			configId = var_0_6[iter_14_0],
			skin_id = var_0_7[iter_14_0]
		}):getPrefab(), true, function(arg_15_0)
			arg_15_0.transform.localScale = Vector3.one
			arg_15_0.transform.localPosition = Vector3(0, 0, 0)
			arg_15_0.transform.anchorMin = Vector2(0.5, 0)
			arg_15_0.transform.anchorMax = Vector2(0.5, 0)

			arg_15_0.transform:SetParent(findTF(self.char, var_14_0), false)

			local var_15_0 = arg_15_0:GetComponent(typeof(SpineAnimUI))

			table.insert(self.modelIds, var_14_1)
			table.insert(self.models, arg_15_0)
			table.insert(self.anims, var_15_0)

			if #self.anims == #var_0_6 then
				if self.charMaoxian then
					self.charMaoxian = false

					self:changeCharAction(var_0_16, 0, nil)
				else
					self:changeCharAction(var_0_11, 0, nil)
				end
			end

			table.insert(self.clickModelTime, 0)
			onButton(self._binder, findTF(self.char, var_14_0).transform, function()
				if not var_15_0 or not arg_15_0 or self.inAnimatedFlag then
					return
				end

				if Time.time - self.clickModelTime[var_14_0] < 3 then
					return
				end

				self.clickModelTime[var_14_0] = Time.time

				if LeanTween.isTweening(go(self.cellPos)) then
					return
				end

				self:setModelAnim(var_15_0, var_0_15, 1, function()
					self:setModelAnim(var_15_0, var_0_11, 0, nil)

					return
				end)

				return
			end, SFX_PANEL)

			return
		end)
	end

	return
end

function MonopolyPtScene:initEvent()
	onButton(self._binder, self.btnStart, function()
		if self.leftCount and self.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		local var_19_0 = {}
		local var_19_1 = self:getPtData():GetAward()
		local var_19_2 = getProxy(PlayerProxy):getRawData()
		local var_19_3, var_19_4 = Task.StaticJudgeOverflow(var_19_2.gold, var_19_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_19_1.type,
				var_19_1.id,
				var_19_1.count
			}
		})

		if var_19_3 then
			table.insert(var_19_0, function(arg_20_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_19_4,
					onYes = arg_20_0
				})

				return
			end)
		end

		seriesAsync(var_19_0, function()
			self:start()

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnBack, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self._binder, self.btnMain, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function MonopolyPtScene:getPtData()
	return (ActivityPtData.New((getProxy(ActivityProxy):getActivityById(self.activityId))))
end

function MonopolyPtScene:addAwards(arg_25_1)
	self.awardTfs = self.awardTfs or {}

	for iter_25_0 = 1, #arg_25_1 do
		local var_25_0 = tf(instantiate(go(self.awardTf)))

		setParent(var_25_0, self.awardParent)
		updateDrop(var_25_0, arg_25_1[iter_25_0])

		var_25_0.anchoredPosition = Vector2(0, 0)

		setActive(var_25_0, true)
		table.insert(self.awardTfs, var_25_0)
	end

	return
end

function MonopolyPtScene:start()
	if self.inAnimatedFlag then
		return
	end

	if self.leftCount and self.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		return
	end

	self:changeAnimeState(true)
	self:move(var_0_14, function()
		return
	end)

	return
end

function MonopolyPtScene:checkCountStory(arg_28_1)
	local var_28_0 = self.useCount
	local var_28_1 = _.detect(self.activity:getDataConfig("story") or {}, function(arg_29_0)
		return arg_29_0[1] == var_28_0
	end)

	if var_28_1 then
		pg.NewStoryMgr.GetInstance():Play(var_28_1[2], arg_28_1)
	else
		arg_28_1()
	end

	return
end

function MonopolyPtScene:changeAnimeState(arg_30_1, arg_30_2)
	if arg_30_1 then
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		self.inAnimatedFlag = true
	else
		self.inAnimatedFlag = false
		self.btnStart:GetComponent(typeof(Image)).raycastTarget = true
	end

	setActive(self.btnStart, not arg_30_1)

	return
end

function MonopolyPtScene:updataActivity(arg_31_1)
	self:activityDataUpdata()
	self:updataUI()

	if self.useCount == 9 then
		self:createMap("ground_2")
		self:createMap("ground_3")
	elseif self.useCount == 19 then
		self:createMap("ground_5")
	end

	return
end

function MonopolyPtScene:activityDataUpdata()
	local var_32_0 = ActivityPtData.New((getProxy(ActivityProxy):getActivityById(self.activityId)))
	local var_32_1, var_32_2, var_32_3 = var_32_0:GetResProgress()
	local var_32_4 = var_32_0:GetLevel()
	local var_32_5 = var_32_0:CanGetAward()
	local var_32_6 = var_32_0:CanGetNextAward()
	local var_32_7 = math.floor(var_32_1 / 500) - var_32_4

	if 20 - var_32_4 < var_32_7 then
		var_32_7 = 20 - var_32_4
	end

	self.useCount = var_32_4
	self.leftCount = var_32_7

	if var_0_29 then
		var_0_30 = var_0_30 + 1
		self.useCount = var_0_30
		self.leftCount = 20 - var_0_30
	end

	self.leftLastDrop = 20 - self.useCount

	return
end

function MonopolyPtScene:updataUI()
	if self.leftLastDrop then
		setText(findTF(self.labelDropShip, "text"), "" .. self.leftLastDrop)
		setActive(self.labelDropShip, self.leftLastDrop > 0)
	end

	setText(self.labelCount, self.leftCount)

	if self.useCount >= 20 then
		setActive(self.btnStart, false)
	end

	return
end

function MonopolyPtScene:updataChar()
	if not isActive(self.char) then
		SetActive(self.char, true)
		self.char:SetAsLastSibling()
	end

	return
end

function MonopolyPtScene:move(arg_35_1, arg_35_2)
	local var_35_0 = {}

	table.insert(var_35_0, function(arg_36_0)
		if self.useCount >= #var_0_31 then
			self.useCount = #var_0_31 - 1
		end

		local var_36_0 = var_0_31[self.useCount + 1] - self.moveDistance

		if self.useCount == 9 and self.housePosition then
			-- block empty
		elseif self.useCount == 19 and self.endPosition then
			-- block empty
		elseif self.useCount == 10 then
			self:createCell(var_36_0)
		else
			self:createCell(var_36_0)
		end

		local var_36_1 = var_36_0 / 250
		local var_36_2 = 0

		self:changeCharAction(arg_35_1, 0, nil)

		if LeanTween.isTweening(go(self.cellPos)) then
			LeanTween.cancel(go(self.cellPos))
		end

		LeanTween.value(go(self.cellPos), 0, var_36_0, var_36_1):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_37_0)
			self:updateMap(arg_37_0 - var_36_2)

			var_36_2 = arg_37_0

			return
		end)):setOnComplete(System.Action(function()
			local var_38_0

			if self.useCount > 1 then
				var_38_0 = self:getStoryData(self.useCount + 1)
			end

			local var_38_1 = self:getBattle(self.useCount + 1)
			local var_38_2 = self.useCount + 1

			self:changeCharAction(var_0_11, 0, nil)

			local function var_38_3()
				local var_39_0 = self:getPtAwardData(var_38_2)

				assert(var_39_0)

				if var_39_0[1] == 1 and var_39_0[2] == 1 then
					self:setModelAnim(self.anims[1], var_0_17, 1, function()
						self:setModelAnim(self.anims[1], var_0_11, 0)

						return
					end)
				elseif var_39_0[1] == 1 and var_39_0[2] == 2 then
					self:setModelAnim(self.anims[1], var_0_19, 1, function()
						self:setModelAnim(self.anims[1], var_0_11, 0)

						return
					end)
				elseif var_39_0[1] == 2 and var_39_0[2] == 0 then
					self:setModelAnim(self.anims[1], var_0_18, 1, function()
						self:setModelAnim(self.anims[1], var_0_11, 0)

						return
					end)
				else
					self:setModelAnim(self.anims[1], var_0_16, 1, function()
						self:setModelAnim(self.anims[1], var_0_11, 0)

						return
					end)
				end

				for iter_39_0 = 2, #self.anims do
					self:setModelAnim(self.anims[iter_39_0], var_0_16, 1, function()
						self:setModelAnim(self.anims[iter_39_0], var_0_11, 0)

						return
					end)
				end

				return
			end

			if self.putongModel then
				local var_38_4 = self.putongModel:GetComponent(typeof(SpineAnimUI))

				self:setModelAnim(var_38_4, "putong_kaiqi", 1, function()
					if var_38_4 then
						self:setModelAnim(var_38_4, "putong_kai", 0, nil)
					end

					return
				end)

				self.putongModel = nil
			end

			if var_38_0 and tonumber(var_38_0) ~= 0 then
				pg.NewStoryMgr.GetInstance():Play(var_38_0, function()
					if var_38_3 then
						var_38_3()
					end

					LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
						arg_36_0()

						return
					end))

					return
				end, true, true)
			elseif self.useCount == 19 and tonumber(var_38_1) ~= 0 and not MonopolyPtScene.battle then
				MonopolyPtScene.battle = true

				pg.m02:sendNotification(GAME.BEGIN_STAGE, {
					system = SYSTEM_PERFORM,
					stageId = tonumber(var_38_1)
				})
			else
				if var_38_3 then
					var_38_3()
				end

				LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
					arg_36_0()

					return
				end))
			end

			return
		end))

		return
	end)
	table.insert(var_35_0, function(arg_49_0)
		local var_49_0 = self:getPtData()
		local var_49_1, var_49_2 = var_49_0:GetResProgress()

		pg.m02:sendNotification(GAME.ACT_NEW_PT, {
			cmd = 1,
			activity_id = var_49_0:GetId(),
			arg1 = var_49_2
		})
		self:changeAnimeState(false)
		self:updataActivity()
		arg_49_0()

		return
	end)
	seriesAsync(var_35_0, arg_35_2)

	return
end

function MonopolyPtScene:getBattle(arg_50_1)
	for iter_50_0 = 1, #self.battles do
		if self.battles[iter_50_0][1] == arg_50_1 then
			return self.battles[iter_50_0][2]
		end
	end

	return nil
end

function MonopolyPtScene:getStoryData(arg_51_1)
	for iter_51_0 = 1, #self.storys do
		if self.storys[iter_51_0][1] == arg_51_1 then
			return self.storys[iter_51_0][2]
		end
	end

	return nil
end

function MonopolyPtScene:createCell(arg_52_1, arg_52_2)
	local var_52_0 = tf(instantiate(go(self.tplCell)))

	var_52_0.localPosition = Vector3(self.cellPos:InverseTransformPoint(self.char.position).x + arg_52_1 + 100, 0, 0)
	var_52_0.localScale = Vector3(0.5, 0.5, 0.5)

	setActive(findTF(var_52_0, "bg_gold"), false)
	setActive(findTF(var_52_0, "bg_oil"), false)
	setActive(findTF(var_52_0, "bg_item"), false)

	local var_52_1 = self:getPtAwardData(self.useCount + 1)

	if var_52_1 then
		if var_52_1[1] == 1 and var_52_1[2] == 1 then
			setActive(findTF(var_52_0, "bg_gold"), true)
		elseif var_52_1[1] == 1 and var_52_1[2] == 2 then
			setActive(findTF(var_52_0, "bg_oil"), true)
		elseif var_52_1[1] == 2 and var_52_1[2] == 0 then
			setActive(findTF(var_52_0, "bg_item"), true)
		else
			PoolMgr.GetInstance():GetSpineChar(var_0_4, true, function(arg_53_0)
				if var_52_0 then
					arg_53_0.transform.localScale = Vector3(0.5, 0.5, 0.5)
					arg_53_0.transform.localPosition = Vector3.zero

					arg_53_0.transform:SetParent(findTF(var_52_0, "baoxiang"), false)
					self:setModelAnim(arg_53_0:GetComponent(typeof(SpineAnimUI)), "putong_guan", 0, nil)

					self.putongModel = arg_53_0
				else
					table.insert(self.baoxiangCells, arg_53_0)
					setActive(arg_53_0, false)
				end

				return
			end)
		end
	else
		setActive(findTF(var_52_0, "bg_item"), true)
	end

	setActive(var_52_0, true)
	setParent(var_52_0, self.cellPos)
	table.insert(self.mapCells, var_52_0)

	return
end

function MonopolyPtScene:getPtAwardData(arg_54_1)
	self.ptDatas = self.ptDatas or pg.activity_event_pt[self.activityId].drop_client

	if arg_54_1 <= #self.ptDatas then
		return self.ptDatas[arg_54_1]
	end

	return nil
end

function MonopolyPtScene:insertMapTf(arg_55_1, arg_55_2, arg_55_3)
	if arg_55_2 == var_0_23 then
		SetParent(arg_55_1, findTF(self.container, "back"))
	elseif arg_55_2 == var_0_24 then
		SetParent(arg_55_1, findTF(self.container, "mid"))
	elseif arg_55_2 == var_0_25 then
		SetParent(arg_55_1, findTF(self.container, "front"))
	else
		print("没有配置层级，无法分配背景tf")
	end

	setActive(arg_55_1, true)

	arg_55_1.anchoredPosition = Vector2(arg_55_3, 0)

	return
end

function MonopolyPtScene:sortMap(arg_56_1)
	local var_56_0 = {}

	for iter_56_0 = 1, #self.mapGround do
		if self.mapGround[iter_56_0].layer == arg_56_1 then
			table.insert(var_56_0, self.mapGround[iter_56_0])
		end
	end

	table.sort(var_56_0, function(arg_57_0, arg_57_1)
		if arg_57_0.index > arg_57_1.index then
			return false
		elseif arg_57_0.index < arg_57_1.index then
			return true
		end

		return
	end)

	for iter_56_1 = 1, #var_56_0 do
		for iter_56_2, iter_56_3 in ipairs(var_56_0[iter_56_1].tfs) do
			iter_56_3:SetAsLastSibling()
		end
	end

	return
end

function MonopolyPtScene:getGround(arg_58_1)
	for iter_58_0 = 1, #self.mapGround do
		if self.mapGround[iter_58_0].name == arg_58_1 then
			return self.mapGround[iter_58_0]
		end
	end

	return nil
end

function MonopolyPtScene:updateMap(arg_59_1, arg_59_2)
	if self.char then
		self.char.anchoredPosition = Vector2(self.char.anchoredPosition.x + arg_59_1, self.char.anchoredPosition.y)
	end

	self.translate.anchoredPosition = Vector2(self.mid.anchoredPosition.x + self.distance - arg_59_1, 0)

	if self.mapTf:InverseTransformPoint(self.translate.position).x <= var_0_27 - 600 then
		if self.useCount < 9 then
			self:createMap("ground_1")
		elseif self.useCount < 20 then
			self:createMap("ground_4")
		end
	end

	self.moveDistance = self.moveDistance + arg_59_1
	self.back.anchoredPosition = Vector2(self.back.anchoredPosition.x - arg_59_1, 0)
	self.mid.anchoredPosition = Vector2(self.mid.anchoredPosition.x - arg_59_1, 0)
	self.front.anchoredPosition = Vector2(self.front.anchoredPosition.x - arg_59_1, 0)

	if #self.mapCells > 0 and self.mapTf:InverseTransformPoint(self.mapCells[1].position).x < -1500 then
		Destroy((table.remove(self.mapCells, 1)))
	end

	return
end

function MonopolyPtScene:setModelAnim(arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	arg_60_1:SetActionCallBack(nil)
	arg_60_1:SetAction(arg_60_2, 0)
	arg_60_1:SetActionCallBack(function(arg_61_0)
		if arg_61_0 == "finish" then
			if arg_60_3 == 1 then
				arg_60_1:SetActionCallBack(nil)
			end

			if arg_60_4 then
				arg_60_4()
			end
		end

		return
	end)

	if arg_60_3 ~= 1 and arg_60_4 then
		arg_60_4()
	end

	return
end

function MonopolyPtScene:changeCharAction(arg_62_1, arg_62_2, arg_62_3)
	for iter_62_0 = 1, #self.anims do
		local var_62_0 = iter_62_0
		local var_62_1 = self.anims[iter_62_0]

		self.anims[iter_62_0]:SetActionCallBack(nil)
		self.anims[iter_62_0]:SetAction(arg_62_1, 0)
		self.anims[iter_62_0]:SetActionCallBack(function(arg_63_0)
			if arg_63_0 == "finish" then
				if arg_62_2 == 1 then
					var_62_1:SetActionCallBack(nil)
					var_62_1:SetAction(var_0_11, 0)
				end

				if var_62_0 == 1 and arg_62_3 then
					arg_62_3()
				end
			end

			return
		end)

		if iter_62_0 == 1 and arg_62_2 ~= 1 and arg_62_3 then
			arg_62_3()
		end
	end

	return
end

function MonopolyPtScene:onHide()
	return
end

function MonopolyPtScene:willExit()
	if LeanTween.isTweening(go(self.cellPos)) then
		LeanTween.cancel(go(self.cellPos))
	end

	if LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if #self.baoxiangCells > 0 then
		for iter_65_0 = 1, #self.baoxiangCells do
			PoolMgr.GetInstance():ReturnSpineChar(var_0_4, self.baoxiangCells[iter_65_0])
		end

		self.baoxiangCells = {}
	end

	if self.enemyModel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_5, self.enemyModel)
	end

	if self.baoxiangModel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_3, self.baoxiangModel)
	end

	if self.mingShimodel then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, self.mingShimodel)
	end

	for iter_65_1 = 1, #self.models do
		PoolMgr.GetInstance():ReturnSpineChar(self.modelIds[iter_65_1], self.models[iter_65_1])
	end

	for iter_65_2 = #self.mapCells, 1, -1 do
		Destroy(self.mapCells[iter_65_2])
	end

	self.mapCells = {}

	if self.awardsTimer then
		if self.awardsTimer.running then
			self.awardsTimer:Stop()
		end

		self.awardsTimer = nil
	end

	if self.awardTfs and #self.awardTfs > 0 then
		for iter_65_3 = #self.awardTfs, 1, -1 do
			Destroy(table.remove(self.awardTfs, iter_65_3))
		end
	end

	return
end

return MonopolyPtScene
