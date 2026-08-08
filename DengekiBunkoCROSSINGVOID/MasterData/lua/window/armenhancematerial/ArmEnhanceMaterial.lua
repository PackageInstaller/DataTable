local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local DBH = require("Manager/DataBindingHandler")
local m_curArm, m_curAttr, m_curIdx
local m_materials = {}
local m_materialUsed = {}
local m_curLevel = 1
local m_preLevel = 1
local m_preAttr, m_pressTime
local m_pressingAdd = false
local m_pressingMinus = false
local m_moneyEnough = true
local m_itemEnough = true
local m_interval = 0.3

function SetupWindow()
  ManageButtonEvent()
end

function UpdateWindow(deltaTime)
  m_pressTime = m_pressTime + deltaTime
  if m_pressTime < m_interval then
    return
  end
  m_interval = m_interval - 0.01
  if m_pressingAdd then
    AddOne()
  elseif m_pressingMinus then
    MinusOne()
  else
    m_interval = 0.3
  end
end

function SetContent(id, index)
  m_curIdx = index
  this:Bind("fci/arms/" .. id, function(arm)
    m_curArm = arm
    this:Bind("ArmEnhance/CurAttr", function(attr)
      m_curAttr = attr
      m_pressingAdd = false
      m_pressingMinus = false
      m_curLevel = U.ToInt(m_curAttr.level)
      m_preLevel = U.ToInt(math.min(m_curLevel + 1, m_curArm.finalAttrLv))
      CaculateCost()
      UpdateAttrs()
    end)
  end)
end

function UpdateAttrs()
  if m_curArm == nil then
    return
  end
  WU.TraverseChildren(REF.NodeAttrs, function(go, index)
    local root = _ENV["$"](go).root
    local ref = _ENV["$"](go)
    local attrInfo = m_curArm.baseAttrs[index + 1]
    if attrInfo and not attrInfo.special then
      WU.ClearButtonEvent(ref.ShapeControl)
      WU.BindButtonEvent(ref.ShapeControl, function()
        ChangeAttrTo(attrInfo)
      end)
      if m_curAttr == attrInfo then
        m_curIdx = index + 1
      end
      local current = m_curIdx == index + 1
      local color = fif(current, "#5375A9FF", "#FFFFFFFF")
      ref.SpriteHighlight.gameObject:SetActive(current)
      WU.SetLabel(ref.LabelType, AddColor(WU.GetString("Window_ActorAttrName_" .. attrInfo.attr.type), color))
      WU.SetLabel(ref.LabelValue, AddColor(attrInfo.attr.value, color))
      root.gameObject:SetActive(true)
    else
      root.gameObject:SetActive(false)
    end
  end)
end

function CaculateCost()
  REF.NodeMax.gameObject:SetActive(m_curAttr.level == m_curArm.finalAttrLv)
  REF.NodeUpgradeAble.gameObject:SetActive(m_curAttr.level < m_curArm.finalAttrLv)
  if m_curAttr.level > m_curArm.finalAttrLv then
    return
  end
  m_pressTime = 0
  m_moneyEnough = true
  m_itemEnough = true
  local res = {}
  local items = {}
  local reCost
  m_materials = {}
  local nextAttr = WU.GetArmAttrById(m_curAttr, m_preLevel)
  if nextAttr == nil then
    return
  end
  m_preAttr = U.FormatAttrValue(nextAttr)
  WU.SetLabel(REF.LevelNow, m_curAttr.level)
  WU.SetLabel(REF.LevelPredict, m_preLevel)
  WU.SetLabel(REF.LabelAttrCur, m_curAttr.attr.value)
  WU.SetLabel(REF.LabelAttrType, WU.GetString("Window_ActorAttrName_" .. m_curAttr.attr.type))
  WU.SetLabel(REF.LabelAttrPre, m_preAttr)
  items, reCost = WU.CaculateArmAttrEnhance(m_curAttr, m_preLevel)
  local show = reCost ~= nil and 0 < #reCost
  if show then
    local re = reCost[1]
    local reCnt = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[re.type] .. "_" .. re.id)
    if reCnt < re.count then
      m_moneyEnough = false
    else
      table.insert(m_materials, re)
    end
    local color = fif(m_moneyEnough, "#FFFFFF", "#ec3b3e")
    REF.LabelCostCnt.gameObject:SetActive(true)
    WU.SetLabel(REF.LabelCost, WU.GetString("UniqueWeapon_MoneyCost"))
    if m_curAttr.level < m_curArm.maxAttrLevel then
      WU.SetLabel(REF.LabelCostCnt, GetResIcon_sString(re.type, re.id) .. AddColor(re.count, color))
    else
      local starStr = ""
      for i = 1, m_curArm.phase + 1 do
        starStr = starStr .. "<img src='ActorRelation.impression_star_m' height = 65%  width = 65%/>"
      end
      WU.SetLabel(REF.LabelCostCnt, AddColor(WU.GetString("UniqueWeapon_UpdateToPhase"), "#ec3b3e") .. starStr)
    end
  end
  WU.TraverseChildren(REF.GridMaterial, function(go, index)
    local gasket = _ENV["$"](go).root
    local info = items[U.ToInt(index + 1)]
    gasket.gameObject:SetActive(info)
    REF["LabelCount" .. index + 1].gameObject:SetActive(info)
    if info then
      local cnt = this:GetData("fci/item/" .. info.id).count
      if cnt < info.count then
        m_itemEnough = false
      else
        table.insert(m_materials, info)
      end
      _ENV["$"](go)["$$SetData"](info.type, info.id, info.count)
      local color = fif(cnt >= info.count, "#FFFFFF", "#ec3b3e")
      WU.SetLabel(REF["LabelCount" .. index + 1], AddColor(cnt, color) .. "/" .. info.count)
    else
      _ENV["$"](go)["$$SetEmpty"](1)
    end
    REF["LabelCount" .. index + 1].gameObject:SetActive(info)
  end)
  local threshold = m_preLevel > m_curArm.maxAttrLevel or m_preLevel < m_curLevel + 1
  local minusCondition = m_preLevel == m_curLevel + 1 or m_curLevel == m_curArm.maxAttrLevel
  local addCondition = m_preLevel >= m_curArm.maxAttrLevel
  REF.ButtonMinus.UISprite.graify = minusCondition
  REF.ButtonMinus.BoxCollider2D.enabled = not minusCondition
  REF.ButtonAdd.UISprite.graify = addCondition
  REF.ButtonAdd.BoxCollider2D.enabled = not addCondition
end

function ChangeAttrTo(attr)
  local idx, a = table.find(m_curArm.baseAttrs, function(k, v)
    return v.attrId == attr.attrId
  end)
  m_curAttr = a
  if not m_curArm.baseAttrs[idx].special then
    m_curIdx = idx
    m_preLevel = m_curLevel + 1
    this:BroadcastGameEvent("ArmEnhance/CurAttrChange", m_curAttr)
  end
end

function ManageArrow()
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

function ManageButtonEvent()
  WU.BindPressEvent(REF.ButtonAdd, function()
    m_pressingMinus = false
    m_pressingAdd = not m_pressingAdd
  end)
  WU.BindPressEvent(REF.ButtonMinus, function()
    m_pressingMinus = not m_pressingMinus
    m_pressingAdd = false
  end)
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    if m_curAttr.level >= m_curArm.finalAttrLv then
      WU.ShowHintText(WU.GetString("UniqueWeapon_MaxAttrLevelGet"))
      return
    elseif m_preLevel > m_curArm.maxAttrLevel then
      WU.ShowHintText(WU.GetString("UniqueWeapon_UpdatePhaseFirst"))
      return
    elseif not m_moneyEnough then
      WU.ShowHintText(WU.GetString("UniqueWeapon_MoneyNotEnough"))
      return
    elseif not m_itemEnough then
      WU.ShowHintText(WU.GetString("UniqueWeapon_ItemNotEnough"))
      return
    end
    local enhanceInfo = {
      targetLv = m_preLevel,
      foodRes = m_materials,
      attrId = m_curAttr.attrId,
      uniqueWeaponId = m_curArm.id
    }
    this:GameRequest("fci/unique-weapon-attr/enhance/"):Post(enhanceInfo, function(resp)
      DBH.ResChange(resp.resChange)
      REF.EffectUpgrade.EffectGenerator:Play()
      this:SetData("ActorInfo/CurrentActor", this:GetData("ActorInfo/CurrentActor"))
      this:SetData("Actor/SelectedUid", this:GetData("Actor/SelectedUid"))
    end)
  end)
end

function AddOne()
  m_preLevel = math.min(m_preLevel + 1, math.min(m_curArm.finalAttrLv, m_curArm.maxAttrLevel))
  CaculateCost()
end

function MinusOne()
  local threshold = math.min(m_curArm.finalAttrLv, m_curAttr.level + 1)
  m_preLevel = math.max(m_preLevel - 1, threshold)
  CaculateCost()
end
