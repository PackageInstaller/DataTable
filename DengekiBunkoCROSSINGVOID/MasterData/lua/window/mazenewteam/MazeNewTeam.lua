local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local SU = require("Common/SortUtil")
local index = 0
local m_repeatedContext = {}
local m_isInit, m_mazeId
local m_actorList = {}
local m_gotList = {}
local m_gotListUid = {}
local m_countTotal = 0
local m_maxCountTeam = 0
local m_maxCountMain = 0
local m_maxCountSub = 0
local m_sortSelectedList = {}
local m_sortSelectedLabelList = {}
local m_curSortChoice = {}
local m_curSort = 1
local m_mainCount = 0
local m_subCount = 0
local m_mainList = {}
local m_subList = {}
local m_rowCount = 10
local m_clickAble = true
local m_confirmLegal = false
local m_maxGot = 20
local m_mazeInfo
local m_hasSameActorId = false
local m_sameId, m_lastMazeInfo, m_mazeActivityId, m_playerId
local Sort_Name2Type = {
  Quality = 32,
  Level = 33,
  Star = 34,
  Name = 37,
  Cultivation = 35,
  Speed = 36
}

function SetupWindow()
  ManageButtonEvents()
  LU.Bind(REF.ContentProvided, {
    updateRow = UpdateActorProvided
  })
  LU.Bind(_ENV["$"](REF.MazeTeamRowItemMain).WrapContent, {
    updateRow = UpdateMainList
  })
  LU.Bind(_ENV["$"](REF.MazeTeamRowItemSub).WrapContent, {
    updateRow = UpdateSubList
  })
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_playerId = this:GetData("playerId")
  m_isInit = true
  REF.DropList.gameObject:SetActive(false)
  REF.ContentGot.gameObject:SetActive(false)
  REF.NodeSelected.gameObject:SetActive(false)
  REF.ButtonConfirm.gameObject:SetActive(false)
  REF.ButtonHideSort.gameObject:SetActive(false)
  REF.ContentProvided.gameObject:SetActive(false)
  this:Bind("fci/MazeId/" .. m_mazeActivityId .. "/", OnSetMazeInfo)
end

function OnTeamChange(result)
  if result == nil then
    return
  end
  m_maxCountSub = m_lastMazeInfo.maxActorCountMain
  m_maxCountMain = m_lastMazeInfo.maxActorCountSub
  m_maxCountTeam = m_maxCountMain + m_maxCountSub
  local actorList = this:GetData("fci/actor/")
  m_actorList = {}
  m_gotList = {}
  m_gotListUid = {}
  table.copy(actorList, m_actorList, true)
  local selectActorCache = WU.GetGameDataCache("MazeSelectActorCache_" .. m_playerId .. "_" .. m_mazeActivityId .. "_" .. m_mazeId)
  if selectActorCache then
    table.copy(selectActorCache, m_gotList, true)
  else
    table.copy(result.selectActors, m_gotList, true)
  end
  local refName = m_curSortChoice.name or "ButtonSortLevel"
  local key = string.sub(refName, string.len("ButtonSort") + 1)
  SetSortSelected(true, m_curSort or 1)
  SU.SortOnce(m_actorList, PB.get("Sort", Sort_Name2Type[key]), true)
  local selectActorList = {}
  for k, v in pairs(m_gotList) do
    local index, v = table.find(m_actorList, function(m, n)
      return n.uid == v.uid
    end)
    if index then
      selectActorList[#selectActorList + 1] = v
    end
  end
  m_gotList = selectActorList
  REF.ContentGot.gameObject:SetActive(true)
  UpdateGotActors()
  LU.Set(REF.ContentProvided, #m_actorList)
  SetBottomBar()
end

function UpdateActorProvided(ref, wrapIndex, realIndex)
  if realIndex < 0 or m_actorList == nil or realIndex >= #m_actorList then
    return
  end
  local idx = realIndex + 1
  local root = ref.root
  local data = m_actorList[idx]
  if data then
    local custom = {showStar = true, showUniqueWeapon = true}
    root["$ResetState"]()
    root["$SetActor"](data)
    root["$ShowCustom"](custom)
    data.selected = false
    if 0 < #m_gotList then
      for k, v in pairs(m_gotList) do
        local uid
        if v.uid then
          uid = v.uid
        else
          uid = v.actor.uid
        end
        if data.uid == uid then
          data.selected = true
        end
      end
    else
      data.selected = false
    end
    root["$SetSelected"](data.selected)
    root["$SetClickCallback"](function()
      if not m_clickAble then
        return
      end
      local kind = WU.GetKindByActorId(data.id)
      if not data.selected then
        if m_countTotal >= m_mazeInfo.maxActorCountMain + m_mazeInfo.maxActorCountSub * 2 then
          WU.ShowHintText(WU.GetString("Tower_MaxActors"))
          return
        elseif m_mainCount >= m_mazeInfo.maxActorCountMain and kind == 1 then
          WU.ShowHintText(WU.GetString("Tower_MaxMainActors"))
          return
        elseif m_subCount >= m_mazeInfo.maxActorCountSub and kind == 2 then
          WU.ShowHintText(WU.GetString("Tower_MaxSubActors"))
          return
        end
      end
      SetActorClick(data, true)
    end)
  end
end

function UpdateGotActors()
  m_mainList = {}
  m_subList = {}
  for k, v in pairs(m_gotList) do
    local actor = v.actor or v
    local kind = WU.GetKindByActorId(actor.id)
    if kind == 1 then
      table.insert(m_mainList, actor)
    elseif kind == 2 then
      table.insert(m_subList, actor)
    end
  end
  if #m_subList <= m_mazeInfo.maxActorCountSub then
    m_subCount = #m_subList
    for i = #m_subList + 1, m_mazeInfo.maxActorCountSub do
      table.insert(m_subList, {})
    end
  end
  if #m_mainList <= m_mazeInfo.maxActorCountMain then
    m_mainCount = #m_mainList
    for i = #m_mainList + 1, m_mazeInfo.maxActorCountMain do
      table.insert(m_mainList, {})
    end
  end
  if #m_subList < m_maxCountSub then
    for i = #m_subList + 1, m_maxCountSub do
      table.insert(m_subList, {limit = true, lock = true})
    end
  end
  if #m_mainList < m_maxCountMain then
    for i = #m_mainList + 1, m_maxCountMain do
      table.insert(m_mainList, {limit = true, lock = true})
    end
  end
  LU.Set(_ENV["$"](REF.MazeTeamRowItemMain).WrapContent, #m_mainList, m_isInit)
  LU.Set(_ENV["$"](REF.MazeTeamRowItemSub).WrapContent, #m_subList, m_isInit)
  m_isInit = false
  local copyGotList = {}
  table.copy(m_gotList, copyGotList, true)
  m_hasSameActorId = false
  for i = 1, #copyGotList do
    for j = 1, #copyGotList do
      if i ~= j and copyGotList[i].id == copyGotList[j].id then
        m_hasSameActorId = true
        m_sameId = copyGotList[i].id
        break
      end
    end
  end
  m_countTotal = m_mainCount + m_subCount
  m_confirmLegal = 0 < m_mainCount and m_mainCount <= m_mazeInfo.maxActorCountMain and m_subCount <= m_mazeInfo.maxActorCountSub and not m_hasSameActorId
  REF.ButtonConfirm.gameObject:SetActive(true)
  REF.LabelSubCount.UIHtmlLabel.text = string.format("%s / %s", m_subCount, m_mazeInfo.maxActorCountSub)
  REF.LabelMainCount.UIHtmlLabel.text = string.format("%s / %s", m_mainCount, m_mazeInfo.maxActorCountMain)
end

function SetActorClick(data, selectAble)
  local index, flag = table.find(m_gotList, function(k, v)
    if v.actor then
      return data.uid == v.actor.uid
    else
      return data.uid == v.uid
    end
  end)
  if flag then
    data.selected = false
    table.remove(m_gotList, index)
  elseif selectAble then
    table.insert(m_gotList, data)
    data.selected = true
  end
  WU.SetGameDataCache("MazeSelectActorCache_" .. m_playerId .. "_" .. m_mazeActivityId .. "_" .. m_mazeId, m_gotList)
  UpdateGotActors()
  LU.Set(REF.ContentProvided, #m_actorList, false)
  SetBottomBar()
end

function SaveAndLeave()
  for i = 1, #m_gotList do
    table.insert(m_gotListUid, m_gotList[i].uid)
  end
  this:SetData("MazeSelectActorUid", m_gotListUid)
  local info = {}
  info.selectActors = m_gotList
  this:SetData("fci/Maze/Actor/" .. m_mazeActivityId .. "/", info)
  local window = _ENV["$"](WU.AcquireWindow("MazeTrainsition"))
  window["$$SetData"]({
    mazeId = m_mazeActivityId,
    selectRoleId = GetLeaderRoleId()
  })
end

function SetBottomBar()
  REF.BottomBarSpace.gameObject:SetActive(0 < #m_actorList)
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(#m_actorList * REF.ContentProvided.UIWrapContent.itemSize, -513, 0)
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonConfirm, function()
    if m_confirmLegal then
      WU.ShowMessageYesNo(WU.GetString("Maze_EnterTips"), function(result)
        if result == "YES" then
          SaveAndLeave()
        end
      end)
    elseif m_mainCount < 1 then
      WU.ShowHintText(WU.GetString("Tower_AtleastOneMain"))
    elseif m_hasSameActorId == true then
      if WU.GetKindByActorId(m_sameId) == 1 then
        WU.ShowHintText(WU.GetString("Maze_HasSameActorMain") .. WU.GetString("ActorName_" .. m_sameId))
      else
        WU.ShowHintText(WU.GetString("Maze_HasSameActorSub") .. WU.GetString("ActorName_" .. m_sameId))
      end
    end
  end)
  WU.BindButtonEvent(REF.ButtonSort, function()
    local ref = REF.ButtonSort
    ref.show = REF.DropList.gameObject.activeSelf
    ref.show = not ref.show
    REF.DropList.gameObject:SetActive(ref.show)
    REF.ButtonHideSort.gameObject:SetActive(ref.show)
  end)
  WU.BindButtonEvent(REF.ButtonHideSort, function()
    REF.DropList.gameObject:SetActive(false)
    REF.ButtonHideSort.gameObject:SetActive(false)
  end)
  ManageSortButton()
end

function ManageSortButton()
  WU.TraverseChildren(REF.SortGrid, function(go, index)
    local gasket = _ENV["$"](go).root
    local realIndex = index + 1
    local key = string.sub(gasket.name, string.len("ButtonSort") + 1)
    m_sortSelectedList[realIndex] = _ENV["$"](go).DropListNodeSelected
    m_sortSelectedLabelList[realIndex] = _ENV["$"](go).DropListLabelItem
    WU.BindButtonEvent(gasket, function()
      for k, v in pairs(m_sortSelectedList) do
        SetSortSelected(false, k)
      end
      if gasket.sortType == nil then
        gasket.sortType = true
      end
      gasket.sortType = fif(m_curSortChoice ~= gasket, gasket.sortType, not gasket.sortType)
      m_curSortChoice = gasket
      m_curSort = realIndex
      SetSortSelected(true, realIndex)
      _ENV["$"](go).DropListSpriteSeqTagChild.UISprite.flip = fif(gasket.sortType, CS.UISprite.Flip.Nothing, CS.UISprite.Flip.Vertically)
      local xlsx = PB.get("Sort", Sort_Name2Type[key])
      SU.SortOnce(m_actorList, xlsx, gasket.sortType)
      LU.Set(REF.ContentProvided, #m_actorList)
      SetBottomBar()
    end)
  end)
end

function SetSortSelected(selected, index)
  if selected then
    m_sortSelectedList[index].gameObject:SetActive(true)
    m_sortSelectedLabelList[index].UILabel.color = CS.NGUIMath.HexToColor(995593215)
  else
    m_sortSelectedList[index].gameObject:SetActive(false)
    m_sortSelectedLabelList[index].UILabel.color = CS.NGUIMath.HexToColor(4294967295)
  end
end

function UpdateMainList(goRef, wrapIndex, realIndex)
  if m_mainList ~= nil and realIndex ~= nil and realIndex <= #m_mainList then
    SetSlot(goRef, m_mainList[realIndex + 1])
  end
end

function UpdateSubList(goRef, wrapIndex, realIndex)
  if m_subList ~= nil and realIndex ~= nil and realIndex <= #m_subList then
    SetSlot(goRef, m_subList[realIndex + 1])
  end
end

function SetSlot(ref, data)
  ref.NodeNextLock.gameObject:SetActive(false)
  ref.SpriteLock.gameObject:SetActive(false)
  if data then
    if data.limit then
      if data.limitLevel then
        ref.LabelLock.UILabel.text = WU.GetString("Maze_LimitLevel", data.limitLevel)
        ref.NodeNextLock.gameObject:SetActive(true)
      elseif data.lock then
        ref.SpriteLock.gameObject:SetActive(true)
      end
      ref.Visual.gameObject:SetActive(false)
      ref["$$SetClickCallback"](function()
      end)
    elseif table.empty(data) then
      ref.Visual.gameObject:SetActive(false)
    else
      ref.Visual.gameObject:SetActive(data ~= nil)
      if data then
        ref["$$SetActor"](data)
        ref["$$SetClickCallback"](function()
          local index = table.find(m_actorList, function(k, v)
            return v.uid == data.uid
          end)
          if index then
            SetActorClick(m_actorList[index], false)
          end
        end)
      end
    end
  end
  ref.NodeAcSelected.gameObject:SetActive(false)
end

function OnSetMazeInfo(id)
  m_mazeInfo = PB.get("MazeInfo", id)
  local allMazeInfo = PB.all("MazeInfo")
  m_lastMazeInfo = allMazeInfo[#allMazeInfo]
  if m_mazeInfo == nil then
    error("MazeInfo has no this id " .. id)
    return
  else
    m_mazeId = id
    this:BindRemote(DB:GameRequest("fci/Maze/Actor/" .. m_mazeActivityId .. "/"), OnTeamChange)
  end
end

function GetLeaderRoleId()
  for i = 1, #m_mainList do
    local roleId
    roleId = GetRoleIdByActorId(m_mainList[i].id)
    if roleId and GetSkeletonResByRoleId(roleId) ~= nil then
      return roleId
    end
  end
  for i = 1, #m_subList do
    local roleId
    roleId = GetRoleIdByActorId(m_subList[i].id)
    if roleId and GetSkeletonResByRoleId(roleId) ~= nil then
      return roleId
    end
  end
  return PB.all("Misc")[1].mazeMiscConf.mazeDefaultSkeletonResRoleId
end

function GetRoleIdByActorId(id)
  if id then
    local actor = PB.get("ActorConfig", id)
    if actor then
      return actor.role
    else
      error("ActorConfig has no this actorId " .. id)
      return
    end
  end
  return
end

function GetSkeletonResByRoleId(roleId)
  if roleId then
    local actorConfig = PB.all("ActorConfig")
    for k, v in pairs(actorConfig) do
      if v.role == roleId then
        local res = v.skeletonRes
        if res and res ~= "" then
          return res
        else
          return
        end
      end
    end
  end
  return
end
