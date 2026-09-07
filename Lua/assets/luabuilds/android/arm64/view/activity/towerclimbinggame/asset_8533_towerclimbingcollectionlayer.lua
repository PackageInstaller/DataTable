local TowerClimbingCollectionLayer = class("TowerClimbingCollectionLayer", import("...base.BaseUI"))

function TowerClimbingCollectionLayer:getUIName()
	return "TowerClimbingCollectionUI"
end

function TowerClimbingCollectionLayer:SetData(arg_2_1)
	self.miniGameData = arg_2_1

	local var_2_0, var_2_1 = TowerClimbingGameView.GetTowerClimbingPageAndScore((self.miniGameData:GetRuntimeData("kvpElements")))

	self.score = var_2_0
	self.pageIndex = var_2_1

	assert(var_2_0)
	assert(var_2_1)

	self.config = pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data

	return
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 < arg_3_0.pageIndex then
		return true
	elseif arg_3_1 == arg_3_0.pageIndex then
		return arg_3_2 <= arg_3_0.score
	else
		return false
	end

	return
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function TowerClimbingCollectionLayer:IsGotAward(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.miniGameData:GetRuntimeData("kvpElements")[1] or {}) do
		if iter_4_1.key == arg_4_1 and iter_4_1.value == 1 then
			return true
		end
	end

	return false
end

function TowerClimbingCollectionLayer:GetAwardState(arg_5_1)
	local var_5_0 = self.config[arg_5_1][1][#self.config[arg_5_1][1]]

	if arg_5_1 < self.pageIndex then
		if self:IsGotAward(arg_5_1) then
			return var_0_4
		else
			return var_0_3
		end
	elseif arg_5_1 == self.pageIndex then
		local var_5_1 = self:IsGotAward(arg_5_1)

		if var_5_1 then
			return var_0_4
		elseif var_5_0 <= self.score and not var_5_1 then
			return var_0_3
		elseif var_5_0 > self.score then
			return var_0_2
		end
	else
		return var_0_2
	end

	return
end

function TowerClimbingCollectionLayer:init()
	self.bookContainer = self._tf:Find("books")
	self.book = self._tf:Find("book")
	self.nextPageBtn = self._tf:Find("book/next")
	self.prevPageBtn = self._tf:Find("book/prev")
	self.scoreList = UIItemList.New(self._tf:Find("book/list"), self._tf:Find("book/list/tpl"))
	self.getBtn = self._tf:Find("book/get")
	self.gotBtn = self._tf:Find("book/got")
	self.goBtn = self._tf:Find("book/go")
	self.books = {
		self._tf:Find("books/1"),
		self._tf:Find("books/2"),
		self._tf:Find("books/3")
	}
	self.parent = self._tf.parent

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function TowerClimbingCollectionLayer:didEnter()
	onButton(self, self._tf, function()
		if self.isOpenBook then
			self:CloseBook()
		else
			self:emit(TowerClimbingCollectionLayer.ON_CLOSE)
		end

		return
	end, SFX_CANCEL)
	self:InitBooks()

	return
end

function TowerClimbingCollectionLayer:InitBooks()
	setActive(self.bookContainer, true)
	setActive(self.book, false)

	for iter_9_0, iter_9_1 in ipairs(self.books) do
		local var_9_0 = iter_9_0 <= self.pageIndex

		setActive(iter_9_1:Find("lock"), not (iter_9_0 <= self.pageIndex))

		iter_9_1:GetComponent(typeof(Image)).color = var_9_0 and Color.New(1, 1, 1, 1) or Color.New(0.46, 0.46, 0.46, 1)

		onButton(self, iter_9_1, function()
			if var_9_0 then
				self:OpenBook(iter_9_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("towerclimbing_book_tip"))
			end

			return
		end, SFX_PANEL)
	end

	self:UpdateTip()

	return
end

function TowerClimbingCollectionLayer:UpdateTip()
	for iter_11_0, iter_11_1 in ipairs(self.books) do
		setActive(iter_11_1:Find("tip"), self:GetAwardState(iter_11_0) == var_0_3)
	end

	return
end

function TowerClimbingCollectionLayer:OpenBook(arg_12_1)
	self.isOpenBook = true

	setActive(self.bookContainer, false)
	setActive(self.book, true)
	setActive(self.book:Find("1"), arg_12_1 == 1)
	setActive(self.book:Find("2"), arg_12_1 == 2)
	setActive(self.book:Find("3"), arg_12_1 == 3)

	local var_12_0 = self.config[arg_12_1][1]

	onButton(self, self.nextPageBtn, function()
		setActive(self.nextPageBtn, false)
		setActive(self.prevPageBtn, true)
		self:UpdatePage(arg_12_1, _.slice(var_12_0, 4, 2), 3)

		return
	end, SFX_PANEL)
	onButton(self, self.prevPageBtn, function()
		setActive(self.nextPageBtn, true)
		setActive(self.prevPageBtn, false)
		self:UpdatePage(arg_12_1, _.slice(var_12_0, 1, 3), 0)

		return
	end, SFX_PANEL)

	local var_12_1 = self:GetAwardState(arg_12_1)

	setActive(self.getBtn, var_12_1 == var_0_3)
	setActive(self.gotBtn, var_12_1 == var_0_4)
	setActive(self.goBtn, var_12_1 == var_0_2)
	onButton(self, self.getBtn, function()
		self:emit(TowerClimbingCollectionMediator.ON_GET, arg_12_1)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("towerclimbing_reward_tip"))

		return
	end, SFX_PANEL)
	triggerButton(self.prevPageBtn)

	return
end

function TowerClimbingCollectionLayer:UpdatePage(arg_17_1, arg_17_2, arg_17_3)
	self.scoreList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("TowerClimbingCollectionIcon/" .. arg_17_1 .. "_" .. arg_18_1 + 1 + arg_17_3, "", arg_18_2:Find("icon"))
			setActive(arg_18_2:Find("lock"), not var_0_1(self, arg_17_1, arg_17_2[arg_18_1 + 1]))
		end

		return
	end)
	self.scoreList:align(#arg_17_2)

	return
end

function TowerClimbingCollectionLayer:CloseBook()
	self.isOpenBook = false

	setActive(self.bookContainer, true)
	setActive(self.book, false)

	return
end

function TowerClimbingCollectionLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parent)

	return
end

return TowerClimbingCollectionLayer
