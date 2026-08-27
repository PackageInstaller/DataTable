local base = require("Game.CommonUI.Rank.UINCommonRankPanelItem")
local UINCardSetRankPanelItem = class("UINCardSetRankPanelItem", base)
local CardSetUtil = require("Game.CardSet.CardSetUtil")

function UINCardSetRankPanelItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Details, self, self._OnClickBattletDetail)
end

function UINCardSetRankPanelItem:InitCardSetRankItem(battleDetailFunc)
  self.ui.tex_Diff.gameObject:SetActive(true)
  self.ui.btn_Details.transform.parent.gameObject:SetActive(true)
  self._battleDetailFunc = battleDetailFunc
end

function UINCardSetRankPanelItem:RefeshCommonRankItem(rankCfg, rankElemData, resloader, hasTime, showHeroNum)
  self.__rankElemData = rankElemData
  local rankAvatar = rankElemData.entry.avatar
  self.ui.tex_RankNumber.text = tostring(rankElemData.rankIdx)
  self.ui.tex_PlayerName.text = tostring(rankAvatar.name)
  local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
  self._titleBgAtlas = resloader:LoadABAsset(atlasPath)
  if rankAvatar.title and rankAvatar.title.titlePrefix ~= 0 then
    self.ui.obj_title:SetActive(true)
    self.userTitle:InitNormalTitleItem(rankAvatar.title.titlePrefix, rankAvatar.title.titlePostfix, rankAvatar.title.titleBackGround, resloader, self._titleBgAtlas)
  else
    self.ui.obj_title:SetActive(false)
  end
  self.userHead:InitUserHeadUI(rankAvatar.avatarId, rankAvatar.avatarFrame, resloader)
  local rankForm = rankElemData.entry.form
  self.rankMultiForm = rankElemData.entry.multiForm
  if not rankForm or #rankForm.heroes == 0 then
    rankForm = self.rankMultiForm[1]
    self.ui.btn_Check.gameObject:SetActive(true)
  else
    self.ui.btn_Check.gameObject:SetActive(false)
  end
  self.ui.tex_heroCount.gameObject:SetActive(false)
  self.ui.obj_heroList:SetActive(false)
  local extraData = rankElemData.entry.extraData
  if extraData and extraData.card then
    local diff, frame
    local totalScore = 0
    local heightScore = 0
    for index, actCardMsg in pairs(extraData.card) do
      local score = actCardMsg.score
      totalScore = totalScore + score
      if heightScore < score then
        diff = actCardMsg.difficulty
        frame = actCardMsg.frame
        heightScore = score
      end
    end
    self.ui.tex_Diff.text = CardSetUtil.GetCardSetDiffName(rankCfg.id, diff)
    self.ui.tex_Score.text = tostring(totalScore)
    self.ui.tex_Time.gameObject:SetActive(hasTime)
    self.ui.tex_Time.text = BattleUtil.FrameToTimeString(frame, true)
  end
end

function UINCardSetRankPanelItem:_OnClickBattletDetail()
  if self._battleDetailFunc ~= nil then
    self._battleDetailFunc(self.__rankElemData.entry.avatar, self.__rankElemData.entry.extraData.card)
  end
end

function UINCardSetRankPanelItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetRankPanelItem
