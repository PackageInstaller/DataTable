local SwitchHeroRewardView = class("SwitchHeroRewardView", RewardView)

function SwitchHeroRewardView:OnCtor()
	SwitchHeroRewardView.super.OnCtor(self)

	self.timerList = {}
end

function SwitchHeroRewardView:InitUI()
	SwitchHeroRewardView.super.InitUI(self)

	self.effctItem_ = Asset.Load("Widget/Common/Com_Prefab/ZhuanHuaAni")
end

function SwitchHeroRewardView:indexItem(arg_4_1, arg_4_2)
	arg_4_2.idx = arg_4_1

	SwitchHeroRewardView.super.indexItem(self, arg_4_1, arg_4_2)
end

function SwitchHeroRewardView:IsConvertAnimePlayed(arg_5_1)
	return self.timerList[arg_5_1] ~= nil
end

function SwitchHeroRewardView:PlayConvertAnime(arg_6_1, arg_6_2)
	if self:IsConvertAnimePlayed(arg_6_1) then
		return false
	end

	local var_6_0 = arg_6_2:FindTrs("ZhuanHuaAni")

	if var_6_0 then
		SetActive(var_6_0.gameObject, false)
	end

	if not var_6_0 then
		local var_6_1 = Object.Instantiate(self.effctItem_, arg_6_2.transform_)

		var_6_0 = var_6_1.transform
		var_6_1.name = "ZhuanHuaAni"

		SetActive(var_6_1, false)
	end

	SetActive(var_6_0.gameObject, true)

	var_6_0.localPosition = Vector3.New(127, -124, 0)

	var_6_0:GetComponent("Animator"):Play("CommonItem_zhuanhua", 0, 0)
	manager.audio:PlayEffect("ui_system_search", "search_itemTransform", "")

	return true
end

function SwitchHeroRewardView:AddTimer(arg_7_1, arg_7_2)
	self.timerList[arg_7_1] = arg_7_2
end

function SwitchHeroRewardView:OnEnter()
	self:RefreshUI(self.params_.list)

	self.callBack_ = self.params_.callBack

	if not self.params_.isBack then
		manager.audio:PlayEffect("ui_system_3_0", "ui_item_get", "")
	end
end

function SwitchHeroRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.params_.lateCallback then
			self:StopTime()
			self:Back(self.callBack_)
		else
			self:Back(self.params_.callBack)
		end
	end)
end

function SwitchHeroRewardView:StopTime()
	for iter_11_0, iter_11_1 in pairs(self.timerList) do
		iter_11_1:Stop()
	end
end

function SwitchHeroRewardView:OnExit()
	self.params_.callBack = nil

	for iter_12_0, iter_12_1 in pairs(self.timerList) do
		if iter_12_1 then
			iter_12_1:Stop()

			iter_12_1 = nil
		end
	end

	self.timerList = {}

	SwitchHeroRewardView.super.OnExit(self)
end

return SwitchHeroRewardView
