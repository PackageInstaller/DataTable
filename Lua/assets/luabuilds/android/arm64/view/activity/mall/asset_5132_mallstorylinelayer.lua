local MallStoryLineLayer = class("MallStoryLineLayer", import("view.base.BaseUI"))

MallStoryLineLayer.Placeindex = 0
MallStoryLineLayer.roleindex = 0
MallStoryLineLayer.num = {
	Role = 3,
	Story = 1,
	Skin = 2,
	Place = 4
}

function MallStoryLineLayer:getUIName()
	return "MallStoryLineUI"
end

function MallStoryLineLayer:init()
	setText(self._tf:Find("tip"), i18n("word_click_to_close"))

	self.adapt = self._tf:Find("adapt")
	self.tabs = self.adapt:Find("tabs")
	self.tabsListCount = self.tabs.transform.childCount
	self.decorate1ListCount = self.adapt:Find("decorate1").transform.childCount
	self.page_listCount = self.adapt:Find("page_list").transform.childCount
	self.StoryList = {}
	self.SkinList = {}
	self.RoleList = {}
	self.PlaceList = {}
	self.TriggeredPointIds = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):GetTriggeredPointIds()
	self.OrderDataList = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):GetOrderData():GetFinishedList()

	for iter_2_0, iter_2_1 in pairs((_.map(pg.activity_mall_story.all, function(arg_3_0)
		return pg.activity_mall_story[arg_3_0]
	end))) do
		if iter_2_1.type == self.num.Skin then
			table.insert(self.StoryList, iter_2_1)
		elseif iter_2_1.type == self.num.Place then
			table.insert(self.SkinList, iter_2_1)
		elseif iter_2_1.type == self.num.Role then
			table.insert(self.RoleList, iter_2_1)
		elseif iter_2_1.type == self.num.Story then
			table.insert(self.PlaceList, iter_2_1)
		end
	end

	self.type2List = {
		[self.num.Story] = self.StoryList,
		[self.num.Skin] = self.SkinList,
		[self.num.Role] = self.RoleList,
		[self.num.Place] = self.PlaceList
	}

	local var_2_0 = -1

	for iter_2_2 = 0, self.tabsListCount - 1 do
		onToggle(self, self.tabs:GetChild(iter_2_2), function(arg_4_0)
			if arg_4_0 then
				if var_2_0 ~= iter_2_2 then
					self:OnUpdata(iter_2_2 + 1)
				end

				var_2_0 = iter_2_2
			end

			return
		end, SFX_PANEL)
	end

	self:OnUpdata(1)

	return
end

function MallStoryLineLayer:UpdataToggle(arg_5_1)
	local var_5_0 = self.type2List[arg_5_1]
	local var_5_1 = arg_5_1 ~= MallStoryLineLayer.num.Skin and self:OnTask(var_5_0) or self:GetSkinFinishNum(var_5_0)

	setText(self.adapt:Find("tabs/" .. arg_5_1 .. "/name"), var_5_1 .. "/" .. #self.type2List[arg_5_1])
	setText(self.adapt:Find("tabs/" .. arg_5_1 .. "/on/name"), var_5_1 .. "/" .. #var_5_0)

	return
end

function MallStoryLineLayer:OnUpdata(arg_6_1)
	for iter_6_0 = 0, self.decorate1ListCount - 1 do
		SetActive(self.adapt:Find("decorate1/" .. iter_6_0 + 1), iter_6_0 + 1 == arg_6_1)
	end

	for iter_6_1 = 0, self.page_listCount - 1 do
		SetActive(self.adapt:Find("page_list/" .. iter_6_1 + 1), iter_6_1 + 1 == arg_6_1)
	end

	self:UpdataToggle(arg_6_1)

	if arg_6_1 == self.num.Story then
		self:OnStoryPage(arg_6_1)
	elseif arg_6_1 == self.num.Skin then
		self:OnSkinPage(arg_6_1)
	elseif arg_6_1 == self.num.Role then
		self:OnRolePage(arg_6_1)
	elseif arg_6_1 == self.num.Place then
		self:OnPlacePage(arg_6_1)
	end

	return
end

function MallStoryLineLayer:OnTask(arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if table.contains(self.TriggeredPointIds, iter_7_1.id) then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function MallStoryLineLayer:GetSkinFinishNum(arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if table.contains(self.OrderDataList, tonumber(iter_8_1.desc)) then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function MallStoryLineLayer:OnStoryPage(arg_9_1)
	local var_9_0 = self.adapt:Find("page_list/" .. arg_9_1)

	for iter_9_0 = 1, #self.StoryList do
		self:OnStoryUPdata(var_9_0:Find("bg/" .. iter_9_0), self.StoryList[iter_9_0])
	end

	return
end

function MallStoryLineLayer:OnStoryUPdata(arg_10_1, arg_10_2)
	local var_10_0 = table.contains(self.TriggeredPointIds, arg_10_2.id)
	local var_10_1 = arg_10_2.lua

	setActive(arg_10_1:Find("on"), var_10_0)
	setActive(arg_10_1:Find("off"), not var_10_0)
	setText(arg_10_1:Find("on/bg/name"), arg_10_2.name)
	setText(arg_10_1:Find("off/bg/lockname"), arg_10_2.desc)
	onButton(self, arg_10_1, function()
		if not var_10_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_10_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function MallStoryLineLayer:OnSkinPage(arg_13_1)
	local var_13_0 = self.adapt:Find("page_list/" .. arg_13_1)

	self:OnSkin(var_13_0:Find("skin/" .. self.roleindex).transform.childCount, var_13_0)
	onButton(self, var_13_0:Find("left"), function()
		self.roleindex = self.roleindex - 1

		self:OnSkin(var_13_0:Find("skin/" .. self.roleindex).transform.childCount, var_13_0)

		return
	end, SFX_PANEL)
	onButton(self, var_13_0:Find("right"), function()
		self.roleindex = self.roleindex + 1

		self:OnSkin(var_13_0:Find("skin/" .. self.roleindex).transform.childCount, var_13_0)

		return
	end, SFX_PANEL)

	return
end

function MallStoryLineLayer:OnSkin(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2:Find("skin").transform.childCount

	setActive(arg_16_2:Find("left"), self.roleindex == 1)
	setActive(arg_16_2:Find("right"), self.roleindex == 0)
	setText(arg_16_2:Find("Text"), self.roleindex + 1 .. "/" .. #self.SkinList / 5)

	for iter_16_0 = 0, var_16_0 - 1 do
		SetActive(arg_16_2:Find("skin/" .. iter_16_0), iter_16_0 == self.roleindex)
	end

	for iter_16_1 = 0, arg_16_1 - 1 do
		self:OnSkinUpdata(arg_16_2:Find("skin/" .. self.roleindex .. "/" .. iter_16_1 + 1), self.SkinList[self.roleindex * 5 + (iter_16_1 + 1)])
	end

	return
end

function MallStoryLineLayer:OnSkinUpdata(arg_17_1, arg_17_2)
	local var_17_0 = table.contains(self.OrderDataList, tonumber(arg_17_2.desc))
	local var_17_1 = arg_17_2.lua

	SetActive(arg_17_1:Find("on"), var_17_0)
	SetActive(arg_17_1:Find("off"), not var_17_0)
	setText(arg_17_1:Find("on/name"), arg_17_2.name)
	setText(arg_17_1:Find("off/lockname"), (i18n("mall_char_lock")))
	setImageSprite(arg_17_1:Find("on/bg"), LoadSprite("ui/mallstorylineui_atlas", arg_17_2.icon))
	onButton(self, arg_17_1, function()
		if not var_17_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_17_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(self, arg_17_1:Find("on/bg"), function()
		if not var_17_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_17_1, function()
			return
		end, true)

		return
	end, SFX_PANEL)

	return
end

function MallStoryLineLayer:OnRolePage(arg_22_1)
	local var_22_0 = self.adapt:Find("page_list/" .. arg_22_1)

	for iter_22_0 = 1, #self.RoleList do
		self:OnRoleUPdata(var_22_0:Find("" .. iter_22_0), self.RoleList[iter_22_0])
	end

	return
end

function MallStoryLineLayer:OnRoleUPdata(arg_23_1, arg_23_2)
	local var_23_0 = table.contains(self.TriggeredPointIds, arg_23_2.id)
	local var_23_1 = i18n("mall_title_lock")
	local var_23_2 = arg_23_2.lua
	local var_23_3 = arg_23_2.icon

	setActive(arg_23_1:Find("on"), var_23_0)
	setActive(arg_23_1:Find("off"), not var_23_0)
	setText(arg_23_1:Find("on/name_s/name"), arg_23_2.name)
	setScrollText(arg_23_1:Find("on/name_l/mask/name"), arg_23_2.name)

	local var_23_4 = GetPerceptualSize(arg_23_2.name) > 7

	setActive(arg_23_1:Find("on/name_s"), not var_23_4)
	setActive(arg_23_1:Find("on/name_l"), var_23_4)
	setText(arg_23_1:Find("off/lock/lockname"), var_23_1)
	setImageSprite(arg_23_1:Find("on/icon"), LoadSprite("ui/mallstorylineui_atlas", var_23_3))
	onButton(self, arg_23_1:Find("on"), function()
		if not var_23_0 then
			return
		end

		pg.NewStoryMgr.GetInstance():Play(var_23_2, function()
			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(self, arg_23_1:Find("off"), function()
		return
	end, SFX_PANEL)

	return
end

function MallStoryLineLayer:OnPlacePage(arg_27_1)
	self.Place = self.adapt:Find("page_list/" .. arg_27_1)

	for iter_27_0 = 0, self.Place:Find("table").transform.childCount - 1 do
		SetActive(self.Place:Find("table/" .. iter_27_0 + 1), self.Placeindex == iter_27_0 + 1)
	end

	self:OnPlaceList(#self.PlaceList - (self.Placeindex + 1) * 6 > 0 and 6 or (self.Placeindex + 1) * 6 - #self.PlaceList, self.Place)
	addSlip(SLIP_TYPE_HRZ, self.adapt:Find("page_list/" .. arg_27_1 .. "/table"), function()
		if self.Placeindex > 0 then
			self.Placeindex = self.Placeindex - 1

			self:OnPlaceList(#self.PlaceList - (self.Placeindex + 1) * 6 > 0 and 6 or (self.Placeindex + 1) * 6 - #self.PlaceList, (self.adapt:Find("page_list/" .. arg_27_1)))
		end

		return
	end, function()
		if self.Placeindex < 2 then
			self.Placeindex = self.Placeindex + 1

			self:OnPlaceList(#self.PlaceList - (self.Placeindex + 1) * 6 > 0 and 6 or (self.Placeindex + 1) * 6 - #self.PlaceList, (self.adapt:Find("page_list/" .. arg_27_1)))
		end

		return
	end)
	onButton(self, self.Place:Find("left"), function()
		self.Placeindex = self.Placeindex - 1

		self:OnPlaceList(#self.PlaceList - (self.Placeindex + 1) * 6 > 0 and 6 or (self.Placeindex + 1) * 6 - #self.PlaceList, (self.adapt:Find("page_list/" .. arg_27_1)))

		return
	end, SFX_PANEL)
	onButton(self, self.Place:Find("right"), function()
		self.Placeindex = self.Placeindex + 1

		self:OnPlaceList(#self.PlaceList - (self.Placeindex + 1) * 6 > 0 and 6 or (self.Placeindex + 1) * 6 - #self.PlaceList, (self.adapt:Find("page_list/" .. arg_27_1)))

		return
	end, SFX_PANEL)

	return
end

function MallStoryLineLayer:OnPlaceList(arg_32_1, arg_32_2)
	setActive(self.Place:Find("left"), self.Placeindex ~= 0)
	setActive(self.Place:Find("right"), self.Placeindex < 2)
	setActive(self.Place:Find("table/0"), self.Placeindex == 0)
	setActive(self.Place:Find("table/1"), self.Placeindex == 1)
	setActive(self.Place:Find("table/2"), self.Placeindex == 2)
	setText(arg_32_2:Find("Text"), self.Placeindex + 1 .. "/" .. #self.PlaceList / 5)

	for iter_32_0 = 1, arg_32_1 do
		self:OnPlaceUPdata(arg_32_2:Find("table/" .. self.Placeindex .. "/" .. iter_32_0), self.PlaceList[self.Placeindex * 6 + iter_32_0], self.Placeindex * 6 + iter_32_0)
	end

	return
end

function MallStoryLineLayer:OnPlaceUPdata(arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = table.contains(self.TriggeredPointIds, arg_33_2.id)

	SetActive(arg_33_1:Find("lock"), not var_33_0)

	if var_33_0 then
		setText(arg_33_1:Find("name_bg/name"), arg_33_2.name)
		setText(arg_33_1:Find("desc/Text"), arg_33_2.desc)
		setImageSprite(arg_33_1:Find("icon"), LoadSprite("ui/mallstorylineui_atlas", arg_33_2.icon))
	end

	setText(arg_33_1:Find("lock/lockname"), (i18n("mall_continue_to_unlock")))

	return
end

function MallStoryLineLayer:didEnter()
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_PANEL)

	for iter_34_0, iter_34_1 in pairs(self.type2List) do
		self:UpdataToggle(iter_34_0)
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function MallStoryLineLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return MallStoryLineLayer
