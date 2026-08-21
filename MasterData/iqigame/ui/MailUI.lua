-- chunkname: @IQIGame\\UI\\MailUI.lua

local MailUI = Base:Extend("MailUI", "IQIGame.Onigao.UI.MailUI", {
	currentSelect = 1
})
local MailMouldCell = require("IQIGame.UI.Mail.MailMouldCell")
local NewMouldCell = require("IQIGame.UI.Mail.NewMouldCell")

function MailUI:OnInit()
	self:Init()
end

function MailUI:GetPreloadAssetPaths()
	return nil
end

function MailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MailUI:OnOpen(userData)
	self.currentSelectMailCellIndex = nil
	self.currentSelect = 1
	self.toggles[self.currentSelect].isOn = true

	self:ShowPanel()
end

function MailUI:OnClose(userData)
	return
end

function MailUI:OnPause()
	return
end

function MailUI:OnResume()
	return
end

function MailUI:OnCover()
	return
end

function MailUI:OnReveal()
	return
end

function MailUI:OnRefocus(userData)
	return
end

function MailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	MailMouldCell.DisposeIn(self)
	NewMouldCell.DisposeIn(self)
	self.commonReturnBtn:Dispose()
end

function MailUI:Init()
	self.btnDel = self.BtnDel:GetComponent("Button")
	self.btnDelOnce = self.BtnDelOnce:GetComponent("Button")
	self.btnAuto = self.BtnAuto:GetComponent("Button")
	self.btnReceive = self.BtnReceive:GetComponent("Button")
	self.scrollPageList = self.goScrollList:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(gridCell)
		self:OnUpDateMailCell(gridCell)
	end

	function self.scrollPageList.onSelectedCell(gridCell)
		self:OnSelectMailCell(gridCell)
	end

	self.scrollNewPageList = self.NewScrollList:GetComponent("ScrollAreaList")

	function self.scrollNewPageList.onRenderCell(gridCell)
		self:OnUpDateNewCell(gridCell)
	end

	function self.scrollNewPageList.onSelectedCell(gridCell)
		self:OnSelectNewCell(gridCell)
	end

	function self.delegateClickBtnDel()
		self:OnClickBtnDel()
	end

	function self.delegateClickBtnDelOnce()
		self:OnClickBtnDelOnce()
	end

	function self.delegateClickBtnAuto()
		self:OnClickBtnAuto()
	end

	function self.delegateClickBtnReceive()
		self:OnClickBtnReceive()
	end

	function self.delegateGetAllMails()
		self:OnGetAllMails()
	end

	function self.delegateMailDataChange(mailId)
		self:OnMailDataChange(mailId)
	end

	function self.delegateDeleteMail(mails)
		self:OnDelegateDeleteMail(mails)
	end

	function self.delegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	self:LoadCommonSlotPrefab()

	self.toggles = {}

	for i = 1, 1 do
		self["Toggle" .. i]:GetComponent("ToggleHelperComponent").text = MailUIApi:GetToggleStr(i)

		local toggle = self["Toggle" .. i]:GetComponent("Toggle")

		toggle.group = self.ToggleGroup:GetComponent("ToggleGroup")
		toggle.isOn = false
		self.toggles[i] = toggle
	end

	UGUIUtil.SetText(self.NullText, MailUIApi:GetNullText(1))
	UGUIUtil.SetText(self.NewNullText, MailUIApi:GetNullText(2))

	self.BtnDel.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetBtnDeleteAllTxt()
	self.BtnAuto.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetBtnGetAllTxt()
	self.BtnReceive.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetBtnGetTxt()
	self.BtnDelOnce.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetBtnDeleteTxt()

	UGUIUtil.SetText(self.TipText, MailUIApi:GetTipText())

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function MailUI:LoadCommonSlotPrefab()
	self.itemsTab = {}

	for i = 1, 20 do
		local itemObj = UnityEngine.Object.Instantiate(self.CommonSlotUI)

		itemObj.transform:SetParent(self.GridItem.transform, false)
		itemObj:SetActive(false)

		self.itemsTab[i] = itemObj
	end

	self:ShowPanel()
end

function MailUI:ShowPanel()
	MailModule.GetAllMails()
	self:ShowContent(false)
	self:ShowTab()
end

function MailUI:OnAddListeners()
	self.btnDel.onClick:AddListener(self.delegateClickBtnDel)
	self.btnAuto.onClick:AddListener(self.delegateClickBtnAuto)
	self.btnReceive.onClick:AddListener(self.delegateClickBtnReceive)
	self.btnDelOnce.onClick:AddListener(self.delegateClickBtnDelOnce)
	EventDispatcher.AddEventListener(EventID.GetAllMailsEvent, self.delegateGetAllMails)
	EventDispatcher.AddEventListener(EventID.MailDataChangeEvent, self.delegateMailDataChange)
	EventDispatcher.AddEventListener(EventID.DeleteMailEvent, self.delegateDeleteMail)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateOnToggleChange)
	end
end

function MailUI:OnRemoveListeners()
	self.btnDel.onClick:RemoveListener(self.delegateClickBtnDel)
	self.btnAuto.onClick:RemoveListener(self.delegateClickBtnAuto)
	self.btnReceive.onClick:RemoveListener(self.delegateClickBtnReceive)
	self.btnDelOnce.onClick:RemoveListener(self.delegateClickBtnDelOnce)
	EventDispatcher.RemoveEventListener(EventID.GetAllMailsEvent, self.delegateGetAllMails)
	EventDispatcher.RemoveEventListener(EventID.MailDataChangeEvent, self.delegateMailDataChange)
	EventDispatcher.RemoveEventListener(EventID.DeleteMailEvent, self.delegateDeleteMail)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateOnToggleChange)
	end
end

function MailUI:OnGetAllMails()
	self.BtnDelOnce.gameObject:SetActive(self.currentSelectMail ~= nil)

	self.tableMails = {}

	local unreadNum = 0

	for k, v in pairs(MailModule.mailDic) do
		if v.cid ~= MailModule.specialMailCid then
			self.tableMails[#self.tableMails + 1] = v

			if not v.isRead then
				unreadNum = unreadNum + 1
			end
		end
	end

	self.scrollPageList:Refresh(#self.tableMails)
	self.BtnReceive:SetActive(false)

	if self.currentSelectMail ~= nil then
		self.currentSelectMail:OnTogChange(true)
		self:OnMailDataChange(self.currentSelectMail.mailData.id)
	end

	UGUIUtil.SetText(self.TotalNumText, MailUIApi:GetTotalNumText(#self.tableMails, UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_MAIL_LIMIT, CfgDiscreteDataTable[49].Data[1], true)))
	UGUIUtil.SetText(self.UnreadNumText, MailUIApi:GetUnreadNumText(unreadNum))

	local isHaveMail = #self.tableMails > 0

	self.ListMail:SetActive(isHaveMail)
	self.Null:SetActive(not isHaveMail)
	self.Tips:SetActive(isHaveMail)
	self:ShowTab()
end

function MailUI:OnDelegateDeleteMail(mails)
	if self.currentSelectMail ~= nil then
		local id = self.currentSelectMail.mailData.id

		for i, mailID in pairs(mails) do
			if mailID == id then
				self.currentSelectMail:OnTogChange(false)

				self.currentSelectMail = nil

				break
			end
		end
	end

	self:OnGetAllMails()
	self:ShowContent(false)
end

function MailUI:OnUpDateMailCell(cell)
	local mailData = self.tableMails[cell.index + 1]

	if mailData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject
	local itemCell = MailMouldCell.PackageOrReuseView(self, item)

	itemCell:SetItem(mailData)
	itemCell:SelectState(self.currentSelectMailCellIndex == cell.index)

	if cell.index == 0 then
		self:OnSelectMailCell(cell)
	end
end

function MailUI:OnSelectMailCell(cell)
	self.currentSelectMailCellIndex = cell.index

	local item = cell.gameObject
	local itemCell = MailMouldCell.PackageOrReuseView(self, item)

	if self.currentSelectMail ~= nil then
		self.currentSelectMail:SelectState(false)
	end

	self.currentSelectMail = itemCell

	self.currentSelectMail:SelectState(true)

	if self.currentSelectMail.mailData ~= nil then
		if self.currentSelectMail.mailData.isRead == false then
			MailModule.ReadMail(self.currentSelectMail.mailData.id)
		else
			self:OnMailDataChange(self.currentSelectMail.mailData.id)
		end
	end
end

function MailUI:OnMailDataChange(mailId)
	local mailData = MailModule.GetMailByMailID(mailId)

	if self.currentSelectMail ~= nil and self.currentSelectMail.mailData.id == mailId then
		self.currentSelectMail:SetItem(mailData)
	end

	self.BtnDelOnce:SetActive(self.currentSelectMail ~= nil)

	if mailData ~= nil then
		self.TextMailName:GetComponent("Text").text = MailUIApi:GetMailTile2(mailData.title)
		self.goSendTimeTitle:GetComponent("Text").text = MailUIApi:GetCreateTime(getDateText(mailData.createTime))
		self.TextSender:GetComponent("Text").text = MailUIApi:GetSender(mailData.sender)
		self.TextContent:GetComponent("Text").text = MailUIApi:GetContent(mailData.content)

		local tag = mailData.isHasItem == true

		self.BtnReceive:SetActive(tag)
		self.BtnDelOnce:SetActive(not tag)
		self:ShowPageItem()
	else
		self.BtnReceive:SetActive(false)
	end

	self:ShowContent(self.currentSelectMail ~= nil)
	self:ShowUnreadNum()
end

function MailUI:ShowUnreadNum()
	local unreadNum = 0

	for k, v in pairs(MailModule.mailDic) do
		if v.cid ~= MailModule.specialMailCid and not v.isRead then
			unreadNum = unreadNum + 1
		end
	end

	UGUIUtil.SetText(self.TotalNumText, MailUIApi:GetTotalNumText(#self.tableMails, UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_MAIL_LIMIT, CfgDiscreteDataTable[49].Data[1], true)))
	UGUIUtil.SetText(self.UnreadNumText, MailUIApi:GetUnreadNumText(unreadNum))
end

function MailUI:ShowPageItem()
	for i = 1, #self.itemsTab do
		self.itemsTab[i]:SetActive(false)
	end

	self.Item:SetActive(false)

	local itemObj

	if self.currentSelectMail ~= nil then
		local isShowItem = false
		local mailData = MailModule.GetMailByMailID(self.currentSelectMail.mailData.id)

		if mailData ~= nil and mailData.itemList ~= nil then
			local realItemList = {}

			for i, v in ipairs(mailData.itemList) do
				if CfgItemTable[v.cid] ~= nil then
					realItemList[#realItemList + 1] = v
				end
			end

			for k = 1, #self.itemsTab do
				if realItemList[k] ~= nil then
					itemObj = self.itemsTab[k]

					itemObj:SetActive(true)

					local itemData = ItemData.CreateByCIDAndNumber(realItemList[k].cid, 0)
					local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

					itemCell:SetItem(itemData)
					itemCell:SetNum(realItemList[k].num)

					isShowItem = true
				end
			end
		end

		self.Item:SetActive(isShowItem)
		self.GridItem:GetComponent("GrayComponent"):SetGray(not self.currentSelectMail.mailData.isHasItem)
	end

	local ItemScroll = self.ItemScroll:GetComponent("ScrollRect")

	ItemScroll.horizontalNormalizedPosition = 0
end

function MailUI:OnClickBtnBack()
	return
end

function MailUI:OnClickBtnDel()
	local mailList = {}

	for i, v in pairs(MailModule.mailDic) do
		if v.isRead == true and v.isHasItem == false then
			mailList[#mailList + 1] = v.id
		end
	end

	if #mailList == 0 then
		NoticeModule.ShowNotice(48002)

		return
	end

	MailModule.DelMail(mailList, true)
end

function MailUI:OnClickBtnDelOnce()
	if self.currentSelectMail ~= nil then
		local mailList = {
			self.currentSelectMail.mailData.id
		}

		MailModule.DelMail(mailList, false)
	end
end

function MailUI:OnClickBtnAuto()
	local mailList = {}

	for i, v in pairs(MailModule.mailDic) do
		if v.isHasItem == true then
			mailList[#mailList + 1] = v.id
		end
	end

	if #mailList == 0 then
		NoticeModule.ShowNotice(21044001)

		return
	end

	MailModule.PickUp(mailList, true)
end

function MailUI:OnClickBtnReceive()
	if self.currentSelectMail ~= nil and self.currentSelectMail.mailData.isHasItem == true then
		local mailList = {
			self.currentSelectMail.mailData.id
		}

		MailModule.PickUp(mailList, false)
	end
end

function MailUI:ShowContent(value)
	self.ContentPanel:SetActive(value)

	if not value and self.currentSelectMail ~= nil then
		self.currentSelectMail:SelectState(false)

		self.currentSelectMail = nil
	end
end

function MailUI:OnToggleChange(isOn)
	if isOn then
		local index

		for i = 1, #self.toggles do
			local toggle = self.toggles[i]

			if toggle.isOn == true then
				index = i

				break
			end
		end

		if self.currentSelect ~= index then
			self.currentSelect = index

			self:ShowTab()
		end
	end
end

function MailUI:ShowTab()
	if self.currentSelect == 1 then
		self.NewListPanel:SetActive(false)
		self.MailPanel:SetActive(true)
	end
end

function MailUI:OnUpDateNewCell(cell)
	local newData = self.tableNews[cell.index + 1]

	if newData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject
	local itemCell = NewMouldCell.PackageOrReuseView(self, item)

	itemCell:SetItem(newData)
end

function MailUI:OnSelectNewCell(cell)
	local newData = self.tableNews[cell.index + 1]

	if newData then
		UIModule.Open(Constant.UIControllerName.LibraryNewsPaperUI, Constant.UILayer.UI, newData)
	end
end

return MailUI
