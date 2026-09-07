local EducateExtraAttrLayer = class("EducateExtraAttrLayer", import(".base.EducateBaseUI"))

function EducateExtraAttrLayer:getUIName()
	return "EducateExtraAttrUI"
end

function EducateExtraAttrLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateExtraAttrLayer:initData()
	self.char = getProxy(EducateProxy):GetCharData()
	self.attrList = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	self.selectedIndex = 0

	return
end

function EducateExtraAttrLayer:findUI()
	self.windowTF = self._tf:Find("window")
	self.attrUIList = UIItemList.New(self.windowTF:Find("content"), self.windowTF:Find("content/tpl"))
	self.avatarTF = self.windowTF:Find("avatar")
	self.curPersonalText = self.avatarTF:Find("Text")
	self.sureBtn = self.windowTF:Find("sure_btn")

	return
end

function EducateExtraAttrLayer:addListener()
	onButton(self, self.sureBtn, function()
		if self.selectedIndex == 0 then
			return
		end

		self:emit(EducateExtraAttrLayer.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_extraAttr_sure_tip"),
			onYes = function()
				self:emit(EducateExtraAttrMediator.ON_ATTR_ADD, {
					id = self.attrList[self.selectedIndex]
				})
				self:emit(EducateExtraAttrLayer.ON_CLOSE)

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function EducateExtraAttrLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	self.attrUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("educateprops/" .. pg.child_attr[self.attrList[arg_9_1 + 1]].icon, arg_9_2:Find("icon"), true)
			setText(arg_9_2:Find("name"), pg.child_attr[self.attrList[arg_9_1 + 1]].name)
			onButton(self, arg_9_2, function()
				if self.selectedIndex == arg_9_1 + 1 then
					return
				end

				self.selectedIndex = arg_9_1 + 1

				self:updateView()

				return
			end, SFX_PANEL)
		elseif arg_9_0 == UIItemList.EventUpdate then
			setActive(arg_9_2:Find("selected"), self.selectedIndex == arg_9_1 + 1)
		end

		return
	end)
	self:updateView()

	return
end

function EducateExtraAttrLayer:updateView()
	self.attrUIList:align(#self.attrList)

	local var_11_0 = self.char:GetPaintingName()

	setText(self.curPersonalText, "当前主导个性：" .. pg.child_attr[self.char:GetPersonalityId()].name)

	return
end

function EducateExtraAttrLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return EducateExtraAttrLayer
