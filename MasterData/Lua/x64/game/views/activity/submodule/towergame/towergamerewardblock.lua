local TowerGameRewardBlock = class("TowerGameRewardBlock", ReduxView)

function TowerGameRewardBlock:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TowerGameRewardBlock:Init()
	self:InitUI()
end

function TowerGameRewardBlock:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.RefreshItem), self.listgo_, TowerGameRewardItem)
end

function TowerGameRewardBlock:RefreshItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshItem(arg_4_1, self.levelid_)
end

function TowerGameRewardBlock:Refresh(arg_5_1)
	self.levelid_ = arg_5_1
	self.title_.text = GetI18NText(BattleTowerGameCfg[TowerGameCfg[self.levelid_].stage_id].name)

	self.list_:StartScroll(#ActivityPointRewardCfg.get_id_list_by_activity_id[self.levelid_])
end

function TowerGameRewardBlock:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

return TowerGameRewardBlock
