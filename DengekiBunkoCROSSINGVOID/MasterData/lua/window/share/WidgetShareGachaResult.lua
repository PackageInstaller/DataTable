local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_showNum
local m_QToColor = {
  [1] = "green",
  [2] = "blue",
  [3] = "purple",
  [4] = "orange"
}

function Start()
  WU.SetActive(REF.ButtonSwitchActor, false)
end

function OnEnable()
  this:Bind("Share/SelectedActors", OnSelectedChange)
end

function OnDisable()
  this:Unbind("Share/SelectedActors", OnSelectedChange)
end

function SetShareInfo(shareInfo)
  local gachaType
  if shareInfo.gachaId == PB.enum.GachaId.Normal then
    gachaType = WU.GetString("WindowGacha_Mode1")
  elseif shareInfo.gachaId == PB.enum.GachaId.Periodic then
    gachaType = WU.GetString("WindowGacha_Mode2Rename")
  end
  local gachaContent
  if shareInfo.gachaId == PB.enum.GachaId.Chips then
    gachaContent = WU.GetString("WindowGacha_ShareCostChips", shareInfo.costCount)
  else
    gachaContent = WU.GetString("WindowGacha_ShareTypeAndCount", gachaType, shareInfo.gachaCount)
  end
  m_showNum = shareInfo.count
  REF.LabelType.UIHtmlLabel.text = gachaContent
  REF.TableType.UITable:Reposition()
  local actorList = shareInfo.actorList
  local actorNum = #actorList
  local bestList = _ENV["!"]({})
  local lastQuality, lastQualityBeginIndex
  for i = 1, m_showNum do
    table.insert(bestList, actorList[i])
    if actorList[i].quality ~= lastQuality then
      lastQuality = actorList[i].quality
      lastQualityBeginIndex = i
    end
  end
  local selectIndex = m_showNum + 1
  if actorNum >= selectIndex and actorList[selectIndex].quality == lastQuality then
    local testIndex = lastQualityBeginIndex
    while testIndex <= m_showNum do
      local _, k = table.find(bestList, function(i, v)
        return i < testIndex and v.id == bestList[testIndex].id
      end)
      if k then
        table.remove(bestList, testIndex)
        local newSelectActor = actorList[selectIndex]
        table.insert(bestList, newSelectActor)
        selectIndex = selectIndex + 1
        if actorNum < selectIndex or lastQuality ~= actorList[selectIndex].quality then
          goto lbl_115
        end
      else
        testIndex = testIndex + 1
      end
    end
  end
  ::lbl_115::
  local resortList = {
    [1] = bestList[5],
    [2] = bestList[3],
    [3] = bestList[1],
    [4] = bestList[2],
    [5] = bestList[4],
    [6] = bestList[6]
  }
  DB:SetData("Share/SelectedActors", resortList)
end

function OnSelectedChange(actors)
  if actors == nil or m_showNum == nil then
    return
  end
  for i = 1, #REF.ListActors do
    local actorConfig = actors[i].config
    local ref = REF.ListActors[i - 1]
    ref.TextureRole.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. actorConfig.animRes
    local offPos = {
      x = actorConfig.shareGachaResultOffsetX,
      y = 0,
      z = 0
    }
    if i <= m_showNum / 2 then
      ref.TextureRoleContainer.transform.localPosition = CS.UnityEngine.Vector3(offPos.x, offPos.y, 0)
      ref.TextureRoleContainer.UIPanel.clipOffset = {
        x = -offPos.x,
        y = -offPos.y
      }
    else
      ref.TextureRoleContainer.transform.localPosition = CS.UnityEngine.Vector3(offPos.x + 30, offPos.y, 0)
      ref.TextureRoleContainer.UIPanel.clipOffset = {
        x = -offPos.x - 30,
        y = -offPos.y
      }
    end
    local BGColor = m_QToColor[actors[i].quality]
    local BGIndex = fif(i <= m_showNum / 2, i, m_showNum - i + 1)
    ref.TextureBG.UITexture.mainTexturePath = "Texture/Share/actor_" .. BGColor .. "_" .. tostring(BGIndex)
    ref.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
    ref.SpriteActorName.UISprite:MakePixelPerfect()
    ref.SpriteActorName.transform.localScale = {
      x = 1.1,
      y = 1.1,
      z = 1
    }
    ref.SpriteActorType.UISprite.spriteName = "actor_type_" .. tostring(actors[i].id)
    ref.SpriteSubBG.gameObject:SetActive(actorConfig.kind == 2)
    ref.SpriteSub.gameObject:SetActive(actorConfig.kind == 2)
  end
  REF.root.gameObject:SetActive(true)
end
