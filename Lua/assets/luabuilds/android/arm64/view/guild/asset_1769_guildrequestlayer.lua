local GuildRequestLayer = class("GuildRequestLayer", import("..base.BaseUI"))

function GuildRequestLayer:getUIName()
	return "GuildRequestUI"
end

function GuildRequestLayer:setRequest(arg_2_1)
	self.requestVOs = arg_2_1

	return
end

function GuildRequestLayer:init()
	self.viewRect = self._tf:Find("request_panel/view")
	self.listEmptyTF = self._tf:Find("main/frame/empty")
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_guildrequestui"))

	self.scrollRect = self.viewRect:GetComponent("LScrollRect")

	return
end

function GuildRequestLayer:didEnter()
	pg.GuildPaintingMgr.GetInstance():Hide()

	return
end

function GuildRequestLayer:initRequests()
	self.requestCards = {}

	function self.scrollRect.onInitItem(arg_6_0)
		self:onInitItem(arg_6_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_7_0, arg_7_1)
		self:onUpdateItem(arg_7_0, arg_7_1)

		return
	end

	self:SetTotalCount()

	return
end

function GuildRequestLayer:onInitItem(arg_8_1)
	local var_8_0 = GuildRequestCard.New(arg_8_1)

	onButton(self, var_8_0.accpetBtn, function()
		self:emit(GuildRequestMediator.ACCPET, var_8_0.requestVO.player.id)

		return
	end, SFX_PANEL)
	onButton(self, var_8_0.rejectBtn, function()
		self:emit(GuildRequestMediator.REJECT, var_8_0.requestVO.player.id)

		return
	end, SFX_PANEL)

	self.requestCards[arg_8_1] = var_8_0

	return
end

function GuildRequestLayer:onUpdateItem(arg_11_1, arg_11_2)
	if not self.requestCards[arg_11_2] then
		self:onInitItem(arg_11_2)
	end

	self.requestCards[arg_11_2]:Update(self.requestVOs[arg_11_1 + 1])

	return
end

function GuildRequestLayer:SetTotalCount()
	table.sort(self.requestVOs, function(arg_13_0, arg_13_1)
		return arg_13_0.timestamp < arg_13_1.timestamp
	end)
	self.scrollRect:SetTotalCount(#self.requestVOs, 0)
	setActive(self.listEmptyTF, #self.requestVOs <= 0)

	return
end

function GuildRequestLayer:addRequest(arg_14_1)
	table.insert(self.requestVOs, arg_14_1)
	self:SetTotalCount()

	return
end

function GuildRequestLayer:deleteRequest(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.requestVOs) do
		if iter_15_1.player.id == arg_15_1 then
			table.remove(self.requestVOs, iter_15_0)

			break
		end
	end

	self:SetTotalCount()

	return
end

function GuildRequestLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:emit(GuildRequestLayer.ON_BACK)

	return
end

function GuildRequestLayer:willExit()
	for iter_17_0, iter_17_1 in pairs(self.requestCards) do
		iter_17_1:Dispose()
	end

	return
end

return GuildRequestLayer
