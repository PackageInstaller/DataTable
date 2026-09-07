local RefluxSignView = class("RefluxSignView", import("..base.BaseSubView"))

function RefluxSignView:getUIName()
	return "RefluxSignUI"
end

function RefluxSignView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()
	self:tryAutoSign()

	return
end

function RefluxSignView:OnDestroy()
	return
end

function RefluxSignView:OnBackPress()
	self:Hide()

	return
end

function RefluxSignView:initData()
	self.refluxProxy = getProxy(RefluxProxy)
	self.dayAwardList = self:getAllAwardList()
	self.totalSignCount = #pg.return_sign_template.all

	return
end

function RefluxSignView:initUI()
	local var_6_0 = self._tf:Find("DayImg")

	self.daySpriteList = {}

	for iter_6_0 = 0, self.totalSignCount - 1 do
		table.insert(self.daySpriteList, (getImageSprite((var_6_0:GetChild(iter_6_0)))))
	end

	self.dayTpl = self._tf:Find("DayTpl")
	self.scrollRectTF = self._tf:Find("ScrollRect")
	self.dayContainerTF = self._tf:Find("ScrollRect/Container")
	self.signCountText = self._tf:Find("DayCount/Text")
	self.dayUIItemList = UIItemList.New(self.dayContainerTF, self.dayTpl)

	self.dayUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_7_2:Find("DayImg")
			local var_7_1 = arg_7_2:Find("Got")
			local var_7_2 = arg_7_2:Find("GotMask")

			arg_7_1 = arg_7_1 + 1

			for iter_7_0, iter_7_1 in ipairs({
				arg_7_2:Find("Item1/Icon"),
				arg_7_2:Find("Item2/Icon"),
				(arg_7_2:Find("Item3/Icon"))
			}) do
				if self.dayAwardList[arg_7_1][iter_7_0].type ~= DROP_TYPE_SHIP then
					setImageSprite(iter_7_1, LoadSprite(self.dayAwardList[arg_7_1][iter_7_0]:getIcon()))
				else
					setImageSprite(iter_7_1, LoadSprite("QIcon/" .. Ship.New({
						configId = self.dayAwardList[arg_7_1][iter_7_0].id
					}):getPainting()))
				end
			end

			local var_7_3 = arg_7_1 <= self.refluxProxy.signCount

			setActive(var_7_1, arg_7_1 <= self.refluxProxy.signCount)
			setActive(var_7_2, var_7_3)
			setImageSprite(var_7_0, self.daySpriteList[arg_7_1])
		end

		return
	end)

	self.scrollSC = self.scrollRectTF:GetComponent(typeof(ScrollRect))
	self.hlgSC = self.dayContainerTF:GetComponent(typeof(HorizontalLayoutGroup))
	self.hlgLeft = self.hlgSC.padding.left
	self.hlgSpacing = self.hlgSC.spacing
	self.tplWidth = self.dayTpl:GetComponent(typeof(LayoutElement)).preferredWidth

	return
end

function RefluxSignView:updateUI()
	setText(self.signCountText, self.refluxProxy.signCount)
	self.dayUIItemList:align(self.totalSignCount)
	self:autoScroll(self.refluxProxy.signCount)

	return
end

function RefluxSignView:updateOutline()
	return
end

function RefluxSignView:getAllAwardList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(pg.return_sign_template.all) do
		local var_10_1 = {}

		for iter_10_2, iter_10_3 in ipairs(pg.return_sign_template[iter_10_1].award_display[self:getLevelIndex(self.refluxProxy.returnLV, pg.return_sign_template[iter_10_1].level)]) do
			table.insert(var_10_1, (Drop.Create(iter_10_3)))
		end

		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

function RefluxSignView:getLevelIndex(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		if iter_11_1[1] <= arg_11_1 and arg_11_1 <= iter_11_1[2] then
			return iter_11_0
		end
	end

	return
end

function RefluxSignView:tryAutoSign()
	if self.refluxProxy:isCanSign() then
		pg.m02:sendNotification(GAME.REFLUX_SIGN)
	end

	return
end

function RefluxSignView:autoScroll(arg_13_1)
	self.scrollSC.horizontalNormalizedPosition = math.clamp(arg_13_1 == 1 and 0 or arg_13_1 == self.dayContainerTF.childCount and 1 or arg_13_1 / self.dayContainerTF.childCount, 0, 1)

	return
end

return RefluxSignView
