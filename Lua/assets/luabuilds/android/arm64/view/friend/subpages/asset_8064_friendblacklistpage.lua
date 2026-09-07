local FriendBlackListPage = class("FriendBlackListPage", import("...base.BaseSubView"))

function FriendBlackListPage:getUIName()
	return "FriendBlackListUI"
end

function FriendBlackListPage:OnLoaded()
	self.blackListPanel = self._tf:Find("blacklist_panel")
	self.blacklistTopTF = self._tf:Find("blacklist_view_top")

	return
end

function FriendBlackListPage:OnInit()
	return
end

function FriendBlackListPage:UpdateData(arg_4_1)
	self.blackVOs = arg_4_1.blackVOs

	if not self.isInit then
		self.isInit = true

		self:initBlackList()

		if not self.blackVOs then
			self:emit(FriendMediator.GET_BLACK_LIST)
		else
			self:sortBlackList()
		end
	else
		self.blackVOs = self.blackVOs or {}

		self:sortBlackList()
	end

	return
end

function FriendBlackListPage:initBlackList()
	self.blackItems = {}
	self.blackRect = self.blackListPanel:Find("mask/view"):GetComponent("LScrollRect")

	function self.blackRect.onInitItem(arg_6_0)
		self:onInitItem(arg_6_0)

		return
	end

	function self.blackRect.onUpdateItem(arg_7_0, arg_7_1)
		self:onUpdateItem(arg_7_0, arg_7_1)

		return
	end

	return
end

function FriendBlackListPage:onInitItem(arg_8_1)
	local var_8_0 = FriendBlackListCard.New(arg_8_1)

	onButton(self, var_8_0.btn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("firend_relieve_blacklist_tip", var_8_0.friendVO.name),
			onYes = function()
				self:emit(FriendMediator.RELIEVE_BLACKLIST, var_8_0.friendVO.id)

				return
			end
		})

		return
	end)

	self.blackItems[arg_8_1] = var_8_0

	return
end

function FriendBlackListPage:onUpdateItem(arg_11_1, arg_11_2)
	if not self.blackItems[arg_11_2] then
		self:onInitItem(arg_11_2)
	end

	self.blackItems[arg_11_2]:update(self.blackVOs[arg_11_1 + 1])

	return
end

function FriendBlackListPage:sortBlackList()
	table.sort(self.blackVOs, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)
	self.blackRect:SetTotalCount(#self.blackVOs, -1)

	return
end

function FriendBlackListPage:OnDestroy()
	for iter_14_0, iter_14_1 in pairs(self.blackItems or {}) do
		iter_14_1:dispose()
	end

	return
end

return FriendBlackListPage
