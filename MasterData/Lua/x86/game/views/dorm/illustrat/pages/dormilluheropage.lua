local DormIlluHeroPage = class("DormIlluHeroPage", ReduxView)

function DormIlluHeroPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitData()
	self:InitUI()
end

function DormIlluHeroPage:InitData()
	self.allIDList_ = self:GetAllID()
end

function DormIlluHeroPage:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, DormIlluHeroItem)
end

function DormIlluHeroPage:AddUIListener()
	return
end

function DormIlluHeroPage:Show(arg_5_1)
	self:RegistEventListener(COMMON_FILTER_OK, handler(self, self.Refresh))
	self:RefreshData()
	self:RefreshUI(arg_5_1)
end

function DormIlluHeroPage:Hide()
	self:RemoveAllEventListener()
end

function DormIlluHeroPage:OnClickFliter()
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Hero_Filter_List
	})
end

function DormIlluHeroPage:Refresh()
	self:RefreshData()
	self:RefreshUI()
end

function DormIlluHeroPage:RefreshData(arg_9_1)
	self.allIDList_ = HeroTools.GetHeroShowIDList(self:GetAllID(), arg_9_1)
end

function DormIlluHeroPage:RefreshUI(arg_10_1)
	self.uiList_:StartScroll(#self.allIDList_)

	if self.recordIndex_ and arg_10_1 then
		self.uiList_:ScrollToIndex(self.recordIndex_)
	end

	self.uiList_:Refresh()
end

function DormIlluHeroPage:Dispose()
	self.recordIndex_ = nil

	self.uiList_:Dispose()
	DormIlluHeroPage.super.Dispose(self)
end

function DormIlluHeroPage:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_1, self.allIDList_[arg_12_1])
	arg_12_2:RegistCallBack(function(arg_13_0, arg_13_1)
		self:OpenDetailView(arg_13_0, arg_13_1)
	end)
end

function DormIlluHeroPage:OpenDetailView(arg_14_1, arg_14_2)
	self.recordIndex_ = arg_14_2

	JumpTools.OpenPageByJump("/dormIlluHeroDetail", {
		heroID = arg_14_1,
		heroIDList = self.allIDList_
	})
end

function DormIlluHeroPage:GetAllID()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if BackHomeHeroCfg[iter_15_1] and not HeroTools.GetIsHide(iter_15_1) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	CommonTools.UniversalSortEx(var_15_1, {
		map = function(arg_16_0)
			if HeroTools.GetHeroIsUnlock(arg_16_0) then
				return 1
			end

			return 0
		end
	}, {
		map = function(arg_17_0)
			return DormData:GetHeroArchiveID(arg_17_0)
		end
	}, {
		ascend = true,
		map = function(arg_18_0)
			return table.indexof(HeroRecordCfg[DormData:GetHeroArchiveID(arg_18_0)].hero_id, arg_18_0) or 0
		end
	})

	return var_15_1
end

return DormIlluHeroPage
