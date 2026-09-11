local BlisterPointItem = class("BlisterPointItem", ReduxView)

function BlisterPointItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BlisterPointItem:Init()
	self:InitUI()

	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.starControl = self.bubblebtn01Controllerexcollection_:GetController("stars")
	self.selectControl = self.bubblebtn01Controllerexcollection_:GetController("select")
	self.lockControl = self.bubblebtn01Controllerexcollection_:GetController("lock")
	self.dustingControl = self.bubblebtn01Controllerexcollection_:GetController("isDusting")
	self.stateControl = self.bubblebtn01Controllerexcollection_:GetController("showState")
end

function BlisterPointItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.bubblebtn01Btn_, nil, function()
		self:OnClick()
	end)
end

function BlisterPointItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.ctrl = arg_5_3
	self.index = arg_5_2
	self.data = arg_5_1

	self:RefreshUI(arg_5_1, arg_5_2)
end

function BlisterPointItem:RefreshUI(arg_6_1, arg_6_2)
	self.txtsignText_.text = ActivityBubbleCfg[arg_6_1.id].name

	self.lockControl:SetSelectedState(BlisterGameData:GetStageIdIsOpen(arg_6_1.id) and "false" or "true")
	self.starControl:SetSelectedState("state" .. arg_6_1.star)
	self.dustingControl:SetSelectedState(arg_6_1.isPass and "false" or "true")
	manager.redPoint:unbindUIandKey(self.con_panelTrs_.transform)
	manager.redPoint:bindUIandKey(self.con_panelTrs_.transform, string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, self.data.id))
	self.stateControl:SetSelectedState("state" .. ((arg_6_2 <= 6 or nil) and (arg_6_2 - 1 or arg_6_2 % 6)))
	self.appearAnim_:Play("Fx_bubblebtn01_cx", 0, 0)
end

function BlisterPointItem:RefreshItem()
	return
end

function BlisterPointItem:OnClick()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, self.data.id), 0)

	if ActivityBubbleCfg[self.data.id] then
		self.ctrl:SetSelect(self.index)

		self.ctrl.scrollviewSr_.enabled = false

		BlisterGameTool.GoToChapterSectionInfoView(self.data.id)
	else
		ShowTips(GetTips("TIME_OVER"))
	end
end

function BlisterPointItem:SetSelect(arg_9_1)
	if arg_9_1 then
		self.selectControl:SetSelectedState("state1")
	else
		self.selectControl:SetSelectedState("state0")
	end
end

function BlisterPointItem:OnExit()
	BlisterPointItem.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.con_panelTrs_.transform)
end

function BlisterPointItem:Dispose()
	BlisterPointItem.super.Dispose(self)
end

return BlisterPointItem
