local Base = inherit("Window/Dorm/DormBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local AI = require("Common/DormAI")
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local FU = require("Common/FriendUtil")
local IsometricTools = CS.IsometricGame.IsometricTools
local Mathf = CS.UnityEngine.Mathf
local BoxTerm = CS.IsometricGame.BoxTerm
local GridStyle = Base.GridStyle
local GRID_COLOR_NORMAL = CS.NGUIMath.HexToColor(217559807)
local GRID_COLOR_ERROR = CS.NGUIMath.HexToColor(4282335231)
local COLOR_WHITE = CS.NGUIMath.HexToColor(4294967295)
local COLOR_BLUE = CS.NGUIMath.HexToColor(995593215)
local HALF_SCREEN_SIZE = CS.UnityEngine.Vector3(CS.UnityEngine.Screen.width / 2, CS.UnityEngine.Screen.height / 2, 0)
local DEFAULT_HEIGHT = 9
local REFRESH_INTERVAL = 60
local SECONDS_PER_HOUR = 3600
local DORM_MAX_FLOOR_LEVEL = math.max(table.unpack(PB.all("DormFloorConfig"):select(function(v)
  return v.level
end)))
local m_defaultArrangement = {
  floor = 1,
  furnitures = {
    {
      furnitureId = 100001,
      position = {
        x = 0,
        y = 0,
        z = 0
      },
      flip = false,
      parent = -1
    },
    {
      furnitureId = 100002,
      position = {
        x = 0,
        y = 0,
        z = 0
      },
      flip = false,
      parent = -1
    }
  }
}
local m_AIController, m_agentMap, m_agentSayMap, m_dorm, m_selectedBox, m_selectedPos, m_dragging, m_moving, m_prevSelectedPos, m_originalPos, m_originalFlip, m_originalAgentState, m_originalAgentFurnBox, m_dormFloor, m_dormWallpaper, m_hostId, m_dormInfo, m_arrangementData, m_floor, m_floorLevel, m_comfort, m_spareActorBlock, m_ownedFurnitrueMap, m_filteredFurnList, m_editCurrCategory, m_inited, m_inEditMode, m_cameraBound, m_canExtendFloor, m_needReload, m_expAddPerHour, m_inVisitMode, m_refreshCoroutine, m_hideUIFlag, m_schemeList, m_ownedThemeList, m_themeToFurnitureMap, m_agentInteractiveMap, m_dialogGoInUseMap, m_greeted

function SetupWindow()
  WU.SetActive(REF.ButtonDebugOutput, false)
  WU.SetActive(REF.ButtonGroupDebug, false)
  WU.BindDragEvent(REF.EventArea, OnDraggingDorm)
  WU.BindPressEvent(REF.EventArea, OnPressDorm)
  WU.BindButtonEvent(REF.EventArea, OnClickDorm)
  WU.BindButtonEvent(REF.ButtonDormName, OnClickDormName)
  WU.BindPressEvent(REF.ButtonComfortDetail, OnPressComfortDetail)
  WU.BindButtonEvent(REF.ButtonRemove, OnClickRemove)
  WU.BindButtonEvent(REF.ButtonOK, OnClickOK)
  WU.BindButtonEvent(REF.ButtonFlip, OnClickFlip)
  WU.BindButtonEvent(REF.ButtonFloor, OnClickFloor)
  WU.BindButtonEvent(REF.ButtonHideUI, OnClickHideUI)
  WU.BindButtonEvent(REF.ButtonEdit, OnClickEdit)
  WU.BindButtonEvent(REF.ButtonShop, OnClickShop)
  WU.BindButtonEvent(REF.ButtonSave, OnClickSave)
  WU.BindButtonEvent(REF.ButtonClear, OnClickClear)
  WU.BindButtonEvent(REF.ButtonShare, OnClickShare)
  WU.BindButtonEvent(REF.ButtonShowSeat, OnClickShowSeat)
  WU.BindButtonEvent(REF.ButtonFeed, OnClickFeed)
  WU.BindButtonEvent(REF.ButtonVisit, OnClickVisit)
  WU.BindButtonEvent(REF.ButtonAppreciate, OnClickAppreciate)
  WU.BindButtonEvent(REF.ButtonAddFriend, OnClickAddFriend)
  WU.BindButtonEvent(REF.ButtonNextPlayer, OnClickNextPlayer)
  WU.BindButtonEvent(REF.ButtonExitVisit, OnClickExitVisit)
  local i = 0
  WU.TraverseChildren(REF.CategoryButtons, function(g)
    _ENV["$"](g)["@category"] = i
    WU.BindButtonEvent(_ENV["$"](g).root, OnFilterCategoryClick)
    i = i + 1
  end)
  LU.Bind(REF.WrapContentFurnList, {
    updateRow = UpdateFurnCard
  })
  CS.GameGlobal.Instance:AssignCameraRenderTexture(REF.DormCamera.Camera, "__dorm")
  local rt = CS.GameGlobal.Instance:AcquireRenderTextureContext("__dorm").m_rt
  REF.DormRT.UITexture.mainTexture = rt
  REF.DormRT.UITexture.width = rt.width
  SetupBase(REF.DormHome)
  m_themeToFurnitureMap = {}
  local furnitureConfigs = PB.all("FurnitureConfig")
  for i = 1, #furnitureConfigs do
    local config = furnitureConfigs[i]
    m_themeToFurnitureMap[config.theme] = m_themeToFurnitureMap[config.theme] or {}
    table.insert(m_themeToFurnitureMap[config.theme], config.id)
  end
end

function InitWindow()
  this:SetData("Dorm/CurrentFloor", 1)
  SetEditMode(false)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:RegisterGameEvent("DormEditFurnitureCountChange", OnDormEditFurnitureCountChange)
  this:RegisterGameEvent("DormNeedReload", function()
    m_needReload = true
  end)
  this:RegisterGameEvent("DormNeedUninit", function()
    Uninit()
  end)
  this:Bind("Dorm/InVisitMode", SetVisitMode)
  this:BindRemote(this:GameRequest("fci/dorm-custom-arrangement/"), OnCustomArrangementChange)
  WU.SetActive(REF.ComfortBuffHint, false)
end

function UninitWindow()
  this:SetData("Dorm/ExpAddMap", nil)
  WU.SetNaviationBackCallback(nil)
  AgentCleanupAllSaying()
end

function UpdateWindow(deltaTime)
  if m_AIController then
    m_AIController:Update(deltaTime)
  end
  if m_inEditMode and m_selectedBox then
    local term = m_selectedBox.term
    if term ~= BoxTerm.Dynamic and term ~= BoxTerm.Floor and term ~= BoxTerm.Wall then
      WU.SetActive(REF.ButtonGroupFurnOperation, true)
      WU.SetActive(REF.ButtonFlip, m_selectedBox.allowFlip)
      local selectedBoxCenterCartPos = CS.IsometricGame.IsometricTools.IsoToCart(m_selectedBox.unitSize, m_selectedBox.isoPosition + m_selectedBox.bound / 2)
      REF.ButtonGroupFurnOperation.transform.localPosition = REF.DormCamera.Camera:WorldToScreenPoint(REF.DormRoot.transform:TransformPoint(selectedBoxCenterCartPos)) - HALF_SCREEN_SIZE
    else
      WU.SetActive(REF.ButtonGroupFurnOperation, false)
    end
  else
    WU.SetActive(REF.ButtonGroupFurnOperation, false)
  end
  if not m_inEditMode and m_agentSayMap then
    local dialogDormPos
    for box, sayData in pairs(m_agentSayMap) do
      dialogDormPos = CS.IsometricGame.IsometricTools.IsoToCart(box.unitSize, box.isoPositionRaw + box.bound)
      sayData.dialogGo.transform.localPosition = REF.DormCamera.Camera:WorldToScreenPoint(REF.DormRoot.transform:TransformPoint(dialogDormPos)) - HALF_SCREEN_SIZE
    end
  end
end

function OnWindowUninited(window)
  if window.name == "DormFeed" then
    CS.GameGlobal.Instance:AssignCameraRenderTexture(REF.DormCamera.Camera, "__dorm")
  elseif window.name == "Share" then
    WU.SetActive(REF.BaseUI, true)
    WU.SetActive(REF.ButtonHideUI, true)
  end
  DoReload()
end

function OnDormChange(dormData)
  if dormData then
    m_dormInfo = dormData.dormInfo
    REF.LabelDormName.UILabel.text = m_dormInfo.dormName
    WU.SetActive(REF.SpriteExtend, m_dormInfo.dormLevel < DORM_MAX_FLOOR_LEVEL)
    if m_dormInfo.dormLevel < DORM_MAX_FLOOR_LEVEL then
      REF.SpriteExtend.SpriteRenderer.sprite = WU.AcquireAssetSprite("Texture/DormSprite/ma_lu_" .. m_dormInfo.dormLevel)
    end
    this:Unbind("Dorm/CurrentFloor", OnFloorChange)
    this:Bind("Dorm/CurrentFloor", OnFloorChange)
    this:Unbind("fci/item", OnItemChange)
    this:Bind("fci/item", OnItemChange)
    if m_refreshCoroutine == nil then
      m_refreshCoroutine = this:DelayInvokeInSeconds(REFRESH_INTERVAL, function()
        m_refreshCoroutine = this:RepeatInvokeInSeconds(REFRESH_INTERVAL, DoRefresh)
      end)
    end
  end
end

function OnFloorChange(floor)
  if floor then
    m_floor = floor
    local dormConfig = PB.get("DormConfig", m_dormInfo.dormLevel)
    m_floorLevel = dormConfig.floorLevel[floor]
    local floorConfig = PB.get("DormFloorConfig", m_floorLevel)
    local rawSize = floorConfig.size
    local size = CS.UnityEngine.Vector3(rawSize, rawSize, DEFAULT_HEIGHT)
    if m_size ~= size then
      m_size = size
      UpdateCameraBound()
    end
    local _, arrangement = table.find(m_dormInfo.dormArrangement, function(k, v)
      return v.floor == m_floor
    end)
    if arrangement and not table.empty(arrangement.furnitures) then
      if m_inited then
        m_needReload = true
        DoReload()
      else
        Init()
        if not m_inVisitMode then
          DoPopup()
          DoGreet()
        end
        m_inited = true
      end
    else
      m_defaultArrangement.floor = m_floor
      if m_inVisitMode then
        table.insert(m_dormInfo.dormArrangement, m_defaultArrangement)
        Init()
        m_inited = true
      else
        DU.RequestSaveArrangement({m_defaultArrangement})
      end
    end
    REF.LabelFloor.UILabel.text = WU.GetString("Dorm_FloorTitle", m_floor)
  end
end

function OnHostDormChange(dormData)
  if dormData then
    m_dormInfo = dormData.dormInfo
    m_hostId = m_dormInfo.playerId
    SetAppreciateUI()
    WU.SetActive(REF.ButtonAddFriend, not FU.IsGameFriend(m_hostId))
    WU.SetActive(REF.SpriteExtend, false)
    REF.LabelDormName.UILabel.text = m_dormInfo.dormName
    REF.LabelDormComfort.UILabel.text = m_dormInfo.dormComfort
    this:Unbind("Dorm/CurrentFloor", OnFloorChange)
    this:Bind("Dorm/CurrentFloor", OnFloorChange)
  end
end

function OnCustomArrangementChange(result)
  if result then
    m_schemeList = result.customInfo
    if m_inEditMode and m_editCurrCategory == 0 then
      ShowFilteredFurnList(0, true)
    end
  end
end

function OnItemChange(items)
  UpdateComfortAndExpPerHour()
  REF.LabelDormComfort.UILabel.text = m_comfort
end

function Init()
  local _
  _, m_arrangementData = table.find(m_dormInfo.dormArrangement, function(k, v)
    return v.floor == m_floor
  end)
  InitBase(m_size)
  LoadStatic(m_arrangementData.furnitures)
  UpdateMovableBoard()
  UpdateSpareActorBlock()
  InitAI()
  LoadDynamic()
  RearrangeAllBox()
  if not m_arrSuccFlag then
    error("GamePlay", "[Dorm] init rearrange error")
    WU.ShowMessageYesNo(WU.GetString("Dorm_RearrangeFail"), function(result)
      if result == "YES" then
        DU.RequestSaveArrangement({m_defaultArrangement})
      else
        WU.RecycleWindow(this)
      end
    end)
  end
end

function LoadStatic(furnitures)
  local furnList = {}
  for _, furn in ipairs(furnitures) do
    local xlsxConfig = PB.get("FurnitureConfig", furn.furnitureId)
    local prefabName = "furniture_" .. furn.furnitureId
    local go = InstantiateBox(prefabName)
    local box = go:GetComponent(typeof(CS.IsometricGame.IsometricBox))
    box.flip = furn.flip
    if box.term == BoxTerm.Walldecor and box.bound.y == 0 then
      furn.position.y = m_size.y
    end
    box.isoPosition = furn.position
    box:AddToRoot(m_root)
    table.insert(furnList, box)
    if box.term == BoxTerm.Floor then
      m_dormFloor = box
    elseif box.term == BoxTerm.Wallpaper then
      m_dormWallpaper = box
    end
  end
  for i, furn in ipairs(furnitures) do
    if furn.parent ~= -1 then
      BoxSetParent(furnList[i], furnList[furn.parent])
    end
  end
end

function LoadDynamic()
  local _, showActors = table.find(m_dormInfo.showActors, function(k, v)
    return v.floor == m_floor
  end)
  if showActors then
    local actors = showActors.actorsUid
    local posList = GetActorRandomSparePosList(#actors)
    if posList then
      for i = 1, #actors do
        local pos = posList[i]
        local uid = actors[i]
        AddActorImpl(pos, uid)
      end
    else
      WU.ShowHintText("Dorm_PutActorFail_NoSpareBlock")
    end
  end
end

function InitAI()
  m_agentMap = {}
  m_AIController = AI.NewController(m_root, m_board, m_agentMap)
  m_agentInteractiveMap = {}
  local _, showActors = table.find(m_dormInfo.showActors, function(k, v)
    return v.floor == m_floor
  end)
  if showActors then
    local actorIds = _ENV["!"]({})
    local actors = showActors.actorsUid
    for _, uid in ipairs(showActors.actorsUid) do
      local actorId
      if m_inVisitMode then
        actorId = m_dormInfo.showActorsId[tostring(uid)]
      else
        actorId = this:GetData("fci/actor/" .. uid).id
      end
      table.insert(actorIds, actorId)
    end
    actorIds:distinct()
    local actorInteractiveConfigs = PB.all("ActorInteractive")
    for i = 1, #actorInteractiveConfigs do
      local config = actorInteractiveConfigs[i]
      local canUse = true
      for _, par in ipairs(config.participants) do
        if not table.find(actorIds, function(_, v)
          return par.actorId == v
        end) then
          canUse = false
          break
        end
      end
      if canUse then
        for _, par in ipairs(config.participants) do
          m_agentInteractiveMap[par.actorId] = m_agentInteractiveMap[par.actorId] or {}
          table.insert(m_agentInteractiveMap[par.actorId], config.id)
        end
      end
    end
  end
  m_agentSayMap = {}
  m_dialogGoInUseMap = {}
end

function DoReload()
  if m_needReload and WU.TopWindow().name == "Dorm" then
    Reload()
    m_needReload = false
  end
end

function Reload()
  SetEditMode(false)
  Uninit()
  Init(this:GetData("fci/dorm/{playerId}"), m_floor)
end

function Uninit()
  m_root.borderList:Clear()
  m_root.boxList:Clear()
  for i = 0, m_root.transform.childCount - 1 do
    CS.UnityEngine.GameObject.Destroy(m_root.transform:GetChild(i).gameObject)
  end
  m_agentMap = nil
  m_AIController = nil
  AgentCleanupAllSaying()
  ClearSelection()
end

function InstantiateBox(prefabName, path)
  if path == nil then
    path = "Dorm/Furniture/"
  end
  
  local function MakeSpriteName(spriteName, suffix)
    return string.sub(spriteName, 1, -2) .. suffix
  end
  
  local suffix = "s"
  if m_floorLevel == 2 then
    suffix = "m"
  elseif m_floorLevel == 3 then
    suffix = "l"
  elseif m_floorLevel == 4 then
    suffix = "xl"
  end
  local go = WU.InstantiateWindowPrefabAttached(REF.DormRoot, path .. prefabName, prefabName)
  local box = _ENV["$"](go)["$IsometricBox"]
  if box.term == BoxTerm.Floor or box.term == BoxTerm.Wallpaper then
    local boxSpriteRenderers = _ENV["$"](box).View["$GetSpriteRenderers"]()
    local wallpaperSprrOffset
    if box.term == BoxTerm.Wallpaper then
      wallpaperSprrOffset = CS.IsometricGame.IsometricTools.IsoToCart(m_root.unitSize, CS.UnityEngine.Vector3(0, m_size.y, 0))
      box.bound = {
        x = 0,
        y = m_size.x,
        z = DEFAULT_HEIGHT
      }
    else
      box.bound = {
        x = m_size.x,
        y = m_size.y,
        z = 0
      }
      local occupationArea = {}
      for i = 0, m_size.x - 1 do
        for j = 0, m_size.y - 1 do
          table.insert(occupationArea, {x = i, y = j})
        end
      end
      box.occupationArea = occupationArea
    end
    for i = 0, boxSpriteRenderers.Length - 1 do
      local sprr = boxSpriteRenderers[i]
      local newSprName = MakeSpriteName(sprr.sprite.name, suffix)
      if newSprName ~= sprr.sprite.name then
        sprr.sprite = WU.AcquireAssetSprite("Texture/DormSprite/" .. newSprName)
      end
      if wallpaperSprrOffset then
        sprr.transform.localPosition = wallpaperSprrOffset
      end
    end
  end
  return go
end

function UpdateCameraBound()
  local y = CS.IsometricGame.IsometricTools.IsoToCart(m_root.unitSize, CS.UnityEngine.Vector3(m_size.x, 0, 0)).y
  local x = CS.IsometricGame.IsometricTools.IsoToCart(m_root.unitSize, CS.UnityEngine.Vector3(m_size.x, m_size.y, 0)).x
  m_cameraBound = {
    x = 0,
    y = y,
    z = x,
    w = -y
  }
  REF.DormCamera.transform.localPosition = CS.UnityEngine.Vector3((m_cameraBound.x + m_cameraBound.z) / 2, 0, -10)
end

function AddFurniture(furnId)
  local prefabName = "furniture_" .. furnId
  local prefab = WU.AcquireAsset("Window/Dorm/Furniture/" .. prefabName)
  if prefab == nil then
    error("GamePlay", "[Dorm] there is no furniture " .. furnId)
    return false
  end
  local succeed = false
  local box = prefab:GetComponent(typeof(CS.IsometricGame.IsometricBox))
  local term = box.term
  local pos
  if term == BoxTerm.Floor then
    RemoveFurnitureImpl(m_dormFloor)
    AlterFurnCount(DU.GetFurnIdByName(m_dormFloor.name), -1)
    m_dormFloor = AddFurnitureImpl(prefabName, CS.UnityEngine.Vector3(0, 0, 0))
    succeed = true
  elseif term == BoxTerm.Wallpaper then
    RemoveFurnitureImpl(m_dormWallpaper)
    AlterFurnCount(DU.GetFurnIdByName(m_dormWallpaper.name), -1)
    m_dormWallpaper = AddFurnitureImpl(prefabName, CS.UnityEngine.Vector3(0, 0, 0))
    succeed = true
  elseif term == BoxTerm.Carpet then
    AddFurnitureImpl(prefabName, CS.UnityEngine.Vector3(0, 0, 0))
    succeed = true
  elseif term == BoxTerm.Walldecor then
    local flip = false
    pos, flip = GetNextWallDecorSparePos(box)
    if pos then
      AddFurnitureImpl(prefabName, pos, flip)
      succeed = true
    else
      succeed = false
    end
  else
    local bd = box.bound
    pos = GetNextSparePos(bd.x, bd.y)
    if pos then
      AddFurnitureImpl(prefabName, pos)
      UpdateMovableBoard()
      succeed = true
    else
      succeed = false
    end
  end
  if succeed then
    AlterFurnCount(furnId, 1)
    this:BroadcastGameEvent("DormEditFurnitureCountChange")
  end
  return succeed
end

function AddFurnitureImpl(prefabName, pos, flip)
  if flip == nil then
    flip = false
  end
  local go = InstantiateBox(prefabName)
  return AddBox(go, m_dormFloor, pos, flip)
end

function RemoveFurniture(box)
  local furnId = DU.GetFurnIdByName(box.name)
  AlterFurnCount(furnId, -1)
  if box.term == BoxTerm.Desk then
    for i = 0, box.boxChildren.size - 1 do
      local child = box.boxChildren[i]
      if child.term == BoxTerm.OnDesk then
        local furnId = DU.GetFurnIdByName(child.name)
        AlterFurnCount(furnId, -1)
      end
    end
  end
  RemoveFurnitureImpl(box)
  UpdateMovableBoard()
  this:BroadcastGameEvent("DormEditFurnitureCountChange")
end

function RemoveFurnitureImpl(box)
  Remove(box)
end

function AlterFurnCount(furnId, delta)
  local furnData = m_ownedFurnitrueMap[furnId] or {
    furnId = furnId,
    usedCount = 0,
    totalCount = this:GetData("fci/item/" .. furnId).count,
    floorUsedCountMap = {}
  }
  furnData.usedCount = furnData.usedCount + delta
  furnData.floorUsedCountMap[m_floor] = furnData.floorUsedCountMap[m_floor] or 0
  furnData.floorUsedCountMap[m_floor] = furnData.floorUsedCountMap[m_floor] + delta
end

function RemoveAllFurniture()
  RemoveAll()
  RearrangeAllBox()
  UpdateMovableBoard()
  for _, v in pairs(m_ownedFurnitrueMap) do
    local category = PB.get("FurnitureConfig", v.furnId).category
    if category ~= PB.enum.FurnitureCategory.Floor and category ~= PB.enum.FurnitureCategory.WallPaper then
      if v.floorUsedCountMap[m_floor] and v.usedCount then
        v.usedCount = v.usedCount - (v.floorUsedCountMap[m_floor] or 0)
      end
      v.floorUsedCountMap[m_floor] = 0
    end
  end
  this:BroadcastGameEvent("DormEditFurnitureCountChange")
  m_agentMap = nil
end

function GetNextSparePos(sx, sy)
  for j = 0, m_size.y do
    for i = 0, m_size.x do
      if IsMovableAtRange(i, j, i + sx - 1, j + sy - 1) then
        return CS.UnityEngine.Vector3(i, j, 0)
      end
    end
  end
end

function GetNextWallDecorSparePos(box)
  local tmpSpareListLeft = {}
  local tmpSpareListRight = {}
  local spareListLeft = {}
  local spareListRight = {}
  for i = 0, m_root.borderList.size - 1 do
    local box = m_root.borderList[i]
    if box.term == BoxTerm.Walldecor then
      local bd = box.bound
      local pos = box.isoPosition
      if bd.x == 0 then
        for j = pos.y, pos.y + bd.y - 1 do
          tmpSpareListLeft[j] = false
        end
      else
        for j = pos.x, pos.x + bd.x - 1 do
          tmpSpareListRight[j] = false
        end
      end
    end
  end
  
  local function FillSpareList(sz, tmpList, list)
    for i = 0, sz - 1 do
      if tmpList[i] == nil then
        local si = i
        local l = 0
        for j = i, sz - 1 do
          if tmpList[j] == nil then
            l = l + 1
          else
            i = j
            break
          end
        end
        table.insert(list, {offset = si, length = l})
      end
    end
  end
  
  FillSpareList(m_size.x, tmpSpareListLeft, spareListLeft)
  FillSpareList(m_size.y, tmpSpareListRight, spareListRight)
  local bd = box.bound
  local l = fif(bd.x == 0, bd.y, bd.x)
  local dir = fif(bd.x == 0, 0, 1)
  for _, v in ipairs(spareListLeft) do
    if l <= v.length then
      if dir == 0 then
        return CS.UnityEngine.Vector3(0, v.offset, 0), false
      elseif box.allowFlip then
        return CS.UnityEngine.Vector3(0, v.offset, 0), true
      end
    end
  end
  for _, v in ipairs(spareListRight) do
    if l <= v.length then
      if dir == 1 then
        return CS.UnityEngine.Vector3(v.offset, m_size.y, 0), false
      elseif box.allowFlip then
        return CS.UnityEngine.Vector3(v.offset, m_size.y, 0), true
      end
    end
  end
  return false, nil
end

function GetActorRandomSparePosList(cntActor)
  if cntActor > #m_spareActorBlock then
    return nil
  end
  local result = {}
  local tmpIdxList = {}
  for i = 1, #m_spareActorBlock do
    table.insert(tmpIdxList, i)
  end
  for i = 1, cntActor do
    local r = math.random(1, #tmpIdxList)
    table.insert(result, m_spareActorBlock[tmpIdxList[r]])
    table.remove(tmpIdxList, r)
  end
  return result
end

function AddActorImpl(pos, uid)
  local go = InstantiateBox("dormActorTemplate", "Dorm/")
  local box = go:GetComponent(typeof(CS.IsometricGame.IsometricBox))
  box.isoPosition = pos
  box:AddToRoot(m_root)
  local dynamicAgent = _ENV["$"](go).root
  m_agentMap[box] = dynamicAgent
  local actorId
  if m_inVisitMode then
    actorId = m_dormInfo.showActorsId[tostring(uid)]
  else
    actorId = this:GetData("fci/actor/" .. uid).id
  end
  if not m_inVisitMode then
    _ENV["$"](go)["@uid"] = uid
  end
  dynamicAgent["$Init"](actorId, _ENV, m_AIController)
end

function ScreenToIso2D(screenPos)
  local worldPos = REF.DormCamera.Camera:ScreenToWorldPoint(screenPos)
  local localPos = m_root.transform:InverseTransformPoint(worldPos)
  localPos.z = 0
  local isoPos = IsometricTools.CartToIso(m_root.unitSize, localPos)
  isoPos.x = Mathf.FloorToInt(isoPos.x)
  isoPos.y = Mathf.FloorToInt(isoPos.y)
  return isoPos
end

function UpdateSpareActorBlock()
  m_spareActorBlock = {}
  for i = 0, m_size.x - 2, 2 do
    for j = 0, m_size.y - 2, 2 do
      if IsMovableAtRange(i, j, i + 1, j + 1) then
        table.insert(m_spareActorBlock, {x = i, y = j})
      end
    end
  end
end

function UpdateFurnitureOwnData()
  local furnCntMap = {}
  for _, arrangement in pairs(m_dormInfo.dormArrangement) do
    local floor = arrangement.floor
    for _, furn in ipairs(arrangement.furnitures) do
      local id = furn.furnitureId
      furnCntMap[floor] = furnCntMap[floor] or {}
      furnCntMap[floor][id] = furnCntMap[floor][id] or 0
      furnCntMap[floor][id] = furnCntMap[floor][id] + 1
    end
  end
  m_ownedFurnitrueMap = _ENV["!"]({})
  local items = this:GetData("fci/item")
  for _, item in ipairs(items) do
    if PB.get("ItemInfo", item.id).type == PB.enum.ItemType.Furniture then
      local usedCount = 0
      local floorUsedCountMap = {}
      for floor, v in pairs(furnCntMap) do
        local cnt = v[item.id]
        floorUsedCountMap[floor] = cnt
        usedCount = usedCount + (cnt or 0)
      end
      m_ownedFurnitrueMap[item.id] = {
        furnId = item.id,
        usedCount = usedCount,
        totalCount = item.count,
        floorUsedCountMap = floorUsedCountMap
      }
    end
  end
end

function UpdateComfortAndExpPerHour()
  m_comfort = DU.CalcComfort()
  local dormActorExpConst = PB.index("Misc", 1).dormActorExpConst
  local seatCnt = _ENV["!"](m_dormInfo.feedSeat):where(function(k, v)
    return v ~= 0
  end):count()
  local interval = PB.index("Misc", 1).dormFoodRefreshInterval
  local actorCountConst = dormActorExpConst.actorCountConst[seatCnt] or 0
  local staticConst = dormActorExpConst.staticConst
  local playerLevelConst = dormActorExpConst.playerLevelConst
  local dormComfortConst = dormActorExpConst.dormComfortConst
  local level = this:GetData("fci/baseinfo").level
  local levelExp = staticConst + level * playerLevelConst
  local comfortRatio = 1 + m_comfort / (m_comfort + dormComfortConst)
  local actorRatio = actorCountConst
  local baseExp = levelExp * comfortRatio * actorRatio
  local extraExp = 0
  for _, v in ipairs(m_dormInfo.foodInfo) do
    local realEffectTime
    if v.expTime and v.expRatio then
      realEffectTime = math.max(SECONDS_PER_HOUR, v.expTime)
      realEffectTime = SECONDS_PER_HOUR
      extraExp = extraExp + baseExp * v.expRatio * realEffectTime
    end
  end
  m_expAddPerHour = math.floor(baseExp + extraExp)
  this:SetData("Dorm/ExpAddPerHour", m_expAddPerHour)
end

function GetDialogGo()
  for i = 0, #REF.ActorDialogs - 1 do
    local dialogGo = REF.ActorDialogs[i].root.gameObject
    if not m_dialogGoInUseMap[dialogGo] then
      m_dialogGoInUseMap[dialogGo] = true
      return dialogGo
    end
  end
end

function AgentSay(box, content, duration)
  if m_agentSayMap[box] then
    AgentStopSaying(box)
  end
  local dialogGo = GetDialogGo()
  if dialogGo then
    dialogGo:SetActive(true)
    _ENV["$"](dialogGo).LabelContent.UILabel.text = content
    m_agentSayMap[box] = {
      dialogGo = dialogGo,
      coroutine = this:DelayInvokeInSeconds(duration, function()
        if box then
          AgentStopSaying(box)
        end
      end)
    }
  else
    error("GamePlay", "ActorDialog count is too small")
  end
end

function AgentSayMore(box, configs)
  if m_agentSayMap[box] then
    AgentStopSaying(box)
  end
  local dialogGo = GetDialogGo()
  if dialogGo then
    AgentSayMoreShowText(dialogGo, configs[1].content)
    m_agentSayMap[box] = {dialogGo = dialogGo, coroutine = nil}
    AgentSayMoreMakeCoroutine(dialogGo, box, configs, 2)
  else
    error("GamePlay", "ActorDialog count is too small")
  end
end

function AgentSayMoreMakeCoroutine(dialogGo, box, configs, index)
  local content = configs[index] and configs[index].content
  local duration = configs[index - 1] and configs[index - 1].duration
  if duration == nil then
    return
  end
  m_agentSayMap[box].coroutine = this:DelayInvokeInSeconds(duration, function()
    if box == nil then
      return
    end
    if content then
      AgentSayMoreShowText(dialogGo, content)
      AgentSayMoreMakeCoroutine(dialogGo, box, configs, index + 1)
    else
      AgentStopSaying(box)
    end
  end)
end

function AgentSayMoreShowText(dialogGo, content)
  dialogGo:SetActive(true)
  if content == "" or content == nil then
    dialogGo:SetActive(false)
  else
    dialogGo:SetActive(true)
    _ENV["$"](dialogGo).LabelContent.UILabel.text = content
  end
end

function AgentStopSaying(box)
  local sayData = m_agentSayMap[box]
  if sayData then
    sayData.dialogGo:SetActive(false)
    this:StopCoroutine(sayData.coroutine)
    m_agentSayMap[box] = nil
    m_dialogGoInUseMap[sayData.dialogGo] = false
  end
end

function AgentCleanupAllSaying()
  for box, data in pairs(m_agentSayMap) do
    data.dialogGo:SetActive(false)
    this:StopCoroutine(data.coroutine)
  end
  m_agentSayMap = {}
  m_dialogGoInUseMap = {}
end

function DoGreet()
  if m_greeted then
    return
  end
  m_greeted = true
  for box, agent in pairs(m_agentMap) do
    AgentSay(box, WU.GetString("Dorm_Greeting"), 5)
  end
end

function GetAgentMap()
  return m_agentMap
end

function GetAgentInteractiveMap()
  return m_agentInteractiveMap
end

function ClearSelection()
  m_selectedBox = nil
end

function ShowFilteredFurnList(category, reset)
  if reset == nil then
    reset = false
  end
  if m_editCurrCategory then
    REF.CategoryButtons[m_editCurrCategory].root.UISprite.spriteName = "choice_bg_off"
    REF.CategoryButtons[m_editCurrCategory].SpriteIcon.UISprite.color = COLOR_WHITE
    REF.CategoryButtons[m_editCurrCategory].Label.UILabel.color = COLOR_WHITE
  end
  m_editCurrCategory = category
  REF.CategoryButtons[m_editCurrCategory].root.UISprite.spriteName = "choice_bg_on"
  REF.CategoryButtons[m_editCurrCategory].SpriteIcon.UISprite.color = COLOR_BLUE
  REF.CategoryButtons[m_editCurrCategory].Label.UILabel.color = COLOR_BLUE
  m_filteredFurnList = m_ownedFurnitrueMap:where(function(k, v)
    return PB.get("FurnitureConfig", v.furnId).category == category
  end):toarray()
  m_ownedThemeList = _ENV["!"]({})
  for themeId, furnitures in pairs(m_themeToFurnitureMap) do
    if PB.get("DormInitialTheme", themeId) ~= nil then
      m_ownedThemeList[themeId] = themeId
      for _, id in ipairs(furnitures) do
        local itemData = this:GetData("fci/item/" .. id)
        if itemData == nil or itemData.count <= 0 then
          m_ownedThemeList[themeId] = nil
          break
        end
      end
    end
  end
  m_ownedThemeList = m_ownedThemeList:toarray()
  if category == 0 then
    LU.Set(REF.WrapContentFurnList, math.min(#m_schemeList + 1, PB.index("Misc", 1).dormCustomSchemeMax) + #m_ownedThemeList, reset)
  else
    LU.Set(REF.WrapContentFurnList, #m_filteredFurnList, reset)
  end
end

function DoPopup()
  RefreshResourceAsync(function(resp)
    CheckAndPopupExpHint(resp.resChange, function(popup)
      local feedCnt = #_ENV["!"](m_dormInfo.feedSeat):where(function(k, v)
        return v ~= 0
      end):toarray()
      if not popup and m_dormInfo.foodCount <= 0 and 0 < feedCnt then
        WU.AcquireWindowAsync("DormFeedMessageBox")
      end
    end)
  end)
end

function DoRefresh()
  if m_inVisitMode then
    return
  end
  RefreshResourceAsync(function(resp)
    local expAddMap = this:GetData("Dorm/ExpAddMap") or {}
    for _, v in ipairs(resp.resChange) do
      if v.actor then
        local uid = v.actor.uid
        local oldActor = this:GetData("fci/actor/" .. uid)
        expAddMap[uid] = expAddMap[uid] or {
          uid = uid,
          old = {
            level = oldActor.level,
            exp = oldActor.curExp
          }
        }
        local data = expAddMap[uid]
        data.new = {
          level = v.actor.level,
          exp = v.actor.curExp
        }
        data.expAdd = (data.expAdd or 0) + AU.CalcExpDiff(data.old.level, data.old.exp, data.new.level, data.new.exp)
      end
    end
    this:SetData("Dorm/ExpAddMap", expAddMap)
  end)
end

function RefreshResourceAsync(callback)
  this:GameRequest("fci/dorm-refresh"):Get(function(resp)
    if m_dormInfo and m_dormInfo.foodCount ~= resp.foodCount then
      m_dormInfo.foodCount = resp.foodCount
      m_dormInfo.foodInfo = resp.foodInfo
      this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
    end
    ClearActorRewardActive()
    for _, info in ipairs(resp.giftInfo) do
      if not table.empty(info.gift) then
        local gift = info.gift[1]
        if gift.type == PB.enum.ResourceType.ResPlayerGold then
          MarkGift(info.actorUid, "Gold")
        elseif gift.type == PB.enum.ResourceType.ResItem and PB.get("ItemInfo", gift.id).funcType == PB.enum.ItemFuncType.Favour then
          MarkGift(info.actorUid, "Favour")
        else
          MarkGift(info.actorUid, "FurnMoney")
        end
      end
    end
    if callback then
      callback(resp)
    end
    DBH.ResChange(resp.resChange)
  end)
end

function CheckAndPopupExpHint(resChange, callback)
  local popup = false
  local expList = {}
  for _, v in ipairs(resChange) do
    if v.actor then
      local newExp = v.actor.curExp
      local uid = v.actor.uid
      local oldActor = this:GetData("fci/actor/" .. uid)
      local data = {
        uid = uid,
        old = {
          level = oldActor.level,
          exp = oldActor.curExp
        },
        new = {
          level = v.actor.level,
          exp = v.actor.curExp
        }
      }
      data.expAdd = AU.CalcExpDiff(data.old.level, data.old.exp, data.new.level, data.new.exp)
      table.insert(expList, data)
      if data.expAdd >= m_expAddPerHour then
        popup = true
      end
    end
  end
  if popup then
    WU.AcquireWindowAsync("DormExpHint", function(w)
      _ENV["$"](w)["$$SetData"](expList)
    end)
  end
  if callback then
    callback(popup)
  end
end

function SetEditMode(mode)
  m_inEditMode = mode
  ClearSelection()
  REF.Black.UITexture.mainTexturePath = fif(mode, "Texture/Dormitory/hostel_bg_2", "Texture/Dormitory/hostel_bg_1")
  WU.SetActive(REF.GroupTop, not m_inEditMode)
  WU.SetActive(REF.ButtonGroupManage, not m_inVisitMode and not m_inEditMode)
  WU.SetActive(REF.GroupEdit, m_inEditMode)
  WU.SetActive(REF.ButtonHideUI, not m_inEditMode)
  WU.SetActive(REF.ButtonFloor, not m_inEditMode)
  if m_inEditMode then
    UpdateFurnitureOwnData()
    ShowFilteredFurnList(PB.enum.FurnitureCategory.Normal, true)
    AgentCleanupAllSaying()
  end
  if mode then
    for _, obj in pairs(m_agentMap) do
      WU.SetActive(obj.gameObject, not m_inEditMode)
    end
    m_agentMap = nil
  end
  this:DelayInvokeInFrames(1, function()
    WU.SetNaviationBackCallback(fif(m_inEditMode, OnClickExit, nil))
  end)
end

function SetVisitMode(mode)
  if mode == nil then
    mode = false
  end
  m_inVisitMode = mode
  WU.SetWindowTitle("Dorm", fif(mode, "Dorm2", "Dorm"))
  if m_inVisitMode then
    WU.SetActive(REF.ButtonGroupVisit, true)
    WU.SetActive(REF.ButtonGroupManage, false)
    this:Unbind("fci/dorm/{playerId}", OnDormChange)
    this:StopCoroutine(m_refreshCoroutine)
    m_refreshCoroutine = nil
    this:Bind("Dorm/Host", OnHostDormChange)
  else
    WU.SetActive(REF.ButtonGroupVisit, false)
    WU.SetActive(REF.ButtonGroupManage, true)
    this:Unbind("Dorm/Host", OnHostDormChange)
    this:BindRemote(this:GameRequest("fci/dorm/{playerId}"), OnDormChange)
  end
end

function BoxSetParent(box, parent)
  box:SetParent(parent)
  if box.term == BoxTerm.OnDesk then
    if parent then
      local boxId = DU.GetFurnIdByName(box.gameObject.name)
      local parentId = DU.GetFurnIdByName(parent.gameObject.name)
      local config = PB.get("FurnitureConfig", boxId)
      local _, constrain = table.find(config.deskConstrains, function(k, v)
        return v.id == parentId
      end)
      if constrain then
        _ENV["$"](box).View["$SetSpriteSuit"](constrain.spriteSuit)
      end
    else
      _ENV["$"](box).View["$SetSpriteSuit"](nil)
    end
  end
end

function CollectGift(agentGo)
  local box = agentGo:GetComponent(typeof(CS.IsometricGame.IsometricBox))
  this:GameRequest("fci/dorm-gift/"):Post({
    actorUid = _ENV["$"](agentGo)["@uid"]
  }, function(resp)
    DBH.ResChange(resp.resChange)
    WU.SetActive(_ENV["$"](agentGo)._ActorReward, false)
    WU.ShowRewards(resp.resChange)
  end)
end

function ClearActorRewardActive()
  if m_agentMap then
    for _, v in ipairs(m_agentMap) do
      WU.SetActive(_ENV["$"](v.gameObject)._ActorReward, false)
    end
  end
end

function MarkGift(actorUid, giftType)
  local _, agent = table.find(m_agentMap, function(k, v)
    return _ENV["$"](v.gameObject)["@uid"] == actorUid
  end)
  if agent then
    local agentGo = agent.gameObject
    WU.SetActive(_ENV["$"](agent)._ActorReward, true)
    WU.SetActive(_ENV["$"](agent)._CoinFurnMoney, giftType == "FurnMoney")
    WU.SetActive(_ENV["$"](agent)._CoinGold, giftType == "Gold")
    WU.SetActive(_ENV["$"](agent)._CoinFavour, giftType == "Favour")
  end
end

function SetAppreciateUI()
  REF.LabelAppreciateCount.UILabel.text = m_dormInfo.likeNum
  REF.ButtonAppreciate.UISprite.spriteName = fif(m_dormInfo.liked, "button_praise_on", "button_praise_off")
end

function RequestAppreciate(like, callback)
  local function UpdateFrindList(playerId, likeNum)
    local _, friend = table.find(this:GetData("fci/friendlist"), function(k, v)
      return v.playerId == playerId
    end)
    if friend then
      friend.likeNum = likeNum
    end
  end
  
  if like then
    this:GameRequest("fci/dorm-like/" .. m_hostId):Post(nil, function(resp)
      m_dormInfo.likeNum = resp.likeNum
      m_dormInfo.liked = true
      UpdateFrindList()
      callback(resp)
    end)
  else
    this:GameRequest("fci/dorm-like/" .. m_hostId):Delete(function(resp)
      m_dormInfo.likeNum = resp.likeNum
      m_dormInfo.liked = false
      UpdateFrindList()
      callback(resp)
    end)
  end
end

function OnDormEditFurnitureCountChange()
  if m_inEditMode then
    ShowFilteredFurnList(m_editCurrCategory)
  end
end

function OnDraggingDorm(_, delta)
  if not m_dragging then
    OnDraggingDormStart()
  end
  local screenPos = WU.MousePosition()
  local box = HandleSelect(screenPos, false, false)
  if m_moving then
    if m_prevSelectedPos ~= m_selectedPos then
      m_prevSelectedPos = m_selectedPos
      HandleMove(screenPos, m_selectedPos, false)
    end
  else
    local x = math.clamp(REF.DormCamera.transform.localPosition.x - 0.01 * delta.x, m_cameraBound.x, m_cameraBound.z)
    local y = math.clamp(REF.DormCamera.transform.localPosition.y - 0.01 * delta.y, m_cameraBound.y, m_cameraBound.w)
    local z = REF.DormCamera.transform.localPosition.z
    REF.DormCamera.transform.localPosition = CS.UnityEngine.Vector3(x, y, z)
  end
end

function HandleSelect(screenPos, onTop, selectObj)
  local pos = REF.DormCamera.Camera:ScreenToWorldPoint(screenPos)
  local localPos = m_root.transform:InverseTransformPoint(pos)
  localPos.z = 0
  local isoPos = IsometricTools.CartToIso(m_root.unitSize, localPos)
  isoPos.x = Mathf.FloorToInt(isoPos.x)
  isoPos.y = Mathf.FloorToInt(isoPos.y)
  m_selectedPos = isoPos
  local canPlace = false
  local box = m_board:GetBoxByGrid(m_selectedPos.x, m_selectedPos.y, false)
  if box then
    if box.term == BoxTerm.OnDesk then
      if onTop then
        localPos.z = box.isoPosition.z
        m_selectedPos = IsometricTools.CartToIso(box.unitSize, localPos)
      else
        local stack = m_board:GetBoxListByGrid(m_selectedPos.x, m_selectedPos.y, false)
        if stack and 0 < stack.size then
          box = stack[0]
          for i = stack.size - 1, 0, -1 do
            if stack[i].term == BoxTerm.Desk then
              box = stack[i]
              break
            end
          end
        end
      end
    end
    if box.term == BoxTerm.Desk and m_selectedBox and m_selectedBox.term == BoxTerm.OnDesk then
      for i = 0, box.placeArea2D.Length - 1 do
        local grid = box.placeArea2D[i]
        if grid.x == m_selectedPos.x and grid.y == m_selectedPos.y then
          localPos.z = box.bound.z
          canPlace = true
          break
        end
      end
      if canPlace then
        m_selectedPos = IsometricTools.CartToIso(box.unitSize, localPos)
      end
    end
    m_selectedPos.x = Mathf.FloorToInt(m_selectedPos.x)
    m_selectedPos.y = Mathf.FloorToInt(m_selectedPos.y)
    m_selectedPos.z = Mathf.FloorToInt(m_selectedPos.z)
  end
  if selectObj and box then
    if m_inVisitMode then
      return
    end
    if not m_inEditMode and box.term ~= BoxTerm.Dynamic then
      return
    end
    m_selectedBox = box
    DeactiveAllGrid()
  end
  return box
end

function HandleMove(screenPos, pos, putDown)
  local bdRaw = m_selectedBox.boundRaw
  if m_selectedBox.term == BoxTerm.Walldecor then
    local isoPos2D = ScreenToIso2D(screenPos)
    if isoPos2D.x + isoPos2D.y < m_size.x then
      pos.x = 0
      if bdRaw.x == 0 then
        m_selectedBox.flip = false
      elseif bdRaw.y == 0 then
        m_selectedBox.flip = true
      end
    else
      pos.y = m_size.y
      if bdRaw.x == 0 then
        m_selectedBox.flip = true
      else
        m_selectedBox.flip = false
      end
    end
    pos.z = 0
  end
  pos.x = math.clamp(pos.x, 0, m_size.x - m_selectedBox.bound.x)
  pos.y = math.clamp(pos.y, 0, m_size.y - m_selectedBox.bound.y)
  local valid = Move(m_selectedBox, pos)
  local stack = m_board:GetBoxListByGrid(pos.x, pos.y, false)
  local targetDesk
  local targetOnDesks = {}
  if m_selectedBox.term == BoxTerm.Dynamic then
    if stack and stack.size > 1 then
      for i = stack.size - 1, 0, -1 do
        if stack[i] ~= m_selectedBox and stack[i].term ~= BoxTerm.Floor and stack[i].term ~= BoxTerm.Carpet and IsometricTools.BoxInner(m_selectedBox, stack[i]) then
          valid = false
        end
        if CanInteractive(stack[i]) then
          valid = true
          break
        end
      end
    end
    m_agentMap[m_selectedBox]["$EnterState"](AI.AGENT_STATE.Control)
  elseif valid and m_selectedBox.term == BoxTerm.OnDesk then
    targetDesk = stack[0]
    for i = stack.size - 1, 0, -1 do
      if stack[i].term == BoxTerm.Desk then
        targetDesk = stack[i]
        break
      end
    end
    if targetDesk.term == BoxTerm.Desk then
      valid = targetDesk:CanPlacedOn(pos)
      if valid then
        local furnId = DU.GetFurnIdByName(m_selectedBox.gameObject.name)
        local deskId = DU.GetFurnIdByName(targetDesk.gameObject.name)
        valid = DU.CheckDeskSuit(furnId, deskId)
      end
    end
  elseif valid and m_selectedBox.term == BoxTerm.Desk and m_selectedBox.bound.z == 0 then
    local deskId = DU.GetFurnIdByName(m_selectedBox.gameObject.name)
    for i = 0, m_root.boxList.size - 1 do
      local box = m_root.boxList[i]
      if box ~= m_selectedBox and box.term == BoxTerm.OnDesk and IsometricTools.BoxInner(box, m_selectedBox) then
        local boxId = DU.GetFurnIdByName(box.gameObject.name)
        if DU.CheckDeskSuit(boxId, deskId) then
          table.insert(targetOnDesks, box)
        else
          valid = false
          break
        end
      end
    end
  end
  DeactiveAllGrid()
  if putDown then
    if valid then
      if stack and stack.size > 1 then
        if m_selectedBox.term == BoxTerm.OnDesk then
          BoxSetParent(m_selectedBox, fif(targetDesk.term == BoxTerm.Desk, targetDesk, nil))
        elseif m_selectedBox.term == BoxTerm.Dynamic then
          local targetBox = stack[0]
          for i = stack.size - 1, 0, -1 do
            if CanInteractive(stack[i]) then
              targetBox = stack[i]
              break
            end
          end
          if targetBox.allowInteractive then
            DU.TranslateActorToInteractiveFurn(m_selectedBox, targetBox)
            m_agentMap[m_selectedBox]["$InteractiveFurn"](targetBox)
          else
            BoxSetParent(m_selectedBox, nil)
            m_agentMap[m_selectedBox]["$EnterState"](AI.AGENT_STATE.Idle)
          end
          RearrangeAllBox()
        elseif m_selectedBox.term == BoxTerm.Desk and m_selectedBox.bound.z == 0 then
          for i = 1, #targetOnDesks do
            BoxSetParent(targetOnDesks[i], m_selectedBox)
          end
        end
      else
        BoxSetParent(m_selectedBox, nil)
        if m_selectedBox.term == BoxTerm.Dynamic then
          m_agentMap[m_selectedBox]["$EnterState"](AI.AGENT_STATE.Idle)
          RearrangeAllBox()
        end
      end
      UpdateMovableBoard()
    else
      if m_selectedBox.term == BoxTerm.Walldecor then
        m_selectedBox.flip = m_originalFlip
      elseif m_selectedBox.term == BoxTerm.Dynamic then
        if m_originalAgentState == AI.AGENT_STATE.Furniture then
          m_agentMap[m_selectedBox]["$InteractiveFurn"](m_originalAgentFurnBox)
        else
          m_agentMap[m_selectedBox]["$EnterState"](AI.AGENT_STATE.Idle)
        end
      end
      Move(m_selectedBox, m_originalPos)
    end
  else
    local grids = {}
    local gridsLength
    if m_selectedBox.term == BoxTerm.Walldecor then
      local bound = m_selectedBox.bound
      local boxPos = m_selectedBox.isoPosition
      if bound.x == 0 then
        gridsLength = bound.y
        for i = 0, bound.y - 1 do
          grids[i] = boxPos + i * CS.UnityEngine.Vector3.up
        end
      else
        gridsLength = bound.x
        for i = 0, bound.x - 1 do
          grids[i] = boxPos + i * CS.UnityEngine.Vector3.right
        end
      end
    else
      grids = m_selectedBox:GetOcclusion(false)
      gridsLength = grids.Length
    end
    local style = fif(m_selectedBox.term == BoxTerm.Walldecor, fif(m_selectedBox.bound.x == 0, GridStyle.FlippedWall, GridStyle.Wall), GridStyle.Normal)
    for i = 0, gridsLength - 1 do
      local grid = grids[i]
      ActiveGrid(grid.x, grid.y, true, fif(valid, GRID_COLOR_NORMAL, GRID_COLOR_ERROR), style, fif(m_selectedBox.bound.z == 0, 99, 999))
    end
    if m_selectedBox.term == BoxTerm.Dynamic then
      _ENV["$"](m_selectedBox).View["$SetSortingOrder"](32700)
    end
  end
end

function OnDraggingDormStart()
  m_dragging = true
  local box = HandleSelect(WU.MousePosition(), true, not m_inEditMode)
  m_moving = m_selectedBox and m_selectedBox == box and m_selectedBox.term ~= BoxTerm.Floor and m_selectedBox.term ~= BoxTerm.Wallpaper
  if m_moving then
    m_originalPos = m_selectedBox.isoPosition
    m_originalFlip = m_selectedBox.flip
    if m_agentMap then
      local agent = m_agentMap[m_selectedBox]
      if agent then
        m_originalAgentState = m_agentMap[m_selectedBox]["$GetState"]()
        m_originalAgentFurnBox = m_agentMap[m_selectedBox]["$GetFurnBox"]()
      end
    end
  end
end

function OnDragStart()
end

function OnDragEnd()
  if m_moving then
    HandleMove(WU.MousePosition(), m_selectedPos, true)
  end
  m_dragging = false
  m_moving = false
end

function OnPressDorm(_, pressed)
  if pressed then
    OnDragStart()
  else
    OnDragEnd()
  end
end

function OnClickDorm()
  if m_inVisitMode then
    return
  end
  local screenPos = WU.MousePosition()
  local box = HandleSelect(screenPos, true, true)
  local obj = CS.GameUtility.PickObjectByCamera(REF.DormCamera.Camera, CS.UnityEngine.LayerMask.NameToLayer("Default"), screenPos)
  if obj and obj.name == "_ActorReward" then
    CollectGift(obj.transform.parent.parent.gameObject)
    return
  end
  if box then
    if box.term == BoxTerm.Floor or box.term == BoxTerm.Wallpaper then
      ClearSelection()
    end
  elseif not m_inEditMode and (m_selectedPos.x >= m_size.x and m_selectedPos.x < m_size.x + 4 and m_selectedPos.y >= 0 and m_selectedPos.y < m_size.y or m_selectedPos.x >= 0 and m_selectedPos.x < m_size.x + 4 and m_selectedPos.y >= -4 and m_selectedPos.y < 0) and m_floorLevel < DORM_MAX_FLOOR_LEVEL then
    DU.ShowExtendFloorMessage(function()
      WU.ShowHintText("Dorm_UpgradeDormSucceed")
    end)
  end
end

function OnClickRemove()
  RemoveFurniture(m_selectedBox)
  ClearSelection()
end

function OnClickOK()
  ClearSelection()
end

function OnClickFlip()
  if not Flip(m_selectedBox) then
    WU.ShowHintText(WU.GetString("Dorm_FlipFail"))
  end
end

function OnClickEdit()
  SetEditMode(not m_inEditMode)
end

function OnClickClear()
  RemoveAllFurniture()
  ClearSelection()
end

function OnClickSave()
  if not m_arrSuccFlag then
    WU.ShowHintText("Dorm_SaveArrangementError")
    return
  end
  local arrangement = DU.GetLuaArrangement(m_root, m_floor)
  DU.RequestSaveArrangement({arrangement}, function()
    WU.ShowHintText("Dorm_SaveSucceed")
  end)
end

function OnClickExit()
  WU.ShowMessageYesNo(WU.GetString("Dorm_SaveHint"), function(result)
    if result == "YES" then
      Reload()
    end
  end)
end

function OnClickShowSeat()
  WU.AcquireWindowAsync("DormActorSelectShow")
end

function OnClickShop()
  WU.AcquireWindowAsync("DormShop")
end

function OnFilterCategoryClick(go)
  ShowFilteredFurnList(_ENV["$"](go)["@category"], true)
end

function OnClickFurnCardFurn(go)
  local furnId = _ENV["$"](go)["@furnId"]
  local furnData = m_ownedFurnitrueMap[furnId]
  local schemeId = _ENV["$"](go)["@schemeId"]
  local themeId = _ENV["$"](go)["@themeId"]
  if furnData and furnData.usedCount < furnData.totalCount then
    if CheckFurnCountReachMax(furnId) then
      WU.ShowHintText(WU.GetString("Dorm_FurnCountReachMax"))
    else
      local succeed = AddFurniture(furnId)
      if not succeed then
        WU.ShowHintText("Dorm_AddFurnitureFail")
      end
    end
  elseif schemeId then
    WU.AcquireWindowAsync("DormCustomScheme", function(w)
      _ENV["$"](w)["$$SetData"](schemeId, m_root, m_floor)
    end)
  elseif themeId then
    local canUse, dormArrangement = CheckFurnCountCanUse(themeId)
    WU.ShowMessageYesNo(WU.GetString(fif(canUse, "Dorm_ReplaceThemeCanUse", "Dorm_ReplaceThemeCannotUse")), function(result)
      if result == "YES" then
        DU.RequestSaveArrangement(dormArrangement, function()
          WU.ShowHintText("Dorm_ApplyThemeSucceed")
        end)
      end
    end)
  end
end

function CheckFurnCountCanUse(themeId)
  local themeFurnitures = PB.get("DormInitialTheme", themeId).arrangement.furnitures
  local dormArrangement = _ENV["!"](m_dormInfo.dormArrangement):duplicate(true)
  local canUse = true
  local needCountMap = {}
  local provideCountMap = {}
  local extraNeedCountMap = {}
  for _, furn in ipairs(themeFurnitures) do
    local furnId = furn.furnitureId
    needCountMap[furnId] = (needCountMap[furnId] or 0) + 1
    local furnCntData = m_ownedFurnitrueMap[furnId]
    if furnCntData and provideCountMap[furnId] == nil then
      local otherCnt = 0
      for floor, cnt in pairs(furnCntData.floorUsedCountMap) do
        if floor ~= m_floor then
          otherCnt = otherCnt + cnt
        end
      end
      provideCountMap[furnId] = furnCntData.totalCount - otherCnt
    end
    if provideCountMap[furnId] == nil then
      error("GamePlay", "furniture is not in the theme, id: " .. furnId)
    end
    local extraNeedCount = needCountMap[furnId] - provideCountMap[furnId]
    if 0 < extraNeedCount then
      canUse = false
      extraNeedCountMap[furnId] = extraNeedCount
    end
  end
  for _, arrangement in ipairs(dormArrangement) do
    if arrangement.floor ~= m_floor then
      local needRelayout = false
      local furnListLen = #arrangement.furnitures
      for i = 1, furnListLen do
        local otherFurn = arrangement.furnitures[i]
        local otherFurnId = otherFurn.furnitureId
        if extraNeedCountMap[otherFurnId] and 0 < extraNeedCountMap[otherFurnId] then
          local category = PB.get("FurnitureConfig", otherFurnId).category
          if category == PB.enum.FurnitureCategory.Floor then
            otherFurn.furnitureId = 100001
          elseif category == PB.enum.FurnitureCategory.Wallpaper then
            otherFurn.furnitureId = 100002
          else
            arrangement.furnitures[i] = nil
            needRelayout = true
          end
          extraNeedCountMap[otherFurnId] = extraNeedCountMap[otherFurnId] - 1
        elseif otherFurn.parent ~= -1 then
          local parent = arrangement.furnitures[otherFurn.parent]
          if parent == nil or extraNeedCountMap[parent.furnitureId] > 0 then
            needRelayout = true
            arrangement.furnitures[i] = nil
          end
        end
      end
      if needRelayout then
        local parentMap = {}
        for i = 1, furnListLen do
          local furn = arrangement.furnitures[i]
          if furn and furn.parent ~= -1 then
            parentMap[furn] = arrangement.furnitures[i]
          end
        end
        arrangement.furnitures = _ENV["!"](arrangement.furnitures):toarray()
        for i = 1, #arrangement.furnitures do
          local furn = arrangement.furnitures[i]
          local parentIdx = table.find(arrangement.furnitures, function(k, v)
            return v == parentMap[furn]
          end)
          furn.parent = parentIdx or -1
        end
      end
    end
  end
  local idx = table.find(dormArrangement, function(k, v)
    return v.floor == m_floor
  end)
  dormArrangement[idx].furnitures = themeFurnitures
  return canUse, dormArrangement
end

function CheckFurnCountReachMax(furnId)
  local count = 0
  local category = PB.get("FurnitureConfig", furnId).category
  local dormConfig = PB.get("DormConfig", m_dormInfo.dormLevel)
  local _, config = table.find(PB.get("DormFloorConfig", m_floorLevel).limits, function(k, v)
    return v.category == category
  end)
  local maxCount = config and config.limit or 0
  if maxCount <= 0 then
    return false
  end
  for id, data in pairs(m_ownedFurnitrueMap) do
    if PB.get("FurnitureConfig", id).category == category then
      count = count + (data.floorUsedCountMap[m_floor] or 0)
    end
  end
  return maxCount <= count
end

function OnClickChangeFloor()
  SetEditMode(false)
  local floor = math.floor(tonumber(REF.InputFloorLabel.UILabel.text))
  this:SetData("Dorm/CurrentFloor", floor)
end

function OnClickDormName()
  local misc = PB.index("Misc", 1)
  local cost = PB.get("DormExtensionCost", PB.enum.DormExtensionType.Rename, 0).cost[1]
  local costHtml = WU.GetString("Window_Free")
  local enough = WU.IsEnoughMoney(cost.count, cost.type)
  if m_dormInfo.notFirstRename then
    costHtml = string.format("<img src='ResIcon_s.%s_%s'>&nbsp;%s", PB.enum.ResourceType.__keys[cost.type], cost.id, HU.ApplyFontColor(cost.count, fif(enough, "#2B487F", "#FD5454")))
  end
  WU.ShowEditBox({
    title = WU.GetString("Dorm_Rename"),
    subTitle = "DIALOG",
    tips = WU.GetString("Window_CharacterLimit", misc.dormMaxNameLen),
    costEx = costHtml,
    characterLimit = misc.dormMaxNameLen
  }, OnConfirmRename)
end

function OnConfirmRename(name)
  if string.match(name, "[/?#\\\"]") then
    WU.ShowHintText(WU.GetString("Window_RenameIllegal"))
    return false
  elseif name == m_dormInfo.dormName then
    WU.ShowHintText(WU.GetString("Window_RenameEquals"))
    return false
  else
    local cost = PB.get("DormExtensionCost", PB.enum.DormExtensionType.Rename, 0).cost[1]
    local enough = WU.IsEnoughMoney(cost.count, cost.type)
    if m_dormInfo.notFirstRename and enough or not m_dormInfo.notFirstRename then
      this:GameRequest("fci/dorm-rename"):Post({newName = name}, function(resp)
        DBH.ResChange(resp.resChange)
        m_dormInfo.dormName = name
        m_dormInfo.notFirstRename = true
        this:SetData("fci/dorm/{playerId}", {dormInfo = m_dormInfo})
      end)
      return true
    else
      WU.ShowHintText(WU.GetString("Dorm_RenameCostNotEnough"))
      return false
    end
  end
  return true
end

function OnClickFeed()
  Uninit()
  WU.AcquireWindowAsync("DormFeed")
end

function OnClickVisit()
  WU.AcquireWindowAsync("DormVisit")
end

function OnClickFloor()
  WU.AcquireWindowAsync("DormFloorMessageBox")
end

function OnClickShare()
  WU.RecordButtonClick(901)
  this:SetData("ShareConfig", {
    shareName = "Dorm",
    fromWindow = WU.TopWindow() and WU.TopWindow().name
  })
  WU.SetActive(REF.BaseUI, false)
  WU.SetActive(REF.ButtonHideUI, false)
  WU.AcquireWindowAsync("Share")
end

function UpdateFurnCard(goRef, wrapIndex, realIndex)
  goRef["@furnId"] = nil
  goRef["@schemeId"] = nil
  goRef["@themeId"] = nil
  if m_editCurrCategory == 0 then
    local maxCnt = PB.index("Misc", 1).dormCustomSchemeMax
    local maxIdx = math.min(#m_schemeList + 1, maxCnt)
    if m_schemeList ~= nil and realIndex ~= nil and realIndex < maxIdx + #m_ownedThemeList then
      if maxCnt > #m_schemeList and realIndex + 1 == maxIdx then
        goRef["@schemeId"] = 0
        goRef["$$SetNewScheme"]()
      elseif realIndex + 1 <= #m_schemeList then
        local schemeData = m_schemeList[realIndex + 1]
        goRef["@schemeId"] = schemeData.arrangementUid
        goRef["$$SetScheme"](schemeData)
      else
        local themeId = m_ownedThemeList[realIndex + 1 - maxIdx]
        goRef["@themeId"] = themeId
        goRef["$$SetTheme"](themeId)
      end
    end
  elseif m_filteredFurnList ~= nil and realIndex ~= nil and realIndex < #m_filteredFurnList then
    local furnData = m_filteredFurnList[realIndex + 1]
    goRef["@furnId"] = furnData.furnId
    goRef["$$SetFurniture"](furnData)
  end
  goRef["$$SetClickCallback"](OnClickFurnCardFurn)
end

function OnClickAppreciate()
  RequestAppreciate(not m_dormInfo.liked, SetAppreciateUI)
end

function OnClickAddFriend()
  this:GameRequest("fci/applyfriend/"):Post({targetId = m_hostId}, function(resp)
    WU.ShowHintText(WU.GetString("Window_SendFriendApply"))
  end)
end

function OnClickNextPlayer()
  this:GameRequest("fci/dorm-visitor/"):Post(nil, function(resp)
    DB:SetData("Dorm/Host", resp)
  end)
end

function OnClickExitVisit()
  SetVisitMode(false)
end

function OnClickHideUI()
  if m_hideUIFlag == nil then
    m_hideUIFlag = false
  end
  m_hideUIFlag = not m_hideUIFlag
  WU.SetActive(REF.BaseUI, not m_hideUIFlag)
  WU.ToggleTopBar("Dorm", not m_hideUIFlag)
  REF.ButtonHideUI.UISprite.spriteName = fif(m_hideUIFlag, "close_ui", "open_ui")
end

function OnPressComfortDetail(go, pressed)
  WU.SetActive(REF.ComfortBuffHint, pressed)
end
