local ReversePacmanBuffSubView = class("ReversePacmanBuffSubView", import("view.base.BaseSubView"))

ReversePacmanBuffSubView.LOCAL_SAVE_KEY = "ReversePacmanBuff"

function ReversePacmanBuffSubView:getUIName()
	return "ReversePacmanBuffPanel"
end

function ReversePacmanBuffSubView:OnLoaded()
	return
end

function ReversePacmanBuffSubView:OnInit()
	onButton(self, self.uiMaskTF, function()
		self:Hide()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SOUND_BACK)

	self.buffUIList = UIItemList.New(self.uiContentTF, self.uiContentTF:Find("tpl"))

	self.buffUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			self:InitBuffTpl(arg_6_1, arg_6_2)
		elseif arg_6_0 == UIItemList.EventUpdate then
			self:UpdateBuffTpl(arg_6_1, arg_6_2)
		end

		return
	end)

	self.slotUIList = UIItemList.New(self.uiSlotsTF, self.uiSlotsTF:Find("tpl"))

	self.slotUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateSlotTpl(arg_7_1, arg_7_2)
		end

		return
	end)

	return
end

function ReversePacmanBuffSubView:Show(arg_8_1, arg_8_2)
	ReversePacmanBuffSubView.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)
	self.slotCnt = arg_8_1
	self.selSlot = 1
	self.owndBuffIds, self.owndBuffCnts = self:GetOwndBuffs()
	self.selBuffIds = ReversePacmanBuffSubView.GetSelBuffIds(self.slotCnt)

	self.buffUIList:align(#self.owndBuffIds)
	self.slotUIList:align(self.slotCnt)

	self.hideCallback = arg_8_2

	return
end

function ReversePacmanBuffSubView:GetOwndBuffs()
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(ReversePacmanConst.BUFF) do
		local var_9_2 = self.activity:GetVitemNumber(pg.activity_chasing_skill[iter_9_1].item_id)

		if var_9_2 > 0 then
			table.insert(var_9_0, iter_9_1)
			table.insert(var_9_1, var_9_2)
		end
	end

	return var_9_0, var_9_1
end

function ReversePacmanBuffSubView:UpdateSlotTpl(arg_10_1, arg_10_2)
	local var_10_0 = self.selBuffIds[arg_10_1 + 1]
	local var_10_1 = self.selBuffIds[arg_10_1 + 1] == 0

	setActive(arg_10_2:Find("empty"), self.selBuffIds[arg_10_1 + 1] == 0)
	setActive(arg_10_2:Find("icon"), not var_10_1)
	setActive(arg_10_2:Find("Text"), false)

	if not var_10_1 then
		LoadImageSpriteAsync(pg.activity_chasing_skill[var_10_0].icon, arg_10_2:Find("icon"))
	end

	return
end

function ReversePacmanBuffSubView:InitBuffTpl(arg_11_1, arg_11_2)
	arg_11_2.name = tostring(self.owndBuffIds[arg_11_1 + 1])

	setText(arg_11_2:Find("content/name"), pg.activity_chasing_skill[self.owndBuffIds[arg_11_1 + 1]].name)
	setText(arg_11_2:Find("content/desc"), (string.gsub(pg.activity_chasing_skill[self.owndBuffIds[arg_11_1 + 1]].desc, "$1", pg.activity_chasing_skill[self.owndBuffIds[arg_11_1 + 1]].param)))
	setText(arg_11_2:Find("content/count"), self.owndBuffCnts[arg_11_1 + 1])
	LoadImageSpriteAsync(pg.activity_chasing_skill[self.owndBuffIds[arg_11_1 + 1]].icon, arg_11_2:Find("icon"))

	return
end

function ReversePacmanBuffSubView:UpdateBuffTpl(arg_12_1, arg_12_2)
	local var_12_0 = self.owndBuffIds[arg_12_1 + 1]
	local var_12_1 = table.contains(self.selBuffIds, self.owndBuffIds[arg_12_1 + 1])

	setActive(arg_12_2:Find("toggle/sel"), var_12_1)

	local var_12_2 = not var_12_1 and underscore.all(self.selBuffIds, function(arg_13_0)
		return arg_13_0 ~= 0
	end)

	setGray(arg_12_2:Find("toggle"), not var_12_1 and underscore.all(self.selBuffIds, function(arg_13_0)
		return arg_13_0 ~= 0
	end))
	onButton(self, arg_12_2:Find("toggle"), function()
		if var_12_2 then
			return
		end

		if var_12_1 then
			self.selBuffIds[table.indexof(self.selBuffIds, var_12_0)] = 0
		else
			self.selBuffIds[(function()
				for iter_15_0, iter_15_1 in ipairs(self.selBuffIds) do
					if iter_15_1 == 0 then
						return iter_15_0
					end
				end

				return
			end)()] = var_12_0
		end

		self:SortAndSaveSelIds()
		self.slotUIList:align(self.slotCnt)
		self.buffUIList:align(#self.owndBuffIds)

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanBuffSubView:SortAndSaveSelIds()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.selBuffIds) do
		if iter_16_1 ~= 0 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	for iter_16_2 = 1, self.slotCnt do
		if var_16_0[iter_16_2] == nil then
			var_16_0[iter_16_2] = 0
		end

		ReversePacmanBuffSubView.SetLocalBuffData(iter_16_2, var_16_0[iter_16_2])
	end

	self.selBuffIds = var_16_0

	return
end

function ReversePacmanBuffSubView:Hide()
	ReversePacmanBuffSubView.super.Hide(self)
	existCall(self.hideCallback)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ReversePacmanBuffSubView:OnDestroy()
	return
end

function ReversePacmanBuffSubView:GetLocalBuffData()
	return PlayerPrefs.GetInt(ReversePacmanBuffSubView.LOCAL_SAVE_KEY .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self) or 0
end

function ReversePacmanBuffSubView:SetLocalBuffData(arg_20_1)
	PlayerPrefs.SetInt(ReversePacmanBuffSubView.LOCAL_SAVE_KEY .. "_" .. getProxy(PlayerProxy):getRawData().id .. "_" .. self, arg_20_1)
	PlayerPrefs.Save()

	return
end

function ReversePacmanBuffSubView:GetSelBuffIds()
	local var_21_0 = {}

	for iter_21_0 = 1, self do
		local var_21_1 = ReversePacmanBuffSubView.GetLocalBuffData(iter_21_0)

		if var_21_1 ~= 0 and table.contains(var_21_0, var_21_1) then
			var_21_1 = 0

			ReversePacmanBuffSubView.SetLocalBuffData(iter_21_0, 0)
		end

		table.insert(var_21_0, var_21_1)
	end

	return var_21_0
end

return ReversePacmanBuffSubView
