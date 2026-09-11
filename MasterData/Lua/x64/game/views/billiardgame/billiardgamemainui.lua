local BilliardGameMainUI = class("BilliardGameMainUI", ReduxView)

function BilliardGameMainUI:UIName()
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_MainUI"
end

function BilliardGameMainUI:UIParent()
	return manager.ui.uiMain.transform
end

function BilliardGameMainUI:Init()
	self:OnInit()
end

function BilliardGameMainUI:BuildContext()
	self.questModule_ = BilliardGameQuestModule.New(self.questObj_)
	self.heroInfoModule_ = BilliardGameHeroInfoModule.New(self.heroInfoModuleObj_)
end

function BilliardGameMainUI:OnInit()
	self:BindCfgUI()
	self:BuildContext()
	BilliardGameTools.BindBilliardGameUI(self.turnBasedObj_)
	self:AddEventListner()

	self.heroInfoController_ = self.mainControllerEx_:GetController("heroInfo")
end

function BilliardGameMainUI:AddEventListner()
	self:RegistEventListener(BilliardGameEvent.BILLIARD_UPDATE_VIEW, function()
		self:UpdateView()
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_HERO_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		self:ShowHeroInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end)
	self:RegistEventListener(BilliardGameEvent.BILLIARD_CONDITION_FINISH, function(arg_9_0)
		self.questModule_:Finish(arg_9_0)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		self:OnDescClick()
	end)
	self:AddBtnListener(self.heroInfoMaskBtn_, nil, function()
		self:ShowHeroInfo(false)
	end)
end

function BilliardGameMainUI:OnDescClick()
	JumpTools.OpenPageByJump("billiardGameIlluView", {
		stageId = BilliardGameMgr:GetStageId()
	})
end

function BilliardGameMainUI:OnEnter()
	self:Refresh()
end

function BilliardGameMainUI:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			prefabPath = "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_TipsPopUI",
			content = GetTips("BILLIARD_GAME_BACK"),
			OkCallback = function()
				SendBilliardMessage((BilliardGameLuaBridge.GetExchangeData()))
				LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
			end
		})
	end)
end

function BilliardGameMainUI:OnBehind()
	manager.windowBar:HideBar()
end

function BilliardGameMainUI:Refresh()
	self.questModule_:Refresh((BilliardGameMgr:GetStageId()))
end

function BilliardGameMainUI:UpdateView()
	self.questModule_:OnDataChange()
end

function BilliardGameMainUI:ShowHeroInfo(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_1 then
		self.heroInfoController_:SetSelectedState("hide")

		return
	end

	self.heroInfoController_:SetSelectedState("showIndex" .. arg_20_2)
	self.heroInfoModule_:Refresh(arg_20_3, arg_20_4, arg_20_5)
end

function BilliardGameMainUI:OnExit()
	return
end

function BilliardGameMainUI:Dispose()
	self.questModule_:Dispose()
	self.heroInfoModule_:Dispose()
	BilliardGameMainUI.super.Dispose(self)
end

return BilliardGameMainUI
