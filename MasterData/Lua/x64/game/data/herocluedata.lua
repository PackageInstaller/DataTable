local var_0_0 = singletonClass("HeroClueData")

function var_0_0.Init(arg_1_0)
	arg_1_0.inited_ = {}
	arg_1_0.unlockClueDataDic_ = {}
	arg_1_0.newClueDic_ = {}
	arg_1_0.selectedClue_ = {}
end

function var_0_0:IsInited(arg_2_1)
	return self.inited_[arg_2_1] == true
end

function var_0_0:InitData(arg_3_1)
	self.inited_[arg_3_1.activity_id] = true
	self.unlockClueDataDic_ = {}
	self.newClueDic_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.clue_list) do
		self.unlockClueDataDic_[iter_3_1.id] = {}
		self.unlockClueDataDic_[iter_3_1.id].id = iter_3_1.id
		self.unlockClueDataDic_[iter_3_1.id].num = iter_3_1.num

		self:UpdateClueLevel(iter_3_1.id)
	end

	self.selectedClue_[arg_3_1.activity_id] = {}
end

function var_0_0:GetUnlockClueDataDic()
	return self.unlockClueDataDic_ or {}
end

function var_0_0:SetUnlockClue(arg_5_1, arg_5_2)
	if not self.unlockClueDataDic_[arg_5_1] then
		self.unlockClueDataDic_[arg_5_1] = {
			id = arg_5_1,
			num = arg_5_2
		}
		self.newClueDic_[arg_5_1] = true
	else
		self.unlockClueDataDic_[arg_5_1].num = self.unlockClueDataDic_[arg_5_1].num + arg_5_2
	end

	self:UpdateClueLevel(arg_5_1)
end

function var_0_0:UpdateClueLevel(arg_6_1)
	local var_6_0 = 0

	for iter_6_0 = #HeroClueCfg[arg_6_1].level, 1, -1 do
		if self.unlockClueDataDic_[arg_6_1].num >= HeroClueCfg[arg_6_1].level[iter_6_0] then
			var_6_0 = iter_6_0

			break
		end
	end

	self.unlockClueDataDic_[arg_6_1].level = var_6_0
end

function var_0_0:GetNewClueDic()
	return self.newClueDic_
end

function var_0_0:SetNewClueDic(arg_8_1, arg_8_2)
	self.newClueDic_[arg_8_1] = arg_8_2
end

function var_0_0:GetSelectedClue(arg_9_1, arg_9_2)
	return self.selectedClue_[arg_9_1][arg_9_2]
end

function var_0_0:SetSelectedClue(arg_10_1, arg_10_2)
	if manager.redPoint:getTipBoolean((string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, arg_10_1, arg_10_2))) == false then
		return
	end

	self.selectedClue_[arg_10_1][arg_10_2] = true

	self:SetNewClueDic(arg_10_2, false)
	HeroClueAction.UpdateNewClueRedPoint(arg_10_1)
end

return var_0_0
