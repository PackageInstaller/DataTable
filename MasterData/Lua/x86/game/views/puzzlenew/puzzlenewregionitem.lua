local PuzzleNewRegionItem = class("PuzzleNewRegionItem", ReduxView)

function PuzzleNewRegionItem:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.regionCfg_ = arg_1_2
	self.regionID_ = arg_1_2[1]
	self.puzzleDic_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2[2]) do
		self.puzzleDic_[iter_1_1] = arg_1_3[iter_1_1]
	end

	self.rewardCfg_ = arg_1_4
	self.statusConst_ = {
		UNFINISH = 0,
		RECEIVED = 1
	}

	SetActive(self.gameObject_, true)
	self:Init()
end

function PuzzleNewRegionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewRegionItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function PuzzleNewRegionItem:AddUIListener()
	return
end

function PuzzleNewRegionItem:Dispose()
	self.receiveCallback_ = nil
	self.gameObject_ = nil
	self.transform_ = nil

	self.commonItem_:Dispose()

	self.commonItem_ = nil

	PuzzleNewRegionItem.super.Dispose(self)
end

function PuzzleNewRegionItem:SetData(arg_6_1)
	self.activityID_ = arg_6_1

	self:RefreshUI()
end

function PuzzleNewRegionItem:RefreshUI()
	self:RefreshReward()
	self:RefreshStatus()
end

function PuzzleNewRegionItem:RefreshReward()
	if self.commonItem_ == nil then
		self.commonItem_ = CommonItemView.New(self.rewardItemGo_, true)
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemData_.id = self.rewardCfg_[1][1]
	self.itemData_.number = self.rewardCfg_[1][2]

	self.commonItem_:SetData(self.itemData_)
end

function PuzzleNewRegionItem:RefreshStatus()
	if PuzzleNewData:GetRegionReceivedList(self.activityID_)[self.regionID_] == true then
		self.status_ = self.statusConst_.RECEIVED
	else
		self.status_ = self.statusConst_.UNFINISH

		local var_10_0 = PuzzleNewData:GetCurPuzzleList(self.activityID_)
		local var_10_1 = 0

		for iter_10_0, iter_10_1 in pairs(self.puzzleDic_) do
			if var_10_0[iter_10_1] and var_10_0[iter_10_1] == iter_10_0 then
				var_10_1 = var_10_1 + 1
			end
		end

		self.curText_.text = var_10_1
		self.needText_.text = string.format("/%d", #self.regionCfg_[2])
	end

	self.statusController_:SetSelectedIndex(self.status_)
end

function PuzzleNewRegionItem:RegisterReceiveCallback(arg_11_1)
	self.receiveCallback_ = arg_11_1
end

return PuzzleNewRegionItem
