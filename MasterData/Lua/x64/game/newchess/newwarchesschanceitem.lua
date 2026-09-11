local var_0_0 = {
	function(arg_1_0)
		if NewWarChessData:GetAttribute(arg_1_0) >= 1 then
			return true
		else
			return false
		end
	end,
	function(arg_2_0)
		if NewWarChessData:GetAttribute(arg_2_0) == 0 then
			return true
		else
			return false
		end
	end,
	function()
		if not NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function()
		if NewWarChessData:CheckIsAllDie() then
			return true
		else
			return false
		end
	end,
	function(arg_5_0, arg_5_1)
		if arg_5_1 <= NewWarChessData:GetAttribute(arg_5_0) then
			return true
		else
			return false
		end
	end,
	function(arg_6_0, arg_6_1)
		if arg_6_1 > NewWarChessData:GetAttribute(arg_6_0) then
			return true
		else
			return false
		end
	end,
	function(arg_7_0)
		if arg_7_0 <= NewWarChessData:GetDiceNum() then
			return true
		else
			return false
		end
	end,
	function(arg_8_0)
		if arg_8_0 > NewWarChessData:GetDiceNum() then
			return true
		else
			return false
		end
	end
}
local NewWarChessChanceItem = class("NewWarChessChanceItem", ReduxView)

function NewWarChessChanceItem:OnCtor(arg_9_1)
	self.gameObject_ = arg_9_1
	self.transform_ = arg_9_1.transform

	self:Init()
end

function NewWarChessChanceItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewWarChessChanceItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "status")
end

function NewWarChessChanceItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnChanceItemClick()
	end)
end

function NewWarChessChanceItem:SetNewChanceHandle(arg_14_1)
	self.executeChanceItemHandle_ = arg_14_1
end

function NewWarChessChanceItem:SetData(arg_15_1, arg_15_2)
	self.chanceID_ = arg_15_1
	self.chanceItemID_ = arg_15_2
	self.chanceItemCfg_ = NewWarChessChanceItemCfg[self.chanceItemID_]
	self.stateInfo_ = NewWarChessData:GetChanceItemState(self.chanceItemID_)
	self.realState_ = 0

	if self.stateInfo_.ispre == 0 then
		if self.chanceItemCfg_.self_state_event[1] then
			if self.chanceItemCfg_.self_state_event[1] == 1 or self.chanceItemCfg_.self_state_event[1] == 2 or self.chanceItemCfg_.self_state_event[1] == 7 or self.chanceItemCfg_.self_state_event[1] == 8 then
				self.realState_ = var_0_0[self.chanceItemCfg_.self_state_event[1]](self.chanceItemCfg_.self_state_event[2]) and self.chanceItemCfg_.self_state_event[3] or self.stateInfo_.state
			elseif self.chanceItemCfg_.self_state_event[1] == 3 or self.chanceItemCfg_.self_state_event[1] == 4 then
				self.realState_ = var_0_0[self.chanceItemCfg_.self_state_event[1]]() and self.chanceItemCfg_.self_state_event[2] or self.stateInfo_.state
			elseif self.chanceItemCfg_.self_state_event[1] == 5 or self.chanceItemCfg_.self_state_event[1] == 6 then
				self.realState_ = var_0_0[self.chanceItemCfg_.self_state_event[1]](self.chanceItemCfg_.self_state_event[2], self.chanceItemCfg_.self_state_event[3]) and self.chanceItemCfg_.self_state_event[4] or self.stateInfo_.state
			end
		else
			self.realState_ = self.stateInfo_.state
		end
	elseif self.stateInfo_.ispre == 1 then
		self.realState_ = self.stateInfo_.state
	else
		print("123 , 服务地传来的机遇选项机遇是否屏蔽前置条件字段有误")
	end

	self:RefreshUI()
end

function NewWarChessChanceItem:RefreshUI()
	self.name_.text = self.chanceItemCfg_.name

	if self.realState_ == NewChessConst.CHANCE_ITEM_STATUS.HIDE then
		SetActive(self.gameObject_, false)
	else
		SetActive(self.gameObject_, true)
		self.stateController_:SetSelectedIndex(self.realState_)
	end

	if self.chanceItemCfg_.dice_type ~= 0 then
		SetActive(self.diceiconGo_, true)
	else
		SetActive(self.diceiconGo_, false)
	end
end

function NewWarChessChanceItem:OnChanceItemClick()
	if self.realState_ == NewChessConst.CHANCE_ITEM_STATUS.NORMAL then
		self:ExecuteChanceItemClick()
	elseif self.realState_ == NewChessConst.CHANCE_ITEM_STATUS.LOCK then
		ShowTips(self.chanceItemCfg_.lock_tips)
	end
end

function NewWarChessChanceItem:ExecuteChanceItemClick()
	if self.chanceItemCfg_.dice_type ~= 0 then
		JumpTools.OpenPageByJump("/newWarChessDiceEventView", {
			chanceID = self.chanceID_,
			chanceItemID = self.chanceItemID_
		})

		return
	elseif self.chanceItemCfg_.jump_event[1] == NewChessConst.CHANCE_JUMP_TYPE.BATTLE then
		NewWarChessAction.SelectChanceItem(self.chanceItemID_, {}, function()
			if not BattleNewWarChessStageCfg[self.chanceItemCfg_.jump_event[2]] then
				-- block empty
			end

			if NewWarChessData:CheckIsAllDie() then
				ShowTips("ACTIVITY_NEW_WARCHESS_ALL_HERO_DIE")

				return
			end

			manager.NewChessManager:BattleStart(self.chanceID_, self.chanceItemID_, {}, {})
			gameContext:Go("/sectionSelectHero", {
				section = self.chanceItemCfg_.jump_event[2],
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS,
				activityID = NewWarChessData:GetCurrentActivity()
			})
		end)
	else
		NewWarChessAction.SelectChanceItem(self.chanceItemID_, {}, function()
			if self.executeChanceItemHandle_ then
				self.executeChanceItemHandle_(self.chanceItemID_)
			else
				print("executeChanceItemHandle_丢失！！")
			end
		end)
	end
end

function NewWarChessChanceItem:SetIsShow(arg_21_1)
	SetActive(self.gameObject_, arg_21_1)
end

function NewWarChessChanceItem:Dispose()
	self.executeChanceItemHandle_ = nil

	Object.Destroy(self.gameObject_)
	NewWarChessChanceItem.super.Dispose(self)
end

return NewWarChessChanceItem
