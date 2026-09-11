local AffixDescriptionView = class("AffixDescriptionView", ReduxView)

function AffixDescriptionView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function AffixDescriptionView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.data = arg_2_3

	self:Init()
end

function AffixDescriptionView:Init()
	self:BindCfgUI()

	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
	self.items = {}

	self:CreatItems()
end

function AffixDescriptionView:CreatItems()
	local var_4_0 = false
	local var_4_1 = false

	for iter_4_0, iter_4_1 in ipairs(self.data) do
		local var_4_2 = iter_4_1[3] == 3

		var_4_0 = var_4_0 or var_4_2
		var_4_1 = var_4_1 or not var_4_2

		if not self.items[1] then
			local var_4_4 = Object.Instantiate(self.m_item, (var_4_2 or nil) and (self.m_playerContent or self.m_monsterContent))
			local var_4_5 = {
				go = var_4_4
			}

			var_4_5.desc = var_4_4.transform:Find("text"):GetComponent("Text")
			var_4_5.name = var_4_4.transform:Find("title/name"):GetComponent("Text")
			var_4_5.icon = var_4_4.transform:Find("title/icon"):GetComponent("Image")
			self.items[1] = var_4_5
		end

		self:RenderItme(self.items[1], iter_4_1)
	end

	if var_4_0 and var_4_1 then
		self.emptyController:SetSelectedIndex(0)
	elseif var_4_1 then
		self.emptyController:SetSelectedIndex(1)
	elseif var_4_0 then
		self.emptyController:SetSelectedIndex(2)
	else
		self.emptyController:SetSelectedIndex(3)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)
end

function AffixDescriptionView:RenderItme(arg_5_1, arg_5_2)
	arg_5_1.icon.sprite = getAffixSprite(arg_5_2)
	arg_5_1.name.text = getAffixName(arg_5_2)
	arg_5_1.desc.text = getAffixDesc(arg_5_2)

	SetActive(arg_5_1.go, true)
end

function AffixDescriptionView:Dispose()
	self.items = {}

	AffixDescriptionView.super.Dispose(self)

	self.hander_ = nil
	self.data = nil
end

return AffixDescriptionView
