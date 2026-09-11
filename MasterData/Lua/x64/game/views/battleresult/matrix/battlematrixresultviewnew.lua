NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleMatrixResultViewNew = class("BattleMatrixResultViewNew", NewBattleSettlementView)

function BattleMatrixResultViewNew:UIName()
	return "Widget/System/MatrixlUI/MatirxBattleResultWinUI"
end

function BattleMatrixResultViewNew:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()

	self.btnController = self.btnController_:GetController("btn")
	self.adaptComp = self:FindCom("AdaptImage", nil, self.commonMaskBg_.transform)

	self:AddListener()

	self.affixList = LuaList.New(handler(self, self.IndexAffixItem), self.affixListGo_, BattleMatrixAffixItem)
end

function BattleMatrixResultViewNew:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		BattleSettlementMatrixHeroHeadModule.New(self.heroHead1Obj_),
		BattleSettlementMatrixHeroHeadModule.New(self.heroHead2Obj_),
		(BattleSettlementMatrixHeroHeadModule.New(self.heroHead3Obj_))
	}
end

function BattleMatrixResultViewNew:OnAddListner()
	SetActive(self.emptyMaskBtn_.gameObject, true)
	self:AddBtnListener(self.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
end

function BattleMatrixResultViewNew:RenderView()
	self:RenderTitleView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshBattleTime()
	self:ShowContent()
end

function BattleMatrixResultViewNew:PostRenderView()
	self.btnController:SetSelectedState("nobtn")

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function BattleMatrixResultViewNew:RenderTitleView()
	SetActive(self.titleObj_, true)

	local var_9_0 = self.stageData:GetActivityID()
	local var_9_1 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(var_9_0)]

	self.titleTxt_.text = string.format("%s-%s", var_9_1.tier, var_9_1.level)
	self.affixTxt_.text = GetTips("MATRIX_GET_AFFIX")
	self.affixData = StrategyMatrixData:GetAffixList(var_9_0)

	self.affixList:StartScroll(#self.affixData)
end

function BattleMatrixResultViewNew:RefreshBattleTime()
	self.battleTimeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")
end

function BattleMatrixResultViewNew:RefreshHeroS()
	local var_11_0 = self.stageData:GetHeroTeam()

	for iter_11_0 = 1, 3 do
		if not var_11_0[iter_11_0] or var_11_0[iter_11_0] == 0 then
			self.heroModule[iter_11_0]:SetHeroData(nil)
			self.heroModule[iter_11_0]:ShowCaptain(false)
		else
			self.heroModule[iter_11_0]:ShowCaptain(true)

			local var_11_1 = self.stageData:GetHeroDataByPos(iter_11_0)
			local var_11_2 = {
				id = var_11_1.id,
				using_skin = var_11_1.using_skin
			}

			var_11_2.star = var_11_1.star or 0

			self.heroModule[iter_11_0]:SetHeroData(var_11_2)
			self.heroModule[iter_11_0]:ShowLevel(var_11_1.level, 1)

			local var_11_3 = StrategyMatrixData:GetHeroDataNew(var_11_0[iter_11_0])

			self.heroModule[iter_11_0]:ShowHp(var_11_3:GetHeroHP(), (var_11_3:GetHeroMaxHP()))
		end
	end
end

function BattleMatrixResultViewNew:onRenderMissionContent()
	self.missionView = self.missionView or MatrixBattleSettlementMissionModule.New(self.contentContainer_)

	self.missionView:RenderRewards(self.params_.rewardList)
end

function BattleMatrixResultViewNew:NeedAddExp()
	return false
end

function BattleMatrixResultViewNew:ShowVitalityBox(arg_14_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function BattleMatrixResultViewNew:ShowEquipBox(arg_15_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function BattleMatrixResultViewNew:IndexAffixItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.affixData[arg_16_1])
end

function BattleMatrixResultViewNew:Dispose()
	self.missionView:Dispose()
	self.affixList:Dispose()
	BattleMatrixResultViewNew.super.Dispose(self)
end

return BattleMatrixResultViewNew
