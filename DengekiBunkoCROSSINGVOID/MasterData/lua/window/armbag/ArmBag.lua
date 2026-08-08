local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local EU = require("Common/EquipUtil")
local m_actor
local m_arms = {}
local m_rowCount, m_curArm
local m_firstIn = true
local m_offAble = false
local m_nameScale = 0.7
local m_porSetting = PB.enum.WeaponPicSituationType.Bag

function SetupWindow()
  LU.Bind(REF.WrapContentArm, {
    updateRow = UpdateArm
  })
  WU.BindButtonEvent(REF.ButtonEquip, function()
    Equip(true)
  end)
  WU.BindButtonEvent(REF.ButtonDetail, ShowDetail)
  WU.TraverseChildren(REF.TabGrid, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        REF.ScrollViewDetail.UIScrollView:ResetPosition()
      end
    end)
  end)
end

function InitWindow()
  m_firstIn = true
  m_rowCount = #_ENV["$"](REF.NodeArms).root
  LU.Set(REF.WrapContentArm, 0)
  REF.TabAttrs.UIToggle.value = true
  this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
  m_firstIn = false
  REF.ScrollViewDetail.UIScrollView:ResetPosition()
end

function UninitWindow()
  EU.SetArmUnNew(m_arms)
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  this:Bind("fci/arms/", ArmChange)
end

function UpdateArm(ref, wrapIndex, realIndex)
  if m_arms == nil or realIndex >= #m_arms then
    return
  end
  for i = 1, m_rowCount do
    local idx = realIndex * m_rowCount + i
    local gasket = _ENV["$"](ref.NodeArms).root[i - 1]
    local curArm = m_arms[idx]
    if curArm then
      gasket.root.gameObject:SetActive(true)
      if m_firstIn then
        if m_actor.uniqueWeaponId and m_actor.uniqueWeaponId ~= 0 then
          m_curArm = AU.GetArmByActor(m_actor)
        elseif idx == 1 then
          m_curArm = curArm
        end
        Equip()
      elseif m_curArm.id == curArm.id then
        m_curArm = curArm
      end
      local equipInfo
      gasket["$$BindArm"](curArm)
      gasket["$$ShowCustom"]({
        selected = m_curArm.id == curArm.id,
        showEquip = true,
        showUsing = curArm.actorUid == m_actor.uid
      })
      m_offAble = m_curArm.actorId and m_actor.uid == m_curArm.actorUid
      WU.SetLabel(REF.LabelEquip, WU.GetString("UniqueWeapon_" .. fif(m_offAble, "UnEquip", "Equip")))
      gasket["$$SetClickCallback"](function()
        m_curArm = curArm
        Equip()
        LU.Set(REF.WrapContentArm, GetRow(), false)
      end)
    else
      gasket.root.gameObject:SetActive(false)
    end
  end
end

function ArmChange(result)
  local armInKind = {}
  for k, v in pairs(result) do
    if v.position == m_actor.kind then
      table.insert(armInKind, v)
    end
  end
  m_arms = armInKind
  table.sort(armInKind, SortArm)
  LU.Set(REF.WrapContentArm, GetRow(), m_firstIn)
end

function GetRow()
  local row, rest = math.modf(#m_arms / m_rowCount)
  if rest ~= 0 then
    row = row + 1
  end
  return row
end

function Equip(post)
  if m_curArm.position ~= m_actor.kind and post then
    WU.ShowHintText("position not match!")
    return
  end
  local req = "fci/unique-weapon/" .. fif(m_offAble, "off", "on") .. "/"
  local param = {
    uniqueWeaponId = m_curArm.id,
    actorUid = m_actor.uid
  }
  if post then
    local function yesFunc()
      this:GameRequest(req):Post(param, function(resp)
        DBH.UpdateArms({
          resp.newWeapon,
          
          resp.oldWeapon
        })
        DBH.UpdateActors({
          resp.oldActor,
          resp.newActor
        })
        this:SetData("ActorInfo/CurrentActor", m_actor)
        WU.RecycleWindow(this)
      end)
    end
    
    if m_curArm.actorUid and m_curArm.actorUid ~= 0 and m_curArm.actorUid ~= m_actor.uid then
      local ac = AU.GetActorByArm(m_curArm)
      local tipKey = WU.GetString("UniqueWeapon_EquippedByOther", WU.GetString("ActorName_" .. ac.id), ac.level)
      WU.ShowMessageYesNo(tipKey, function(result)
        if result == "YES" then
          yesFunc()
        else
          return
        end
      end)
    else
      yesFunc()
    end
  end
  REF.ScrollViewDetail.UIScrollView:ResetPosition()
  WU.ModifyWeaponName(REF.NodeName, m_curArm.id, m_nameScale, m_curArm.quality - 2)
  WU.ModifyWeaponPortrait(REF.TextureArm, m_curArm.id, m_porSetting, this.name, m_curArm.cardSkinIndex)
  RenderAttr(m_curArm.baseAttrs)
  UpdateProcess()
  WU.SetLabel(REF.LabelCultivation, WU.GetString("Sort_ActorCultivation") .. ": " .. m_curArm.cultivation)
  WU.SetLabel(REF.LabelSkillName, WU.GetString("UniqueWeaponSkillName_" .. m_curArm.id))
  WU.SetLabel(REF.LabelSkill, SE.GetWeaponSkillDesc(m_curArm.id, m_curArm.phase))
end

function RenderAttr(attrs)
  local cnt = 0
  local attrPerLine = 2
  local attrString = "<l width=100% valign=center>"
  for k, v in pairs(attrs) do
    if cnt % attrPerLine == 0 and cnt ~= 0 then
      attrString = attrString .. "</l>" .. HU.HtmlSplitLine("Common.Line_dark") .. "<l width=100% valign=center>"
    end
    if cnt % attrPerLine == 0 then
      local icon = "&nbsp;&nbsp;<img src='ActorUI.attr_type_" .. v.attr.type .. "'/>&nbsp;&nbsp;"
      attrString = attrString .. "<c width=34% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. v.attr.type) .. "</c>"
      attrString = attrString .. "<c width=24% align=left>" .. v.attr.value .. "</c>"
    else
      local icon = "<img src='ActorUI.attr_type_" .. v.attr.type .. "'/>&nbsp;&nbsp;&nbsp;"
      attrString = attrString .. "<c width=21% align=left>" .. icon .. WU.GetString("Window_ActorAttrName_" .. v.attr.type) .. "</c>"
      attrString = attrString .. "<c width=18% align=right>" .. v.attr.value .. "</c>"
    end
    cnt = cnt + 1
  end
  REF.LabelAttributes.UIHtmlLabel.text = attrString .. "</l>"
end

function ShowDetail()
  WU.AcquireWindowAsync("ArmDetail", function(window)
    _ENV["$"](window)["$$SetContent"](m_curArm, {hideEquip = true})
  end)
end

function UpdateProcess()
  local process = SE.GetWeaponProcess(m_curArm.id)
  WU.TraverseChildren(REF.ContentProcess, function(go, index)
    local gasket = _ENV["$"](go).root
    local realIndex = index + 1
    local pro = process[realIndex + 1]
    if pro then
      gasket.gameObject:SetActive(true)
      WU.SetLabel(_ENV["$"](go).LabelDescPro, pro)
      WU.SetLabel(_ENV["$"](go).LabelPreDescPro, "<img src='ActorRelation.impression_star_m" .. fif(realIndex <= m_curArm.phase, "", "_dark") .. "' height = 50%  width = 50%/>" .. WU.GetString("UniqueWeapon_Process") .. realIndex)
    else
      gasket.gameObject:SetActive(false)
    end
  end)
end

function SortArm(a, b)
  local uid = m_actor.uid
  
  local function CompareEquip(param1, param2)
    if param1.actorUid == 0 and param2.actorUid == 0 then
      return nil
    end
    if param1.actorUid ~= 0 and param2.actorUid == 0 then
      if param1.actorUid == uid then
        return true
      else
        return nil
      end
    elseif param1.actorUid == 0 and param2.actorUid ~= 0 then
      if param2.actorUid == uid then
        return false
      else
        return nil
      end
    elseif param1.actorUid == uid then
      return true
    elseif param2.actorUid == uid then
      return false
    end
    return nil
  end
  
  local equip = CompareEquip(a, b)
  if equip ~= nil then
    return equip
  end
  if a.quality ~= b.quality then
    return a.quality > b.quality
  elseif a.phase ~= b.phase then
    return a.phase > b.phase
  elseif a.level ~= b.level then
    return a.level > b.level
  elseif a.id ~= b.id then
    return a.id < b.id
  end
end
