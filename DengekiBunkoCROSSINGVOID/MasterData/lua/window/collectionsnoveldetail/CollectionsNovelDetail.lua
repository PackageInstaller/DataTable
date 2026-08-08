local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local m_novel, m_actorInfos, m_coverId, m_activeCovers

function SetupWindow()
  WU.BindButtonEvent(REF.TextureCoverTint, OnClickCover)
  LU.Bind(REF.WrapContentActor, {
    updateRow = UpdateRow
  })
  WU.BindButtonEvent(REF.ButtonRead, function()
    local url = m_novel.url
    if url ~= "" then
      WU.OpenUrlExternal(url)
    end
  end)
end

function InitWindow()
  m_novel = nil
  m_actorInfos = nil
  m_coverId = nil
  WU.ToggleRendering(REF.NodeActors, false)
  WU.ToggleRendering(REF.NodeRequirement, false)
end

function UninitWindow()
  if m_coverId and m_novel.unlock and m_coverId ~= m_novel.curCover then
    this:GameRequest("fci/CollectionsNovel/" .. m_novel.novelId):Put({newCover = m_coverId}, function(result)
      local novel = this:GetData("Collections/Novels/" .. m_novel.novelId)
      novel.curCover = m_coverId
      this:SetData("Collections/Novels/" .. m_novel.novelId, novel)
    end)
  end
end

function SetNovel(novel)
  m_novel = novel
  m_coverId = m_novel.curCover
  if m_novel then
    this:Bind("Collections/Novels/" .. m_novel.novelId, OnNovelChanged)
  end
end

function SetViewActors()
  local rewards
  rewards = PB.get("CollectionsNovelReward", m_novel.novelId).rewards[m_novel.curRewardNum + 1]
  WU.ToggleRendering(REF.NodeActors, true)
  local hasReward = toboolean(rewards and rewards.reward)
  WU.ToggleRendering(REF.NodeRequirement, false)
  if rewards and rewards.reward then
    local reward = rewards.reward
    local unlockScore = rewards.score
    local actorScore = 0
    if m_actorInfos then
      for _, actor in pairs(m_actorInfos) do
        actorScore = actorScore + actor.star
      end
    end
    if not m_novel.canGetReward and m_novel.curRewardNum == 0 then
      WU.ToggleRendering(REF.NodeRequirement, true)
      REF.LabelRequirement.UILabel.text = "[ff0000]" .. actorScore .. "[-]/" .. unlockScore
    end
  end
end

function OnNovelChanged()
  REF.LabelTitle.UILabel.text = WU.GetString("NovelName_" .. m_novel.novelId)
  REF.LabelDesc.UIHtmlLabel.text = WU.GetString("NovelDesc_" .. m_novel.novelId)
  REF.ScrollViewDesc.UIScrollView:ResetPosition()
  REF.TextureCover.UITexture.mainTexturePath = "Texture/Book_icon/book_" .. m_coverId
  WU.SetActive(REF.TextureCoverTint, m_novel.curRewardNum == 0)
  REF.SpriteCoverBgAlpha.UIWidget.alpha = fif(m_novel.curRewardNum == 0, 0.5, 1)
  local showReadButton = this:GetData("accountCache").socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ and m_novel.url ~= "" and not WU.IsPreCommit()
  WU.ToggleRendering(REF.ButtonRead, showReadButton)
  REF.NodeDesc.UIWidget.height = fif(showReadButton, 500, 640)
  WU.SetActive(REF.EffectUnlockTouch, m_novel.canGetReward)
  if m_novel.unlock then
    this:GameRequest("fci/CollectionsNovel/" .. m_novel.novelId):Get(function(result)
      m_actorInfos = result.novelDetail.actorInfo
      m_actorInfos = table.where(m_actorInfos, function(k, v)
        return AU.IsActorOpen(v.actorId, PB.get("ActorConfig", v.actorId).openTime)
      end)
      LU.Set(REF.WrapContentActor, #m_novel.actors)
      SetViewActors()
    end)
  else
    LU.Set(REF.WrapContentActor, #m_novel.actors)
    SetViewActors()
  end
end

function OnClickCover()
  if m_novel.unlock and m_novel.canGetReward then
    this:GameRequest("fci/CollectionsNovel/" .. m_novel.novelId):Post(nil, function(result)
      REF.EffectUnlockBg.EffectGenerator:Play()
      REF.EffectUnlockBook.EffectGenerator:Play()
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Book")
      DBH.ResChange(result.resChange)
      local novelDatas = this:GetData("fci/CollectionsNovel").novels
      for _, novel in pairs(result.novels) do
        local index = table.find(novelDatas, function(k, v)
          return v.novelId == m_novel.novelId
        end)
        novelDatas[index] = novel
      end
      DB:SyncRemote(this:GameRequest("fci/NovelCover/" .. m_novel.novelId))
      this:SetData("fci/CollectionsNovel", this:GetData("fci/CollectionsNovel"))
    end)
  end
end

function UpdateRow(refRow, wrapIndex, realIndex)
  if realIndex ~= nil and m_novel ~= nil and realIndex < #m_novel.actors then
    local actorId = m_novel.actors[realIndex + 1]
    local resConfig = PB.get("ActorConfig", actorId)
    if resConfig then
      refRow.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorJourneyHead/actor_head_" .. resConfig.animRes
      refRow.SpriteActorName.UISprite.spriteName = "actor_name_outline_" .. resConfig.animRes
      refRow.SpriteNameBg.UISprite.width = refRow.SpriteActorName.UISprite.atlas:GetSprite(refRow.SpriteActorName.UISprite.spriteName).width
      refRow.SpriteActorIcon.UISprite.spriteName = "actor_type_" .. actorId
    else
      error("GamePlay", "cannot find actorId in ActorConfig, id: " .. tostring(actorId))
    end
    local starCount = 0
    if m_actorInfos then
      local _, actorInfo = table.find(m_actorInfos, function(_, v)
        return v.actorId == actorId
      end)
      if actorInfo then
        starCount = actorInfo.star
      end
    end
    refRow.LabelStar.UILabel.text = starCount
  end
end
