local WU, DB, REF = require("Common/WindowUtil")(this)
local m_originalParents, m_originalIndexes, m_tutorialPanel, m_tutorialObjs, m_tutorialObjsPanels, m_hintAnchorIndexes, m_hintAchorOffsets, m_tutorialId, m_window
local m_SORTING_ORDER = 29960

function Awake()
end

function Init()
  m_originalParents = {}
  m_originalIndexes = {}
  m_tutorialPanel = REF["$transform"]:GetComponentInParent(typeof(CS.UITutorialPanel))
  m_window = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow)).gameObject
  m_tutorialId = m_tutorialPanel.tutorialId
  m_tutorialObjs = m_tutorialPanel:GetTutorialObjs(REF["$transform"]:GetSiblingIndex())
  m_tutorialObjsPanels = {}
  m_hintAchorOffsets = m_tutorialPanel:GetHintAchorOffsets(REF["$transform"]:GetSiblingIndex())
  m_hintAnchorIndexes = m_tutorialPanel:GetHintAchorIndexes(REF["$transform"]:GetSiblingIndex())
end

function StartStep()
  for i = 0, m_hintAnchorIndexes.Count - 1 do
    REF["$transform"]:GetChild(i).position = m_tutorialObjs[m_hintAnchorIndexes[i]].transform.position + m_hintAchorOffsets[i]
  end
  for i = 0, m_tutorialObjs.Count - 1 do
    m_originalIndexes[m_tutorialObjs[i]] = m_tutorialObjs[i].transform:GetSiblingIndex()
  end
  for i = 0, m_tutorialObjs.Count - 1 do
    local obj = m_tutorialObjs[i]
    m_originalParents[obj] = obj.transform.parent
    SetActiveAnimator(obj, false)
    obj.transform.parent = REF["$transform"]
    MarkParentChanged(obj.transform)
    SetPanel(obj, false)
  end
  for i = 0, REF["$transform"].childCount - 1 do
    local objRef = REF["$"][i]
    if objRef["$UnforcedTutorialHolder"] then
      for j = 0, objRef["$transform"].childCount - 1 do
        if objRef["$"][j]["$gameObject"].name == "UnforcedTutorialEffect" then
          objRef["$"][j]["$UIPanel"].sortingOrder = m_SORTING_ORDER + 1
        end
      end
    end
  end
end

function EndStep()
  local tempForSort = {}
  for objK, v in pairs(m_originalIndexes) do
    table.insert(tempForSort, {index = v, obj = objK})
  end
  table.sort(tempForSort, function(a, b)
    return a.index < b.index
  end)
  for i = 1, #tempForSort do
    local obj = tempForSort[i].obj
    obj.transform.parent = m_originalParents[obj]
    MarkParentChanged(obj.transform)
    SetActiveAnimator(obj, true)
    SetPanel(obj, true)
    obj.transform:SetSiblingIndex(m_originalIndexes[obj])
  end
  m_originalParents = {}
  m_originalIndexes = {}
  m_tutorialObjs = nil
  m_tutorialPanel = nil
  m_window = nil
  m_tutorialId = nil
  m_hintAchorOffsets = nil
  m_hintAnchorIndexes = nil
  m_tutorialObjsPanels = nil
end

function MarkParentChanged(t)
  if t:GetComponent(typeof(CS.UIWidget)) then
    t:GetComponent(typeof(CS.UIWidget)):ParentHasChanged()
  end
  for i = 0, t.childCount - 1 do
    MarkParentChanged(t:GetChild(i))
  end
end

function SetActiveAnimator(obj, active)
  local t = obj.transform.parent
  while t do
    if _ENV["$"](t)["$Animator"] then
      _ENV["$"](t)["$Animator"].enabled = active
    end
    if t.gameObject == m_window then
      break
    end
    t = t.parent
  end
end

function SetPanel(obj, reset)
  local panels = obj:GetComponentsInChildren(typeof(CS.UIPanel), true)
  for i = 0, panels.Length - 1 do
    local panel = panels[i]
    local sortingOrder
    if reset then
      sortingOrder = m_tutorialObjsPanels[panel]
    else
      sortingOrder = m_SORTING_ORDER + 1
      m_tutorialObjsPanels[panel] = panel.sortingOrder
    end
    panel.sortingOrder = sortingOrder
  end
end
