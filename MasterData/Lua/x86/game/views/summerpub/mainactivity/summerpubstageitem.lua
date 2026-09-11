local SummerPubStageItem = class("SummerPubStageItem", ReduxView)

function SummerPubStageItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_3
	self.levelID_ = arg_1_2
	self.cfg_ = SummerPubLevelCfg[self.levelID_]
	self.selectHandler_ = arg_1_4

	self:Init()
end

function SummerPubStageItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerPubStageItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("selectState")
	self.passController_ = self.controllerEx_:GetController("passState")

	self:RefreshUI()
end

function SummerPubStageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("summerPubStageSectionView", {
			levelID = self.levelID_,
			battleType = BattleConst.STAGE_TYPE_NEW.SUMMER_PUB
		})

		if self.selectHandler_ then
			self.selectHandler_(self.index_, self.levelID_)
		end
	end)
end

function SummerPubStageItem:SetSelect(arg_6_1)
	if arg_6_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function SummerPubStageItem:RefreshUI()
	self.selectController_:SetSelectedState("false")

	if SummerPubData:GetLevelIDIsOpen(self.levelID_) then
		if self.cfg_.type == SummerPubConst.STAGE_TYPE.BALL then
			self.passController_:SetSelectedState("unlock")

			if SummerPubData:GetClearNumByStageID(self.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				self.passController_:SetSelectedState("complete")
			end

			if SummerPubData:GetClearNumByStageID(self.levelID_, SummerPubConst.PIN_BALL_STAGE_TYPE.HARD) > 0 then
				self.passController_:SetSelectedState("completehard")
			end
		elseif SummerPubData:GetClearNumByStageID(self.levelID_) > 0 then
			self.passController_:SetSelectedState("complete")
		else
			self.passController_:SetSelectedState("challenge")
		end
	else
		self.passController_:SetSelectedState("lock")
	end
end

function SummerPubStageItem:Dispose()
	SummerPubStageItem.super.Dispose(self)
end

return SummerPubStageItem
