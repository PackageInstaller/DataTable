local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_sceneList, m_currentSceneId
local m_buttonIdMap = {}
local m_currentSelectId, m_confirmCallback, m_oldSelectId

function SetBGMSelect(sceneList, sceneId, selectId)
  m_sceneList = sceneList
  m_currentSceneId = sceneId
  if selectId ~= nil then
    m_currentSelectId = selectId
    m_oldSelectId = selectId
  else
    m_currentSelectId = m_currentSceneId
    m_oldSelectId = m_currentSceneId
  end
  m_buttonIdMap = {}
  local warpContent = REF.WrapContentBGM
  local buttonConfirm = REF.ButtonConfirm
  local buttonCancel = REF.ButtonCancel
  REF.LabelTitle.UILabel.text = WU.GetString("Window_SelectBGM")
  _ENV["$"](buttonConfirm).Label.UILabel.text = WU.GetString("WindowSystem_Confirm")
  _ENV["$"](buttonCancel).Label.UILabel.text = WU.GetString("WindowSystem_Cancel")
  WU.BindButtonEvent(buttonConfirm, OnClickConfirm)
  WU.BindButtonEvent(buttonCancel, OnClickCancel)
  WU.BindButtonEvent(REF.ButtonCancel_2, OnClickCancel)
  WU.TraverseChildren(warpContent, function(go, i)
    local ref = _ENV["$"](go)
    ref.DefaultLabel.UILabel.text = WU.GetString("Window_Recommend")
    i = i + 1
    WU.SetActive(ref.Focus, false)
    WU.BindButtonEvent(ref.ButtonChoose, function()
      if m_buttonIdMap[i] ~= nil then
        for j = 0, #warpContent - 1 do
          WU.SetActive(warpContent[j].Focus, false)
        end
        WU.SetActive(ref.Focus, true)
        m_currentSelectId = m_buttonIdMap[i]
        local xlsxConfig = PB.get("CollectionsScenes", m_currentSelectId)
        CS.SoundManager.Instance:PlayMusic(fif(m_buttonIdMap[i] == m_currentSelectId, xlsxConfig.bgmRes, ""))
      end
    end)
  end)
  LU.Bind(warpContent, {
    updateRow = UpdateDropSlot
  })
  LU.Set(warpContent, #m_sceneList)
  InitList()
end

function UninitWindow()
  m_sceneList = nil
  m_currentSceneId = nil
  m_buttonIdMap = {}
  m_currentSelectId = nil
  m_confirmCallback = nil
end

function UpdateDropSlot(ref, wrapIndex, realIndex)
  if realIndex ~= nil and realIndex < #m_sceneList then
    wrapIndex = wrapIndex + 1
    realIndex = realIndex + 1
    WU.SetActive(ref.Visual, true)
    ref.Label.UILabel.text = "\227\128\138" .. m_sceneList[realIndex].bgmName .. "\227\128\139"
    ref.LabelNum.UILabel.text = realIndex
    m_buttonIdMap[wrapIndex] = m_sceneList[realIndex].id
    WU.SetActive(ref.Focus, m_sceneList[realIndex].id == m_currentSelectId)
    WU.SetActive(ref.DefaultTag, m_sceneList[realIndex].id == m_currentSceneId)
  else
    WU.SetActive(ref.Visual, false)
  end
end

function SetConfirmCallback(delegate)
  m_confirmCallback = delegate
end

function OnClickConfirm()
  if m_confirmCallback ~= nil then
    m_confirmCallback(m_currentSelectId)
  end
  WU.RecycleWindow(this)
end

function OnClickCancel()
  local xlsxConfig = PB.get("CollectionsScenes", m_oldSelectId)
  CS.SoundManager.Instance:PlayMusic(fif(m_oldSelectId ~= nil, xlsxConfig.bgmRes, ""))
  WU.RecycleWindow(this)
end

function InitList()
  local index = 0
  for k, v in pairs(m_sceneList) do
    if v.id == m_oldSelectId then
      index = k - 1
      break
    end
  end
  REF.ScrollViewBGM.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, index * 140 - 5, 0))
  if 4 < #m_sceneList and 1 < index then
    REF.ScrollViewBGM.UIScrollView:RestrictWithinBounds(true)
  end
end
