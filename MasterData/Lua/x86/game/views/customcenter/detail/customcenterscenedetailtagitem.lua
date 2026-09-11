local CustomCenterSceneDetailTagItem = class("CustomCenterSceneDetailTagItem", ReduxView)

function CustomCenterSceneDetailTagItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function CustomCenterSceneDetailTagItem:Dispose()
	CustomCenterSceneDetailTagItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function CustomCenterSceneDetailTagItem:AddListeners()
	self:AddToggleListener(self.toggle_, function(arg_4_0)
		if arg_4_0 then
			if self.onSelect then
				self:onSelect()
			end
		elseif not self.toggle_.group:AnyTogglesOn() and self.onClear then
			self:onClear()
		end
	end)
end

function CustomCenterSceneDetailTagItem:SetData(arg_5_1)
	self.cfg = HomeSceneTagCfg[arg_5_1]
	self.text_.text = HomeSceneTagCfg[arg_5_1].tag_desc
	self.icon_.sprite = getSprite("Atlas/MainAtlas", HomeSceneTagCfg[arg_5_1].tag_icon)

	self:Show(true)
end

function CustomCenterSceneDetailTagItem:SetOnSelectCallback(arg_6_1)
	self.onSelect = arg_6_1
end

function CustomCenterSceneDetailTagItem:SetOnClearCallback(arg_7_1)
	self.onClear = arg_7_1
end

function CustomCenterSceneDetailTagItem:Select(arg_8_1)
	self.toggle.isOn = arg_8_1
end

function CustomCenterSceneDetailTagItem:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

return CustomCenterSceneDetailTagItem
