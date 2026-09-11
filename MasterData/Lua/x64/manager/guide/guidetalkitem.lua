local GuideTalkItem = class("GuideTalkItem")

function GuideTalkItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function GuideTalkItem:Init()
	self:InitUI()
end

function GuideTalkItem:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	if self.controllerEx_ then
		self.heroController = self.controllerEx_:GetController("hero")
		self.reverseController = self.controllerEx_:GetController("reverse")
		self.nameController = self.controllerEx_:GetController("name")
	end
end

function GuideTalkItem:SetData(arg_4_1, arg_4_2)
	if self.scrollrect_ then
		self.scrollrect_.normalizedPosition = Vector2(0, 1)
	end

	self.textCom_.text = arg_4_1.talk_content

	local var_4_0, var_4_1 = arg_4_2:GetNarratorInfo()

	if self.dialogNameText_ then
		self.dialogNameText_.text = var_4_0
	end

	if self.dialogHeadImg_ then
		self.dialogHeadImg_.sprite = string.isNullOrEmpty(arg_4_2.talk_icon_path) and getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", var_4_1)) or pureGetSpriteWithoutAtlas(arg_4_2.talk_icon_path .. var_4_1)
	end

	if self.controllerEx_ then
		if arg_4_1.has_icon == 1 then
			self.heroController:SetSelectedState("hide")
			self.reverseController:SetSelectedState(arg_4_1.has_name == 1 and "notname" or "nothero")
			self.nameController:SetSelectedState("nothero")
		else
			local var_4_2 = arg_4_1.is_reversed == 0 or arg_4_1.is_reversed == nil

			self.heroController:SetSelectedState((arg_4_1.is_reversed == 0 or arg_4_1.is_reversed == nil) and "left" or "right")
			self.reverseController:SetSelectedState(var_4_2 and "left" or "right")

			if arg_4_1.has_name == 1 then
				self.nameController:SetSelectedState("hide")
			else
				self.nameController:SetSelectedState(var_4_2 and "left" or "right")
			end
		end
	end
end

function GuideTalkItem:Hide()
	SetActive(self.gameObject_, false)
end

function GuideTalkItem:Show()
	SetActive(self.gameObject_, true)
end

function GuideTalkItem:Dispose()
	Object.Destroy(self.gameObject_)
end

return GuideTalkItem
