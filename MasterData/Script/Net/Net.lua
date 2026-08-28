local Net = {
  sendGuideNO = 0,
  duration = 0,
  sendGuideMethodName = "",
  isWaitingResponse = false,
  updateGuideNoLimit = nil,
  firstGuideUpdateMethodName = "",
  firstGuide_step_index = -1,
  firstGuide_step_id = -1,
  isWaitingFirstGuideResponse = false,
  FailRepeatSendCode = {
    test = true,
    ["111"] = true,
    [80600026] = true,
    ["80600026"] = true
  },
  CacheProto = {},
  IsOpenTest = false,
  resources_version = -1,
  client_version = "*",
  notic = "",
  bilipc_charge_playerlv = -1,
  bilipc_charge_normal_ip_playerlv = -1,
  bilipc_charge_blocked_ip_playerlv = -1,
  bilipc_charge_blocked_regions = "",
  pc_tap_charge_playerlv = -1,
  overseas_priority_ocweb_recharge_pop = 0
}
local protocol = require("Net/Protocol")
local GachaNewDataModel = require("UIGachaNew/UIGachaNewDataModel")
local StoreDataModel = require("UIStore/UIStoreDataModel")
local SignBattleLevelDataModel = require("UIActivitySignBattleLevel/UIActivitySignBattleLevelDataModel")
local mission_pro = {
  ["quest.list"] = 1,
  ["battle_pass.multi_pass_rewards"] = 1,
  ["quest.multi_pass_rec_quests_rewards"] = 1,
  ["item.recv_liveness_rewards"] = 1,
  ["quest.recv_rewards"] = 1,
  ["battle_pass.multi_buy"] = 1,
  ["battle_pass.multi_upgrade"] = 1
}
local squad_pro = {
  ["deck.preset"] = 1,
  ["deck.update_hero"] = 1,
  ["deck.set_deck"] = 1
}
local activityId

local function IsMatchClientVersion(version, versionStr)
  if versionStr == "" then
    return true
  end
  local tList = string.split(versionStr, ",")
  for key, value in ipairs(tList) do
    if value == "*" or value == version then
      return true
    end
  end
  return false
end

local function IsMatchResourcesVersion(version, versionStr)
  if versionStr == "" then
    return true
  end
  local versionInt = tonumber(versionStr)
  local tagetVersionInt = tonumber(version:match("(%d+)$"))
  if versionInt < 0 or versionInt <= tagetVersionInt then
    return true
  end
  return false
end

local function OnExitGame()
  CS.GameSetting.Quit()
end

local function UpdateClient()
  if GameSetting.platform == "IOS" then
    ApplicationHelper.OpenUrl(GameSetting.upgradeIosURL)
    OnExitGame()
    return
  end
  HotfixSetting:UpdateClient()
end

local function HandleExtraReward(reward, cs_reward)
  local extra = {}
  for k, v in pairs(cs_reward) do
    for k1, v1 in pairs(v) do
      extra[k1] = v1
    end
  end
  for k, v in pairs(reward) do
    for k1, v1 in pairs(v) do
      if extra[k1] then
        v1.num = v1.num - extra[k1].num
      end
    end
  end
  reward.extra = extra
end

function Net.CheckClientVersionWithRepJson(json)
  Net.client_version = json.client_version or "*"
  if IsMatchClientVersion(HotfixSetting.clientAppVersion, Net.client_version) == false then
    local notic = Net.notic
    if notic == nil or notic == "" then
      notic = GetText("80602200")
    end
    CommonTips.OnPromptConfirmOnly(notic, GetText("80602201"), function()
      UpdateClient()
    end, true)
    return false
  end
  return true
end

function Net.Callback(response, cb, failCb, protocol)
  local json = Json.decode(response)
  Net.resources_version = json.resources_version or -1
  Net.client_version = json.client_version or "*"
  Net.notic = json.notic or ""
  Net.bilipc_charge_playerlv = json.bilipc_charge_playerlv or -1
  Net.bilipc_charge_normal_ip_playerlv = json.bilipc_charge_normal_ip_playerlv or -1
  Net.bilipc_charge_blocked_ip_playerlv = json.bilipc_charge_blocked_ip_playerlv or -1
  Net.bilipc_charge_blocked_regions = json.bilipc_charge_blocked_regions or ""
  Net.pc_tap_charge_playerlv = json.pc_tap_charge_playerlv or -1
  Net.overseas_priority_ocweb_recharge_pop = json.overseas_priority_ocweb_recharge_pop or 0
  if IsMatchResourcesVersion(HotfixSetting.serverPatchVersion, Net.resources_version) == false then
    local notic = Net.notic
    if notic == nil or notic == "" then
      notic = GetText("80602199")
    end
    CommonTips.OnPromptConfirmOnly(notic, GetText("80600068"), function()
      OnExitGame()
    end, true)
    return
  end
  if IsMatchClientVersion(HotfixSetting.clientAppVersion, Net.client_version) == false then
    local notic = Net.notic
    if notic == nil or notic == "" then
      notic = GetText("80602200")
    end
    CommonTips.OnPromptConfirmOnly(notic, GetText("80602201"), function()
      UpdateClient()
    end, true)
    return
  end
  print_r("<color=#00ff00ff>\230\156\141\229\138\161\229\153\168=============>\229\174\162\230\136\183\231\171\175</color>", json)
  if json.msg and json.msg ~= "" and type(json.msg) == "string" then
    Debug.LogError("<color=#00ff00ff>\230\156\141\229\138\161\229\153\168\233\148\153\232\175\175\228\191\161\230\129\175\239\188\154</color> " .. json.msg)
    if json.msg == "\230\139\166\232\183\175\230\128\170\228\184\141\229\140\185\233\133\141" or json.rc == "2.2.3" or json.rc == "2.2.2" then
      BugLogReporter:ReportTrainEvent()
    end
  end
  if Net.IsOpenTest and type(json.msg) == "string" then
    print_r("<color=#FFF000>\230\156\141\229\138\161\229\153\168=============>\229\174\162\230\136\183\231\171\175</color>\231\137\185\229\136\171\231\154\132msg", json.msg)
  end
  if json.server_now then
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json.server_now
    PlayerData.ServerData.server_now = json.server_now
  end
  if json.rc == "" then
    if Net.CacheProto[cb] then
      Net.CacheProto[cb] = nil
    end
    if Net.isWaitingResponse == true then
      local tempGuideNo = Net.sendGuideNO
      Net.ResetGuideNo()
      SdkReporter.TrackGuideComplete(tempGuideNo)
      PlayerData:GetUserInfo().newbie_step = tempGuideNo
      GuideManager:SetGuideNO(tempGuideNo)
    end
    if Net.isWaitingFirstGuideResponse then
      Net.ResetFirstGuideData(true)
      Net.isWaitingFirstGuideResponse = false
    end
    if json.entrust_sp then
      PlayerData.ServerData.entrust_sp = json.entrust_sp
    end
    if json.help then
      PlayerData.ServerData.helpData = json.help
    end
    if json.reward and 0 < table.count(json.reward) then
      local args = {}
      args.reward = json.reward
      args.protocolName = protocol
      PlayerData.RefreshCardsData(args.reward)
      PlayerData:AddRewardSever(args)
      PrisonData.GetPrisonExpRefresh(json.reward)
    end
    if json.monthly_card then
      PlayerData.ServerData.monthly_card = json.monthly_card
    end
    if json.monthly_sign then
      PlayerData.ServerData.monthly_sign = json.monthly_sign
    end
    if json.req_back_num then
      PlayerData:GetHomeInfo().req_back_num = json.req_back_num
    end
    if json.monthly_req_back_num then
      PlayerData:GetHomeInfo().monthly_req_back_num = json.monthly_req_back_num
    end
    if json.activity_monthly_req_back_num then
      PlayerData:GetHomeInfo().activity_monthly_req_back_num = json.activity_monthly_req_back_num
    end
    if json.use_free_num then
      PlayerData:GetHomeInfo().use_free_num = json.use_free_num
    end
    if json.consumables then
      PlayerData:RemoveRewardServer(json.consumables)
    end
    if json.quest_awards then
      if json.quest_awards.card_pack then
        json.quest_awards.card_pack = Clone(json.reward.card_pack)
      end
      PlayerData:SubQuestReward(json.reward, json.quest_awards)
    end
    if json.cs_reward then
      HandleExtraReward(json.reward, json.cs_reward)
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    if json.heros then
      PlayerData:RefreshRoles(json.heros)
    end
    if json.roles and protocol ~= "friend.coach" and protocol ~= "battle.help_list" then
      PlayerData:RefreshRoles(json.roles)
    end
    if json.items then
      PlayerData:RefreshItem(json.items)
    end
    if json.chapter_level then
      PlayerData:RefreshChapterLevel(json.chapter_level)
    end
    if json.station_info then
      PlayerData:RefreshStationInfo(json.station_info)
    end
    if json.display_train then
      PlayerData:RefreshDisplayTrain(json.display_train)
    end
    if json.material then
      PlayerData:RefreshMaterial(json.material)
    end
    if json.goods then
      PlayerData:RefreshGoods(json.goods)
    end
    if json.equips then
      PlayerData:RefreshEquips(json.equips)
    end
    if json.user_info then
      PlayerData:RefreshUserInfo(json.user_info)
    end
    if json.cards then
      PlayerData:RefreshCards(json.cards)
    end
    if json.mails then
      PlayerData:RefreshMails(json.mails)
    end
    if json.shops then
      PlayerData:RefreshShops(json.shops)
    end
    if json.server_quests then
      PlayerData:RefreshActivityBuffByServerQuest(json.server_quests, protocol == nil)
    end
    if json.recharge_goods then
      PlayerData.RechargeGoods = json.recharge_goods
    end
    if json.reputation then
      PlayerData:RefreshReputation(json.reputation)
    else
      PlayerData.TempCache.repLvUpCache = nil
      if json.reward and json.reward.rep then
        PlayerData:RefreshRewardRep(json.reward.rep)
      end
    end
    if json.rep_rewards then
      PlayerData:RefreshRepList(json.rep_rewards)
    end
    if json.change_city then
      PlayerData:RefreshStationState(json.change_city)
    end
    if json.stations then
      PlayerData:RefreshStationsDriveNum(json.stations)
      PlayerData:RefreshStationsFairyland(json.stations)
    end
    if json.readiness then
      PlayerData:RefreshReadiness(json.readiness)
    end
    if json.dev_degree then
      PlayerData:RefreshDevDegree(json.dev_degree)
    end
    if json.home_battery then
      PlayerData:GetHomeInfo().home_battery = json.home_battery
    end
    if json.dress then
      PlayerData.CaptainSkinSystem:InitData(json.dress)
    end
    if json.plot_paragraph then
      PlayerData:RefreshPlot_paragraph(json.plot_paragraph)
    end
    if json.enemies then
      PlayerData:RefreshEnemies(json.enemies)
    end
    if json.completed_dungeon then
      PlayerData:RefreshCompleteDungeon(json.completed_dungeon)
    end
    if json.books then
      local books = json.books
      if json.books.music then
        PlayerData:RefreshMusic(books.music)
      end
      if json.books.pictures then
        PlayerData:RefreshPictures(books.pictures)
      end
      if json.books.enemy then
        PlayerData:RefreshEnemy(books.enemy)
      end
      if json.books.photo then
        PlayerData:RefreshPhoto(books.photo)
      end
      if json.books.video then
        PlayerData:RefreshVideo(books.video)
      end
      if json.books.sound then
        PlayerData:RefreshSound(books.sound)
      end
      if json.books.card_pack then
        PlayerData:RefreshCardPack(books.card_pack)
      end
      if json.books.weapon then
        PlayerData:RefreshWeapon(books.weapon)
      end
      if json.books.equip then
        PlayerData:RefreshEquip(books.equip)
      end
    end
    if json.construction then
      PlayerData:RefreshConstruction(json.construction)
    end
    if json.change_order then
      PlayerData:RefreshOrders(json.change_order)
    end
    if json.update_quests then
      PlayerData:UpdateQuestData(json.update_quests)
      if PlayerData.TempCache.AutoCompleteLevels ~= nil then
        PlayerData.TempCache.AutoCompleteLevelsServerReward = json.quest_awards
      end
      PrisonData.QuestRefresh()
      GachaNewDataModel:SetQuestCardGachaMain(json.update_quests)
      StoreDataModel:SetQuestStoreRedState(json.update_quests)
    end
    if json.server_quests then
      PlayerData.RefreshServerQuests(json.server_quests)
    end
    if json.pollute_areas then
      PlayerData:RefrshPolluteLines(json.pollute_areas)
    end
    if json.areas then
      PlayerData:GetHomeInfo().areas = json.areas
    end
    if json.plots then
      PlayerData:RefreshGotWord(json.plots.data_bank)
    end
    if json.data_bank then
      PlayerData:RefreshGotWord(json.data_bank)
    end
    if json.server_construction then
      PlayerData:RefreshActivityServerConstruction(json.server_construction)
    end
    if json.multi_battle_pass then
      PlayerData.ServerData.multi_battle_pass = json.multi_battle_pass
      PlayerData:RefreshCurrentMultiBattleIds()
    end
    if json.multi_quests then
      PlayerData.ServerData.quests = PlayerData.ServerData.quests or {}
      for k, v in pairs(json.multi_quests) do
        PlayerData.ServerData.quests[k] = v
      end
    end
    if json.multi_pass_daily_quests then
      PlayerData.ServerData.quests = PlayerData.ServerData.quests or {}
      PlayerData.ServerData.quests.multi_pass_daily_quests = json.multi_pass_daily_quests
    end
    if json.multi_pass_weekly_quests then
      PlayerData.ServerData.quests = PlayerData.ServerData.quests or {}
      PlayerData.ServerData.quests.multi_pass_weekly_quests = json.multi_pass_weekly_quests
    end
    if json.bs_pass then
      PlayerData.ServerData.bs_pass = json.bs_pass
    end
    if json.carrying_backpack then
      PlayerData.ServerData.user_prison_info.carrying_backpack = json.carrying_backpack
    end
    if json.prison_backpack then
      PlayerData.ServerData.user_prison_info.prison_backpack = json.prison_backpack
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if json.abyss_level then
      if PlayerData.ServerData.abyss_level == nil then
        PlayerData.ServerData.abyss_level = {}
      end
      for k, v in pairs(json.abyss_level) do
        PlayerData.ServerData.abyss_level[k] = v
      end
    end
    if json.return_info then
      PlayerData.ServerData.return_info = json.return_info
    end
    if json.ret_buff then
      for i, v in pairs(json.ret_buff) do
        if PlayerData.ServerData.return_info.ret_buff[i] then
          PlayerData.ServerData.return_info.ret_buff[i] = v
        end
      end
    end
    if json.stage_quest_reward then
      PlayerData:RefreshStageQuestReward(json.stage_quest_reward)
    end
    if json.banners then
      PlayerData:RefreshCardGacha(json.banners)
    end
    if json.current_quests ~= nil then
      for k, v in pairs(json.current_quests) do
        if v.recv ~= 0 and v.unlock == 0 then
          GachaNewDataModel:SetQuestCardGacha(k)
          StoreDataModel:SetQuestStoreGacha(k)
        end
      end
    end
    if json.cs_activity then
      SignBattleLevelDataModel:SetSignBattleData(json)
    end
    if json.material_num then
      local UIBattle_MaterialDataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
      UIBattle_MaterialDataModel:SetCurrentNum(json.material_num)
    end
    if json.equip_day_num then
      local UIBattle_EquipmentDayDataModel = require("UIBattle_EquipmentDay/UIBattle_EquipmentDayDataModel")
      UIBattle_EquipmentDayDataModel:SetCurrentNum(json.equip_day_num)
    end
    if json.equip_week_num then
      local UIBattle_EquipmentWeekDataModel = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekDataModel")
      UIBattle_EquipmentWeekDataModel:SetCurrentNum(json.equip_week_num)
    end
    if json.capsule then
      PlayerData.SetCapsuleData(json.capsule)
    end
    if protocol then
      GuideManager:ProtocolCallback(protocol)
      if mission_pro[protocol] then
        PlayerData.MultiMissionRefreshAll = true
      end
      if squad_pro[protocol] then
        PlayerData:GetAwakeEquipRed()
      end
      if protocol == "main.participate" and activityId then
        GachaNewDataModel:SetActivityCardGacha(activityId)
        StoreDataModel:SetActivityStoreRedState(activityId)
      end
    end
    if PlayerData.TempCache.AutoCompleteLevels then
      GuideManager:CompleteQuestCallBack(PlayerData.TempCache.AutoCompleteLevels)
    end
    if json.user_info and json.user_info.retry_login == 1 then
      CommonTips.OnPromptConfirmOnly("80600171", "80600068", function()
        CBus:NewLogout()
      end, false)
    else
      if cb ~= nil then
        cb(json)
      end
      if protocol then
        PlayerData:ProtocolCallback(protocol)
      end
      if json.update_quests and json.update_quests.achieve_quests then
        PlayerData:UpdateAchieveData(json.update_quests.achieve_quests)
      end
      if protocol ~= "battle.end_battle" and protocol ~= "station.arrive" and protocol ~= "shop.buy" and protocol ~= "main.main" then
        CommonTips.OpenQuestsCompleteTip()
      end
    end
  else
    if json.rc == "80601508" then
      if failCb then
        failCb(json)
      end
      return
    end
    if Net.CacheProto[cb] and Net.FailRepeatSendCode[json.rc] then
      ServerConnectManager:Add(Net.CacheProto[cb], true)
      CommonTips.OnPromptConfirmOnly(json.msg, "80600068", function()
        ServerConnectManager:RepeatSpecialProtocol()
      end, function()
        CBus:NewLogout()
      end, false)
      return
    end
    if json.rc == "undisplay" then
      return
    end
    if json.rc == 1007 or json.rc == 1011 then
      CommonTips.OpenTips("\232\186\171\228\187\189\232\175\129\229\143\183\230\160\188\229\188\143\230\160\161\233\170\140\229\164\177\232\180\165")
    elseif json.msg ~= nil and json.msg ~= "" then
      print_r(protocol)
      print_r("-----------protocol--------------")
      if not UseGSDK or protocol ~= "pay.query_oid" then
        CommonTips.OpenTips(json.msg)
      end
    end
    if json.rc == "80600058" then
      CommonTips.OnPromptConfirmOnly("80601507", nil, function()
        LogoutHelper.LogoutBySever()
      end, false)
      return
    end
    if failCb then
      failCb(json)
    end
  end
end

function Net:SendProto(methodName, cb, ...)
  local params = protocol[methodName](...)
  local data = {}
  local failCb
  for k, v in pairs(params) do
    if type(v) == "table" then
      if #v == 0 then
        data[k] = ""
        for a, b in pairs(v) do
          data[k] = data[k] .. a .. ":" .. b .. ","
        end
      else
        data[k] = table.concat(v, "&")
      end
    elseif type(v) == "function" then
      failCb = v
    else
      data[k] = v
    end
  end
  if Net.sendGuideMethodName == methodName or Net.firstGuideUpdateMethodName == methodName then
    local canUpdate = true
    if Net.updateGuideNoLimit then
      canUpdate = true
      for k, v in pairs(Net.updateGuideNoLimit) do
        if k == EnumDefine.GuideNoUpdateLimitDataEnum.CheckLevelMod then
          local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
          canUpdate = canUpdate and levelCA.mod == tostring(v)
        elseif PlayerData.TempCache.GuideNoUpdateLimitData[k] then
          canUpdate = canUpdate and tostring(PlayerData.TempCache.GuideNoUpdateLimitData[k]) == tostring(v)
        else
          canUpdate = canUpdate and tostring(data[k]) == tostring(v)
        end
      end
    end
    if canUpdate then
      if Net.sendGuideMethodName == methodName then
        data.newbie_step = Net.sendGuideNO
        Net.isWaitingResponse = true
      elseif Net.firstGuideUpdateMethodName == methodName then
        data.step_index = Net.firstGuide_step_index
        data.step_id = Net.firstGuide_step_id
        Net.isWaitingFirstGuideResponse = true
      end
    end
  elseif Net.sendGuideNO >= 999 then
    data.newbie_step = Net.sendGuideNO
    Net.isWaitingResponse = true
  end
  if methodName == "main.participate" and data.activityId then
    activityId = data.activityId
  end
  data.remote_id = PlayerData.RemoteId
  data.device_id = GameSetting.RandomUID
  print_r("<color=#00ffffff>\229\174\162\230\136\183\231\171\175=============>\230\156\141\229\138\161\229\153\168</color>", methodName, data)
  if cb then
    self.CacheProto[cb] = {
      methodName = methodName,
      params = data,
      pid = PlayerData.pid,
      platform = PlayerData.platform,
      cb = function(response)
        self.Callback(response, cb, failCb, methodName)
      end
    }
  end
  ServerConnectManager:Add({
    methodName = methodName,
    params = data,
    pid = PlayerData.pid,
    platform = PlayerData.platform,
    cb = function(response)
      self.Callback(response, cb, failCb, methodName)
    end
  })
end

function Net.GetServeTimeOffset(cb)
  cb(PlayerData.serverTimeOffset)
end

function Net.SendGuideNO(methodName, guideNO, duration, isAtOnce)
  Net.sendGuideMethodName = methodName
  Net.sendGuideNO = guideNO
  Net.duration = duration
  if isAtOnce then
    Net:SendProto("main.newbie_step", function(json)
    end)
  end
end

function Net.ResetGuideNo()
  Net.sendGuideMethodName = ""
  Net.sendGuideNO = 0
  Net.duration = 0
  Net.updateGuideNoLimit = nil
  Net.isWaitingResponse = false
end

function Net.SetGuideNoUpdateLimit(key, value)
  if Net.updateGuideNoLimit == nil then
    Net.updateGuideNoLimit = {}
  end
  Net.updateGuideNoLimit[key] = value
end

function Net.SetFirstGuideUpdateData(methodName, step_index, step_id)
  Net.firstGuideUpdateMethodName = methodName
  Net.firstGuide_step_index = step_index
  Net.firstGuide_step_id = step_id
end

function Net.ResetFirstGuideData(isComplete)
  local tempStepId = Net.firstGuide_step_id
  Net.firstGuideUpdateMethodName = ""
  Net.firstGuide_step_index = -1
  Net.firstGuide_step_id = -1
  Net.updateGuideNoLimit = nil
  if isComplete == true then
    GuideManager:CompletePanelTriggerGuideId(tempStepId)
  end
end

return Net
