local Base = inherit("Window/ActorSelect/ActorSelectBase", _ENV)
local groupBase = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local m_displayActorTable, m_showActorTableMain, m_showActorTableSub, m_initWindow
local m_repeatedContext = {}
local m_selectedActors = {}
local m_pills = {}
local m_members
local m_roleIdList = {}
local m_curRoleId, m_selectRoleId, m_mode
local m_select = 1
local m_group = 2
local m_show = 3
local m_selectLeader = 4
local m_eventActivityType, m_dungeonId, m_dungeonType, m_membersDetail, m_mazeActivityId

function SetupWindow()
  Base.SetupWindow()
  groupBase.SetupWindow()
  WU.BindButtonEvent(REF.Confirm, function()
    OnConfirm()
  end)
  WU.BindButtonEvent(REF.ButtonFight, Fight)
  WU.BindButtonEvent(REF.ButtonBag, function()
    WU.AcquireWindowAsync("MazeBag")
  end)
  WU.BindButtonEvent(REF.ActorLink, OnActorLinkClick)
  REF.ActorMain.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ActorMain, OnActorMainClick)
  WU.BindButtonEvent(REF.SpriteLeaderBG, OnSelectLeaderRole)
  WU.BindButtonEvent(REF.ConfirmSelectLeader, OnConfirmSelectLeader)
  LU.Bind(REF.ActorSelectWidgetGrid, {
    updateRow = UpdateRow,
    delta = 0.01
  })
  Base.SetData("GetMembers", function(groups)
    return groups
  end)
  Base.SetData("SetMembers", function(groups, patchData)
    m_members = patchData.members
    Base.SetData("groups", m_members)
    return true
  end)
  Base.SetData("OnActorGroupChanged", OnActorGroupChanged)
  Base.SetData("OnGroupMemberClick", function()
    ShowMode(m_select)
  end)
  LU.Bind(REF.WrapContentMain, {
    updateRow = UpdateRowMain
  })
  LU.Bind(REF.WrapContentSub, {
    updateRow = UpdateRowSub
  })
  LU.Bind(REF.WrapContentSelectLeader, {
    updateRow = UpdateSelectLeaderSlot
  })
  REF.WidgetGroupMembers["$SetClickCallback"](OnSlotSelected)
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_initWindow = true
  REF.SpriteSelectedMain.gameObject:SetActive(false)
  ShowMode(nil)
  Base.InitWindow()
  groupBase.InitAutoFight(PB.enum.DungeonType.Maze)
  this:DelayInvokeInFrames(1, function()
    OnRefreshActorGroup()
    OnRefreshDungeon()
  end)
  local nav = WU.FindWindow("Navigation")
  _ENV["$"](nav)["$$Save"]()
  _ENV["$"](nav)["$$SetBackCallback"](OnBackCallback)
  _ENV["$"](nav)["$$SetHomeCallback"](OnHomeCallback)
end

function UninitWindow()
  Base.UninitWindow()
end

function OnRefreshDungeon()
  m_eventActivityType = this:GetData("Event/ActivityType")
  this:SetData("ActorGroup/Mode", PB.enum.ActorGroupType.Maze)
  this:SetData("ActorGroup/GroupUri", "fci/Maze/FightActorGroup/")
  this:Unbind("WindowDungeon/DungeonId", OnDungeonInit)
  this:Bind("WindowDungeon/DungeonId", OnDungeonInit)
end

function OnDungeonInit(dungeonId)
  if dungeonId then
    m_dungeonId = dungeonId
  end
end

function OnRefreshActorGroup()
  WU.ToggleRendering(REF.Remove, false)
  WU.ToggleRendering(REF.Panel, false)
  WU.ToggleRendering(Base.GetData("currentGrid"), false)
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  this:Bind("fci/Maze/FightActorGroup/", OnActorGroupChanged)
  this:Bind("MazeNewActorSelect/MainActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Main then
      RefreshWrapContent(list)
    end
    if list then
      RefreshShowWrap(list, PB.enum.ActorType.Main)
    end
  end)
  this:Bind("MazeNewActorSelect/SubActors/", function(list)
    local actorType = Base.GetData("actorType")
    if list and actorType == PB.enum.ActorType.Sub then
      RefreshWrapContent(list, actorType)
    end
    if list then
      RefreshShowWrap(list, PB.enum.ActorType.Sub)
    end
  end)
end

function OnActorGroupChanged(result)
  if result ~= nil then
    local dataSource = this:GetData("fci/Maze/Actor/" .. m_mazeActivityId .. "/")
    m_selectedActors = dataSource.selectActors
    if m_mode == m_show then
      OnSetRoleList()
    end
    local groups = _ENV["!"]({})
    local actorGroup = {}
    local dataGroup = {}
    if result.fightGroup then
      dataGroup = result.fightGroup[1]
    else
      dataGroup = result
    end
    actorGroup = NormalizeGroups(dataGroup)
    table.copy(actorGroup, groups, true)
    m_members = groups
    RefreshGroupMembers()
    if m_initWindow then
      m_initWindow = false
      Base.ResetState(0, true, 0)
      Base.ClearAllSelect()
      REF.root.Animator:Play("DelayOpen", -1, 0)
    end
    WU.ToggleRendering(REF.Panel, true)
    ShowMode(m_mode)
  end
end

function SetMode(mode)
  m_mode = mode
  CustomizeWidgetGroup()
end

function ShowMode(mode)
  REF.NodeGroup.gameObject:SetActive(mode == m_group)
  REF.NodeSelect.gameObject:SetActive(mode == m_select)
  REF.NodeShow.gameObject:SetActive(mode == m_show)
  REF.NodeSelectLeader.gameObject:SetActive(mode == m_selectLeader)
  REF.SpriteSelectedMain.gameObject:SetActive(mode == m_selectLeader)
end

function UpdateRowMain(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_showActorTableMain ~= nil and rowIndex < #m_showActorTableMain then
    SetRow(m_showActorTableMain, rowRef, rowIndex)
  end
end

function UpdateRowSub(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_showActorTableSub ~= nil and rowIndex < #m_showActorTableSub then
    SetRow(m_showActorTableSub, rowRef, rowIndex)
  end
end

function SetRow(actorTable, rowRef, rowIndex)
  local actor = actorTable[rowIndex + 1]
  rowRef.WidgetIconSlot["$SetActor"](actor)
  rowRef["@uid"] = actor.uid
  local hp, dead = GetActorHpAndDead(actor.uid)
  local fill = GetActorHpFill(actor.uid)
  rowRef.SpriteIsDead.gameObject:SetActive(fif(hp == 0 and dead == true, true, false))
  rowRef.HpDetail.UIProgressBar.value = fif(fill == nil, 0, fill)
  rowRef.Visual.UIWidget.alpha = fif(hp == 0 and dead == true, 0.5, 1)
end

function UpdateRow(rowRef, wrapIndex, rowIndex)
  WU.ToggleRendering(rowRef["$"], rowIndex ~= nil)
  if rowIndex ~= nil and m_displayActorTable ~= nil and rowIndex < #m_displayActorTable then
    local actor = m_displayActorTable[rowIndex + 1]
    rowRef["$$UpdateActor"](actor)
    rowRef["$$SetClickCallback"](OnActorHeadClick)
    local currentActor
    local currentActorUid = Base.GetData("currentActorUid")
    if currentActorUid ~= nil then
      currentActor = this:GetData("fci/mazeactor/" .. currentActorUid).actor
    end
    local linksActorId = Base.GetData("linksActorId")
    if currentActor ~= nil and currentActor.id == actor.id then
      rowRef["$$SetMemberLink"](false)
    elseif linksActorId ~= nil then
      rowRef["$$SetMemberLink"](linksActorId[actor.id])
    end
    rowRef["@uid"] = actor.uid
    local displayNumbers = Base.GetData("displayNumbers")
    rowRef["$$ShowCustom"]({
      showCultivationTotal = displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = displayNumbers == SU.DisplayNumbers.Speed,
      showStar = displayNumbers == SU.DisplayNumbers.Star
    })
    local hp, dead = GetActorHpAndDead(actor.uid)
    local hpDesc = fif(dead, nil, WU.GetString("ActorSelect_ActorAttrName_1") .. hp)
    local data = {
      Hp = hpDesc,
      Pill = nil,
      Dead = dead
    }
    rowRef["$$ShowMoreInfo"](data)
  end
end

function RefreshGroupMembers()
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = root.HpDetailNode.transform.localPosition
    root.HpDetailNode.transform.localPosition = CS.UnityEngine.Vector3(pos.x, -328, 0)
    root.HpDetailNode.transform.localScale = CS.UnityEngine.Vector3(1, 1.4, 0)
  end
  Base.SetData("groups", m_members)
  REF.WidgetGroupMembers["$SetMazeGroupMembers"](m_members)
  Base.RefreshShow()
end

function Home()
  local winName = "City"
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnActorLinkClick()
  OpenDisplayInfo("ActorInfoDisplay", function(ui)
    _ENV["$"](ui)["$$SetSelectedTab"]("TabRelation")
    _ENV["$"](ui)["$$HideTab"]("TabEquipDisplay")
  end)
end

function OnActorMainClick()
  OpenDisplayInfo("ActorMainDisplay")
end

function CustomizeWidgetGroup()
  tweenFromGroup = fif(m_mode == m_show, {
    80,
    688,
    1296
  }, {
    -160,
    428,
    1016
  })
  REF.NodeLeader.gameObject:SetActive(m_mode == m_show)
  REF.NodeCommonLabel.gameObject:SetActive(m_mode ~= m_show)
  local scale = fif(m_mode == m_show, CS.UnityEngine.Vector3(0.8, 0.8, 1), CS.UnityEngine.Vector3(0.9, 0.9, 1))
  REF.WidgetGroupMembers.transform.localScale = scale
  REF.GroupTabNode.gameObject:SetActive(false)
  REF.Grid.UIGrid.cellWidth = fif(m_mode == m_show, 590, 650)
  for i = 1, 3 do
    local root = _ENV["$"](REF["TweenNode" .. i])
    local pos = REF["TweenNode" .. i].transform.localPosition
    REF["TweenNode" .. i].TweenPosition.from = CS.UnityEngine.Vector3(tweenFromGroup[i], pos.y, 0)
    REF["TweenNode" .. i].TweenPosition.to = CS.UnityEngine.Vector3(tweenFromGroup[i] - 75, pos.y, 0)
    root.WidgetActorCardEffectMain.transform.localScale = scale
    root.WidgetActorCardEffectSub.transform.localScale = scale
    root.Attrs.UISprite.height = 350
  end
end

function GetMazeActor(uid)
  local ac
  for i = 1, #m_selectedActors do
    if m_selectedActors[i].actor.uid == uid then
      ac = m_selectedActors[i].actor
      break
    end
  end
  return ac
end

function OpenDisplayInfo(win, callback)
  local currentActorUid = Base.GetData("currentActorUid")
  if currentActorUid ~= nil and 0 < currentActorUid then
    local ac = GetMazeActor(currentActorUid)
    local actorInfo = ac
    local displayInfo = {actorInfo = actorInfo}
    if actorInfo ~= nil and 0 < actorInfo.id then
      WU.AcquireWindowAsync(win, function(ui)
        if callback then
          callback(ui)
        end
        this:SetData("Space/DisplayInfo", displayInfo)
      end)
    end
  else
    WU.ShowHintText(WU.GetString("Window_NoFocusActor"))
  end
end

function OnActorHeadClick(go)
  local ref = _ENV["$"](go)
  local actorUid = ref["@uid"]
  if actorUid == nil then
    info("Actor", "actorUid nil?")
    return
  end
  local top = WU.TopWindow()
  if top and top.name == "ActorPeek" then
    WU.ShowActorPeek(this:GetData("fci/mazeactor/" .. actorUid).actor)
  else
    local currentActorUid = Base.GetData("currentActorUid")
    local slotIndex = Base.GetData("slotIndex")
    if currentActorUid == actorUid then
      return
    end
    Base.ClearAllSelect()
    local eventData = {index = slotIndex}
    eventData.cardS = this:GetData("fci/mazeactor/" .. actorUid).actor
    if currentActorUid then
      eventData.card = this:GetData("fci/mazeactor/" .. currentActorUid).actor
    end
    REF.WidgetGroupMembers["$OnActorGroupSlotChanged"](eventData, Base.OnGroupSlotChangeSuccess)
    Base.SetData("currentActorUid", actorUid)
  end
  RefreshGroupMembers()
  OnSlotSelected(REF.WidgetGroupMembers["$GetSlotByIndex"](Base.GetData("slotIndex")))
end

function OnSlotSelected(go)
  REF.SpriteSelectedMain.gameObject:SetActive(false)
  Base.OnSlotSelected(go)
end

function RefreshShowWrap(list, actorType)
  m_showActorTableMain = _ENV["!"]({})
  m_showActorTableSub = _ENV["!"]({})
  if actorType == PB.enum.ActorType.Main then
    _ENV["!"](list):copy(m_showActorTableMain)
    Base.RemoveActorsInGroup(m_showActorTableMain)
    LU.Set(REF.WrapContentMain, #m_showActorTableMain)
  elseif actorType == PB.enum.ActorType.Sub then
    _ENV["!"](list):copy(m_showActorTableSub)
    Base.RemoveActorsInGroup(m_showActorTableSub)
    LU.Set(REF.WrapContentSub, #m_showActorTableSub)
  end
end

function RefreshWrapContent(list)
  WU.ToggleRendering(Base.GetData("currentGrid"), true)
  m_displayActorTable = _ENV["!"]({})
  _ENV["!"](list):copy(m_displayActorTable)
  Base.RemoveActorsInGroup(m_displayActorTable)
  local resetPosition = true
  local resetActorSelect = Base.GetData("resetActorSelect")
  if resetActorSelect == false then
    resetPosition = false
  end
  if Base.GetData("currentGrid") == REF.ActorSelectWidgetGrid then
    LU.Set(REF.ActorSelectWidgetGrid, #m_displayActorTable, resetPosition, not resetPosition)
  end
end

function OnConfirm(isHome, onBack)
  local groups = Base.GetData("groups")
  local groupMembers = GetGroupMembers(groups)
  this:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Post({members = groupMembers}, function(result)
    this:SetData("fci/Maze/FightActorGroup/", result)
    ShowMode(m_mode)
    if onBack then
      if isHome then
        Home()
      else
        WU.RecycleWindow(this)
      end
    end
  end)
end

function OnBackCallback()
  local top = WU.TopWindow()
  if top and top.name == "MazeNewActorSelect" then
    OnBackValidate()
  else
    this:BroadcastGameEvent("OnNavigation", "Back")
  end
end

function OnHomeCallback()
  OnBackValidate(true)
end

function Home()
  local winName = "City"
  WU.RecycleWindow("MazeInterEvent")
  if WU.IsStandaloneGame() then
    winName = "StoryMode"
  end
  S:Get("TutorialManager").SetNavigation(winName)
  this:BroadcastGameEvent("OnNavigation", winName)
end

function OnBackValidate(isHome)
  local function DontSave()
    if isHome then
      Home()
    else
      WU.RecycleWindow(this)
    end
  end
  
  local originalGroups = this:GetData("fci/Maze/FightActorGroup/")
  local groups = Base.GetData("groups")
  for k, v in pairs(originalGroups.fightGroup) do
    for i = 1, #v.members do
      local member = v.members[i]
      if member.actorUid ~= groups[i].actorUid then
        WU.ShowMessageYesNo(WU.GetString("Window_ActorSelectBackValidate"), function(result)
          if result == "YES" then
            OnConfirm(isHome, true)
          else
            DontSave()
          end
        end)
        return
      end
    end
  end
  DontSave()
end

function Focus(on)
  if m_mode then
    ShowMode(m_mode)
    Base.ClearAllSelect()
    if on then
      WU.SetWindowTitle("MazeNewActorSelect", "ActorSelect")
    end
  end
end

function NormalizeGroups(fightGroup)
  local group = fightGroup.members or fightGroup
  for i = 1, #group do
    for k, v in pairs(m_selectedActors) do
      if v.actor and v.actor.uid == group[i].actorUid then
        group[i].actor = v.actor
        group[i].hp = v.hp
        group[i].dead = v.dead
        group[i].spSkillUsed = v.spSkillUsed
        break
      end
    end
  end
  return group
end

function GetGroupMembers(group)
  local members = {}
  for i = 1, #group do
    table.insert(members, {
      index = group[i].index,
      actorUid = group[i].actorUid
    })
  end
  return members
end

function GetActorHpAndDead(uid)
  local index = table.find(m_selectedActors, function(k, v)
    return v.actor.uid == uid
  end)
  if index then
    return m_selectedActors[index].hp, m_selectedActors[index].dead
  else
    error("no actor uid " .. uid)
    return
  end
end

function Fight()
  if GU.GroupIsOK(m_members, true) and GU.CheckHp(m_members, true) then
    local groups = Base.GetData("groups")
    local groupMembers = GetGroupMembers(groups)
    this:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Post({members = groupMembers}, function(result)
      this:SetData("fci/Maze/FightActorGroup/", result)
      EnterDungeon()
    end)
  end
end

function EnterDungeon()
  local cellIndex = this:GetData("MazeSelectIndex")
  local postData = {cellIndex = cellIndex, activityId = m_mazeActivityId}
  this:GameRequest("fci/maze-dungeon/"):Post(postData, function(result)
    m_membersDetail = {}
    for i, v in pairs(m_members) do
      local actorWrap
      if v.actorUid and v.actorUid > 0 then
        actorWrap = this:GetData("fci/mazeactor/" .. v.actorUid)
      end
      if actorWrap then
        v.hp = actorWrap.hp
        v.actor = actorWrap.actor
      end
      m_membersDetail[v.index + 1] = v.actor or {}
    end
    local fightActorInfo = {
      {
        playerId = this:GetData("playerId"),
        actors = m_membersDetail
      }
    }
    this:SetData("FightActorInfo", fightActorInfo)
    local hps = {}
    for _, member in ipairs(m_members) do
      if member.hp == nil then
        table.insert(hps, 0)
      elseif member.dead then
        table.insert(hps, -1)
      else
        local k2, v2 = table.find(result.myRecord, function(k, v)
          return v.actorUid == member.actorUid
        end)
        if v2 then
          table.insert(hps, v2.hp)
        else
          table.insert(hps, member.hp)
        end
      end
    end
    local allCardUseCount = {}
    table.merge(allCardUseCount, result.normalSkillUseCount)
    table.merge(allCardUseCount, result.linkSkillUseCount)
    local groupInfo = {
      hp = hps,
      sp = result.energySp,
      mp = result.energyMp,
      allCardUseCount = allCardUseCount
    }
    if result.enemyRecord then
      local enemyHps = result.enemyRecord.hp
      for i = 1, 6 do
        if enemyHps[i] == nil then
          enemyHps[i] = 0
        elseif enemyHps[i] == 0 then
          enemyHps[i] = -1
        end
      end
    end
    local fightInitInfo = {
      groupInfo,
      result.enemyRecord
    }
    this:SetData("FightInitInfo", fightInitInfo)
    WU.EnterGameLevel(result.dungeonUid, result.baseInfo, result.baseInfo.dungeonId, PB.enum.DungeonType.Maze, 1, false)
  end)
end

function GetActorHpFill(uid)
  local function ManageHp(data)
    if data.actor == nil then
      return nil
    end
    local maxHp = 0
    local hp = data.hp or data.actor.hp
    local attrs = data.actor.attrs
    for k, v in pairs(attrs) do
      if v.type == PB.enum.AttrType.Hp then
        maxHp = v.value
        hp = fif(hp == nil, v.value, hp)
      end
    end
    return hp, maxHp
  end
  
  local index = table.find(m_selectedActors, function(k, v)
    return v.actor.uid == uid
  end)
  if index then
    local hp, maxHp = ManageHp(m_selectedActors[index])
    local fill
    if hp then
      fill = hp / maxHp
    end
    return fill
  else
    error("no actor uid " .. uid)
    return
  end
end

function OnSetRoleList()
  m_roleIdList = {}
  m_curRoleId = nil
  m_selectRoleId = nil
  m_curRoleId = this:GetData("fci/MazeInfo/").currentRoleId
  if m_curRoleId == nil or m_curRoleId == 0 then
    m_curRoleId = PB.all("Misc")[1].mazeMiscConf.mazeDefaultSkeletonResRoleId
  end
  m_selectRoleId = m_curRoleId
  RefreshLeaderButton()
  table.insert(m_roleIdList, m_curRoleId)
  for k, v in pairs(m_selectedActors) do
    local roleId = GetRoleIdByActorId(v.actor.id)
    if roleId and roleId ~= m_curRoleId and not table.has(m_roleIdList, roleId) and GetSkeletonResByRoleId(roleId) ~= nil then
      table.insert(m_roleIdList, roleId)
    end
  end
end

function RefreshLeaderButton()
  local resStr = GetSkeletonResByRoleId(m_selectRoleId)
  local skeletonDataAsset
  local status, value = pcall(function()
    WU.AcquireAsset("Dependencies/Spine/" .. resStr .. "/" .. resStr .. "_SkeletonData")
  end)
  if status == true then
    skeletonDataAsset = WU.AcquireAsset("Dependencies/Spine/" .. resStr .. "/" .. resStr .. "_SkeletonData")
  else
    error("Dont has this resource that ActorConfig roleid " .. m_selectRoleId .. " get")
    return
  end
  REF.SkeletonActor.SkeletonGenerator:ResetRenderOrder()
  local skeletonAnim = REF.SkeletonActor.SkeletonGenerator:SetSkeleton(skeletonDataAsset)
  skeletonAnim.AnimationState:SetAnimation(0, "idle", true)
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

function UpdateSelectLeaderSlot(goRef, wrapIndex, realIndex)
  if m_roleIdList ~= nil and realIndex ~= nil and realIndex < #m_roleIdList then
    goRef.TextureRoleCartoon.UITexture.mainTexturePath = "Texture/Dormitory_actor_big/Dormitory_actor_big_" .. GetSkeletonResByRoleId(m_roleIdList[realIndex + 1])
    WU.ClearButtonEvent(goRef.SpriteBG)
    WU.BindButtonEvent(goRef.SpriteBG, function()
      m_selectRoleId = m_roleIdList[realIndex + 1]
      RefreshLeaderButton()
    end)
  end
end

function OnSelectLeaderRole()
  Base.ClearAllSelect()
  REF.SpriteSelectedMain.gameObject:SetActive(true)
  LU.Set(REF.WrapContentSelectLeader, #m_roleIdList)
  ShowMode(m_selectLeader)
end

function OnConfirmSelectLeader()
  if m_selectRoleId ~= m_curRoleId then
    this:GameRequest("fci/Maze/change-role/" .. m_selectRoleId .. "/" .. m_mazeActivityId .. "/"):Post(nil, function(result)
      if result then
        local mazeInfo = this:GetData("fci/MazeInfo/")
        ShowMode(m_show)
        mazeInfo.currentRoleId = result.roleId
        this:SetData("fci/MazeInfo/", mazeInfo)
      end
    end)
  else
    ShowMode(m_show)
  end
end
