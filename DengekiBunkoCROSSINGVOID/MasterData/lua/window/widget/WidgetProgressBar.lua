local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_expEffect
local m_width = 0
local m_sprite

function Start()
  if REF.SpriteExpAdd then
    m_sprite = REF.SpriteExpAdd
  end
  if m_sprite then
    m_width = m_sprite.UISprite.width
    if m_sprite.TweenFillAmount then
      CS.EventDelegate.Add(m_sprite.TweenFillAmount.onFinished, function()
        this:DelayInvokeInSeconds(0.3, function()
          REF.EffectExpAdd.gameObject:SetActive(false)
        end)
      end)
    end
  end
end

function Update()
  if m_expEffect and m_sprite then
    local posX = m_width * m_sprite.UISprite.fillAmount
    REF.EffectExpAdd.transform.localPosition = CS.UnityEngine.Vector3(posX, 0, 0)
  end
end

function AccountExp(currentLevel, exp)
  m_expEffect = false
  REF.LabelFront.UIHtmlLabel.text = WU.GetString("WindowAccount_CurrentExp")
  local resPlayerLevelInitConfig = PB.get("PlayerLevelInitConfig", currentLevel + 1)
  resPlayerLevelInitConfig = resPlayerLevelInitConfig or PB.get("PlayerLevelInitConfig", currentLevel)
  if not exp then
    local idx = string.find(REF.LabelBack.UIHtmlLabel.text, "/")
    exp = tonumber(string.sub(REF.LabelBack.UIHtmlLabel.text, 1, idx - 1))
  end
  local expLabel = exp .. "/" .. resPlayerLevelInitConfig.exp
  REF.LabelBack.UIHtmlLabel.text = expLabel
  REF["$UIProgressBar"].value = exp / tonumber(resPlayerLevelInitConfig.exp)
  REF.SpriteExpAddPredict.gameObject:SetActive(false)
  REF.SpriteExp.UISprite.width = 520
  REF.SpriteExpAdd.UISprite.width = 514
  if REF.FlagInAccount ~= nil then
    if 9 < #expLabel then
      REF.SpriteExp.UISprite.width = 420
      REF.SpriteExpAdd.UISprite.width = 414
    else
      REF.SpriteExp.UISprite.width = 450
      REF.SpriteExpAdd.UISprite.width = 444
    end
  end
end

function ActorLevelUpExp(actorInfo, targetLevel, totalFoodExp)
  m_expEffect = false
  local resActorLevelup = PB.get("ActorLevelup", actorInfo.level + 1)
  if not resActorLevelup then
    return
  end
  local upExp = tonumber(resActorLevelup.exp)
  local frontText = WU.GetString("Window_ActorLevelHint") .. "&nbsp;" .. actorInfo.level
  if targetLevel ~= actorInfo.level then
    frontText = frontText .. "&nbsp;<img src='Common.arrow_right' width=73% height=73%/>&nbsp;" .. targetLevel
  end
  frontText = "<l width=100%>" .. frontText .. "</l><font size=5>&nbsp;</font>"
  REF.LabelFront.UIHtmlLabel.text = frontText
  local curExp = tonumber(actorInfo.curExp)
  local overflow = true
  if totalFoodExp + curExp < resActorLevelup.exp then
    overflow = false
  end
  REF.SpriteExp.UISprite.width = 752
  REF.SpriteExpAdd.UISprite.width = 752
  REF.SpriteExpAddPredict.UISprite.width = 746
  local trans = REF.LabelBack.transform.localPosition
  REF.LabelBack.transform.localPosition = CS.UnityEngine.Vector3(746, trans.y, trans.z)
  LevelUpExpCommon(curExp, upExp, totalFoodExp, overflow)
end

function LevelUpExpCommon(curExp, upExp, totalFoodExp, overflow)
  m_expEffect = false
  REF["$UIProgressBar"].value = curExp / upExp
  if totalFoodExp == 0 then
    REF.SpriteExpAddPredict.gameObject:SetActive(false)
    REF.LabelBack.UIHtmlLabel.text = WU.GetString("Window_ActorLevelupExpFormatCur", curExp, upExp)
  else
    REF.SpriteExpAddPredict.gameObject:SetActive(true)
    if overflow then
      REF.SpriteExpAddPredict.UISprite.fillAmount = 1
    else
      REF.SpriteExpAddPredict.UISprite.fillAmount = (curExp + totalFoodExp) / upExp
    end
    REF.LabelBack.UIHtmlLabel.text = WU.GetString("Window_ActorLevelupExpFormatPredict", curExp, totalFoodExp, upExp)
  end
end

function EquipLevelUpExp(equip, targetLevel, totalFoodExp)
  m_expEffect = false
  local equipInfo = PB.get("EquipInfo", equip.id)
  if equipInfo then
    local equipEnhance = PB.get("EquipEnhance", equipInfo.quality, equip.level)
    local nextEquipEnhance = PB.get("EquipEnhance", equipInfo.quality, equip.level + 1)
    local frontText = WU.GetString("Window_ActorLevelHint") .. "&nbsp;" .. equip.level
    if targetLevel ~= equip.level then
      frontText = frontText .. "&nbsp;<img src='Common.arrow_right' width=73% height=73%/>&nbsp;" .. targetLevel
    end
    frontText = "<l width=100%>" .. frontText .. "</l><font size=5>&nbsp;</font>"
    REF.LabelFront.UIHtmlLabel.text = frontText
    if not nextEquipEnhance then
      REF.LabelBack.UIHtmlLabel.text = WU.GetString("Window_EquipLevelMax")
      REF.SpriteExpAddPredict.UISprite.fillAmount = 0
      REF.SpriteExpAdd.UISprite.fillAmount = 1
    else
      LevelUpExpCommon(equip.curExp, equipEnhance.levelUpExp, totalFoodExp)
    end
  end
end

function BalanceExp(fromFillAmount, toFillAmount, isLevelup, levelData)
  m_expEffect = true
  REF.LabelPlayerLevel.UILabel.text = WU.GetString("Window_Level", levelData.fromLv)
  if m_sprite ~= nil then
    m_sprite.TweenFillAmount.from = fromFillAmount
    if isLevelup then
      m_sprite.TweenFillAmount.to = 1
    else
      m_sprite.TweenFillAmount.to = toFillAmount
    end
    CS.EventDelegate.Add(m_sprite.TweenFillAmount.onFinished, function()
      if isLevelup then
        REF.LabelPlayerLevel.UILabel.text = WU.GetString("Window_Level", levelData.toLv)
        WU.ShowPlayerLevelupResult(levelData.fromLv, levelData.toLv)
        this:DelayInvokeInSeconds(1, function()
          isLevelup = false
          m_sprite.TweenFillAmount.from = 0
          m_sprite.TweenFillAmount.to = toFillAmount
          m_sprite.TweenFillAmount:ResetToBeginning()
          m_sprite.TweenFillAmount:PlayForward()
        end)
      end
    end)
  end
end
