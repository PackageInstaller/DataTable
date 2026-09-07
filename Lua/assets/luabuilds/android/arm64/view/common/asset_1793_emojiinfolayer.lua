local EmojiInfoLayer = class("EmojiInfoLayer", import("view.base.BaseUI"))

function EmojiInfoLayer:getUIName()
	return "EmojiInfoUI"
end

function EmojiInfoLayer:init()
	self.nameTxt = self._tf:Find("frame/name"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.emojiContainer = self._tf:Find("frame/icon_bg")

	setText(self._tf:Find("frame/tip"), i18n("word_click_to_close"))

	return
end

function EmojiInfoLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(EmojiInfoLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	self:Flush()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function EmojiInfoLayer:Flush()
	assert(self.contextData.id)

	self.nameTxt.text = pg.emoji_template[self.contextData.id].item_name
	self.descTxt.text = pg.emoji_template[self.contextData.id].item_desc

	self:ReturnEmoji()
	self:LoadEmoji(pg.emoji_template[self.contextData.id])

	return
end

function EmojiInfoLayer:LoadEmoji(arg_6_1)
	PoolMgr.GetInstance():GetPrefab("emoji/" .. arg_6_1.pic, arg_6_1.pic, true, function(arg_7_0)
		local var_7_0 = arg_7_0:GetComponent("Animator")

		if var_7_0 then
			var_7_0.enabled = true
		end

		setParent(arg_7_0, self.emojiContainer, false)

		self.emoji = arg_7_0

		return
	end)

	self.template = arg_6_1

	return
end

function EmojiInfoLayer:ReturnEmoji()
	if self.template and self.emoji then
		PoolMgr.GetInstance():ReturnPrefab("emoji/" .. self.template.pic, self.template.pic, self.emoji)

		self.template = nil
		self.emoji = nil
	end

	return
end

function EmojiInfoLayer:onBackPressed()
	EmojiInfoLayer.super.onBackPressed(self)

	return
end

function EmojiInfoLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:ReturnEmoji()

	return
end

return EmojiInfoLayer
