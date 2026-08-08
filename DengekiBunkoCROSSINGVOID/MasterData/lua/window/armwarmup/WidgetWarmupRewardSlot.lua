local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local ACU = require("Common/ActivityUtil")
local m_allList = PB.all("WarmupChapterProgressConfig")
local m_storyList, m_progressInfo, m_chapterList, m_warmupInfo, m_currentChapterId, m_currentProgressId, m_chapterId, m_rewardList, m_secretPlan, m_hasGet

function Awake()
  WU.BindButtonEvent(REF.Close, function()
    REF["$"].gameObject:SetActive(false)
  end)
end

function SetData(chapterId, progressId, pos)
  SetInfo()
  local info = PB.get("WarmupChapterProgressConfig", chapterId, progressId)
  if info and info.progressType == PB.enum.WarmupProgressType.Reward then
    if chapterId < m_currentChapterId then
      m_hasGet = true
    elseif m_currentChapterId == chapterId then
      if progressId <= m_currentProgressId then
        m_hasGet = true
      else
        m_hasGet = false
      end
    else
      m_hasGet = false
    end
    REF["$"].transform.position = pos
    SetList(info)
    REF["$"].gameObject:SetActive(true)
    REF.NodeReward.gameObject:SetActive(true)
  elseif info and info.progressType == PB.enum.WarmupProgressType.Story then
    if chapterId < m_currentChapterId then
      m_hasGet = true
    elseif m_currentChapterId == chapterId then
      if progressId <= m_currentProgressId then
        m_hasGet = true
      else
        m_hasGet = false
      end
    else
      m_hasGet = false
    end
    REF["$"].transform.position = pos
    if not m_hasGet then
      REF["$"].gameObject:SetActive(true)
      REF.NodeStory.gameObject:SetActive(true)
    end
  end
end

function SetList(data)
  if data.progressReward and not table.empty(data.progressReward) then
    REF.SpriteBasicGet.gameObject:SetActive(m_hasGet)
    REF.BasicRewards.gameObject:SetActive(true)
    WU.TraverseChildren(REF.BasicRewards, function(go, i)
      if data.progressReward[i + 1] then
        local info = data.progressReward[i + 1]
        go:SetActive(true)
        _ENV["$"](go)["$$SetData"](info.type, info.id, info.count)
      else
        go:SetActive(false)
      end
    end)
    REF.BasicRewards.UIGrid:Reposition()
  else
    REF.BasicRewards.gameObject:SetActive(false)
  end
  if data.progressRewardSecretPlan and not table.empty(data.progressRewardSecretPlan) then
    REF.SpriteOtherGet.gameObject:SetActive(m_secretPlan and m_hasGet)
    REF.OtherRewards.gameObject:SetActive(true)
    WU.TraverseChildren(REF.OtherRewards, function(go, i)
      if data.progressRewardSecretPlan[i + 1] then
        local info = data.progressRewardSecretPlan[i + 1]
        go:SetActive(true)
        _ENV["$"](go)["$$SetData"](info.type, info.id, info.count)
      else
        go:SetActive(false)
      end
    end)
    REF.OtherRewards.UIGrid:Reposition()
  else
    REF.OtherRewards.gameObject:SetActive(false)
  end
end

function SetInfo()
  local info = this:GetData("fci/warmup")
  m_warmupInfo = info
  if m_warmupInfo and m_warmupInfo.chapterRecords then
    m_currentChapterId = m_warmupInfo.currentChapterId
    local index = table.find(m_warmupInfo.chapterRecords, function(k, v)
      return v.chapterId == m_warmupInfo.currentChapterId
    end)
    m_currentProgressId = m_warmupInfo.chapterRecords[index].currentProgressId
  else
    error("no info in fci/warmup")
    return
  end
  m_secretPlan = info.secretPlan
  REF.NodeReward.gameObject:SetActive(false)
  REF.NodeStory.gameObject:SetActive(false)
  REF.LabelHasNotBuy.gameObject:SetActive(not m_secretPlan)
  REF.LabelHasBuy.gameObject:SetActive(m_secretPlan)
end
