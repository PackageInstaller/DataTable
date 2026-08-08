local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_allList = PB.all("WarmupChapterProgressConfig")
local m_storyList, m_progressInfo, m_chapterList, m_warmupInfo, m_currentChapterId, m_currentProgressId, m_progressList

function SetupWindow()
  m_chapterList = {}
  for k, v in pairs(m_allList) do
    if m_chapterList[v.chapterId] == nil then
      m_chapterList[v.chapterId] = {}
    end
    table.insert(m_chapterList[v.chapterId], v)
  end
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/warmup"), function(info)
    m_warmupInfo = info
    if m_warmupInfo and m_warmupInfo.chapterRecords then
      m_currentChapterId = m_warmupInfo.currentChapterId
      local index = table.find(m_warmupInfo.chapterRecords, function(k, v)
        return v.chapterId == m_warmupInfo.currentChapterId
      end)
      m_currentProgressId = m_warmupInfo.chapterRecords[index].currentProgressId
      SetProgress(m_currentChapterId, m_currentProgressId)
    else
      error("no info in fci/warmup")
      return
    end
  end)
end

function SetProgress(currentChapterId, currentProgressId)
  m_storyList = {}
  m_progressList = {}
  for i = 1, currentChapterId - 1 do
    m_storyList[i] = {
      1,
      2,
      3
    }
  end
  for k, v in pairs(m_chapterList[currentChapterId]) do
    if m_storyList[currentChapterId] == nil then
      m_storyList[currentChapterId] = {}
    end
    if currentProgressId >= v.progressId and v.progressType == PB.enum.WarmupProgressType.Story then
      table.insert(m_storyList[currentChapterId], v.progressStoryParam)
    end
    if v.progressType == PB.enum.WarmupProgressType.Story then
      table.insert(m_progressList, v.progressId)
    end
  end
  WU.TraverseChildren(REF.TabWrapContent, function(go, index)
    if index + 1 > currentChapterId then
      go:SetActive(false)
    else
      go:SetActive(true)
      _ENV["$"](go)["$$SetTab"](WU.GetString("ArmWarmup_ChapterTitle_" .. index + 1))
      _ENV["$"](go)["$$SetClickCallback"](function()
        RefreshInsert(index + 1)
      end)
    end
  end)
end

function RefreshInsert(index)
  if m_storyList[index] then
    REF.EffectArm.EffectGenerator.m_EffectName = "UI_ImpressionWeapon_Pieces0" .. index
    REF.EffectArm.EffectGenerator:Reset()
    REF.TextureTitleNone.UITexture.mainTexturePath = "Texture/Impression_activity/impression_0"
    REF.TextureTitle.UITexture.mainTexturePath = "Texture/Impression_activity/title_" .. index
    if #m_storyList[index] == 0 then
      REF.EffectArm.gameObject:SetActive(false)
      REF.EffectNone.gameObject:SetActive(true)
      REF.TextureTitle.gameObject:SetActive(false)
      REF.TextureTitleNone.gameObject:SetActive(true)
      SetText(index, 1, false)
      SetText(index, 2, false)
      SetText(index, 3, false)
    elseif #m_storyList[index] == 1 then
      REF.EffectArm.gameObject:SetActive(false)
      REF.EffectNone.gameObject:SetActive(true)
      REF.TextureTitle.gameObject:SetActive(false)
      REF.TextureTitleNone.gameObject:SetActive(true)
      SetText(index, 1, true)
      SetText(index, 2, false)
      SetText(index, 3, false)
    elseif #m_storyList[index] == 2 then
      REF.EffectArm.gameObject:SetActive(false)
      REF.EffectNone.gameObject:SetActive(true)
      REF.TextureTitle.gameObject:SetActive(true)
      REF.TextureTitleNone.gameObject:SetActive(false)
      SetText(index, 1, true)
      SetText(index, 2, true)
      SetText(index, 3, false)
    elseif #m_storyList[index] == 3 then
      REF.EffectArm.gameObject:SetActive(true)
      REF.EffectNone.gameObject:SetActive(false)
      REF.TextureTitle.gameObject:SetActive(true)
      REF.TextureTitleNone.gameObject:SetActive(false)
      SetText(index, 1, true)
      SetText(index, 2, true)
      SetText(index, 3, true)
    end
    REF.Wrap.UITable:Reposition()
    WU.TraverseChildren(REF.Wrap, function(go, idx)
      local pos = go.transform.localPosition
      go.transform.localPosition = CS.UnityEngine.Vector3(15, pos.y, pos.z)
    end)
    REF.ScrollViewDesc.UIScrollView:ResetPosition()
  end
end

function SetText(index, storyIndex, isShow)
  _ENV["$"](REF["Node" .. storyIndex]).LabelTitle.UILabel.text = WU.GetString("ArmWarmup_StoryTitle_" .. index .. "_" .. storyIndex)
  _ENV["$"](REF["Node" .. storyIndex]).LabelDesc.UILabel.text = WU.GetString("ArmWarmup_StoryDesc_" .. index .. "_" .. storyIndex)
  if isShow == true then
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.atlasPath = "Welfare"
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.spriteName = "Impression/page_bg_1"
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGDesc.gameObject:SetActive(true)
    local height = _ENV["$"](REF["Node" .. storyIndex]).LabelDesc.UILabel.height + 90
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGDesc.UISprite.height = height
    _ENV["$"](REF["Node" .. storyIndex]).LabelPoint.gameObject:SetActive(false)
    _ENV["$"](REF["Node" .. storyIndex]).LabelState.UILabel.text = WU.GetString("ArmWarmup_StoryHasUnlock")
  else
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.atlasPath = "Common"
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.spriteName = "white"
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGTitle.UISprite.color = CS.NGUIMath.HexToColor(4294967242)
    _ENV["$"](REF["Node" .. storyIndex]).SpriteBGDesc.gameObject:SetActive(false)
    _ENV["$"](REF["Node" .. storyIndex]).LabelPoint.gameObject:SetActive(false)
    _ENV["$"](REF["Node" .. storyIndex]).LabelState.UILabel.text = WU.GetString("ArmWarmup_StoryUnlockInProgress", m_progressList[storyIndex])
  end
end

function SetIndex(index)
  REF.TabWrapContent[index - 1]["$UIToggle"].value = true
  RefreshInsert(index)
end
