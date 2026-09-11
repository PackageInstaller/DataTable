local IlluEquipManual = class("IlluEquipManual", ReduxView)

function IlluEquipManual:UIName()
	return "Widget/System/IllustratedHandbook/IlluEquipUI"
end

function IlluEquipManual:UIParent()
	return manager.ui.uiMain.transform
end

function IlluEquipManual:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluEquipManual:InitUI()
	self:BindCfgUI()

	self.itemScroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluEquipManualItem)
end

function IlluEquipManual:AddUIListener()
	return
end

function IlluEquipManual:UpdateDate()
	self.itemList_ = {}

	local var_6_0 = HideInfoData:GetEquipSuitHideList()

	for iter_6_0, iter_6_1 in ipairs(EquipSuitCfg.all) do
		if not var_6_0[iter_6_1] then
			self.itemList_[1] = {
				id = iter_6_1
			}
		end
	end
end

function IlluEquipManual:indexItem(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(self.itemList_[arg_7_1])
end

function IlluEquipManual:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:UpdateDate()

	if self.params_.scrollPos_ then
		self.itemScroll_:StartScrollByPosition(#self.itemList_, self.params_.scrollPos_)
	else
		self.itemScroll_:StartScroll(#self.itemList_)
	end

	self.numText_.text = IlluTools.GetEquipAll() .. "/" .. EquipTools.GetSuitTotalNum() * 6
end

function IlluEquipManual:OnExit()
	manager.windowBar:HideBar()

	self.params_.scrollPos_ = self.itemScroll_:GetScrolledPosition()
end

function IlluEquipManual:Dispose()
	self.itemScroll_:Dispose()

	self.itemScroll_ = nil

	IlluEquipManual.super.Dispose(self)
end

return IlluEquipManual
