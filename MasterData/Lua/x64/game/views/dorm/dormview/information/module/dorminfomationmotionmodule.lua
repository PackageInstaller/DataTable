DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local DormInfomationMotionModule = class("DormInfomationMotionModule", DormInfomationModuleBase)

function DormInfomationMotionModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/MotionPanel"
end

function DormInfomationMotionModule:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, DormIlluDanceItem)
end

function DormInfomationMotionModule:AddListener()
	return
end

function DormInfomationMotionModule:Show(arg_4_1)
	DormInfomationMotionModule.super.Show(self, arg_4_1)

	self.idLst = {}

	for iter_4_0, iter_4_1 in ipairs(BackhomeContentNoticeCfg[arg_4_1].params) do
		table.insert(self.idLst, iter_4_1)
	end

	self.uiList_:StartScroll(#self.idLst)

	self.info_.text = string.format(BackhomeContentNoticeCfg[arg_4_1].desc, "")
end

function DormInfomationMotionModule:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.idLst[arg_5_1])
	arg_5_2:RegistCallBack(function(arg_6_0)
		return
	end)
	arg_5_2:SetUnlock(true)
end

function DormInfomationMotionModule:OpenDetailView(arg_7_1)
	JumpTools.OpenPageByJump("/dormIlluDanceDetail", {
		danceID = arg_7_1,
		danceIDList = self.idLst
	})
end

function DormInfomationMotionModule:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	DormInfomationMotionModule.super.Dispose(self)
end

return DormInfomationMotionModule
