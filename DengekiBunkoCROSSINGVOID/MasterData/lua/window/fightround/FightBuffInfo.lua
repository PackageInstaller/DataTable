local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local FightHelper = require("Common/FightHelper")
local m_subWeapon, m_buffList, m_mergeList, m_dataCount

function Awake()
  REF.BuffContent.ReuseTable.onInitializeItem = OnInitializeItem
  REF.BuffContent.ReuseTable.onGetChildWidget = OnGetChildWidget
end

function RefreshBuffDetail(subRoundActorInfo, buffList, mergeList, uniqueId)
  m_buffList = buffList
  m_mergeList = mergeList
  m_dataCount = #buffList
  m_subWeapon = nil
  if subRoundActorInfo then
    local actorInfo = subRoundActorInfo.actorInfo
    if actorInfo.uniqueWeaponId and actorInfo.uniqueWeaponId > 0 then
      m_subWeapon = {
        id = actorInfo.uniqueWeaponId,
        phase = actorInfo.uniqueWeaponPhase,
        skin = actorInfo.uniqueWeaponSkin or 0
      }
      m_dataCount = m_dataCount + 1
    end
  end
  REF.BuffContent.ReuseTable:ResetPosition(true)
  REF.BuffContent.ReuseTable:SetDataCount(m_dataCount)
end

function OnInitializeItem(go, wrapIndex, realIndex)
  local index = realIndex + 1
  if 0 < index and index <= m_dataCount then
    local ref = _ENV["$"](go)
    WU.SetActive(ref.Buff, not m_subWeapon or index ~= 1)
    WU.SetActive(ref.SubWeapon, m_subWeapon and index == 1)
    if m_subWeapon and index == 1 then
      DisplayAsWeapon(ref, m_subWeapon)
    else
      local buffInfo = m_buffList[index]
      if m_subWeapon then
        buffInfo = m_buffList[index - 1]
      end
      DisplayAsBuff(ref, buffInfo)
    end
  end
end

function DisplayAsWeapon(ref, data)
  if ref and data then
    local uniqueWeaponSkill = PB.get("UniqueWeaponSkill", data.id or 0, data.phase or 1)
    if uniqueWeaponSkill then
      ref["@type"] = "weapon"
      ref.WeaponHead.UITexture.mainTexturePath = "Texture/FightImpressionHead/FightBuffImpressionHead/buff_impression_head_" .. uniqueWeaponSkill.id .. "_" .. data.skin
      ref.WeaponTitle.UILabel.text = WU.GetString("UniqueWeaponName_" .. uniqueWeaponSkill.id)
      local describe = WU.GetString("UniqueWeaponSkill_" .. uniqueWeaponSkill.id)
      for i = 1, #uniqueWeaponSkill.specials do
        local special = uniqueWeaponSkill.specials[i]
        local specialIndex = special.index
        if 0 < specialIndex then
          local effect = SE.GetSpecialEffect(specialIndex, data.phase or 1)
          describe = describe .. WU.FormatString(TU.render(WU.GetString("UniqueWeaponSpecial_" .. specialIndex), effect), "#72e6ff", "#ff8888")
        end
      end
      ref.WeaponDescribe.UIHtmlLabel.text = "<br/><br/>" .. describe
    else
      warning("GamePlay", "missing UniqueWeaponSkill.xlsx id " .. tostring(data.id) .. " , phase : " .. tostring(data.phase))
    end
  end
end

function DisplayAsBuff(ref, data)
  if ref and data then
    ref["@type"] = "buff"
    local buffData = PB.get("BuffData", data.buffKey.id, data.buffKey.owner)
    ref.Icon.UISprite.spriteName = buffData.iconName
    ref.Name.UILabel.text = buffData.intro
    local round = WU.GetString("Buff_Desc_Infinite")
    if data.round >= 0 then
      round = tostring(data.round)
    end
    ref.Round.UILabel.text = round
    local source = ""
    if 0 < data.sourceId then
      source = WU.GetString("ActorName_" .. data.sourceId)
    elseif 0 > data.sourceId then
      source = WU.GetString("UniqueWeaponName_" .. math.abs(data.sourceId))
    end
    ref.Source.UILabel.text = source
    local mergeStr = ""
    for i = 1, #data.mergeList do
      local id = data.mergeList[i].id
      local owner = data.mergeList[i].owner
      if m_mergeList ~= nil then
        for j = 1, #m_mergeList do
          local mergeBuff = m_mergeList[j]
          if mergeBuff.buffKey.id == id and mergeBuff.buffKey.owner == owner then
            local mergeBuffData = PB.get("BuffData", id, owner)
            mergeStr = mergeStr .. "\239\188\140" .. FightHelper.getBuffDescribe(mergeBuffData, mergeBuff.val, mergeBuff.rate, mergeBuff.level)
          end
        end
      end
    end
    local stackStr = ""
    if 1 < buffData.maxStack then
      stackStr = WU.GetString("Buff_Desc_Stack", data.stack)
    end
    ref.BuffDescribe.UIHtmlLabel.text = "<br/><br/>" .. FightHelper.getBuffDescribe(buffData, data.val, data.rate, data.level) .. mergeStr .. stackStr
  end
end

function OnGetChildWidget(transform)
  local ref = _ENV["$"](transform)
  if ref["@type"] == "weapon" then
    return ref.WeaponDescribe.UIHtmlLabel
  else
    return ref.BuffDescribe.UIHtmlLabel
  end
end
