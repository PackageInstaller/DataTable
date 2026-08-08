local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local RU = require("Common/RedMarkUtil")
local m_reward, m_chapterRecord, m_drawCallback

function Start()
  WU.BindButtonEvent(REF.ButtonDraw, OnDrawClick)
end

function SetReward(chapterReward, chapterRecord)
  m_reward = chapterReward
  m_chapterRecord = chapterRecord
  for i = 0, #REF.Grid - 1 do
    local itemSlotRef = REF.Grid[i]
    itemSlotRef["$gameObject"]:SetActive(i < #m_reward.reward)
    if i < #m_reward.reward then
      local reward = m_reward.reward[i + 1]
      if reward.type == PB.enum.ResourceType.ResActor then
        local actorQuality = AU.CheckActorStarRandom(reward.id, reward.param)
        itemSlotRef["$$SetActorCustom"]({
          id = reward.id,
          quality = actorQuality
        })
        itemSlotRef["$$SetClickCallback"](function()
          WU.AcquireWindowAsync("ItemDetail", function(ui)
            _ENV["$"](ui)["$$SetActorInfo"](reward.id, actorQuality)
          end)
        end)
      else
        itemSlotRef["$$SetData"](reward.type, reward.id, reward.count)
      end
      if reward.type == PB.enum.ResourceType.ResMedal then
        itemSlotRef["$$SetNameVisible"](false)
      end
      itemSlotRef["$$SetCountFontSize"](46)
    end
  end
  local isCurrentChapter = this:GetData("ChapterRewardDefaultSelectChapter") == m_chapterRecord.chapterId
  local got = table.has(m_chapterRecord.starRewardGot, m_reward.star)
  local starMatched
  if m_reward.star == 0 then
    starMatched = m_chapterRecord.finished
  else
    starMatched = m_reward.star <= m_chapterRecord.totalStar
  end
  REF.SpriteGot.gameObject:SetActive(got)
  REF.ButtonNotGet.gameObject:SetActive(not got and not starMatched)
  REF.ButtonDraw.gameObject:SetActive(not got and starMatched)
  if REF.ButtonDraw.gameObject.activeSelf then
    REF.EffectBox.UIPlayTween:Play(true)
  end
  REF.LabelStar.UILabel.text = m_reward.star
  REF.NodeStar.gameObject:SetActive(m_reward.star ~= 0)
  REF.SpriteFinishReward.gameObject:SetActive(m_reward.star == 0)
end

function OnDrawClick()
  if m_drawCallback then
    m_drawCallback()
  end
  WU.RecordButtonClick(129002)
  if m_chapterRecord then
    this:GameRequest("fci/dungeon/chapter/" .. m_chapterRecord.chapterId .. "/reward/"):Post({
      starReward = m_reward.star
    }, OnRewardResponse)
  end
end

function OnButtonGotoClick()
  WU.RecycleWindow("ChapterRewardListAll")
  local chapterInfo = PB.get("ChapterInfo", m_chapterRecord.chapterId)
  if chapterInfo then
    local index = chapterInfo.chapterIndex
    this:BroadcastGameEvent("ChapterPageTo", index - 1)
  end
end

function OnRewardResponse(result)
  DBH.ResChange(result.resChange)
  this:SetData("ChapterRewardDefaultSelectChapter", m_chapterRecord.chapterId)
  WU.ShowRewards(result.resChange)
  m_chapterRecord.starRewardGot = result.starRewardGot
  local chapter = this:GetData("fci/dungeon/chapter/" .. m_chapterRecord.chapterId)
  if chapter then
    chapter.recordChapter = m_chapterRecord
    this:SetData("fci/dungeon/chapter/" .. m_chapterRecord.chapterId, chapter)
  end
  this:BroadcastGameEvent("NavigateToCanGetReward")
end

function SetDrawCallback(callback)
  m_drawCallback = callback
end
