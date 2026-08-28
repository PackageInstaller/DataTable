local DataModel = require("UICubeRogueMain/UICubeRogueMainDataModel")
local View = require("UICubeRogueMain/UICubeRogueMainView")
local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
local StartBattle = require("UISquads/View_StartBattle")
local PublicTool = require("UICubeRogueMain/CubeRoguePublicMethod")
local SquadsDataController = require("UISquads/UISquadsDataController")
local DragRotate = require("UICubeRogueMain/DragHandle")
local OutSideData = require("UICubeSkill/UICubeSkillDataModel")
local AttrManager = require("UICubeRogueMain/CubeRogueEquipAttrManager")
local ItemAttrManager = require("UICubeRogueMain/CubeRogueItemAttrManager")
local EnemyTalentController = require("UIGroup_EnemyTalent/UIGroup_EnemyTalentController")
local Controller = {
  Enum_Continue = {
    Cube_Event = 1,
    ShowReward = 2,
    ContinueOrder = 3,
    ContinueOrderAfterTrigger = 4,
    StartEvent = 5,
    NextRoundAfterTrigger = 6,
    OpenOptionPanel = 7,
    OpenSquadPanel = 8,
    StartRound = 9,
    NextFace = 10,
    EndCube = 11
  }
}

function Controller.OnPlayerRotBtnClick(ver, clockWize)
  DataModel.roleCtrl:ActiveRotBtns(false)
  if ver == 1 then
    DataModel.SelectCubeVertical(DataModel.roleCtrl.face, DataModel.roleCtrl.x, DataModel.roleCtrl.y)
  else
    DataModel.SelectCubeHorizontal(DataModel.roleCtrl.face, DataModel.roleCtrl.x, DataModel.roleCtrl.y)
  end
  Controller.DoRotate(clockWize)
end

function Controller.OnEnter()
  local dragRotate = DragRotate.new(DataModel.rubikCube.obj, -DataModel.cfg.spinX, -DataModel.cfg.spinY, DataModel.allConfig)
  dragRotate:BindEvents()
  local cam = Controller:FindCamera()
  Controller.cam = cam
  dragRotate.rightDir = cam.transform.right
  cam.transform.localPosition = Vector3(DataModel.cfg.cameraX, DataModel.cfg.cameraY, DataModel.cfg.cameraZ)
  local camRot = cam.transform.localEulerAngles
  camRot.x = DataModel.cfg.rotateX
  cam.transform.localEulerAngles = camRot
  cam.fieldOfView = DataModel.cfg.cameraView
  if Controller.completed then
    Controller.completed = nil
    return
  end
  DataModel.rubikCube:PlayAnim(DataModel.cfg.enterAnimation)
end

function Controller.ShowPlayerBegin()
  local function call(json)
    View.Group_PlayerBegin:SetActive(true)
    
    View.Group_MoveTips.Group_PlayerMove:SetActive(true)
    View.Group_MoveTips.Group_BossMove:SetActive(false)
    View.self:SelectPlayAnim(View.Group_PlayerBegin.self, "enter", function()
      View.Group_PlayerBegin:SetActive(false)
      local netData = json.dice or {}
      local tips = AttrManager:TriggerByTimingType(Enum_TriggerTiming.RoundStart, nil, netData)
      Controller.rewardList = Controller.rewardList or {}
      for _, tip in pairs(tips) do
        table.insert(Controller.rewardList, 1, tip)
      end
      Controller.DealRewardLose(json, true)
      Controller.playerMoving = false
      Controller.playerRotating = false
      DataModel.curMoveNum = 0
      DataModel.curRotNum = 0
      Controller.RefreshPlayerStep()
      Controller.TryShowReward()
    end)
  end
  
  if PlayerData:GetPlayerPrefs("int", "CubeRogueFaceAnimation") ~= 1 then
    PlayerData:SetPlayerPrefs("int", "CubeRogueFaceAnimation", 1)
    View.Group_Enter:SetActive(true)
    View.Group_Enter.Group_1.Group_Present.Img_Icon:SetSprite(GetResPath(88300186))
    View.Group_Enter.Group_2.Group_Present.Img_Icon:SetSprite(GetResPath(88300187))
    View.Group_Enter.Group_3.Group_Present.Img_Icon:SetSprite(GetResPath(88300188))
    local curFaceIndex = DataModel.cfg.faceIndex or 1
    for i = 1, 3 do
      View.Group_Enter["Group_" .. i]:SetActive(i <= curFaceIndex)
      View.Group_Enter["Group_" .. i].Group_Finish:SetActive(i < curFaceIndex)
      View.Group_Enter["Group_" .. i].Group_Present:SetActive(i == curFaceIndex)
    end
    local tips = AttrManager:TriggerByTimingType(Enum_TriggerTiming.Enter)
    Controller.rewardList = Controller.rewardList or {}
    for _, tip in pairs(tips) do
      table.insert(Controller.rewardList, 1, tip)
    end
    View.self:SelectPlayAnim(View.Group_Enter.self, "enter", function()
      View.Group_Enter:SetActive(false)
      DataModel.rubikCube:PlayAnim(DataModel.cfg.enterAnimation)
      if not Controller.TryShowReward() then
        Controller.TryNextFace()
      end
    end)
  else
    Net:SendProto("cube.start_round", function(json)
      DataModel.needStartRound = nil
      call(json)
    end)
  end
end

function Controller.RefreshPlayerStep(onlySelect)
  local maxMoveNum = DataModel.GetMaxStepNum()
  local moveDone = maxMoveNum <= DataModel.curMoveNum
  local maxRotNum = DataModel.GetMaxRotNum()
  local rotDone = maxRotNum <= DataModel.curRotNum
  if moveDone then
    Controller.playerMoving = false
  end
  if rotDone then
    Controller.playerRotating = false
  end
  View.Group_ActionInformation.Group_Move.Group_Select:SetActive(Controller.playerMoving)
  View.Group_ActionInformation.Group_Spin.Group_Select:SetActive(Controller.playerRotating)
  if onlySelect then
    return
  end
  View.Group_ActionInformation.Group_Move.Group_Not:SetActive(not moveDone)
  View.Group_ActionInformation.Group_Move.Group_Complete:SetActive(moveDone)
  local maxMoveStr = string.format("%d", maxMoveNum)
  View.Group_ActionInformation.Group_Move.Group_Not.Txt_Num:SetText(DataModel.curMoveNum .. "/" .. maxMoveStr)
  View.Group_ActionInformation.Group_Move.Group_Select.Txt_Num:SetText(DataModel.curMoveNum .. "/" .. maxMoveStr)
  View.Group_ActionInformation.Group_Move.Group_Complete.Txt_Num:SetText(DataModel.curMoveNum .. "/" .. maxMoveStr)
  View.Group_ActionInformation.Group_Spin.Group_Not:SetActive(not rotDone)
  View.Group_ActionInformation.Group_Spin.Group_Complete:SetActive(rotDone)
  local maxRotStr = string.format("%d", maxRotNum)
  View.Group_ActionInformation.Group_Spin.Group_Not.Txt_Num:SetText(DataModel.curRotNum .. "/" .. maxRotStr)
  View.Group_ActionInformation.Group_Spin.Group_Select.Txt_Num:SetText(DataModel.curRotNum .. "/" .. maxRotStr)
  View.Group_ActionInformation.Group_Spin.Group_Complete.Txt_Num:SetText(DataModel.curRotNum .. "/" .. maxRotStr)
end

function Controller.ShowBossBegin(cb)
  View.Group_PlayerComplete:SetActive(true)
  View.Group_MoveTips.Group_PlayerMove:SetActive(false)
  View.Group_MoveTips.Group_BossMove:SetActive(true)
  View.self:SelectPlayAnim(View.Group_PlayerComplete.self, "enter", function()
    View.Group_PlayerComplete:SetActive(false)
    if cb then
      cb()
    end
  end)
end

function Controller.ShowBossAction(cb)
  View.Group_BossAction:SetActive(true)
  View.self:SelectPlayAnim(View.Group_BossAction.self, "enter", function()
    View.Group_BossAction:SetActive(false)
    if cb then
      cb()
    end
  end)
end

function Controller.StartTimer(name, t, call, once)
  Controller.TimerNameList = Controller.TimerNameList or {}
  Controller.TimerNameList[name] = t
  if once then
    TimerHelper.StartOnce(name, t, function()
      call()
      Controller.TimerNameList[name] = nil
    end)
  else
    TimerHelper.Start(name, t, function()
      call()
    end)
  end
end

function Controller.StopAllTimer()
  if Controller.TimerNameList == nil then
    return
  end
  for k, v in pairs(Controller.TimerNameList) do
    TimerHelper.Stop(k)
  end
  Controller.TimerNameList = nil
end

function Controller.RemoveTimer(tName)
  if Controller.TimerNameList and Controller.TimerNameList[tName] then
    Controller.TimerNameList[tName] = nil
  end
  TimerHelper.Stop(tName)
end

function Controller.OnPanelBack()
  if not Controller.TryShowReward() then
    if DataModel.rubikCube == nil or DataModel.rubikCube.obj == nil then
      return
    end
    if Controller.NeedTriggerAfterReward then
      Controller.TryDealOrderAfterTrigger()
    elseif not Controller.TryDealOrder() and not Controller.optionPanelState then
      if DataModel.playerCube and DataModel.playerCube.realId then
        local eventCfg = GetCA(DataModel.playerCube.realId, "RogueEventFactory")
        if eventCfg.func == "OpenLevel" then
          local hasDebeat = PlayerData.IsCubeLevelFinished(eventCfg.levelId)
          if hasDebeat then
            Controller.TryTriggerAndNextRound()
          else
            Controller.StartEvent()
          end
        elseif eventCfg.func == "OpenUI" then
          if UIManager:IsPanelOpened(eventCfg.uiPath) then
            Controller.StartEvent()
          end
        else
          Controller.StartEvent()
        end
      elseif DataModel.playerCube and DataModel.playerCube.netData then
        Controller.SendNetEvent()
      else
        Controller.TryNextFace()
      end
    end
  end
end

function Controller.TryNextFace()
  local isComplete = false
  local bossCube = DataModel.rubikCube:GetCube(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y)
  if bossCube == nil or bossCube.netData == nil then
    isComplete = true
  end
  if isComplete then
    Controller.completed = true
    DataModel.rubikCube.obj.transform.rotation = Quaternion.Euler(0, 0, 0)
    DataModel.rubikCube:PlayAnim(DataModel.cfg.outAnimation)
    View.Img_Quit:SetActive(true)
    View.self:SelectPlayAnim(View.Img_Quit, "quit", function()
      PlayerData:DeletePlayerPrefs("CubeRogueFaceAnimation")
      ItemAttrManager.OnRoundEnd()
      ItemAttrManager.OnFaceEnd()
      local openRest, nextId = Controller.OpenRestPanel()
      Controller.ResetPanel()
      if not openRest then
        Controller.ClearData()
        if nextId == nil or nextId == 0 then
          Controller.EndCube(true)
        else
          Net:SendProto("cube.end_rest", function(json)
            PlayerData.TempCache.CubeRogueData = json.cube
            PlayerData.TempCache.CubeRogueData.reward = json.reward
            Controller.OnPanelOpen()
          end)
        end
      end
    end)
  else
    Controller.TryShowNextRound()
  end
end

function Controller.OnPanelOpen()
  local restId = PlayerData.TempCache.CubeRogueData.rest_id
  if restId == nil or restId == "" then
    DataModel.attrManager = AttrManager
    DataModel.itemAttrManager = ItemAttrManager
    DataModel:InitRubik(Controller.OnPlayerRotBtnClick)
    Controller.RefreshShow()
    Controller.InitReloginData(Controller.delayContinue or 0)
    Controller.OnEnter()
    Controller.delayContinue = nil
  else
    DataModel.attrManager = AttrManager
    DataModel.itemAttrManager = ItemAttrManager
    DataModel:InitRubik(Controller.OnPlayerRotBtnClick, true)
    Controller.RefreshShow()
    Controller.OpenRestPanel(tonumber(restId))
  end
end

function Controller.EndCube(isWin, json, isMainScene)
  UIManager:Open("UI/CubeRogue/Settlement/CubeRogueSettlement", Json.encode({
    isWin = isWin,
    json = json,
    isMainScene = isMainScene
  }))
end

function Controller.ResetPanel()
  View.Img_Quit:SetActive(false)
  View.Group_Enter:SetActive(false)
  View.Group_ConfirmRot:SetActive(false)
  View.Btn_Continue:SetActive(false)
end

function Controller.OnOtherPanelClose(continueType)
  if continueType then
    Controller.ContinueClick = continueType
    View.Btn_Continue:SetActive(true)
  end
end

local function DealRewardOnRelogin(package, select, reward)
  local temp = {}
  if package then
    for k, v in pairs(package) do
      temp[k] = v
    end
  end
  if select then
    for k, v in pairs(select) do
      temp[k] = v
    end
  end
  if table.count(temp) > 0 then
    reward.rg_pack = temp
  end
  if reward.item then
    for _, v in pairs(reward.item) do
      v.dontAdd = true
    end
  end
  Controller.DealRewardLose({reward = reward}, true)
end

local function CheckOrderListContainsBattle(cfg)
  local needTrigger, continueOrderIndex
  for i = 1, #cfg.optionFuncList do
    local temp = cfg.optionFuncList[i]
    local orderCfg = GetCA(temp.id, "RogueOrderFactory")
    if orderCfg.orderType ~= "Level" or orderCfg.levelId <= 0 then
      needTrigger = true
      continueOrderIndex = i
      break
    end
    if not PlayerData.IsCubeLevelFinished(orderCfg.levelId) then
      continueOrderIndex = i
      break
    end
  end
  if continueOrderIndex == nil then
    continueOrderIndex = #cfg.optionFuncList + 1
    needTrigger = true
  end
  return needTrigger, continueOrderIndex
end

function Controller.InitReplaceData()
  local allItems = PlayerData.TempCache.CubeRogueData.inside_item or {}
  local maxItemNum = DataModel.GetMaxItemNum()
  if maxItemNum < #allItems then
    DataModel.surplusItems = maxItemNum + 1
  else
    DataModel.surplusItems = nil
  end
end

function Controller.InitReloginData(delayDo)
  local netdata = PlayerData.TempCache.CubeRogueData
  if netdata.packages and table.count(netdata.packages) == 0 then
    netdata.packages = nil
  end
  if netdata.selected and table.count(netdata.selected) == 0 then
    netdata.selected = nil
  end
  if netdata.option_pack == "" then
    netdata.option_pack = nil
  end
  local curPosEventPack = DataModel.playerCube.netData
  local curPosEvent = DataModel.playerCube.realId
  local netPackage = netdata.packages
  local netSelect = netdata.selected
  local netOption = netdata.option_pack and tonumber(netdata.option_pack) or nil
  Controller.InitReplaceData()
  local netReward = netdata.reward or {}
  local hasReward = netReward.item and 0 < table.count(netReward.item) or netReward.rg_buff and 0 < table.count(netReward.rg_buff) or netReward.rg_equip and 0 < table.count(netReward.rg_equip)
  local needShowRewardLose = netPackage or netSelect or DataModel.surplusItems or hasReward
  local needStartRound = netdata.round_ss == 0
  local needTryNextFace = DataModel.rubikCube.bossCube == nil
  local leftStep = DataModel.GetMaxRoundNum() - DataModel.stepNum
  DataModel.needStartRound = needStartRound
  local closeMask = false
  if needTryNextFace then
    Controller.ContinueClick = Controller.Enum_Continue.NextFace
  elseif needStartRound then
    if needShowRewardLose then
      DealRewardOnRelogin(netPackage, netSelect, netReward)
      Controller.ContinueClick = Controller.Enum_Continue.ShowReward
    elseif leftStep <= 0 then
      delayDo = nil
      Controller.ContinueClick = Controller.Enum_Continue.EndCube
    else
      Controller.ContinueClick = Controller.Enum_Continue.StartRound
    end
  elseif curPosEventPack == nil then
    if needShowRewardLose then
      DealRewardOnRelogin(netPackage, netSelect, netReward)
      Controller.ContinueClick = Controller.Enum_Continue.ShowReward
    elseif leftStep <= 0 then
      delayDo = nil
      Controller.ContinueClick = Controller.Enum_Continue.EndCube
    else
      closeMask = true
      Controller.ContinueClick = nil
    end
  elseif curPosEvent == nil then
    if needShowRewardLose then
      DealRewardOnRelogin(netPackage, netSelect, netReward)
      Controller.ContinueClick = Controller.Enum_Continue.ShowReward
    else
      Controller.ContinueClick = Controller.Enum_Continue.Cube_Event
    end
  elseif netOption == nil then
    if needShowRewardLose then
      DealRewardOnRelogin(netPackage, netSelect, netReward)
      Controller.ContinueClick = Controller.Enum_Continue.ShowReward
    else
      Controller.ContinueClick = Controller.Enum_Continue.StartEvent
      local eventCfg = GetCA(curPosEvent, "RogueEventFactory")
      if eventCfg.func == "OpenLevel" then
        local hasDebeat = PlayerData.IsCubeLevelFinished(eventCfg.levelId)
        if hasDebeat then
          Controller.ContinueClick = Controller.Enum_Continue.NextRoundAfterTrigger
        end
      end
    end
  else
    local optionCfg = GetCA(netOption, "ActivityListFactory")
    local needTri, continueOrderIndex = CheckOrderListContainsBattle(optionCfg)
    local eventCfg = GetCA(curPosEvent, "RogueEventFactory")
    local curOptionIndex
    for m, n in ipairs(eventCfg.optionList) do
      if n.id == netOption then
        curOptionIndex = m
        break
      end
    end
    Controller.InitOptionPanelData(eventCfg)
    Controller.curSelectOption = curOptionIndex
    Controller.dealOptionList = optionCfg.optionFuncList
    Controller.dealOptionIndex = continueOrderIndex
    DataModel.isDealingOrder = true
    DataModel.BattleEndTriggerOptionId = netOption
    Controller.NeedTriggerAfterReward = needTri
    Controller.ShowOptionsPanel(false, true)
    if needShowRewardLose then
      DealRewardOnRelogin(netPackage, netSelect, netReward)
      Controller.ContinueClick = Controller.Enum_Continue.ShowReward
    elseif not needTri then
      Controller.ContinueClick = Controller.Enum_Continue.ContinueOrder
    else
      Controller.ContinueClick = Controller.Enum_Continue.ContinueOrderAfterTrigger
    end
  end
  netdata.cur_event = nil
  netdata.packages = nil
  netdata.selected = nil
  netdata.option_pack = nil
  netdata.reward = nil
  View.Btn_Continue:SetActive(not closeMask)
  if delayDo then
    if delayDo <= 0 then
      Controller.ContinueBtnClick()
    else
      Controller.StartTimer("DelayDoContinue", delayDo, function()
        Controller.ContinueBtnClick()
      end, true)
    end
  end
end

function Controller.ContinueBtnClick()
  View.Btn_Continue:SetActive(false)
  if Controller.ContinueClick then
    if Controller.ContinueClick == Controller.Enum_Continue.Cube_Event then
      Controller.SendNetEvent()
    elseif Controller.ContinueClick == Controller.Enum_Continue.ShowReward then
      Controller.TryShowReward()
    elseif Controller.ContinueClick == Controller.Enum_Continue.ContinueOrder then
      Controller.TryDealOrder()
    elseif Controller.ContinueClick == Controller.Enum_Continue.ContinueOrderAfterTrigger then
      Controller.TryDealOrderAfterTrigger()
    elseif Controller.ContinueClick == Controller.Enum_Continue.StartEvent then
      Controller.StartEvent()
    elseif Controller.ContinueClick == Controller.Enum_Continue.NextRoundAfterTrigger then
      Controller.TryTriggerAndNextRound()
    elseif Controller.ContinueClick == Controller.Enum_Continue.OpenOptionPanel then
      Controller.ShowOptionsPanel(false)
    elseif Controller.ContinueClick == Controller.Enum_Continue.OpenSquadPanel then
      Controller:OpenSquadPanel(Controller.cacheLevelId)
      Controller.cacheLevelId = nil
    elseif Controller.ContinueClick == Controller.Enum_Continue.StartRound then
      Controller.ShowPlayerBegin()
    elseif Controller.ContinueClick == Controller.Enum_Continue.NextFace then
      Controller.TryNextFace()
    elseif Controller.ContinueClick == Controller.Enum_Continue.EndCube then
      Controller.EndCube(false)
    end
    Controller.ContinueClick = nil
  else
  end
end

function Controller.PlaySpecialItemAnim(cubeData, cb)
  if cubeData.specialItemModel == nil or cubeData.specialItemModel:IsNull() then
    cubeData.specialItemModel = nil
    if cb then
      cb()
    end
    return
  end
  local specialItem = cubeData.specialItemModel
  cubeData.specialItemModel = nil
  local animator = specialItem:GetComponentInChildren(typeof(CS.UnityEngine.Animator))
  if animator and not animator:IsNull() then
    animator:Play("obtain")
  end
  Controller.ShowSpecialInfo()
  Controller.StartTimer("DelayDelete", 1, function()
    CS.UnityEngine.GameObject.Destroy(specialItem)
    if cb then
      cb()
    end
  end, true)
end

function Controller.TryTriggerEvent(opid, call)
  local function cb()
    opid = opid or DataModel.BattleEndTriggerOptionId
    
    DataModel.BattleEndTriggerOptionId = nil
    DataModel.playerCube.netData = nil
    DataModel.playerCube.realId = nil
    DataModel.playerCube.item = nil
    Controller.RefreshMissionInfo()
    DataModel.rubikCube:ShowIcon(DataModel.roleCtrl.face, DataModel.roleCtrl.x, DataModel.roleCtrl.y)
    DataModel.ShowPlayerOutline()
    Controller.NeedTriggerAfterReward = nil
    Net:SendProto("cube.trigger", function(json)
      if json.move_boss_pos == "" then
        DataModel.newBossPos = nil
      else
        DataModel.newBossPos = json.move_boss_pos
      end
      if json.new_boss_pos == "" then
        DataModel.bossRot = nil
      else
        DataModel.bossRot = json.new_boss_pos
      end
      DataModel.CheckRoundEnd()
      if call then
        call(json)
      end
    end, opid)
  end
  
  local eCA = PlayerData:GetFactoryData(DataModel.playerCube.realId)
  if eCA and eCA.firstPlotId and eCA.firstPlotId ~= "" and eCA.firstPlotId ~= -1 and PlayerData.plot_paragraph[tostring(eCA.firstPlotId)] == nil then
    UIManager:Open("UI/Dialog/Dialog", Json.encode({
      id = eCA.firstPlotId
    }), cb, cb)
  else
    if eCA == nil then
      logError("Trigger\230\151\182, \230\156\170\232\142\183\229\143\150\229\136\176\229\189\147\229\137\141\230\160\188\229\173\144\231\154\132\228\186\139\228\187\182\230\149\176\230\141\174: " .. tostring(DataModel.playerCube.realId))
    end
    cb()
  end
  if eCA.typeId == 12601542 or eCA.typeId == 12601540 then
    PlayerData.TempCache.CubeRogueData.face_events[tostring(eCA.id)] = PlayerData.TempCache.CubeRogueData.face_events[tostring(eCA.id)] or 0
    PlayerData.TempCache.CubeRogueData.face_events[tostring(eCA.id)] = PlayerData.TempCache.CubeRogueData.face_events[tostring(eCA.id)] + 1
  end
end

function Controller.TryTriggerAndNextRound(opid, call)
  Controller.TryTriggerEvent(opid, function(json)
    if call then
      if not call() then
        Controller.TryNextFace()
      end
    else
      Controller.TryNextFace()
    end
  end)
end

function Controller.RefreshShow(onlyUI)
  View.Group_Plane.Txt_Name:SetText(DataModel.cfg.planesName)
  View.Group_Plane.Img_Num:SetSprite(DataModel.cfg.numIcon)
  View.Group_Plane.Img_Bg:SetSprite("UI/CubeRogue/OverView/Image/Bg_Num_0" .. DataModel.cfg.faceIndex)
  View.Group_Plane.Group_ScheduleLeft.Img_Schedule:SetFilledImgAmount(DataModel.cfg.faceIndex / 3)
  View.Group_Plane.Group_ScheduleRight.Img_Schedule:SetFilledImgAmount(DataModel.cfg.faceIndex / 3)
  View.Group_Difficulty.Img_Icon:SetSprite(DataModel.difficultInfo.insideIcon)
  View.Group_PlayerBegin.Img_Icon:SetSprite(GetResPath(88300213))
  View.Group_PlayerComplete.Img_Icon:SetSprite(GetResPath(88300212))
  Controller.RefreshStepNum()
  Controller.ShowCoin()
  Controller.ShowTeam()
  Controller.ShowFormation()
  Controller.ShowPackSake()
  Controller.ShowPressure()
  Controller.RefreshPlayerStep()
  Controller.RefreshUseItems()
  Controller.RefreshMissionInfo()
  Controller.showMissionInfo = false
  Controller.ShowMissionInfo(Controller.showMissionInfo)
  Controller.ShowSpecialInfo()
end

function Controller.ShowSpecialInfo()
  local getNum = DataModel.cfg.specialNum - DataModel.GetCurSpecialNum()
  View.Group_Action.Group_special.Txt_Num:SetText(string.format(GetText(80610963), getNum, DataModel.cfg.specialNum))
end

function Controller.ShowFormation()
  local num = 0
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.roles) do
    if PlayerData:GetFactoryData(k) ~= nil then
      num = num + 1
    end
  end
  View.Group_Formation.Txt_Num:SetText(num)
end

function Controller.ShowPackSake()
  View.Group_PackSake.Txt_Num:SetText(table.count(PlayerData.TempCache.CubeRogueData.inside_buffs) + table.count(PlayerData.TempCache.CubeRogueData.equips))
  Controller.ShowEquips()
end

function Controller.ShowEquips()
  local list = PlayerData.TempCache.CubeRogueData.equips
  DataModel.panelEquipList = {}
  for k, v in pairs(list) do
    v.id = k
    v.isDead = v.orders == nil or table.count(v.orders) == 0
    local cfg = PlayerData:GetFactoryData(k, "RogueEquipmentFactory")
    v.quality = cfg.qualityInt
    table.insert(DataModel.panelEquipList, v)
  end
  table.sort(DataModel.panelEquipList, function(a, b)
    if a.isDead and not b.isDead then
      return false
    elseif b.isDead and not a.isDead then
      return true
    else
      return a.quality > b.quality
    end
  end)
  local dataCount = #DataModel.panelEquipList
  View.Group_Weapon.Group_Empty:SetActive(dataCount <= 6)
  View.Group_Weapon.ScrollGrid_List.self:SetEnable(6 < dataCount)
  View.Group_Weapon.ScrollGrid_List.grid.self:SetDataCount(dataCount)
  View.Group_Weapon.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller.ShowPressure()
  if DataModel.difficultInfo.isDifficult then
    View.Group_Pressure:SetActive(true)
    View.Group_Pressure.Group_.Txt_Num:SetText(Controller.GetMaxDescent())
  else
    View.Group_Pressure:SetActive(false)
  end
end

function Controller.ShowMissionInfo(value)
  View.Group_Information.Group_Planes.Group_Switch.Group_Off:SetActive(not value)
  View.Group_Information.Group_Planes.Group_Switch.Group_On:SetActive(value)
  View.Group_Information.Group_Planes.Group_Information:SetActive(value)
  if value then
    Controller.RefreshMissionInfo()
  end
end

function Controller.RefreshMissionInfo()
  View.Group_Information.Group_Planes.Group_Information.Group_Boss.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.Boss))
  View.Group_Information.Group_Planes.Group_Information.Group_Difficult.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.HardBattle))
  View.Group_Information.Group_Planes.Group_Information.Group_Normal.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.NormalBattle))
  View.Group_Information.Group_Planes.Group_Information.Group_Store.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.Shop))
  View.Group_Information.Group_Planes.Group_Information.Group_Rest.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.Recover))
  View.Group_Information.Group_Planes.Group_Information.Group_Reward.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.Reward))
  View.Group_Information.Group_Planes.Group_Information.Group_Adventure.Txt_Num:SetText(DataModel.rubikCube:GetCubeTypeNum(DataModel.Enum_CubeType.Event))
end

function Controller.ShowCoin()
  local coinCfg = GetCA(DataModel.allConfig.coinId, "ItemFactory")
  View.Group_Coin.Img_Icon:SetSprite(coinCfg.buyPath)
  View.Group_Coin.Txt_Num:SetText(string.format("%d", PlayerData:GetGoodsById(DataModel.allConfig.coinId).num))
  coinCfg = GetCA(DataModel.allConfig.specialItemId, "ItemFactory")
  View.Group_Special.Img_Icon:SetSprite(coinCfg.buyPath)
  View.Group_Special.Txt_Num:SetText(string.format("%d", PlayerData:GetGoodsById(DataModel.allConfig.specialItemId).num))
end

function Controller.ShowTeam()
  View.Group_Team.Img_Icon:SetSprite(DataModel.teamCfg.cardIconPath)
  View.Group_Team.Txt_Name:SetText(DataModel.teamCfg.name)
end

function Controller.RefreshStepNum()
  local maxNum = DataModel.GetMaxRoundNum()
  local left = maxNum - DataModel.stepNum
  local txtColor = "#3FDCDC"
  if left <= 3 then
    txtColor = "#E46F41"
  end
  View.Group_Action.Img_Icon:SetActive(3 < left)
  View.Group_Action.Img_Not:SetActive(left <= 3)
  View.Group_Action.Txt_Num:SetText(string.format("%d", left))
  View.Group_Action.Txt_Num:SetColor(txtColor)
end

function Controller:FindCamera()
  local camGO = CS.UnityEngine.GameObject.Find("Base/Main Camera")
  if camGO == nil or camGO:IsNull() then
    return nil
  end
  local cam = camGO:GetComponent(typeof(CS.UnityEngine.Camera))
  if cam == nil then
    return nil
  end
  return cam
end

function Controller.ConfirmRot()
  DataModel.ReleaseCube()
  local nextface = DataModel.rubikCube.GetRotateNextFace(DataModel.roleCtrl.face, DataModel.isHorizon, DataModel.clockwise)
  DataModel.SendRotateMsg(nextface, function(json)
    if json.move_boss_pos == "" then
      DataModel.newBossPos = nil
    else
      DataModel.newBossPos = json.move_boss_pos
    end
    if json.new_boss_pos == "" then
      DataModel.bossRot = nil
    else
      DataModel.bossRot = json.new_boss_pos
    end
    Controller.ShowConfirmRevert(false)
    DataModel.curRotNum = DataModel.curRotNum + 1
    DataModel.CheckRoundEnd()
    Controller.RefreshPlayerStep()
    if DataModel.isHorizon then
      DataModel.rubikCube:RotHorizontalData(DataModel.roleCtrl.face, DataModel.roleCtrl.x, DataModel.roleCtrl.y, DataModel.clockwise, DataModel.roleCtrl, DataModel.bossCtrl)
    else
      DataModel.rubikCube:RotVerticalData(DataModel.roleCtrl.face, DataModel.roleCtrl.x, DataModel.roleCtrl.y, DataModel.clockwise, DataModel.roleCtrl, DataModel.bossCtrl)
    end
    DataModel:RotateToFaceUp(DataModel.roleCtrl.face)
    DataModel.roleCtrl:SetPosition(DataModel.playerCube)
    AttrManager:TriggerByTimingType(Enum_TriggerTiming.Turn)
    if Controller.DealRewardLose(json) then
      return
    end
    Controller.TryShowNextRound()
  end)
end

function Controller.DoRotate(clockwise)
  if DataModel.isHorizon == true then
    DataModel.RotHorizon(DataModel.roleCtrl.face, clockwise)
  else
    DataModel.RotVertical(DataModel.roleCtrl.face, clockwise)
  end
  DataModel.hasConfirmRot = false
  Controller.ShowConfirmRevert(true)
end

function Controller.ShowConfirmRevert(state)
  View.Group_ConfirmRot:SetActive(state)
end

function Controller.CanDealRotStuff()
  if DataModel.isRotating or DataModel.isResetRoting or DataModel.roleCtrl and DataModel.roleCtrl.IsMoving or DataModel.bossCtrl and DataModel.bossCtrl.IsMoving then
    return false
  end
  return true
end

function Controller.EaseOutBack(t)
  local c1 = 1.70158
  local c3 = c1 + 1
  return 1 + c3 * (t - 1) ^ 3 + c1 * (t - 1) ^ 2
end

function Controller.EaseInOutQuad(t)
  return t < 0.5 and 2 * t * t or 1 - (-2 * t + 2) ^ 2 / 2
end

function Controller.EaseOutQuart(t)
  return 1 - (1 - t) ^ 4
end

function Controller.EaseOutCubic(t)
  return 1 - (1 - t) ^ 3
end

function Controller.EaseInOutQuart(t)
  return t < 0.5 and 8 * t ^ 4 or 1 - (-2 * t + 2) ^ 4 / 2
end

function Controller.EaseOutBounce(t)
  local n1 = 7.5625
  local d1 = 2.75
  if t < 1 / d1 then
    return n1 * t * t
  elseif t < 2 / d1 then
    t = t - 1.5 / d1
    return n1 * t * t + 0.75
  elseif t < 2.5 / d1 then
    t = t - 2.25 / d1
    return n1 * t * t + 0.9375
  else
    t = t - 2.625 / d1
    return n1 * t * t + 0.984375
  end
end

function Controller.EaseInBounce(t)
  return 1 - Controller.EaseOutBounce(1 - t)
end

function Controller.EaseInOutBounce(t)
  return t < 0.5 and (1 - Controller.EaseOutBounce(1 - 2 * t)) / 2 or (1 + Controller.EaseOutBounce(2 * t - 1)) / 2
end

function Controller.EaseInBack(t)
  local c1 = 1.70158
  local c3 = c1 + 1
  return c3 * t ^ 3 - c1 * t ^ 2
end

function Controller:Update()
  if DataModel.isResetRoting == false and DataModel.isRotating then
    DataModel.rotElapsed = DataModel.rotElapsed + Time.deltaTime
    local t = DataModel.rotElapsed / DataModel.rotDuration
    if 1 < t then
      t = 1
    end
    local tweakedT = Controller.EaseOutQuart(t)
    local newRotation = Quaternion.Slerp(DataModel.rotStartRotation, DataModel.rotTargetRotation, tweakedT)
    DataModel.rubikCube.rot.transform.localRotation = newRotation
    if 1 <= t then
      DataModel.rubikCube.rot.transform.localRotation = DataModel.rotTargetRotation
      DataModel.isRotating = false
      if DataModel.bossRotating then
        DataModel.ReleaseCube()
        if DataModel.bossRotating == 1 then
          DataModel.rubikCube:RotVerticalData(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y, DataModel.bossRotClock, DataModel.roleCtrl, DataModel.bossCtrl)
        else
          DataModel.rubikCube:RotHorizontalData(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y, DataModel.bossRotClock, DataModel.roleCtrl, DataModel.bossCtrl)
        end
        DataModel.roleCtrl:SetPosition(DataModel.playerCube)
        DataModel.bossRotating = nil
        DataModel.bossRotClock = nil
        Controller.TryShowNextRound()
      elseif DataModel.hasConfirmRot then
        DataModel.ReleaseCube()
        Controller.playerRotating = true
        Controller.RefreshPlayerStep(Controller.playerRotating)
        DataModel.ShowPlayerRotDir(Controller.playerRotating)
      end
    end
  end
  if DataModel.isResetRoting == true then
    DataModel.rotElapsed = DataModel.rotElapsed + Time.deltaTime * DataModel.resetSpeed
    local t = DataModel.rotElapsed / DataModel.rotDuration
    if 1 < t then
      t = 1
    end
    local newRotation = Quaternion.Slerp(DataModel.resetRotStartRotation, DataModel.resetRotTargetRotation, t)
    DataModel.rubikCube.obj.transform.rotation = newRotation
    if 1 <= t then
      DataModel.rubikCube.obj.transform.rotation = DataModel.resetRotTargetRotation
      DataModel.isResetRoting = false
      DataModel.rotElapsed = 0
      if DataModel.bossResetFace then
        DataModel.bossResetFace = nil
        if not Controller.TryBossRound() then
          Controller.TryNextFace()
        end
      elseif DataModel.playerResetFace then
        DataModel.playerResetFace = nil
        Controller.TryShowNextRound()
      end
    end
  end
end

function Controller:GetRoleHpPercent(roleId)
  local hp = 1
  local roleInfo = PlayerData.TempCache.CubeRogueData.roles[tostring(roleId)]
  if roleInfo ~= nil then
    hp = roleInfo.hp or 1
  end
  return hp
end

function Controller:GetRoleExLv(roleId)
  local lv = 0
  if PlayerData.TempCache.CubeRogueData.roles ~= nil then
    local roleInfo = PlayerData.TempCache.CubeRogueData.roles[tostring(roleId)]
    if roleInfo ~= nil then
      lv = roleInfo.ex_lv or 0
    end
  end
  return lv
end

function Controller.SetRoleHp(_type, _value, _showTip)
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.roles) do
    v.hp = v.hp or 1
    if _type == "Present" then
      v.hp = v.hp * (1 + _value)
    elseif _type == "Upper" then
      v.hp = v.hp + _value
    end
    v.hp = math.min(1, math.max(1.0E-4, v.hp))
  end
  if _showTip then
    Controller.rewardList = Controller.rewardList or {}
    table.insert(Controller.rewardList, {
      ptype = "hp_change",
      isAdd = 0 < _value
    })
  end
end

function Controller:IsRoleEnough()
  local usableRoleCount = 0
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.roles) do
    if 0 < (v.hp or 1) then
      usableRoleCount = usableRoleCount + 1
    end
  end
  return 5 <= usableRoleCount
end

function Controller:AddInsideBuff(buffId, buffData)
  if PlayerData.TempCache.CubeRogueData == nil then
    return
  end
  local id = tostring(buffId)
  PlayerData.TempCache.CubeRogueData.inside_buffs[id] = buffData
  if buffData then
    local buffCa = PlayerData:GetFactoryData(id)
    local teamId = buffCa.correspondingTeam
    if PlayerData.TempCache.CubeRogueData.team == tostring(teamId) then
      PlayerData.TempCache.CubeRogueData.buff_cnt = PlayerData.TempCache.CubeRogueData.buff_cnt or 0
      PlayerData.TempCache.CubeRogueData.buff_cnt = PlayerData.TempCache.CubeRogueData.buff_cnt + 1
    end
  else
    AttrManager:TriggerByTimingType(Enum_TriggerTiming.LoseBuff)
  end
  Controller.ShowPackSake()
end

function Controller:SetBuffIntensify(buffId, val)
  if PlayerData.TempCache.CubeRogueData == nil then
    return
  end
  local id = tostring(buffId)
  if PlayerData.TempCache.CubeRogueData.inside_buffs[id] == nil then
    return
  end
  PlayerData.TempCache.CubeRogueData.inside_buffs[id].intensify = val
end

function Controller:AddEquip(equipId, equipData)
  if PlayerData.TempCache.CubeRogueData == nil then
    return
  end
  local id = tostring(equipId)
  PlayerData.TempCache.CubeRogueData.equips[id] = equipData
  if equipData then
    AttrManager:TriggerByTimingType(Enum_TriggerTiming.GetWeapon)
    AttrManager:AddEquipBuff(equipId)
  else
    AttrManager:RemoveEquip(equipId)
  end
  Controller.ShowPackSake()
end

function Controller.GetEquips(quality)
  local result = {}
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.equips) do
    local cfg = GetCA(k, "RogueEquipmentFactory")
    v.quality = cfg.quality
    if quality == "All" or v.quality == quality then
      v.id = k
      table.insert(result, v)
    end
  end
  return result
end

function Controller.GetBuffs(quality)
  local result = {}
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.inside_buffs) do
    local cfg = GetCA(k, "RogueBuffFactory")
    v.quality = cfg.quality
    if not cfg.isSpecial and (quality == "All" or v.quality == quality) then
      v.id = k
      table.insert(result, v)
    end
  end
  return result
end

function Controller:OpenPackPanel()
  UIManager:Open("UI/CubeRogue/CubeWarehouse/CubeWarehouse")
end

function Controller:OpenSquadPanel(levelId, isReStart)
  UIManager:Open("UI/CubeRogue/Team_Cube/Team_Battle", Json.encode({
    mode = "CubeSquad",
    levelId = levelId,
    isReStart = isReStart
  }))
end

function Controller:StartBattle(levelId, isReStart)
  local curSquad = {}
  local roleList1 = {}
  local roleList = PlayerData.TempCache.CubeRogueData.deck
  for k, v in pairs(roleList) do
    curSquad[#curSquad + 1] = {id = k}
    roleList1[#roleList1 + 1] = tonumber(k)
    if v.header == 1 then
      local roleData = curSquad[1]
      curSquad[1] = curSquad[#curSquad]
      curSquad[#curSquad] = roleData
      roleList1[#roleList1] = roleList1[1]
      roleList1[1] = tonumber(k)
    end
  end
  autoBattleVF.SetTeamData("Cube", roleList1, roleList1[1])
  PlayerData.BattleCallBackPage = "UI/CubeRogue/Main/CubeRogueMain"
  PlayerData.Last_Chapter_Parms = {scene = "RubikCube", delayContinue = 0}
  curSquad = SquadsDataController:GetRoleDataList(curSquad)
  local buffDic = PlayerData.TempCache.CubeRogueData.inside_buffs
  local insideSkills = {
    Ally = {},
    TeamLeader = {},
    SysUnit = {}
  }
  for k, v in pairs(buffDic) do
    local skillCa = PlayerData:GetFactoryData(k)
    local effectId = skillCa.effect
    skillCa = PlayerData:GetFactoryData(effectId)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. effectId)
    else
      table.insert(insideSkills[skillCa.effectTarget], {
        id = skillCa.id,
        weight = skillCa.skillWeight
      })
    end
  end
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.outside_buffs) do
    local skillCa = PlayerData:GetFactoryData(k)
    local effectId = skillCa.skillEffect
    skillCa = PlayerData:GetFactoryData(effectId)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\229\177\128\229\164\150\230\138\128\232\131\189Id\239\188\154" .. effectId)
    elseif skillCa.orderType == "Skill" then
      effectId = skillCa.skillId
      skillCa = PlayerData:GetFactoryData(effectId)
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\136\152\230\150\151\230\138\128\232\131\189Id\239\188\154" .. effectId)
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight
        })
      end
    end
  end
  local weaponBuffDic = AttrManager:GetBattleSkill()
  for k, v in pairs(weaponBuffDic) do
    local skillCa = PlayerData:GetFactoryData(k)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. k)
    else
      table.insert(insideSkills[skillCa.effectTarget], {
        id = k,
        weight = skillCa.skillWeight,
        val = v
      })
    end
  end
  local itemBuff = ItemAttrManager.GetBattleSkill()
  for k, v in pairs(itemBuff) do
    local skillCa = PlayerData:GetFactoryData(k)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. k)
    else
      table.insert(insideSkills[skillCa.effectTarget], {
        id = k,
        weight = skillCa.skillWeight,
        val = v
      })
    end
  end
  local teamId = PlayerData.TempCache.CubeRogueData.team
  local teamCA = PlayerData:GetFactoryData(teamId)
  for i = 1, #teamCA.initialEffectList do
    local skillCa = PlayerData:GetFactoryData(teamCA.initialEffectList[i].id)
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. teamCA.initialEffectList[i].id)
    else
      table.insert(insideSkills[skillCa.effectTarget], {
        id = teamCA.initialEffectList[i].id,
        weight = skillCa.skillWeight
      })
    end
  end
  local descentList = Controller:GetDescentBattleSkill()
  for i = 1, #descentList do
    local skillCa = PlayerData:GetFactoryData(descentList[i])
    if skillCa == nil then
      logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. descentList[i])
    else
      table.insert(insideSkills[skillCa.effectTarget], {
        id = skillCa.id,
        weight = skillCa.skillWeight
      })
    end
  end
  PlayerData.TempCache.CurCubeEid = PlayerData.TempCache.CurCubeEid or DataModel.curSelectCube.realId
  local eventCA = PlayerData:GetFactoryData(PlayerData.TempCache.CurCubeEid)
  local exLv = 0
  local bossBuff = DataModel.GetBossBuff()
  if eventCA.isBoss then
    exLv = bossBuff.boss.lv
    for k, v in pairs(bossBuff.boss.skills) do
      local skillCa = PlayerData:GetFactoryData(k)
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. k)
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight,
          val = v
        })
      end
    end
    local descentBossList = Controller:GetDescentBossBattleSkill()
    for i = 1, #descentBossList do
      local skillCa = PlayerData:GetFactoryData(descentBossList[i])
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. descentBossList[i])
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight
        })
      end
    end
  else
    exLv = bossBuff.all.lv
    for k, v in pairs(bossBuff.all.skills) do
      local skillCa = PlayerData:GetFactoryData(k)
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. k)
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight,
          val = v
        })
      end
    end
  end
  local bossSkills = PlayerData.TempCache.CubeRogueData.boss_skills
  local itemSkills = PlayerData.TempCache.CubeRogueData.item_skills
  local itemCnt = PlayerData.TempCache.CubeRogueData.face_item_cnt
  local pCA = PlayerData:GetFactoryData(PlayerData.TempCache.CubeRogueData.cube_id)
  local bossNum = #bossSkills
  local itemNum = #itemSkills
  if eventCA.typeId == 12601542 then
    bossNum = pCA.elitePlaneNum
    itemNum = pCA.eliteMuseNum
  elseif eventCA.typeId == 12601540 then
    bossNum = pCA.ordinaryPlaneNum
    itemNum = pCA.ordinaryMuseNum
  end
  for i = 1, bossNum do
    if i <= #bossSkills then
      local skillCa = PlayerData:GetFactoryData(bossSkills[i])
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. bossSkills[i])
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight
        })
      end
    end
  end
  for i = itemCnt + 1, itemNum do
    if i <= #itemSkills then
      local skillCa = PlayerData:GetFactoryData(itemSkills[i])
      if skillCa == nil then
        logError("\233\148\153\232\175\175\231\154\132\230\138\128\232\131\189Id\239\188\154" .. itemSkills[i])
      else
        table.insert(insideSkills[skillCa.effectTarget], {
          id = skillCa.id,
          weight = skillCa.skillWeight
        })
      end
    end
  end
  for k, skillList in pairs(insideSkills) do
    table.sort(skillList, function(s1, s2)
      if s1.weight ~ s2.weight then
        return s1.weight > s2.weight
      end
      return tonumber(s1.id) > tonumber(s2.id)
    end)
  end
  local skillStr = {}
  for k, skillList in pairs(insideSkills) do
    local str = ""
    for i = 1, #skillList do
      if k == "Ally" or k == "TeamLeader" then
        if str ~= "" then
          str = str .. "|"
        end
        str = str .. skillList[i].id
        if skillList[i].val ~= nil and skillList[i].val ~= -1 then
          str = str .. ",A," .. skillList[i].val
        end
      elseif k == "SysUnit" then
        if str ~= "" then
          str = str .. ","
        end
        str = str .. skillList[i].id .. ":1"
      end
    end
    skillStr[k] = str
  end
  for i = 1, #curSquad do
    local exSkills = ""
    local curHp = self:GetRoleHpPercent(curSquad[i].unitId)
    exSkills = exSkills .. 12302340 .. ",ILoseHp," .. curHp
    if i == 1 and skillStr.TeamLeader ~= "" then
      exSkills = exSkills .. "|" .. skillStr.TeamLeader
    end
    if skillStr.Ally ~= "" then
      exSkills = exSkills .. "|" .. skillStr.Ally
    end
    if curSquad[i].extraSkills ~= "" then
      curSquad[i].extraSkills = curSquad[i].extraSkills .. "|"
    end
    curSquad[i].extraSkills = curSquad[i].extraSkills .. exSkills
    curSquad[i].lv = PlayerData.GetCubeRoleLv() + self:GetRoleExLv(curSquad[i].unitId)
    curSquad[i].awakeLv = (curSquad[i].awakeLv or 0) + (PlayerData.TempCache.CubeRogueData.roles[tostring(curSquad[i].unitId)].awake_lv or 0)
    curSquad[i].equip1Id = -1
    curSquad[i].equip1Lv = 1
    curSquad[i].e1s1Id = -1
    curSquad[i].e1s1NumSN = 0
    curSquad[i].e1s2Id = -1
    curSquad[i].e1s2NumSN = 0
    curSquad[i].e1s3Id = -1
    curSquad[i].e1s3NumSN = 0
    curSquad[i].e1s4Id = -1
    curSquad[i].e1s4NumSN = 0
    curSquad[i].e1s5Id = -1
    curSquad[i].e1s5NumSN = 0
    curSquad[i].e1s6Id = -1
    curSquad[i].e1s6NumSN = 0
    curSquad[i].equip2Id = -1
    curSquad[i].equip2Lv = 1
    curSquad[i].e2s1Id = -1
    curSquad[i].e2s1NumSN = 0
    curSquad[i].e2s2Id = -1
    curSquad[i].e2s2NumSN = 0
    curSquad[i].e2s3Id = -1
    curSquad[i].e2s3NumSN = 0
    curSquad[i].e2s4Id = -1
    curSquad[i].e2s4NumSN = 0
    curSquad[i].e2s5Id = -1
    curSquad[i].e2s5NumSN = 0
    curSquad[i].e2s6Id = -1
    curSquad[i].e2s6NumSN = 0
    curSquad[i].equip3Id = -1
    curSquad[i].equip3Lv = 1
    curSquad[i].e3s1Id = -1
    curSquad[i].e3s1NumSN = 0
    curSquad[i].e3s2Id = -1
    curSquad[i].e3s2NumSN = 0
    curSquad[i].e3s3Id = -1
    curSquad[i].e3s3NumSN = 0
    curSquad[i].e3s4Id = -1
    curSquad[i].e3s4NumSN = 0
    curSquad[i].e3s5Id = -1
    curSquad[i].e3s5NumSN = 0
    curSquad[i].e3s6Id = -1
    curSquad[i].e3s6NumSN = 0
  end
  local difficulty = PlayerData.TempCache.CubeRogueData.difficulty
  local cubeId = PlayerData.TempCache.RogueCache.cubeId
  local cubeCA = PlayerData:GetFactoryData(cubeId)
  if difficulty == nil or difficulty < 0 then
    difficulty = 0
  end
  local diffData = cubeCA.rogueDifficultList[difficulty + 1]
  local enemyLevel = diffData.enemyLv + exLv
  if skillStr.SysUnit ~= "" then
    skillStr.SysUnit = skillStr.SysUnit .. ","
  end
  skillStr.SysUnit = skillStr.SysUnit .. "12303479:1"
  DataModel.ResetNetData()
  if not isReStart then
    EnemyTalentController:InitSingularityInfo()
  end
  StartBattle:StartCubeBattle(levelId, curSquad, enemyLevel, skillStr.SysUnit)
end

local hasDrag

function Controller.OnCubePointerDown(eventData, cubeData)
  hasDrag = nil
  PublicTool.PassPointerDownEvent(DataModel.rubikCube.obj, eventData)
end

function Controller.OnCubeDrag(eventData)
  hasDrag = true
  PublicTool.PassDragEvent(DataModel.rubikCube.obj, eventData)
end

function Controller.OnCubePointerUp(eventData, cubeData)
  PublicTool.PassPointerUpEvent(DataModel.rubikCube.obj, eventData)
  if hasDrag then
    return
  end
  if not Controller.playerMoving then
    return
  end
  if not DataModel.CanMoveToCube(cubeData.face, cubeData.row, cubeData.col) then
    return
  end
  if not DataModel.hasConfirmRot then
    return
  end
  if DataModel.isRotating or DataModel.isResetRoting or DataModel.roleCtrl.IsMoving then
    return
  end
  if DataModel.roleCtrl.face == cubeData.face and DataModel.roleCtrl.x == cubeData.row and DataModel.roleCtrl.y == cubeData.col then
    return
  end
  DataModel.curSelectCube = cubeData
  Controller.ShowEventConfirmPanel()
end

function Controller.ShowEventConfirmPanel()
  if DataModel.curSelectCube.netData ~= nil and DataModel.curSelectCube.netData ~= "" then
    local eCfg = GetCA(tonumber(DataModel.curSelectCube.netData), "ActivityListFactory")
    local eTag = GetCA(eCfg.typeId, "TagFactory")
    View.Group_EventDetails.Img_Icon:SetSprite(eTag.eventDetailsPng)
    if eCfg.typeId == 12601541 or eCfg.typeId == 12601542 or eCfg.typeId == 12601540 then
      local function _showEventInfo()
        local realEventCfg = GetCA(DataModel.curSelectCube.realId, "CubeEventFactory")
        
        View.Group_EventDetails.Img_ZZ:SetActive(true)
        local levelCfg = GetCA(realEventCfg.levelId)
        local bossCfg = GetCA(levelCfg.bossId)
        local bossView = GetCA(bossCfg.viewId)
        View.Group_EventDetails.Img_ZZ.Img_Enemy:SetSprite(bossView.face)
        View.Group_EventDetails.Txt_Name:SetText(realEventCfg.name)
        View.Group_EventDetails.ScrollView_Describe.Viewport.Txt_Describe:SetText(realEventCfg.des)
        View.Group_EventDetails:SetActive(true)
      end
      
      if DataModel.curSelectCube.realId == nil then
        Net:SendProto("cube.event", function(json)
          DataModel.curSelectCube.realId = tonumber(json.event_id)
          if json.event_id == "" or json.event_id == nil then
            logError("\230\156\141\229\138\161\229\153\168\232\191\148\229\155\158\228\186\134\231\169\186\231\154\132\230\136\152\230\150\151\228\186\139\228\187\182")
          end
          _showEventInfo()
        end, DataModel.curSelectCube.row .. ":" .. DataModel.curSelectCube.col .. ":" .. DataModel.curSelectCube.face)
      else
        _showEventInfo()
      end
    else
      View.Group_EventDetails.Img_ZZ:SetActive(false)
      View.Group_EventDetails.Txt_Name:SetText(eTag.eventTypeName)
      View.Group_EventDetails.ScrollView_Describe.Viewport.Txt_Describe:SetText(eTag.eventTypeDes)
      View.Group_EventDetails:SetActive(true)
    end
  else
    View.Group_EventDetails:SetActive(true)
    View.Group_EventDetails.Img_ZZ:SetActive(false)
    View.Group_EventDetails.Txt_Name:SetText(GetText(80610284))
    View.Group_EventDetails.Img_Icon:SetSprite("UI/CubeRogue/TypeIcon/icon_empty_1")
    View.Group_EventDetails.ScrollView_Describe.Viewport.Txt_Describe:SetText(GetText(80610285))
  end
end

function Controller.SetCameraToMove(value)
  if Controller.cam == nil or Controller.cam:IsNull() then
    return
  end
  local startValue, endValue, yEndValue
  if value then
    startValue = DataModel.cfg.cameraView
    endValue = DataModel.cfg.moveCameraView
    yEndValue = DataModel.cfg.moveCameraY
  else
    startValue = DataModel.cfg.moveCameraView
    endValue = DataModel.cfg.cameraView
    yEndValue = DataModel.cfg.cameraY
  end
  local tempTime = 0
  local dura = 0.5
  DOTweenTools.DOLocalMoveYCallback(Controller.cam.transform, yEndValue, dura, function()
  end, function()
  end)
  Controller.cam:DOFieldOfView(endValue, dura)
end

function Controller.RoleMoveEnd(cubeData)
  DataModel.roleCtrl.face = cubeData.face
  DataModel.roleCtrl.x = cubeData.row
  DataModel.roleCtrl.y = cubeData.col
  DataModel.curMoveNum = DataModel.curMoveNum + 1
  DataModel.CheckRoundEnd()
  Controller.playerMoving = false
  DataModel.ShowCanMoveOutline(false)
  DataModel.ShowPlayerOutline()
  Controller.RefreshPlayerStep()
  Controller.SetCameraToMove(false)
end

function Controller.CancelSelectCube()
  View.Group_EventDetails:SetActive(false)
  View.Group_EventDetails.self.gameObject:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
  DataModel.curSelectCube = nil
end

function Controller.DealRewardLose(json, dontShow)
  if json.reward and table.count(json.reward) > 0 then
    Controller.DealDirectReward(json.reward)
    Controller.InitReplaceData()
    if dontShow then
      return 0 < table.count(Controller.rewardList)
    end
    return Controller.TryShowReward()
  end
  return false
end

function Controller.ConfirmToCube()
  View.Group_EventDetails:SetActive(false)
  local cubeData = DataModel.curSelectCube
  local coord = cubeData.row .. ":" .. cubeData.col .. ":" .. cubeData.face
  Net:SendProto("cube.move", function(json)
    if json.move_boss_pos == "" then
      DataModel.newBossPos = nil
    else
      DataModel.newBossPos = json.move_boss_pos
    end
    if json.new_boss_pos == "" then
      DataModel.bossRot = nil
    else
      DataModel.bossRot = json.new_boss_pos
    end
    local sound = SoundManager:CreateSound(DataModel.allConfig.jumpSound)
    if sound then
      sound:Play()
    end
    DataModel.roleCtrl:MoveTo(cubeData, function()
      local function cb()
        cubeData.item = nil
        
        if cubeData.netData then
          local eCfg = GetCA(tonumber(cubeData.netData), "ActivityListFactory")
          AttrManager:MoveRefresh(eCfg.typeId)
        else
          AttrManager:MoveRefresh("")
        end
        AttrManager:TriggerByTimingType(Enum_TriggerTiming.MoveEnd)
        if Controller.DealRewardLose(json) then
          return
        end
        if cubeData.netData == nil or cubeData.netData == "" then
          Controller.TryShowNextRound()
        else
          local eCfg = GetCA(tonumber(cubeData.netData), "ActivityListFactory")
          if eCfg.typeId == 12601541 or eCfg.typeId == 12601542 or eCfg.typeId == 12601540 then
            Controller.StartEvent()
          else
            Controller.SendNetEvent()
          end
        end
      end
      
      Controller.PlaySpecialItemAnim(cubeData, cb)
    end)
    Controller.RoleMoveEnd(cubeData)
  end, coord)
end

function Controller.SendNetEvent(coord)
  coord = coord or DataModel.curSelectCube.row .. ":" .. DataModel.curSelectCube.col .. ":" .. DataModel.curSelectCube.face
  Net:SendProto("cube.event", function(json)
    DataModel.curSelectCube.realId = tonumber(json.event_id)
    Controller.StartEvent()
  end, coord)
end

function Controller.TryShowNextRound()
  if DataModel.needStartRound then
    local bossRound = not DataModel.bossCtrl or DataModel.newBossPos or DataModel.bossRot
    if bossRound then
      Controller.ShowBossBegin(function()
        DataModel.bossResetFace = true
        DataModel:RotateToFaceUp(DataModel.bossCtrl.face)
      end)
      return
    end
    if DataModel.needTriggerRoundEnd then
      ItemAttrManager.OnRoundEnd()
      local tips = AttrManager:TriggerByTimingType(Enum_TriggerTiming.RoundEnd)
      Controller.rewardList = Controller.rewardList or {}
      for _, tip in pairs(tips) do
        table.insert(Controller.rewardList, 1, tip)
      end
      if Controller.TryShowReward() then
        return
      end
    else
      Controller.ShowPlayerBegin()
      return
    end
    DataModel.stepNum = DataModel.stepNum + 1
    Controller.RefreshStepNum()
    if DataModel.stepNum >= DataModel.GetMaxRoundNum() then
      Controller.EndCube(false)
      return
    end
    Controller.StepNumAnim(-1, GetText(80610791), function()
      DataModel:RotateToFaceUp(DataModel.roleCtrl.face)
      Controller.ShowPlayerBegin()
    end)
  end
end

function Controller.TryBossRound()
  if DataModel.bossCtrl == nil then
    return false
  end
  if not Controller.TryBossMove() and not Controller.TryBossRot() then
    return false
  end
  return true
end

function Controller.TryBossMove()
  if DataModel.bossCtrl == nil or DataModel.newBossPos == nil then
    logError("\230\156\141\229\138\161\229\153\168\232\191\148\229\155\158\231\154\132\229\173\151\230\174\181 moveBossPos \228\184\186\231\169\186\229\173\151\231\172\166")
    return false
  end
  local temp = string.split(DataModel.newBossPos, ":")
  DataModel.newBossPos = nil
  local cube = DataModel.rubikCube:GetCube(tonumber(temp[3]), tonumber(temp[1]), tonumber(temp[2]))
  local bossCube = DataModel.rubikCube:GetCube(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y)
  DataModel.bossCtrl:MoveToLiner(cube, function()
    Controller.PlaySpecialItemAnim(cube, function()
      Controller.StartBossEvent(bossCube, cube)
    end)
  end)
  return true
end

function Controller.TryBossRot()
  if DataModel.bossCtrl == nil or DataModel.bossRot == nil then
    logError("\230\156\141\229\138\161\229\153\168\232\191\148\229\155\158\231\154\132\229\173\151\230\174\181 newBossPos \228\184\186\231\169\186\229\173\151\231\172\166")
    return false
  end
  local temp = string.split(DataModel.bossRot, ":")
  DataModel.bossRot = nil
  local isVer, isClo = DataModel.GetBossRotData(tonumber(temp[3]))
  DataModel.bossRotClock = isClo
  if isVer then
    DataModel.bossRotating = 1
    DataModel.SelectCubeVertical(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y)
    DataModel.RotVertical(DataModel.bossCtrl.face, isClo)
  else
    DataModel.bossRotating = -1
    DataModel.SelectCubeHorizontal(DataModel.bossCtrl.face, DataModel.bossCtrl.x, DataModel.bossCtrl.y)
    DataModel.RotHorizon(DataModel.bossCtrl.face, isClo)
  end
  return true
end

function Controller.StartBossEvent(bossCube, cube)
  local eventTypeId = cube.netData
  local needTips = false
  if cube.face == DataModel.roleCtrl.face and cube.row == DataModel.roleCtrl.x and cube.col == DataModel.roleCtrl.y then
    DataModel.needStartRound = nil
    DataModel.needTriggerRoundEnd = nil
    
    local function func()
      cube.netData = bossCube.netData
      cube.realId = bossCube.realId
      bossCube.netData = nil
      bossCube.realId = nil
      bossCube.item = nil
      DataModel.curSelectCube = cube
      local event = PlayerData:GetFactoryData(cube.realId, "CubeEventFactory")
      Controller:OpenSquadPanel(event.levelId)
    end
    
    if bossCube.realId == nil or bossCube.realId <= 0 then
      Net:SendProto("cube.event", function(json)
        bossCube.realId = tonumber(json.event_id)
        if json.event_id == "" or json.event_id == nil then
          logError("\230\156\141\229\138\161\229\153\168\232\191\148\229\155\158\228\186\134\231\169\186\231\154\132\230\136\152\230\150\151\228\186\139\228\187\182")
        end
        func()
      end, bossCube.row .. ":" .. bossCube.col .. ":" .. bossCube.face)
    else
      func()
    end
    return
  else
    if cube.netData then
      DataModel.AddBossBuff(cube.netData)
      local eventCfg = PlayerData:GetFactoryData(cube.netData, "ActivityListFactory")
      local eventType = PlayerData:GetFactoryData(eventCfg.typeId, "TagFactory")
      local eventName = eventType.eventTypeName
      local skillDes
      if eventType.skillBuff and eventType.skillBuff ~= "" and 0 < eventType.skillBuff then
        local effect = PlayerData:GetFactoryData(eventType.skillBuff, "SkillFactory")
        skillDes = effect.description
      end
      View.Group_BossAction.Txt_Move:SetActive(true)
      View.Group_BossAction.Txt_Move:SetText(string.format(GetText(80610684), eventName))
      if skillDes then
        View.Group_BossAction.Txt_Skill:SetText(string.format(GetText(80610685), skillDes))
      else
        View.Group_BossAction.Txt_Skill:SetText(GetText(80610686))
      end
    else
      View.Group_BossAction.Txt_Move:SetActive(false)
      View.Group_BossAction.Txt_Skill:SetText(GetText(80610882))
    end
    View.Group_BossAction.Txt_Get:SetActive(cube.item ~= nil and table.count(cube.item) ~= 0)
    needTips = true
  end
  cube.netData = bossCube.netData
  cube.realId = bossCube.realId
  bossCube.netData = nil
  bossCube.realId = nil
  if cube.item then
    bossCube.item = bossCube.item or {}
    for k, v in pairs(cube.item) do
      if bossCube.item[k] then
        bossCube.item[k].num = bossCube.item[k].num + v.num
      else
        bossCube.item[k] = v
      end
    end
  end
  cube.item = bossCube.item
  bossCube.item = nil
  DataModel.rubikCube:ShowIcon(bossCube.face, bossCube.x, bossCube.y)
  DataModel.rubikCube:ShowIcon(cube.face, cube.x, cube.y)
  if needTips then
    Controller.ShowBossAction(function()
      if not Controller.TryBossRound() then
        Controller.TryNextFace()
      end
    end)
  elseif not Controller.TryBossRound() then
    Controller.TryNextFace()
  end
end

function Controller.StepNumAnim(num, txt, callBack)
  local show
  if 0 <= num then
    show = "+" .. string.format("%d", num)
  else
    show = "-" .. string.format("%d", math.abs(num))
  end
  View.Group_ActionTip.Txt_Add:SetText(show)
  View.Group_ActionTip.Txt_Name:SetText(txt)
  View.Group_ActionTip:SetActive(true)
  Controller.RemoveTimer("NextRound")
  Controller.StartTimer("NextRound", 2, function()
    View.Group_ActionTip:SetActive(false)
    if callBack then
      callBack()
    end
  end, true)
end

local function getRewardShowInfo(ptype, param)
  if Controller.rewardList == nil then
    return nil
  end
  for k, v in pairs(Controller.rewardList) do
    if v.ptype == ptype and v.itemType == param then
      return v
    end
  end
  return nil
end

local function removeAllRandomGet()
  if Controller.rewardList == nil then
    return
  end
  local num = #Controller.rewardList
  for i = num, 1, -1 do
    if Controller.rewardList[i].sendNet then
      if Controller.rewardList[i].data then
        Controller.rewardList[i].sendNet = nil
      else
        table.remove(Controller.rewardList, i)
      end
    end
  end
end

function Controller.ShowOneReward(data)
  if data.ptype == "get_gold" then
    UIManager:Open("UI/CubeRogue/ShowItem/CubeRogueShowItem", Json.encode(data))
  elseif data.ptype == "lose_gold" then
    UIManager:Open("UI/CubeRogue/ShowItem/CubeRogueShowItem", Json.encode(data))
  elseif data.ptype == "get_equip_buff" or data.ptype == "lose_equip_buff" then
    if data.sendNet then
      Net:SendProto("cube.select_package", function(json)
        removeAllRandomGet()
        Controller.DealDirectReward(json.reward)
        Controller.OnPanelBack()
      end)
    elseif data.data == nil then
      Controller.OnPanelBack()
    else
      UIManager:Open("UI/CubeRogue/ItemGet/ItemGet", Json.encode(data))
    end
  elseif data.ptype == "get_equip_buff_select" then
    UIManager:Open("UI/CubeRogue/ItemSelection/ItemSelection", Json.encode(data))
  elseif data.ptype == "lose_equip_buff_select" then
    UIManager:Open("UI/CubeRogue/ItemSelection/ItemSelection", Json.encode(data))
  elseif data.ptype == "intensify" then
    UIManager:Open("UI/CubeRogue/ItemGet/ItemGet", Json.encode(data))
  elseif data.ptype == "hp_change" then
    UIManager:Open("UI/CubeRogue/HpTips/CubeRogueHpTips", Json.encode(data))
  end
end

local tableCopy

function tableCopy(t)
  if t == nil then
    return nil
  end
  local result = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      result[k] = tableCopy(v)
    else
      result[k] = v
    end
  end
  return result
end

function Controller.DealDirectReward(reward)
  Controller.rewardList = Controller.rewardList or {}
  if reward.item then
    local item = {
      ptype = "get_equip_buff",
      itemType = "Item",
      data = nil
    }
    local items = {}
    local tips1, tips2
    for k, v in pairs(reward.item) do
      v.id = k
      if k == tostring(DataModel.allConfig.coinId) then
        items[k] = v.num
        tips1 = AttrManager:TriggerByTimingType(Enum_TriggerTiming.GetCoin, {
          getNum = v.num
        })
      elseif k == tostring(DataModel.allConfig.specialItemId) then
        items[k] = v.num
        tips2 = AttrManager:TriggerByTimingType(Enum_TriggerTiming.GetSpecial, {
          getNum = v.num
        })
        PlayerData.TempCache.CubeRogueData.face_item_cnt = PlayerData.TempCache.CubeRogueData.face_item_cnt or 0
        PlayerData.TempCache.CubeRogueData.face_item_cnt = PlayerData.TempCache.CubeRogueData.face_item_cnt + 1
      else
        if not v.dontAdd then
          ItemAttrManager.GetItem(k)
        end
        item.data = item.data or {}
        table.insert(item.data, v)
        reward.item[k] = nil
      end
    end
    if 0 < table.count(reward.item) then
      table.insert(Controller.rewardList, {
        ptype = "get_gold",
        data = reward.item
      })
      Controller.ShowCoin()
    end
    if tips1 then
      for _, tip in pairs(tips1) do
        table.insert(Controller.rewardList, 1, tip)
      end
    end
    if tips2 then
      for _, tip in pairs(tips2) do
        table.insert(Controller.rewardList, 1, tip)
      end
    end
    if item.data and 0 < table.count(item.data) then
      table.insert(Controller.rewardList, item)
      Controller.RefreshUseItems()
    end
  end
  local equip = {
    ptype = "get_equip_buff",
    itemType = "Equip",
    data = nil
  }
  local buff = {
    ptype = "get_equip_buff",
    itemType = "Buff",
    data = nil
  }
  local specialBuff = {
    ptype = "get_equip_buff",
    itemType = "Buff",
    data = nil,
    isSpecial = true
  }
  local intensifyBuff = {ptype = "intensify", data = nil}
  
  local function seteb(list, t)
    if list == nil then
      return
    end
    t.data = t.data or {}
    for k, v in pairs(list) do
      v.id = k
      if t.itemType == "Buff" then
        local buffCfg = GetCA(k, "RogueBuffFactory")
        if buffCfg.isSpecial then
          specialBuff.data = specialBuff.data or {}
          table.insert(specialBuff.data, v)
        elseif v.intensify then
          intensifyBuff.data = intensifyBuff.data or {}
          table.insert(intensifyBuff.data, v)
        else
          table.insert(t.data, v)
        end
      else
        table.insert(t.data, v)
      end
      if t.itemType == "Equip" then
        Controller:AddEquip(k, v)
        Controller.ShowPackSake()
      elseif t.itemType == "Buff" then
        Controller:AddInsideBuff(k, v)
        Controller.ShowPackSake()
      end
    end
  end
  
  seteb(reward.rg_equip, equip)
  seteb(reward.rg_buff, buff)
  if reward.rg_pack then
    for k, v in pairs(reward.rg_pack) do
      local pcfg = GetCA(tonumber(k), "ActivityListFactory")
      if pcfg.func == "Random" then
        local temp = pcfg.packageType == "Equip" and equip or buff
        if temp.data then
          temp = tableCopy(temp)
          temp.data = nil
          temp.sendNet = true
          table.insert(Controller.rewardList, temp)
        else
          temp.sendNet = true
        end
      elseif pcfg.func == "Select" then
        local tempDataList = v.buff or v.equip
        local realDataList = {}
        for o, p in pairs(tempDataList) do
          realDataList[tostring(p)] = {}
        end
        if 0 < table.count(realDataList) then
          local temp = {
            ptype = "get_equip_buff_select",
            id = k,
            data = realDataList,
            refresh = v.refresh
          }
          table.insert(Controller.rewardList, temp)
        end
      elseif pcfg.loseType == "Select" then
        table.insert(Controller.rewardList, {
          ptype = "lose_equip_buff_select",
          id = tonumber(k),
          data = v
        })
      end
    end
  end
  if specialBuff.data and 0 < table.count(specialBuff.data) then
    table.insert(Controller.rewardList, specialBuff)
  end
  if intensifyBuff.data and 0 < table.count(intensifyBuff.data) then
    table.insert(Controller.rewardList, intensifyBuff)
  end
  if buff.data and 0 < table.count(buff.data) or buff.sendNet then
    table.insert(Controller.rewardList, buff)
  end
  if equip.data and 0 < table.count(equip.data) or equip.sendNet then
    table.insert(Controller.rewardList, equip)
  end
end

function Controller.TryShowReward()
  if Controller.rewardList == nil or #Controller.rewardList == 0 then
    if DataModel.surplusItems then
      UIManager:Open("UI/CubeRogue/ItemReplace/RogueItemReplace")
      return true
    end
    return false
  end
  local rData = Controller.rewardList[#Controller.rewardList]
  Controller.rewardList[#Controller.rewardList] = nil
  Controller.ShowOneReward(rData)
  return true
end

function Controller.StartEvent()
  if DataModel.curSelectCube == nil or DataModel.curSelectCube.realId == nil then
    return
  end
  local eId = tonumber(DataModel.curSelectCube.realId)
  local eCfg = GetCA(eId, "RogueEventFactory")
  if eCfg.func == "OpenLevel" then
    Controller:OpenSquadPanel(eCfg.levelId)
  elseif eCfg.func == "Reward" then
    Controller.TryTriggerEvent(nil, function(json)
      Controller.DealRewardLose(json)
    end)
  elseif eCfg.func == "OpenUI" then
    if not UIManager:IsPanelOpened(eCfg.uiPath) then
      UIManager:Open(eCfg.uiPath, Json.encode({triggerWhenClose = true}))
      Controller.TryShowReward()
    end
  elseif eCfg.func == "Options" then
    Controller.InitOptionPanelData(eCfg)
    Controller.ShowOptionsPanel(true, true)
  end
end

function Controller.InitOptionPanelData(eventCfg)
  Controller.curOptionEvent = eventCfg
  Controller.curSelectOption = -1
  DataModel.AllOptions = {}
  local op = eventCfg.optionList
  for k, v in pairs(op) do
    local cannotSelect
    local optionCfg = GetCA(v.id, "ActivityListFactory")
    for m, n in pairs(optionCfg.optionFuncList) do
      local funcCfg = GetCA(n.id, "RogueOrderFactory")
      if funcCfg.orderType == "Discard" and funcCfg.isEnough then
        for i, j in pairs(funcCfg.discardList) do
          local isEnough = PlayerData:GetGoodsById(j.id).num >= j.num
          if not isEnough then
            cannotSelect = GetText(funcCfg.insufficientTips)
          end
          break
        end
      elseif funcCfg.orderType == "LoseBuff" then
        local hasCount = #Controller.GetBuffs(funcCfg.qualityType)
        if hasCount < funcCfg.param then
          cannotSelect = GetText(funcCfg.insufficientTips)
        end
      elseif funcCfg.orderType == "LoseEquip" then
        local hasCount = #Controller.GetEquips(funcCfg.qualityType)
        if hasCount < funcCfg.param then
          cannotSelect = GetText(funcCfg.insufficientTips)
        end
      elseif funcCfg.orderType == "Intensify" then
        local hasCount = #Controller.GetBuffs(funcCfg.qualityType)
        if hasCount < funcCfg.param then
          cannotSelect = GetText(funcCfg.insufficientTips)
        end
      elseif funcCfg.orderType == "Action" and funcCfg.param < 0 and DataModel.GetMaxRoundNum() - DataModel.stepNum < math.abs(funcCfg.param) then
        cannotSelect = GetText(funcCfg.insufficientTips)
      end
    end
    table.insert(DataModel.AllOptions, {
      index = k,
      cfg = optionCfg,
      cannotSel = cannotSelect
    })
  end
end

function Controller.ShowOptionsPanel(needAnim, refreshStatic)
  needAnim = needAnim == nil and true or needAnim
  View.Group_EventOptions:SetActive(true)
  local eventCfg = Controller.curOptionEvent
  if needAnim then
    Controller.optionPanelState = 1
    View.Group_EventOptions.Group_Options:SetActive(false)
    View.self:SelectPlayAnim(View.Group_EventOptions.self, "in1", function()
      Controller.optionPanelState = 2
      if not Controller.isDoText then
        Controller.ShowOptionsPanel(false)
      end
    end)
    View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetText("")
    Controller.StartTimer("DelayDoText", 0.05, function()
      Controller.isDoText = true
      View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetTweenContent(eventCfg.des, function()
        Controller.isDoText = false
        if Controller.optionPanelState == 2 then
          Controller.ShowOptionsPanel(false)
        end
      end, 0.04)
    end, true)
  else
    Controller.optionPanelState = 3
    if Controller.isDoText then
      Controller.isDoText = false
      View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:CompleteTween()
    end
    View.Group_EventOptions.Group_Options:SetActive(true)
    View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetText(eventCfg.des)
    View.self:SelectPlayAnim(View.Group_EventOptions.self, "in2", function()
      Controller.optionPanelState = 4
    end)
  end
  if not refreshStatic then
    return
  end
  View.Group_EventOptions.Group_Left.Txt_Name:SetText(eventCfg.name)
  local hasNpc = eventCfg.npcId and eventCfg.npcId > 0
  if hasNpc then
    View.Group_EventOptions.Group_Left.Group_Bg:SetActive(false)
    View.Group_EventOptions.Group_Left.Group_Character:SetActive(true)
    local npcCfg = PlayerData:GetFactoryData(eventCfg.npcId, "NPCFactory")
    local hasSpine = npcCfg.spineUrl and npcCfg.spineUrl ~= ""
    if hasSpine then
      View.Group_EventOptions.Group_Left.Group_Character.Spine_Character:SetActive(true)
      View.Group_EventOptions.Group_Left.Group_Character.Img_Character:SetActive(false)
      View.Group_EventOptions.Group_Left.Group_Character.Spine_Character:SetData(npcCfg.spineUrl)
      View.Group_EventOptions.Group_Left.Group_Character.Spine_Character:SetAnchoredPosition(Vector2(npcCfg.spineOffsetX, npcCfg.spineOffsetY))
      View.Group_EventOptions.Group_Left.Group_Character.Spine_Character:SetLocalScale(npcCfg.spineScale, npcCfg.spineScale, npcCfg.spineScale)
    else
      View.Group_EventOptions.Group_Left.Group_Character.Spine_Character:SetActive(false)
      View.Group_EventOptions.Group_Left.Group_Character.Img_Character:SetActive(true)
      View.Group_EventOptions.Group_Left.Group_Character.Img_Character:SetSprite(npcCfg.resUrl)
      View.Group_EventOptions.Group_Left.Group_Character.Img_Character:SetAnchoredPosition(Vector2(npcCfg.offsetX, npcCfg.offsetY))
    end
  else
    View.Group_EventOptions.Group_Left.Group_Bg:SetActive(true)
    View.Group_EventOptions.Group_Left.Group_Character:SetActive(false)
    View.Group_EventOptions.Group_Left.Group_Bg.Img_ZZ.Img_Icon:SetSprite(eventCfg.iconPath)
  end
  View.Group_EventOptions.Img_Title:SetSprite(GetResPath(88300208))
  local dataCount = #DataModel.AllOptions
  local tempGrid
  for i = 1, 4 do
    local _show = i == dataCount
    View.Group_EventOptions.Group_Options["StaticGrid_List" .. i].self:SetActive(_show)
    if _show then
      tempGrid = View.Group_EventOptions.Group_Options["StaticGrid_List" .. i]
    end
  end
  if tempGrid then
    tempGrid.grid.self:SetDataCount(dataCount)
    tempGrid.grid.self:RefreshAllElement()
  end
  Controller.curOptionGrid = tempGrid
end

function Controller.SetOptionView(element, elementIndex)
  local data = DataModel.AllOptions[elementIndex]
  if data == nil then
    return
  end
  
  local function initShow(group)
    group.Txt_Name:SetText(data.cfg.optionName)
    group.Txt_Des:SetText(data.cfg.optionDes)
    if group.Txt_Tips then
      group.Txt_Tips:SetText(data.cannotSel)
    end
    if group.Btn_ then
      group.Btn_:SetClickParam(tostring(data.index))
    end
  end
  
  if data.cannotSel then
    element.Group_Normal:SetActive(false)
    element.Group_Affirm:SetActive(false)
    element.Group_Limit:SetActive(true)
    initShow(element.Group_Limit)
  else
    local isSelected = Controller.curSelectOption == data.index
    element.Group_Normal:SetActive(not isSelected)
    element.Group_Affirm:SetActive(isSelected)
    element.Group_Limit:SetActive(false)
    if isSelected then
      initShow(element.Group_Affirm)
    else
      initShow(element.Group_Normal)
    end
  end
end

function Controller.OptionSelectClick(str)
  if DataModel.isDealingOrder then
    return
  end
  if Controller.optionPanelState ~= 4 then
    return
  end
  Controller.SelectOption(tonumber(str))
end

function Controller.OptionConfirmClick(str)
  if DataModel.isDealingOrder then
    return
  end
  Controller.ConfirmOption(tonumber(str))
end

function Controller.SelectOption(index)
  Controller.curSelectOption = index
  if Controller.curOptionGrid then
    Controller.curOptionGrid.grid.self:RefreshAllElement()
  end
end

function Controller.ConfirmOption(index)
  local data = DataModel.AllOptions[index]
  if data == nil then
    return
  end
  local needTrigger = true
  if data.cfg.optionFuncList and #data.cfg.optionFuncList > 0 then
    local first = GetCA(data.cfg.optionFuncList[1].id, "RogueOrderFactory")
    if first.orderType == "Level" then
      needTrigger = false
    end
  end
  DataModel.BattleEndTriggerOptionId = data.cfg.id
  
  local function call()
    Controller.dealOptionList = data.cfg.optionFuncList or {}
    Controller.dealOptionIndex = 1
    DataModel.isDealingOrder = true
  end
  
  Net:SendProto("cube.option_pack", function(json)
    if needTrigger then
      Controller.TryDealOrderAfterTrigger(call)
    else
      call()
      Controller.TryDealOrder()
    end
  end, data.cfg.id)
end

function Controller.TryDealOrderAfterTrigger(call)
  Controller.TryTriggerEvent(nil, function(json)
    if call then
      call()
    end
    Controller.dealOptionNetData = json
    if json.event_id and json.event_id ~= "" then
      DataModel.needStartRound = nil
      DataModel.needTriggerRoundEnd = nil
    end
    Controller.TryDealOrder()
  end)
end

function Controller.TryDealOrder()
  if DataModel.isDealingOrder then
    if not Controller.DealOrder() then
      Controller.dealOptionIndex = nil
      Controller.dealOptionList = nil
      Controller.dealOptionNetData = nil
      DataModel.isDealingOrder = nil
      Controller.OptionOver()
      return false
    end
    return true
  end
  return false
end

function Controller.DealOrder()
  if Controller.dealOptionIndex > #Controller.dealOptionList then
    return false
  end
  local orderID = Controller.dealOptionList[Controller.dealOptionIndex].id
  local orderCfg = GetCA(orderID, "RogueOrderFactory")
  local json = Controller.dealOptionNetData
  Controller.dealOptionIndex = Controller.dealOptionIndex + 1
  if orderCfg.orderType == "Level" then
    local needTrigger = true
    local next = Controller.dealOptionList[Controller.dealOptionIndex + 1]
    if next then
      local nextCfg = GetCA(next.id, "RogueOrderFactory")
      if nextCfg.orderType == "Level" then
        needTrigger = false
      end
    end
    Controller:OpenSquadPanel(orderCfg.levelId)
  elseif orderCfg.orderType == "Reward" then
    if not Controller.DealRewardLose(json) then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "Event" then
    if Controller.TryDealOrder() then
      print_r("\230\168\161\228\187\191\232\130\137\233\184\189: Order\233\133\141\231\189\174\233\148\153\232\175\175, OrderID: " .. orderID .. " \230\173\164\231\177\187\229\158\139\229\145\189\228\187\164\233\156\128\232\166\129\233\133\141\231\189\174\229\156\168\229\136\151\232\161\168\231\154\132\230\156\128\229\144\142")
    end
    
    function Controller.optionOverCallBack()
      if json.event_id == nil or json.event_id == "" or json.event_id == 0 then
        Controller.TryNextFace()
      else
        DataModel.curSelectCube.realId = tonumber(json.event_id)
        Controller.StartEvent()
      end
    end
  elseif orderCfg.orderType == "Discard" then
    local tempData = {}
    local showData = {}
    for m, n in pairs(orderCfg.discardList) do
      tempData[tostring(n.id)] = math.min(n.num, PlayerData:GetGoodsById(n.id).num)
      table.insert(showData, n)
      if n.id == DataModel.allConfig.coinId then
        AttrManager:TriggerByTimingType(Enum_TriggerTiming.LoseCoin, {
          loseNum = n.num
        })
      elseif n.id == DataModel.allConfig.specialItemId then
      end
    end
    if table.count(showData) > 0 then
      Controller.rewardList = Controller.rewardList or {}
      table.insert(Controller.rewardList, {ptype = "lose_gold", data = showData})
    end
    PlayerData:RefreshUseItems(tempData)
    Controller.ShowCoin()
    if not Controller.TryShowReward() then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "Action" then
    ItemAttrManager.AddEventAttr(orderID)
    Controller.RefreshStepNum()
    Controller.StepNumAnim(orderCfg.param, GetText(80610791), function()
      Controller.StartTimer("delayContinueOrder", 0.1, function()
        Controller.TryDealOrder()
      end, true)
    end)
  elseif orderCfg.orderType == "Intensify" then
    Controller.rewardList = Controller.rewardList or {}
    local intensifyList = {}
    for k, v in pairs(json.intensify_bf) do
      table.insert(intensifyList, {
        id = tonumber(v),
        intensify = true
      })
      Controller:SetBuffIntensify(v, 1)
    end
    if 0 < #intensifyList then
      table.insert(Controller.rewardList, {ptype = "intensify", data = intensifyList})
    end
    if not Controller.TryShowReward() then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "LoseBuff" then
    Controller.rewardList = Controller.rewardList or {}
    if json.select_buffs and json.select_buffs[tostring(orderCfg.id)] then
      local dataDic = json.select_buffs[tostring(orderCfg.id)]
      if table.count(dataDic) > 0 then
        table.insert(Controller.rewardList, {
          ptype = "lose_equip_buff_select",
          id = orderCfg.id,
          data = dataDic
        })
      end
    elseif json.random_buffs and 0 < table.count(json.random_buffs) then
      local dataDic = json.random_buffs
      local list = {}
      for m, n in pairs(dataDic) do
        n.id = m
        table.insert(list, n)
        Controller:AddInsideBuff(m, nil)
      end
      if 0 < #list then
        table.insert(Controller.rewardList, {
          ptype = "lose_equip_buff",
          itemType = "Buff",
          data = list
        })
      end
    end
    if not Controller.TryShowReward() then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "LoseEquip" then
    Controller.rewardList = Controller.rewardList or {}
    if json.select_equips and json.select_equips[tostring(orderCfg.id)] then
      local dataDic = json.select_equips[tostring(orderCfg.id)]
      if table.count(dataDic) > 0 then
        table.insert(Controller.rewardList, {
          ptype = "lose_equip_buff_select",
          id = orderCfg.id,
          data = dataDic
        })
      end
    elseif json.random_equips and 0 < table.count(0 < json.table.count(json.random_equips)) then
      local dataDic = json.random_equips
      local list = {}
      for m, n in pairs(dataDic) do
        n.id = m
        table.insert(list, n)
        Controller:AddEquip(n, nil)
      end
      if 0 < #list then
        table.insert(Controller.rewardList, {
          ptype = "lose_equip_buff",
          itemType = "Equip",
          data = list
        })
      end
    end
    if not Controller.TryShowReward() then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "Recover" then
    Controller.SetRoleHp(orderCfg.recoverType, orderCfg.param, true)
    if not Controller.TryShowReward() then
      Controller.TryDealOrder()
    end
  elseif orderCfg.orderType == "SpinNum" then
    ItemAttrManager.AddEventAttr(orderID)
    Controller.RefreshPlayerStep()
    DataModel.needStartRound = nil
    DataModel.needTriggerRoundEnd = nil
    Controller.StepNumAnim(orderCfg.param, GetText(80610792), function()
      Controller.StartTimer("delayContinueOrder", 0.1, function()
        Controller.TryDealOrder()
      end, true)
    end)
  elseif orderCfg.orderType == "StepNum" then
    ItemAttrManager.AddEventAttr(orderID)
    Controller.RefreshPlayerStep()
    DataModel.needStartRound = nil
    DataModel.needTriggerRoundEnd = nil
    Controller.StepNumAnim(orderCfg.param, GetText(80610793), function()
      Controller.StartTimer("delayContinueOrder", 0.1, function()
        Controller.TryDealOrder()
      end, true)
    end)
  else
    Controller.TryDealOrder()
  end
  return true
end

function Controller.OptionOver(needAnim)
  needAnim = needAnim == nil and true or needAnim
  local optionData = DataModel.AllOptions[Controller.curSelectOption]
  View.Group_EventOptions.Group_Options:SetActive(false)
  if needAnim then
    Controller.optionPanelState = 5
    View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetText("")
    View.self:SelectPlayAnim(View.Group_EventOptions.self, "finish1", function()
      Controller.optionPanelState = 6
      Controller.isDoText = true
      View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetTweenContent(optionData.cfg.endDes, function()
        Controller.isDoText = false
      end, 0.04)
      View.self:SelectPlayAnim(View.Group_EventOptions.self, "finish2", function()
      end)
    end)
  else
    if Controller.isDoText then
      Controller.isDoText = false
      View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:CompleteTween()
    end
    Controller.optionPanelState = 6
    View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:SetText(optionData.cfg.endDes)
    View.self:SelectPlayAnim(View.Group_EventOptions.self, "finish2", function()
    end)
  end
end

function Controller.CloseOptionsPanel()
  View.Group_EventOptions:SetActive(false)
  Controller.optionPanelState = nil
  Controller.curOptionEvent = nil
  Controller.isDoText = nil
  Controller.curSelectOption = nil
  DataModel.AllOptions = nil
  Controller.dealOptionList = nil
  Controller.dealOptionIndex = nil
  Controller.TryShowNextRound()
  if Controller.optionOverCallBack then
    Controller.optionOverCallBack()
    Controller.optionOverCallBack = nil
  end
end

function Controller.RoleFlashPos(json)
  if DataModel.roleCtrl == nil then
    return
  end
  if json.cur_lct == nil or json.cur_lct == "" then
    Controller.DealRewardLose(json)
    return
  end
  local face, x, y
  local temp = string.split(json.cur_lct, ":")
  face = tonumber(temp[3])
  x = tonumber(temp[1])
  y = tonumber(temp[2])
  local cube = DataModel.rubikCube:GetCube(face, x, y)
  if cube == nil then
    return
  end
  DataModel.roleCtrl:MoveToFlash(cube, function()
    DataModel:RotateToFaceUp(face)
  end, DataModel.rotDuration, function()
    DataModel.ShowPlayerOutline()
    DataModel.curSelectCube = DataModel.playerCube
  end, function()
    Controller.PlaySpecialItemAnim(DataModel.curSelectCube, function()
      DataModel.curSelectCube.item = nil
      if not Controller.DealRewardLose(json) then
        Controller.OnPanelBack()
      end
    end)
  end)
end

function Controller.OpenRestPanel(restId)
  local nextCfg
  if restId then
    nextCfg = GetCA(PlayerData.TempCache.CubeRogueData.cube_id, "CubeRogueFactory")
  else
    restId = DataModel.cfg.restId
    nextCfg = GetCA(DataModel.cfg.nextId, "CubeRogueFactory")
  end
  local nextId = nextCfg and nextCfg.id or nil
  if restId == nil or restId <= 0 then
    return false, nextId
  end
  PlayerData.TempCache.CubeRogueData.rest_id = tostring(restId)
  PlayerData:DeletePlayerPrefs("CubeRogueFaceAnimation")
  DataModel.restPanelCfg = GetCA(restId, "RogueEventFactory")
  View.Group_RestArea:SetActive(true)
  Controller.ShowConfirmRevert(false)
  View.Group_RestArea.Group_Top.Img_Bg:SetSprite(GetResPath(88300161))
  View.Group_RestArea.Group_Next.Img_Next:SetSprite(GetResPath(88300162))
  View.Group_RestArea.Group_Next.Img_Num:SetSprite(nextCfg.numIcon)
  View.Group_RestArea.StaticGrid_List.grid.self:SetDataCount(#DataModel.restPanelCfg.restEventList)
  View.Group_RestArea.StaticGrid_List.grid.self:RefreshAllElement()
  return true, nextId
end

function Controller.RefreshUseItems()
  View.Group_UseItem.StaticGrid_List.grid.self:SetDataCount(DataModel.GetMaxItemNum_Slot())
  View.Group_UseItem.StaticGrid_List.grid.self:RefreshAllElement()
end

function Controller.GetMaxDescent()
  if DataModel.maxDescent then
    return DataModel.maxDescent
  end
  local val = 0
  local buffMap = {}
  for k, v in pairs(PlayerData.TempCache.CubeRogueData.debuff) do
    local orderCA = PlayerData:GetFactoryData(k)
    if orderCA and buffMap[orderCA.descent] ~= true then
      buffMap[orderCA.descent] = true
      local buffCA = PlayerData:GetFactoryData(orderCA.descent)
      if buffCA then
        val = val + buffCA.descent
      end
    end
  end
  DataModel.maxDescent = val
  return DataModel.maxDescent
end

function Controller:GetDescentBattleSkill()
  local skillList = {}
  local attrList = DataModel.GetDescentAttr("Battle")
  for i = 1, #attrList do
    local attrCA = PlayerData:GetFactoryData(attrList[i])
    skillList[#skillList + 1] = attrCA.skillId
  end
  return skillList
end

function Controller:GetDescentBossBattleSkill()
  local skillList = {}
  local attrList = DataModel.GetDescentAttr("BossBattle")
  for i = 1, #attrList do
    local attrCA = PlayerData:GetFactoryData(attrList[i])
    skillList[#skillList + 1] = attrCA.skillId
  end
  return skillList
end

function Controller.ClearData()
  Controller.StopAllTimer()
  if Controller.isDoText then
    Controller.isDoText = nil
    View.Group_EventOptions.Group_Left.ScrollView_Describe.Viewport.Txt_Describe:CompleteTween()
  end
  DataModel.rotSpeed = nil
  DataModel.rotDuration = nil
  DataModel.resetSpeed = nil
  DataModel.outlineWidth = nil
  if DataModel.rubikCube then
    DataModel.rubikCube:Clear()
    DataModel.rubikCube = nil
  end
  if DataModel.roleCtrl then
    DataModel.roleCtrl:Clear()
    DataModel.roleCtrl = nil
  end
  if DataModel.bossCtrl then
    DataModel.bossCtrl:Clear()
    DataModel.bossCtrl = nil
  end
  DataModel.playerCube = nil
  DataModel.curSelectCube = nil
  DataModel.CurrentColor = nil
  DataModel.MoveColor = nil
  DataModel.SpinSideColor = nil
  DataModel.canMoveCubes = nil
  DataModel.isRotating = nil
  DataModel.isResetRoting = nil
  DataModel.hasConfirmRot = true
  DataModel.rotCube = nil
  DataModel.mapID = nil
  DataModel.cfg = nil
  DataModel.curMoveNum = nil
  DataModel.maxMoveNum = nil
  DataModel.curRotNum = nil
  DataModel.maxRotNum = nil
  Controller.playerMoving = nil
  Controller.playerRotating = nil
  DataModel.stepNum = nil
  DataModel.difficult = nil
  DataModel.allConfig = nil
  DataModel.difficultInfo = nil
  DataModel.buffList = nil
  DataModel.battleRoles = nil
  DataModel.equipList = nil
  Controller.ContinueClick = nil
  Controller.cacheLevelId = nil
  DataModel.isHorizon = nil
  DataModel.clockwise = nil
  DataModel.rotElapsed = nil
  DataModel.rotStartRotation = nil
  DataModel.rotTargetRotation = nil
  DataModel.isAuto = nil
  hasDrag = nil
  Controller.rewardList = nil
  Controller.curOptionEvent = nil
  Controller.curSelectOption = nil
  DataModel.AllOptions = nil
  Controller.optionPanelState = nil
  Controller.dealOptionList = nil
  Controller.dealOptionIndex = nil
  Controller.optionOverCallBack = nil
  DataModel.isDealingOrder = nil
  Controller.NeedTriggerAfterReward = nil
  DataModel.BattleEndTriggerOptionId = nil
  DataModel.bossRotating = nil
  DataModel.bossResetFace = nil
  DataModel.playerResetFace = nil
  DataModel.maxDescent = nil
  DataModel.descentAttr = nil
  DataModel.newBossPos = nil
  DataModel.bossRot = nil
  DataModel.bossRotating = nil
  DataModel.bossResetFace = nil
  DataModel.needStartRound = nil
  DataModel.needTriggerRoundEnd = nil
end

return Controller
