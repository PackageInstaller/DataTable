local IlluWorldIViewItem = class("IlluWorldIViewItem", ReduxView)

function IlluWorldIViewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluWorldIViewItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluWorldIViewItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
end

function IlluWorldIViewItem:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.info_ = arg_4_2
	self.isFirst_ = self.info_.isFirst
	self.id_ = self.info_.id
	self.nameText_.text = GetI18NText(CollectWordCfg[self.id_].name)

	self:ShowSelect2(arg_4_2.select)

	self.isRead_ = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, self.id_)

	if self.isFirst_ then
		manager.redPoint:SetRedPointIndependent(self.transform_, false)

		if self.isRead_ == 0 then
			IllustratedAction.ViewIllustration(self.id_, CollectConst.WORLDVIEW)
		end

		self.info_.isFirst = false
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, self.isRead_ == 0, nil)
	end
end

function IlluWorldIViewItem:ShowSelect(arg_5_1)
	self.info_.select = arg_5_1

	if arg_5_1 then
		self.controller_:SetSelectedState("sel")

		if self.isRead_ == 0 then
			IllustratedAction.ViewIllustration(self.id_, CollectConst.WORLDVIEW)
		end

		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	else
		self.controller_:SetSelectedState("notSel")
	end
end

function IlluWorldIViewItem:ShowSelect2(arg_6_1)
	self.info_.select = arg_6_1

	if arg_6_1 then
		self.controller_:SetSelectedState("sel")
	else
		self.controller_:SetSelectedState("notSel")
	end
end

function IlluWorldIViewItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.func_ then
			self.func_(self.index_)
		end
	end)
end

function IlluWorldIViewItem:RegisterBtnListener(arg_9_1)
	self.func_ = arg_9_1
end

function IlluWorldIViewItem:Dispose()
	IlluWorldIViewItem.super.Dispose(self)
end

return IlluWorldIViewItem
