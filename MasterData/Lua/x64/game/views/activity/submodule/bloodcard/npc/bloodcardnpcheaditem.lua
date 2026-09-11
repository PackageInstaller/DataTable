local BloodCardNpcHeadItem = class("BloodCardNpcHeadItem", ReduxView)

function BloodCardNpcHeadItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
	self:InitUI()
end

function BloodCardNpcHeadItem:InitUI()
	self.stateController_ = self.controller_:GetController("HeadNPC")
end

function BloodCardNpcHeadItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallBack_ then
			self.clickCallBack_(self.npcID_)
		end
	end)
end

function BloodCardNpcHeadItem:CancelRedPoint()
	if BloodCardData:GetUnPassNpc() == self.npcID_ then
		saveData("bloodCard", "hasClickStage", 1)
		manager.redPoint:SetRedPointIndependent(self.btn_.transform, false)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID()), 0)
	end
end

function BloodCardNpcHeadItem:SetData(arg_6_1)
	self.npcID_ = arg_6_1
	self.cfg_ = BloodCardGameNPCCfg[self.npcID_]
	self.activityID_ = BloodCardGameStageCfg[self.cfg_.stage_list[1]].activity_id

	self:RefreshUI()
end

function BloodCardNpcHeadItem:RefreshUI(arg_7_1)
	self.nameText_.text = self.cfg_.name
	self.numText_.text = #self.cfg_.stage_list
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackHouseUI/RoleHead/" .. self.cfg_.icon)

	if BloodCardData:GetUnPassNpc() == self.npcID_ and (getData("bloodCard", "hasClickStage") or 0) ~= 1 then
		manager.redPoint:SetRedPointIndependent(self.btn_.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(self.btn_.transform, false)
	end
end

function BloodCardNpcHeadItem:SetClickCallBack(arg_8_1)
	self.clickCallBack_ = arg_8_1
end

function BloodCardNpcHeadItem:RefreshState(arg_9_1)
	local var_9_0 = BloodCardData:GetNpcUnlock(self.npcID_, self.activityID_)
	local var_9_1 = self.npcID_ == arg_9_1

	if not var_9_0 then
		self.stateController_:SetSelectedState("lock")
	elseif var_9_1 then
		self.stateController_:SetSelectedState("select")
	else
		self.stateController_:SetSelectedState("normal")
	end

	if not var_9_0 and self.npcID_ == 105 then
		self.stateController_:SetSelectedState("gengchen")

		self.nameText_.text = GetTips("ACTIVITY_BLOOD_CARD_SCRETE_NPC")
	end
end

function BloodCardNpcHeadItem:Dispose()
	self.clickCallBack_ = nil

	BloodCardNpcHeadItem.super.Dispose(self)
end

return BloodCardNpcHeadItem
