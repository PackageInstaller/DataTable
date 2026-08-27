local base = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapNodeBase")
local UINSGChapterMapStageNode = class("UINSGChapterMapStageNode", base)

function UINSGChapterMapStageNode:OnInit()
  base.OnInit(self)
  self._challengeUISizeDefault = self.ui.ChallengeBg.sizeDelta.x
end

function UINSGChapterMapStageNode:InitNSGChapterMapNode(storyData, nodeData)
  base.InitNSGChapterMapNode(self, storyData, nodeData)
  self:__RefreshChallenge()
end

function UINSGChapterMapStageNode:SGNode_RefreshNodeState()
  base.SGNode_RefreshNodeState(self)
  self:__RefreshChallenge()
end

function UINSGChapterMapStageNode:__RefreshNodeTitle()
  self.ui.tex_Stage.text = self.nodeData:Act23GSSN_GetNodeTitle(".")
end

function UINSGChapterMapStageNode:__RefreshNodeImg()
  local index = self.nodeData:Act23GSSN_GetNodeOutLookIndex()
  index = math.clamp(index, 0, 2)
  if index == 2 then
    self.ui.Img_FinalQuest:SetActive(true)
    index = 0
  else
    self.ui.Img_FinalQuest:SetActive(false)
  end
  self.ui.img_self:SetIndex(index)
end

function UINSGChapterMapStageNode:Act23SGSetClickCallback(callback)
  self.callback = callback
end

function UINSGChapterMapStageNode:__RefreshChallenge()
  local diff = self.storyData:Act23Gs_GetDiffIndex()
  local stageId = self.nodeData:Act23GSSN_GetStageId(diff)
  if PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(stageId) then
    self.ui.challenge:SetActive(true)
    local stageCfg = ConfigData.sector_stage[stageId]
    local size = self.ui.ChallengeBg.sizeDelta
    size.x = self._challengeUISizeDefault * #stageCfg.hard_task
    self.ui.ChallengeBg.sizeDelta = size
    local curNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(stageId)
    size = self.ui.Img_ChallengeCur.sizeDelta
    size.x = self._challengeUISizeDefault * curNum
    self.ui.Img_ChallengeCur.sizeDelta = size
  else
    self.ui.challenge.gameObject:SetActive(false)
  end
end

function UINSGChapterMapStageNode:__OnClick()
  if self.callback ~= nil then
    self.callback(self.nodeData, self)
  end
end

function UINSGChapterMapStageNode:OnDelete()
  base.OnDelete(self)
end

return UINSGChapterMapStageNode
