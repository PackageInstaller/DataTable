local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local SE = require("Common/SkillEffect")
local m_configDataManager = S:Get("ConfigDataManager")
local m_pill, m_pillList, m_curList
local m_btnList = {}
local m_curIdx = 1

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollView.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  ManageSelectButtons()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecordButtonClick(100121401)
    WU.RecycleWindow(this)
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdatePillSlot
  })
end

function InitWindow()
  LU.Set(REF.WrapContent, 0)
  local m_towerSumry = this:GetData("fci/extreme-challenge/summary/")
  this:BindRemote(DB:GameRequest("fci/extreme-challenge/select-buffitems/" .. m_towerSumry.curFloor - 1 .. "/"), function(result)
    if result == nil then
      return
    end
    m_pill = result
    m_pillList = result.groups
    m_curList = m_pillList[m_curIdx].items
    LU.Set(REF.WrapContent, #m_curList)
  end)
end

function UpdatePillSlot(ref, wrapIndex, realIndex)
  if m_curList == nil or realIndex >= #m_curList then
    return
  end
  local root = ref.root
  local idx = realIndex + 1
  local widgetIcon = _ENV["$"](ref.WidgetIconSlot)
  local curPill = m_curList[idx]
  widgetIcon["$$SetData"](curPill.type, curPill.id, curPill.count)
  widgetIcon["$$SetClickCallback"](nil)
  ref.LabelDesc.UIHtmlLabel.text = SE.GetTowerPillDesc(curPill.id)
  local pillInfo = PB.get("ExtremeChallengeBuffItem", curPill.id)
  ref.NodeSelected.gameObject:SetActive(false)
  ref.NodeEffectSingle.gameObject:SetActive(pillInfo.dragfastAdd == 0 or pillInfo.score == 0)
  ref.NodeEffectDouble.gameObject:SetActive(pillInfo.dragfastAdd ~= 0 and pillInfo.score ~= 0)
  if pillInfo.dragfastAdd ~= 0 and pillInfo.score ~= 0 then
    ref.LabelPill.UIHtmlLabel.text = "<img src='Tournament.challenge_limit_icon'/>" .. " +" .. pillInfo.dragfastAdd
    ref.LabelScore.UIHtmlLabel.text = "<img src='Tournament.challenge_hotspot_icon'/>" .. " +" .. pillInfo.score
  else
    ref.NodeEffectSingle.UISprite.color = CS.NGUIMath.HexToColor(fif(pillInfo.dragfastAdd ~= 0, 4294967295, 2313485311))
    ref.LabelSingle.UIHtmlLabel.text = fif(pillInfo.dragfastAdd ~= 0, "<img src='Tournament.challenge_limit_icon'/>" .. " +" .. pillInfo.dragfastAdd, "<img src='Tournament.challenge_hotspot_icon'/>" .. " +" .. pillInfo.score)
  end
end

function ManageSelectButtons()
  WU.TraverseChildren(REF.GridSelected, function(go, index)
    local ref = _ENV["$"](go)
    m_btnList[index + 1] = ref.ButtonSelect
    WU.BindButtonEvent(ref.ButtonSelect, function()
      m_curIdx = index + 1
      CurPillListChange()
    end)
  end)
  
  local function step(factor)
    m_curIdx = m_curIdx + factor
    if m_curIdx >= #m_pill.groups then
      m_curIdx = #m_pill.groups
    end
    if m_curIdx <= 1 then
      m_curIdx = 1
    end
    CurPillListChange()
  end
  
  WU.BindButtonEvent(REF.ButtonNext, function()
    WU.RecordButtonClick(100121403)
    step(1)
  end)
  WU.BindButtonEvent(REF.ButtonLast, function()
    WU.RecordButtonClick(100121402)
    step(-1)
  end)
end

function SetSelectedIndex(index)
  m_curIdx = index
  CurPillListChange()
end

function CurPillListChange()
  m_curList = m_pillList[m_curIdx].items
  ManageBtnList(m_curIdx)
  LU.Set(REF.WrapContent, #m_curList)
  REF.LabelTitle.UILabel.text = WU.GetString("TowerPillGroup", m_curIdx)
end

function ManageBtnList(curIdx)
  for k, v in pairs(m_btnList) do
    v.UISprite.spriteName = "button_off_2"
  end
  m_btnList[curIdx].UISprite.spriteName = "bar_button"
end

function Focus(on)
  WU.RecordWindowFocus(1001214, on)
end
