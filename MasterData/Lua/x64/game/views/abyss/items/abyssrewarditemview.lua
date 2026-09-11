local AbyssRewardItemView = class("AbyssRewardItemView", ReduxView)

function AbyssRewardItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssRewardItemView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, CommonItemView)
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function AbyssRewardItemView:indexItem(arg_4_1, arg_4_2)
	CommonTools.SetCommonData(arg_4_2, {
		id = self.cfg_.reward_list[arg_4_1][1],
		number = self.cfg_.reward_list[arg_4_1][2],
		clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number,
				0,
				self.time_valid
			})
		end
	})
end

function AbyssRewardItemView:AddUIListener()
	self:AddBtnListener(self.receivebtn_, nil, function()
		AbyssAction.GetLayerBonus({
			self.id_
		})
	end)
end

function AbyssRewardItemView:AddEventListeners()
	return
end

function AbyssRewardItemView:SetData(arg_9_1, arg_9_2)
	self.index_ = arg_9_1
	self.id_ = arg_9_2
	self.cfg_ = AbyssData:GetAbyssCfg(arg_9_2)

	self:UpdateView()
end

function AbyssRewardItemView:UpdateView()
	self.itemtext_.text = self.id_ == #AbyssData:GetCurrentIdList() and string.format(GetTips("ABYSS_LAYER_MAX_AWARD_TIP"), self.id_) or string.format(GetTips("ABYSS_LAYER_AWARD_TIP"), self.id_)

	self.uiList_:StartScroll(#self.cfg_.reward_list)

	if AbyssData:IsLayerBonusGet(self.cfg_.level) then
		self.statusController_:SetSelectedState("haveGet")
	elseif AbyssData:GetMaxLayer() >= self.id_ then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("cannotGet")
	end
end

function AbyssRewardItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssRewardItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssRewardItemView:OnMainHomeViewTop()
	return
end

function AbyssRewardItemView:Dispose()
	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AbyssRewardItemView.super.Dispose(self)
end

return AbyssRewardItemView
