DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local DormInfomationFurnitureModule = class("DormInfomationFurnitureModule", DormInfomationModuleBase)

function DormInfomationFurnitureModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/FurniturePanel"
end

function DormInfomationFurnitureModule:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, FurnitureItemSimple)
end

function DormInfomationFurnitureModule:AddListener()
	return
end

function DormInfomationFurnitureModule:Show(arg_4_1)
	DormInfomationFurnitureModule.super.Show(self, arg_4_1)

	self.idLst = {}

	for iter_4_0, iter_4_1 in ipairs(BackhomeContentNoticeCfg[arg_4_1].params) do
		table.insert(self.idLst, iter_4_1)
	end

	self.uiList_:StartScroll(#self.idLst)

	self.info_.text = string.format(BackhomeContentNoticeCfg[arg_4_1].desc, "")
end

function DormInfomationFurnitureModule:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.idLst[arg_5_1])
end

function DormInfomationFurnitureModule:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	DormInfomationFurnitureModule.super.Dispose(self)
end

return DormInfomationFurnitureModule
