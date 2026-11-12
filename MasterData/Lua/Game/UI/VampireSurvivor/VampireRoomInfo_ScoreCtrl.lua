local VampireRoomInfo_ScoreCtrl = class("VampireRoomInfo_ScoreCtrl", BaseCtrl)
VampireRoomInfo_ScoreCtrl._mapNodeConfig = {
  imgScoreBg = {sComponentName = "Image"},
  Score = {nCount = 3},
  TMPScore = {sComponentName = "TMP_Text", nCount = 3},
  TMPScoreAnim = {
    sNodeName = "TMPScore",
    sComponentName = "Animator",
    nCount = 3
  },
  TMPScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Score_Title"
  },
  imgBonus = {nCount = 3},
  TMPBonus = {sComponentName = "TMP_Text", nCount = 3},
  rtFillMask = {
    sComponentName = "HpBarRectTransform"
  },
  rtBonus = {
    sComponentName = "CanvasGroup"
  },
  AnimRoot = {sComponentName = "Animator"},
  UIParticleScore1 = {}
}
VampireRoomInfo_ScoreCtrl._mapEventConfig = {
  VampireScoreChange = "OnEvent_VampireScoreChange",
  VampireBonusKill = "OnEvent_VampireBonusChange",
  VampireBonusExpire = "OnEvnet_VampireBonusExpire"
}
VampireRoomInfo_ScoreCtrl._mapRedDotConfig = {}

function VampireRoomInfo_ScoreCtrl:Awake()
  self.tbColor = {}
  local bSuccess
  bSuccess, self.tbColor[1] = ColorUtility.TryParseHtmlString("#4c74d6")
  bSuccess, self.tbColor[2] = ColorUtility.TryParseHtmlString("#EB7057")
  bSuccess, self.tbColor[3] = ColorUtility.TryParseHtmlString("#ED4564")
  self.nBonusTime = 0
  self.tbBonusRank = {}
  self.tbBonusPower = {}
  local sBonusConfig = ConfigTable.GetConfigValue("VampireBonusConfig")
  if sBonusConfig ~= nil then
    local tbBonusConfig = decodeJson(sBonusConfig)
    if tbBonusConfig ~= nil then
      for _, tbData in ipairs(tbBonusConfig) do
        table.insert(self.tbBonusRank, tbData[1])
        table.insert(self.tbBonusPower, tbData[2])
      end
    end
  end
  local sBonusTime = ConfigTable.GetConfigValue("VampireBonusTime")
  if sBonusTime ~= nil then
    local nTime = tonumber(sBonusTime)
    if nTime ~= nil then
      self.nBonusTime = nTime
    end
  end
  self.nCurScore = 0
end

function VampireRoomInfo_ScoreCtrl:FadeIn()
end

function VampireRoomInfo_ScoreCtrl:FadeOut()
end

function VampireRoomInfo_ScoreCtrl:OnEnable()
  self._mapNode.Score[1].gameObject:SetActive(true)
  self._mapNode.Score[2].gameObject:SetActive(false)
  self._mapNode.Score[3].gameObject:SetActive(false)
  self._mapNode.UIParticleScore1:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.TMPScore[1], 0)
  self._mapNode.imgBonus[1].gameObject:SetActive(true)
  self._mapNode.imgBonus[2].gameObject:SetActive(false)
  self._mapNode.imgBonus[3].gameObject:SetActive(false)
  self._mapNode.TMPBonus[1].gameObject:SetActive(true)
  self._mapNode.TMPBonus[2].gameObject:SetActive(false)
  self._mapNode.TMPBonus[3].gameObject:SetActive(false)
  self.nCurRank = 0
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtBonus, 0)
end

function VampireRoomInfo_ScoreCtrl:OnDisable()
end

function VampireRoomInfo_ScoreCtrl:OnDestroy()
end

function VampireRoomInfo_ScoreCtrl:OnRelease()
end

function VampireRoomInfo_ScoreCtrl:OnEvent_VampireScoreChange(nScore)
  nScore = math.floor(nScore)
  if self.nCurRank <= 1 then
    NovaAPI.SetTMPText(self._mapNode.TMPScore[1], nScore)
    self._mapNode.TMPScoreAnim[1]:Play("rtScoreTMP_in")
  elseif self.nCurRank < 3 then
    NovaAPI.SetTMPText(self._mapNode.TMPScore[self.nCurRank], nScore)
    self._mapNode.TMPScoreAnim[2]:Play("rtScoreTMP_in")
  else
    NovaAPI.SetTMPText(self._mapNode.TMPScore[3], nScore)
    self._mapNode.TMPScoreAnim[3]:Play("rtScoreTMP_in")
  end
  self.nCurScore = nScore
end

function VampireRoomInfo_ScoreCtrl:OnEvent_VampireBonusChange(nCount)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtBonus, 1)
  self._mapNode.rtFillMask:SetTarget(Vector2(92, 84), 0)
  self._mapNode.rtFillMask:SetTarget(Vector2(92, 0), self.nBonusTime + 1)
  local rank = 0
  for i = 1, #self.tbBonusRank do
    if nCount >= self.tbBonusRank[i] then
      rank = i
    else
      break
    end
  end
  if rank ~= self.nCurRank then
    self._mapNode.imgScoreBg.color = self.tbColor[rank <= 1 and 1 or rank == 2 and 2 or 3]
    self._mapNode.UIParticleScore1:SetActive(rank == 1)
    self._mapNode.Score[1].gameObject:SetActive(rank <= 1)
    self._mapNode.Score[2].gameObject:SetActive(rank == 2)
    self._mapNode.Score[3].gameObject:SetActive(3 <= rank)
    self._mapNode.imgBonus[1].gameObject:SetActive(rank <= 1)
    self._mapNode.imgBonus[2].gameObject:SetActive(rank == 2)
    self._mapNode.imgBonus[3].gameObject:SetActive(3 <= rank)
    self._mapNode.TMPBonus[1].gameObject:SetActive(rank <= 1)
    self._mapNode.TMPBonus[2].gameObject:SetActive(rank == 2)
    self._mapNode.TMPBonus[3].gameObject:SetActive(3 <= rank)
    self.nCurRank = rank
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if rank == 2 then
        self._mapNode.AnimRoot:Play("VampireRoomInfoBonus_in")
      elseif rank == 3 then
        self._mapNode.AnimRoot:Play("VampireRoomInfoBonus_in1")
      end
    end
    
    cs_coroutine.start(wait)
  end
  if self.nCurRank == 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPBonus[1], orderedFormat(ConfigTable.GetUIText("Vampire_Bonus_Title_z") or "", nCount))
  elseif 1 >= self.nCurRank then
    NovaAPI.SetTMPText(self._mapNode.TMPBonus[1], orderedFormat(ConfigTable.GetUIText("Vampire_Bonus_Title") or "", nCount, self.tbBonusPower[1] / 100))
  elseif self.nCurRank <= 3 then
    NovaAPI.SetTMPText(self._mapNode.TMPBonus[self.nCurRank], orderedFormat(ConfigTable.GetUIText("Vampire_Bonus_Title") or "", nCount, self.tbBonusPower[self.nCurRank] / 100))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPBonus[3], orderedFormat(ConfigTable.GetUIText("Vampire_Bonus_Title") or "", nCount, self.tbBonusPower[self.nCurRank] / 100))
  end
end

function VampireRoomInfo_ScoreCtrl:OnEvnet_VampireBonusExpire()
  self._mapNode.imgScoreBg.color = self.tbColor[1]
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtBonus, 0)
  self.nCurRank = 0
  self:OnEvent_VampireScoreChange(self.nCurScore)
  self._mapNode.Score[1].gameObject:SetActive(true)
  self._mapNode.Score[2].gameObject:SetActive(false)
  self._mapNode.Score[3].gameObject:SetActive(false)
  self._mapNode.imgBonus[1].gameObject:SetActive(true)
  self._mapNode.imgBonus[2].gameObject:SetActive(false)
  self._mapNode.imgBonus[3].gameObject:SetActive(false)
  self._mapNode.TMPBonus[1].gameObject:SetActive(true)
  self._mapNode.TMPBonus[2].gameObject:SetActive(false)
  self._mapNode.TMPBonus[3].gameObject:SetActive(false)
end

return VampireRoomInfo_ScoreCtrl
