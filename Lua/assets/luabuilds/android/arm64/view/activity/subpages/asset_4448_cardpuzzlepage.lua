local CardPuzzlePage = class("CardPuzzlePage", import("view.base.BaseActivityPage"))

function CardPuzzlePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.titleTF = self.bg:Find("title")
	self.progressTF = self.bg:Find("progress")
	self.descTF = self.bg:Find("desc")
	self.startBtn = self.bg:Find("start_btn")
	self.getBtn = self.bg:Find("get_btn")
	self.gotBtn = self.bg:Find("got_btn")
	self.item = self.bg:Find("levels/tpl")
	self.items = self.bg:Find("levels")
	self.uilist = UIItemList.New(self.items, self.item)

	return
end

function CardPuzzlePage:OnDataSetting()
	self.levelList = self.activity:getConfig("config_data")[1]
	self.awardList = self.activity:getConfig("config_data")[2]

	return
end

function CardPuzzlePage:OnFirstFlush()
	self.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			self:InitItem(arg_4_1, arg_4_2)
		elseif arg_4_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)
	onButton(self, self.startBtn, function()
		if not self.selectedId then
			return
		end

		self:emit(ActivityMediator.GO_CARDPUZZLE_COMBAT, self.selectedId)

		return
	end, SFX_PANEL)

	self.selectedId = self:GetCurLevel()

	self:UpdateLevelInfo()

	return
end

function CardPuzzlePage:InitItem(arg_6_1, arg_6_2)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/cardpuzzlepage_atlas", arg_6_1 + 1, arg_6_2:Find("normal/num"), true)
	GetImageSpriteFromAtlasAsync("ui/activityuipage/cardpuzzlepage_atlas", arg_6_1 + 1, arg_6_2:Find("selected/num"), true)

	return
end

function CardPuzzlePage:UpdateItem(arg_7_1, arg_7_2)
	local var_7_0 = self.levelList[arg_7_1 + 1]

	setActive(arg_7_2:Find("selected"), self.selectedId == self.levelList[arg_7_1 + 1])

	local var_7_1 = table.contains(self.finishList, var_7_0)

	setActive(arg_7_2:Find("finish"), var_7_1)
	setActive(arg_7_2:Find("normal"), not var_7_1 and self.selectedId ~= var_7_0)
	onButton(self, arg_7_2, function()
		self.selectedId = var_7_0

		self.uilist:align(#self.levelList)
		self:UpdateLevelInfo()

		return
	end, SFX_PANEL)

	return
end

function CardPuzzlePage:OnUpdateFlush()
	self.gotList = self.activity:getData1List()
	self.finishList = self.activity.data2_list

	self.uilist:align(#self.levelList)

	if self:CheckAward() then
		setActive(self.getBtn, true)
		onButton(self, self.getBtn, function()
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 2,
				activity_id = self.activity.id,
				arg1 = self:CheckAward()
			})

			return
		end, SFX_PANEL)
	else
		setActive(self.getBtn, false)
	end

	setActive(self.gotBtn, #self.gotList == #self.awardList)
	setText(self.progressTF, setColorStr(#self.finishList, "#C2FFF3") .. "/" .. #self.levelList)
	self:UpdateEveryDayTip()

	return
end

function CardPuzzlePage:CheckAward()
	if #self.gotList == #self.awardList then
		return nil
	end

	local var_11_0 = #self.finishList

	for iter_11_0, iter_11_1 in ipairs(self.awardList) do
		if not table.contains(self.gotList, iter_11_1[1]) and var_11_0 >= iter_11_1[1] then
			return iter_11_1[1]
		end
	end

	return nil
end

function CardPuzzlePage:UpdateLevelInfo()
	setText(self.titleTF, "·" .. pg.puzzle_combat_template[self.selectedId].name)
	setText(self.descTF, pg.puzzle_combat_template[self.selectedId].description)

	return
end

function CardPuzzlePage:GetCurLevel()
	self.finishList = self.activity.data2_list

	for iter_13_0, iter_13_1 in ipairs(self.levelList) do
		if not table.contains(self.finishList, iter_13_1) then
			return iter_13_1, iter_13_0
		end
	end

	return self.levelList[#self.levelList], #self.levelList
end

function CardPuzzlePage:UpdateEveryDayTip()
	if #self.gotList == #self.awardList then
		return
	end

	if self:CheckAward() then
		return
	end

	local var_14_0, var_14_1 = self:GetCurLevel()
	local var_14_2 = self.items:GetChild(var_14_1 - 1)
	local var_14_3 = var_14_2:Find("tip")

	if PlayerPrefs.GetInt(var_14_2) == 0 then
		setActive(var_14_3, true)
		PlayerPrefs.SetInt("DAY_TIP_" .. self.activity.id .. "_" .. getProxy(PlayerProxy):getData().id .. "_" .. self.activity:getDayIndex(), 1)
	else
		setActive(var_14_3, false)
	end

	return
end

return CardPuzzlePage
