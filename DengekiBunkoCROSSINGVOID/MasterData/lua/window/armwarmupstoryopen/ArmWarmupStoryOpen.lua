local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local m_allList = PB.all("WarmupChapterProgressConfig")
local m_storyList, m_progressInfo, m_chapterList, m_warmupInfo, m_currentChapterId, m_currentProgressId, m_window, m_startFly

function SetupWindow()
  m_chapterList = {}
  for k, v in pairs(m_allList) do
    if m_chapterList[v.chapterId] == nil then
      m_chapterList[v.chapterId] = {}
    end
    table.insert(m_chapterList[v.chapterId], v)
  end
  REF.ButtonClose["$SetCallback"](function()
    REF.EffectBlow.gameObject:SetActive(true)
    REF.WindowSize.gameObject:SetActive(false)
    REF.EffectBlow.EffectGenerator:Reset()
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
    REF.Black.gameObject:SetActive(false)
    REF.EffectBlow.EffectGenerator:Play(function()
      REF.EffectFly.gameObject:SetActive(true)
      REF.EffectFly.EffectGenerator:Reset()
      m_startFly = true
      REF.EffectFly.transform.localPosition = CS.UnityEngine.Vector3.zero
      REF.EffectFly.EffectGenerator:Play(function()
        WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
        WU.RecycleWindow(this)
      end)
    end)
  end)
end

function InitWindow()
  m_startFly = false
  m_window = WU.FindWindow("ArmWarmup")
  REF.Black.gameObject:SetActive(true)
  REF.WindowSize.gameObject:SetActive(true)
  REF.EffectBlow.gameObject:SetActive(false)
  REF.EffectFly.gameObject:SetActive(false)
  this:BindRemote(DB:GameRequest("fci/warmup"), function(info)
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
  end)
end

function SetProgress(chapterId, progressId)
  local info = PB.get("WarmupChapterProgressConfig", chapterId, progressId)
  if info then
    if info.progressType == PB.enum.WarmupProgressType.Story and info.progressStoryParam ~= 0 then
      RefreshInsert(chapterId, info.progressStoryParam)
    else
      error("WarmupChapterProgressConfig " .. chapterId .. "-" .. progressId .. " has no story")
    end
  else
    error("WarmupChapterProgressConfig has no " .. chapterId .. "-" .. progressId)
  end
end

function RefreshInsert(chapterId, index)
  REF.TextureTitle.UITexture.mainTexturePath = "Texture/Impression_activity/detail_" .. chapterId
  REF.EffectArm.EffectGenerator.m_EffectName = "UI_ImpressionWeapon_Pieces0" .. chapterId
  REF.EffectArm.EffectGenerator:Reset()
  if index == 1 then
    REF.EffectArm.gameObject:SetActive(false)
    REF.EffectNone.gameObject:SetActive(true)
    REF.TextureTitle.gameObject:SetActive(false)
    REF.TextureTitleNone.gameObject:SetActive(true)
    SetText(chapterId, index)
  elseif index == 2 then
    REF.EffectArm.gameObject:SetActive(false)
    REF.EffectNone.gameObject:SetActive(true)
    REF.TextureTitle.gameObject:SetActive(true)
    REF.TextureTitleNone.gameObject:SetActive(false)
    SetText(chapterId, index)
  elseif index == 3 then
    REF.EffectArm.gameObject:SetActive(true)
    REF.EffectNone.gameObject:SetActive(false)
    REF.TextureTitle.gameObject:SetActive(true)
    REF.TextureTitleNone.gameObject:SetActive(false)
    SetText(chapterId, index)
  end
end

function SetText(chapterId, index)
  REF.LabelDesc.UILabel.text = WU.GetString("ArmWarmup_StoryDesc_" .. chapterId .. "_" .. index)
end

function UpdateWindow()
  if m_startFly == true then
    local pos = REF.root.transform:InverseTransformPoint(_ENV["$"](m_window).Sprite.gameObject.transform.position)
    U.Translate(REF.EffectFly.transform, pos.x / 13, pos.y / 13, 0)
  end
end
