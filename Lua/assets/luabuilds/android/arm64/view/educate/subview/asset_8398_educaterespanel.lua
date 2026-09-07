local EducateResPanel = class("EducateResPanel", import("...base.BaseSubView"))

function EducateResPanel:getUIName()
	return "EducateResPanel"
end

function EducateResPanel:OnInit()
	self.moneyBtn = findTF(self._go, "res/money")
	self.moneyValue = findTF(self._go, "res/money/value"):GetComponent(typeof(Text))
	self.moodBtn = findTF(self._go, "res/mood")
	self.moodValue = findTF(self._go, "res/mood/value"):GetComponent(typeof(Text))
	self.moodMaxValue = pg.child_resource[EducateChar.RES_MOOD_ID].max_value
	self.siteBtn = findTF(self._go, "res/site")
	self.siteValue = findTF(self._go, "res/site/value"):GetComponent(typeof(Text))
	self.siteMaxValue = pg.child_resource[EducateChar.RES_SITE_ID].max_value

	local var_2_0 = findTF(self._go, "res"):GetComponent(typeof(Image))
	local var_2_1 = findTF(self._go, "res")

	if self.contextData and self.contextData.showBg then
		var_2_0.enabled = true

		self:OverlayPanel(self._tf, {
			pbList = {
				findTF(self._go, "res")
			}
		})
	else
		var_2_0.enabled = false
	end

	self:addListener()
	self:Flush()

	return
end

function EducateResPanel:addListener()
	onButton(self, self.moneyBtn, function()
		self:ShowResBox(EducateChar.RES_MONEY_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.moodBtn, function()
		self:ShowResBox(EducateChar.RES_MOOD_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.siteBtn, function()
		self:ShowResBox(EducateChar.RES_SITE_ID)

		return
	end, SFX_PANEL)

	return
end

function EducateResPanel:ShowResBox(arg_7_1)
	self:emit(EducateBaseUI.EDUCATE_ON_ITEM, {
		drop = {
			number = 1,
			type = EducateConst.DROP_TYPE_RES,
			id = arg_7_1
		}
	})

	return
end

function EducateResPanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self.char = getProxy(EducateProxy):GetCharData()
	self.siteMaxValue = self.char:GetSiteCnt()
	self.moneyValue.text = self.char.money
	self.moodValue.text = self.char.mood .. "/" .. self.moodMaxValue
	self.siteValue.text = self.char.site .. "/" .. self.siteMaxValue

	return
end

function EducateResPanel:FlushAddValue(arg_9_1, arg_9_2)
	if not self:GetLoaded() then
		return
	end

	self.moodValue.text = self.char.mood .. arg_9_1
	self.moneyValue.text = self.char.money .. arg_9_2

	return
end

function EducateResPanel:OnDestroy()
	if self.contextData and self.contextData.showBg then
		self:UnOverlayPanel(self._tf)
	end

	return
end

return EducateResPanel
