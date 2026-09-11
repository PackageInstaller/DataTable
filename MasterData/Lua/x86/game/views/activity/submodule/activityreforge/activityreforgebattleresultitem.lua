local ActivityReforgeBattleResultItem = class("ActivityReforgeBattleResultItem", ReduxView)

function ActivityReforgeBattleResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityReforgeBattleResultItem:Init()
	self:InitUI()

	self.barGoList_ = {}
end

function ActivityReforgeBattleResultItem:InitUI()
	self:BindCfgUI()
end

function ActivityReforgeBattleResultItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	self.type_ = arg_4_1
	self.barMinNum_ = arg_4_2
	self.levelID_ = arg_4_3
	self.curData_ = arg_4_4
	self.allPlayerData_ = deepClone(arg_4_5)
	self.rangeLength_ = arg_4_6
	self.barNum_ = self.barMinNum_
	self.maxPalyerNum_ = 0

	for iter_4_0, iter_4_1 in ipairs(self.allPlayerData_) do
		if iter_4_1 > self.maxPalyerNum_ then
			self.maxPalyerNum_ = iter_4_1
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.allPlayerData_) do
		if 100 * (iter_4_3 / self.maxPalyerNum_) <= 1 then
			self.allPlayerData_[iter_4_2] = 0
		end
	end

	for iter_4_4 = #self.allPlayerData_, 1, -1 do
		if iter_4_4 > self.barMinNum_ then
			if self.allPlayerData_[iter_4_4] > 0 then
				self.barNum_ = iter_4_4

				break
			end
		else
			break
		end
	end

	self:RefreshUI()
end

function ActivityReforgeBattleResultItem:RefreshUI()
	if self.type_ == 1 then
		local var_5_0 = manager.time:DescCTime(self.curData_, "%M%S")
		local var_5_1 = var_5_0 % 100
		local var_5_2 = math.floor(var_5_0 / 100) % 100

		if var_5_0 % 100 < 10 then
			var_5_1 = "0" .. var_5_1
		end

		if var_5_2 < 10 then
			var_5_2 = "0" .. var_5_2
		end

		self.numText_.text = var_5_2 .. ":" .. var_5_1
	else
		self.numText_.text = self.curData_
	end

	local var_5_3 = self.barPanelTrans_.rect.width / self.barNum_

	for iter_5_0 = 1, self.barNum_ do
		if self.barGoList_[iter_5_0] == nil then
			self.barGoList_[iter_5_0] = Object.Instantiate(self.barGo_, self.barPanelTrans_)
		end

		self.barGoList_[iter_5_0].transform.sizeDelta = Vector2.New(var_5_3, self.allPlayerData_[iter_5_0] / self.maxPalyerNum_ * self.barPanelTrans_.rect.height)
		self.barGoList_[iter_5_0].transform.anchoredPosition = Vector3.New((iter_5_0 - 1) * self.barGoList_[iter_5_0].transform.rect.width, self.barGoList_[iter_5_0].transform.anchoredPosition.y, 0)
	end

	for iter_5_1, iter_5_2 in pairs(self.barGoList_) do
		if iter_5_1 <= self.barNum_ then
			SetActive(self.barGoList_[iter_5_1], true)
		else
			SetActive(self.barGoList_[iter_5_1], false)
		end
	end

	self.lineTrans_.transform.anchoredPosition = Vector3.New(((self.curData_ / (self.barNum_ * self.rangeLength_) > 1 or nil) and 1) * self.barPanelTrans_.rect.width, 0, 0)

	local var_5_6 = ActivityReforgeData:GetBestFinishLevelServerData(self.levelID_)
	local var_5_7 = 0

	if self.type_ == 1 then
		var_5_7 = ((var_5_6.minUseSeconds / (self.barNum_ * self.rangeLength_) > 1 or nil) and 1) * self.barPanelTrans_.rect.width
	elseif self.type_ == 2 then
		var_5_7 = ((var_5_6.minLosePoint / (self.barNum_ * self.rangeLength_) > 1 or nil) and 1) * self.barPanelTrans_.rect.width
	elseif self.type_ == 3 then
		var_5_7 = ((var_5_6.minUseGold / (self.barNum_ * self.rangeLength_) > 1 or nil) and 1) * self.barPanelTrans_.rect.width
	end

	self.bestLineTrans_.transform.anchoredPosition = Vector3.New(var_5_7, 0, 0)
end

function ActivityReforgeBattleResultItem:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.barGoList_) do
		Object.Destroy(iter_6_1)

		self.barGoList_[iter_6_0] = nil
	end

	self.barGoList_ = nil

	ActivityReforgeBattleResultItem.super.Dispose(self)
end

return ActivityReforgeBattleResultItem
