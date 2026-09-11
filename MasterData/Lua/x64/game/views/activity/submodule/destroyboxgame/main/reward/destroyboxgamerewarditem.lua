ActivityRewardItemBase = import("game.views.activity.Submodule.destroyBoxGame.rewardBase.ActivityRewardItemBase")

local DestroyBoxGameRewardItem = class("DestroyBoxGameRewardItem", ActivityRewardItemBase)

function DestroyBoxGameRewardItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CommonItemView)
	self.buttonController = ControllerUtil.GetController(self.transform_, "status")
end

function DestroyBoxGameRewardItem:SetData(arg_2_1, arg_2_2)
	self.index_ = arg_2_2

	self:Show(true)

	self.rewardID_ = arg_2_1

	local var_2_0 = DestroyBoxGameRewardCfg[arg_2_1]

	self.descText_.text = string.format(DestroyBoxGameRewardCfg[arg_2_1].desc, DestroyBoxGameRewardCfg[arg_2_1].complete_num)

	if var_2_0 then
		self.rewardList_ = var_2_0.item_list or {}
	end

	self.list_:StartScroll(#self.rewardList_)

	if table.keyof(DestroyBoxGameData:GetReceiveRewardList(var_2_0.main_activity_id), arg_2_1) then
		self.buttonController:SetSelectedState("haveGet")
	elseif DestroyBoxGameTools.IsUnlockReward(arg_2_1) then
		self.buttonController:SetSelectedState("canGet")
	else
		self.buttonController:SetSelectedState("unFinish")
	end
end

function DestroyBoxGameRewardItem:Dispose()
	self.list_:Dispose()

	self.list_ = nil

	DestroyBoxGameRewardItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function DestroyBoxGameRewardItem:AddListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		DestroyBoxGameAction.RequestReward(DestroyBoxGameRewardCfg[self.rewardID_].main_activity_id, {
			self.rewardID_
		}, function()
			manager.notify:Invoke(ACTIVITY_REWARD_REFRESH)
		end)
	end)
end

function DestroyBoxGameRewardItem:IndexItem(arg_7_1, arg_7_2)
	local var_7_0 = self.rewardList_[arg_7_1]
	local var_7_1 = clone(ItemTemplateData)

	var_7_1.id = self.rewardList_[arg_7_1][1]
	var_7_1.number = self.rewardList_[arg_7_1][2]

	function var_7_1.clickFun(arg_8_0)
		ShowPopItem(POP_ITEM, var_7_0)
	end

	arg_7_2:SetData(var_7_1)
end

function DestroyBoxGameRewardItem:Update()
	self:SetData(self.rewardID_, self.index_)
end

return DestroyBoxGameRewardItem
