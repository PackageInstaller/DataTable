local LiquorFloorMapScene = class("LiquorFloorMapScene", import("view.base.BaseUI"))

function LiquorFloorMapScene:getUIName()
	return "LiquorFloorUI"
end

LiquorFloorMapScene.RANDOM_POS = {
	Vector2.New(121.6, 121.6),
	Vector2.New(-258.5, 22.8),
	Vector2.New(-166.1, 283),
	Vector2.New(-647.1, -14),
	Vector2.New(-440.7, -26.8),
	Vector2.New(-534.5, -285.1),
	Vector2.New(279.7, -299.1),
	Vector2.New(599.7, -299.1),
	Vector2.New(897.5, -15.2),
	Vector2.New(468.8, -15.2),
	Vector2.New(952.9, 166.2),
	Vector2.New(10.9, -91.6)
}
LiquorFloorMapScene.TOP_POS = {
	Vector2.New(213, 152),
	Vector2.New(15, -137),
	Vector2.New(348, -50),
	Vector2.New(-32, -6),
	Vector2.New(-296, -267),
	Vector2.New(399, -113)
}
LiquorFloorMapScene.architecturePos = {
	Vector2.New(-224.8, 183),
	Vector2.New(-435, -81.5),
	Vector2.New(452.5, 320.5),
	Vector2.New(201, 53),
	Vector2.New(26, -236.5),
	Vector2.New(641.5, -63)
}

function LiquorFloorMapScene:SetActivity(arg_2_1)
	self.activity = arg_2_1

	return
end

function LiquorFloorMapScene:init()
	self.ui = self._tf:Find("ui")
	self.fightBtn = self.ui:Find("fightBtn")
	self.taskBtn = self.ui:Find("decorate/decorate1_1/decorate1_2/taskBtn")
	self.storyBtn = self.ui:Find("decorate/decorate1_1/storyBtn")
	self.architectureData = {
		self.ui:Find("architecture/muchang_bg"),
		self.ui:Find("architecture/nongchang_bg"),
		self.ui:Find("architecture/kuangchang_bg"),
		self.ui:Find("architecture/sheyingpeng_bg"),
		self.ui:Find("architecture/huochezhan_bg"),
		self.ui:Find("architecture/jiudian_bg")
	}
	self.architectureMapData = {
		self._tf:Find("bgs/muchang_xiao"),
		self._tf:Find("bgs/nongchang_xiao"),
		self._tf:Find("bgs/kuangchang_xiao"),
		self._tf:Find("bgs/sheyingpeng_xiao"),
		self._tf:Find("bgs/huochezhan_xiao"),
		self._tf:Find("bgs/jiudian_xiao")
	}
	self.lv = self.ui:Find("LV")
	self.top = self.ui:Find("top")
	self.backBtn = self.top:Find("back_button")
	self.homeBtn = self.top:Find("home_button")
	self.slotTFs = self._tf:Find("bgs/content")
	self.slotTpl = self._tf:Find("bgs/content/tpl")

	setActive(self.slotTpl, false)

	self.box = self.ui:Find("box")

	SetActive(self.box, false)

	self.Text_new = self.ui:Find("LV/Lv_bg/Text_new")

	SetActive(self.Text_new, false)

	self.taskTip = self.ui:Find("decorate/decorate1_1/decorate1_2/taskBtn/tip")

	setText(self.top:Find("title/Text1"), i18n("LiquorFloor_title"))
	setText(self.top:Find("title/Text2"), i18n("LiquorFloor_title_en"))
	setText(self.ui:Find("decorate/decorate1_1/storyBtn/Text"), i18n("LiquorFloor_story_title"))
	setText(self.ui:Find("decorate/decorate1_1/decorate1_2/taskBtn/Text"), i18n("LiquorFloorTaskUI_title"))

	return
end

function LiquorFloorMapScene:OnStoryList()
	self.gather1 = {}
	self.gather2 = {}
	self.gather3 = {}
	self.client = self.activity:getConfig("config_client").BookData

	for iter_4_0, iter_4_1 in ipairs(self.client[1].data1) do
		table.insert(self.gather1, iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(self.client[2].data2) do
		table.insert(self.gather2, iter_4_3)
	end

	for iter_4_4, iter_4_5 in ipairs(self.client[3].data3) do
		table.insert(self.gather3, iter_4_5)
	end

	self.storyList = {}

	self:OnStory()

	return
end

function LiquorFloorMapScene:didEnter()
	self:OnStoryList()
	self:InitData()
	onButton(self, self.fightBtn, function()
		self:emit(LiquorFloorMapMediator.GO_FIGHT)

		return
	end, SFX_CANCEL)
	onButton(self, self.taskBtn, function()
		self:emit(LiquorFloorMapMediator.OPEN_LAYER, Context.New({
			mediator = LiquorFloorTaskMediator,
			viewComponent = LiquorFloorTaskScene,
			data = {
				activityID = self.activity.id
			}
		}))

		return
	end, SFX_CANCEL)
	onButton(self, self.storyBtn, function()
		self:emit(LiquorFloorMapMediator.OPEN_CLUE_BOOK)

		return
	end, SFX_CANCEL)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(LiquorFloorMapScene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.box, function()
		SetActive(self.box, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.top:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.LiquorFloor_tip.tip
		})

		return
	end, SFX_CANCEL)
	setText(self.ui:Find("Allgold/Text"), i18n("LiquorFloor_gold_get"))
	onButton(self, self.ui:Find("Allgold"), function()
		SetActive(self.box, false)

		if self.activity:HasMaxGold() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("LiquorFloor_gold_max_tip")
			})
		else
			self:emit(LiquorFloorMapMediator.ALL_WORKPLACE)
		end

		return
	end, SFX_CANCEL)

	self.timeCfg = self.activity:getConfig("config_client").endingtime
	self.Placeitems = self.ui:Find("architecture")
	self.Placeitem = self.Placeitems:Find("muchang_bg")
	self.uilistPlace = UIItemList.New(self.Placeitems, self.Placeitem)

	self:OnPlaceDes()
	self:UpdateBubbles()

	self.timer = Timer.New(function()
		self:OnUpdateTime()
		self:OnPlaceDes()

		return
	end, 1, -1)

	self.timer:Start()
	self:OnUpdateTime()

	self.timeCfg = self.activity:getConfig("config_client").endingtime
	self.spineRoles = {}

	self.activity:SetBubbleTipTag(true)
	self:RefreshRedPoint()

	if self.contextData.openStory == 1 then
		triggerButton(self.storyBtn)
	end

	return
end

function LiquorFloorMapScene:OnStory()
	for iter_15_0, iter_15_1 in ipairs(self.gather1) do
		local var_15_0 = self:getCollectDataBySiteId(iter_15_1)

		if var_15_0.unlock[2] <= self.activity:GetTownLevel() then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_15_0.luaID) then
				pg.NewStoryMgr.GetInstance():Play(var_15_0.luaID, function()
					if iter_15_0 == 1 then
						pg.NewGuideMgr.GetInstance():Play("LiquorFloor_help")
					end

					return
				end)
			end
		end
	end

	local var_15_1 = self.activity:GetPlaceList()

	for iter_15_2, iter_15_3 in ipairs(self.gather2) do
		local var_15_2 = self:getCollectDataBySiteId(iter_15_3)

		if var_15_2.unlock[2] <= var_15_1[var_15_2.unlock[1]]:GetLevel() then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_15_2.luaID) then
				pg.NewStoryMgr.GetInstance():Play(var_15_2.luaID, function()
					return
				end)
			end
		end
	end

	for iter_15_4, iter_15_5 in ipairs(self.gather3) do
		local var_15_3 = self:getCollectDataBySiteId(iter_15_5)

		if var_15_3.unlock[2] <= var_15_1[var_15_3.unlock[1]]:GetLevel() then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_15_3.luaID) then
				pg.NewStoryMgr.GetInstance():Play(var_15_3.luaID, function()
					return
				end)
			end
		end
	end

	return
end

function LiquorFloorMapScene:OnstoryPlay()
	if not self.storyList or #self.storyList == 0 then
		return
	end

	pg.NewStoryMgr.GetInstance():Play(self.storyList, function()
		return
	end, false)

	return
end

function LiquorFloorMapScene:OnUpdateTime()
	return
end

function LiquorFloorMapScene:GetRandomPos()
	local var_22_0 = {}

	for iter_22_0 = 1, #LiquorFloorMapScene.RANDOM_POS do
		table.insert(var_22_0, iter_22_0)
	end

	shuffle(var_22_0)

	local var_22_1 = {}

	for iter_22_1 = 1, 8 do
		table.insert(var_22_1, LiquorFloorMapScene.RANDOM_POS[var_22_0[iter_22_1]])
	end

	return var_22_1
end

function LiquorFloorMapScene:UpdateBubbles()
	self.bubblesPosList = {}

	if self.slotTpl then
		setActive(self.slotTpl, false)
	end

	self.randomPos = Clone(LiquorFloorMapScene.RANDOM_POS)

	for iter_23_0, iter_23_1 in ipairs(self.shipIds) do
		local var_23_0 = self.slotTFs:Find(iter_23_0) or cloneTplTo(self.slotTpl, self.slotTFs, iter_23_0)
		local var_23_1

		if iter_23_1 > 0 then
			var_23_1 = getProxy(BayProxy):RawGetShipById(iter_23_1)

			if var_23_1 then
				var_23_1 = self.activity:GetBubbleCntByPos(iter_23_0) > 0
			end
		end

		setActive(var_23_0, var_23_1)

		if var_23_1 then
			table.insert(self.bubblesPosList, iter_23_0)
			self:UpdateShip(var_23_0, iter_23_0, iter_23_1)
		end
	end

	return
end

function LiquorFloorMapScene:UpdateShip(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_3 > 0 and getProxy(BayProxy):RawGetShipById(arg_24_3)

	if not var_24_0 then
		return
	end

	local var_24_1 = self.activity:GetBubbleCntByPos(arg_24_2)

	setAnchoredPosition(arg_24_1, self.randomPos[#self.randomPos])
	table.removebyvalue(self.randomPos, self.randomPos[#self.randomPos])
	setImageSprite(arg_24_1:Find("icon"), (LoadSprite("qicon/" .. var_24_0:getPainting())))
	onButton(self, arg_24_1:Find("icon"), function()
		if not self.bubblesPosList or #self.bubblesPosList <= 0 then
			return
		end

		if self.activity:HasMaxGold() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("LiquorFloor_gold_max_tip"),
				onYes = function()
					self:emit(LiquorFloorMapMediator.CLICK_BUBBLE, self.bubblesPosList)

					return
				end
			})
		else
			self:emit(LiquorFloorMapMediator.CLICK_BUBBLE, self.bubblesPosList)
		end

		return
	end, SFX_PANEL)

	return
end

function LiquorFloorMapScene:Onstory()
	if not #self.storyList or #self.storyList == 0 then
		return
	end

	pg.NewStoryMgr.GetInstance():SeriesPlay(self.storyList)

	return
end

function LiquorFloorMapScene:CleanSpines()
	if self.spineRoles then
		table.Foreach(self.spineRoles, function(arg_29_0, arg_29_1)
			arg_29_1:Dispose()

			return
		end)
	end

	self.spineRoles = {}

	return
end

function LiquorFloorMapScene:InitData()
	self.shipIds = self.activity:GetShipIds()

	self:AchitectureMessage((self.activity:GetPlaceList()))
	self:OnLV()
	self:UpdateGold()

	local var_30_0 = self.activity:getConfig("config_client")

	SetActive(self.ui:Find("Allgold/tip"), LiquorFloorMapScene.GetLiquorFloorMapTip())

	return
end

function LiquorFloorMapScene:OnPlaceDes()
	local var_31_0 = self.activity:GetPlaceList()

	self.uilistPlace:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			self:UpdatePlace(arg_32_1, arg_32_2, var_31_0)
		end

		return
	end)
	self.uilistPlace:align(#var_31_0)

	return
end

function LiquorFloorMapScene:UpdatePlace(arg_33_1, arg_33_2, arg_33_3)
	i = arg_33_1 + 1
	self._subTime = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_33_3[i]:GetType() == 1 then
		SetActive(self.architectureData[i]:Find("tip"), false)

		if arg_33_3[i]:OnStartTime() < arg_33_3[i]:GetTypeParam() * 7200 or arg_33_3[i]:GetTypeParam() == 0 then
			setImageSprite(self.architectureData[i]:Find("numbg/icon1"), LoadSprite("ui/LiquorFloorUI_atlas", "settleGold_1"), true)
		elseif arg_33_3[i]:OnStartTime() > arg_33_3[i]:GetTypeParam() * 7200 and arg_33_3[i]:OnStartTime() < arg_33_3[i]:GetTypeParam() * 14400 then
			setImageSprite(self.architectureData[i]:Find("numbg/icon1"), LoadSprite("ui/LiquorFloorUI_atlas", "settleGold_2"), true)
		elseif arg_33_3[i]:OnStartTime() > arg_33_3[i]:GetTypeParam() * 14400 then
			SetActive(self.architectureData[i]:Find("tip"), true)
			setImageSprite(self.architectureData[i]:Find("numbg/icon1"), LoadSprite("ui/LiquorFloorUI_atlas", "settleGold_3"), true)
		end
	end

	if arg_33_3[i]:OnStartTime() <= 0 then
		setText(arg_33_2:Find("numbg/Text"), "0")
	else
		setText(arg_33_2:Find("numbg/Text"), TownActivity2.GoldToShow(arg_33_3[i]:OnStartTime()))
	end

	return
end

function LiquorFloorMapScene:AchitectureMessage(arg_34_1)
	for iter_34_0 = 1, #arg_34_1 do
		setText(self.architectureData[iter_34_0]:Find("lv"), arg_34_1[iter_34_0]:GetLevel())
		setText(self.architectureData[iter_34_0]:Find("name"), arg_34_1[iter_34_0]:GetName())

		if arg_34_1[iter_34_0]:GetType() == 1 and arg_34_1[iter_34_0]:GetLevel() > 0 then
			SetActive(self.architectureData[iter_34_0]:Find("numbg"), true)
			onButton(self, self.architectureData[iter_34_0]:Find("numbg"), function()
				if arg_34_1[iter_34_0]:OnStartTime() <= 0 then
					return
				end

				if self.activity:HasMaxGold() then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("LiquorFloor_gold_max_tip")
					})
				else
					self:emit(LiquorFloorMapMediator.ADD_WORKPLACE, arg_34_1[iter_34_0]:GetId())
				end

				return
			end, SFX_CANCEL)
		else
			SetActive(self.architectureData[iter_34_0]:Find("numbg"), false)
		end

		onButton(self, self.architectureData[iter_34_0], function()
			SetActive(self.box, true)
			setAnchoredPosition(self.box, LiquorFloorMapScene.TOP_POS[iter_34_0])
			self:OnBox(arg_34_1[iter_34_0], iter_34_0, self.activity)

			return
		end, SFX_CANCEL)
	end

	self:OnMap()

	return
end

function LiquorFloorMapScene:OnMap()
	local var_37_0 = self.activity:GetPlaceList()

	for iter_37_0 = 1, #var_37_0 do
		setImageSprite(self.architectureMapData[iter_37_0], LoadSprite("ui/LiquorFloorUI_atlas", (var_37_0[iter_37_0]:GetIcon())))
	end

	local var_37_1 = self.activity:TownLevel()

	if var_37_1 >= 0 and var_37_1 <= 3 then
		setImageSprite(self._tf:Find("bgs"), LoadSprite("ui/LiquorFloorUI_atlas", "bg1"), true)
	elseif var_37_1 > 3 and var_37_1 <= 7 then
		setImageSprite(self._tf:Find("bgs"), LoadSprite("ui/LiquorFloorUI_atlas", "bg2"), true)
	elseif var_37_1 > 7 and var_37_1 <= 10 then
		setImageSprite(self._tf:Find("bgs"), LoadSprite("ui/LiquorFloorUI_atlas", "bg3"), true)
	end

	return
end

function LiquorFloorMapScene:UpdateGold()
	self.top:Find("res/gold1/Text"):GetComponent(typeof(Text)).text = TownActivity2.GoldToShow(self.activity:GetGold()) .. "/" .. TownActivity2.GoldToShow(self.activity:GetLimitGold())

	setText(self.top:Find("res/gold2/Text"), " " .. TownActivity2.GoldToShow(self.activity:GetGold2()))

	return
end

function LiquorFloorMapScene:OnLV()
	local var_39_0 = self.activity:TownLevel()

	if var_39_0 >= #self.activity.listLVList2 + 1 then
		setFillAmount(self.lv:Find("Slider"), 1)
		SetActive(self.lv:Find("num_bg"), false)
	else
		setFillAmount(self.lv:Find("Slider"), var_39_0 / self.activity.listLVList[var_39_0])
		setText(self.lv:Find("num_bg/num"), TownActivity2.GoldToShow(self.activity.listLVList2[var_39_0 - 1] and self.activity:GetPtAllGold() - self.activity.listLVList2[var_39_0 - 1] or self.activity:GetPtAllGold()) .. "/" .. TownActivity2.GoldToShow(self.activity.listLVList[var_39_0]))
	end

	setText(self.lv:Find("Lv_bg/Text"), var_39_0)
	setText(self.ui:Find("LV/lvbtn/Text"), i18n("LiquorFloor_level"))

	return
end

function LiquorFloorMapScene:OnUpgradeMoveLV()
	setText(self.Text_new, (self.activity:GetTownLevel()))
	SetActive(self.Text_new, true)
	LeanTween.move(self.Text_new, Vector3(0, 0, 0), 1):setOnComplete(System.Action(function()
		self:OnLV()

		return
	end))

	return
end

function LiquorFloorMapScene:OnBox(arg_42_1, arg_42_2, arg_42_3)
	if arg_42_1:GetType() == 1 then
		SetActive(self.box:Find("role_bg"), false)
	elseif arg_42_1:GetType() == 3 then
		SetActive(self.box:Find("role_bg"), true)
		self:OnRole_bg(arg_42_1)
	else
		SetActive(self.box:Find("role_bg"), false)
	end

	setText(self.box:Find("box_bg/lv"), arg_42_1:GetLevel())
	setText(self.box:Find("box_bg/name"), arg_42_1:GetName())
	setText(self.box:Find("box_bg/describe"), arg_42_1:GetDesc())

	if arg_42_1:GetType() == 1 then
		setText(self.box:Find("box_bg/Text"), i18n("LiquorFloor_gold"))
	elseif arg_42_1:GetType() == 2 then
		setText(self.box:Find("box_bg/Text"), i18n("LiquorFloor_gold_num"))
	elseif arg_42_1:GetType() == 3 then
		setText(self.box:Find("box_bg/Text"), i18n("LiquorFloor_character_num"))
	end

	setText(self.box:Find("box_bg/num"), TownActivity2.GoldToShow(arg_42_1:GetTypeParam((arg_42_3:GetGoldOutput()))))

	local var_42_0 = self:OnNextArchitecture(arg_42_1:GetId())

	if var_42_0 == 0 then
		SetActive(self.box:Find("box_bg/num_1"), false)
		SetActive(self.box:Find("box_bg/decorate2"), false)
	else
		setText(self.box:Find("box_bg/num_1"), TownActivity2.GoldToShow(var_42_0))
	end

	local var_42_1 = arg_42_1:GetNeedTownLv()

	if var_42_1 <= arg_42_3:TownLevel() and #arg_42_1:GetUpgrade() ~= 0 then
		SetActive(self.box:Find("box_bg/num"), true)
		SetActive(self.box:Find("box_bg/decorate2"), true)
		SetActive(self.box:Find("box_bg/num_1"), true)
		SetActive(self.box:Find("box_bg/btn_lock"), false)
		SetActive(self.box:Find("box_bg/upgrade"), true)

		local var_42_2 = arg_42_1:GetUpgrade()

		setText(self.box:Find("box_bg/upgrade/name"), i18n("LiquorFloor_update"))

		local var_42_3 = arg_42_3:GetUpgradeGold(arg_42_1:GetId())

		setText(self.box:Find("box_bg/upgrade/num1"), TownActivity2.GoldToShow(var_42_3[1][3]))
		SetActive(self.box:Find("box_bg/num_man"), false)

		if #var_42_3 == 1 then
			SetActive(self.box:Find("box_bg/upgrade/icon2"), false)
			SetActive(self.box:Find("box_bg/upgrade/num2"), false)
		else
			SetActive(self.box:Find("box_bg/upgrade/icon2"), true)
			SetActive(self.box:Find("box_bg/upgrade/num2"), true)
			setText(self.box:Find("box_bg/upgrade/num2"), TownActivity2.GoldToShow(var_42_3[2][3]))
		end

		if arg_42_3:UpgradeGold(arg_42_1:GetId()) then
			self.box:Find("box_bg/upgrade"):GetComponent(typeof(Button)).interactable = true

			onButton(self, self.box:Find("box_bg/upgrade"), function()
				self:emit(LiquorFloorMapMediator.UPGRADE_WORKPLACE, arg_42_1:GetId(), arg_42_1, arg_42_2)

				return
			end, SFX_CANCEL)
		else
			self.box:Find("box_bg/upgrade"):GetComponent(typeof(Button)).interactable = false
		end
	elseif #arg_42_1:GetUpgrade() == 0 and var_42_1 == 0 then
		SetActive(self.box:Find("box_bg/num"), false)
		SetActive(self.box:Find("box_bg/decorate2"), false)
		SetActive(self.box:Find("box_bg/num_1"), false)
		SetActive(self.box:Find("box_bg/upgrade"), false)
		SetActive(self.box:Find("box_bg/btn_lock/icon"), false)
		SetActive(self.box:Find("box_bg/btn_lock"), true)
		SetActive(self.box:Find("box_bg/btn_lock/name"), true)
		SetActive(self.box:Find("box_bg/num_man"), true)
		setText(self.box:Find("box_bg/num_man"), TownActivity2.GoldToShow(arg_42_1:GetTypeParam((arg_42_3:GetGoldOutput()))))
		setText(self.box:Find("box_bg/btn_lock/name"), i18n("LiquorFloor_update_max"))
	else
		SetActive(self.box:Find("box_bg/num_man"), false)
		SetActive(self.box:Find("box_bg/btn_lock"), true)
		SetActive(self.box:Find("box_bg/upgrade"), false)
		setText(self.box:Find("box_bg/btn_lock/name"), i18n("LiquorFloor_update_unlock", var_42_1))
	end

	return
end

function LiquorFloorMapScene:OnRole_bg(arg_44_1)
	self.items = self.box:Find("role_bg/list")
	self.item = self.items:Find("bg")
	self.uilist = UIItemList.New(self.items, self.item)

	setActive(self.item, false)
	self.uilist:make(function(arg_45_0, arg_45_1, arg_45_2)
		if arg_45_0 == UIItemList.EventUpdate then
			self:UpdateTask(arg_45_1, arg_45_2, arg_44_1:GetTypeParam(), self:OnNextArchitecture(arg_44_1:GetId()), arg_44_1)
		end

		return
	end)
	self.uilist:align(9)
	setText(self.box:Find("role_bg/rule1"), i18n("LiquorFloor_character_tip"))

	return
end

function LiquorFloorMapScene:UpdateTask(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1 + 1

	if not arg_46_5:GetUpgrade() or #arg_46_5:GetUpgrade() == 0 then
		SetActive(arg_46_2:Find("icon"), false)
		SetActive(arg_46_2:Find("Text"), false)
		SetActive(arg_46_2:Find("btn"), false)
	else
		SetActive(arg_46_2:Find("icon"), false)
		SetActive(arg_46_2:Find("Text"), arg_46_1 + 1 == arg_46_4)
	end

	setButtonEnabled(arg_46_2, arg_46_1 + 1 < arg_46_4 or arg_46_4 == -1)
	SetActive(arg_46_2:Find("btn"), arg_46_1 + 1 < arg_46_4 or arg_46_4 == -1)

	if arg_46_1 + 1 < arg_46_4 and arg_46_4 == -1 then
		SetActive(arg_46_2:Find("Text"), false)
	elseif arg_46_1 + 1 == arg_46_4 then
		SetActive(arg_46_2:Find("Text"), true)
		setText(arg_46_2:Find("Text"), i18n("LiquorFloor_character_unlock", arg_46_4))
	else
		SetActive(arg_46_2:Find("Text"), false)
	end

	setImageSprite(arg_46_2:Find("btn"), LoadSprite("ui/LiquorFloorUI_atlas", "box_decorate1"), true)

	local var_46_1

	if self.shipIds[arg_46_1 + 1] then
		local var_46_2 = getProxy(BayProxy):RawGetShipById(self.shipIds[arg_46_1 + 1])

		if var_46_2 then
			setImageSprite(arg_46_2:Find("btn"), LoadSprite("qicon/" .. var_46_2:getPainting()), true)
		end
	end

	onButton(self, arg_46_2, function()
		self:emit(LiquorFloorMapMediator.OPEN_CHUANWU, var_46_0, var_46_1, arg_46_5:GetId())

		return
	end, SFX_CANCEL)

	return
end

function LiquorFloorMapScene:OnNextArchitecture(arg_48_1)
	if pg.activity_town_work_level_2[arg_48_1 + 1] then
		return pg.activity_town_work_level_2[arg_48_1 + 1].type_param
	end

	return -1
end

function LiquorFloorMapScene:willExit()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function LiquorFloorMapScene:RefreshRedPoint()
	setActive(self.taskTip, LiquorFloorMapScene.ShouldShowTaskTip())
	SetActive(self.storyBtn:Find("tip"), LiquorFloorMapScene.GetCollectionBookTip())

	return
end

function LiquorFloorMapScene.ShouldShowTaskTip()
	local var_51_0 = getProxy(TaskProxy)

	for iter_51_0, iter_51_1 in ipairs(pg.activity_template[getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2):getConfig("config_client").taskActivityID].config_data) do
		local var_51_1 = var_51_0:getTaskVO(iter_51_1)

		if var_51_1 and var_51_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function LiquorFloorMapScene:getCollectDataBySiteId(arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(pg.activity_town_collection_2.all) do
		if pg.activity_town_collection_2[iter_52_1].id == arg_52_1 then
			return pg.activity_town_collection_2[iter_52_1]
		end
	end

	return nil
end

function LiquorFloorMapScene.GetCollectionBookTip()
	local var_53_0 = getProxy(TaskProxy)
	local var_53_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2):getConfig("config_client").BookData

	for iter_53_0 = 1, #var_53_1 do
		local var_53_2 = getProxy(TaskProxy):getTaskVO(var_53_1[iter_53_0].task)

		if var_53_2 and var_53_2:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function LiquorFloorMapScene.GetLiquorFloorMapTip()
	local var_54_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2):GetPlaceList()

	for iter_54_0 = 1, #var_54_0 do
		if var_54_0[iter_54_0]:GetType() == 1 and var_54_0[iter_54_0]:GetLevel() > 0 and var_54_0[iter_54_0]:OnStartTime() >= var_54_0[iter_54_0]:GetTypeParam() * pg.activity_town_2[ActivityConst.LiquorFloor_ACT_ID].gold_time_limit then
			return true
		end
	end

	return false
end

return LiquorFloorMapScene
