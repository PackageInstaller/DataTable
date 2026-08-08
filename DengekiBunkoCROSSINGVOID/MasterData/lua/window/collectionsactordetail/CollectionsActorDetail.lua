local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local SDU = require("Common/SoundUtil")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local m_iActorIndex, m_dragDelta, m_actorSkills, m_nowActor, m_nowActorConfig, m_nowAudioSource, m_sortedActorList
local m_fTweenerInterval = 0
local m_fElapsed = 0
local m_bDoTween = false
local m_iFadeInterval = 0.5
local m_fAlpha = 1
local m_bUpGoes = false
local m_thumbsUp = false
local m_kTweener, m_kNowActorTab, m_fromViewType
local FromViewtype = {From_CollectionsActor = 1, From_ActorMain = 2}
local ActorTypePrefix = {
  "WindowActorList_Actor",
  "WindowActorList_Assist"
}
local ActorTabs = {
  Summary = 1,
  Skill = 2,
  Assistant = 3,
  Talent = 4,
  ActorSkin = 5
}

function SetViewFrom(from)
  m_fromViewType = from
end

function SetupWindow()
  WU.BindButtonEvent(REF.BtnSummary, function()
    WU.RecordButtonClick(100136704)
    if m_kNowActorTab ~= ActorTabs.Summary then
      m_kNowActorTab = ActorTabs.Summary
      ShowTabView()
    end
  end)
  WU.BindButtonEvent(REF.BtnSkill, function()
    WU.RecordButtonClick(100136705)
    if m_kNowActorTab ~= ActorTabs.Skill then
      m_kNowActorTab = ActorTabs.Skill
      ShowTabView()
    end
  end)
  WU.BindButtonEvent(REF.BtnAssistant, function()
    WU.RecordButtonClick(100136706)
    if m_kNowActorTab ~= ActorTabs.Assistant then
      m_kNowActorTab = ActorTabs.Assistant
      ShowTabView()
    end
  end)
  WU.BindButtonEvent(REF.BtnTalent, function()
    WU.RecordButtonClick(100136707)
    if m_kNowActorTab ~= ActorTabs.Talent then
      m_kNowActorTab = ActorTabs.Talent
      ShowTabView()
    end
  end)
  WU.BindButtonEvent(REF.BtnActorSkin, function()
    WU.RecordButtonClick(100136708)
    if m_kNowActorTab ~= ActorTabs.ActorSkin then
      m_kNowActorTab = ActorTabs.ActorSkin
      ShowTabView()
    end
  end)
  WU.BindButtonEvent(REF.BtnWikiVoice, function()
    WU.RecordButtonClick(100136703)
    if m_nowActorConfig ~= nil then
      if m_nowAudioSource ~= nil then
        m_nowAudioSource:Stop()
      end
      m_nowAudioSource = SDU.PlayActorWiki(m_nowActorConfig.role)
      InitWikiVoice(m_nowAudioSource.clip.length)
    end
  end)
  WU.BindButtonEvent(REF.BtnMoreInfo, function()
    if m_nowActorConfig ~= nil then
      WU.AcquireWindowAsync("CollectionsActorShapes", function(window)
        _ENV["$"](window)["$$InitData"](m_nowActor)
      end)
    end
  end)
  WU.BindDragEvent(REF.TextureActor, OnDraging)
  WU.BindPressEvent(REF.TextureActor, OnPress)
  WU.TraverseChildren(REF.WrapContentSkin, function(RowGo)
    WU.TraverseChildren(_ENV["$"](RowGo).root, function(boxGo)
      WU.BindButtonEvent(_ENV["$"](boxGo).root, function()
        OnClickSkinBox(_ENV["$"](boxGo))
      end)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonRead, function()
    local resNovel = PB.get("Novel", AU.GetActorNovel(m_nowActor.id))
    local novelUrl = ""
    if resNovel then
      novelUrl = resNovel.url
    end
    if novelUrl ~= "" then
      WU.OpenUrlExternal(novelUrl)
    end
  end)
  WU.BindButtonEvent(REF.ButtonComment, function()
    WU.RecordButtonClick(100136702)
    WU.AcquireWindowAsync("ActorComments", function(window)
      _ENV["$"](window)["$$SetWhereFrom"](1)
      _ENV["$"](window)["$$InitData"]()
    end)
  end)
  WU.BindButtonEvent(REF.ButtonthumbsUp, function()
    WU.RecordButtonClick(100136701)
    DoThumbsUp()
  end)
end

function UninitWindow()
  WU.ToggleRendering(REF.SpriteLike, false)
  if m_nowAudioSource ~= nil then
    m_nowAudioSource:Stop()
  end
end

function OnActorDataChange(actor)
  SetActor(actor, false)
end

function SetSortedActorList(sortedActorList)
  m_sortedActorList = sortedActorList
end

function InitWindow()
  this:RegisterGameEvent("OnActorDataChange", OnActorDataChange)
  m_iActorIndex = nil
end

function UpdateWindow(delta)
  UpdateWikiVoice(delta)
end

function DoThumbsUp()
  local params = {isCancel = m_thumbsUp}
  DB:GameRequest("fci/ActorLike/" .. m_nowActorConfig.id):Post(params, function(response)
    InitThumbsUp(response)
  end)
end

function InitThumbsUp(resp)
  REF.LabelThumbsUp.UILabel.text = resp.likeNum
  m_thumbsUp = resp.isLike
  WU.ToggleRendering(REF.SpriteLike, m_thumbsUp)
end

function UpdateWikiVoice(deltaTime)
  if m_bDoTween then
    m_fElapsed = m_fElapsed + deltaTime
    if m_fElapsed <= m_fTweenerInterval then
      local fAttenStep = deltaTime
      if m_bUpGoes then
        m_fAlpha = m_fAlpha + fAttenStep
        if 1 < m_fAlpha then
          m_bUpGoes = false
          m_fAlpha = 1
        end
      else
        m_fAlpha = m_fAlpha - fAttenStep
        if m_fAlpha <= 0.5 then
          m_fAlpha = 0.5
          m_bUpGoes = true
        end
      end
      REF.BtnWikiVoice.UIButton.defaultColor = CS.UnityEngine.Color(1, 1, 1, m_fAlpha)
    else
      m_bDoTween = false
      REF.BtnWikiVoice.UIButton.defaultColor = CS.UnityEngine.Color(1, 1, 1, 1)
    end
  end
end

function InitWikiVoice(audioClipLenght)
  local iTotalFadeCount = math.ceil(audioClipLenght / m_iFadeInterval)
  if iTotalFadeCount % 2 ~= 0 then
    iTotalFadeCount = iTotalFadeCount + 1
  end
  m_fElapsed = 0
  m_bDoTween = true
  m_fAlpha = 1
  m_bUpGoes = false
  m_fTweenerInterval = iTotalFadeCount * m_iFadeInterval
end

function GetNowActorDesctirbe()
  local iMaxCount = 5
  local iNowRoleID = m_nowActorConfig.role
  local kDesc = ""
  for i = 1, iMaxCount do
    local key = "ActorDescribe_" .. iNowRoleID .. "_" .. i
    if WU.IsExist(key) then
      local thisDesc = WU.GetString(key)
      if thisDesc ~= nil and thisDesc ~= "" and thisDesc ~= key then
        if kDesc ~= "" then
          kDesc = kDesc .. "\n" .. thisDesc
        else
          kDesc = thisDesc
        end
      end
    end
  end
  return kDesc
end

function SetActor(actor, isSwitchSet)
  if m_nowAudioSource ~= nil then
    m_nowAudioSource:Stop()
  end
  m_nowActor = actor
  local actorID = actor.id
  m_nowActorConfig = PB.get("ActorConfig", actorID)
  m_actorSkills = SE.GetActorSkills(m_nowActor.id)
  local thePortrait = PB.get("ActorPortrait", actorID, 0)
  this:SetData("ActorWikiSelected", m_nowActorConfig.id)
  if m_sortedActorList and isSwitchSet == false then
    m_iActorIndex = table.find(m_sortedActorList, function(k, v)
      return v.id == actorID
    end)
  end
  if m_kNowActorTab == nil then
    m_kNowActorTab = ActorTabs.Summary
  end
  ShowTabView()
  HideOrShowMoreButton()
  RequestThumbsUp()
  REF.IconActorName.UISprite.spriteName = "actor_name_" .. m_nowActorConfig.animRes
  REF.IconActorName.UISprite:SnapWithoutScale()
  REF.LabelViewSummary.UILabel.text = GetNowActorDesctirbe()
  REF.IconActorType.UISprite.spriteName = "actor_type_" .. m_nowActorConfig.id
  local textCV = WU.GetString("ActorCV_" .. m_nowActorConfig.id)
  textCV = string.replace(textCV, "CV\239\188\154", "")
  REF.LabelCVDesc.UILabel.text = textCV
  local textKind = WU.GetString(ActorTypePrefix[m_nowActorConfig.kind])
  local textCategory = WU.GetString("ActorCategory_" .. tostring(m_nowActor.category))
  REF.LabelType.UILabel.text = textKind
  REF.LabelTypeCategory.UILabel.text = textCategory
  m_nowAudioSource = SDU.PlayActorWiki(m_nowActorConfig.role)
  InitWikiVoice(m_nowAudioSource.clip.length)
  if m_nowActor.unlock then
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. m_nowActorConfig.animRes
    REF.TextureActor.UITexture.maskTexturePath = "Texture/ActorPortrait/actor_portrait_" .. m_nowActorConfig.animRes
  else
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_bg"
    REF.TextureActor.UITexture.maskTexturePath = "Texture/ActorPortrait/actor_portrait_" .. m_nowActorConfig.animRes
  end
  local width = REF.TextureActor.UITexture.width
  local height = REF.TextureActor.UITexture.height
  local offsetX = -m_nowActorConfig.portraitUVOffsetX / width
  local offsetY = m_nowActorConfig.portraitUVOffsetY / height
  local tileX = 1
  local tileY = 1
  REF.TextureActor.UITexture.uvRect = CS.UnityEngine.Rect(offsetX, offsetY, tileX, tileY)
  local actorTag = PB.get("ActorTag", actorID)
  local j = 1
  local i = 1
  while i <= #REF.ActorTags do
    local tag = actorTag.tag[j]
    local tagRef = REF.ActorTags[i - 1]
    tagRef["$gameObject"]:SetActive(false)
    if tag then
      local actorTagInfo = PB.get("ActorTagInfo", tag)
      if actorTagInfo.displayTag then
        tagRef["$gameObject"]:SetActive(true)
        tagRef.TagType.UISprite.spriteName = "actor_type_tag_" .. tag
        tagRef.TagSprite.UISprite.spriteName = "actor_tag_1"
        if actorTagInfo and actorTagInfo.displayTag then
          tagRef.TagSprite.UISprite.spriteName = "actor_tag_" .. actorTagInfo.color
        else
          warning("ActorTagInfo.xlsx", "tag not found : " .. tostring(tag))
        end
        tagRef.TagLabel.UILabel.text = WU.GetString("tag" .. tag)
        i = i + 1
      end
      j = j + 1
    else
      i = i + 1
    end
  end
end

function RequestThumbsUp()
  DB:GameRequest("fci/ActorLike/" .. m_nowActorConfig.id):Get(function(response)
    InitThumbsUp(response)
  end)
end

function HideOrShowMoreButton()
  local count = 0
  local acquredActors = this:GetData("Collections/Actors/")
  for _, v in pairs(acquredActors) do
    if m_nowActor.roleId == v.roleId then
      count = count + 1
    end
  end
  if 1 < count then
    REF.BtnMoreInfo.gameObject:SetActive(true)
  else
    REF.BtnMoreInfo.gameObject:SetActive(false)
  end
end

function SwitchActor(next)
  if m_sortedActorList == nil or m_iActorIndex == nil then
    return
  end
  if next and m_iActorIndex < #m_sortedActorList then
    m_iActorIndex = m_iActorIndex + 1
    SetActor(m_sortedActorList[m_iActorIndex], true)
    REF["$Animator"]:Play("Open", -1, 0)
  end
  if not next and 1 < m_iActorIndex then
    m_iActorIndex = m_iActorIndex - 1
    SetActor(m_sortedActorList[m_iActorIndex], true)
    REF["$Animator"]:Play("Open", -1, 0)
  end
end

function ResetTabView()
  REF.CheckPressedSummary.gameObject:SetActive(false)
  REF.CheckNormalSummary.gameObject:SetActive(true)
  REF.LabelSummary.UILabel.color = CS.NGUIMath.HexToColor(995593215)
  REF.CheckPressedSkill.gameObject:SetActive(false)
  REF.CheckNormalSkill.gameObject:SetActive(true)
  REF.LabelSkill.UILabel.color = CS.NGUIMath.HexToColor(995593215)
  REF.CheckPressedAssistant.gameObject:SetActive(false)
  REF.CheckNormalAssistant.gameObject:SetActive(true)
  REF.LabelAssistant.UILabel.color = CS.NGUIMath.HexToColor(995593215)
  REF.CheckPressedTalent.gameObject:SetActive(false)
  REF.CheckNormalTalent.gameObject:SetActive(true)
  REF.LabelTalent.UILabel.color = CS.NGUIMath.HexToColor(995593215)
  REF.CheckPressedActorSkin.gameObject:SetActive(false)
  REF.CheckNormalActorSkin.gameObject:SetActive(true)
  REF.LabelActorSkin.UILabel.color = CS.NGUIMath.HexToColor(995593215)
  REF.ViewSummary.gameObject:SetActive(false)
  REF.ViewSkill.gameObject:SetActive(false)
  REF.ViewAssistant.gameObject:SetActive(false)
  REF.ViewTalent.gameObject:SetActive(false)
  REF.ViewActorSkin.gameObject:SetActive(false)
end

function ShowTabView()
  ResetTabView()
  local tabName = table.find(ActorTabs, function(k, v)
    return v == m_kNowActorTab
  end)
  REF["CheckPressed" .. tabName].gameObject:SetActive(true)
  REF["CheckNormal" .. tabName].gameObject:SetActive(false)
  REF["View" .. tabName].gameObject:SetActive(true)
  REF["Label" .. tabName].UILabel.color = CS.NGUIMath.HexToColor(4294967295)
  _ENV["SetViewDataOf" .. tabName]()
end

function SetViewDataOfSummary()
  WU.ToggleRendering(REF.ButtonRead, false)
  local novelId = AU.GetActorNovel(m_nowActor.id)
  local url = ""
  if novelId then
    url = PB.get("Novel", novelId).url
    REF.LabelNovel.UILabel.text = WU.GetString("NovelName_" .. novelId)
    WU.ToggleRendering(REF.ButtonRead, url ~= "" and this:GetData("accountCache").socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ and not WU.IsPreCommit())
  end
  WU.ToggleRendering(REF.LabelNovel, novelId ~= nil)
end

function OnInitItemSkill(goRef, wrapIndex, realIndex)
  if m_actorSkills ~= nil and realIndex ~= nil and realIndex < table.count(m_actorSkills) then
    local actorSkill = m_actorSkills[realIndex + 1][1]
    local skillEffect
    local skillBgIcon = ""
    if actorSkill.isPassive then
      skillEffect = SE.GetSpecialEffect(actorSkill.specialIndex[1], 1)
      local unlockStarCount = SE.IsSkillUnlockedRaw(actorSkill)
      goRef.WidgetTagSkill["$SetUnlockTips"](unlockStarCount)
      skillBgIcon = "skill_passive"
    else
      local skillCost = SE.GetActorSkillCost(actorSkill.skillId)
      goRef.WidgetTagSkill["$SetSkillCost"](skillCost.costSp, skillCost.costMp)
      skillEffect = SE.GetActorComboEffect(actorSkill.skillId, 1)
      local isSuperSkill = SE.IsSuperSkill(actorSkill)
      skillBgIcon = fif(isSuperSkill, "skill_strong", "skill_normal")
    end
    goRef.SkillBg.UISprite.spriteName = skillBgIcon
    if skillEffect ~= nil then
      goRef.LabelSkillDesc.UIHtmlLabel.text = WU.FormatString(TU.render(WU.GetString("SkillDescribeSimplify_" .. actorSkill.skillId), skillEffect), "#0199e9")
    else
      goRef.LabelSkillDesc.UIHtmlLabel.text = "\230\156\170\233\133\141\231\189\174\230\149\176\230\141\174"
    end
    goRef.LabelSkillName.UILabel.text = WU.GetString("SkillName_" .. actorSkill.skillId)
    goRef.SkillIconTexture.UITexture.mainTexturePath = SE.GetSkillTexturePath(actorSkill, m_nowActor.id)
  end
end

function SetViewDataOfSkill()
  LU.Bind(REF.WrapContentSkill, {
    updateRow = OnInitItemSkill
  })
  LU.Set(REF.WrapContentSkill, #m_actorSkills)
end

local m_kAssitants

function SetViewDataOfAssistant()
  local links = {
    AU.GetActorLinks(m_nowActor, this:GetData("fci/actor/"))
  }
  local activeLinks = links[2]
  if #activeLinks == 0 then
    WU.ToggleRendering(REF.NodeEmptyAssistant, true)
    WU.ToggleRendering(REF.NodeScrollViewAssistant, false)
  else
    WU.ToggleRendering(REF.NodeEmptyAssistant, false)
    WU.ToggleRendering(REF.NodeScrollViewAssistant, true)
    m_kAssitants = activeLinks
    LU.Bind(REF.WrapContentAssistant, {
      updateRow = OnInitItemAssistant
    })
    LU.Set(REF.WrapContentAssistant, #m_kAssitants)
  end
end

function OnInitItemAssistant(goRef, wrapIndex, realIndex)
  if realIndex ~= nil and realIndex < #m_kAssitants then
    local itemIndex = realIndex + 1
    goRef["$$SetData"](m_kAssitants[itemIndex], m_nowActor)
  end
end

function SetViewDataOfTalent()
  local theSpecialTalent
  local allTalent = PB.all("ActorTalent")
  for k, v in pairs(allTalent) do
    if v.spectial == 1 and v.actorID == m_nowActorConfig.id then
      theSpecialTalent = v
    end
  end
  if theSpecialTalent == nil then
    REF.LabelTalentName.gameObject:SetActive(false)
    REF.LabelTalentDesc.gameObject:SetActive(false)
    REF.LabelTalentInfo.gameObject:SetActive(false)
    REF.ActorTalentIcon.gameObject:SetActive(true)
    REF.ActorTalentIcon.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_unknown"
    REF.LabelNoTalentTip.gameObject:SetActive(true)
    REF.LabelTalentName.gameObject:SetActive(false)
    REF.LabelTalentDesc.gameObject:SetActive(false)
    REF.LabelTalentInfo.gameObject:SetActive(false)
  else
    REF.LabelTalentName.gameObject:SetActive(true)
    REF.LabelTalentDesc.gameObject:SetActive(true)
    REF.LabelTalentInfo.gameObject:SetActive(true)
    REF.ActorTalentIcon.gameObject:SetActive(true)
    REF.LabelNoTalentTip.gameObject:SetActive(false)
    REF.LabelTalentName.gameObject:SetActive(true)
    REF.LabelTalentDesc.gameObject:SetActive(true)
    REF.LabelTalentInfo.gameObject:SetActive(true)
    REF.ActorTalentIcon.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. tostring(theSpecialTalent.talentIcon)
    REF.LabelTalentName.UILabel.text = WU.GetString("TalentName_" .. tostring(theSpecialTalent.id))
    REF.LabelTalentInfo.UILabel.text = WU.GetString("TalentDescribe_" .. tostring(theSpecialTalent.id))
  end
end

function SetViewDataOfActorSkin()
  local actor2skin = this:GetData("actor2skin")[m_nowActor.id] or {}
  LU.Bind(REF.WrapContentSkin, {
    dataSource = function(dataIndex)
      return actor2skin[dataIndex]
    end,
    updateSlot = UpdateSkinSlot
  })
  LU.Set(REF.WrapContentSkin, math.ceil(#actor2skin / #REF.WrapContentSkin[0].root))
end

function UpdateSkinSlot(ref, skinId)
  local unlocked = this:GetData("fci/unlockedSkins")[skinId]
  WU.SetActive(ref.SpriteLocked, not unlocked)
  local actorId = m_nowActor.id
  ref.WidgetIconSkin["$ResetState"]()
  if skinId ~= 0 then
    ref.WidgetIconSkin["$SetData"](skinId)
  else
    ref.WidgetIconSkin["$SetDefault"](actorId)
  end
  ref["@skinId"] = skinId
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  elseif m_dragDelta.x < -100 then
    if m_fromViewType == FromViewtype.From_CollectionsActor then
      SwitchActor(true)
    end
  elseif m_dragDelta.x > 100 then
    if m_fromViewType == FromViewtype.From_CollectionsActor then
      SwitchActor(false)
    end
  elseif math.abs(m_dragDelta.x) <= 30 and 30 >= math.abs(m_dragDelta.y) and m_nowActor.unlock then
    WU.AcquireWindowAsync("CollectionsActorPicture", function(window)
      _ENV["$"](window)["$$SetActor"](m_nowActorConfig)
    end)
  end
end

function OnSelectEvent()
end

function OnClickSkinBox(ref)
  local skinId = ref["@skinId"]
  local actorId = m_nowActor.id
  WU.AcquireWindowAsync("ItemDetail", function(ui)
    _ENV["$"](ui)["$$SetSkinId"](skinId, actorId)
  end)
end

function Focus(on)
  WU.RecordWindowFocus(1001367, on)
end
