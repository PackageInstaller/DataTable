local NewChessTipsItem = class("NewChessTipsItem")

function NewChessTipsItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewChessTipsItem:Init()
	self:InitUI()
end

function NewChessTipsItem:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.typeController_ = ControllerUtil.GetController(self.transform_, "status")
	self.switchDiceController_ = ControllerUtil.GetController(self.switchDiceTrans_, "point")
	self.diceController_ = ControllerUtil.GetController(self.getDiceTrans_, "point")
	self.buffItem_ = NewWarChessTipsBuffItem.New(self.buffGo_)
end

function NewChessTipsItem:SetData(arg_4_1)
	self.typeController_:SetSelectedIndex(arg_4_1.tipsType)

	self.text_.text = arg_4_1.tipsText

	if arg_4_1.tipsType == NewChessConst.TIPS_TYPE.SWITCH then
		self.switchDiceController_:SetSelectedIndex(arg_4_1.tipsDiceNum)
	elseif arg_4_1.tipsType == NewChessConst.TIPS_TYPE.DICE then
		self.diceController_:SetSelectedIndex(arg_4_1.tipsDiceNum)
		manager.audio:PlayEffect("minigame_activity_2_6_grid", "minigame_activity_2_6_grid_getdice", "")
	elseif arg_4_1.tipsType == NewChessConst.TIPS_TYPE.BUFF then
		self.buffItem_:SetData(1, 0, arg_4_1.tipsBuffEntity)
	end
end

function NewChessTipsItem:SetDisposeHandler(arg_5_1)
	self.disposeHandler_ = arg_5_1
end

function NewChessTipsItem:SetIsShow(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	self.isShow_ = arg_6_1

	if arg_6_1 then
		self.transform_:SetAsLastSibling()
		self:StartTimer()
	end
end

function NewChessTipsItem:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:StopTimer()
			self:SetIsShow(false)
			self.disposeHandler_(self.tipsinfo_)
		end, 3, 1)
	end

	self.timer_:Start()
end

function NewChessTipsItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function NewChessTipsItem:GetIsShow()
	return self.isShow_
end

function NewChessTipsItem:Dispose()
	self:StopTimer()

	self.disposeHandler_ = nil

	Object.Destroy(self.gameObject_)
	self.buffItem_:Dispose()
end

return NewChessTipsItem
