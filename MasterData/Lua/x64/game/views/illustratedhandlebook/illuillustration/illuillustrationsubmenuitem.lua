local illuillustrationSubMenuItem = class("illuillustrationSubMenuItem", ReduxView)

function illuillustrationSubMenuItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController = ControllerUtil.GetController(self.transform_, "toggle")
end

function illuillustrationSubMenuItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.chapterID_)
		end
	end)
end

function illuillustrationSubMenuItem:SetData(arg_4_1)
	self:Show(true)

	self.chapterID_ = arg_4_1
	self.titleText_.text = ChapterClientCfg[self.chapterID_].name
end

function illuillustrationSubMenuItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function illuillustrationSubMenuItem:SetClickFunc(arg_6_1)
	self.clickFunc_ = arg_6_1
end

function illuillustrationSubMenuItem:SetSelect(arg_7_1)
	self.selectController:SetSelectedState(arg_7_1 and "on" or "off")
end

function illuillustrationSubMenuItem:Dispose()
	illuillustrationSubMenuItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return illuillustrationSubMenuItem
