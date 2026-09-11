local OsirisPlayGameSectionAdditionalView = class("OsirisPlayGameSectionAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function OsirisPlayGameSectionAdditionalView:InitSubViewCfg()
	self.subViewDic_ = {
		comboSkillView = {
			go = self.comboSkillGo_,
			getClassFunc = handler(self, self.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = self.mimirInfoGo_,
			getClassFunc = handler(self, self.GetMimirInfoViewClass)
		},
		stageInfoView = {
			go = self.stageInfoGo_,
			getClassFunc = handler(self, self.GetStageInfoClass)
		},
		similarityInfoView = {
			go = self.similarityGo_,
			getClassFunc = handler(self, self.GetSimilarityClass)
		},
		heroVoiceInfoView = {
			go = self.heroVoiceInfoGo_,
			getClassFunc = handler(self, self.GetHeroVoiceInfoViewClass)
		}
	}
end

function OsirisPlayGameSectionAdditionalView:GetSimilarityClass()
	return self.sectionProxy_:GetSimilarityClass()
end

return OsirisPlayGameSectionAdditionalView
