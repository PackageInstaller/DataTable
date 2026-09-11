local SlayerMainView_3_6 = class("SlayerMainView_3_6", (import("game.views.activity.Submodule.slayer.slayer_2_4.SlayerMainView_2_4")))

function SlayerMainView_3_6:Init()
	SlayerMainView_3_6.super.Init(self)

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.rewardListGo_, CommonItemView)
	self.itemDataList_ = {}
end

function SlayerMainView_3_6:OnEnter()
	SlayerMainView_3_6.super.OnEnter(self)
	self:RefreshReward()
end

function SlayerMainView_3_6:RefreshReward()
	self.itemIDList_ = {}

	local var_3_0 = {}

	if ActivityCfg[self.activityID_] then
		self.regionList = ActivityCfg[self.activityID_].sub_activity_list or {}
	end

	for iter_3_0 = #self.regionList, 1, -1 do
		for iter_3_1, iter_3_2 in ipairs(ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[self.regionList[iter_3_0]] or {}) do
			for iter_3_3, iter_3_4 in ipairs(ActivitySlayerPointRewardCfg[iter_3_2].reward_item_list) do
				if not var_3_0[iter_3_4[1]] and ItemCfg[iter_3_4[1]].rare >= 5 then
					self.itemIDList_[#self.itemIDList_ + 1] = iter_3_4[1]
					var_3_0[iter_3_4[1]] = true
				end
			end
		end
	end

	self.rewardList_:StartScroll(#self.itemIDList_)
end

function SlayerMainView_3_6:IndexItem(arg_4_1, arg_4_2)
	if not self.itemDataList_[arg_4_1] then
		self.itemDataList_[arg_4_1] = clone(ItemTemplateData)
		self.itemDataList_[arg_4_1].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	self.itemDataList_[arg_4_1].id = self.itemIDList_[arg_4_1]
	self.itemDataList_[arg_4_1].number = nil

	arg_4_2:SetData(self.itemDataList_[arg_4_1])
end

function SlayerMainView_3_6:Dispose()
	SlayerMainView_3_6.super.Dispose(self)
	self.rewardList_:Dispose()
end

return SlayerMainView_3_6
