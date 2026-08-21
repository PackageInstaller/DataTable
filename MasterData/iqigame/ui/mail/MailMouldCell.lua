-- chunkname: @IQIGame\\UI\\Mail\\MailMouldCell.lua

local MailMouldCell = {
	isSelected = false
}

function MailMouldCell.PackageOrReuseView(ui, mailMouldPrefab)
	if ui == nil or mailMouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		ui.__SUB_UI_MAP_MailMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MailMouldCell
	local mailItemCell

	if subUIMap[mailMouldPrefab:GetInstanceID()] == nil then
		mailItemCell = MailMouldCell:__New(mailMouldPrefab)
		subUIMap[mailMouldPrefab:GetInstanceID()] = mailItemCell
	else
		mailItemCell = subUIMap[mailMouldPrefab:GetInstanceID()]
	end

	return mailItemCell
end

function MailMouldCell:__New(itemCellView)
	local itemCell = Clone(self)

	itemCell.tabComponent = {}
	itemCell.goView = itemCellView

	LuaCodeInterface.BindOutlet(itemCellView, itemCell.tabComponent)

	return itemCell
end

function MailMouldCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MailMouldCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_MailMouldCell = nil
end

function MailMouldCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self.tabComponent)

	self.tabComponent = nil
	self.goView = nil
end

function MailMouldCell:SetItem(mailData)
	self.mailData = mailData

	if mailData == nil then
		self:Clear()
	else
		self:Update()
	end
end

function MailMouldCell:Update()
	if self.mailData ~= nil then
		self.tabComponent.TextMailName:GetComponent("Text").text = MailUIApi:GetMailTile(self.mailData.title, self.mailData.isRead)
		self.tabComponent.TextMailSender:GetComponent("Text").text = MailUIApi:GetTextMailSender(self.mailData.sender, self.mailData.isRead)

		if self.mailData.expireTime <= 0 then
			self.tabComponent.TextMailTime:GetComponent("Text").text = MailUIApi:GetMailTime(1, nil, self.mailData.isRead)
		else
			local cd = self.mailData.expireTime - PlayerModule.GetServerTime()

			if cd > 0 then
				self.tabComponent.TextMailTime:GetComponent("Text").text = MailUIApi:GetMailTime(2, getTimeDurationText(cd, 2), self.mailData.isRead)
			else
				self.tabComponent.TextMailTime:GetComponent("Text").text = MailUIApi:GetMailTime(3, nil, self.mailData.isRead)
			end
		end

		self.tabComponent.ImageMail:SetActive(not self.mailData.isRead)
		self.tabComponent.ImageBg:SetActive(not self.mailData.isRead)
		self.tabComponent.ImageBgOpen:SetActive(self.mailData.isRead)
		self.tabComponent.ImageNameBg:SetActive(not self.mailData.isRead)
		self.tabComponent.ImageNameBgOpen:SetActive(self.mailData.isRead)
		self.tabComponent.TextMail1:SetActive(not self.mailData.isRead and #self.mailData.itemList <= 0)
		self.tabComponent.TextMail2:SetActive(self.mailData.isRead and #self.mailData.itemList <= 0)
		self.tabComponent.ItemMail1:SetActive(self.mailData.isHasItem and #self.mailData.itemList > 0)
		self.tabComponent.ItemMail2:SetActive(not self.mailData.isHasItem and #self.mailData.itemList > 0)
		self.tabComponent.IsGetItemText:SetActive(not self.mailData.isHasItem and #self.mailData.itemList > 0)
	end
end

function MailMouldCell:SelectState(isOn)
	self.tabComponent.SelectImg:SetActive(isOn)

	local c = Constant.MailNameColor.Select

	if not isOn then
		if self.mailData.isRead then
			c = Constant.MailNameColor.Read
		else
			c = Constant.MailNameColor.UnRead
		end
	end

	self.tabComponent.TextMailName:GetComponent("Text").color = c
end

function MailMouldCell:OnTogChange(isOn)
	return
end

function MailMouldCell:Clear()
	self.goView:SetActive(false)
end

return MailMouldCell
