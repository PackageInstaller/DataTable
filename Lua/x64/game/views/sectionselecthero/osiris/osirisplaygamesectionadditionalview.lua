local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("OsirisPlayGameSectionAdditionalView", var_0_0)

function var_0_1.InitSubViewCfg(arg_1_0)
	arg_1_0.subViewDic_ = {
		comboSkillView = {
			go = arg_1_0.comboSkillGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = arg_1_0.mimirInfoGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetMimirInfoViewClass)
		},
		stageInfoView = {
			go = arg_1_0.stageInfoGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetStageInfoClass)
		},
		similarityInfoView = {
			go = arg_1_0.similarityGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetSimilarityClass)
		},
		heroVoiceInfoView = {
			go = arg_1_0.heroVoiceInfoGo_,
			getClassFunc = handler(arg_1_0, arg_1_0.GetHeroVoiceInfoViewClass)
		}
	}
end

function var_0_1.GetSimilarityClass(arg_2_0)
	return arg_2_0.sectionProxy_:GetSimilarityClass()
end

return var_0_1
