local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local ACU = require("Common/ActivityUtil")
local m_NoviceGiftInfo
local m_bigItem = {}
local m_bigTime = 1.5
local m_activityId

function Start()
  WU.TraverseChildren(REF.ItemContents, function(go, i)
    local trueIndex = i + 1
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref["$"], function()
      OnClickReward(trueIndex)
    end)
  end)
  local prize = PB.all("NewPlayerSignReward")
  for i = 1, #prize do
    if prize[i].isBig then
      table.insert(m_bigItem, prize[i].day)
    end
  end
  SetRewardPosition()
  SetRewardInfo()
end

function OnEnable()
  SetInfo()
end

function SetInfo()
  if m_activityId == nil then
    local config = PB.all("WelfareConfig")
    local welfareId = table.find(config, function(_, v)
      return v.relatedActivityType == PB.enum.ActivityType.NewPlayerSignIn
    end)
    m_activityId = config[welfareId].relatedActivityIds[1]
  end
  this:GameRequest(string.format("fci/NewPlayerSignIn/%d/", m_activityId)):Get(function(result)
    this:SetData("fci/NewPlayerSignIn/", result.signInfo)
    local redPointData = this:GetData("fci/redpoint/data")
    local data = redPointData.newPlayerSignIn
    if data then
      data.rewardDays = result.signInfo.rewardDays
      data.signDays = result.signInfo.signDays
    end
    m_NoviceGiftInfo = result.signInfo
    SetSakuPosition()
    SetPrizeState()
    REF.EndTime.UILabel.text = WU.RenderTime2(result.signInfo.endTime, nil, nil, nil, true)
  end)
end

function OnClickReward(index)
  local playerSignInfo = this:GetData("fci/NewPlayerSignIn/")
  if index > playerSignInfo.rewardDays and index <= playerSignInfo.signDays then
    this:GameRequest("fci/NewPlayerSignInReward/"):Post({activityId = m_activityId}, function(result)
      DBH.ResChange(result.resChange)
      WU.ShowRewards(result.resChange)
      SetInfo()
    end)
  else
    local reward = PB.all("NewPlayerSignReward")[index].reward[1]
    if reward.type == PB.enum.ResourceType.ResActor then
      local actors = this:GetData("Collections/Actors")
      if actors ~= nil then
        do
          local _, dataCombined = table.find(actors, function(k, v)
            return v.id == reward.id
          end)
          if dataCombined then
            WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
              _ENV["$"](w)["$$SetViewFrom"](1)
              _ENV["$"](w)["$$SetSortedActorList"](actors)
              _ENV["$"](w)["$$SetActor"](dataCombined, false)
            end)
          end
        end
      end
    else
      WU.ShowResourceDetail(reward.type, reward.id)
    end
  end
end

function SetRewardPosition()
  local rewardList = PB.all("NewPlayerSignReward")
  if #rewardList > #REF.ItemContents then
    warning("WlfViewNoviceGift", "\233\133\141\231\189\174\231\154\132\229\165\150\229\138\177\230\149\176\233\135\143\229\164\170\229\164\154\228\186\134")
  end
  local length = REF.RightPosMark.transform.localPosition.x - REF.LeftPosMark.transform.localPosition.x
  local tempTarget = REF.ItemContents[0].BGIconItem
  local normalHalfWidth = tempTarget.transform.localScale.x * tempTarget.UISprite.width / 2
  local bigHalfHeight = tempTarget.transform.localScale.y * tempTarget.UISprite.height * (math.max(m_bigTime, 1) - 1) / 2
  local isHeadBig = table.find(m_bigItem, function(_, v)
    return v == 1
  end) ~= nil
  local isTailBig = table.find(m_bigItem, function(_, v)
    return v == #rewardList
  end) ~= nil
  local bigHalfWidth = normalHalfWidth * m_bigTime
  local widthDiff = bigHalfWidth - normalHalfWidth
  local headTailAdd = fif(isHeadBig, bigHalfWidth - widthDiff, normalHalfWidth) + fif(isTailBig, bigHalfWidth - widthDiff, normalHalfWidth)
  local itemLength = (widthDiff * #m_bigItem + normalHalfWidth * #rewardList) * 2 - headTailAdd
  local peerSpace = math.max(length - itemLength, 0) / (#rewardList - 1)
  local tempPos = fif(isHeadBig, widthDiff, 0)
  WU.TraverseChildren(REF.ItemContents, function(go, i)
    local ref = _ENV["$"](go)
    local trueIndex = i + 1
    if rewardList[trueIndex] == nil then
      WU.SetActive(ref["$"], false)
      return
    end
    local isBig = table.find(m_bigItem, function(_, v)
      return v == trueIndex
    end) ~= nil
    local newScale = fif(isBig, {
      x = m_bigTime,
      y = m_bigTime,
      z = 1
    }, {
      x = 1,
      y = 1,
      z = 1
    })
    tempPos = tempPos + fif(isBig, bigHalfWidth, normalHalfWidth) * fif(trueIndex == 1, 0, 1)
    ref.root.transform.localPosition = {
      x = tempPos,
      y = fif(isBig, bigHalfHeight, 0),
      z = 0
    }
    ref.root.transform.localScale = newScale
    ref["$TweenScale"].from = ref.root.transform.localScale
    ref["$TweenScale"].to = {
      x = newScale.x * 1.05,
      y = newScale.y * 1.05,
      z = 1
    }
    ref.Effect.transform.localScale = fif(isBig, {
      x = 0.64,
      y = 0.64,
      z = 1
    }, {
      x = 0.39,
      y = 0.39,
      z = 1
    })
    tempPos = tempPos + fif(isBig, bigHalfWidth, normalHalfWidth) + peerSpace
  end)
end

function SetRewardInfo()
  local prizeList = PB.all("NewPlayerSignReward")
  for i = 1, #REF.ItemContents do
    local curPrize = prizeList[i]
    if curPrize == nil then
      break
    end
    local refItem = REF.ItemContents[i - 1]
    local id = prizeList[i].reward[1].id
    local type = prizeList[i].reward[1].type
    local count = prizeList[i].reward[1].count
    if type ~= PB.enum.ResourceType.ResActor then
      local texturePath
      local qualityBg = "icon_bg_0"
      if type == PB.enum.ResourceType.ResItem then
        local itemInfo = PB.get("ItemInfo", id)
        if itemInfo then
          local textureName = itemInfo.icon
          local resIcon = ACU.ReplaceIconRes(id)
          if resIcon ~= nil and resIcon ~= "" then
            textureName = resIcon
          end
          texturePath = "Texture/ItemIcon/" .. textureName
          qualityBg = "icon_bg_" .. tostring(itemInfo.quality)
        end
      elseif type == PB.enum.ResourceType.ResEquip then
        local equipInfo = PB.get("EquipInfo", id)
        if equipInfo then
          texturePath = "Texture/EquipIcon/" .. equipInfo.icon
          qualityBg = "icon_bg_" .. tostring(equipInfo.quality)
        end
      elseif type == PB.enum.ResourceType.ResActor then
        local actorConfig = PB.all("ActorConfig")
        local _, v = table.find(actorConfig, function(k, v)
          return v.id == id
        end)
        texturePath = "Texture/ActorHeadRectangle/" .. "actor_head_" .. v.animRes
      elseif type == PB.enum.ResourceType.ResPlayerPower then
        texturePath = "Texture/ItemIcon/ResPlayerPower_0"
        qualityBg = "icon_bg_" .. tostring(PB.get("ResourceQuality", type).quality)
      elseif type == PB.enum.ResourceType.ResPlayerGold then
        texturePath = "Texture/ItemIcon/ResPlayerGold_0"
        qualityBg = "icon_bg_" .. tostring(PB.get("ResourceQuality", type).quality)
      elseif type == PB.enum.ResourceType.ResPlayerMoney then
        texturePath = "Texture/ItemIcon/ResPlayerMoney_0"
        qualityBg = "icon_bg_" .. tostring(PB.get("ResourceQuality", type).quality)
      end
      WU.SetActive(refItem.SpriteIcon, false)
      refItem.IconItem.UITexture.mainTexturePath = texturePath
      refItem.BGIconItem.UISprite.spriteName = qualityBg
    else
      WU.SetActive(refItem.SpriteIcon, true)
      refItem.SpriteIcon.UISprite.spriteName = "actor_head_1011a"
      refItem.BGIconItem.UISprite.spriteName = "role_bg_3"
    end
    refItem.IconDayNumber.UISprite.spriteName = "day_" .. tostring(i)
    refItem.LabelItemcount.UILabel.text = count
  end
end

function SetSakuPosition()
  REF.IconSignDayRemminder.UISprite.spriteName = "enter_" .. tostring(m_NoviceGiftInfo.signDays)
  local sakuPos = {}
  local maxLoginDayNum = #PB.all("NewPlayerSignReward")
  local realSignDays = math.min(m_NoviceGiftInfo.signDays, maxLoginDayNum)
  local itemRef = REF.ItemContents[realSignDays - 1]
  local isBig = table.find(m_bigItem, function(_, v)
    return v == m_NoviceGiftInfo.signDays
  end) ~= nil
  sakuPos.x = itemRef.root.transform.localPosition.x
  sakuPos.y = itemRef.BGIconItem.transform.localScale.y * itemRef.BGIconItem.UISprite.height / 2 * fif(isBig, m_bigTime, 1) + itemRef.root.transform.localPosition.y + 50
  sakuPos.z = 0
  REF.ProgressIndicatorSaku.transform.localPosition = sakuPos
end

function SetPrizeState()
  WU.TraverseChildren(REF.ItemContents, function(go, i)
    local ref = _ENV["$"](go)
    local trueIndex = i + 1
    if trueIndex > m_NoviceGiftInfo.signDays then
      ref.IconHasClaimed.gameObject:SetActive(false)
      ref["$"].TweenScale.enabled = false
      ref.Effect.gameObject:SetActive(false)
    elseif trueIndex > m_NoviceGiftInfo.rewardDays then
      ref.IconHasClaimed.gameObject:SetActive(false)
      ref["$"].TweenScale.enabled = true
      ref.Effect.gameObject:SetActive(true)
    else
      ref.IconHasClaimed.gameObject:SetActive(true)
      ref["$"].TweenScale.enabled = false
      ref.Effect.gameObject:SetActive(false)
    end
  end)
end
