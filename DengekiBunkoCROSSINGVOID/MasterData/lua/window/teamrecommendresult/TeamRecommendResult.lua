local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local TR = require("Common/TeamRCMDUtil")
local m_dataPage = 0
local m_requestPage = 0
local m_needReset = true
local m_activeData = {}
local m_indice, m_playerId

function SetupWindow()
  CS.EventDelegate.Add(REF.TeamScrollView.UIScrollView.onNext, function()
    RequestPage()
  end)
  CS.EventDelegate.Add(REF.TeamScrollView.UIScrollView.onPrev, function()
  end)
  WU.BindButtonEvent(REF.BtnSearch, function()
    WU.AcquireWindowAsync("TeamRecommendSearch", function(UI)
      WU.RecycleWindow(this)
      _ENV["$"](UI)["$$SetData"](m_indice)
    end)
  end)
  LU.Bind(REF.TeamWrapContent, {
    updateRow = function(ref, wrapIndex, realIndex)
      ref["$$SetData"](m_activeData[realIndex + 1])
    end
  })
  LU.Set(REF.TeamWrapContent, #m_activeData)
end

function OnEnable()
  m_requestPage = m_dataPage
end

function SetData(indice)
  Reset()
  SwichUI(1)
  REF.LabelDescription.UILabel.text = WU.GetString("TeamRCMD_Result1")
  WU.SetActive(REF.BtnSearch, true)
  m_indice = indice
  UpdateSelectedActors()
  RequestPage()
end

function SetData_B(playerId)
  Reset()
  SwichUI(2)
  REF.LabelDescription.UILabel.text = WU.GetString("TeamRCMD_Result2")
  WU.SetActive(REF.BtnSearch, false)
  m_playerId = playerId
  RequestPage()
end

function Reset()
  m_indice = nil
  m_playerId = nil
  m_activeData = {}
  WU.SetActive(REF.NoData, false)
  WU.SetActive(REF.TeamRCMDList, true)
  m_requestPage = 0
  m_dataPage = 0
end

function RequestPage()
  if m_dataPage == m_requestPage then
    m_requestPage = m_requestPage + 1
    if m_indice then
      this:GameRequest("fci/share-group/search"):SyncInput(m_requestPage == 0):Post(ProtobufT("ApiShareGroupSearch", {actorIds = m_indice, page = m_requestPage}), function(resp)
        AppendWrapData(resp.groupList)
        m_dataPage = m_dataPage + 1
      end)
    elseif m_playerId then
      this:GameRequest(string.format("fci/share-group/query-someone/%s/%d", m_playerId, m_requestPage)):SyncInput(m_requestPage == 0):Get(function(resp)
        AppendWrapData(resp.groupList)
        m_dataPage = m_dataPage + 1
      end)
    else
      WU.SetActive(REF.NoData, true)
      WU.SetActive(REF.TeamRCMDList, false)
      warning("TeamRCMD", "Miss target to Request")
    end
  end
end

function AppendWrapData(datas)
  local n = #datas
  if n == 0 then
    if m_dataPage == 0 then
      WU.SetActive(REF.NoData, true)
      WU.SetActive(REF.TeamRCMDList, false)
    else
      WU.ShowHintText(WU.GetString("TeamRCMD_NoMoreData"))
    end
    m_dataPage = m_dataPage - 1
    m_requestPage = m_requestPage - 1
  else
    for _, v in ipairs(datas) do
      for i = 1, 6 do
        local actor = v.actors[i]
        if actor then
          v.actors[i] = TR.ActorDataStencil(actor)
        end
      end
      table.insert(m_activeData, v)
    end
    LU.Set(REF.TeamWrapContent, #m_activeData, m_dataPage == 0)
  end
end

function UpdateSelectedActors()
  local i = 0
  for _, v in ipairs(m_indice) do
    WU.SetActive(REF.SelectedActor[i]["$"], true)
    REF.SelectedActor[i]["$$SetActorCustom"]({id = v})
    i = i + 1
  end
  for j = i, 5 do
    WU.SetActive(REF.SelectedActor[j]["$"], false)
  end
end

function SwichUI(mode)
  if mode == 1 then
    REF.Line.transform.localPosition = CS.UnityEngine.Vector3(0, -411, 0)
    WU.SetActive(REF.SelectedActor, true)
    WU.SetActive(REF.BtnSearch, true)
  elseif mode == 2 then
    REF.Line.transform.localPosition = CS.UnityEngine.Vector3(0, -559, 0)
    WU.SetActive(REF.Line, false)
    WU.SetActive(REF.SelectedActor, false)
    WU.SetActive(REF.BtnSearch, false)
  end
  REF.TeamScrollView.UIPanel:UpdateAnchors()
end
