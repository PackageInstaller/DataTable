DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local DormInfomationModifierModule = class("DormInfomationModifierModule", DormInfomationModuleBase)

function DormInfomationModifierModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/ModifierPanel"
end

function DormInfomationModifierModule:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, DormIlluHeroItem)
end

function DormInfomationModifierModule:AddListener()
	return
end

function DormInfomationModifierModule:Show(arg_4_1)
	DormInfomationModifierModule.super.Show(self, arg_4_1)

	self.idLst = {}

	for iter_4_0, iter_4_1 in ipairs(BackhomeContentNoticeCfg[arg_4_1].params) do
		table.insert(self.idLst, iter_4_1)
	end

	self.uiList_:StartScroll(#self.idLst)

	self.info_.text = string.format(BackhomeContentNoticeCfg[arg_4_1].desc, "")
end

function DormInfomationModifierModule:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.idLst[arg_5_1])
	arg_5_2:RegistCallBack(function(arg_6_0)
		return
	end)
	arg_5_2:SetUnlock(true)
end

function DormInfomationModifierModule:OpenDetailView(arg_7_1)
	JumpTools.OpenPageByJump("/dormIlluHeroDetail", {
		heroID = arg_7_1,
		heroIDList = self.idLst
	})
end

function DormInfomationModifierModule:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil

	DormInfomationModifierModule.super.Dispose(self)
end

return DormInfomationModifierModule
