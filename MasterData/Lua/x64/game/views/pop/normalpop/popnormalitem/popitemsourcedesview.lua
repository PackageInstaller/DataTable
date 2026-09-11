local PopItemSourceDesView = class("PopItemSourceDesView", import("game.views.pop.PopItemView"))
local ItemTools = import("game.tools.ItemTools")

function PopItemSourceDesView:CustomInitUI()
	self.soureceDesControllerController:SetSelectedState("show")
	self.tabControllerController:SetSelectedState("descripe")
	self.btnShowControllerController:SetSelectedState("hide")
end

function PopItemSourceDesView:RefreshContent()
	local var_2_0 = ItemCfg[self.itemInfo_.id]

	self.nameText_.text = ItemTools.getItemName(ItemCfg[self.itemInfo_.id].id)
	self.countentText_.text = ItemTools.getItemDesc(var_2_0.id)

	if var_2_0.time == nil or var_2_0.time == "" then
		self.timeController:SetSelectedState("no")
	else
		local var_2_1 = ItemTools.GetItemExpiredTimeByInfo(self.itemInfo_)

		if var_2_1 <= manager.time:GetServerTime() then
			self.timeController:SetSelectedState("no")
		else
			self.timeController:SetSelectedState("yes")

			self.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(var_2_1, "!%Y/%m/%d %H:%M"))
		end
	end

	if var_2_0.type == ItemConst.ITEM_TYPE.STICKER then
		if self.extraInfo_.isForeign then
			SetActive(self.isLockGo_, false)
		else
			SetActive(self.isLockGo_, PlayerData:GetSticker(var_2_0.id).lock)
		end
	else
		SetActive(self.isLockGo_, false)
	end

	self.sourceDesTxt_.text = GetI18NText(var_2_0.desc_source) or ""
end

return PopItemSourceDesView
