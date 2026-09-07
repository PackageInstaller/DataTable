local ShrineBuffView = class("ShrineBuffView", import("...base.BaseSubView"))

function ShrineBuffView:getUIName()
	return "ShrineBuff"
end

function ShrineBuffView:OnInit()
	self:Show()
	self:initData()
	self:initUI()
	self:updateView()

	return
end

function ShrineBuffView:OnDestroy()
	self.contextData.onClose()

	self.lockBackPress = false

	return
end

function ShrineBuffView:initData()
	self.lockBackPress = true

	return
end

function ShrineBuffView:initUI()
	self.bg = self._tf:Find("BG")
	self.backBtn = self._tf:Find("BackBtn")
	self.buffListTF = self._tf:Find("Main/BuffList")

	for iter_5_0 = 1, 3 do
		onButton(self, self.buffListTF:GetChild(iter_5_0 - 1), function()
			self.contextData.onSelect(iter_5_0)
			self:Destroy()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.backBtn, function()
		self:Destroy()

		return
	end, SFX_CANCEL)

	return
end

function ShrineBuffView:updateView()
	return
end

return ShrineBuffView
