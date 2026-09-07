local JiuJiuExpeditionCollectionLayer = class("JiuJiuExpeditionCollectionLayer", import("...base.BaseUI"))

function JiuJiuExpeditionCollectionLayer:getUIName()
	return "JiuJiuExpeditionCollectionUI"
end

function JiuJiuExpeditionCollectionLayer:SetData(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self.allDatas = arg_2_1
	self.completeDatas = arg_2_2
	self.getRewardIndex = arg_2_3
	self.gotRewardIndex = arg_2_4

	return
end

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	return table.contains(arg_3_0.completeDatas, arg_3_2)
end

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

function JiuJiuExpeditionCollectionLayer:IsGotAward(arg_4_1)
	if arg_4_1 <= self.gotRewardIndex then
		return true
	end

	return false
end

function JiuJiuExpeditionCollectionLayer:GetAwardState(arg_5_1)
	if arg_5_1 > self.gotRewardIndex + 1 then
		return var_0_2
	elseif arg_5_1 <= self.gotRewardIndex then
		return var_0_4
	elseif arg_5_1 == self.gotRewardIndex + 1 and arg_5_1 <= self.getRewardIndex then
		return var_0_3
	else
		return var_0_2
	end

	return
end

function JiuJiuExpeditionCollectionLayer:init()
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

function JiuJiuExpeditionCollectionLayer:didEnter()
	onButton(self, self._tf, function()
		if self.isOpenBook then
			self:CloseBook()
		else
			self:emit(JiuJiuExpeditionCollectionLayer.ON_CLOSE)
		end

		return
	end, SFX_CANCEL)
	self:InitBooks()

	return
end

function JiuJiuExpeditionCollectionLayer:InitBooks()
	setActive(self.bookContainer, true)
	setActive(self.book, false)
	self:updateBooks()
	self:UpdateTip()

	return
end

function JiuJiuExpeditionCollectionLayer:updateBooks()
	for iter_10_0, iter_10_1 in ipairs(self.books) do
		local var_10_0 = iter_10_0 <= self.gotRewardIndex + 1

		setActive(iter_10_1:Find("lock"), not (iter_10_0 <= self.gotRewardIndex + 1))

		iter_10_1:GetComponent(typeof(Image)).color = var_10_0 and Color.New(1, 1, 1, 1) or Color.New(0.46, 0.46, 0.46, 1)

		onButton(self, iter_10_1, function()
			if var_10_0 then
				self:OpenBook(iter_10_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_book_tip"))
			end

			return
		end, SFX_PANEL)
	end

	return
end

function JiuJiuExpeditionCollectionLayer:UpdateTip()
	for iter_12_0, iter_12_1 in ipairs(self.books) do
		setActive(iter_12_1:Find("tip"), self:GetAwardState(iter_12_0) == var_0_3)
	end

	return
end

function JiuJiuExpeditionCollectionLayer:OpenBook(arg_13_1)
	self.isOpenBook = true

	setActive(self.bookContainer, false)
	setActive(self.book, true)
	setActive(self.book:Find("1"), arg_13_1 == 1)
	setActive(self.book:Find("2"), arg_13_1 == 2)
	setActive(self.book:Find("3"), arg_13_1 == 3)

	local var_13_0 = self.allDatas[arg_13_1]

	onButton(self, self.nextPageBtn, function()
		setActive(self.nextPageBtn, false)
		setActive(self.prevPageBtn, true)
		self:UpdatePage(arg_13_1, _.slice(var_13_0, 4, 2), 3)

		return
	end, SFX_PANEL)
	onButton(self, self.prevPageBtn, function()
		setActive(self.nextPageBtn, true)
		setActive(self.prevPageBtn, false)
		self:UpdatePage(arg_13_1, _.slice(var_13_0, 1, 3), 0)

		return
	end, SFX_PANEL)

	local var_13_1 = self:GetAwardState(arg_13_1)

	setActive(self.getBtn, var_13_1 == var_0_3)
	setActive(self.gotBtn, var_13_1 == var_0_4)
	setActive(self.goBtn, var_13_1 == var_0_2)
	onButton(self, self.getBtn, function()
		self:emit(JiuJiuExpeditionCollectionMediator.ON_GET, arg_13_1)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("jiujiu_expedition_reward_tip"))

		return
	end, SFX_PANEL)
	triggerButton(self.prevPageBtn)

	return
end

function JiuJiuExpeditionCollectionLayer:UpdatePage(arg_18_1, arg_18_2, arg_18_3)
	self.scoreList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("JiuJiuExpeditionCollectionIcon/" .. arg_18_1 .. "_" .. arg_19_1 + 1 + arg_18_3, "", arg_19_2:Find("icon"))
			setActive(arg_19_2:Find("lock"), not var_0_1(self, arg_18_1, arg_18_2[arg_19_1 + 1]))
		end

		return
	end)
	self.scoreList:align(#arg_18_2)

	return
end

function JiuJiuExpeditionCollectionLayer:CloseBook()
	self.isOpenBook = false

	setActive(self.bookContainer, true)
	setActive(self.book, false)

	return
end

function JiuJiuExpeditionCollectionLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parent)

	return
end

return JiuJiuExpeditionCollectionLayer
