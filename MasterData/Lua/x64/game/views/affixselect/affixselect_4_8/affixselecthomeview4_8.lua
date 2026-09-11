local AffixSelectHomeView4_8 = class("AffixSelectHomeView4_8", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function AffixSelectHomeView4_8:GetUIName()
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_MainUI"
end

function AffixSelectHomeView4_8:Init()
	AffixSelectHomeView4_8.super.Init(self)

	self.itemDataList_ = {}

	if self.btnControllerEx_ then
		self.lockController = self.btnControllerEx_:GetController("statelock01")
	end
end

function AffixSelectHomeView4_8:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/affixSelectEnterView4_8", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_5_0, var_5_1 = self:CheckAdvanceOpenTime()

		manager.tips:ShowTips(var_5_1)
	end)
	self:AddBtnListener(nil, self.descBtn_, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AFFIX_CHOOSE_4_8_GAMEPLAY_DESC")
		})
	end)
end

function AffixSelectHomeView4_8:OnEnter()
	AffixSelectHomeView4_8.super.OnEnter(self)
	ActivityAffixSelectAction.ReadUnPassRedPoint()

	self.titleTet_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name)
	self.descTxt_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc)
end

function AffixSelectHomeView4_8:OnExit()
	AffixSelectHomeView4_8.super.OnExit(self)
end

function AffixSelectHomeView4_8:IndexItem(arg_9_1, arg_9_2)
	if not self.itemDataList_[arg_9_1] then
		self.itemDataList_[arg_9_1] = clone(ItemTemplateData)
		self.itemDataList_[arg_9_1].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	self.itemDataList_[arg_9_1].id = self.itemIDList_[arg_9_1]
	self.itemDataList_[arg_9_1].number = nil

	arg_9_2:SetData(self.itemDataList_[arg_9_1])
end

function AffixSelectHomeView4_8:Dispose()
	AffixSelectHomeView4_8.super.Dispose(self)
end

function AffixSelectHomeView4_8:RefreshAcvanceStatus(arg_12_1)
	if self.lockController then
		self.lockController:SetSelectedState(arg_12_1 and "normal01" or "lock01")
	end
end

function AffixSelectHomeView4_8:RefreshTimeText()
	if self.timeText_ then
		if not self:isHasLeftTimeDes() then
			local var_13_0, var_13_1 = self:CheckAdvanceOpenTime()

			self.timeText_.text = var_13_1

			self:RefreshAcvanceStatus(not var_13_0)
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		end
	end
end

return AffixSelectHomeView4_8
