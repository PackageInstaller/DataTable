local SequentialBattleBuffInfoCondition = class("SequentialBattleBuffInfoCondition", ReduxView)

function SequentialBattleBuffInfoCondition:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function SequentialBattleBuffInfoCondition:Dispose()
	SequentialBattleBuffInfoCondition.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SequentialBattleBuffInfoCondition:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.descText_.text = GetI18NText(SequentialBattleBuffCfg[arg_3_3].type_desc[arg_3_4])

	if arg_3_2 then
		local var_3_0 = SequentialBattleTools.GetConditionStatus(self:GetHeroList(arg_3_1, (table.keyof(SequentialBattleChapterCfg[arg_3_1].stage_id, arg_3_2))), SequentialBattleBuffCfg[arg_3_3].type)

		self.cntText_.text = var_3_0[arg_3_4] >= SequentialBattleBuffCfg[arg_3_3].type[arg_3_4][3] and string.format("<color=#6AA788>%s/%s</color>", var_3_0[arg_3_4], SequentialBattleBuffCfg[arg_3_3].type[arg_3_4][3]) or string.format("<color=#F96763>%s/%s</color>", var_3_0[arg_3_4], SequentialBattleBuffCfg[arg_3_3].type[arg_3_4][3])
	else
		self.cntText_.text = ""
	end

	self:Show(true)
end

function SequentialBattleBuffInfoCondition:GetHeroList(arg_4_1, arg_4_2)
	return (ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE, arg_4_1, arg_4_2, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[arg_4_1].stage_id[arg_4_2],
		activityID = arg_4_1
	}))))
end

function SequentialBattleBuffInfoCondition:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return SequentialBattleBuffInfoCondition
