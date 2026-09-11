local IlluEquipManualItem = class("IlluEquipManualItem", ReduxView)

function IlluEquipManualItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluEquipManualItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluEquipManualItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
end

function IlluEquipManualItem:RefreshUI(arg_4_1)
	self.id_ = arg_4_1.id
	self.nameText_.text = GetI18NText(EquipSuitCfg[self.id_].name)
	self.iconImg_.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[self.id_].icon)
	self.shadowImg_.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[self.id_].icon)
	self.have_ = IllustratedData:GetEquipInfo()[self.id_]

	if self.have_ then
		self.controller_:SetSelectedState("true")

		self.numText_.text = IlluTools.GetEquipHaveNum(self.id_) .. "/6"
		self.view_ = IllustratedData:GetIsView(self.id_, 4)

		manager.redPoint:SetRedPointIndependent(self.transform_, self.view_ == 0)
	else
		self.controller_:SetSelectedState("false")

		self.numText_.text = "0/6"

		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function IlluEquipManualItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.have_ and self.view_ == 0 then
			IllustratedAction.ViewIllustration(self.id_, CollectConst.EQUIP)
		end

		self:Go("/equipArchive", {
			equipID = self.id_
		})
	end)
end

function IlluEquipManualItem:Dispose()
	IlluEquipManualItem.super.Dispose(self)
end

return IlluEquipManualItem
