local MemoryBookLayer = class("MemoryBookLayer", import("...base.BaseUI"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

MemoryBookLayer.PAGE_ONE = 1
MemoryBookLayer.PAGE_TWO = 2

local var_0_4 = 12
local var_0_5 = {
	{
		-503,
		83
	},
	{
		-371.4,
		72.6
	},
	{
		-464,
		-211
	},
	{
		-234.3,
		-176
	},
	{
		-74.5,
		30.1
	},
	{
		80,
		121.5
	},
	{
		80,
		25.4
	},
	{
		80,
		-89
	},
	{
		291,
		25.4
	},
	{
		483,
		-33
	},
	{
		334,
		-246
	},
	{
		483,
		-217.5
	},
	{
		-478.4,
		84.5
	},
	{
		-290,
		44.5
	},
	{
		-137,
		12.5
	},
	{
		100.5,
		92.5
	},
	{
		-364.3,
		-179.6
	},
	{
		-137,
		-176.9
	},
	{
		78,
		-176.9
	},
	{
		247,
		-242
	},
	{
		383,
		33
	},
	{
		548,
		69
	},
	{
		456,
		-184
	},
	{
		573,
		-106
	}
}

local function var_0_6(arg_1_0)
	local var_1_0 = {}

	function var_1_0:Get()
		local var_3_0

		if #self.list == 0 then
			var_3_0 = GameObject("Image")

			var_3_0:AddComponent(typeof(Image))
		else
			var_3_0 = table.remove(self.list, #self.list)
		end

		setActive(var_3_0, true)

		return var_3_0
	end

	function var_1_0:Return(arg_4_1)
		self:Clear(arg_4_1)
		setParent(arg_4_1, self.root)
		table.insert(self.list, arg_4_1)

		return
	end

	function var_1_0.Clear(arg_5_0, arg_5_1)
		arg_5_1:GetComponent(typeof(Image)).sprite = nil

		setActive(arg_5_1, false)

		return
	end

	function var_1_0:Dispose()
		_.each(self.list, function(arg_7_0)
			Destroy(arg_7_0)

			return
		end)

		self.list = nil

		return
	end

	;(function(arg_2_0)
		arg_2_0.root = arg_1_0
		arg_2_0.list = {}

		return
	end)(var_1_0)

	return var_1_0
end

function MemoryBookLayer:getUIName()
	return "MemoryBookUI"
end

function MemoryBookLayer:setActivity(arg_9_1)
	self.activity = arg_9_1
	self.targetItems = self.activity:getConfig("config_data")
	self.fetchItems = self.activity.data1_list
	self.unlockItems = self.activity.data2_list
	self.awardVO = self.activity:getConfig("config_client")[1]

	return
end

function MemoryBookLayer:getMemoryState(arg_10_1)
	local var_10_0

	if table.contains(self.unlockItems, arg_10_1) then
		var_10_0 = var_0_3

		if not var_0_3 then
			if table.contains(self.fetchItems, arg_10_1) then
				var_10_0 = var_0_2 or var_0_1
			end
		end
	end

	return var_10_0
end

function MemoryBookLayer:updateMemorys()
	self.memorys = {}

	for iter_11_0, iter_11_1 in ipairs(self.targetItems) do
		local var_11_0 = self.memorys
		local var_11_1 = {
			id = iter_11_1
		}

		if iter_11_0 % var_0_4 == 0 then
			var_11_1.index = var_0_4 or iter_11_0 % var_0_4
		end

		var_11_1.pos = var_0_5[iter_11_0]
		var_11_1.state = self:getMemoryState(iter_11_1)

		table.insert(var_11_0, var_11_1)
	end

	self:updateMemoryBook(self.contextData.page or 1, true)

	return
end

function MemoryBookLayer:init()
	self.backBtn = self._tf:Find("back_btn")
	self.page1 = self._tf:Find("page1")
	self.page2 = self._tf:Find("page2")

	local var_12_0 = self._tf:Find("get")

	setActive(var_12_0, false)

	self.getSprite = var_12_0:GetComponent(typeof(Image)).sprite
	self.slider = self._tf:Find("slider"):GetComponent(typeof(Slider))
	self.totalTxt = self._tf:Find("progress"):GetComponent(typeof(Text))
	self.currValueTxt = self._tf:Find("progress/value"):GetComponent(typeof(Text))
	self.awardIcon = self._tf:Find("award_bg/icon")
	self.awardLabel = self._tf:Find("award_bg/label")
	self.awardLabelGot = self._tf:Find("award_bg/label_got")
	self.helpBtn = self._tf:Find("help")
	self.pool = var_0_6(self._tf)

	return
end

function MemoryBookLayer:didEnter()
	self:addRingDragListenter()
	onButton(self, self.backBtn, function()
		self:emit(MemoryBookLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.memorybook_notice.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.page1:Find("switch"), function()
		self:updateMemoryBook(MemoryBookLayer.PAGE_TWO)

		return
	end, SFX_PANEL)
	onButton(self, self.page2:Find("switch"), function()
		self:updateMemoryBook(MemoryBookLayer.PAGE_ONE)

		return
	end, SFX_PANEL)

	self.sprites = {}
	self.gameObjects = {}

	self:updateMemorys()
	self:updateProgress()

	return
end

function MemoryBookLayer:getStartAndEndIndex(arg_18_1)
	return (arg_18_1 - 1) * var_0_4 + 1, (arg_18_1 - 1) * var_0_4 + 1 + var_0_4 - 1
end

function MemoryBookLayer:updateMemoryBook(arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(self.gameObjects) do
		self.pool:Return(iter_19_1)
	end

	self.gameObjects = {}

	local var_19_0 = self["page" .. arg_19_1]
	local var_19_1, var_19_2 = self:getStartAndEndIndex(arg_19_1)

	for iter_19_2 = var_19_1, var_19_2 do
		self:updateMemoryItem(arg_19_1, self.memorys[iter_19_2])
	end

	local var_19_3 = false

	if arg_19_1 == MemoryBookLayer.PAGE_ONE then
		var_19_3 = self:updatePageTip(MemoryBookLayer.PAGE_TWO)
	elseif arg_19_1 == MemoryBookLayer.PAGE_TWO then
		var_19_3 = self:updatePageTip(MemoryBookLayer.PAGE_ONE)
	end

	setActive(var_19_0:Find("switch/tip"), var_19_3)

	self.page = arg_19_1
	self.contextData.page = arg_19_1

	if arg_19_2 then
		if arg_19_1 == MemoryBookLayer.PAGE_TWO then
			self.page2.localPosition = Vector3.New(0, 0)
			self.page1.localPosition = Vector3.New(-1280, 0)

			setActive(self.page2:Find("switch"), true)
		else
			local var_19_4 = self.page1:Find("switch")

			self.page2.localPosition = Vector3.New(1280, 0)
			self.page1.localPosition = Vector3.New(0, 0)

			setActive(var_19_4, true)
		end
	elseif arg_19_1 == MemoryBookLayer.PAGE_TWO then
		local var_19_5 = self.page2:Find("switch")

		setActive(var_19_5, false)

		self.page2.localPosition = Vector3.New(1280, 0)
		self.page1.localPosition = Vector3.New(0, 0)

		LeanTween.moveX(self.page2, 0, 0.5)
		LeanTween.moveX(self.page1, -1280, 0.5):setOnComplete(System.Action(function()
			setActive(var_19_5, true)

			return
		end))
	else
		local var_19_6 = self.page1:Find("switch")

		setActive(var_19_6, false)

		self.page2.localPosition = Vector3.New(0, 0)
		self.page1.localPosition = Vector3.New(-1280, 0)

		LeanTween.moveX(self.page2, 1280, 0.5)
		LeanTween.moveX(self.page1, 0, 0.5):setOnComplete(System.Action(function()
			setActive(var_19_6, true)

			return
		end))
	end

	return
end

function MemoryBookLayer:addRingDragListenter()
	local var_22_0 = GetOrAddComponent(self._tf, "EventTriggerListener")
	local var_22_1 = 0
	local var_22_2

	var_22_0:AddBeginDragFunc(function()
		var_22_1 = 0
		var_22_2 = nil

		return
	end)
	var_22_0:AddDragFunc(function(arg_24_0, arg_24_1)
		var_22_2 = var_22_2 or arg_24_1.position
		var_22_1 = arg_24_1.position.x - var_22_2.x

		return
	end)
	var_22_0:AddDragEndFunc(function(arg_25_0, arg_25_1)
		if var_22_1 < -50 then
			if self.page == MemoryBookLayer.PAGE_ONE then
				self:updateMemoryBook(MemoryBookLayer.PAGE_TWO)
			end
		elseif var_22_1 > 50 and self.page == MemoryBookLayer.PAGE_TWO then
			self:updateMemoryBook(MemoryBookLayer.PAGE_ONE)
		end

		return
	end)

	return
end

function MemoryBookLayer:updatePageTip(arg_26_1)
	local var_26_0, var_26_1 = self:getStartAndEndIndex(arg_26_1)

	return _.any(_.slice(self.memorys, var_26_0, var_0_4), function(arg_27_0)
		return arg_27_0.state == var_0_2
	end)
end

function MemoryBookLayer:updateMemoryItem(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.state
	local var_28_1 = self["page" .. arg_28_1]

	local function var_28_2()
		local var_29_0 = self.pool:Get()

		setImageSprite(var_29_0, (var_28_0 == var_0_2 or nil) and (self.getSprite or self:GetMemorySprite(arg_28_1, arg_28_2.index)), true)

		var_29_0:GetComponent(typeof(Image)).raycastTarget = var_28_0 == var_0_2

		setParent(var_29_0, var_28_1:Find("container"))

		tf(var_29_0).localPosition = Vector3(arg_28_2.pos[1], arg_28_2.pos[2], 0)

		table.insert(self.gameObjects, var_29_0)

		return var_29_0
	end

	if arg_28_2.state == var_0_1 then
		-- block empty
	elseif arg_28_2.state == var_0_2 then
		onButton(self, var_28_2(), function()
			self:emit(MemoryBookMediator.ON_UNLOCK, arg_28_2.id, self.activity.id)

			return
		end, SFX_PANEL)
	elseif arg_28_2.state == var_0_3 then
		var_28_2()
	end

	return
end

function MemoryBookLayer:GetMemorySprite(arg_31_1, arg_31_2)
	if self.sprites[arg_31_1 .. "_" .. arg_31_2] then
		return self.sprites[arg_31_1 .. "_" .. arg_31_2]
	else
		local var_31_0 = GetSpriteFromAtlas("puzzla/bg_2", arg_31_1 .. "_" .. arg_31_2)

		self.sprites[arg_31_1 .. "_" .. arg_31_2] = var_31_0

		return var_31_0
	end

	return
end

function MemoryBookLayer:updateProgress()
	local var_32_0 = #self.targetItems
	local var_32_1 = #self.unlockItems

	self.slider.value = #self.unlockItems / #self.targetItems
	self.totalTxt.text = var_32_0
	self.currValueTxt.text = var_32_1

	self:updateAward(var_32_1 == var_32_0)

	return
end

function MemoryBookLayer:updateAward(arg_33_1)
	if not self.isInitAward then
		self.isInitAward = true

		if self.awardVO[1] == DROP_TYPE_FURNITURE then
			GetSpriteFromAtlasAsync("furniture/" .. Furniture.New({
				id = self.awardVO[2]
			}):getConfig("picture"), "", function(arg_34_0)
				if self.exited then
					return
				end

				setImageSprite(self.awardIcon, arg_34_0, true)

				return
			end)
		else
			assert(false, "this award type is not deal")
		end
	end

	local var_33_0 = self.activity.data1 == 1

	setGray(self.awardIcon, not arg_33_1, false)
	setActive(self.awardLabel, arg_33_1 and not var_33_0)
	setActive(self.awardLabelGot, var_33_0)

	if LeanTween.isTweening(go(self.awardLabel)) then
		LeanTween.cancel(go(self.awardLabel))
	end

	if arg_33_1 and not var_33_0 then
		blinkAni(self.awardLabel, 0.8, nil, 0.5)
	end

	removeOnButton(self.awardIcon)

	if not var_33_0 then
		onButton(self, self.awardIcon, function()
			if not arg_33_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("memorybook_get_award_tip"))
			else
				self:emit(MemoryBookMediator.EVENT_OPERATION, {
					cmd = 1,
					activity_id = self.activity.id
				})
			end

			return
		end, SFX_PANEL)
	end

	return
end

function MemoryBookLayer:willExit()
	self.pool:Dispose()

	self.sprites = nil
	self.getSprite = nil

	return
end

return MemoryBookLayer
