local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINWeeklyChallengeScoreIntro = class("UINBuildLogicLvPreview", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINWeeklyChallengeScoreIntroRowItem = require("Game.WeeklyChallenge.UINWeeklyChallengeScoreIntroRowItem")

function UINWeeklyChallengeScoreIntro:OnInit()
  base.OnInit(self)
  base.InitWithClass(self, nil, UINWeeklyChallengeScoreIntroRowItem)
end

function UINWeeklyChallengeScoreIntro:InitWeeklyScoreIntro(challengeId)
  UIUtil.SetTopStatus(self, self._Close)
  local weeklyCfg = ConfigData.weekly_challenge[challengeId]
  self.ui.tex_SkillName:SetIndex(0, LanguageUtil.GetLocaleText(weeklyCfg.name))
  self.ui.obj_Current.gameObject:SetActive(false)
  self.headAttrPool:HideAll()
  local item = self.headAttrPool:GetOne(true)
  item:InitAttrItem(ConfigData:GetTipContent(6002))
  for i, type_id in ipairs(weeklyCfg.base_reward) do
    if type_id == 1 then
      item = self.headAttrPool:GetOne(true)
      item:InitAttrItem(ConfigData:GetTipContent(6003))
    elseif type_id == 2 then
      item = self.headAttrPool:GetOne(true)
      item:InitAttrItem(ConfigData:GetTipContent(6004))
    end
  end
  local scoreRewardCfg = ConfigData.weekly_challenge_base_reward
  local list = {}
  for k, v in pairs(scoreRewardCfg) do
    table.insert(list, v)
  end
  table.sort(list, function(a, b)
    return a.score < b.score
  end)
  self.rowItemPool:HideAll()
  for i, v in ipairs(list) do
    local scoreMin = v.score
    local scoreMax
    if i + 1 <= #list then
      scoreMax = list[i + 1].score - 1
    end
    item = self.rowItemPool:GetOne(true)
    item:InitWithClass()
    item:InitWeeklyRewardRow(scoreMin, scoreMax, v.data, weeklyCfg.base_reward)
  end
end

return UINWeeklyChallengeScoreIntro
