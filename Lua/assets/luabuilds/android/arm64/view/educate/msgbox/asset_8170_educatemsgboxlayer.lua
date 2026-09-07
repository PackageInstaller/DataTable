local EducateMsgBoxLayer = class("EducateMsgBoxLayer", import("..base.EducateBaseUI"))

EducateMsgBoxLayer.TYPE_NORMAL = 1
EducateMsgBoxLayer.TYPE_SINGLE_ITEM = 2

local var_0_1 = {
	[EducateMsgBoxLayer.TYPE_NORMAL] = Vector2(924, 616),
	[EducateMsgBoxLayer.TYPE_SINGLE_ITEM] = Vector2(1060, 628)
}
local var_0_2 = {
	[EducateMsgBoxLayer.TYPE_NORMAL] = i18n("child_msg_title_tip"),
	[EducateMsgBoxLayer.TYPE_SINGLE_ITEM] = i18n("child_msg_title_detail")
}

function EducateMsgBoxLayer:getUIName()
	return "EducateMsgBoxUI"
end

function EducateMsgBoxLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf, {
		groupDelta = 3
	})

	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateMsgBoxLayer.ON_CLOSE)

		return
	end)

	self._window = self._tf:Find("anim_root/window")

	setActive(self._window, true)

	self._top = self._window:Find("top")
	self._titleText = self._top:Find("title")
	self._closeBtn = self._top:Find("btnBack")
	self._msgPanel = self._window:Find("msg_panel")
	self.contentText = self._msgPanel:Find("content"):GetComponent("RichText")

	self.contentText:AddSprite("gold", self._tf:Find("res/gold"):GetComponent(typeof(Image)).sprite)

	self._sigleItemPanel = self._window:Find("single_item_panel")
	self.singleItemTF = self._sigleItemPanel:Find("item")
	self.singleItemOwn = self._sigleItemPanel:Find("own")
	self.singleItemName = self._sigleItemPanel:Find("display_panel/name")
	self.singleItemDesc = self._sigleItemPanel:Find("display_panel/desc/Text")
	self._noBtn = self._window:Find("button_container/no")

	setText(self._noBtn:Find("pic"), i18n("word_cancel"))

	self._yesBtn = self._window:Find("button_container/yes")

	setText(self._yesBtn:Find("pic"), i18n("word_ok"))

	return
end

function EducateMsgBoxLayer:didEnter()
	self:ShowMsgBox(self.contextData)

	return
end

function EducateMsgBoxLayer:ShowMsgBox(arg_5_1)
	self:commonSetting(arg_5_1)
	self:showByType(arg_5_1)

	return
end

function EducateMsgBoxLayer:commonSetting(arg_6_1)
	self.settings = arg_6_1

	local var_6_0 = self.settings.type or EducateMsgBoxLayer.TYPE_NORMAL

	self._window.sizeDelta = var_0_1[var_6_0]

	setText(self._titleText, var_0_2[var_6_0])
	setActive(self._msgPanel, false)
	setActive(self._sigleItemPanel, false)

	local var_6_1 = self.settings.hideYes or false
	local var_6_2 = self.settings.hideClose or false
	local var_6_3 = self.settings.onYes or function()
		return
	end
	local var_6_4 = self.settings.onNo or function()
		return
	end
	local var_6_5 = self.settings.onClose or function()
		return
	end

	setActive(self._noBtn, not (self.settings.hideNo or false))
	onButton(self, self._noBtn, function()
		if var_6_4 then
			var_6_4()
		end

		self:_close()

		return
	end, SFX_CANCEL)
	setActive(self._yesBtn, not var_6_1)
	onButton(self, self._yesBtn, function()
		if var_6_3 then
			var_6_3()
		end

		self:_close()

		return
	end, SFX_CANCEL)
	setActive(self._closeBtn, not var_6_2)
	onButton(self, self._closeBtn, function()
		if var_6_5 then
			var_6_5()
		else
			var_6_4()
		end

		self:_close()

		return
	end, SFX_CANCEL)
	onButton(self, tf(self._go):Find("anim_root/bg"), function()
		if var_6_5 then
			var_6_5()
		else
			var_6_4()
		end

		self:_close()

		return
	end, SFX_CANCEL)

	return
end

function EducateMsgBoxLayer:showByType(arg_14_1)
	switch(self.settings.type or EducateMsgBoxLayer.TYPE_NORMAL, {
		[EducateMsgBoxLayer.TYPE_NORMAL] = function()
			self:showNormalMsgBox()

			return
		end,
		[EducateMsgBoxLayer.TYPE_SINGLE_ITEM] = function()
			self:showSingleItemBox()

			return
		end
	})

	return
end

function EducateMsgBoxLayer:showNormalMsgBox()
	setActive(self._msgPanel, true)

	self.contentText.text = self.settings.content or ""

	return
end

function EducateMsgBoxLayer:showSingleItemBox()
	setActive(self._sigleItemPanel, true)
	setActive(self._noBtn, false)
	EducateHelper.UpdateDropShow(self.singleItemTF, self.settings.drop)

	local var_18_0 = EducateHelper.GetDropConfig(self.settings.drop)

	setText(self.singleItemName, var_18_0.name or "")

	if self.settings.drop.type == EducateConst.DROP_TYPE_RES and var_18_0.id == EducateChar.RES_MOOD_ID then
		setText(self.singleItemDesc, self:getMoodDesc(var_18_0.desc))
	else
		setText(self.singleItemDesc, (not var_18_0.desc or nil) and (var_18_0.name or ""))
	end

	if self.settings.drop.type == EducateConst.DROP_TYPE_ITEM then
		setText(self.singleItemOwn, i18n("child_msg_owned", (getProxy(EducateProxy):GetItemCntById(var_18_0.id))))
		setActive(self.singleItemOwn, true)
	else
		setActive(self.singleItemOwn, false)
	end

	return
end

function EducateMsgBoxLayer:getMoodDesc(arg_19_1)
	return string.gsub(arg_19_1, "$1", i18n("child_mood_desc" .. getProxy(EducateProxy):GetCharData():GetMoodStage()))
end

function EducateMsgBoxLayer:_close()
	self.anim:Play("anim_educate_MsgBox_out")

	return
end

function EducateMsgBoxLayer:onBackPressed()
	self:_close()

	return
end

function EducateMsgBoxLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return EducateMsgBoxLayer
