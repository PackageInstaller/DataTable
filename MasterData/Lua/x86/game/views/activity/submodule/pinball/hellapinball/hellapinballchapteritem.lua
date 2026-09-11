local HellaPinballChapterItem = class("HellaPinballChapterItem", BaseView)

function HellaPinballChapterItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaPinballChapterItem:Init()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.bossController_ = self.controllerEx_:GetController("boss")
	self.lockController_ = self.controllerEx_:GetController("lock")

	self:AddUIListener()
end

function HellaPinballChapterItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ and PinballData:GetStageUnlocked(self.id_) then
			self.clickCallBack_(self.index_)
		end
	end)
end

function HellaPinballChapterItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2

	if PinballStageCfg[arg_5_2] then
		self.text_.text = PinballStageCfg[arg_5_2].name
		self.isBossStage_, self.bossType_ = PinballData:IsBossStage(self.id_)

		if not self.isBossStage_ then
			self.bossController_:SetSelectedState("normal")
		elseif self.bossType_ == 4 then
			self.bossController_:SetSelectedState("boss2")
		else
			self.bossController_:SetSelectedState("boss")
		end
	end

	self.lockController_:SetSelectedState(not PinballData:GetStageUnlocked(self.id_) and "on" or "off")
end

function HellaPinballChapterItem:SetSelect(arg_6_1)
	self.selectController_:SetSelectedState(arg_6_1 and "on" or "off")
end

function HellaPinballChapterItem:SetClickCallBack(arg_7_1)
	self.clickCallBack_ = arg_7_1
end

return HellaPinballChapterItem
