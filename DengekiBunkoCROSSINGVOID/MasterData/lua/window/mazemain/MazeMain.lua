local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local CO = require("Common/Coroutine")
local U = require("Common/Util")
local IU = require("Common/ItemUtil")
local m_buffRowList, m_curFloor, m_refMapUi, m_width, m_triggerCall, m_selectedActors
local m_scrollView = REF.LayerScrollView.UIScrollView
local m_scrollViewPanel = REF.LayerScrollView.UIPanel
local m_bGMovePos = CS.UnityEngine.Vector3.one
local m_curScrollViewPos = {}
local m_balance, m_skeletonAnim, m_moveData, m_isMoving, m_mazeId, m_init, m_isFirstMazeIn, m_mazeActivityId, m_playTween, m_mazeBuffIndex, m_chaosValue, m_mazeResourceId
local effectEndSound = "Sound/system/s_System_MazeExit"
local effectEventSound = {}
effectEventSound[PB.enum.MazeEventType.MazeEvent_Fight] = "Sound/system/s_System_MazeBossFight"
effectEventSound[PB.enum.MazeEventType.MazeEvent_Boss] = "Sound/system/s_System_MazeBossFight"
effectEventSound[PB.enum.MazeEventType.MazeEvent_Story] = "Sound/system/s_System_MazeQuiz"
effectEventSound[PB.enum.MazeEventType.MazeEvent_Camp] = "Sound/system/s_System_MazeCamp"
effectEventSound[PB.enum.MazeEventType.MazeEvent_Shop] = "Sound/system/s_System_MazeShop"

function SetupWindow()
  LU.Bind(REF.BuffWrapContent, {
    updateRow = UpdateBuffRowCell
  })
  WU.BindButtonEvent(REF.ButtonCure, function()
    WU.TryToPay(PB.enum.ResourceType.ResItem, 92000, 1, function()
      this:GameRequest("fci/Maze/use-chaos-recovery/" .. m_mazeActivityId .. "/"):Post({
        items = {
          type = PB.enum.ResourceType.ResItem,
          id = 92000,
          count = 1
        }
      }, function(result)
        if result then
          WU.ShowHintText(WU.GetString("Maze_ChaosRecovered", math.max(m_chaosValue - result.chaosValue, 0)))
          DBH.ResChange(result.resChange)
          UpdateChaosValue(result.chaosValue)
        end
      end)
    end, function()
      WU.ShowHintText(WU.GetString("Maze_NoChaosCure"))
    end)
  end)
  WU.BindButtonEvent(REF.ButtonBag, function()
    WU.AcquireWindowAsync("MazeBag")
  end)
  WU.BindButtonEvent(REF.ButtonReward, function()
    WU.ShowMessageYesNo(WU.GetString("Maze_CloseAllTips"), function(result)
      if result == "YES" then
        ClickReward()
      end
    end)
  end)
  WU.BindButtonEvent(REF.ButtonGroupShow, function()
    WU.AcquireWindowAsync("MazeNewActorSelect", function(window)
      _ENV["$"](window)["$$SetMode"](3)
    end)
  end)
  WU.BindPressEvent(REF.ButtonPollutionTips, function(go, pressed)
    if pressed then
      REF.SpritePollutionTips.gameObject:SetActive(true)
    else
      REF.SpritePollutionTips.gameObject:SetActive(false)
    end
  end)
  WU.TraverseChildren(REF.NodeHollowShow, function(go, index)
    WU.BindButtonEvent(go, function()
      WU.AcquireWindowAsync("MazeInterEvent", function(window)
        _ENV["$"](window)["$$SetMazeHollow"]()
      end)
    end)
  end)
end

function ClickReward()
  this:GameRequest("fci/Maze/ReceivePrize/" .. m_mazeActivityId .. "/"):Post({}, function(result)
    if result then
      DBH.ResChange(result.resChange)
      ClearMazeCache()
      WU.AcquireWindowAsync("MazeAllBalance", function(window)
        _ENV["$"](window)["$$SetData"](result)
        WU.RecycleWindow("MazeInterEvent")
        WU.RecycleWindow(this)
      end)
    end
  end)
end

function ClearMazeCache()
  if m_refMapUi then
    m_refMapUi["$$ClearCache"]()
  end
  DestroyCurMaze()
  local actors = this:GetData("MazeActors")
  if actors then
    for i, v in ipairs(actors) do
      this:SetData("fci/mazeactor/" .. v.uid, nil)
    end
  end
  this:SetData("MazeActors", nil)
  this:SetData("fci/Maze/Actor/" .. m_mazeActivityId .. "/", nil)
  this:SetData("fci/Maze/FightActorGroup/", nil)
  this:SetData("fci/Maze/Hollow/" .. m_mazeActivityId .. "/", nil)
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  ChangeMoveFlag(false)
  m_init = true
  this:Bind("fci/MazeId/" .. m_mazeActivityId .. "/", SetMazeId)
  this:Unbind("fci/MazeInfo/", OnUpdateMazeInfo)
  this:Bind("fci/MazeInfo/", OnUpdateMazeInfo)
  this:RegisterGameEvent("MazeMove", OnMazeMove)
  REF.SpritePollutionTips.gameObject:SetActive(false)
  REF.NodePollution.gameObject:SetActive(false)
  REF.NodeRewards.gameObject:SetActive(false)
  REF.NodeHollowShow.gameObject:SetActive(false)
  REF.LabelStock.ResourcePrinter:SetResource(11, 55004)
  local key = "fci/Maze/Actor/" .. m_mazeActivityId .. "/"
  this:SetData(key, nil)
  this:Unbind(key)
  this:BindRemote(DB:GameRequest(key), function(res)
    if res == nil then
      return
    end
    m_selectedActors = res.selectActors
    AU.OnGetMazeActorPool(res)
    DB:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Get(function(result)
      this:SetData("fci/Maze/FightActorGroup/", result)
    end)
  end)
  if m_mazeActivityId == 34002 then
    SetResourcesIcon()
  end
  REF.NodePollution.gameObject:SetActive(m_mazeActivityId == 34001)
  REF.NodeRewards.gameObject:SetActive(m_mazeActivityId == 34002)
  if WU.GetGameDataCache("Maze/TutorialShow" .. DB:GetData("playerId")) ~= true then
    this:DelayInvokeEndOfFrame(function()
      WU.AcquireWindowAsync("MazeTutorial")
    end)
  end
  this:BindRemote(DB:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"), OnRefreshData)
  this:Bind("fci/mazeHollow/", OnRefreshHollows)
end

function OnRefreshHollows(result)
  local hollowList = {}
  if result and not table.empty(result) then
    for k, v in pairs(result) do
      if v and v.count > 0 then
        table.insert(hollowList, v)
      end
    end
    for i = 1, #REF.NodeHollowShow do
      if hollowList[i] then
        REF.NodeHollowShow[i - 1].root.UITexture.mainTexturePath = "Texture/hollowicon/hollow_icon_show_" .. hollowList[i].id
        REF.NodeHollowShow[i - 1].root.gameObject:SetActive(true)
      else
        REF.NodeHollowShow[i - 1].root.gameObject:SetActive(false)
      end
    end
    REF.NodeHollowShow.gameObject:SetActive(true)
  end
end

function UninitWindow()
end

function SetResourcesIcon()
  this:Bind("fci/resource/ResMazePoint_0", function(data)
    SetIcon(REF.RewardsGrid[4], PB.enum.ResourceType.ResMazePoint, 0, data)
  end)
  this:Bind("fci/item/91001", function(data)
    SetIcon(REF.RewardsGrid[0], PB.enum.ResourceType.ResItem, 91001, data.count)
  end)
  this:Bind("fci/item/91002", function(data)
    SetIcon(REF.RewardsGrid[1], PB.enum.ResourceType.ResItem, 91002, data.count)
  end)
  this:Bind("fci/item/91003", function(data)
    SetIcon(REF.RewardsGrid[2], PB.enum.ResourceType.ResItem, 91003, data.count)
  end)
  this:Bind("fci/item/55004", function(data)
    SetIcon(REF.RewardsGrid[3], PB.enum.ResourceType.ResItem, 55004, data.count)
  end)
end

function SetIcon(ref, type, id, count)
  ref.root.AnimatedAlpha.alpha = fif(count == 0, 0.5, 1)
  ref.LabelCount.UILabel.text = count
  local texturePath = IU.GetResourceIconPath(type, id)
  if texturePath then
    ref.TextureIcon.UITexture.mainTexturePath = texturePath
  end
  WU.BindButtonEvent(ref.root, function()
    WU.ShowResourceDetail(type, id)
  end)
end

function GetActorsByRangeType(rangeType)
  if rangeType == PB.enum.MazeBuffRange.AllActor then
    local actors = this:GetData("MazeActors")
    if actors == nil then
      actors = {}
    end
    return actors
  else
    local actors = {}
    local temp = this:GetData("fci/Maze/FightActorGroup/")
    if temp then
      temp = temp["1"]
      for i, v in ipairs(temp.members) do
        local t = {}
        t.uid = v.actorUid
        actors[#actors + 1] = t
      end
      return actors
    end
  end
end

function DoBuff(buffId, influenceRound, newBuff)
  local mazeInfo = PB.get("MazeBuff", buffId)
  if mazeInfo then
    if mazeInfo.type == PB.enum.MazeBuffType.AttrChange then
      if mazeInfo.param.type == PB.enum.AttrType.Hp and newBuff == buffId then
        local actors = GetActorsByRangeType(mazeInfo.range)
        for i2, actor in ipairs(actors) do
          local actorWrap = this:GetData("fci/mazeactor/" .. actor.uid)
          if actorWrap then
            actorWrap.hp = mazeInfo.param.value + actorWrap.hp
          end
        end
      end
    elseif mazeInfo.type == PB.enum.MazeBuffType.MpChange then
      local temp = this:GetData("fci/Maze/FightActorGroup/")
      temp.energyMp = temp.energyMp + mazeInfo.param.value * influenceRound
    elseif mazeInfo.type == PB.enum.MazeBuffType.SpChange then
      local temp = this:GetData("fci/Maze/FightActorGroup/")
      temp.energySp = temp.energySp + mazeInfo.param.value * influenceRound
    end
  else
    warning("Debug", "no mazebuff id:" .. buffId)
  end
end

function DoBuffList(data)
  for i, v in ipairs(data.influenceBuff) do
    DoBuff(v.buffId, v.influenceRound, data.newBuff)
  end
end

function UpdateBuffData(data)
  local buffMap = {}
  if data.curBuff then
    for i, v in ipairs(data.curBuff) do
      if v.buffId > 0 then
        local buffInfo = PB.get("MazeBuff", v.buffId)
        if buffInfo then
          v.isAll = buffInfo.range == PB.enum.MazeBuffRange.MazeBuffRange_AllActor
          buffMap[v.buffId] = v
        end
      end
    end
  end
  local mazeInfo = this:GetData("fci/MazeInfo/")
  if mazeInfo then
    mazeInfo.curBuff = data.curBuff
  end
  local isEnterNext = data.mazeMapDimension and 0 < data.mazeMapDimension
  if not isEnterNext then
    local temp = this:GetData("MazeBuff")
    if temp then
      for k, v in pairs(temp) do
        if v.buffId and v.buffId > 0 then
          local buffInfo = PB.get("MazeBuff", v.buffId)
          if buffInfo and (buffInfo.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_MapCell or buffInfo.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_MapBattle) then
            buffMap[v.buffId] = v
          end
        end
      end
    end
  end
  if data.mazeMapBuffId and 0 < data.mazeMapBuffId then
    local buff = {}
    buff.buffId = data.mazeMapBuffId
    buff.leftRound = -1
    buff.isAll = true
    buffMap[data.mazeMapBuffId] = buff
  end
  this:SetData("MazeBuff", buffMap)
end

function DoMapBuff(ways)
  if ways and 0 < ways then
    local temp = this:GetData("MazeBuff")
    if temp then
      for k, v in pairs(temp) do
        if v.buffId and 0 < v.buffId then
          local buffInfo = PB.get("MazeBuff", v.buffId)
          if buffInfo and buffInfo.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_MapCell then
            DoBuff(v.buffId, ways)
          end
        end
      end
    end
  end
end

function OnMazeMove(data)
  m_moveData = data
  SetPlayerIndex(data.mazeInfo.playerCellIndex)
  CO.coroutine_call(Move, this)()
end

function Move()
  if m_refMapUi then
    m_refMapUi.Mask.gameObject:SetActive(true)
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
    ChangeMoveFlag(true)
    
    local function Fuc(pos1, pos2, delta)
      return math.abs(pos1.x - pos2.x) > math.abs(delta.x) and math.abs(pos1.y - pos2.y) > math.abs(delta.y)
    end
    
    local speed = PB.all("Misc")[1].mazeMiscConf.mazeRoleSpeed
    local movePathList = {}
    table.copy(m_moveData.way, movePathList, true)
    local lastIndex = movePathList[1]
    table.remove(movePathList, 1)
    m_scrollView:DisableSpring()
    m_skeletonAnim.AnimationState:SetAnimation(0, "walk", true)
    local waitCam = false
    local overlaped, moveDistance = CheckOverlap(REF.RoleBounder.UIWidget)
    waitCam = overlaped
    while movePathList and 0 < #movePathList do
      ShopVisual()
      overlaped, moveDistance = CheckOverlap(REF.RoleBounder.UIWidget)
      if overlaped == true and waitCam then
        m_skeletonAnim.AnimationState:SetAnimation(0, "idle", true)
        CamFollow()
        waitCam = false
        m_skeletonAnim.AnimationState:SetAnimation(0, "walk", true)
      end
      if movePathList[1] - lastIndex == -1 or 1 < movePathList[1] - lastIndex then
        m_refMapUi.SkeletonActor.transform.localScale = CS.UnityEngine.Vector3.one
      elseif movePathList[1] - lastIndex == 1 or movePathList[1] - lastIndex < -1 then
        m_refMapUi.SkeletonActor.transform.localScale = CS.UnityEngine.Vector3(-1, 1, 0)
      end
      local newPos = m_refMapUi["Slot" .. movePathList[1]].transform.localPosition
      local oldPos = m_refMapUi.SkeletonActor.transform.localPosition
      local delta = (newPos - oldPos) / speed
      while Fuc(newPos, m_refMapUi.SkeletonActor.transform.localPosition, delta) do
        m_refMapUi.SkeletonActor.transform.localPosition = m_refMapUi.SkeletonActor.transform.localPosition + delta
        if not waitCam then
          overlaped, moveDistance = CheckOverlap(REF.RoleBounder.UIWidget)
          if overlaped then
            m_scrollView:MoveRelative(-delta)
          end
        end
        CO.yield_return(CS.UnityEngine.WaitForSeconds(0.023))
      end
      lastIndex = movePathList[1]
      table.remove(movePathList, 1)
      CS.SoundManager.Instance:PlaySound("Sound/effect/move/foot_step01")
    end
    m_skeletonAnim.AnimationState:SetAnimation(0, "idle", true)
    ChangeMoveFlag(false)
    DoBuffList(m_moveData)
    DoMapBuff(#m_moveData.way - 1)
    local newMazeInfo = m_moveData.mazeInfo
    UpdateBuffData(newMazeInfo)
    UpdateChaosValue(newMazeInfo.curChaosValue)
    local index
    if m_moveData.way and #m_moveData.way > 0 then
      index = m_moveData.way[#m_moveData.way]
    end
    if newMazeInfo.isMazeOver == true then
      local mazeInfo = this:GetData("fci/MazeInfo/")
      if mazeInfo then
        mazeInfo.isMazeOver = newMazeInfo.isMazeOver
      end
      SetPlayerIndex(index)
      DealMazeOver()
    else
      local cellData = this:GetData("MazeCellData" .. index)
      if cellData and cellData.isEnd then
        MoveToNextFloor()
        UpdateRoad(m_moveData)
      else
        SetPlayerIndex(index)
        UpdateEvent(m_moveData, cellData)
        UpdateRoad(m_moveData)
      end
    end
    UpdatePassedCount()
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
    m_refMapUi.Mask.gameObject:SetActive(false)
  end
end

function PlayArriveSound(cellData)
  local eventType = cellData.data.eventType
  local sound
  if eventType == PB.enum.MazeEventType.MazeEvent_Story then
    local storyId = cellData.data.eventProgress
    local storyInfo = PB.get("MazeEventStoryInfo", storyId)
    if storyInfo then
      if storyInfo.storyType == PB.enum.MazeEventType.MazeEvent_Fight or storyInfo.storyType == PB.enum.MazeEventType.MazeEvent_Boss then
        sound = effectEventSound[storyInfo.storyType]
      else
        sound = effectEventSound[PB.enum.MazeEventType.MazeEvent_Story]
      end
    end
    if sound == nil then
      sound = effectEventSound[PB.enum.MazeEventType.MazeEvent_Story]
    end
  else
    sound = effectEventSound[eventType]
  end
  if sound then
    CS.SoundManager.Instance:PlaySound(sound)
  end
end

function UpdateEvent(res, cellData)
  local topWindow = WU.TopWindow()
  if topWindow.name ~= "MazeMain" then
    return
  end
  if (res.isMazeOver == false or res.mazeInfo and res.mazeInfo.isMazeOver == false) and cellData.data.isComplete == false then
    if cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Fight or cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Boss or cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Camp or cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Shop or cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Story then
      PlayArriveSound(cellData)
      WU.AcquireWindowAsync("MazeInterEvent", function(ui)
        _ENV["$"](ui)["$$SetData"](res, cellData)
      end)
    elseif cellData.data.eventType == PB.enum.MazeEventType.MazeEvent_Treasure and res.resChange then
      DBH.ResChange(res.resChange)
      cellData.data.isComplete = true
      WU.ShowRewards(res.resChange)
    end
  elseif (res.isMazeOver == false or res.mazeInfo and res.mazeInfo.isMazeOver == false) and cellData.data.isComplete == true then
    local topWindow = WU.TopWindow()
    if topWindow == "MazeInterEvent" then
      WU.RecycleWindow("MazeInterEvent")
    end
  end
end

function DealMazeOver()
  if IsAllActorDead() then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips26"))
  else
    WU.ShowHintText(WU.GetString("LocalMaze_Tips21"))
  end
end

function SetPlayerIndex(index)
  if index and 0 < index then
    this:SetData("MazePlayerIndex", index)
    local info = this:GetData("fci/MazeInfo/")
    if info then
      info.playerCellIndex = index
    end
  else
    WU.ShowHintText(WU.GetString("LocalMaze_Tips23"))
  end
end

function UpdateRoad(data)
  if data and data.way and #data.way > 0 then
    for i = 1, #data.way do
      local cell = this:GetData("MazeCellData" .. data.way[i])
      SetCompleteAndUpdate(cell)
    end
  end
end

function ShopVisual()
  local info = this:GetData("fci/MazeInfo/")
  if info and info.mazeCells then
    for k, v in pairs(info.mazeCells) do
      if v.eventType == PB.enum.MazeEventType.MazeEvent_Shop and v.isPassed then
        local cell = this:GetData("MazeCellData" .. k)
        SetCompleteAndUpdate(cell)
      end
    end
  end
end

function CreateMazeMap(data)
  if data then
    if m_refMapUi == nil then
      local maze = CS.ResourceManager.Instance:InstantiateWindowPrefab("MazeMain/MazeLayer" .. data.mazeMapDimension)
      if maze then
        local transform = maze.transform
        transform.parent = REF.LayerScrollView.transform
        transform.localPosition = CS.UnityEngine.Vector3.zero
        transform.localRotation = CS.UnityEngine.Quaternion.identity
        transform.localScale = CS.UnityEngine.Vector3.one
        local refMaze = _ENV["$"](maze)
        refMaze["$$SetData"](data, true)
        m_refMapUi = refMaze
        if REF.LayerScrollView then
          WU.HandleGameObjectAttached(REF.LayerScrollView.gameObject)
        end
      else
        error("Maze", "MazeMain/MazeLayer" .. data.mazeMapDimension .. " doesn't exist.")
      end
    else
      m_refMapUi["$$SetData"](data)
    end
    m_refMapUi.Mask.gameObject:SetActive(false)
    local index = this:GetData("MazePlayerIndex")
    local cellData = this:GetData("MazeCellData" .. index)
    local boardActorId = this:GetData("BoardActor/RoleId")
    local resStr, skeletonDataAsset
    if data.currentRoleId and data.currentRoleId ~= 0 then
      resStr = GetSkeletonResByRoleId(data.currentRoleId)
      skeletonDataAsset = WU.AcquireAsset("Dependencies/Spine/" .. resStr .. "/" .. resStr .. "_SkeletonData")
    else
      resStr = GetSkeletonResByRoleId(PB.all("Misc")[1].mazeMiscConf.mazeDefaultSkeletonResRoleId)
      skeletonDataAsset = WU.AcquireAsset("Dependencies/Spine/" .. resStr .. "/" .. resStr .. "_SkeletonData")
    end
    m_refMapUi.Skeleton.SkeletonGenerator:ResetRenderOrder()
    m_skeletonAnim = m_refMapUi.Skeleton.SkeletonGenerator:SetSkeleton(skeletonDataAsset)
    m_skeletonAnim.AnimationState:SetAnimation(0, "idle", true)
    local pos = m_refMapUi["Slot" .. index].transform.localPosition
    m_refMapUi.SkeletonActor.transform.localPosition = pos
    m_refMapUi.SkeletonActor.gameObject:SetActive(true)
    if cellData and cellData.isEnd then
      this:DelayInvokeInFrames(1, function()
        MoveToNextFloor()
      end)
    else
      this:DelayInvokeInFrames(1, function()
        if IsAllActorDead() then
          WU.AcquireWindowAsync("MazeFastFightBalance", function(window)
            _ENV["$"](window)["$$SetAllLose"](ClickReward)
          end)
        elseif data.dropHollows ~= nil and not table.empty(data.dropHollows) then
          WU.AcquireWindowAsync("MazeRelicSelect", function(window)
            _ENV["$"](window)["$$SetData"](data.dropHollows)
            _ENV["$"](window)["$$SetClickCallBack"](function()
              WU.RecycleWindow("MazeRelicSelect")
            end)
          end)
        else
          UpdateEvent(data, cellData)
        end
      end)
    end
    if m_init then
      if data.mazeMapDimension >= 4 then
        this:DelayInvokeInFrames(1, function()
          REF.LayerScrollView.UIScrollView:ResetPosition()
          local moveDistance = REF.RoleBounder.transform.localPosition - REF.LayerScrollView.transform.localPosition - m_refMapUi.SkeletonActor.transform.localPosition
          m_scrollView:MoveRelative(moveDistance)
        end)
      end
      m_init = false
    end
    UpdatePassedCount()
  end
end

function UpdateFloor(data)
  if data.playerCellIndex == nil or data.playerCellIndex == 0 then
    data.playerCellIndex = 1
  end
  m_width = data.mazeMapDimension
  SetPlayerIndex(data.playerCellIndex)
  local str = WU.GetString("LocalMaze_Tips11")
  REF.LabelFloor.UIHtmlLabel.text = str
  REF.LabelFloorCount.UILabel.text = m_curFloor
  CreateMazeMap(data)
end

function IsAllActorDead()
  return AU.MazeActorAllDead()
end

function OnUpdateMazeInfo(data)
  if data == nil then
    return
  end
  this:DelayInvokeInFrames(1, function()
    this:SetData("MazeFirstTweenOn", false)
  end)
  if data.playerCellIndex == nil or data.playerCellIndex == 0 then
    data.playerCellIndex = 1
  end
  if data.curMazeFloor == nil then
    data.curMazeFloor = 1
  end
  UpdateBuffData(data)
  OnSetEffectBG(data)
  this:Unbind("MazeBuff", UpdateBuffList)
  this:Bind("MazeBuff", UpdateBuffList)
  m_curFloor = data.curMazeFloor
  UpdateFloor(data)
  m_mazeBuffIndex = data.mazeBuffIndex
  UpdateChaosValue(data.curChaosValue)
end

function UpdatePassedCount()
  local mazeInfo = this:GetData("fci/MazeInfo/")
  local mazeCells = mazeInfo.mazeCells
  if mazeCells and not table.empty(mazeCells) then
    local allCount = 0
    local passedCount = 0
    for k, v in pairs(mazeCells) do
      local curCellInfo = this:GetData("MazeCellData" .. k)
      if curCellInfo.data.isPassed == true then
        passedCount = passedCount + 1
      end
      allCount = allCount + 1
    end
    REF.LabelPassedCount.UIHtmlLabel.text = "(" .. passedCount .. "/" .. allCount .. ")"
  end
end

function UpdateBuffList(buffMap)
  if buffMap == nil then
    return
  end
  local buffList = {}
  for k, v in pairs(buffMap) do
    if v.buffId > 0 then
      if (v.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle or v.persistentType == PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Cell) and 0 < v.leftRound then
        buffList[#buffList + 1] = v
      elseif v.persistentType ~= PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Battle and v.persistentType ~= PB.enum.MazeBuffPersistentType.MazeBuffPersistent_Cell then
        buffList[#buffList + 1] = v
      end
    end
  end
  m_buffRowList = {}
  local col = 4
  local len = math.ceil(#buffList / col)
  for i = 1, len do
    local temp = {}
    for i2 = 1, col do
      temp[i2] = buffList[(i - 1) * col + i2]
    end
    m_buffRowList[i] = temp
  end
  LU.Set(REF.BuffWrapContent, len)
end

function UpdateBuffRowCell(rowRef, wrapIndex, realIndex)
  if m_buffRowList and realIndex ~= nil and realIndex < #m_buffRowList then
    local index = realIndex + 1
    local buffRow = m_buffRowList[index]
    rowRef["$$SetData"](buffRow)
  end
end

function OnRefreshDungeonGroup(result)
end

function SetCompleteAndUpdate(cellData)
  cellData.data.isPassed = true
  this:SetData("MazeCellData" .. cellData.index, cellData)
  
  local function updateCell(index)
    local key = "MazeCellData" .. index
    local cell = this:GetData(key)
    if cell then
      this:SetData(key, cell)
    end
  end
  
  local last = cellData.index
  local left = last - 1
  local right = last + 1
  local up = last - m_width
  local down = last + m_width
  updateCell(left)
  updateCell(right)
  updateCell(up)
  updateCell(down)
end

function UpdateChaosValue(curValue)
  m_chaosValue = curValue
  if m_mazeActivityId == 34001 and m_mazeBuffIndex ~= 0 then
    local maxValue = PB.all("Misc")[1].mazeMiscConf.mazeConfs[m_mazeActivityId].chaosPollutionMax
    local allChaosBuff = PB.all("MazeChaosBuff")
    local chaosBuff
    local curChaosLevel = 1
    for i = 0, #REF.ChaosGrid - 1 do
      REF.ChaosGrid[i]["$gameObject"]:SetActive(false)
      REF.ChaosGrid[i].SpriteIsThis.gameObject:SetActive(false)
    end
    for i = 2, #allChaosBuff do
      local ratio = allChaosBuff[i].chaosValue / maxValue
      REF.ChaosGrid[i - 2]["$gameObject"]:SetActive(true)
      REF.ChaosGrid[i - 2]["$transform"].localPosition = CS.UnityEngine.Vector3(ratio * REF.ChaosGrid.UIWidget.width, 0, 0)
    end
    for i = 1, #allChaosBuff do
      if curValue < allChaosBuff[i].chaosValue then
        chaosBuff = allChaosBuff[i - 1]
        if 2 < i then
          REF.ChaosGrid[i - 3].SpriteIsThis.gameObject:SetActive(true)
          curChaosLevel = i - 1
        end
        break
      end
    end
    if curValue >= allChaosBuff[#allChaosBuff].chaosValue then
      chaosBuff = allChaosBuff[#allChaosBuff]
      REF.ChaosGrid[#allChaosBuff - 2].SpriteIsThis.gameObject:SetActive(true)
      curChaosLevel = #allChaosBuff - 1
    end
    REF.SpriteExpAdd.UISprite.spriteName = "bar_pollute_" .. curChaosLevel
    local itemCure = this:GetData("fci/item/92000")
    local cureNum = 0
    local info = PB.get("MazeInfo", m_mazeId)
    if itemCure and 0 < itemCure.count then
      cureNum = itemCure.count
    end
    if WU.GetGameDataCache("Maze/TutorialPollution" .. DB:GetData("playerId")) ~= true then
      if WU.GetGameDataCache("Maze/TutorialShow" .. DB:GetData("playerId")) == true and 0 < cureNum then
        REF.MazePolluteTip.gameObject:SetActive(true)
        this:DelayInvokeInSeconds(5, function()
          REF.MazePolluteTip.gameObject:SetActive(false)
          WU.SetGameDataCache("Maze/TutorialPollution" .. DB:GetData("playerId"), true)
        end)
      end
    else
      REF.MazePolluteTip.gameObject:SetActive(false)
    end
    REF.LabelCure.UILabel.text = WU.GetString("Maze_PollutionClear") .. "(" .. cureNum .. "/" .. info.chaosBuyLimit .. ")"
    REF.WidgetProgressBar.UIProgressBar.value = math.min(1, curValue / maxValue)
    REF.LabelPollution.UIHtmlLabel.text = WU.GetString("Maze_PollutionNum", curValue)
    if chaosBuff and chaosBuff.buffId then
      local tpl = WU.GetString("AffixDesc_" .. chaosBuff.buffId[m_mazeBuffIndex])
      local tplParam = SE.GetAffixTplParam(chaosBuff.buffId[m_mazeBuffIndex])
      if tplParam == nil then
        return
      else
        REF.LabelPollutionDesc.UIHtmlLabel.text = TU.render(tpl, tplParam)
      end
    else
      error("MazeChaosBuff.xlsx has no chaoValue " .. chaosBuff.buffId[m_mazeBuffIndex])
      return
    end
  end
end

function UpdateWindow()
  if m_curScrollViewPos.x ~= m_scrollViewPanel.clipOffset.x or m_curScrollViewPos.y ~= m_scrollViewPanel.clipOffset.y then
    local bgMoveX = m_scrollViewPanel.clipOffset.x
    local bgMoveY = m_scrollViewPanel.clipOffset.y
    m_curScrollViewPos.x = bgMoveX
    m_curScrollViewPos.y = bgMoveY
    m_bGMovePos:Set(-bgMoveX / 5, -bgMoveY / 5, 0)
    REF.EffectBG1.transform.localPosition = m_bGMovePos
    m_bGMovePos:Set(-bgMoveX / 20, -bgMoveY / 20, 0)
    REF.EffectBG2.transform.localPosition = m_bGMovePos
    m_bGMovePos:Set(-bgMoveX / 50, -bgMoveY / 50, 0)
    REF.EffectBG3.transform.localPosition = m_bGMovePos
  end
end

function DestroyCurMaze()
  if m_refMapUi then
    m_refMapUi["$$Clean"]()
    CS.UnityEngine.GameObject.Destroy(m_refMapUi["$gameObject"])
    m_refMapUi = nil
    m_skeletonAnim = nil
  end
end

function OnSetEffectBG(res)
  m_mazeResourceId = res.mazeResourceId
  
  local function fuc(resourceId)
    if m_playTween == true then
      REF.EffectBG3.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG03"
      REF.EffectBG2.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG02"
      REF.EffectBG1.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG01"
    else
      REF.EffectBG3.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG03" .. "_loop"
      REF.EffectBG2.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG02" .. "_loop"
      REF.EffectBG1.EffectGenerator.m_EffectName = "UI_Maze0" .. resourceId .. "_BG01" .. "_loop"
    end
    this:DelayInvokeEndOfFrame(function()
      REF.EffectBG3.EffectGenerator:Reset()
      REF.EffectBG2.EffectGenerator:Reset()
      REF.EffectBG1.EffectGenerator:Reset()
      REF.EffectBG3.EffectGenerator:Play()
      REF.EffectBG2.EffectGenerator:Play()
      REF.EffectBG1.EffectGenerator:Play()
    end)
  end
  
  m_playTween = this:GetData("MazeFirstTweenOn")
  fuc(m_mazeResourceId)
end

function SetMazeId(data)
  if data then
    m_mazeId = data
  end
end

function MoveToNextFloor()
  local info = PB.get("MazeInfo", m_mazeId)
  local strTip
  local isLastFloor = false
  if info then
    isLastFloor = m_curFloor >= info.maxFloor
  else
    error("MazeInfo.xlsx has not this id " .. m_mazeId)
    return
  end
  
  local function callBackYes()
    if isLastFloor then
      WU.RecycleWindow("MazeInterEvent")
      ClickReward()
    else
      DB:GameRequest("fci/Maze/Move/" .. m_mazeActivityId .. "/"):Patch(nil, function(result)
        if result and result.mazeInfo then
          WU.RecycleWindow("MazeInterEvent")
          DestroyCurMaze()
          m_init = true
          DB:SetData("MazeFirstTweenOn", true)
          DB:SetData("fci/MazeInfo/", result.mazeInfo)
        end
      end)
    end
  end
  
  local function callBackNo()
    DB:GameRequest("fci/Maze/Move/" .. m_mazeActivityId .. "/"):Put(nil, function(result)
      if result then
        WU.RecycleWindow("MazeInterEvent")
        OnMazeMove(result)
      end
    end)
  end
  
  CS.SoundManager.Instance:PlaySound(effectEndSound)
  WU.AcquireWindowAsync("MazeInterEvent", function(window)
    _ENV["$"](window)["$$SetNextFloor"](callBackYes, callBackNo, isLastFloor)
  end)
end

function CheckOverlap(widget)
  local curCorners = m_refMapUi.Skeleton.UIDrawCallBreaker.worldCorners
  local validCorners = widget.worldCorners
  local overlaped, moveDistance
  if curCorners[0].x > validCorners[0].x and curCorners[3].x < validCorners[3].x and curCorners[0].y > validCorners[0].y and curCorners[1].y < validCorners[1].y then
    overlaped = false
  else
    overlaped = true
    moveDistance = REF.RoleBounder.transform.localPosition - REF.LayerScrollView.transform.localPosition - m_refMapUi.SkeletonActor.transform.localPosition
  end
  return overlaped, moveDistance
end

function SetContinue()
  WU.ShowHintText(WU.GetString("Maze_ContinueGame"))
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
          error("ActorConfig has no tis skeletonRes by roleId " .. roleId)
          return
        end
      end
    end
  else
    return
  end
  return
end

function CamFollow()
  local overlaped, moveDistance = CheckOverlap(REF.RoleBounder.UIWidget)
  while overlaped == true do
    local step = moveDistance * 0.03
    m_scrollView:MoveRelative(step)
    moveDistance = moveDistance - step
    overlaped = CheckOverlap(REF.RoleBounder.UIWidget)
    CO.yield_return(CS.UnityEngine.WaitForSeconds(0.023))
  end
end

function ChangeMoveFlag(flag)
  m_isMoving = flag
  this:SetData("Maze/Moving", flag)
end

function OnRefreshData()
end
