local PrayPoolSelectPoolView = class("PrayPoolSelectPoolView", import("..base.BaseSubView"))

function PrayPoolSelectPoolView:getUIName()
	return "PrayPoolSelectPoolView"
end

function PrayPoolSelectPoolView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()

	return
end

function PrayPoolSelectPoolView:OnDestroy()
	return
end

function PrayPoolSelectPoolView:OnBackPress()
	return
end

function PrayPoolSelectPoolView:initData()
	self.prayProxy = getProxy(PrayProxy)
	self.poolToggleList = {}
	self.selectedPoolType = nil

	return
end

function PrayPoolSelectPoolView:initUI()
	self.poolListContainer = self._tf:Find("PoolList")
	self.poolTpl = self._tf:Find("PoolTpl")
	self.preBtn = self._tf:Find("PreBtn")
	self.nextBtn = self._tf:Find("NextBtn")
	self.nextBtnCom = GetComponent(self.nextBtn, "Button")
	self.poolList = UIItemList.New(self.poolListContainer, self.poolTpl)

	self.poolList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_7_1 + 1

			setImageSprite(arg_7_2:Find("PoolImg"), GetSpriteFromAtlas("ui/prayselectpoolpage_atlas", "pool" .. arg_7_1 + 1))
			onToggle(self, arg_7_2, function(arg_8_0)
				if arg_8_0 then
					self.nextBtnCom.interactable = true
					self.selectedPoolType = var_7_0

					self.prayProxy:setSelectedPoolNum(var_7_0)
				else
					self.nextBtnCom.interactable = false
					self.selectedPoolType = nil

					self.prayProxy:setSelectedPoolNum(nil)
				end

				return
			end, SFX_PANEL)

			self.poolToggleList[arg_7_1 + 1] = arg_7_2
		end

		return
	end)
	self.poolList:align(#pg.activity_ship_create.all)

	self.nextBtnCom.interactable = false

	onButton(self, self.preBtn, function()
		self.prayProxy:updatePageState(PrayProxy.STATE_HOME)
		self:emit(PrayPoolConst.SWITCH_TO_HOME_PAGE, PrayProxy.STATE_HOME)

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self.prayProxy:updateSelectedPool(self.selectedPoolType)
		self.prayProxy:updatePageState(PrayProxy.STAGE_SELECT_SHIP)
		self:emit(PrayPoolConst.SWITCH_TO_SELECT_SHIP_PAGE, PrayProxy.STAGE_SELECT_SHIP)

		return
	end, SFX_PANEL)
	self:Show()

	return
end

function PrayPoolSelectPoolView:updateUI()
	local var_11_0 = self.prayProxy:getSelectedPoolType()

	if var_11_0 then
		triggerToggle(self.poolToggleList[var_11_0], true)
	else
		return
	end

	return
end

return PrayPoolSelectPoolView
