local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local EU = require("Common/EquipUtil")
local m_firstIn = true
local m_curArm, m_curAttr
local m_curIdx = 1
local m_materialUsed = {}
local m_enhanceInfo
local m_itemEnough = true
local m_moneyEnough = true
local m_materialUsedSpr = {}
local m_enhanceInfoSpr
local m_itemEnoughSpr = true
local m_moneyEnoughSpr = true
local m_materialsSpr = {}
local m_attrTip = ""
local m_attrMaxGot = false
local m_sprMaxGot = false
local m_finalAttrLv
local m_porSetting = PB.enum.WeaponPicSituationType.Enhance

function SetupWindow()
  ManageButtonEvents()
end

function InitWindow()
  m_firstIn = true
  SetTutorial()
  this:RegisterGameEvent("ArmEnhance/CurAttrChange", ChangeCurAttr)
  this:RegisterGameEvent("Resource/ResourceChange", ChangeCurAttr)
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if REF.TabSpiritUpgrade.UIToggle.value then
        UpdateMaterialSpr()
      end
    end)
  end)
end

function UnInitWindow()
end

function SetContent(content)
  this:Bind("fci/arms/" .. content.id, function(result)
    if result == nil then
      return
    end
    m_curArm = result
    m_finalAttrLv = m_curArm.finalAttrLv
    if m_firstIn then
      m_curAttr = m_curArm.baseAttrs[1]
      m_curIdx = 1
    else
      local at = this:GetData("ArmEnhance/CurAttr")
      local idx, atNow = table.find(m_curArm.baseAttrs, function(k, v)
        return v.attrId == at.attrId
      end)
      m_curAttr = atNow
      m_curIdx = idx
    end
    UpdateData()
    WU.ModifyWeaponPortrait(REF.TextureArm, m_curArm.id, m_porSetting, this.name, m_curArm.cardSkinIndex)
    WU.ModifyWeaponName(REF.Left, m_curArm.id, 0.8, m_curArm.quality - 2, true)
    for i = 0, #REF.NodeArmStar - 1 do
      local slotRef = REF.NodeArmStar[i]
      slotRef.root.UISprite.spriteName = "impression_star_m" .. fif(m_curArm.phase < i + 1, "_dark", "")
    end
  end)
end

function Focus(on)
  UpdateData()
end

function UpdateData()
  if m_curArm == nil then
    return
  end
  UpdateMaterial()
  UpdateAttrs()
  UpdateMaterialSpr()
  UpdateAttrsSpr()
end

function UpdateAttrs()
  if m_curArm == nil then
    return
  end
  WU.TraverseChildren(REF.GridAttrs, function(go, index)
    local root = _ENV["$"](go).root
    local ref = _ENV["$"](go)
    if root.gameObject.name ~= "AttrLine" then
      return
    end
    local attrInfo = m_curArm.baseAttrs[index + 1]
    if m_firstIn and index + 1 == 1 then
      m_curAttr = attrInfo
      m_firstIn = false
    end
    if attrInfo and not attrInfo.special then
      WU.ClearButtonEvent(root)
      WU.BindButtonEvent(root, function()
        ChangeCurAttr(attrInfo)
      end)
      ref.SpriteHighlight.gameObject:SetActive(m_curAttr == attrInfo)
      if m_curAttr == attrInfo then
        m_curIdx = index + 1
      end
      WU.SetLabel(ref.LabelType, WU.GetString("Window_ActorAttrName_" .. attrInfo.attr.type))
      WU.SetLabel(ref.LabelValue, attrInfo.attr.value)
      WU.SetLabel(ref.LabelAttrLevel, attrInfo.level)
      root.gameObject:SetActive(true)
    else
      root.gameObject:SetActive(false)
    end
  end)
end

function UpdateAttrsSpr()
  if m_curArm == nil then
    return
  end
  WU.TraverseChildren(REF.GridAttrsSpr, function(go, index)
    local root = _ENV["$"](go).root
    local ref = _ENV["$"](go)
    if root.gameObject.name ~= "AttrLineSpr" then
      return
    end
    local attrInfo = m_curArm.speAttr[index + 1]
    if attrInfo then
      if m_curAttr == attrInfo then
        m_curIdx = index + 1
      end
      local nextAttr = WU.GetArmAttrById(attrInfo, attrInfo.level + 1)
      ref.SpriteTypeSpr.UISprite.spriteName = "attr_type_" .. attrInfo.attr.type
      WU.SetLabel(ref.LabelTypeSpr, WU.GetString("Window_ActorAttrName_" .. attrInfo.attr.type))
      WU.SetLabel(ref.LabelValueSpr, attrInfo.attr.value)
      if nextAttr then
        WU.SetLabel(ref.LabelNextValueSpr, U.FormatAttrValue(nextAttr))
      end
      ref.LabelNextValueSpr.gameObject:SetActive(not m_sprMaxGot)
      ref.SpriteNextSpr.gameObject:SetActive(not m_sprMaxGot)
      root.gameObject:SetActive(true)
    else
      root.gameObject:SetActive(false)
    end
  end)
end

function ChangeCurAttr(attr, info)
  if m_curAttr == attr then
    return
  end
  local idx
  idx, m_curAttr = table.find(m_curArm.baseAttrs, function(k, v)
    return v.attrId == attr.attrId
  end)
  UpdateAttrs()
  UpdateMaterial()
end

function UpdateMaterial()
  m_attrMaxGot = m_curAttr.level >= m_curArm.maxAttrLevel
  WU.SetLabel(REF.LabelCost, WU.GetString("UniqueWeapon_MaxAttrLevelGet"))
  this:SetData("ArmEnhance/CurAttr", m_curAttr)
  WU.SetLabel(REF.LabelTypeCur, WU.GetString("Window_ActorAttrName_" .. m_curAttr.attr.type))
  WU.SetLabel(REF.LabelAttrValueCur, m_curAttr.attr.value)
  WU.SetLabel(REF.LabelAttrLevelCur, m_curAttr.level)
  WU.SetLabel(REF.LabelLevel, "Lv. " .. m_curArm.level)
  WU.SetLabel(REF.LabelCultivation, WU.GetString("Sort_ActorCultivation") .. ": " .. m_curArm.cultivation)
  m_enhanceInfo = {}
  m_materialUsed = {}
  local preLevel = math.min(m_finalAttrLv, m_curAttr.level + 1)
  local materials, materialRe = WU.CaculateArmAttrEnhance(m_curAttr, preLevel)
  m_moneyEnough, m_itemEnough = ManageMaterial(REF.MaterialGrid, materials, materialRe, m_materialUsed, "LabelCount", REF.LabelCost)
  m_enhanceInfo = {
    targetLv = preLevel,
    foodRes = m_materialUsed,
    attrId = m_curAttr.attrId,
    uniqueWeaponId = m_curArm.id
  }
  REF.MaterialGrid.UIGrid:Reposition()
  if m_curAttr.level < m_finalAttrLv then
    REF.NodeNext.gameObject:SetActive(true)
    REF.TextureMax.gameObject:SetActive(false)
    local nextAttr = WU.GetArmAttrById(m_curAttr, m_curAttr.level + 1)
    WU.SetLabel(REF.LabelAttrLevelNext, preLevel)
    WU.SetLabel(REF.LabelAttrValueNext, U.FormatAttrValue(nextAttr))
    REF.LabelAttrValueCur.transform.localPosition = CS.UnityEngine.Vector3(-24, -28, 0)
  else
    REF.NodeNext.gameObject:SetActive(false)
    REF.LabelCost.gameObject:SetActive(true)
    REF.TextureMax.gameObject:SetActive(true)
    REF.LabelAttrValueCur.transform.localPosition = CS.UnityEngine.Vector3(-134, -28, 0)
    WU.SetLabel(REF.LabelCost, WU.GetString("UniqueWeapon_MaxAttrLevelGet"))
  end
end

function UpdateMaterialSpr()
  m_enhanceInfoSpr = {}
  m_materialUsedSpr = {}
  m_sprMaxGot = m_curArm.speAttr[1].level >= m_curArm.maxSpeAttrLevel
  WU.SetActive(REF.LabelArmNextLevel, not m_sprMaxGot)
  REF.TextureMaxSpr.gameObject:SetActive(m_sprMaxGot)
  REF.LabelArmLevel.gameObject.transform.localPosition = CS.UnityEngine.Vector3(fif(m_sprMaxGot, -161, -94), -3, 0)
  local preLevel = math.min(m_curArm.speAttr[1].level + 1, m_curArm.maxSpeAttrLevel)
  local sprRe
  m_materialsSpr, sprRe = WU.CaculateArmAttrEnhance(m_curArm.speAttr[1], preLevel)
  m_moneyEnoughSpr, m_itemEnoughSpr = ManageMaterial(REF.MaterialGridSpr, m_materialsSpr, sprRe, m_materialUsedSpr, "LabelCountSpr", REF.LabelCostSpr)
  m_enhanceInfoSpr = {
    targetLv = preLevel,
    foodRes = m_materialUsedSpr,
    uniqueWeaponId = m_curArm.id
  }
  WU.SetLabel(REF.LabelArmLevel, fif(m_sprMaxGot, WU.GetString("UniqueWeapon_SpiritMaxGet"), "") .. m_curArm.speAttr[1].level)
  WU.SetLabel(REF.LabelArmNextLevel, m_curArm.speAttr[1].level + 1)
  REF.MaterialGridSpr.UIGrid:Reposition()
end

function ManageMaterial(ref, materials, materialResource, materialUsed, labelPrefix, labelCost)
  if materials == nil then
    return
  end
  local moneyEnough = true
  local itemEnough = true
  WU.TraverseChildren(ref, function(go, index)
    local gasket = _ENV["$"](go).root
    local info = materials[U.ToInt(index + 1)]
    if info then
      local cnt = 0
      local item = this:GetData("fci/item/" .. info.id)
      if item then
        cnt = item.count
      end
      if cnt < info.count then
        itemEnough = false
      else
        table.insert(materialUsed, info)
      end
      _ENV["$"](go).material["$SetData"](info.type, info.id, info.count)
      local color = fif(cnt >= info.count, "#295085", "#ec3b3e")
      gasket.gameObject:SetActive(true)
      WU.SetLabel(_ENV["$"](go).LabelCount, AddColor(cnt, color) .. "/" .. info.count)
    else
      gasket.gameObject:SetActive(false)
    end
  end)
  local show = materialResource ~= nil and 0 < #materialResource
  labelCost.gameObject:SetActive(show and not REF.TabSpiritUpgrade.UIToggle.value)
  if show then
    local re = materialResource[1]
    local reCnt = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[re.type] .. "_" .. re.id)
    if reCnt < re.count then
      moneyEnough = false
    else
      table.insert(materialUsed, re)
    end
    local color = fif(moneyEnough, "#295085", "#ec3b3e")
    if m_attrMaxGot then
      local starStr = ""
      for i = 1, m_curArm.phase + 1 do
        starStr = starStr .. "<img src='ActorRelation.impression_star_m' height = 65%  width = 65%/>"
      end
      m_attrTip = WU.GetString("UniqueWeapon_UpdateToPhase") .. starStr
      WU.SetLabel(REF.LabelCost, AddColor(WU.GetString("UniqueWeapon_UpdateToPhase"), "#ec3b3e") .. starStr)
    else
      WU.SetLabel(REF.LabelCost, GetResIcon_sString(re.type, re.id) .. AddColor(re.count, color))
    end
  end
  return moneyEnough, itemEnough
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonClear, function()
    WU.AcquireWindowAsync("ArmEnhanceMaterial", function(window)
      _ENV["$"](window)["$$SetContent"](m_curArm.id, m_curIdx)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonFurnace, function()
  end)
  WU.BindButtonEvent(REF.ButtonEnhance, function()
    if m_enhanceInfo.targetLv > m_curArm.maxAttrLevel or m_curAttr.level >= m_curArm.maxAttrLevel then
      if m_curAttr.level >= m_finalAttrLv then
        WU.ShowHintText(WU.GetString("UniqueWeapon_MaxAttrLevelGet"))
      else
        WU.ShowHintText(m_attrTip)
      end
      return
    elseif not m_moneyEnough then
      WU.ShowHintText(WU.GetString("UniqueWeapon_MoneyNotEnough"))
      return
    elseif not m_itemEnough then
      WU.ShowHintText(WU.GetString("UniqueWeapon_ItemNotEnough"))
      return
    end
    this:GameRequest("fci/unique-weapon-attr/enhance/"):Post(m_enhanceInfo, function(resp)
      DBH.ResChange(resp.resChange)
      REF.LevelUpEffect.transform.localPosition = REF.GridAttrs[m_curIdx - 1]["$transform"].localPosition
      REF.LevelUpEffect.EffectGenerator:Play()
      this:SetData("ActorInfo/CurrentActor", this:GetData("ActorInfo/CurrentActor"))
      this:SetData("Actor/SelectedUid", this:GetData("Actor/SelectedUid"))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonUpgradeSpr, function()
    if m_enhanceInfoSpr.targetLv > m_curArm.maxSpeAttrLevel or m_sprMaxGot then
      WU.ShowHintText(WU.GetString("UniqueWeapon_MaxAttrLevelGet"))
      return
    elseif not m_moneyEnoughSpr then
      WU.ShowHintText(WU.GetString("UniqueWeapon_MoneyNotEnough"))
      return
    elseif not m_itemEnoughSpr then
      WU.ShowHintText(WU.GetString("UniqueWeapon_ItemNotEnough"))
      return
    end
    this:GameRequest("fci/unique-weapon/enhance/"):Post(m_enhanceInfoSpr, function(resp)
      DBH.ResChange(resp.resChange)
      this:SetData("ActorInfo/CurrentActor", this:GetData("ActorInfo/CurrentActor"))
      WU.TraverseChildren(REF.GridAttrsSpr, function(go, index)
        local effectPar = _ENV["$"](_ENV["$"](go).LevelUpEffectSpr)
        effectPar.root.transform.localScale = CS.UnityEngine.Vector3(2.08, 1.8, 1)
        effectPar.effect.EffectGenerator:Play()
      end)
    end)
  end)
end

function GetResIcon_sString(type, id)
  if type == PB.enum.ResourceType.ResPlayerPayMoney then
    return "<img src='ResIcon_s.ResPlayerPayMoney_0'/>"
  elseif type == PB.enum.ResourceType.ResPlayerMoney then
    return "<img src='ResIcon_s.ResPlayerMoney_0'/>"
  elseif type == PB.enum.ResourceType.ResPlayerGold then
    return "<img src='ResIcon_s.ResPlayerGold_0'/>"
  else
    return "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[type] .. "_" .. id .. "'/>"
  end
end

function AddColor(str, color)
  return "<font color=" .. color .. ">" .. str .. "</font>"
end

function SetTutorial()
  WU.ActiveByNeverClick(REF.ArmEnhanceTip_ArmEnhance)
  this:DelayInvokeInSeconds(5, function()
    WU.SetClickB4(REF.ArmEnhanceTip_ArmEnhance)
  end)
end
