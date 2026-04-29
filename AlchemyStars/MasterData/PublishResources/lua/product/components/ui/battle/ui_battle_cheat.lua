local UIBattleCheatHideUIArea = {
  Begin = 1,
  LeftUp = 1,
  LeftDown = 2,
  AutoArea = 3,
  StateArea = 4,
  DebugInfo = 5,
  CheatBtn = 6,
  DamageDisplay = 7,
  HUD = 8,
  Combo = 9,
  End = 9,
  MAX = 99
}
_enum("UIBattleCheatHideUIArea", UIBattleCheatHideUIArea)
local UIBattleCheatHideObjEnum = {
  SceneRoot = 1,
  Piece = 2,
  Entity = 3,
  Monster = 4,
  Trap = 5,
  Pet = 6,
  Light = 7,
  CGEffect = 8,
  HideObjEnum8 = 8,
  HideObjEnum9 = 9,
  HideObjEnum10 = 10,
  HideObjEnum11 = 11,
  HideObjEnum12 = 12,
  HideObjEnum13 = 13,
  HideObjEnum14 = 14,
  HideObjEnum15 = 15,
  HideObjEnum16 = 16,
  HideObjEnum17 = 17,
  HideObjEnum18 = 18,
  HideObjEnum19 = 19,
  HideObjEnum20 = 20,
  MAX = 999
}
_enum("UIBattleCheatHideObjEnum", UIBattleCheatHideObjEnum)
_class("UIBattleCheat", UIController)
UIBattleCheat = UIBattleCheat

function UIBattleCheat:OnShow(uiparam)
  self._infoPanelGo = self:GetGameObject("InfoPanel")
  self._infoContent = self:GetGameObject("Content")
  self._infoLabel = self:GetGameObject("InfoLabel")
  self._infoPanelGo:SetActive(false)
  local input = self:GetUIComponent("InputField", "InputAttack")
  input.text = uiparam[1]
  self._infoLabels = {
    self._infoLabel
  }
  self._logIndex = 1
  local idx = BattleConst.AutoFightMoveEnhanced and 2 or 1
  local inputComplex = self:GetUIComponent("InputField", "InputComplex")
  inputComplex.text = tostring(BattleConst.AutoFightPathComplexity[idx])
  local inputCnt = self:GetUIComponent("InputField", "InputConnectCnt")
  inputCnt.text = tostring(BattleConst.AutoFightPathLengthCutPosNum)
  local inputRate = self:GetUIComponent("InputField", "InputConnectRate")
  inputRate.text = tostring(BattleConst.AutoFightPathLengthCutConnectRate[idx])
  self._cheatHideUIRecord = uiparam[2] or {}
  self._cheatHideObjRecord = uiparam[3] or {}
  self._openDetailsPanelGo = uiparam[4] or false
  self:_RefreshHideUIToggle()
  self._detailsPanelGo = self:GetGameObject("DetailsPanel")
  self._detailsPanelGo:SetActive(self._openDetailsPanelGo)
  self._inputHideEntityByName = self:GetUIComponent("InputField", "InputHideEntityByName")
  self._textPlaceholderInputHideEntity = self:GetUIComponent("UILocalizationText", "PlaceholderInputHideEntity")
  self._inputHideObjName = self:GetUIComponent("InputField", "InputHideObjName")
  local contentHideObj = self:GetGameObject("ContentHideObj")
  self._contentHideObjTransform = contentHideObj.transform
  self._hideObjItem = self:GetGameObject("HideObjItem")
  self._hideObjList = {}
  self:OnRefreshHideEntityByNameList()
end

function UIBattleCheat:OnHide()
end

function UIBattleCheat:BlackBGOnClick(go)
  local input = self:GetUIComponent("InputField", "ModifyTimeScale")
  local scale = tonumber(input.text)
  if scale then
    BattleConst.TimeSpeedList[2] = scale
  end
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleCheat",
    input = "BlackBGOnClick",
    args = {}
  })
  self:CloseDialog()
end

function UIBattleCheat:ReloadConfigOnClick(go)
  CfgClear("cfg_skill_view")
  CfgClear("cfg_battle_skill")
  CfgClear("cfg_pet_battle_skill")
  ConfigServiceHelper.ClearSkillConfigData()
end

function UIBattleCheat:HeroFullHPOnClick(go)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatHeroMaxHP")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:FullPowerOnClick(go)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatTeamPowerFull")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:MonsterInvincibleOnClick(go)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatMonsterInvincible")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AttackMaxOnClick(go)
  local input = self:GetUIComponent("InputField", "InputAttack")
  local attack = tonumber(input.text)
  self:_HeroAttack(attack)
end

function UIBattleCheat:_HeroAttack(attack)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatAttackMax")
  cmd:SetFuncParam(attack)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AddPetButtonOnClick(go)
  local input = self:GetUIComponent("InputField", "InputAddPetInfo")
  local infoStr = input.text
  if not infoStr then
    return
  end
  local params = string.split(infoStr, ",")
  if params and 0 < #params then
    local createInfo = {}
    createInfo.petID = tonumber(params[1])
    createInfo.level = tonumber(params[2])
    createInfo.grade = tonumber(params[3])
    createInfo.awake = tonumber(params[4])
    createInfo.equip = tonumber(params[5])
    createInfo.atk = tonumber(params[6])
    createInfo.def = tonumber(params[7])
    createInfo.hp = tonumber(params[8])
    self:_AddPet(createInfo)
  else
    return
  end
end

function UIBattleCheat:_AddPet(createInfo)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatAddPet")
  cmd:SetFuncParam(createInfo)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:GetRightOnClick(go)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatGetRight")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AutoSummonOnClick(go)
end

function UIBattleCheat:KillMonstersOnClick()
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  if coreGameStateID ~= GameStateID.WaitInput then
    Log.exception("请在玩家可以连线时使用此GM")
    return
  end
  local world = GameGlobal:GetInstance():GetMainWorld()
  local prvwSvc = world:GetService("PreviewMonsterTrap")
  prvwSvc:ClearPreviewMonster()
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleKillMonsters")
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:StartProfilerOnClick()
  GameGlobal.StartProfiler()
end

function UIBattleCheat:StopProfilerOnClick()
  GameGlobal.StopProfiler()
end

function UIBattleCheat:CancelFrameRateOnClick()
  UnityEngine.Application.targetFrameRate = 60
end

function UIBattleCheat:AddBuffHeroOnClick(go)
  local input = self:GetUIComponent("InputField", "InputBuffID")
  local buffID = tonumber(input.text)
  self:_HeroAddBuff(buffID)
end

function UIBattleCheat:_HeroAddBuff(buffID)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatAddBuffHero")
  cmd:SetFuncParam(buffID)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:RemoveBuffHeroOnClick(go)
  local input = self:GetUIComponent("InputField", "InputRemoveBuffID")
  local buffID = tonumber(input.text)
  self:_HeroRemoveBuff(buffID)
end

function UIBattleCheat:_HeroRemoveBuff(buffID)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatRemoveBuffHero")
  cmd:SetFuncParam(buffID)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AddBuffAllMonstersOnClick(go)
  local input = self:GetUIComponent("InputField", "InputBuffID2")
  local buffID = tonumber(input.text)
  self:_MonsterAddBuff(buffID)
end

function UIBattleCheat:_MonsterAddBuff(buffID)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatAddBuffAllMonsters")
  cmd:SetFuncParam(buffID)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:changeAllMonstersHPPercentOnClick(go)
  local input = self:GetUIComponent("InputField", "InputHPPercent")
  local hppercent = tonumber(input.text)
  self:_ChangeMonsterHP(hppercent)
end

function UIBattleCheat:_ChangeMonsterHP(hppercent)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatChangeAllMonstersHPPercent")
  cmd:SetFuncParam(hppercent)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:CloseInfoPanelOnClick(go)
  self._infoPanelGo:SetActive(false)
end

function UIBattleCheat:OutPutOnClick(go)
  local world = GameGlobal:GetInstance():GetMainWorld()
  world:GetMatchLogger():SaveMatchLog(true)
  world:GetDetailMatchLogger():SaveDetailMatchLog(false)
end

function UIBattleCheat:GetCreateInfo()
  local InputFieldID = self:GetUIComponent("InputField", "InputCreateTrapID")
  local InputFieldPosX = self:GetUIComponent("InputField", "InputCreateTrapPosX")
  local InputFieldPosY = self:GetUIComponent("InputField", "InputCreateTrapPosY")
  local InputCreateDirX = self:GetUIComponent("InputField", "InputCreateDirX")
  local InputCreateDirY = self:GetUIComponent("InputField", "InputCreateDirY")
  local id = tonumber(InputFieldID.text)
  local pos = Vector2(tonumber(InputFieldPosX.text), tonumber(InputFieldPosY.text))
  local dir = Vector2(tonumber(InputCreateDirX.text), tonumber(InputCreateDirY.text))
  return id, pos, dir
end

function UIBattleCheat:CreateTrapButtonOnClick()
  local id, pos, dir = self:GetCreateInfo()
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatCreateTrap")
  cmd:SetFuncParam(id, pos, dir)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:CreateMonsterButtonOnClick()
  local id, pos, dir = self:GetCreateInfo()
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatCreateMonster")
  cmd:SetFuncParam(id, pos, dir)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:SkillLogOnClick()
  self._infoPanelGo:SetActive(true)
  self._logIndex = 1
  self:_ShowLog()
end

function UIBattleCheat:PrevLogOnClick()
  if self._logIndex > 1 then
    self._logIndex = self._logIndex - 1
  end
  self:_ShowLog()
end

function UIBattleCheat:NextLogOnClick()
  local world = GameGlobal:GetInstance():GetMainWorld()
  local logger = world:GetMatchLogger()
  local t = logger:GetLogs()
  local cnt = 0
  for i, v in ipairs(t) do
    if v.name == "FSMInfo" then
      cnt = cnt + 1
    end
  end
  if cnt > self._logIndex then
    self._logIndex = self._logIndex + 1
  end
  self:_ShowLog()
end

function UIBattleCheat:_ShowLog()
  for i, label in ipairs(self._infoLabels) do
    label:GetComponent("UILocalizationText"):SetText("")
  end
  local world = GameGlobal:GetInstance():GetMainWorld()
  local logger = world:GetMatchLogger()
  local t = logger:GetLogs()
  local cnt = 0
  local index = 0
  for i, v in ipairs(t) do
    if v.name == "FSMInfo" then
      index = index + 1
    end
    if index == self._logIndex then
      cnt = cnt + 1
      if cnt <= #self._infoLabels then
        local label = self._infoLabels[cnt]
        label:GetComponent("UILocalizationText"):SetText(v.info)
      else
        local label = UnityEngine.GameObject.Instantiate(self._infoLabel, self._infoLabel.transform.parent)
        label:GetComponent("UILocalizationText"):SetText(v.info)
        self._infoLabels[#self._infoLabels + 1] = label
      end
    end
  end
end

function UIBattleCheat:SetBoardPieceOnClick()
  local InputColor = self:GetUIComponent("InputField", "InputColor")
  local pieceType = tonumber(InputColor.text)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatSetBoardPiece")
  cmd:SetFuncParam(pieceType)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AutoTestLogOnClick()
  self:ShowDialog("UIBattleAutoTest")
end

function UIBattleCheat:ShowLogicColorOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetEditorInfoShowType, UnityEngine.KeyCode.Z)
end

function UIBattleCheat:ShowEntityIDOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetEditorInfoShowType, UnityEngine.KeyCode.D)
end

function UIBattleCheat:ShowConfigIDOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetEditorInfoShowType, UnityEngine.KeyCode.S)
end

function UIBattleCheat:changePetHPPercentOnClick(go)
  local input = self:GetUIComponent("InputField", "InputPetHPPercent")
  local hppercent = tonumber(input.text)
  self:_ChangePetHP(hppercent)
end

function UIBattleCheat:_ChangePetHP(hppercent)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatChangePetHPPercent")
  cmd:SetFuncParam(hppercent)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AutoFightComplexOnClick()
  local input = self:GetUIComponent("InputField", "InputComplex")
  local complex = tonumber(input.text)
  self:_ChangeAutoFightComplex(complex)
end

function UIBattleCheat:_ChangeAutoFightComplex(complex)
  local cmd = GMCommand:New()
  cmd:SetFuncName("BattleCheatSetAutoFightComplex")
  cmd:SetFuncParam(complex)
  GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.OnUIGMCheatCommand, cmd)
end

function UIBattleCheat:AutoFightConnectRateOnClick()
  local input = self:GetUIComponent("InputField", "InputConnectRate")
  local rate = tonumber(input.text)
  local idx = BattleConst.AutoFightMoveEnhanced and 2 or 1
  BattleConst.AutoFightPathLengthCutConnectRate[idx] = rate
end

function UIBattleCheat:AutoFightConnectCntOnClick()
  local input = self:GetUIComponent("InputField", "InputConnectCnt")
  local cnt = tonumber(input.text)
  BattleConst.AutoFightPathLengthCutPosNum = cnt
end

function UIBattleCheat:_RefreshHideUIToggle()
  if self._cheatHideUIRecord then
    for i = UIBattleCheatHideUIArea.Begin, UIBattleCheatHideUIArea.End do
      self:_InitHideUIToggle(i)
    end
  end
  if self._cheatHideObjRecord then
    for i = UIBattleCheatHideObjEnum.SceneRoot, UIBattleCheatHideObjEnum.HideObjEnum20 do
      self:_InitHideObjToggle(i)
    end
  end
end

function UIBattleCheat:_InitHideUIToggle(index)
  local name = "HideUIToggle" .. tostring(index)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    if self._cheatHideUIRecord[index] then
      tgl.isOn = true
    else
      tgl.isOn = false
    end
  end
end

function UIBattleCheat:_HideUIToggleOnClick(index)
  local name = "HideUIToggle" .. tostring(index)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.UICheatHideArea, index, bHide)
  end
end

function UIBattleCheat:HideUIToggle1OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.LeftUp)
end

function UIBattleCheat:HideUIToggle2OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.LeftDown)
end

function UIBattleCheat:HideUIToggle3OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.AutoArea)
end

function UIBattleCheat:HideUIToggle4OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.StateArea)
end

function UIBattleCheat:HideUIToggle5OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.DebugInfo)
end

function UIBattleCheat:HideUIToggle6OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.CheatBtn)
end

function UIBattleCheat:HideUIToggle7OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.DamageDisplay)
  local name = "HideUIToggle" .. tostring(7)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local playDamageService = world:GetService("PlayDamage")
    playDamageService:CheatHideDamageDisplay(bHide)
  end
end

function UIBattleCheat:HideUIToggle8OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.HUD)
  local name = "HideUIToggle" .. tostring(8)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local hudCamera = world:MainCamera():HUDCamera()
    hudCamera.enabled = bHide == false
  end
end

function UIBattleCheat:HideUIToggle9OnClick()
  self:_HideUIToggleOnClick(UIBattleCheatHideUIArea.Combo)
end

function UIBattleCheat:_InitHideObjToggle(index)
  local name = "HideObjToggle" .. tostring(index)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    if self._cheatHideObjRecord[index] then
      tgl.isOn = true
    else
      tgl.isOn = false
    end
  end
end

function UIBattleCheat:_HideObjToggleOnClick(index)
  local name = "HideObjToggle" .. tostring(index)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    GameGlobal:GetInstance():EventDispatcher():Dispatch(GameEventType.UICheatHideObj, index, bHide)
  end
end

function UIBattleCheat:HideObjToggle1OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.SceneRoot)
  local name = "HideObjToggle" .. tostring(1)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goScene = renderBoardCmpt:GetSceneGO("SceneRoot")
    if not goScene then
      return
    end
    goScene:SetActive(bHide == false)
  end
end

function UIBattleCheat:HideObjToggle2OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Piece)
  local name = "HideObjToggle" .. tostring(2)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local pieceGroup = world:GetGroup(world.BW_WEMatchers.Piece)
    for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
      local viewCmpt = pieceEntity:View()
      local gameObj = viewCmpt:GetGameObject()
      gameObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle3OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Entity)
  local name = "HideObjToggle" .. tostring(3)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local inputHideEntity = self:GetUIComponent("InputField", "InputHideEntity")
    local entityID = tonumber(inputHideEntity.text)
    local world = GameGlobal:GetInstance():GetMainWorld()
    local entity = world:GetEntityByID(entityID)
    entity:SetViewVisible(bHide == false)
  end
end

function UIBattleCheat:HideObjToggle4OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Monster)
  local name = "HideObjToggle" .. tostring(4)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local monster_group = world:GetGroup(world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monster_group:GetEntities()) do
      local viewCmpt = monsterEntity:View()
      local gameObj = viewCmpt:GetGameObject()
      gameObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle5OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Trap)
  local name = "HideObjToggle" .. tostring(5)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
    for _, trapEntity in ipairs(trapGroup:GetEntities()) do
      local viewCmpt = trapEntity:View()
      local gameObj = viewCmpt:GetGameObject()
      gameObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle6OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Pet)
  local name = "HideObjToggle" .. tostring(6)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local petGroup = world:GetGroup(world.BW_WEMatchers.Pet)
    for _, petEntity in ipairs(petGroup:GetEntities()) do
      local viewCmpt = petEntity:View()
      local gameObj = viewCmpt:GetGameObject()
      gameObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle7OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.Light)
  local name = "HideObjToggle" .. tostring(7)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local hideObjToggleScene2_7ObjList = {
      "cao01 (1)",
      "cao01 (2)",
      "ftzc_grass",
      "grass2",
      "guanmu02",
      "guanmu01"
    }
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goSceneObjList = renderBoardCmpt:GetBattleCheatHideSceneObjList(name)
    if not goSceneObjList or table.count(goSceneObjList) == 0 then
      local objList = {}
      for i, v in ipairs(hideObjToggleScene2_7ObjList) do
        local obj = UnityEngine.GameObject.Find(v)
        if obj then
          table.insert(objList, obj)
        end
      end
      renderBoardCmpt:SetBattleCheatHideSceneObjList(name, objList)
      goSceneObjList = objList
    end
    for i, goObj in ipairs(goSceneObjList) do
      goObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle8OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum8)
  local name = "HideObjToggle" .. tostring(8)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    renderBoardCmpt:SetBattleCheatHideSceneObjList(name, bHide)
  end
end

function UIBattleCheat:HideObjToggle9OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum9)
  local name = "HideObjToggle" .. tostring(9)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local hideObjToggleScene2_7ObjList = {"Rocks"}
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goSceneObjList = renderBoardCmpt:GetBattleCheatHideSceneObjList(name)
    if not goSceneObjList or table.count(goSceneObjList) == 0 then
      local objList = {}
      for i, v in ipairs(hideObjToggleScene2_7ObjList) do
        local obj = UnityEngine.GameObject.Find(v)
        if obj then
          table.insert(objList, obj)
        end
      end
      renderBoardCmpt:SetBattleCheatHideSceneObjList(name, objList)
      goSceneObjList = objList
    end
    for i, goObj in ipairs(goSceneObjList) do
      goObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle10OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum10)
  local name = "HideObjToggle" .. tostring(10)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local hideObjToggleScene2_7ObjList = {"dimian"}
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goSceneObjList = renderBoardCmpt:GetBattleCheatHideSceneObjList(name)
    if not goSceneObjList or table.count(goSceneObjList) == 0 then
      local objList = {}
      for i, v in ipairs(hideObjToggleScene2_7ObjList) do
        local obj = UnityEngine.GameObject.Find(v)
        if obj then
          table.insert(objList, obj)
        end
      end
      renderBoardCmpt:SetBattleCheatHideSceneObjList(name, objList)
      goSceneObjList = objList
    end
    for i, goObj in ipairs(goSceneObjList) do
      goObj:SetActive(bHide == false)
    end
  end
end

function UIBattleCheat:HideObjToggle11OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum11)
  local name = "HideObjToggle" .. tostring(11)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle12OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum12)
  local name = "HideObjToggle" .. tostring(12)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle13OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum13)
  local name = "HideObjToggle" .. tostring(13)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle14OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum14)
  local name = "HideObjToggle" .. tostring(14)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle15OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum15)
  local name = "HideObjToggle" .. tostring(15)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle16OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum16)
  local name = "HideObjToggle" .. tostring(16)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle17OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum17)
  local name = "HideObjToggle" .. tostring(17)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle18OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum18)
  local name = "HideObjToggle" .. tostring(18)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle19OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum19)
  local name = "HideObjToggle" .. tostring(19)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:HideObjToggle20OnClick()
  self:_HideObjToggleOnClick(UIBattleCheatHideObjEnum.HideObjEnum20)
  local name = "HideObjToggle" .. tostring(20)
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
  end
end

function UIBattleCheat:ShowDetailsPanelOnClick()
  self._detailsPanelGo:SetActive(true)
  self:_RefreshHideObjByName()
end

function UIBattleCheat:CloseDetailsPanelOnClick()
  self._detailsPanelGo:SetActive(false)
  if self._openDetailsPanelGo then
    self:CloseDialog()
  end
end

function UIBattleCheat:HideObjToggleByNameOnClick()
  local name = "HideObjToggle" .. tostring("ByName")
  local tgl = self:GetUIComponent("Toggle", name)
  if tgl then
    local bHide = tgl.isOn
    local targetObjName = self._inputHideEntityByName.text
    if self._inputHideEntityByName.text == "" and self._textPlaceholderInputHideEntity ~= "" and self._textPlaceholderInputHideEntity ~= "" then
      targetObjName = self._textPlaceholderInputHideEntity
    end
    local world = GameGlobal:GetInstance():GetMainWorld()
    local boardEntity = world:GetRenderBoardEntity()
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goScene = renderBoardCmpt:GetSceneGO("SceneRoot")
    local renderBoardCmpt = boardEntity:RenderBoard()
    local goSceneObjList = renderBoardCmpt:GetBattleCheatHideSceneObjList(name)
    if not goSceneObjList or table.count(goSceneObjList) == 0 then
      local objList = {}
      local meshRenderers = goScene:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
      for i = 0, meshRenderers.Length - 1 do
        local mesh = meshRenderers[i]
        if mesh.gameObject.name == targetObjName then
          table.insert(objList, mesh.gameObject)
        end
      end
      renderBoardCmpt:SetBattleCheatHideSceneObjList("HideObjByNameKey", targetObjName)
      renderBoardCmpt:SetBattleCheatHideSceneObjList(name, objList)
      goSceneObjList = objList
    end
    for i, goObj in ipairs(goSceneObjList) do
      goObj:SetActive(bHide == false)
    end
    renderBoardCmpt:SetBattleCheatHideSceneObjList("HideObjByNameToggle", bHide)
  end
end

function UIBattleCheat:_RefreshHideObjByName()
  local name = "HideObjToggle" .. tostring("ByName")
  local tgl = self:GetUIComponent("Toggle", name)
  if not tgl then
    return
  end
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local hideObjByNameValue = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideObjByNameKey")
  local hideObjByNameToggle = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideObjByNameToggle")
  if type(hideObjByNameValue) ~= "table" and hideObjByNameToggle == true then
    self._textPlaceholderInputHideEntity:SetText(hideObjByNameValue)
  end
  if type(hideObjByNameToggle) ~= "table" then
    tgl.isOn = hideObjByNameToggle
  end
end

function UIBattleCheat:ShowResourceOnClick()
  local stats = SceneStats:New({})
  stats:OnGetTexturePixelPercentageData()
end

function UIBattleCheat:ShowResourceMonsterOnClick()
  local stats = MonsterStats:New({})
  stats:OnGetTexturePixelPercentageData()
end

function UIBattleCheat:ShowResourcePetOnClick()
end

function UIBattleCheat:ShowResourceTrapOnClick()
end

function UIBattleCheat:OnRefreshHideEntityByNameList()
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local hideEntityByNameListKey = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListKey")
  local hideEntityByNameListValue = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListValue")
  local hideEntityByNameListCount = table.count(hideEntityByNameListKey)
  if hideEntityByNameListCount == 0 then
    return
  end
  self._contentHideObjPath = self:GetUIComponent("UISelectObjectPath", "ContentHideObj")
  self._contentHideObjPath:SpawnObjects("UIBattleCheatHideObjItem", hideEntityByNameListCount)
  self._uiBattleCheatHideObjItemList = self._contentHideObjPath:GetAllSpawnList()
  for i = 1, #self._uiBattleCheatHideObjItemList do
    local item = self._uiBattleCheatHideObjItemList[i]
    local targetObjName = hideEntityByNameListKey[i]
    local targetObjHide = hideEntityByNameListValue[i]
    item:SetData(i, targetObjName, targetObjHide, function(index, text, hide)
      self:HideEntityByNameItemOnClicCallBack(index, text, hide)
    end)
  end
end

function UIBattleCheat:ButtonHideEntityByNameOnClick()
  local targetObjName = self._inputHideObjName.text
  if targetObjName == "" then
    return
  end
  local targetHide = true
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local hideEntityByNameListKey = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListKey")
  local hideEntityByNameListValue = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListValue")
  if table.intable(hideEntityByNameListKey, targetObjName) then
    return
  end
  table.insert(hideEntityByNameListKey, targetObjName)
  table.insert(hideEntityByNameListValue, targetHide)
  self:OnRefreshHideEntityByNameList()
  self:HideEntityByNameItemSetActicve(targetObjName, targetHide)
end

function UIBattleCheat:HideEntityByNameItemOnClicCallBack(index, text, hide)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local hideEntityByNameListKey = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListKey")
  local hideEntityByNameListValue = renderBoardCmpt:GetBattleCheatHideSceneObjList("HideEntityByNameListValue")
  hideEntityByNameListValue[index] = hide
  renderBoardCmpt:SetBattleCheatHideSceneObjList("HideEntityByNameListValue", hideEntityByNameListValue)
  self:HideEntityByNameItemSetActicve(text, hide)
end

function UIBattleCheat:HideEntityByNameItemSetActicve(targetObjName, targetHide)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local hideObjNameKey = "HideEntityByNameObj" .. targetObjName
  local hideEntityByNameObj = renderBoardCmpt:GetBattleCheatHideSceneObjList(hideObjNameKey)
  if not hideEntityByNameObj or table.count(hideEntityByNameObj) == 0 then
    local objList = {}
    local obj = UnityEngine.GameObject.Find(targetObjName)
    if obj then
      table.insert(objList, obj)
    end
    renderBoardCmpt:SetBattleCheatHideSceneObjList(hideObjNameKey, objList)
    hideEntityByNameObj = objList
  end
  for i, goObj in ipairs(hideEntityByNameObj) do
    goObj:SetActive(targetHide == false)
  end
end

function UIBattleCheat:ChangeStencilOnClick()
  local uiBattle = GameGlobal.UIStateManager():GetController("UIBattle")
  uiBattle._widgetAutoFight:GetGameObject("stencil"):SetActive(true)
  uiBattle._widgetAutoFight:GetGameObject("stencilValue"):SetActive(true)
end
