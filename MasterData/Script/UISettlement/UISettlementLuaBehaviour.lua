local CommonItem = require("Common/BtnItem")
local View = require("UISettlement/UISettlementView")
local DataModel = require("UISettlement/UISettlementDataModel")
local ViewFunction = require("UISettlement/UISettlementViewFunction")
local SettlementConfig = require("UISettlement/UISettlementSetting")
local Controller = require("UISettlement/UISettlementController")
local AttrManager = require("UICubeRogueMain/CubeRogueEquipAttrManager")
local BattleResult, RoleList
local Data = {}
local Score, UserLevelMaxData, UnitLevelMaxData
local ReportTrackList = {}
local ConfigFactory, delay_ani_time
local isGridFinish = false
local UserExpConfig
DataModel.now_evaluate = {}
DataModel.now_evaluate_index = 4
local is_administration = false
local comparison_table = {
  [1] = {cn = "\231\148\178", en = "S"},
  [2] = {cn = "\228\185\153", en = "A"},
  [3] = {cn = "\228\184\153", en = "B"},
  [4] = {cn = "\228\184\129", en = "C"},
  [5] = {cn = "\228\184\129", en = "C"}
}

local function PlayRoleSound(role_id, sound_type)
  local roleConfig = PlayerData:GetFactoryData(role_id)
  if roleConfig.fileList[1] == nil then
    return
  end
  local file_id = roleConfig.fileList[1].file
  local roleInfo = PlayerData:GetRoleById(role_id)
  if next(roleInfo) then
    local nowSkinId = tonumber(roleInfo.current_skin[1])
    for i, v in ipairs(roleConfig.fileList) do
      if v.skinId == nowSkinId then
        file_id = v.file
        break
      end
    end
  end
  local file_cfg = PlayerData:GetFactoryData(file_id)
  local battle_list = file_cfg.BattleAudio or {}
  local sound_list = {}
  for i, v in ipairs(battle_list) do
    if sound_type == 1 then
      if v.AudioTypeInt == 4 then
        table.insert(sound_list, v.id2)
      end
    elseif sound_type == -1 and v.AudioTypeInt == 3 then
      table.insert(sound_list, v.id2)
    end
  end
  local sound_count = #sound_list
  if 1 <= sound_count then
    math.randomseed(os.time())
    local sound_id = sound_list[math.random(1, sound_count)]
    local sound = SoundManager:CreateSound(sound_id)
    if sound ~= nil then
      sound:Play()
    end
  end
end

local function DealCubeRogueBattleResult()
  local ItemAttrManager = require("UICubeRogueMain/CubeRogueItemAttrManager")
  ItemAttrManager.OnBattleEnd()
end

local function CountEvaluateScore(stageid)
  local LevelFactory = PlayerData:GetFactoryData(stageid, "LevelFactory")
  local maxScoreList = LevelFactory.maxScoreList
  local difficulty = LevelFactory.difficulty
  local difficulty_num
  if difficulty == "Normal" then
    difficulty_num = ConfigFactory.sdiff01
  end
  if difficulty == "Difficult" then
    difficulty_num = ConfigFactory.sdiff02
  end
  local time = LevelFactory.time or 1
  local sec = (time - BattleResult.duration) * ConfigFactory.stime01
  if sec < 0 then
    sec = 0
  end
  local roleScore = ConfigFactory.slive01 - (table.count(BattleResult.roleInfoList) - BattleResult.survivor) * ConfigFactory.slive02
  local score = math.max((sec + roleScore) * (difficulty_num or 1), 0)
  Score = score
  local evaluate
  for i = 1, table.count(maxScoreList) do
    if score > tonumber(maxScoreList[i].gradeLine) then
      evaluate = comparison_table[i]
      DataModel.now_evaluate_index = i
      break
    end
  end
  if evaluate == nil then
    evaluate = comparison_table[#comparison_table]
    DataModel.now_evaluate_index = #comparison_table
  end
  if is_administration == true then
    DataModel.now_evaluate = evaluate.cn
  else
    DataModel.now_evaluate = evaluate.en
  end
end

local Img_PlayerExp, Group_Damage, Group_Score, Group_MVP, before_lv_ani, now_lv_ani
local now_exp_ani = 0
local before_exp_ani = 0
local show_top_exp_ani, top_exp_ani, top_exp_ani_speed, damage_ani, damage_ani_speed, front_exp, diff_exp, temp_lv_ani, temp_score_ani, temp_score_ani_speed
local before_expel = 0
local now_expel = 0
local expel_ani = 0
local cacheSeriesName = ""
local cacheDeterrence = 0
local before_stability = 0
local now_stability = 0
local max_stability = 0
local stability_ani = 0
local isShowStabilityPop = false
local old_coreLv = 0
local old_coreLvAni = 0
local new_coreLv = 0
local coreLv_ani = 0
local core_breakCnt = 0
local core_breakLv = 0
local core_unitId = 0
local old_coreNum = 0
local new_coreNum = 0
local core_restart = false

local function InitCoreInfo()
  core_restart = false
  if PlayerData.BattleInfo.coreId == nil then
    return
  end
  local serverInfo = PlayerData.ServerData.engines[tostring(PlayerData.BattleInfo.coreId)]
  local curLv = serverInfo.lv
  old_coreNum = serverInfo.num
  old_coreLv = curLv
  old_coreLvAni = old_coreLv
  local coreCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.coreId)
  core_unitId = 0
  local curMaxLv = 0
  for i, levelInfo in ipairs(coreCA.coreLevelList) do
    if levelInfo.id == PlayerData.BattleInfo.battleStageId then
      core_unitId = levelInfo.profileId
      curMaxLv = levelInfo.grade
      break
    end
  end
  core_breakCnt = 0
  for i = 1, old_coreLv do
    local info = coreCA.coreExpList[i]
    if info and info.isBreak then
      core_breakCnt = core_breakCnt + 1
    end
  end
  new_coreNum = tonumber(PlayerData.BattleInfo.BattleResult.cores) or 0
  new_coreLv = curLv
  for i = curLv + 1, curMaxLv do
    local info = coreCA.coreExpList[i]
    if info and new_coreNum >= info.num then
      new_coreLv = new_coreLv + 1
    end
    if info.isBreak then
      core_breakLv = i
      break
    end
  end
  if core_breakLv == 0 then
    local cnt = #coreCA.coreExpList
    for i = curMaxLv + 1, cnt do
      local info = coreCA.coreExpList[i]
      if info.isBreak then
        core_breakLv = i
        break
      end
    end
    if core_breakLv == 0 then
      core_breakLv = cnt
    end
  end
  coreLv_ani = (new_coreLv - old_coreLv) / SettlementConfig.NumSpeed
  serverInfo.lv = new_coreLv
  if new_coreNum > tonumber(serverInfo.num) then
    serverInfo.num = new_coreNum
  end
  core_restart = curMaxLv > new_coreLv
  if new_coreLv > old_coreLv then
    local preRedName = RedpointTree.NodeNames.Core .. "|" .. PlayerData.BattleInfo.coreId
    for lv = old_coreLv, new_coreLv do
      local expInfo = coreCA.coreExpList[lv]
      if expInfo and 0 < expInfo.id then
        local tempListCA = PlayerData:GetFactoryData(expInfo.id)
        if tempListCA and 0 < #tempListCA.EngineRewardList then
          local redName = preRedName .. "|" .. lv
          RedpointTree:InsertNode(redName)
          RedpointTree:ChangeRedpointCnt(redName, 1)
        end
      end
    end
  end
end

local function FindPictures(id)
  for c, d in pairs(PlayerData.ServerData.pictures) do
    if d == id then
      return true
    end
  end
  return false
end

local function FindMusic(id)
  for c, d in pairs(PlayerData.ServerData.music) do
    if d == id then
      return true
    end
  end
  return false
end

local function FindEnemy(id)
  for c, d in pairs(PlayerData.ServerData.enemy) do
    if d == id then
      return true
    end
  end
  return false
end

local function UnLockBook()
  if DataModel.LevelCA then
    local CA = DataModel.LevelCA
    local pictureList = CA.pictureList
    if pictureList ~= nil and table.count(pictureList) > 0 then
      for k, v in pairs(pictureList) do
        if FindPictures(v.id) == false then
          table.insert(PlayerData.ServerData.pictures, v.id)
        end
      end
    end
    local musicList = CA.musicList
    if musicList ~= nil and table.count(musicList) > 0 then
      for k, v in pairs(musicList) do
        if FindMusic(v.id) == false then
          table.insert(PlayerData.ServerData.music, v.id)
        end
      end
    end
    local enemyBookList = CA.enemyBookList
    if table.count(enemyBookList) > 0 then
      for k, v in pairs(enemyBookList) do
        if FindEnemy(v.id) == false then
          table.insert(PlayerData.ServerData.enemy, v.id)
        end
      end
    end
  end
end

local function RefreshAni()
  local exp = now_exp_ani - before_exp_ani
  if exp <= show_top_exp_ani and temp_score_ani >= Score and isGridFinish == true and before_expel >= now_expel and old_coreLvAni >= new_coreLv and before_stability >= now_stability then
    DataModel.AniState = false
    if DataModel.IsSkipLevel == true then
      local parms = {}
      parms.before_lv_ani = before_lv_ani
      parms.temp_lv_ani = temp_lv_ani
      CommonTips.OpenGradeUpSkipLevel(parms)
      DataModel.IsSkipLevel = false
    end
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenRepLvUp()
    CommonTips.OpenPlaygroundLevelUp()
    if now_expel == 1 then
      CommonTips.OpenExpelTips(cacheSeriesName, cacheDeterrence)
    elseif now_stability == max_stability and isShowStabilityPop then
      CommonTips.OpenStabilityTips()
    end
    if PlayerData.BattleInfo.coreId ~= nil and new_coreLv > old_coreLv then
      CommonTips.OpenEngineCoreLvUp(PlayerData.BattleInfo.coreId, old_coreLv, new_coreLv)
    end
    if DataModel.DropAwardList.role and table.count(DataModel.DropAwardList.role) then
      local list = {}
      list.cards = {}
      list.index = 1
      list.goBackState = 1
      local count = 0
      for k, v in pairs(DataModel.DropAwardList.role) do
        count = count + 1
        local row = {}
        list.cards[count] = row
        row.id = tonumber(k)
        row.isNew = true
        if PlayerData:GetRoleById(k) and 0 < table.count(PlayerData:GetRoleById(k)) then
          row.isNew = false
        end
      end
      list.type = 1
      UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(list), nil, nil, false, false)
    end
    return
  end
  local data = UserLevelMaxData
  local levelUpExp
  if data[temp_lv_ani] then
    levelUpExp = data[temp_lv_ani].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local speed_exp_top_ani = exp / SettlementConfig.NumSpeed
  show_top_exp_ani = math.ceil(show_top_exp_ani + speed_exp_top_ani)
  show_top_exp_ani = exp < show_top_exp_ani and exp or show_top_exp_ani
  if 0 < exp then
    Img_PlayerExp.Group_Exp.self:SetActive(true)
    Img_PlayerExp.Group_Exp.Txt_Num:SetText(exp < show_top_exp_ani and exp or show_top_exp_ani)
  else
    Img_PlayerExp.Group_Exp.self:SetActive(false)
    Img_PlayerExp.Group_Exp.Txt_Num:SetText(0)
  end
  if temp_lv_ani > before_lv_ani then
    DataModel.IsSkipLevel = true
    if levelUpExp <= show_top_exp_ani - front_exp then
      front_exp = front_exp + levelUpExp
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    if data[temp_lv_ani] then
      levelUpExp = data[temp_lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(0)
    Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani - front_exp) / levelUpExp)
    local sum = show_top_exp_ani - front_exp
    if sum / levelUpExp == 0 then
      Img_PlayerExp.Img_Exp.Txt_Num:SetText("0%")
    else
      Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
    end
    if temp_lv_ani > before_lv_ani then
      DataModel.IsSkipLevel = true
    end
  else
    if levelUpExp <= show_top_exp_ani + before_exp_ani then
      front_exp = levelUpExp - before_exp_ani
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani + before_exp_ani) / levelUpExp)
    Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp_ani / levelUpExp)
    local sum = show_top_exp_ani + before_exp_ani
    Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
  end
  Img_PlayerExp.Txt_Lv:SetText(temp_lv_ani)
  temp_score_ani_speed = Score / SettlementConfig.NumSpeed
  temp_score_ani = math.ceil(temp_score_ani + temp_score_ani_speed)
  Group_Score.Txt_Score:SetText(PlayerData:GetPreciseDecimalFloor(temp_score_ani > Score and Score or temp_score_ani, 0))
  for k, v in pairs(View.Group_Victory.Group_CharacterExp.StaticGrid_Character.grid) do
    local row = DataModel.RoleList[tonumber(k)]
    local element = v
    if row == nil then
      break
    end
    local before_lv = row.before.lv or 1
    local now_lv = row.now.lv or 1
    local Group_Character01 = element.Group_Character01
    if DataModel.LevelCA.saleLevelType == "CubeRogue" then
      local roleInfo = PlayerData.BattleInfo.HpPercentList[tostring(row.roleid)]
      local hpPercent = 1
      if roleInfo ~= nil then
        hpPercent = roleInfo.hp or 1
      end
      Group_Character01.Img_Mask.Img_FaceMask:SetActive(hpPercent <= 0)
      Group_Character01.Img_HpBg:SetActive(true)
      Group_Character01.Img_HpBg.Img_HpBar:SetFilledImgAmount(hpPercent)
    else
      Group_Character01.Img_HpBg:SetActive(false)
    end
    local data = UnitLevelMaxData
    local levelUpExp
    if data[row.lv_ani] then
      levelUpExp = data[row.lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    local now_exp = row.now.exp or 0
    local before_exp = row.before.exp or 0
    local exp = row.now_role_exp - before_exp
    row.exp_ani_speed = exp / SettlementConfig.NumSpeed
    row.exp_ani = math.ceil(row.exp_ani_speed + row.exp_ani)
    row.exp_ani = exp < row.exp_ani and exp or row.exp_ani
    if 0 < exp then
      Group_Character01.Group_Exp.self:SetActive(true)
      Group_Character01.Group_Exp.Txt_Num:SetText(now_exp < row.exp_ani and now_exp or row.exp_ani)
    else
      Group_Character01.Group_Exp.self:SetActive(false)
      Group_Character01.Group_Exp.Txt_Num:SetText(0)
    end
    local isMax = PlayerData:RoleLvIsMax(row.roleid, before_lv)
    if isMax == true then
      Group_Character01.Txt_LevelMax:SetText("MAX")
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount(1)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
    else
      Group_Character01.Txt_LevelMax:SetText("")
    end
    if before_lv < row.lv_ani then
      if levelUpExp <= row.exp_ani - row.front_exp then
        row.front_exp = row.front_exp + levelUpExp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      if data[row.lv_ani] then
        levelUpExp = data[row.lv_ani].levelUpExp
      else
        levelUpExp = data[table.count(data)].levelUpExp
      end
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani - row.front_exp) / levelUpExp)
    else
      if levelUpExp <= row.exp_ani + before_exp then
        row.front_exp = levelUpExp - before_exp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani + before_exp) / levelUpExp)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
    end
    Group_Character01.Group_Exp.Txt_Num:SetText(exp < row.exp_ani and exp or row.exp_ani)
    Group_Character01.Group_Lv.Txt_Num:SetText(now_lv < row.lv_ani and now_lv or row.lv_ani)
  end
  if 0 < expel_ani then
    local expelSpeed = expel_ani / SettlementConfig.NumSpeed
    before_expel = before_expel + expelSpeed
    before_expel = before_expel > now_expel and now_expel or before_expel
    View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(math.ceil(before_expel * 100) .. "%")
  elseif 0 < stability_ani then
    local expelSpeed = stability_ani / SettlementConfig.NumSpeed
    before_stability = before_stability + expelSpeed
    before_stability = before_stability > now_stability and now_stability or before_stability
    View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(math.ceil(before_stability) .. "/" .. max_stability)
  end
  if 0 < coreLv_ani then
    old_coreLvAni = old_coreLvAni + coreLv_ani
    old_coreLvAni = old_coreLvAni >= new_coreLv and new_coreLv or old_coreLvAni
    View.Group_Victory.Group_Core.Group_Break.Txt_Num:SetText(string.format(GetText(80602007), math.floor(old_coreLvAni + 1.0E-4), core_breakLv))
  end
end

local function RefreshCubeVictoryResultPage()
  if View.Group_CubeVictory == nil then
    return
  end
  DataModel.AniState = false
  local group = View.Group_CubeVictory
  group:SetActive(true)
  group.Group_Tips.Img_Z:SetSprite(GetResPath(88300200))
  local group_MVP = group.Group_MVP
  local unit = PlayerData:GetRoleById(BattleResult.mvpId)
  local unitCA = PlayerData:GetFactoryData(BattleResult.mvpId)
  group_MVP.Group_Name.Txt_Name:SetText(unitCA.name)
  local mvpInfo = BattleResult.roleInfoList[BattleResult.mvpId]
  group_MVP.Group_Damage.Txt_DamageNum:SetText(PlayerData:NumToFormatString(mvpInfo.damage))
  local viewId = unitCA.viewId
  if unit and table.count(unit) > 0 then
    viewId = unit.current_skin[1]
  end
  local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  group_MVP.Spine_Role:SetData(receptionistData.resDir)
  local spineUrl = receptionistData.spineUrl
  local isSpine2 = false
  local victory_center = group.Group_Center
  local isVideo = receptionistData.videoSpine
  isSpine2 = false
  if PlayerData:GetRoleById(BattleResult.mvpId).resonance_lv == 5 and unit.current_skin[2] == 1 then
    isSpine2 = true
  end
  victory_center.Video_Character:SetActive(isVideo)
  victory_center.Spine_Character:SetActive(false)
  victory_center.SpineSecondMode_Character:SetActive(false)
  victory_center.Img_Character:SetActive(false)
  if isVideo then
    local resPath = receptionistData.videoPath
    if receptionistData.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      resPath = receptionistData.videoFemale
    end
    victory_center.Video_Character:SetAnchoredPosition(Vector2(receptionistData.videoX, receptionistData.videoY))
    victory_center.Video_Character:SetLocalScale(Vector3.one * receptionistData.videoScale)
    DataModel.roleVideo = resPath
    victory_center.Video_Character:SetActive(false)
    TimerHelper.StartOnce("delayPlayRoleVideo", 2, function()
      if DataModel.roleVideo then
        victory_center.Video_Character:SetActive(true)
        victory_center.Video_Character:Play(DataModel.roleVideo, true, false, false)
        DataModel.roleVideo = nil
      end
    end)
  elseif receptionistData ~= nil and (spineUrl ~= "" or receptionistData.spine2Url ~= "") then
    victory_center.Spine_Character:SetActive(not isSpine2)
    victory_center.SpineSecondMode_Character:SetActive(isSpine2)
    if not isSpine2 then
      if receptionistData.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        spineUrl = receptionistData.spineFemale
      end
      victory_center.Spine_Character:SetData(spineUrl, "idle")
      victory_center.SpineSecondMode_Character:SetPrefab("")
    else
      spineUrl = receptionistData.spine2Url
      victory_center.SpineSecondMode_Character:SetPrefab(spineUrl)
      victory_center.SpineSecondMode_Character.transform.localPosition = Vector3(receptionistData.spine2X, receptionistData.spine2Y, 0)
      victory_center.Spine_Character:SetData("")
      if receptionistData.state2Overturn == true then
        victory_center.SpineSecondMode_Character:SetLocalScale(Vector3(-1 * receptionistData.spine2Scale, receptionistData.spine2Scale, 1))
      end
    end
  else
    victory_center.Img_Character:SetActive(true)
    local imgPath = receptionistData.resUrl
    local imgOff = Vector3(0, 0, 0)
    local imgSca = Vector3.one
    if isSpine2 then
      imgPath = receptionistData.State2Res
      imgOff.x = receptionistData.offsetX2
      imgOff.y = receptionistData.offsetY2
    else
      imgOff.x = receptionistData.offsetX - 275
      imgOff.y = receptionistData.offsetY
      imgSca = imgSca * receptionistData.offsetScale
      if receptionistData.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        imgPath = receptionistData.pngFemale
      end
    end
    victory_center.Img_Character:SetSprite(imgPath)
    victory_center.Img_Character:SetNativeSize()
    victory_center.Img_Character:SetLocalPosition(imgOff)
    victory_center.Img_Character:SetLocalScale(imgSca)
  end
  DataModel.isSpine2 = isSpine2
  local victory_Right = group.Group_Right
  victory_Right.Group_Time.Txt_MinNum:SetText(TimeUtil:SecondToTable(BattleResult.duration).minute)
  victory_Right.Group_Time.Txt_SecNum:SetText(TimeUtil:SecondToTable(BattleResult.duration).second)
  victory_Right.Group_Live.Txt_LiveNum:SetText(BattleResult.survivor)
  victory_Right.StaticGrid_Character.grid.self:RefreshAllElement()
  View.Group_Victory.ScrollGrid_Rewards.self:SetActive(false)
  local coinNum = 0
  local buffNum = 0
  local weaponNum = 0
  local spItemNum = 0
  local cubeId = PlayerData.TempCache.RogueCache.cubeId
  local cubeCA = PlayerData:GetFactoryData(cubeId)
  local coinId = cubeCA.coinId
  local spItemId = cubeCA.specialItemId
  local tips1, tips2
  for i = #PlayerData.BattleInfo.DropAwardList, 1, -1 do
    local rCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.DropAwardList[i].id)
    if rCA.mod == "\233\173\148\230\150\185\232\142\183\229\143\150\229\140\133" then
      if rCA.packageType == "Buff" then
        buffNum = buffNum + rCA.selectNum
      elseif rCA.packageType == "Equip" then
        weaponNum = weaponNum + rCA.selectNum
      end
    elseif rCA.id == coinId then
      coinNum = coinNum + PlayerData.BattleInfo.DropAwardList[i].num
      tips1 = AttrManager:TriggerByTimingType(Enum_TriggerTiming.GetCoin, {getNum = coinNum})
    elseif rCA.id == spItemId then
      spItemNum = spItemNum + PlayerData.BattleInfo.DropAwardList[i].num + AttrManager:GetAttr(Enum_AttrType.GetSpecialBoss)
      tips2 = AttrManager:TriggerByTimingType(Enum_TriggerTiming.GetSpecial, {getNum = spItemNum})
      PlayerData.TempCache.CubeRogueData.face_item_cnt = PlayerData.TempCache.CubeRogueData.face_item_cnt or 0
      PlayerData.TempCache.CubeRogueData.face_item_cnt = PlayerData.TempCache.CubeRogueData.face_item_cnt + 1
    end
  end
  local CubeRogueController = require("UICubeRogueMain/UICubeRoguewMainController")
  if tips1 then
    if CubeRogueController.rewardList == nil then
      CubeRogueController.rewardList = {}
    end
    for k, v in pairs(tips1) do
      table.insert(CubeRogueController.rewardList, v)
    end
  end
  if tips2 then
    if CubeRogueController.rewardList == nil then
      CubeRogueController.rewardList = {}
    end
    for k, v in pairs(tips2) do
      table.insert(CubeRogueController.rewardList, v)
    end
  end
  CubeRogueController.TryShowReward()
  victory_Right.ScrollView_Reward.Viewport.Content.Group_Weapon:SetActive(0 < weaponNum)
  victory_Right.ScrollView_Reward.Viewport.Content.Group_Buff:SetActive(0 < buffNum)
  victory_Right.ScrollView_Reward.Viewport.Content.Group_Money:SetActive(0 < coinNum)
  victory_Right.ScrollView_Reward.Viewport.Content.Group_Other:SetActive(0 < spItemNum)
  if 0 < weaponNum then
    victory_Right.ScrollView_Reward.Viewport.Content.Group_Weapon.Txt_Num:SetText(weaponNum)
  end
  if 0 < buffNum then
    victory_Right.ScrollView_Reward.Viewport.Content.Group_Buff.Txt_Num:SetText(buffNum)
  end
  if 0 < coinNum then
    victory_Right.ScrollView_Reward.Viewport.Content.Group_Money.Txt_Num:SetText(coinNum)
  end
  if 0 < spItemNum then
    victory_Right.ScrollView_Reward.Viewport.Content.Group_Other.Txt_Num:SetText(spItemNum)
  end
  CommonTips.OpenQuestsCompleteTip()
  CommonTips.OpenRepLvUp()
  CommonTips.OpenPlaygroundLevelUp()
  DataModel:ShowPersonalLeaderboards()
  DealCubeRogueBattleResult()
end

local function RefreshNormalVictoryResultPage()
  local isCore = PlayerData.BattleInfo.coreId ~= nil and DataModel.LevelCA.saleLevelType == "Core"
  local coreCA
  if isCore then
    coreCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.coreId)
  end
  temp_lv_ani = before_lv_ani
  now_lv_ani = Data.user_info.lv
  now_exp_ani = Data.user_info.exp
  before_exp_ani = DataModel.user_info.exp
  local temp_exp = 0
  if now_exp_ani - before_exp_ani <= 0 and now_lv_ani ~= before_lv_ani then
    if 0 < now_lv_ani - temp_lv_ani then
      for i = temp_lv_ani, now_lv_ani - 1 do
        local levelUpExp = UserLevelMaxData[i].levelUpExp
        temp_exp = temp_exp + levelUpExp - before_exp_ani
      end
      now_exp_ani = now_exp_ani + temp_exp
    else
      now_exp_ani = -1 * now_exp_ani
    end
    now_exp_ani = now_exp_ani + before_exp_ani
  end
  damage_ani = 0
  top_exp_ani = 0
  show_top_exp_ani = 0
  temp_score_ani = 0
  View.Group_Victory.Group_btn.Btn_Restart.self:SetActive(false)
  View.Group_Victory.Group_btn.Btn_Restart.Group_Restart:SetActive(false)
  if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.isWitchBattle then
    local parkMapCA = WitchData.GetParkMapCA()
    local levelCfg = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
    local times = WitchData.GetRemainBossBattleTimes()
    if levelCfg.isWitchesBoss and 0 < times then
      View.Group_Victory.Group_btn.Btn_Restart.self:SetActive(true)
      View.Group_Victory.Group_btn.Btn_Restart.Group_Restart:SetActive(true)
      View.Group_Victory.Group_btn.Btn_Restart.Group_Restart.Txt_:SetText(string.format(GetText(80610664), times, parkMapCA.challengeNum))
    end
  end
  View.Group_Victory.self:SetActive(true)
  View.Group_Victory.Group_btn.Btn_Detail.self:SetActive(true)
  local group_victory = View.Group_Victory
  local victory_center = group_victory.Group_Center
  local victory_left = group_victory
  local canArrest = DataModel:CheckCanArrest()
  victory_left.Btn_Arrest:SetActive(canArrest)
  local LevelFactory = DataModel.LevelCA
  local level_chapter = LevelFactory.levelChapter or ""
  local chapter_name = LevelFactory.levelName or ""
  victory_left.Group_Score.Txt_Score:SetText(0)
  victory_left.Group_Score.Group_Time.Txt_MinNum:SetText(TimeUtil:SecondToTable(BattleResult.duration).minute)
  victory_left.Group_Score.Group_Time.Txt_SecNum:SetText(" " .. TimeUtil:SecondToTable(BattleResult.duration).second)
  victory_left.Group_Score.Group_Live.Txt_LiveNum:SetText(BattleResult.survivor)
  victory_left.Group_Level.Txt_LevelNumber:SetText(level_chapter)
  victory_left.Group_Level.Txt_LevelName:SetText(chapter_name)
  victory_left.Group_Tips:SetActive(not isCore)
  victory_left.Group_CoreTips:SetActive(isCore)
  victory_left.Group_MVP:SetActive(not isCore)
  victory_left.Group_CoreMVP:SetActive(isCore)
  victory_left.Group_Core:SetActive(isCore)
  Img_PlayerExp:SetActive(not isCore)
  if isCore then
    victory_left.Group_Record:SetActive(false)
    if 0 < core_unitId then
      local unitCA = PlayerData:GetFactoryData(core_unitId)
      View.Group_Victory.Group_CoreMVP.Txt_Victory:SetText(string.format(GetText(80601850), unitCA.name))
    end
    victory_left.Group_Core.Img_Di:SetSprite(coreCA.settlementIconPath)
    victory_left.Group_Core.Img_Icon:SetSprite(coreCA.coreIconPath)
    victory_left.Group_Core.Txt_EngName:SetText(coreCA.nameEN)
    victory_left.Group_Core.Txt_Name:SetText(GetText(coreCA.name))
    victory_left.Group_Core.Group_Break.Txt_Num:SetText(string.format(GetText(80602007), old_coreLv, core_breakLv))
    for i = 1, 5 do
      local element = victory_left.Group_Core.Group_Break["Img_Break" .. i]
      local isShow = i <= core_breakCnt
      element:SetActive(isShow)
      if isShow then
        element:SetSprite(coreCA.breakPath)
      end
    end
    local avatar = PlayerData:GetUserInfo().avatar
    local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      victory_left.Group_Core.Group_Record.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
    end
    local endExp = PlayerData:GetMaxExp()
    victory_left.Group_Core.Group_Record.Img_EXPPB:SetFilledImgAmount(PlayerData:GetUserInfo().exp / endExp)
    victory_left.Group_Core.Group_Record.Txt_Num:SetText(string.format(GetText(coreCA.settlementNum), new_coreNum))
    victory_left.Group_Core.Group_Record.Txt_Num.Img_New:SetActive(old_coreNum < new_coreNum)
    victory_left.Group_Core.Group_Record.Txt_Time:SetText(os.date("%Y-%m-%d %H:%M", TimeUtil:GetServerTimeStamp()))
    victory_left.Group_Core.Group_Record.Group_LV.Txt_Num:SetText(PlayerData:GetPlayerLevel())
  elseif 0 < DataModel.LevelCA.levelCoreId and DataModel.LevelCA.saleLevelType ~= "Core" then
    victory_left.Group_MVP.Group_NameAndDamage.Txt_DamageNum:SetActive(false)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_Damage:SetActive(false)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_BuffNum:SetActive(true)
    victory_left.Group_Record:SetActive(true)
    local avatar = PlayerData:GetUserInfo().avatar
    local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      victory_left.Group_Record.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
    end
    victory_left.Group_Record.Txt_Time:SetText(os.date("%Y-%m-%d %H:%M", TimeUtil:GetServerTimeStamp()))
    victory_left.Group_Record.Group_LV.Txt_Num:SetText(PlayerData:GetPlayerLevel())
  else
    victory_left.Group_MVP.Group_NameAndDamage.Txt_DamageNum:SetActive(true)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_Damage:SetActive(true)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_BuffNum:SetActive(false)
    victory_left.Group_Record:SetActive(false)
  end
  local unit = PlayerData:GetRoleById(BattleResult.mvpId)
  local unitCA = PlayerData:GetFactoryData(BattleResult.mvpId)
  local viewId = unitCA.viewId
  if unit and 0 < table.count(unit) then
    viewId = unit.current_skin[1]
  end
  local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineUrl = receptionistData.spineUrl
  victory_center.SpineAnimation_Character:SetActive(false)
  victory_center.Img_Character:SetActive(false)
  victory_center.Spine_Character:SetActive(false)
  local isSpine2 = false
  local isVideo = receptionistData.videoSpine
  victory_center.Video_Character:SetActive(isVideo)
  if isVideo then
    victory_center.SpineAnimation_Character:SetActive(false)
    victory_center.SpineSecondMode_Character:SetActive(false)
    victory_center.Img_Character:SetActive(false)
    local resPath = receptionistData.videoPath
    if receptionistData.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      resPath = receptionistData.videoFemale
    end
    DataModel.roleVideo = resPath
    victory_center.Video_Character:SetActive(false)
    TimerHelper.StartOnce("delayPlayRoleVideo", 2, function()
      if DataModel.roleVideo then
        victory_center.Video_Character:SetActive(true)
        victory_center.Video_Character:Play(DataModel.roleVideo, true, false, false)
        DataModel.roleVideo = nil
      end
    end)
  else
    if receptionistData ~= nil and (spineUrl ~= "" or receptionistData.spine2Url ~= "") then
      isSpine2 = false
      if PlayerData:GetRoleById(BattleResult.mvpId).resonance_lv == 5 and receptionistData.spine2Url ~= nil and receptionistData.spine2Url ~= "" and unit.current_skin[2] == 1 then
        isSpine2 = true
        spineUrl = receptionistData.spine2Url
      end
      victory_center.SpineAnimation_Character:SetActive(not isSpine2)
      victory_center.SpineSecondMode_Character:SetActive(isSpine2)
      if isSpine2 then
        victory_center.SpineAnimation_Character:SetLocalScale(Vector3(receptionistData.spine2Scale, receptionistData.spine2Scale, 1))
        victory_center.SpineSecondMode_Character:SetPrefab(spineUrl)
        victory_center.SpineAnimation_Character:SetData("")
        if receptionistData.state2Overturn == true then
          victory_center.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1 * receptionistData.spine2Scale, receptionistData.spine2Scale, 1))
        end
      else
        if receptionistData.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
          spineUrl = receptionistData.spineFemale
        end
        victory_center.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
        victory_center.SpineSecondMode_Character:SetPrefab("")
        victory_center.SpineAnimation_Character:SetActive(true)
        victory_center.SpineAnimation_Character:SetData(spineUrl)
      end
    else
      victory_center.SpineAnimation_Character:SetActive(false)
      victory_center.self:SetActive(true)
      victory_center.Img_Character:SetActive(true)
      isSpine2 = false
      local imgPath = receptionistData.resUrl
      if PlayerData:GetRoleById(BattleResult.mvpId).resonance_lv == 5 and unit.current_skin[2] == 1 then
        isSpine2 = true
        imgPath = receptionistData.State2Res
      end
      if not isSpine2 and receptionistData.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        imgPath = receptionistData.pngFemale
      end
      victory_center.Img_Character:SetSprite(imgPath)
      victory_center.Img_Character:SetNativeSize()
    end
    DataModel.isSpine2 = isSpine2
  end
  local name = unitCA.name
  local mvpInfo = BattleResult.roleInfoList[BattleResult.mvpId]
  if not isCore then
    victory_left.Group_MVP.Group_NameAndDamage.Txt_Name:SetText(name)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_DamageNum:SetText(mvpInfo.damage)
    if 0 < DataModel.LevelCA.levelCoreId and DataModel.LevelCA.saleLevelType ~= "Core" then
      local coreBuffCount = mvpInfo.coreBuffCount or {}
      local buffCnt = 0
      for i, cnt in pairs(coreBuffCount) do
        buffCnt = buffCnt + cnt
      end
      local curCore = PlayerData:GetFactoryData(DataModel.LevelCA.levelCoreId)
      victory_left.Group_MVP.Group_NameAndDamage.Txt_BuffNum:SetText(string.format(GetText(curCore.mvpNum), buffCnt))
      victory_left.Group_Record.Txt_Num:SetText(string.format(GetText(curCore.settlementNum), tonumber(PlayerData.BattleInfo.BattleResult.cores) or 0))
    end
  else
    victory_left.Group_CoreMVP.Group_NameAndDamage.Txt_Name:SetText(name)
    local coreBuffCount = mvpInfo.coreBuffCount or {}
    local buffCnt = 0
    for i, cnt in pairs(coreBuffCount) do
      buffCnt = buffCnt + cnt
    end
    victory_left.Group_CoreMVP.Group_NameAndDamage.Txt_DamageNum:SetText(string.format(GetText(coreCA.mvpNum), buffCnt))
  end
  victory_left.Group_Score.Img_Bottom:SetSprite(UIConfig.SettleMentGradBottom[DataModel.now_evaluate])
  victory_left.Group_Score.Img_Grade:SetSprite(UIConfig.SettleMentGrad[DataModel.now_evaluate])
  victory_left.Group_Score.Img_Mask:SetSprite(UIConfig.SettleMentGradMask[DataModel.now_evaluate])
  local before_lv = DataModel.user_info.lv
  local now_lv = Data.user_info.lv
  Img_PlayerExp.Txt_Lv:SetText(before_lv)
  local data = UserLevelMaxData
  local levelUpExp
  if data[now_lv] then
    levelUpExp = data[now_lv].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local now_exp = Data.user_info.exp
  local before_exp = DataModel.user_info.exp
  Img_PlayerExp.Group_Exp.Txt_Num:SetText(0)
  Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount(before_exp / levelUpExp)
  Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
  Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(before_exp / levelUpExp * 100, 1) .. "%")
  View.Group_Victory.Group_CharacterExp.self:SetActive(true)
  View.Group_Victory.Group_CharacterExp.StaticGrid_Character.self:RefreshAllElement()
  ViewFunction.Settlement_Group_Victory_Group_Right_Group_Statistics_Btn_Character_Click()
  View.Group_Victory.ScrollGrid_Rewards.self:SetActive(false)
  for i = #PlayerData.BattleInfo.DropAwardList, 1, -1 do
    local rCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.DropAwardList[i].id)
    if rCA.mod == "\233\173\148\230\150\185\232\142\183\229\143\150\229\140\133" then
      table.remove(PlayerData.BattleInfo.DropAwardList, i)
    end
  end
  if not isCore and PlayerData.BattleInfo.DropAwardList and 0 < table.count(PlayerData.BattleInfo.DropAwardList) then
    View.Group_Victory.ScrollGrid_Rewards.self:SetActive(true)
    View.Group_Victory.ScrollGrid_Rewards.grid.self:SetDataCount(table.count(PlayerData.BattleInfo.DropAwardList))
    View.Group_Victory.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  end
  isShowStabilityPop = false
  local isShowExpel = false
  local levelCA = DataModel.LevelCA
  if 0 < levelCA.expelNum and 0 < levelCA.CorrespondingList then
    local listCA = PlayerData:GetFactoryData(levelCA.CorrespondingList, "ListFactory")
    local maxExpel = listCA.expelNum
    local serverInfo = PlayerData.ServerData.security_levels[tostring(listCA.buildingId)]
    if serverInfo and serverInfo[tostring(levelCA.CorrespondingList)] then
      serverInfo = serverInfo[tostring(levelCA.CorrespondingList)]
      if maxExpel > serverInfo.expel_num then
        isShowExpel = true
        cacheSeriesName = listCA.seriesName
        before_expel = serverInfo.expel_num / maxExpel
        local toExpel = (serverInfo.expel_num + levelCA.expelNum) / maxExpel
        toExpel = 1 < toExpel and 1 or toExpel
        now_expel = toExpel
        expel_ani = now_expel - before_expel
        View.Group_Victory.Img_Expel.self:SetActive(true)
        View.Group_Victory.Img_Expel.Group_1.Txt_Dec:SetText(string.format(GetText(80601113), cacheSeriesName))
        View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(math.ceil(before_expel * 100) .. "%")
        serverInfo.expel_num = serverInfo.expel_num + levelCA.expelNum
        cacheDeterrence = 1 <= toExpel and listCA.deterrence or 0
        PlayerData:GetUserInfo().deterrence = PlayerData:GetUserInfo().deterrence + cacheDeterrence
      end
    end
  elseif levelCA.addStability and 0 < levelCA.addStability then
    local playgroundCA = PlayerData:GetFactoryData(levelCA.playgroundId)
    local maxStability = playgroundCA.maxStability
    local serverInfo = PlayerData:GetHomeInfo().playground[tostring(levelCA.playgroundId)]
    local stability = serverInfo and (serverInfo.stability or 0) or 0
    max_stability = maxStability
    if serverInfo and maxStability > stability then
      isShowExpel = true
      before_stability = stability
      local toStability = stability + levelCA.addStability
      toStability = maxStability < toStability and maxStability or toStability
      now_stability = toStability
      stability_ani = now_stability - before_stability
      if stability_ani <= 0 then
        stability_ani = 0
        isShowStabilityPop = false
      else
        isShowStabilityPop = true
      end
      View.Group_Victory.Img_Expel.self:SetActive(true)
      View.Group_Victory.Img_Expel.Group_1.Txt_Dec:SetText(GetText(playgroundCA.stlmtTips))
      View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(before_stability .. "/" .. max_stability)
      serverInfo.stability = stability + levelCA.addStability
    end
  end
  if not isShowExpel then
    View.Group_Victory.Img_Expel.self:SetActive(false)
    before_expel = 0
    now_expel = 0
    expel_ani = 0
    cacheSeriesName = ""
    before_stability = 0
    now_stability = 0
    stability_ani = 0
  end
  View.self:StartC(LuaUtil.cs_generator(function()
    DataModel.AutoNextGoState = false
    DataModel.AniState = true
  end))
  local animName = "Win"
  if isCore then
    animName = "Core"
  end
  View.self:SelectPlayAnim(View.Group_Victory.self, animName, function()
    if PlayerData.curLevelHelpRole then
      for i = 1, #DataModel.RoleList do
        if tostring(DataModel.RoleList[i].roleid) == tostring(PlayerData.curLevelHelpRole.id) then
          View.Group_Victory.Group_AddFriend:SetActive(true)
          local element = View.Group_Victory.Group_CharacterExp.StaticGrid_Character.grid[i]
          View.Group_Victory.Group_AddFriend:SetPositionX(element.self.transform.position.x)
          break
        end
      end
    end
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenRepLvUp()
    CommonTips.OpenPlaygroundLevelUp()
    DataModel:ShowPersonalLeaderboards()
    Controller.SetOpenSettlementCamera()
    DealCubeRogueBattleResult()
  end)
  local Parent_1 = View.Group_Victory.Group_Score.Img_Bottom.Group_Effect.self
  Parent_1:SetDynamicGameObject(UIConfig.SettleMentEffect[DataModel.now_evaluate_index][1], 0, 0)
  DataModel.LoadSpineBg(viewId)
  if LevelFactory.saleLevelType == "RandomBattle" then
    View.Group_Victory.self:SetActive(false)
    if View.Group_Win.self ~= nil then
      View.Group_Win.self:SetActive(true)
    end
  end
  local correspondingActivityCA = PlayerData:GetFactoryData(levelCA.correspondingActivity)
  if View.Group_Victory.Img_GoldLevel ~= nil then
    if levelCA.saleLevelType == "Infinite" and correspondingActivityCA and correspondingActivityCA.isGoldLevel then
      View.Group_Victory.Img_GoldLevel:SetActive(true)
      local levelData = PlayerData.ServerData.chapter_level[tostring(levelCA.id)]
      local goldRecord = levelData.max_gold or 0
      local goldNow = levelData.gold or 0
      local isBreak = goldRecord <= goldNow
      View.Group_Victory.Img_GoldLevel.Group_GoldNormal:SetActive(not isBreak)
      View.Group_Victory.Img_GoldLevel.Group_GoldBreaking:SetActive(isBreak)
      if isBreak then
        View.Group_Victory.Img_GoldLevel.Group_GoldBreaking.Txt_Num:SetText(goldNow)
      else
        View.Group_Victory.Img_GoldLevel.Group_GoldNormal.Txt_Num:SetText(goldNow)
      end
      View.Group_Victory.Img_GoldLevel.Group_GoldRecord.Txt_Num:SetText(goldRecord)
      local activityData = PlayerData:GetActivityData(levelCA.correspondingActivity)
      if activityData ~= nil then
        activityData.level_gold = (activityData.level_gold or 0) + goldNow
      end
    else
      View.Group_Victory.Img_GoldLevel:SetActive(false)
    end
  end
end

local function RefreshBattleVictoryResultPage()
  if DataModel.LevelCA.saleLevelType == "CubeRogue" then
    AttrManager:TriggerByTimingType(Enum_TriggerTiming.BattleVictory)
    RefreshCubeVictoryResultPage()
  else
    RefreshNormalVictoryResultPage()
  end
end

local function RefreshBattleDefeatResultPage()
  Net:SendProto("battle.end_battle", function(jsons)
    Train.EventBattleFinish(jsons)
    DataModel.JsonList = jsons
    DataModel.AniState = false
    DataModel.AutoNextGoState = false
    local LevelFactory = DataModel.LevelCA
    if LevelFactory.saleLevelType == "RandomBattle" then
      if View.Group_Lose.self ~= nil then
        View.Group_Lose.self:SetActive(true)
        local failTime = PlayerData.BattleInfo.rbFailTime + 1
        local configCA = PlayerData:GetFactoryData(99900113)
        local maxLoseTime = configCA.randomBattleLose
        View.Group_Lose.Group_Hp.StaticGrid_Hp.grid.self:SetDataCount(maxLoseTime)
        View.Group_Lose.Group_Hp.StaticGrid_Hp.grid.self:RefreshAllElement()
        for i = 1, maxLoseTime do
          local hpGroup = View.Group_Lose.Group_Hp.StaticGrid_Hp.grid[i]
          if i > maxLoseTime - failTime then
            hpGroup.Img_On:SetActive(false)
            hpGroup.Img_Off:SetActive(true)
          else
            hpGroup.Img_On:SetActive(true)
            hpGroup.Img_Off:SetActive(false)
          end
        end
      end
    elseif LevelFactory.saleLevelType == "CubeRogue" then
      if View.Group_CubeDefeat ~= nil then
        View.Group_CubeDefeat.self:SetActive(true)
        View.Group_CubeDefeat.Img_Bg.Txt_DeficiencyDes:SetActive(DataModel.ShowDeficiencyDes)
        View.Group_CubeDefeat.Img_Z:SetSprite(GetResPath(88300199))
      end
    else
      local level_chapter = LevelFactory.levelChapter or ""
      local chapter_name = LevelFactory.levelName or ""
      View.Group_Defeat.Group_Level.Txt_LevelNumber:SetText(level_chapter)
      View.Group_Defeat.Group_Level.Txt_LevelName:SetText(chapter_name)
      View.Group_Defeat.self:SetActive(true)
      View.Group_Defeat.Btn_Detail.self:SetActive(true)
      local isShowRestartBtn = true
      if PlayerData.Last_Chapter_Parms ~= nil and PlayerData.Last_Chapter_Parms.stationId ~= nil then
        isShowRestartBtn = false
      end
      if PlayerData.TempCache.EventFinish then
        isShowRestartBtn = false
      end
      if PlayerData.BattleInfo.coreId ~= nil then
        isShowRestartBtn = true
      end
      if PlayerData.Last_Chapter_Parms ~= nil and PlayerData.Last_Chapter_Parms.turntableId ~= nil then
        isShowRestartBtn = false
      end
      if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Abyss/Battle_Abyss" then
        isShowRestartBtn = false
      end
      if PlayerData.Last_Chapter_Parms ~= nil and PlayerData.Last_Chapter_Parms.scene == "Monopoly" then
        isShowRestartBtn = false
      end
      if LevelFactory.saleLevelType == "Endless" then
        isShowRestartBtn = false
      end
      if LevelFactory.saleLevelType == "CubeRogue" then
        isShowRestartBtn = false
      end
      if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.isWitchBattle then
        local levelCfg = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
        isShowRestartBtn = levelCfg.isWitchesBoss and WitchData.GetRemainBossBattleTimes() > 0
      end
      View.Group_Defeat.Btn_Restart.self:SetActive(isShowRestartBtn)
      View.self:SelectPlayAnim(View.Group_Defeat.self, "DefeatIn", function()
        CommonTips.OpenQuestsCompleteTip()
        CommonTips.OpenRepLvUp()
        CommonTips.OpenPlaygroundLevelUp()
      end)
    end
    DataModel.now_evaluate_index = 0
    local heard_id = PlayerData.ServerData.squad[PlayerData.BattleInfo.squadIndex].header
    local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
    if tonumber(autoBattle.teamKey) == nil then
      heard_id = tostring(autoBattle.header)
    end
    PlayRoleSound(heard_id, -1)
  end, PlayerData.BattleInfo.levelUid, 0, Json.encode(DataModel.DeadHero), function(json)
    if json.rc == "80601508" then
      View.Group_Timeout.self:SetActive(true)
      return
    end
  end, 0, PlayerData.BattleInfo.BattleResult.isExitBattle == true and -1 or 0, PlayerData.BattleInfo.BattleResult.cores)
end

local function InitPage()
  DataModel.AutoSettlement = false
  DataModel.LevelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId)
  if DataModel.LevelCA.saleLevelType == "pollute" or DataModel.LevelCA.saleLevelType == "Line" then
    DataModel.AutoSettlement = PlayerData:GetHomeInfo().drive_setup.bar == 1
  end
  if PlayerData.BattleInfo.eventId ~= nil then
    local EventCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.eventId)
    if EventCA.mod == "\230\177\161\230\159\147\231\130\185\229\135\187\228\186\139\228\187\182" then
      local DungeonDataModel = require("UIBattle_Dungeon/UIBattle_DungeonDataModel")
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      DataModel.AutoSettlement = DungeonDataModel.IsAutoDungeon == 1 or DungeonScanDataModel.IsAutoDungeon == 1
    end
    if EventCA.mod == "\231\130\185\229\135\187\229\137\175\230\156\172\228\186\139\228\187\182" then
      local DungeonDataModel = require("UIBattle_Dungeon/UIBattle_DungeonDataModel")
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      DataModel.AutoSettlement = DungeonDataModel.IsAutoDungeon == 1 or DungeonScanDataModel.IsAutoDungeon == 1
    end
    if EventCA.mod == "\231\130\185\229\135\187\229\133\179\229\141\161" then
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      DataModel.AutoSettlement = DungeonScanDataModel.IsAutoDungeon == 1
    end
    if EventCA.mod == "\233\154\144\232\151\143\230\137\171\230\143\143\228\186\139\228\187\182" then
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      DataModel.AutoSettlement = DungeonScanDataModel.IsAutoDungeon == 1
    end
  end
  DataModel.AutoSettlement = DataModel.AutoSettlement or PlayerData.TempCache.MonsterLevelAutoBattle
  View.Group_SettlementPrompt.self:SetActive(false)
  View.Btn_Detail:SetActive(CBus:GetManager(CS.ManagerName.ReplayManager).isBattleTest)
  DataModel.user_info = PlayerData.ServerData.user_info
  before_lv_ani = DataModel.user_info.lv
  DataModel.before_roles = {}
  DataModel.DelayTime = 0
  DataModel.AutoNextTime = 300 + DataModel.DelayTime * 60
  delay_ani_time = 200
  isGridFinish = false
  DataModel.SettingTime = math.max(SettlementConfig.NumSpeed, SettlementConfig.FillSpeed)
  Img_PlayerExp = View.Group_Victory.Img_PlayerExp
  Group_Score = View.Group_Victory.Group_Score
  UnitLevelMaxData = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
  UserLevelMaxData = PlayerData:GetFactoryData(99900004, "ConfigFactory").expList
  for k, v in pairs(PlayerData.ServerData.roles) do
    DataModel.before_roles[k] = v
  end
  BattleResult = PlayerData.BattleInfo.BattleResult
  RoleList = BattleResult.roleInfoList
  View.Group_Defeat.self:SetActive(false)
  View.Group_Victory.self:SetActive(false)
  View.Group_Timeout.self:SetActive(false)
  if View.Group_Win.self ~= nil then
    View.Group_Win.self:SetActive(false)
  end
  if View.Group_Lose.self ~= nil then
    View.Group_Lose.self:SetActive(false)
  end
  if View.Group_CubeVictory ~= nil then
    View.Group_CubeVictory:SetActive(false)
  end
  if View.Group_CubeDefeat ~= nil then
    View.Group_CubeDefeat:SetActive(false)
  end
  View.Group_Victory.Group_btn.Btn_Next.Txt_Time:SetActive(DataModel.AutoSettlement)
  View.Group_Victory.Group_btn.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), DataModel.AutoNextTime / 60))
  View.Group_Defeat.Btn_Next.Txt_Time:SetActive(DataModel.AutoSettlement)
  View.Group_Defeat.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), DataModel.AutoNextTime / 60))
  DataModel.now_evaluate = {}
  DataModel.JsonList = {}
  local hero_list = {}
  local string_ded = ""
  local connect = "&"
  if 0 < table.count(BattleResult.deadRoleList) then
    for k, v in pairs(BattleResult.deadRoleList) do
      string_ded = string_ded .. v .. connect
    end
  end
  string_ded = string.sub(string_ded, 1, string.len(string_ded) - 1)
  local enemyIds = ""
  local enemyIdList = string.split(BattleResult.enemy_ids, ",")
  local averageNum = 1
  local remainNum = 0
  if DataModel.LevelCA.saleLevelType == "Infinite" then
    local LevelManager = CBus:GetManager(CS.ManagerName.LevelManager)
    local finalWaveNum = LevelManager.currentEnemyWave - 1
    averageNum = math.floor(finalWaveNum / #enemyIdList)
    remainNum = finalWaveNum % #enemyIdList
  end
  local goldNum = 0
  for i = 1, #enemyIdList do
    local waveNum = averageNum
    if i <= remainNum then
      waveNum = waveNum + 1
    end
    enemyIds = enemyIds .. enemyIdList[i] .. ":" .. waveNum
    if i ~= #enemyIdList then
      enemyIds = enemyIds .. ","
    end
    local waveCA = PlayerData:GetFactoryData(enemyIdList[i])
    local curDifficulty = PlayerData.BattleInfo.difficulty or 1
    if waveCA ~= nil and curDifficulty <= #waveCA.dropTableList then
      local dropId = waveCA.dropTableList[curDifficulty].listId
      local dropCA = PlayerData:GetFactoryData(dropId)
      if dropCA ~= nil and 1 <= #dropCA.leveldropList then
        goldNum = goldNum + dropCA.leveldropList[1].numMax
      end
    end
  end
  hero_list.enemyIds = enemyIds
  hero_list.enemy_Ids = BattleResult.enemy_ids
  hero_list.enemy_level_min = BattleResult.enemy_level_min
  hero_list.enemy_level = BattleResult.enemy_level
  hero_list.weather_id = BattleResult.weather_id
  hero_list.second_weather_id = BattleResult.second_weather_id
  hero_list.bgId = BattleResult.bgId
  hero_list.level_progress = BattleResult.level_progress or 0
  hero_list.duration_time = BattleResult.duration
  local recordDetail = require("UITestLevel/UITestLevelDataModel").RecordDetail
  if DataModel.LevelCA.isUploadRankCount then
    if string.contains(DataModel.LevelCA.rankType, "Buff") then
      hero_list.rank_score = tonumber(BattleResult.cores)
    elseif string.contains(DataModel.LevelCA.rankType, "Damage") then
      hero_list.rank_score = recordDetail.damageTotal
    elseif string.contains(DataModel.LevelCA.rankType, "Gold") then
      hero_list.rank_score = goldNum
    elseif string.contains(DataModel.LevelCA.rankType, "MaxHit") then
      hero_list.rank_score = recordDetail.onceDamageMax
    else
      hero_list.rank_score = tonumber(BattleResult.cores)
    end
  end
  if DataModel.LevelCA.saleLevelType == "CubeRogue" then
    hero_list.role_info_list = PlayerData.BattleInfo.HpPercentList
    hero_list.level_progress = 0.1
  end
  if DataModel.LevelCA.saleLevelType == "Endless" and BattleResult.duration <= 5 then
    local endlessDataModel = require("UIEndlessBattle/UIEndlessBattleDataModel")
    if endlessDataModel.user_endless ~= nil and (endlessDataModel.user_endless.difficulty_progress or 0) > BattleResult.level_progress then
      hero_list.level_progress = endlessDataModel.user_endless.difficulty_progress or 0
    end
  end
  local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId)
  local isCheck = false
  if BattleResult.isWin and levelCA.isDisplayLeaderBoard == true then
    if levelCA.leaderBoardSortType == "damage" then
      hero_list.checkAttrDic = PlayerData.BattleInfo.checkAttrDic
    end
    isCheck = true
    if PlayerData.ServerData.level_record == nil then
      PlayerData.ServerData.level_record = {}
    end
    if PlayerData.ServerData.level_record[tostring(PlayerData.BattleInfo.battleStageId)] == nil then
      PlayerData.ServerData.level_record[tostring(PlayerData.BattleInfo.battleStageId)] = {}
    end
    local level_record = PlayerData.ServerData.level_record[tostring(PlayerData.BattleInfo.battleStageId)].records
    if level_record == nil then
      level_record = {}
      PlayerData.ServerData.level_record[tostring(PlayerData.BattleInfo.battleStageId)].records = level_record
    end
    if 0 < #level_record then
      if levelCA.leaderBoardSortType == "time" then
        table.sort(level_record, function(e1, e2)
          return e1.duration < e2.duration
        end)
      elseif levelCA.leaderBoardSortType == "damage" then
        table.sort(level_record, function(e1, e2)
          return (e1.damageTotal or 0) > (e2.damageTotal or 0)
        end)
      end
    end
    local maxRecordNum = levelCA.maxRecordNum
    local isNewRecord = false
    if maxRecordNum <= 0 or maxRecordNum > #level_record then
      isNewRecord = true
    elseif levelCA.leaderBoardSortType == "time" then
      isNewRecord = BattleResult.duration < level_record[#level_record].duration
    elseif levelCA.leaderBoardSortType == "damage" then
      isNewRecord = recordDetail.damageTotal > level_record[#level_record].damageTotal
    end
    if isNewRecord then
      local bResult = {}
      bResult.duration = BattleResult.duration
      bResult.skillDamageNow = recordDetail.skillDamageNow
      bResult.skillDamageMax = recordDetail.skillDamageMax
      bResult.damageTotalAt10s = recordDetail.damageTotalAt10s
      bResult.usedCards = recordDetail.usedCards
      bResult.usedCost = recordDetail.usedCost
      bResult.damageTotal = recordDetail.damageTotal
      bResult.getHitTotal = BattleResult.getHitTotal
      bResult.healTotal = BattleResult.healTotal
      local testController = require("UITestLevelDetail/UITestLevelDetailController")
      bResult.roles = {}
      for key, value in pairs(BattleResult.roleInfoList) do
        local temp = testController.GetRoleTemp(key, value, nil, nil, true)
        temp.name = nil
        temp.id = key
        temp.cardList = nil
        bResult.roles[#bResult.roles + 1] = temp
      end
      hero_list.battle_result = bResult
      level_record[#level_record + 1] = bResult
      if levelCA.leaderBoardSortType == "time" then
        table.sort(level_record, function(e1, e2)
          return e1.duration < e2.duration
        end)
      elseif levelCA.leaderBoardSortType == "damage" then
        table.sort(level_record, function(e1, e2)
          return (e1.damageTotal or 0) > (e2.damageTotal or 0)
        end)
      end
      if 0 < maxRecordNum and maxRecordNum < #level_record then
        for i = maxRecordNum + 1, #level_record do
          level_record[i] = nil
        end
      end
      local battleBossDataModel = require("UIBattleBoss/UIBattleBossDataModel")
      if level_record[1].create_ts == nil and battleBossDataModel.BatterInfo ~= nil and battleBossDataModel.TurntableCA ~= nil then
        local BatterInfo = battleBossDataModel.BatterInfo
        local neiestIndex = table.count(BatterInfo)
        if 0 < neiestIndex then
          local levelBossCA = PlayerData:GetFactoryData(battleBossDataModel.TurntableCA.levelBossList[neiestIndex].id)
          local levelBossList = levelBossCA.levelList
          local levelIndex = BatterInfo[tostring(neiestIndex - 1)].cnt + 1
          levelIndex = math.min(#levelBossList, levelIndex)
          local levelId = levelBossList[levelIndex].id
          if tostring(levelId) == tostring(PlayerData.BattleInfo.battleStageId) then
            hero_list.roleSkinList = {}
            for i = 1, #bResult.roles do
              hero_list.roleSkinList[#hero_list.roleSkinList + 1] = bResult.roles[i].face
            end
          end
        end
      end
    end
  end
  View.Group_Victory.Group_btn.Btn_Check.self:SetActive(isCheck)
  View.Group_Victory.Group_btn.Btn_Check.Txt_Check:SetText(GetText(80607506))
  View.Group_Victory.Group_btn.Btn_Check.Img_Check:SetSprite("UI/Chapter/Battle_Boss/BattleBoss_icon_best2")
  if DataModel.LevelCA.saleLevelType == "buoy" then
    View.Group_Victory.Group_MVP.Txt_Victory:SetText(GetText(80602351))
    View.Group_Victory.Group_Tips.Txt_victory_CN:SetText(GetText(80602351))
    View.Group_Victory.Group_Tips.Txt_victory_EN:SetText(GetText(80602401))
  else
    View.Group_Victory.Group_MVP.Txt_Victory:SetText(GetText(80602400))
    View.Group_Victory.Group_Tips.Txt_victory_CN:SetText(GetText(80602400))
    View.Group_Victory.Group_Tips.Txt_victory_EN:SetText(GetText(80602402))
  end
  DataModel.DeadHero = hero_list
end

local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if PlayerData.curSelectedHelpRole and PlayerData.curSelectedHelpRole.isFriend ~= 1 then
      PlayerData.curLevelHelpRole = PlayerData.curSelectedHelpRole
    else
      PlayerData.curLevelHelpRole = nil
    end
    View.Group_Victory.Group_AddFriend:SetActive(false)
    PlayerData.helpSquadIndex = nil
    PlayerData.helpRoleList = nil
    PlayerData.curSelectedHelpRole = nil
    PlayerData.curHelpRoles = nil
    PlayerData.curHelpBattlePage = nil
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
    local levelCfg = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId)
    local activityId = levelCfg.correspondingActivity
    if 0 < activityId then
      local plotId = levelCfg.endParagraphId
      local plotOver = PlayerData.plot_paragraph[tostring(plotId)] ~= nil
      local hasPlot = 0 < plotId
      if hasPlot and not plotOver and PlayerData.BattleInfo.BattleResult.isWin then
        View.self:SetActive(false)
        UIManager:Open(UIPath.UIDialog, Json.encode({id = plotId, activityId = activityId}))
        return
      end
      if not hasPlot and PlayerData.BattleInfo.BattleResult.isWin then
        local isJion = PlayerData.ServerData.all_activities.ing[tostring(activityId)]
        local isJoinCA = levelCfg.isJoin
        if not isJion and isJoinCA then
          Net:SendProto("main.participate", function(jsons)
            if jsons.activity then
              PlayerData.ServerData.all_activities.ing[tostring(activityId)] = jsons.activity
            end
          end, activityId)
        end
      end
    end
    DataModel.IsBuyEnergy = false
    DataModel.IsReStart = false
    DataModel.AutoNextGoState = true
    DataModel.IsSkipLevel = false
    DataModel.canArrestNum = nil
    DataModel.arrestFlag = false
    ConfigFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    View.Group_Defeat.Img_Bg.Btn_Wiki.self:SetActive(ConfigFactory.isShowWiki)
    View.self:SetActive(false)
    View.self:SetActive(true)
    PlayerData.FreeCameraIndex = 1
    InitPage()
    DataModel.ShowDeficiencyDes = false
    if BattleResult.isWin and DataModel.LevelCA.saleLevelType == "CubeRogue" then
      local eventCA = PlayerData:GetFactoryData(PlayerData.TempCache.CurCubeEid)
      if not eventCA.isBoss then
        local aliveNum = 0
        for k, v in pairs(PlayerData.TempCache.CubeRogueData.roles) do
          if v.hp ~= nil and 0 < v.hp and k ~= "" then
            if PlayerData.BattleInfo.HpPercentList[k] then
              if PlayerData.BattleInfo.HpPercentList[k].hp and 0 < PlayerData.BattleInfo.HpPercentList[k].hp then
                aliveNum = aliveNum + 1
              end
            else
              aliveNum = aliveNum + 1
            end
          end
        end
        if aliveNum < 5 then
          DataModel.ShowDeficiencyDes = true
          BattleResult.isWin = false
        else
          PlayerData.TempCache.CurCubeEid = nil
        end
      else
        PlayerData.TempCache.CurCubeEid = nil
      end
    end
    if BattleResult.isWin == false then
      DataModel.DeadHero.dead_hero_num = table.count(RoleList) - BattleResult.survivor
      PlayerData.TempCache.MonsterLevelAutoBattle = false
      PlayerData.BattleInfo.nextLevel = nil
      RefreshBattleDefeatResultPage()
    elseif BattleResult.isWin == true then
      CountEvaluateScore(PlayerData.BattleInfo.battleStageId)
      local currentHP = {}
      if PlayerData.LevelChain.OnLevelChain == true then
        local roleList = PlayerData.ServerData.squad[100].role_list
        for i = 1, table.count(roleList) do
          if roleList[i] ~= "" then
            local hp = PlayerData:GetFactoryData(roleList[i].id, "UnitFactory").hp_SN
            currentHP[tostring(roleList[i])] = hp
          end
        end
      end
      PlayerData:RefreshChapterSeverData()
      DataModel.roleVideo = nil
      Net:SendProto("battle.end_battle", function(jsons)
        DataModel.JsonList = jsons
        if PlayerData.LevelChain.OnLevelChain == true then
          PlayerData.ServerData.level_chain.roles = currentHP
        end
        Train.EventBattleFinish(jsons)
        UnLockBook()
        InitCoreInfo()
        PlayerData.BattleInfo.DropAwardList = PlayerData:SortShowItem(jsons.reward)
        DataModel.DropAwardList = jsons.reward
        if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.isWitchBattle and levelCfg.isWitchesBoss then
          local damage = require("UITestLevel/UITestLevelDataModel").RecordDetail.damageTotal
          WitchData.RefreshBossDamageMax(damage)
          WitchData.ReduceBossBattleTimes()
        end
        if jsons.last_level ~= nil and PlayerData.ChooseChapterType == 1 then
          PlayerData.last_level = tonumber(jsons.last_level)
        end
        Data = jsons
        DataModel.RoleList = {}
        local count = 1
        for k, v in pairs(RoleList) do
          local row = {}
          DataModel.RoleList[count] = row
          row.roleid = k
          local factory = PlayerData:GetFactoryData(row.roleid, "UnitFactory")
          row.name = factory.name
          row.viewId = factory.viewId
          row.viewList = PlayerData:GetFactoryData(row.viewId, "UnitViewFactory")
          row.face = row.viewList.face
          row.before = DataModel.before_roles[tostring(row.roleid)] == nil and PlayerData:GetFactoryData(tostring(row.roleid)) or DataModel.before_roles[tostring(row.roleid)]
          row.now = Data.roles[tostring(row.roleid)] and Clone(Data.roles[tostring(row.roleid)]) or row.before
          if levelCfg.isUseLevelRole then
            for i = 1, #levelCfg.levelRoleList do
              local roleData = PlayerData:GetFactoryData(levelCfg.levelRoleList[i].id, "LevelRoleFactory")
              if tonumber(roleData.unitId) == tonumber(k) and roleData.usePlayerRoleData ~= true then
                row.now.lv = roleData.lv
                row.before.lv = roleData.lv
                row.before.exp = 0
                row.now.exp = 0
              end
            end
          end
          for i = 1, #PlayerData.BattleInfo.roleDataList do
            local roleData = PlayerData.BattleInfo.roleDataList[i]
            if roleData and tonumber(roleData.unitId) == tonumber(k) and roleData.isHelpRole then
              row.now.lv = roleData.lv
              row.before.lv = roleData.lv
              row.before.exp = 0
              row.now.exp = 0
            end
          end
          local now_role_exp = row.now.exp or 0
          local before_role_exp = row.before.exp or 0
          local before_role_lv = row.before.lv or 0
          local now_role_lv = row.now.lv or 0
          local temp_exp = 0
          if 0 < now_role_lv - before_role_lv then
            for i = before_role_lv, now_role_lv - 1 do
              local levelUpExp = UnitLevelMaxData[i].levelUpExp
              temp_exp = temp_exp + levelUpExp - before_role_exp
            end
            now_role_exp = now_role_exp + temp_exp + before_role_exp
          end
          row.now_role_exp = now_role_exp
          row.battleInfo = v
          row.exp_ani = 0
          count = count + 1
        end
        DataModel.DeadHero.dead_hero_num = table.count(DataModel.RoleList) - BattleResult.survivor
        if PlayerData.ChooseChapterType == 3 then
          ViewFunction:Settlement_Group_Victory_Group_Right_Btn_Next_Click()
        else
          RefreshBattleVictoryResultPage()
        end
        local mvp_id = BattleResult.mvpId
        PlayRoleSound(mvp_id, 1)
        if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.scene == "RubikCube" then
          DataModel.CubeRogueReward = jsons.reward
          DataModel.CubeRogueReward.item = nil
          PlayerData.CubeLevelFinish(DataModel.LevelCA.id)
        end
        if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_Material" then
          local UIBattle_MaterialDataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
          UIBattle_MaterialDataModel:BattleEndSetCurrentNum()
        end
        if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_EquipmentDay" then
          local UIBattle_EquipmentDayDataModel = require("UIBattle_EquipmentDay/UIBattle_EquipmentDayDataModel")
          UIBattle_EquipmentDayDataModel:BattleEndSetCurrentNum()
        end
        if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_EquipmentWeek" then
          local UIBattle_EquipmentWeekDataModel = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekDataModel")
          UIBattle_EquipmentWeekDataModel:BattleEndSetCurrentNum()
        end
        DealCubeRogueBattleResult()
        DataModel.CubeRogueReward = jsons.reward
        PlayerData.CubeLevelFinish(DataModel.LevelCA.id)
      end, PlayerData.BattleInfo.levelUid, math.floor(Score), Json.encode(DataModel.DeadHero), function(json)
        if json.rc == "80601508" then
          View.Group_Timeout.self:SetActive(true)
          return
        end
        Net:SendProto("battle.end_battle", function(jsons)
          DataModel.JsonList = jsons
          if PlayerData.LevelChain.OnLevelChain == true then
            PlayerData.ServerData.level_chain.roles = currentHP
          end
          Train.EventBattleFinish(jsons)
          UnLockBook()
          InitCoreInfo()
          PlayerData.BattleInfo.DropAwardList = PlayerData:SortShowItem(jsons.reward)
          DataModel.DropAwardList = jsons.reward
          if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.isWitchBattle and levelCfg.isWitchesBoss then
            local damage = require("UITestLevel/UITestLevelDataModel").RecordDetail.damageTotal
            WitchData.RefreshBossDamageMax(damage)
            WitchData.ReduceBossBattleTimes()
          end
          if jsons.last_level ~= nil and PlayerData.ChooseChapterType == 1 then
            PlayerData.last_level = tonumber(jsons.last_level)
          end
          Data = jsons
          DataModel.RoleList = {}
          local count = 1
          for k, v in pairs(RoleList) do
            local row = {}
            DataModel.RoleList[count] = row
            row.roleid = k
            local factory = PlayerData:GetFactoryData(row.roleid, "UnitFactory")
            row.name = factory.name
            row.viewId = factory.viewId
            row.viewList = PlayerData:GetFactoryData(row.viewId, "UnitViewFactory")
            row.face = row.viewList.face
            row.before = DataModel.before_roles[tostring(row.roleid)] == nil and PlayerData:GetFactoryData(tostring(row.roleid)) or DataModel.before_roles[tostring(row.roleid)]
            row.now = Data.roles[tostring(row.roleid)] and Clone(Data.roles[tostring(row.roleid)]) or row.before
            if levelCfg.isUseLevelRole then
              for i = 1, #levelCfg.levelRoleList do
                local roleData = PlayerData:GetFactoryData(levelCfg.levelRoleList[i].id, "LevelRoleFactory")
                if tonumber(roleData.unitId) == tonumber(k) and roleData.usePlayerRoleData ~= true then
                  row.now.lv = roleData.lv
                  row.before.lv = roleData.lv
                  row.before.exp = 0
                  row.now.exp = 0
                end
              end
            end
            local now_role_exp = row.now.exp or 0
            local before_role_exp = row.before.exp or 0
            local before_role_lv = row.before.lv or 0
            local now_role_lv = row.now.lv or 0
            local temp_exp = 0
            if 0 < now_role_lv - before_role_lv then
              for i = before_role_lv, now_role_lv - 1 do
                local levelUpExp = UnitLevelMaxData[i].levelUpExp
                temp_exp = temp_exp + levelUpExp - before_role_exp
              end
              now_role_exp = now_role_exp + temp_exp + before_role_exp
            end
            row.now_role_exp = now_role_exp
            row.battleInfo = v
            row.exp_ani = 0
            count = count + 1
          end
          if PlayerData.ChooseChapterType == 3 then
            ViewFunction:Settlement_Group_Victory_Group_Right_Btn_Next_Click()
          else
            RefreshBattleVictoryResultPage()
          end
          if PlayerData.Last_Chapter_Parms and PlayerData.Last_Chapter_Parms.scene == "RubikCube" then
            DataModel.CubeRogueReward = jsons.reward
            DataModel.CubeRogueReward.item = nil
            PlayerData.CubeLevelFinish(DataModel.LevelCA.id)
          end
          if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_Material" then
            local UIBattle_MaterialDataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
            UIBattle_MaterialDataModel:BattleEndSetCurrentNum()
          end
          if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_EquipmentDay" then
            local UIBattle_EquipmentDayDataModel = require("UIBattle_EquipmentDay/UIBattle_EquipmentDayDataModel")
            UIBattle_EquipmentDayDataModel:BattleEndSetCurrentNum()
          end
          if PlayerData.BattleCallBackPage == "UI/Chapter/Battle_Material/Battle_EquipmentWeek" then
            local UIBattle_EquipmentWeekDataModel = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekDataModel")
            UIBattle_EquipmentWeekDataModel:BattleEndSetCurrentNum()
          end
          DealCubeRogueBattleResult()
          DataModel.CubeRogueReward = jsons.reward
          PlayerData.CubeLevelFinish(DataModel.LevelCA.id)
        end, PlayerData.BattleInfo.levelUid, math.floor(Score), Json.encode(DataModel.DeadHero), nil, Json.encode(currentHP), 1, PlayerData.BattleInfo.BattleResult.cores)
      end, Json.encode(currentHP), 1, PlayerData.BattleInfo.BattleResult.cores)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if PlayerData.ChooseChapterType == 3 and BattleResult.isWin == true then
      return
    end
    if DataModel.AutoNextGoState == false then
      DataModel.AutoNextTime = DataModel.AutoNextTime - 1
      DataModel.SettingTime = DataModel.SettingTime - 1
    end
    if DataModel.SettingTime <= 0 then
      isGridFinish = true
    end
    if DataModel.AutoSettlement then
      if DataModel.AutoNextTime == 0 and DataModel.AutoNextGoState == false then
        DataModel.AutoNextGoState = true
        if BattleResult.isWin == false then
          ViewFunction:Settlement_Group_Defeat_Btn_Next_Click()
        elseif BattleResult.isWin == true then
          ViewFunction:Settlement_Group_Victory_Btn_Next_Click()
        end
      end
      if DataModel.AutoNextGoState == false then
        if BattleResult.isWin == false then
          View.Group_Defeat.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), math.ceil(0 <= DataModel.AutoNextTime / 60 and DataModel.AutoNextTime / 60 or 0)))
        elseif BattleResult.isWin == true then
          View.Group_Victory.Group_btn.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), math.ceil(0 <= DataModel.AutoNextTime / 60 and DataModel.AutoNextTime / 60 or 0)))
        end
      elseif DataModel.AutoNextGoState == true then
        View.Group_Victory.Group_btn.Btn_Next.Txt_Time:SetText("")
        View.Group_Defeat.Btn_Next.Txt_Time:SetText("")
      end
    end
    delay_ani_time = delay_ani_time - 1
    if DataModel.AniState == true and delay_ani_time <= 0 then
      RefreshAni()
    end
  end,
  ondestroy = function()
    if not DataModel.IsReStart and not DataModel.isAutoNext then
      PlayerData.LevelData = {}
    end
    CommonItem:DestroyInstantiate()
    DataModel:CleanEffect()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
