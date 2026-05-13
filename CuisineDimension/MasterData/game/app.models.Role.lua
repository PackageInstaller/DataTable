local UnitCsv = require("csvdata.unit")
local SysErrCsv = require("csvdata.sys_codes")
local FormationCsv = require("csvdata.formation")
local FBuildCsv = require("csvdata.farm_building")
local FTermsCsv = require("csvdata.farm_terms")
local LoopCsv = require("csvdata.loop_task")
local RandomTaskCsv = require("csvdata.random_task")
local LoveCsv = require("csvdata.love_task")
local MissionCsv = require("csvdata.mission")
local HeadPicCsv = require("csvdata.head_pic")
local ItemCsv = require("csvdata.item")
local FunctionOpenCsv = require("csvdata.function_open")
local MonthGiftCsv = require("csvdata.farm_sign_month")
local AchieveCsv = require("csvdata.achievement")
local NewRechargeCsv = require("csvdata.loop_activity.loop_rechargegift")
local TotalRechargeCsv = require("csvdata.loop_activity.loop_totalrechargegift")
local MarryCsv = require("csvdata.once_activity.marry")
local Marry86Csv = require("csvdata.once_activity.marry86")
local LevelCsv = require("csvdata.activity_levelgift")
local RechargeCsv = require("csvdata.activity_rechargegift")
local LoginCsv = require("csvdata.activity_logingift")
local Login88Csv = require("csvdata.activity_88_logingift")
local Activity92Csv = require("csvdata.activity_92_task")
local ActivityLogingiftCsv = require("csvdata.loop_activity.loop_logingift")
local AMissionCsv = require("csvdata.activity_taskgift")
local SpeicalMCsv = require("csvdata.activity_scoregift")
local HeroMCsv = require("csvdata.activity_puzzlegift")
local MagicTaskCsv = require("csvdata.activity_traditionaltask")
local InviteCsv = require("csvdata.friend_invite")
local jobStageCsv = require("csvdata.hero_job_stage")
local jobBonusCsv = require("csvdata.hero_job_bonus")
local MoonGiftCsv = require("csvdata.moon_gift")
local MoonTaskCsv = require("csvdata.moon_task")
local MoonScoreCsv = require("csvdata.moon_scoregift")
local NewYearGiftCsv = require("csvdata.once_activity.newyear")
local unionTechCsv = require("csvdata.union_tech")
local HalloweenTaskCsv = require("csvdata.halloween.halloween_task")
local HalloweenGoalTaskCsv = require("csvdata.halloween.halloween_goal")
local DinerTalentCsv = require("csvdata.diner_talent_type")
local LtyGiftCsv = require("csvdata.lty.lty_gift")
local TapDailyCsv = require("csvdata.loop_activity.daily_task")
local TapGoalCsv = require("csvdata.loop_activity.goal_task")
local LoverStoryCsv = require("csvdata.once_activity.valentines")
local LoverGiftCsv = require("csvdata.shop_score1")
local YearLoginCsv = require("csvdata.loop_activity.logingift_year")
local YearLogin103Csv = require("csvdata.loop_activity.logingift_year103")
local SauceBonusCsv = require("csvdata.sauce_bonus")
local SauceLoginCsv = require("csvdata.once_activity.logingift1")
local FirstDayTaskCsv = require("csvdata.loop_activity.newyear_task")
local AFormationCsv = require("csvdata.activity_formation")
local ALuckyCsv = require("csvdata.once_activity.lucky")
local CollectHeroCsv = require("csvdata.activity_herocollection")
local PassRewardCsv = require("csvdata.battlepass_reward")
local DiamondfundRewardCsv = require("csvdata.diamondfund_reward")
local RouGeRewardCsv = require("csvdata.rouge.rouge_pass_reward")
local DateCsv = require("csvdata.date")
local PTRankCsv = require("csvdata.pt_rankgift1")
local InviteTaskCsv = require("csvdata.regression_task")
local TimeLimitGiftCsv = require("csvdata.time_limit_gift")
local CollectExtraStarCsv = require("csvdata.collect_extrastar_task")
local ChapterPassManager = require("app.models.ChapterPassManager")
local Activity_80_taskCsv = require("csvdata.activity_80_task")
local MonthLoginGiftCsv = require("csvdata.activity_month_logingift")
local CostDiamondCsv = require("csvdata.activity_costdiamond_reward")
local UnionTechCsv = require("csvdata.union_tech")
local sdkInterface = require("sdk.SDKInterface")
local ActivityManager = require("app.models.ActivityManager")
local Activity95Manager = require("app.views.activity.Activity95Manager")
local Activity_85_taskCsv = require("csvdata.activity_85_task")
local Activity_85_rewardCsv = require("csvdata.activity_85_reward")
local unionBattleRewardCsv = require("csvdata.union_battle_reward")
local Role = class("Role")

function Role:ctor(msg)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  for key, value in pairs(msg) do
    if key == "activityStatus" or key == "buildListJson" then
      self[key] = json.decode(value)
    else
      self[key] = value
    end
  end
  self.heros = {}
  self.carbons = {}
  self.maps = {}
  self.equips = {}
  self.sauces = {}
  self.worldChats = {}
  self.unionChats = {}
  self.crossChats = {}
  self.sysTip = {}
  self.roleChats = {}
  self.p2pChats = {}
  self.p2pChatsIndex = {}
  self.redPoints = {}
  self.redDirty = {}
  self.lastCarbonInfo = {}
  self:bindNetListerners()
  self:afterInit()
end

function Role:afterInit()
  self.formation = json.decode(self.formationJson)
  self.heroBook = json.decode(self.heroBook)
  self.dressBook = self.dressBook:toNumMap()
  self.carbonBattle = json.decode(self.battleInfo)
  self.autoBattle = json.decode(self.autoBattleInfo)
  self.paradiseBattle = json.decode(self.paradiseBattleInfo)
  self.moonBattle = json.decode(self.moonBattleInfo)
  self.activeGuide = json.decode(self.activeGuideJson) or {}
  local master, slave = string.match(self.guide, "(%d+)=(%d+)")
  self.majorGuideStep = tonumber(master)
  self.minorGuideStep = 1
  if game.checkAge and game.age < 18 then
    self.timerHandler = scheduler.scheduleGlobal(function()
      game:sendData(actionCodes.Role_dTimeUpdateRpc, MsgPack.pack({
        age = game.age
      }))
      self:checkTimeLimit()
    end, globalCsv.dTimeUpdateSpace * 60)
  end
  if SKIP_GUIDE then
    self.majorGuideStep = 9999
  end
end

function Role:bindNetListerners()
  self.eventListeners = {
    NetManager:addEventListener(actionHandlers[actionCodes.Sys_commonNotice], function(event)
      local msg = MsgPack.unpack(event.data)
      if msg.body then
        MRunningMsg:show({
          text = msg.body
        })
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Sys_innerErrorMsg], function(event)
      local msg = MsgPack.unpack(event.data)
      if msg.id then
        local err = "因网络原因，数据与服务器不同步，请尝试重新登录，code:" .. msg.id
        MFlashMsg:show({text = err})
      end
      UIHelper.removeWaiting()
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Sys_maintainNotice], function(event)
      local msg = MsgPack.unpack(event.data)
      local dialog = MDialog:single({
        text = msg.body
      }, function()
        cc.Director:getInstance():endToLua()
      end)
      local endTime = game:nowTime() + 10
      local setTime
      
      function setTime()
        local leftTime = endTime - game:nowTime()
        dialog.okBtn:setTitleText(string.format("确定(%d)", leftTime))
        if leftTime <= 0 then
          dialog.callback()
          dialog:close()
        else
          dialog:runAction(transition.sequence({
            cc.DelayTime:create(1),
            cc.CallFunc:create(function()
              setTime()
            end)
          }))
        end
      end
      
      setTime()
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Sys_runningHorse], function(event)
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        MRunningMsg:show({
          text = msg.code
        })
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Sys_errorMsg], function(event)
      local msg = MsgPack.unpack(event.data)
      print("errorCode", msg.errCode)
      self:sysError(msg.errCode)
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Carbon_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      for id, carbonInfo in pairs(msg) do
        self.carbons[id] = carbonInfo
      end
      self:setRedDirty("mission")
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      for _, data in pairs(msg) do
        self:updateProperty(data.key, data.newValue, data.oldValue, data.extraValue)
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_updateProperties], function(event)
      local msg = MsgPack.unpack(event.data)
      for field, value in pairs(msg) do
        self:updateProperty(field, value)
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Union_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      if not msg.key then
        return
      end
      if not self.unionData then
        self.unionData = {
          members = {}
        }
      end
      if msg.key == "members" then
        for _, member in pairs(msg.newValue) do
          local ischange = false
          for index, unionMember in pairs(self.unionData[msg.key]) do
            if member.id == unionMember.id then
              ischange = true
              self.unionData[msg.key][index] = member
            end
          end
          if not ischange then
            table.insert(self.unionData[msg.key], member)
          end
        end
      else
        self.unionData[msg.key] = msg.newValue
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Union_updateProperties], function(event)
      local msg = MsgPack.unpack(event.data)
      if not self.unionData then
        self.unionData = {}
      end
      for field, value in pairs(msg) do
        self.unionData[field] = value
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Hero_loadInfos], function(event)
      local msg = MsgPack.unpack(event.data)
      for _, hero in ipairs(msg) do
        if hero.bDel then
          self.heros[hero.id] = nil
        else
          local newHero = require("app.models.Hero").new(hero)
          self.heros[newHero.id] = newHero
          if newHero.choose == 1 then
            table.insert(self.chooseHeros, newHero)
          end
        end
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Hero_delHeros], function(event)
      local msg = MsgPack.unpack(event.data)
      for _, heros in ipairs(msg) do
        for _, hero in ipairs(heros.ids) do
          if hero.bDel then
            self.heros[hero.id] = nil
          else
            local newHero = require("app.models.Hero").new(hero)
            self.heros[newHero.id] = newHero
            if newHero.choose == 1 then
              table.insert(self.chooseHeros, newHero)
            end
          end
        end
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Hero_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      local hero = self.heros[msg.id]
      if hero == nil then
        return
      end
      for _, data in ipairs(msg.datas) do
        hero:updateProperty(data.key, data.newValue, data.oldValue)
      end
      self:setRedDirty("loverDay")
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Farm_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      if not self.farmData then
        self.farmData = {}
      end
      for field, value in pairs(msg) do
        self.farmData[field] = value
      end
      if msg.level3 then
        self.storeLevel = msg.level3
      end
      if msg.level5 then
        self.tradeLevel = msg.level5
      end
      if msg.level6 then
        self.boxLevel = msg.level6
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Tower_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      if not self.towerData then
        self.towerData = {}
      end
      for field, value in pairs(msg) do
        self.towerData[field] = value
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Pvp_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      if not self.pvpInfo then
        self.pvpInfo = {}
      end
      for field, value in pairs(msg) do
        self.pvpInfo[field] = value
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Item_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      for itemId, count in pairs(msg) do
        if count <= 0 then
          self.items[itemId] = nil
        else
          self.items[itemId] = count
        end
      end
      self:setRedDirty("moon")
      self:setRedDirty("activity")
      self:setRedDirty("lty")
      self:dispatchEvent({
        name = "item_update",
        data = msg
      })
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Map_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      for _, mapInfo in ipairs(msg) do
        self.maps[mapInfo.mapId] = mapInfo
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_updateStoryBook], function(event)
      local msg = MsgPack.unpack(event.data)
      for _, story in pairs(msg) do
        local page = tostring(story.page)
        if not self.storyBook[page] then
          self.storyBook[page] = {}
        end
        if story.page == 6 or story.page == 7 then
          self.storyBook[page][story.id] = story.status
        else
          self.storyBook[page][tostring(story.id)] = story.status
        end
      end
      self:setRedDirty("story")
      self:setRedDirty("loverDay")
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_updateHeroBook], function(event)
      local msg = MsgPack.unpack(event.data)
      self.heroBook[tostring(msg.type)] = msg.status
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_notifyNewEvent], function(event)
      local msg = MsgPack.unpack(event.data)
      for name, value in pairs(msg.events) do
        if name == "collect" or name == "plant" then
          if CommonHelper.funcOpen("farm") then
            self.redPoints[name] = value == 1 and {value} or {}
          end
        elseif name == "box" then
          self.redPoints.box = value
        elseif name == "actItemC" then
          self.PTCount = value
          self:setRedDirty("activity")
        else
          self.redPoints[name] = value == 1 and {value} or {}
        end
        self:dispatchEvent({
          name = "notifyNewMessage",
          type = name
        })
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Equip_updateProperty], function(event)
      local equipInfo = MsgPack.unpack(event.data)
      if self.equips[equipInfo.id] then
        if equipInfo.bDel then
          self.equips[equipInfo.id] = nil
        else
          self.equips[equipInfo.id]:updateProperty(equipInfo)
        end
      else
        self.equips[equipInfo.id] = require("app.models.Equip"):create(equipInfo)
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Sauce_updateProperty], function(event)
      local sauceInfo = MsgPack.unpack(event.data)
      if self.sauces[sauceInfo.id] then
        if sauceInfo.bDel then
          self.sauces[sauceInfo.id] = nil
        else
          self.sauces[sauceInfo.id]:updateProperty(sauceInfo)
        end
      else
        self.sauces[sauceInfo.id] = require("app.models.Sauce"):create(sauceInfo)
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_chat], function(event)
      local msg = MsgPack.unpack(event.data)
      local informStr = UserData.informStr or ""
      if not (msg and next(msg)) or informStr:getv(msg.player.roleId, 0) ~= 0 then
        return
      end
      local roleId
      if msg.chatType == "world" then
        table.insert(self.worldChats, msg)
        table.sort(self.worldChats, function(a, b)
          return a.time < b.time
        end)
        if #self.worldChats > 60 then
          for i = 1, #self.worldChats - 60 do
            table.remove(self.worldChats, 1)
          end
        end
        self:dispatchEvent({
          name = "updateChat",
          newMsg = msg,
          chatType = msg.chatType,
          toRoleId = roleId
        })
        if msg.player.roleId == -1 then
          local copyData = clone(msg)
          copyData.chatType = "union"
          if (self.union or 0) == 0 or self.union ~= copyData.player.union then
            return
          end
          if #self.unionChats == 60 then
            table.remove(self.unionChats, 1)
          end
          table.insert(self.unionChats, copyData)
          table.sort(self.unionChats, function(a, b)
            return a.time < b.time
          end)
        end
      elseif msg.chatType == "union" then
        if (self.union or 0) == 0 or self.union ~= msg.player.union then
          return
        end
        if #self.unionChats == 60 then
          table.remove(self.unionChats, 1)
        end
        table.insert(self.unionChats, msg)
        table.sort(self.unionChats, function(a, b)
          return a.time < b.time
        end)
        self:dispatchEvent({
          name = "updateChat",
          newMsg = msg,
          chatType = msg.chatType,
          toRoleId = roleId
        })
      elseif msg.chatType == "cross" then
        table.insert(self.crossChats, msg)
        table.sort(self.crossChats, function(a, b)
          return a.time < b.time
        end)
        if 60 < #self.crossChats then
          for i = 1, #self.crossChats - 60 do
            table.remove(self.crossChats, 1)
          end
        end
        self:dispatchEvent({
          name = "updateChat",
          newMsg = msg,
          chatType = msg.chatType,
          toRoleId = roleId
        })
      elseif msg.chatType == "p2p" then
        roleId = msg.to == self.id and msg.player.roleId or msg.to
        if self.toChatRoleId == roleId then
          self.redPoints.p2pRedPoints[roleId] = 0
        else
          self.redPoints.p2pRedPoints[roleId] = (self.redPoints.p2pRedPoints[roleId] or 0) + 1
        end
        if not self.p2pChats[roleId] then
          self.p2pChats[roleId] = {}
        end
        if not self:checkP2pChatRoleId(roleId) then
          table.insert(self.p2pChatsIndex, roleId)
        end
        if #self.p2pChats[roleId] == 40 then
          table.remove(self.p2pChats[roleId], 1)
        end
        table.insert(self.p2pChats[roleId], msg)
        table.sort(self.p2pChats[roleId], function(a, b)
          return a.time < b.time
        end)
        table.sort(self.p2pChatsIndex, function(a, b)
          local factorA = next(self.p2pChats[a]) and self.p2pChats[a][#self.p2pChats[a]].time or 0
          local factorB = next(self.p2pChats[b]) and self.p2pChats[b][#self.p2pChats[b]].time or 0
          return factorA > factorB
        end)
        self:dispatchEvent({
          name = "updateChat",
          newMsg = msg,
          chatType = msg.chatType,
          toRoleId = roleId
        })
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Role_chatCrossServer], function(event)
      local msg = MsgPack.unpack(event.data)
      if not msg or not next(msg) then
        return
      end
      local newMsg = {}
      for _, data in pairs(msg) do
        if (UserData.informCrossStr or ""):getv(data.player.roleId, 0) == 0 then
          table.insert(self.crossChats, data)
          table.insert(newMsg, data)
        end
      end
      if not next(newMsg) then
        return
      end
      table.sort(self.crossChats, function(a, b)
        return a.time < b.time
      end)
      table.sort(newMsg, function(a, b)
        return a.time < b.time
      end)
      if 60 <= #newMsg then
        for i = 1, #newMsg - 60 do
          table.remove(newMsg, 1)
        end
      end
      if #self.crossChats >= 60 then
        for i = 1, #self.crossChats - 60 do
          table.remove(self.crossChats, 1)
        end
      end
      self:dispatchEvent({
        name = "updateChat",
        crossNewMsg = newMsg,
        chatType = "cross"
      })
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Friend_updateProperty], function(event)
      local msg = MsgPack.unpack(event.data)
      self.friendRed = self.friendRed or {}
      if msg.newFriend then
        self.friendRed.newFriend = 1
      end
      if msg.newApply then
        self.friendRed.newApply = 1
      end
      self:setRedDirty("friend")
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Diner_updateProperty], function(event)
      if not self.diner then
        return
      end
      local msg = MsgPack.unpack(event.data)
      for field, value in pairs(msg) do
        self.diner[field] = value
        local spos, epos, id = string.find(field, "diner(%d+)")
        if spos == 1 and epos == string.len(field) then
          local diner = json.decode(value) or {}
          if self.diner.diners[tonumber(id)] then
            self.diner.diners[tonumber(id)]:updateProperty(diner)
          else
            self.diner.diners[tonumber(id)] = require("app.models.Diner"):create(diner)
          end
        end
      end
      if msg.sellInfo then
        self:setRedDirty("diner")
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Diner_updateProperties], function(event)
      if not self.diner then
        return
      end
      local msg = MsgPack.unpack(event.data)
      for field, value in pairs(msg) do
        self.diner[field] = value
        local spos, epos, id = string.find(field, "diner(%d+)")
        if spos == 1 and epos == string.len(field) then
          local diner = json.decode(value) or {}
          if self.diner.diners[tonumber(id)] then
            self.diner.diners[tonumber(id)]:updateProperty(diner)
          else
            self.diner.diners[tonumber(id)] = require("app.models.Diner"):create(diner)
          end
        end
      end
      if msg.sellInfo then
        self:setRedDirty("diner")
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Diner_itemUpdateProperty], function(event)
      if not self.diner then
        return
      end
      local msg = MsgPack.unpack(event.data)
      local filed
      if msg.type == "car" then
        filed = "item_car"
      elseif msg.type == "fitment" then
        filed = "item_fitment"
      elseif msg.type == "box" then
        filed = "item_box"
      end
      if filed then
        if not self.diner[filed] then
          self.diner[filed] = {}
        end
        if msg.count <= 0 then
          self.diner[filed][msg.id] = nil
        else
          self.diner[filed][msg.id] = msg.count
        end
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Diner_accessoryUpdateProperty], function(event)
      if not self.diner then
        return
      end
      local accessoryInfo = MsgPack.unpack(event.data)
      if not self.diner.accessories then
        self.diner.accessories = {}
      end
      if self.diner.accessories[accessoryInfo.id] then
        if accessoryInfo.bDel then
          self.diner.accessories[accessoryInfo.id] = nil
        else
          for k, v in pairs(accessoryInfo) do
            self.diner.accessories[accessoryInfo.id][k] = v
          end
        end
      else
        self.diner.accessories[accessoryInfo.id] = accessoryInfo
      end
    end),
    NetManager:addEventListener(actionHandlers[actionCodes.Diner_talentUpdateProperty], function(event)
      self:initBoxTalent(MsgPack.unpack(event.data))
    end)
  }
end

function Role:checkP2pChatRoleId(roleId)
  for _, id in pairs(self.p2pChatsIndex) do
    if id == roleId then
      return true
    end
  end
  return false
end

function Role:reset()
  self:removeAllEventListeners()
  for _, handler in ipairs(self.eventListeners) do
    game:removeEventListener(handler)
  end
end

function Role:canShowFunctionGuide(carbonId)
  if self.skipGuideCount < 3 and self.carbons[carbonId] and self.carbons[carbonId].starNum > 0 then
    local openData = FunctionOpenCsv[carbonId]
    if openData and openData.guideId and 0 < openData.guideId then
      local savedData = self.activeGuide[tostring(openData.guideId)]
      if savedData and 0 < tonumber(savedData) then
        return false
      else
        return openData
      end
    end
  end
  return false
end

function Role:initRedPoint()
  local fields = {
    "mission",
    "kitchen",
    "progress",
    "trade",
    "activity",
    "plant",
    "collect",
    "email",
    "sign",
    "achieve",
    "friend",
    "moon",
    "halloween",
    "diner",
    "lty",
    "christmas",
    "taptap",
    "loverDay",
    "newyear",
    "p2pRedPoints",
    "palace",
    "oneyear",
    "firstday",
    "general1",
    "general2",
    "lucky",
    "mysteryBoxHome",
    "mysteryBox",
    "topDiner",
    "unionBattle",
    "pass"
  }
  local checkField = {}
  for _, field in pairs(fields) do
    self.redPoints[field] = {}
  end
  for _, field in pairs(fields) do
    self:checkRedPoint(field)
  end
end

function Role:checkRedPoint(field, value)
  local check = {
    mission = function()
      self.redPoints.mission = {}
      for index, data in ipairs(MissionCsv) do
        local carbon = self.carbons[data.condition1]
        if carbon and carbon.task:getv(data.condition2, 0) == 0 and data.condition2 <= carbon.starNum then
          self.redPoints.mission.main = true
          break
        end
      end
      for type, cur in pairs(self.dailyTaskStatusNew:toNumMap()) do
        local data
        if 1000 <= type then
          data = RandomTaskCsv[1][type]
        else
          data = LoopCsv[1][type]
        end
        if data then
          local all = data.condition2 ~= 0 and data.condition2 or data.condition1
          if cur >= all then
            self.redPoints.mission.daily = true
            break
          end
        end
      end
      for type, cur in pairs(self.weekTaskStatusNew:toNumMap()) do
        local data
        if 1000 <= type then
          data = RandomTaskCsv[2][type]
        else
          data = LoopCsv[2][type]
        end
        local all = data.condition2 ~= 0 and data.condition2 or data.condition1
        if cur >= all then
          self.redPoints.mission.week = true
          break
        end
      end
      for heroId, cur in pairs(self.loveTaskNew:toNumMap()) do
        local hero = self.heros[heroId]
        if hero and hero.loveBreak < 4 then
          local loveData = LoveCsv[hero.type][hero.loveBreak]
          local all = loveData.condition2 ~= 0 and loveData.condition2 or loveData.condition1
          if cur >= all then
            self.redPoints.mission.love = true
            break
          end
        end
      end
    end,
    story = function()
      self.redPoints.story = {}
      for type, stories in pairs(self.storyBook) do
        if type == "6" or type == "7" then
          for _, state in pairs(stories) do
            if state == 0 then
              self.redPoints.story[tonumber(type)] = true
              break
            end
          end
        else
          for _, story in pairs(stories) do
            if story.check == 0 then
              self.redPoints.story[tonumber(type)] = true
              break
            end
          end
        end
      end
    end,
    kitchen = function()
      self.redPoints.kitchen = {}
      local time = game:nowTime()
      for _, data in pairs(self.buildListJson or {}) do
        if time > data.time then
          self.redPoints.kitchen[2] = true
        end
      end
    end,
    progress = function()
      self.redPoints.progress = {}
      local time = self.progressTime
      time = time == 0 and game:nowTime() or time
      if self.progress + (game:nowTime() - time) / (60 * globalCsv.ghostPowerSpeed) >= 100 then
        self.redPoints.progress = {1}
      end
    end,
    mysteryBoxHome = function()
      self.redPoints.mysteryBoxHome = {}
      if not self.activityStatus["84"] then
        return
      end
      local curStatus = self.activityStatus["84"]
      if curStatus.freeCount == 1 or curStatus.recharge1 and curStatus.recharge1 - curStatus.drawCount1 > 0 or curStatus.recharge2 and 0 < curStatus.recharge2 - curStatus.drawCount2 or curStatus.recharge3 and 0 < curStatus.recharge3 - curStatus.drawCount3 or curStatus.recharge4 and 0 < curStatus.recharge4 - curStatus.drawCount4 then
        self.redPoints.mysteryBoxHome = {}
      else
        self.redPoints.mysteryBoxHome = {}
      end
    end,
    mysteryBox = function()
      self.redPoints.mysteryBox = {
        ["1"] = false,
        ["2"] = false,
        ["3"] = false,
        ["4"] = false
      }
      if not self.activityStatus["84"] then
        return
      end
      local curStatus = self.activityStatus["84"]
      for i = 1, 4 do
        if curStatus["recharge" .. i] - curStatus["drawCount" .. i] > 0 then
          self.redPoints.mysteryBox["" .. i] = false
        else
          self.redPoints.mysteryBox["" .. i] = false
        end
      end
      if curStatus.freeCount == 1 then
        self.redPoints.mysteryBox["1"] = false
      end
    end,
    activity = function()
      self.redPoints.activity = {}
      local temp = json.decode(self.activityBackStatus) or {}
      local exist = {}
      for type, data in pairs(temp) do
        if data.red and type ~= "21" and type ~= "89" and type ~= "90" then
          self.redPoints.activity[type] = true
        else
          exist[tonumber(type)] = 1
        end
      end
      if exist[1] then
        for _, data in pairs(LevelCsv) do
          local state = self.activityStatus["1"]:getv(data.id, 0)
          if state ~= -1 and self.level >= data.level then
            self.redPoints.activity["1"] = true
            break
          end
        end
      end
      if exist[2] then
        local state = self.activityStatus["2"]:getv(1, 0)
        if state == 1 then
          self.redPoints.activity["2"] = true
        end
      end
      if exist[3] then
        for _, data in ipairs(RechargeCsv) do
          local curNum = self.activityStatus["3"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.money then
            self.redPoints.activity["3"] = true
            break
          end
        end
      end
      if exist[4] then
        for _, data in ipairs(ActivityLogingiftCsv) do
          local curNum = self.activityStatus["4"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["4"] = true
            break
          end
        end
      end
      local openDays = self.openDays + 1
      if exist[5] then
        for _, data in ipairs(AMissionCsv) do
          local curNum = self.activityStatus["5"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.conditon and openDays >= data.unlock then
            self.redPoints.activity["5"] = true
            break
          end
        end
      end
      if exist[10] and 0 < self.activityStatus["10"].free then
        self.redPoints.activity["10"] = true
      end
      if exist[13] then
        local status1 = self.activityStatus["13"]["1"]
        for _, data in ipairs(SpeicalMCsv[1]) do
          local curNum = status1:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.condition1 then
            self.redPoints.activity["13"] = true
            break
          end
        end
        local status2 = self.activityStatus["13"]["2"]
        for _, data in ipairs(SpeicalMCsv[2]) do
          local curNum = status2:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.condition1 then
            self.redPoints.activity["13"] = true
            break
          end
        end
      end
      if exist[14] then
        local status = self.activityStatus["14"]
        local finishNum = 0
        if status:getv(0, 0) ~= -1 then
          for _, data in ipairs(HeroMCsv) do
            local curNum = status:getv(data.id, -10)
            if 0 <= curNum then
              curNum = data.type == 0 and status:getv(0, 0) or curNum
              if curNum >= data.condition1 then
                self.redPoints.activity["14"] = true
                break
              end
            end
            if curNum == -1 then
              finishNum = finishNum + 1
            end
          end
          if finishNum == #HeroMCsv then
            self.redPoints.activity["14"] = true
          end
        end
      end
      if exist[15] then
        local data = self.activityStatus["15"]
        for _, status in pairs(data.status:toNumMap()) do
          if status == 1 then
            self.redPoints.activity["15"] = true
            break
          end
        end
      end
      if exist[23] then
        local data = self.activityStatus["23"]
        if data.energy >= 100 then
          self.redPoints.activity["23"] = true
          return
        end
        if data.task ~= "no" and data.task ~= "empty" then
          local info = data.task:toArray("=", true)
          local taskData = MagicTaskCsv[info[1]]
          if info[2] >= taskData.condition1 then
            self.redPoints.activity["23"] = true
          end
        end
      end
      if exist[26] then
        local count = self.activityStatus["26"] or 0
        local heroMinimum = globalCsv.heroMinimum:toArray("=", true)
        if count >= heroMinimum[2] then
          self.redPoints.activity["26"] = true
        end
      end
      if exist[27] and self.activityStatus["27"] == 1 then
        self.redPoints.activity["27"] = true
      end
      if exist[28] then
        for _, data in ipairs(LoginCsv) do
          local curNum = self.activityStatus["28"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["28"] = true
            break
          end
        end
      end
      if exist[33] then
        for _, data in pairs(InviteCsv) do
          local curNum = self.activityStatus["33"]:getv(data.id, 0)
          if curNum ~= -1 and self.inviteCount >= data.condition then
            self.redPoints.activity["33"] = true
            break
          end
        end
      end
      if exist[35] then
        local data = self.activityStatus["35"]
        if data.energy >= 100 then
          self.redPoints.activity["35"] = true
          return
        end
        if data.task ~= "no" and data.task ~= "empty" then
          local info = data.task:toArray("=", true)
          local taskData = MagicTaskCsv[info[1]]
          if info[2] >= taskData.condition1 then
            self.redPoints.activity["35"] = true
          end
        end
      end
      if exist[40] then
        local set = globalCsv.ActivitySpecialCook:toArray("=", true)
        local status = self.activityStatus["40"] or ""
        local cookNum = status:getv(0, 0)
        local gotCount = status:getv(1, 0)
        local tempCount = 0
        if cookNum >= set[2] then
          cookNum = cookNum - set[2]
          tempCount = 1
          if 0 < cookNum then
            tempCount = tempCount + math.floor(cookNum / set[3])
          end
        end
        if gotCount < tempCount then
          self.redPoints.activity["40"] = true
        end
      end
      if exist[104] then
        local set = globalCsv.ActivitySpecialCookDream:toArray("=", true)
        local status = self.activityStatus["104"] or ""
        local cookNum = status:getv(0, 0)
        local gotCount = status:getv(1, 0)
        local tempCount = 0
        if cookNum >= set[2] then
          cookNum = cookNum - set[2]
          tempCount = 1
          if 0 < cookNum then
            tempCount = tempCount + math.floor(cookNum / set[3])
          end
        end
        if gotCount < tempCount then
          self.redPoints.activity["104"] = true
        end
      end
      if exist[43] then
        for _, data in pairs(NewRechargeCsv) do
          local curNum = self.activityStatus["43"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.money then
            self.redPoints.activity["43"] = true
            break
          end
        end
      end
      if exist[45] then
        local cur = self.achievementTypeStatus:getv(47, 0)
        for _, data in pairs(MarryCsv) do
          local status = self.activityStatus["45"]:getv(data.id, 0)
          if status ~= -1 and cur >= data.count then
            self.redPoints.activity["45"] = true
          end
        end
      end
      if exist[47] then
        for _, data in ipairs(YearLoginCsv) do
          local curNum = self.activityStatus["47"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["47"] = true
            break
          end
        end
      end
      if exist[103] then
        for _, data in ipairs(YearLogin103Csv) do
          local curNum = self.activityStatus["103"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["103"] = true
            break
          end
        end
      end
      if exist[51] then
        for _, data in ipairs(SauceLoginCsv) do
          local curNum = self.activityStatus["51"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["51"] = true
            break
          end
        end
      end
      if exist[62] then
        for group, Csv in pairs(AFormationCsv) do
          if self.activityStatus["62"]:getv(group * 100, 0) > #Csv then
            self.redPoints.activity["62"] = true
            break
          end
          for _, data in ipairs(Csv) do
            if 0 < self.activityStatus["62"]:getv(group * 100 + data.id, 0) then
              self.redPoints.activity["62"] = true
              break
            end
          end
        end
      end
      if exist[65] then
        local status = self.activityStatus["65"] or ""
        for _, data in pairs(CollectHeroCsv) do
          if status:getv(data.id, 0) >= data.condition then
            self.redPoints.activity["65"] = true
            break
          end
        end
      end
      if exist[67] then
        for line, Set in pairs(PTRankCsv) do
          for index, data in pairs(Set) do
            if line == 1 and (self.items[30100] or 0) > data.condition and (self.activityStatus["67"]:getv(line * 1000 + data.id, 0) or 0) ~= -1 then
              self.redPoints.activity["67"] = true
              break
            end
          end
        end
      end
      if exist[70] then
        local status = self.activityStatus["70"] or ""
        local taskDataList = status.taskStr:toNumMap()
        if status.inviter ~= 0 then
          if (taskDataList[1] or 0) ~= -1 then
            self.redPoints.activity["70"] = true
          else
            for i, taskdata in ipairs(taskDataList) do
              if (taskdata or 0) >= InviteTaskCsv[i].condition1 then
                self.redPoints.activity["70"] = true
                break
              end
            end
          end
        end
        local rewardList = status.rewardStr:toNumMap()
        for i = 1, 3 do
          if i <= game.role.inviterCount and not rewardList[i] then
            self.redPoints.activity["70"] = true
            break
          end
        end
      end
      if exist[72] then
        for _, data in pairs(TotalRechargeCsv) do
          local curNum = self.activityStatus["72"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.money then
            self.redPoints.activity["72"] = true
            break
          end
        end
      end
      if exist[74] then
        local ActivityData = self.activityStatus["74"]
        for _, data in pairs(CollectExtraStarCsv) do
          if data.id < 100 then
            if ActivityData.gainCount >= data.condition and ActivityData.rewardStr:getv(data.id, 0) ~= -1 then
              self.redPoints.activity["74"] = true
              break
            end
          elseif ActivityData.dayGain == 0 then
            self.redPoints.activity["74"] = true
            break
          end
        end
      end
      if exist[79] then
        local isRed = ChapterPassManager:checkRedPoint()
        if isRed then
          self.redPoints.activity["79"] = true
        end
      end
      if exist[80] then
        local activity = self.activityStatus["80"] or {}
        local passedCount = activity.passedCount or 0
        local getedRewardStr = activity.getedReward or ""
        for k, data in ipairs(Activity_80_taskCsv) do
          local passed = passedCount >= data.condition
          if passed then
            local geted = 0 < getedRewardStr:getv(data.id, 0)
            if not geted then
              self.redPoints.activity["80"] = true
              break
            end
          end
        end
        if activity.finalBox == "1" then
        else
          local isTimeUp = game:nowTime() >= globalCsv.Activity80GiftTime
          local LastTarget = Activity_80_taskCsv[7].condition
          local passedCount = activity.finalPassedCount or -1
          if passedCount < 0 then
            passedCount = activity.passedCount
          end
          if isTimeUp and LastTarget <= passedCount then
            self.redPoints.activity["80"] = true
          end
        end
      end
      if exist[81] then
        for _, data in pairs(MonthLoginGiftCsv) do
          local curNum = self.activityStatus["81"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["81"] = true
            break
          end
        end
      end
      if exist[82] then
        for _, data in pairs(CostDiamondCsv) do
          local curNum = self.activityStatus["82"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.cost then
            self.redPoints.activity["82"] = true
            break
          end
        end
      end
      if exist[83] and ActivityManager.CheckActivity83Red() then
        self.redPoints.activity["83"] = true
      end
      if exist[86] then
        if not self.activityStatus["86"] then
          return
        end
        local cur = self.activityStatus["86"].num or 0
        for index, data in ipairs(Marry86Csv) do
          local status = self.activityStatus["86"].status and self.activityStatus["86"].status:getv(data.id, 0) or 0
          if status ~= -1 and cur >= data.count then
            self.redPoints.activity["86"] = true
            break
          end
        end
      end
      if exist[88] then
        for _, data in ipairs(Login88Csv) do
          local curNum = self.activityStatus["88"]:getv(data.id, 0)
          if curNum ~= -1 and curNum >= data.day then
            self.redPoints.activity["88"] = true
            break
          end
        end
      end
      if exist[92] then
        for _, data in ipairs(Activity92Csv) do
          local curstatus = self.activityStatus["92"] or {}
          local curId = curstatus.id or 0
          local curCount = curstatus.count or 0
          if curId < data.id and curCount >= data.condition then
            self.redPoints.activity["92"] = true
            break
          end
        end
      end
      if exist[95] then
        local isRed = Activity95Manager:checkRedPoint()
        if isRed then
          self.redPoints.activity["95"] = true
        end
      end
    end,
    trade = function()
      self.redPoints.trade = {}
      if self.tradeBuyNew then
        self.redPoints.trade = {1}
      end
    end,
    plant = function()
      if not self.farmData or not self.farmData.buildList then
        return
      end
      local now = game:nowTime()
      for _, data in pairs(json.decode(self.farmData.buildList) or {}) do
        if data.time and now > data.time then
          self.redPoints.plant = {1}
          return
        end
      end
      self.redPoints.plant = {}
    end,
    collect = function()
      if not self.farmData or not self.farmData.lastUpdateTime then
        return
      end
      for type = 1, 4 do
        local isFull = self:drawMaterial(type)
        if isFull == 1 then
          return
        end
      end
      self.redPoints.collect = {}
    end,
    email = function()
      if not self.mails then
        return
      end
      for _, mail in ipairs(self.mails) do
        if mail.status == 0 then
          self.redPoints.email = {1}
          return
        end
      end
      self.redPoints.email = {}
    end,
    sign = function()
      self.redPoints.sign = {}
      local time = game:nowTime()
      local tm = CommonHelper.date()
      local Set = MonthGiftCsv[tm.month] or {}
      local sign = json.decode(self.sign)
      local days = 0
      for _, v in pairs(sign) do
        if v == tm.month then
          days = days + 1
        end
      end
      for _, data in pairs(Set) do
        local cur = self.signStatus:getv(data.id, 0)
        if cur ~= -1 and days >= data.days then
          self.redPoints.sign = {1}
          break
        end
      end
    end,
    achieve = function()
      local redType = {
        "carbon",
        "collectH",
        "growH",
        "collectE",
        "growE",
        "love",
        "source",
        "sell",
        "tree",
        "sauce",
        "awake",
        "dream"
      }
      self.redPoints.achieve = {}
      for _, data in pairs(AchieveCsv) do
        if data.id < 10000 then
          local cur = self.missionTaskStatus:getv(data.id, 0)
          local all = data.condition1
          if cur ~= -1 and all <= self.achievementTypeStatus:getv(data.type, 0) then
            self.redPoints.achieve[redType[data.flag]] = true
          end
        end
      end
    end,
    friend = function()
      self.redPoints.friend = {}
      self.friendRed = self.friendRed or {}
      if self.friendRed.newFriend then
        self.redPoints.friend.newFriend = true
      end
      if self.friendRed.newApply then
        self.redPoints.friend.newApply = true
      end
    end,
    moon = function()
      self.redPoints.moon = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["16"] then
        return
      end
      for id, data in pairs(MoonGiftCsv) do
        if self.midAutAreaTask:getv(id, 0) > -1 and self.midBattleCount:getv(data.unlockLevel, 0) >= data.conditon then
          self.redPoints.moon.carbonGift = self.redPoints.moon.carbonGift or {}
          self.redPoints.moon.carbonGift[data.unlockLevel] = true
        end
      end
      for index, count in pairs(self.midAutDailyTask:toNumMap()) do
        local csvData = (MoonTaskCsv[math.floor(index / 1000)] or {})[index % 1000]
        if csvData then
          if csvData.type == 103 and count ~= -1 then
            count = self.items[17] or 0
          end
          if count >= csvData.condition1 then
            self.redPoints.moon.task = true
            break
          end
        end
      end
      for phase, group in pairs(MoonScoreCsv) do
        if self.redPoints.moon.score then
          break
        end
        for id, data in pairs(group) do
          if game:nowTime() < CommonHelper.toUnixtime(data.openTime .. string.format("%02x", RESET_TIME)) then
            break
          end
          if self.midAutScoreGift:getv(phase * 1000 + id, 0) ~= -1 and (self.items[17] or 0) >= data.condition then
            self.redPoints.moon.score = true
            break
          end
        end
      end
    end,
    halloween = function()
      self.redPoints.halloween = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["21"] or not self.activityStatus["21"] then
        return
      end
      for index, count in pairs(self.activityStatus["21"].taskStatus:toNumMap()) do
        local csvData = (HalloweenTaskCsv[math.floor(index / 1000)] or {})[index % 1000]
        if csvData and count >= csvData.condition1 then
          self.redPoints.halloween.task1 = true
          break
        end
      end
      for index, count in pairs(self.activityStatus["21"].otherTask:toNumMap()) do
        local csvData = (HalloweenTaskCsv[math.floor(index / 1000)] or {})[index % 1000]
        if csvData and count >= csvData.condition1 then
          self.redPoints.halloween.task2 = true
          break
        end
      end
      if not self.redPoints.halloween.task2 then
        local goalCount = self.activityStatus["21"].goalTask:getv(0, 0)
        for index, data in pairs(HalloweenGoalTaskCsv) do
          if goalCount >= data.condition and self.activityStatus["21"].goalTask:getv(index, 0) ~= -1 then
            self.redPoints.halloween.task2 = true
          end
        end
      end
    end,
    topDiner = function()
      self.redPoints.topDiner = {}
      local curStatus = self.activityStatus["85"]
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["85"] or not curStatus then
        return
      end
      for index, count in pairs(curStatus.taskStatus:toNumMap()) do
        local csvData = (Activity_85_taskCsv[math.floor(index / 1000)] or {})[index % 1000]
        if csvData and count >= csvData.condition1 then
          self.redPoints.topDiner.task = true
          break
        end
      end
      local point = curStatus.curPoint == #Activity_85_rewardCsv and curStatus.curPoint or curStatus.curPoint + 1
      local num = self.items[globalCsv.topDinerItemId] or 0
      if num >= Activity_85_rewardCsv[point].condition then
        self.redPoints.topDiner.road = true
      end
    end,
    unionBattle = function()
      self.redPoints.unionBattle = {}
      local curStatus = self.activityStatus["89"]
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["89"] or not curStatus then
        return
      end
      local show = false
      local activityStatus = game.role.activityStatus["89"]
      local winCount = activityStatus.win_count or 0
      local battleCount = activityStatus.battle_count or 0
      local reward_record = activityStatus.reward_record or {}
      local generalDatas = unionBattleRewardCsv[1]
      local winDatas = unionBattleRewardCsv[2]
      local unionDatas = unionBattleRewardCsv[3]
      for idx, data in ipairs(generalDatas) do
        local done = next(reward_record) and reward_record[tostring(100 + data.rewardId)]
        local canGet = battleCount >= data.condition
        if not done and canGet then
          self.redPoints.unionBattle.reward = true
          show = true
          break
        end
      end
      if not show then
        for idx, data in ipairs(winDatas) do
          local done = next(reward_record) and reward_record[tostring(200 + data.rewardId)]
          local canGet = winCount >= data.condition
          if not done and canGet then
            self.redPoints.unionBattle.reward = true
            show = true
            break
          end
        end
      end
    end,
    diner = function()
      if not self.diner then
        return
      end
      for k, sellInfo in pairs(json.decode(self.diner.sellInfo).sell or {}) do
        if sellInfo.time and sellInfo.time > 0 and game:nowTime() >= sellInfo.time then
          self.redPoints.diner = {1}
          return
        end
      end
      self.redPoints.diner = {}
    end,
    lty = function()
      self.redPoints.lty = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["29"] or not self.activityStatus["29"] then
        return
      end
      local num1 = self.items[166] or 0
      local num2 = self.items[167] or 0
      for _, data in pairs(LtyGiftCsv) do
        local res = self.ltyScoreGift:getv(data.id, 0) == 0
        local extra = true
        if data.condition2 and data.condition2 ~= "" then
          local need = data.condition2:toArray("=", true)
          extra = (game.role.items[need[1]] or 0) >= need[2]
        end
        if data.type == 1 and num1 >= data.condition and res and extra then
          self.redPoints.lty = {1}
          break
        else
          if data.type == 2 and num2 >= data.condition and res and extra then
            self.redPoints.lty = {1}
            break
          else
          end
        end
      end
    end,
    christmas = function()
      self.redPoints.christmas = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["31"] or not self.activityStatus["31"] then
        return
      end
      for _, data in pairs(MoonTaskCsv) do
        if game.role.midAutAreaTask:getv(data.id, 0) >= data.condition1 then
          self.redPoints.christmas.taskNormal = true
          break
        end
      end
    end,
    taptap = function()
      self.redPoints.taptap = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["36"] or not self.activityStatus["36"] then
        return
      end
      local info = self.activityStatus["36"]
      for _, data in pairs(TapDailyCsv[info.dailyTime]) do
        local cur = info.dailyTask:getv(data.id, 0)
        if cur >= data.condition1 then
          self.redPoints.taptap.daily = 1
          break
        end
      end
      local all = info.goalTask:getv(0, 0)
      for _, data in pairs(TapGoalCsv[info.goalTime]) do
        local cur = info.goalTask:getv(data.id, 0)
        if cur ~= -1 and all >= data.conditon then
          self.redPoints.taptap.goal = 1
          break
        end
      end
    end,
    loverDay = function()
      self.redPoints.loverDay = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["37"] or not self.activityStatus["37"] then
        return
      end
      local status = self.storyBook["7"] or {}
      for _, state in pairs(status) do
        if state == 0 then
          self.redPoints.loverDay.story = 1
          break
        end
      end
    end,
    newyear = function()
      self.redPoints.newyear = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["38"] or not self.activityStatus["38"] then
        return
      end
      for _, data in pairs(NewYearGiftCsv) do
        local cur = self.midBattleCount:getv(data.level * 10 + 3, 0)
        if 0 < cur and self.midAutAreaTask:getv(data.level, 0) ~= -1 then
          self.redPoints.newyear.chapter = 1
          break
        end
      end
      for _, data in pairs(MoonTaskCsv) do
        local cur = self.midAutScoreGift:getv(data.id, 0)
        if cur ~= -1 and cur >= data.condition1 then
          self.redPoints.newyear.task = 1
          break
        end
      end
    end,
    palace = function()
      self.redPoints.palace = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["42"] or not self.activityStatus["42"] then
        return
      end
    end,
    oneyear = function()
      self.redPoints.oneyear = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["48"] or not self.activityStatus["48"] then
        return
      end
      for _, data in pairs(NewYearGiftCsv) do
        local cur = self.midBattleCount:getv(data.level * 10 + 3, 0)
        if 0 < cur and self.midAutAreaTask:getv(data.level, 0) ~= -1 then
          self.redPoints.oneyear.carbon = 1
          break
        end
      end
      local status = self.activityStatus["48"].status or ""
      for _, data in pairs(MoonTaskCsv) do
        local cur = status:getv(data.id, 0)
        if cur ~= -1 and cur >= data.condition1 then
          if not self.redPoints.oneyear.task then
            self.redPoints.oneyear.task = {}
          end
          self.redPoints.oneyear.task[data.opentime] = 1
        end
      end
      status = game.role.activityStatus["48"].gift or ""
      for phase, group in pairs(MoonScoreCsv) do
        for id, data in pairs(group) do
          if status:getv(data.phase * 1000 + data.id, 0) ~= -1 and (self.items[69] or 0) >= data.condition then
            self.redPoints.oneyear.score = 1
            break
          end
        end
      end
    end,
    firstday = function()
      self.redPoints.firstday = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["54"] or not self.activityStatus["54"] then
        return
      end
      for _, data in pairs(FirstDayTaskCsv) do
        if game.role.midAutAreaTask:getv(data.id, 0) >= data.condition1 then
          self.redPoints.firstday.task = true
          break
        end
      end
    end,
    general1 = function()
      self.redPoints.general1 = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["58"] or not self.activityStatus["58"] then
        return
      end
      for index, count in pairs(self.midAutDailyTask:toNumMap()) do
        local csvData = (MoonTaskCsv[math.floor(index / 1000)] or {})[index % 1000]
        if csvData and count >= csvData.condition1 then
          self.redPoints.general1.task = true
          break
        end
      end
    end,
    general2 = function()
      self.redPoints.general2 = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["60"] or not self.activityStatus["60"] then
        return
      end
      local status1 = self.activityStatus["60"]["1"]
      for _, data in ipairs(SpeicalMCsv[1]) do
        local curNum = status1:getv(data.id, 0)
        if curNum ~= -1 and curNum >= data.condition1 then
          self.redPoints.general2 = {1}
          return
        end
      end
      local status2 = self.activityStatus["60"]["2"]
      for _, data in ipairs(SpeicalMCsv[2]) do
        local curNum = status2:getv(data.id, 0)
        if curNum ~= -1 and curNum >= data.condition1 then
          self.redPoints.general2 = {1}
          return
        end
      end
    end,
    lucky = function()
      self.redPoints.lucky = {}
      local temp = json.decode(self.activityBackStatus) or {}
      if not temp["61"] or not self.activityStatus["61"] then
        return
      end
      local status = self.activityStatus["61"]
      local done = true
      for _, group in pairs(ALuckyCsv) do
        for _, data in pairs(group) do
          local count = status:getv(data.period * 100 + data.task, 0)
          if count ~= -1 and count >= data.condition1 then
            local pre = data.period - 1
            if (data.period == 1 or status:getv(pre * 100 + #ALuckyCsv[pre], 0) == -1) and (data.task == 1 or status:getv(data.period * 100 + data.task - 1, 0) == -1) then
              self.redPoints.lucky[data.period] = 1
            end
          end
          if count ~= -1 then
            done = false
          end
        end
      end
      if done and status:getv(0, 0) ~= -1 then
        self.redPoints.lucky[0] = 1
      end
    end,
    pass = function()
      self.redPoints.pass = {}
      local curStatus63 = self.activityStatus["63"]
      local curStatus91 = self.activityStatus["91"]
      local curStatus93 = self.activityStatus["93"]
      if not curStatus63 and not curStatus91 and not curStatus93 then
        return
      end
      if curStatus63 and self:activityIsOpen(63) then
        for _, data in pairs(PassRewardCsv) do
          if curStatus63.reward:getv(data.id, 0) ~= -1 and data.reward ~= "" and curStatus63.level >= data.level and (data.need == 0 or curStatus63.reward:getv(0, 0) == -1) then
            self.redPoints.pass[1] = true
            return
          end
        end
      end
      if curStatus91 and self:activityIsOpen(91) then
        for _, data in pairs(DiamondfundRewardCsv) do
          if curStatus91.reward:getv(data.id, 0) ~= -1 and data.reward ~= "" and curStatus91.level >= data.level and (data.need == 0 or curStatus91.status == 1) then
            self.redPoints.pass[2] = true
            return
          end
        end
      end
      if curStatus93 and self:activityIsOpen(93) then
        for _, data in pairs(RouGeRewardCsv) do
          if curStatus93.reward:getv(data.id, 0) ~= -1 and data.reward ~= "" and curStatus93.level >= data.level and (data.need == 0 or curStatus93.status == 1) then
            self.redPoints.pass[3] = true
            return
          end
        end
      end
      self.redPoints.pass = {}
    end
  }
  if not check[field] then
    return
  end
  check[field]()
  self:dispatchEvent({
    name = "notifyNewMessage",
    type = field
  })
end

function Role:activityIsOpen(type)
  type = tonumber(type or 0) or 0
  local openActivity = json.decode(self.activityBackStatus) or {}
  return openActivity[tostring(type)]
end

function Role:carbonActivityIsOpen()
  local activityTypes = {
    "16",
    "31",
    "38",
    "42",
    "49",
    "54",
    "58"
  }
  local openActivity = json.decode(self.activityBackStatus) or {}
  for _, activityType in ipairs(activityTypes) do
    if openActivity[activityType] then
      return true
    end
  end
  return false
end

function Role:setRedDirty(field)
  self.redDirty[field] = true
end

function Role:set_exp(value)
  local old = self.exp
  self.exp = value
  self:dispatchEvent({
    name = "set_exp",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_level(value)
  local old = self.level
  self.level = value
  self:dispatchEvent({
    name = "set_level",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_material1(value)
  local old = self.material1
  self.material1 = value
  self:dispatchEvent({
    name = "set_material1",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_material2(value)
  local old = self.material2
  self.material2 = value
  self:dispatchEvent({
    name = "set_material2",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_material3(value)
  local old = self.material3
  self.material3 = value
  self:dispatchEvent({
    name = "set_material3",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_material4(value)
  local old = self.material4
  self.material4 = value
  self:dispatchEvent({
    name = "set_material4",
    oldValue = old,
    newValue = math.floor(value)
  })
end

function Role:set_progress(value)
  self.progress = value
  self:setRedDirty("progress")
end

function Role:set_buildListJson(value)
  self.buildListJson = json.decode(value)
  self:setRedDirty("kitchen")
end

function Role:set_tradeBuyStatus(value)
  local new = json.decode(value)
  local old = json.decode(self.tradeBuyStatus)
  for slot, data in ipairs(new) do
    if next(data) and not next(old[slot]) and CommonHelper.funcOpen("farm") then
      self.tradeBuyNew = true
      self:setRedDirty("trade")
      break
    end
  end
  self.tradeBuyStatus = value
end

function Role:set_signStatus(value)
  self.signStatus = value
  self:setRedDirty("sign")
end

function Role:set_missionTaskStatus(value)
  self.missionTaskStatus = value
  self:setRedDirty("achieve")
end

function Role:set_achievementTypeStatus(value)
  self.achievementTypeStatus = value
  self:setRedDirty("achieve")
end

function Role:set_level(...)
  local origLevel = self.level
  local level = select(1, ...)
  local oldHealth = select(3, ...)
  self.level = level
  umeng.setUserLevel(self.level)
  self:dispatchEvent({name = "set_level", newValue = level})
  self:setRedDirty("activity")
  sdkInterface:dispatchEvent({
    name = "noticeSdkEvent",
    eventName = "roleLevel",
    roleName = game.role.name,
    roleId = game.role.id,
    roleLevel = game.role.level,
    cumulCharge = game.role.cumulCharge,
    createTime = game.role.createTime,
    serverId = game.serverInfo.serverId,
    serverName = game.serverInfo.name
  })
end

function Role:set_guide(str)
  self.guide = str
  local master, slave = string.match(self.guide, "(%d+)=(%d+)")
  self.majorGuideStep = tonumber(master)
  self.minorGuideStep = 1
end

function Role:set_activeGuide(guideJson)
  self.activeGuideJson = guideJson
  self.activeGuide = json.decode(self.activeGuideJson) or {}
end

function Role:set_formationJson(value)
  self.formationJson = value
  self.formation = json.decode(self.formationJson)
  self:dispatchEvent({
    name = "set_formationJson",
    newValue = value
  })
end

function Role:set_dailyTaskStatusNew(value)
  self.dailyTaskStatusNew = value
  self:setRedDirty("mission")
end

function Role:set_weekTaskStatusNew(value)
  self.weekTaskStatusNew = value
  self:setRedDirty("mission")
end

function Role:set_loveTaskNew(value)
  self.loveTaskNew = value
  self:setRedDirty("mission")
end

function Role:set_ltyScoreGift(value)
  self.ltyScoreGift = value
  self:setRedDirty("lty")
end

function Role:set_dressBook_x(value)
  self.dressBook[value] = 1
end

function Role:set_battleInfo(value)
  self.battleInfo = value
  self.carbonBattle = json.decode(self.battleInfo)
end

function Role:set_autoBattleInfo(value)
  self.autoBattleInfo = value
  self.autoBattle = json.decode(self.autoBattleInfo)
end

function Role:set_paradiseBattleInfo(value)
  self.paradiseBattleInfo = value
  self.paradiseBattle = json.decode(self.paradiseBattleInfo)
end

function Role:set_moonBattleInfo(value)
  self.moonBattleInfo = value
  self.moonBattle = json.decode(self.moonBattleInfo)
end

function Role:set_activityStatus(value)
  self.activityStatus = json.decode(value)
  self:checkActivityCarbonRed()
end

function Role:set_activityBackStatus(value)
  self.activityBackStatus = value
  self:checkActivityCarbonRed()
  self:dispatchEvent({
    name = "set_activityBackStatus",
    newValue = value
  })
end

function Role:set_midAutAreaTask(value)
  self.midAutAreaTask = value
  self:checkActivityCarbonRed()
end

function Role:set_midAutDailyTask(value)
  self.midAutDailyTask = value
  self:checkActivityCarbonRed()
end

function Role:set_midAutScoreGift(value)
  self.midAutScoreGift = value
  self:checkActivityCarbonRed()
end

function Role:set_midBattleCount(value)
  self.midBattleCount = value
  self:checkActivityCarbonRed()
end

function Role:checkActivityCarbonRed()
  self:setRedDirty("moon")
  self:setRedDirty("newyear")
  self:setRedDirty("christmas")
  self:setRedDirty("palace")
  self:setRedDirty("oneyear")
  self:setRedDirty("firstday")
  self:setRedDirty("general1")
  self:setRedDirty("activity")
  self:setRedDirty("halloween")
  self:setRedDirty("lucky")
  self:setRedDirty("general2")
  self:setRedDirty("mysteryBoxHome")
  self:setRedDirty("topDiner")
end

function Role:updateProperty(key, ...)
  local method = self["set_" .. key]
  if type(method) ~= "function" then
    local newValue = select(1, ...)
    self[key] = newValue
    self:dispatchEvent({
      name = "set_" .. key,
      newValue = newValue,
      oldValue = select(2, ...)
    })
    return
  end
  method(self, ...)
end

function Role:supplyFormation(index)
  local formation = self.formation[tostring(index)]
  local material1, material2 = 0, 0
  for _, id in pairs(formation.list) do
    local hero = self.heros[id]
    if hero then
      local temp1, temp2 = hero:getMaterialCost()
      material1 = material1 + temp1
      material2 = material2 + temp2
    end
  end
  if material1 > self.material1 then
    return
  end
  if material2 > self.material2 then
    return
  end
  return true
end

function Role:testSupplyFull(index)
  local formation = self.formation[tostring(index)]
  for _, id in pairs(formation.list) do
    local hero = self.heros[id]
    if hero then
      local temp1, temp2 = hero.material1, hero.material2
      if temp1 ~= 100 and temp2 ~= 100 then
        return false
      end
    end
  end
  return true
end

function Role:getMaterialPercent(index)
  local formation = self.formation[tostring(index)]
  local percent1, percent2, percent3, num = 0, 0, 0, 0
  for _, id in pairs(formation.list) do
    local hero = self.heros[id]
    if hero then
      num = num + 1
      percent1 = percent1 + hero.material1
      percent2 = percent2 + hero.material2
      percent3 = percent3 + hero.hpPercent / 1000
    end
  end
  local per1 = math.floor(percent1 / num / 12.5) * 12.5
  local per2 = math.floor(percent2 / num / 12.5) * 12.5
  local per3 = percent3 / num * 100
  return per1, per2, per3
end

function Role:getFormationState(index)
  local states = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  local format = game.role.formation[tostring(index)]
  if not format then
    return states
  end
  for _, heroId in pairs(format.list) do
    local hero = game.role.heros[heroId]
    if hero:bOnTreat() then
      states[1] = true
      break
    end
  end
  if format.lock and format.lock.carbon then
    states[2] = true
  end
  if format.lock and format.lock.entrust then
    states[3] = true
  end
  return states
end

function Role:getHero(id)
  for _, heroInfo in pairs(self.heros) do
    if heroInfo.id == id then
      return heroInfo
    end
  end
end

function Role:getJobStage(jobId)
  return math.min(self.jobStage:getv(jobId, 1), #jobStageCsv)
end

function Role:getJobLevel(jobId)
  if self.jobLevel == "" or not self.jobLevel then
    self:setJobLevel()
  end
  return self.jobLevel:getv(jobId, 1)
end

function Role:setJobLevel()
  for jobId = 1, 6 do
    local curExp = self.jobExp:getv(jobId, 0)
    local jobStage = self.jobStage:getv(jobId, 1)
    jobStage = math.min(jobStage, #jobStageCsv)
    local curData
    local csvData = jobBonusCsv[jobId][jobStage]
    for index, data in ipairs(csvData) do
      if curExp >= data.exp then
        curData = data
      end
    end
    self.jobLevel = self.jobLevel or ""
    self.jobLevel = self.jobLevel:setv(jobId, curData.level)
  end
end

function Role:saveGuideData(guideData, bFinish, bSkip)
  guideData = guideData or {
    master = self.majorGuideStep,
    slave = self.minorGuideStep,
    finish = bFinish and 1 or 0,
    skip = bSkip and 1 or 0
  }
  if guideData.skip and 0 < guideData.skip then
    self.skipGuideCount = self.skipGuideCount + 1
  end
  game:sendData(actionCodes.Role_guideRpc, MsgPack.pack(guideData))
  game:addResponseHandler(actionCodes.Role_guideRpc, function(event)
  end)
end

function SysError(errId)
  Role:sysError(errId)
end

function Role:sysError(errId)
  local content = SysErrCsv[errId].content
  MFlashMsg:show({text = content})
end

function Role:getBattleAttrs(format, battleType, battleInfo, attrUp)
  local formation = self.formation[tostring(format)]
  local result = {
    heros = {}
  }
  local tempheros = {}
  for _, heroId in pairs(formation.list) do
    local hero = self.heros[heroId]
    local heroInfo = hero:getTotalAttrValues({battle = true, attrUp = attrUp})
    local skillInfo, sauceBuff = hero:getTotalAttrFactors()
    heroInfo.__battleValue = hero:getBattleValue(heroInfo, skillInfo.factor or 0, sauceBuff)
    heroInfo.id = hero.id
    heroInfo.type = hero:getDressType()
    heroInfo.quality = hero.quality
    heroInfo.fieldLevel = hero.fieldLevel
    heroInfo.material2 = battleType == BattleType.Paradise and 100 or hero.material2
    heroInfo.fullHp = heroInfo.hp
    local hpPercent = battleType == BattleType.Paradise and (battleInfo.heroList[tostring(hero.id)] or 0) or hero:getProperty("hpPercent")
    heroInfo.hp = heroInfo.fullHp * hpPercent / 1000
    if 0 < heroInfo.hp and heroInfo.hp < 1 then
      heroInfo.hp = 1
    end
    heroInfo.skillInfo = skillInfo
    heroInfo.hurtChange = hero:getHurtChange()
    heroInfo.battleTag = hero:getBattleTag()
    heroInfo.tebao = hero:getTeBaoValue()
    heroInfo.tekang = hero:getTeKangValue()
    table.insert(result.heros, heroInfo)
    tempheros[hero.id] = {
      type = hero:getProperty("type"),
      fieldLevel = hero:getProperty("fieldLevel"),
      formationId = hero:getFormationId()
    }
  end
  local format = {}
  for index, pos in pairs(formation.pos) do
    format[pos] = formation.list[index]
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function Role:getMJAttrs(format)
  local formation = self.formation[tostring(format)]
  local result = {
    heros = {}
  }
  local tempheros = {}
  for slot, heroId in pairs(formation.list) do
    local hero = self.heros[heroId]
    local heroInfo = hero:getTotalAttrValues({battle = true})
    local skillInfo, sauceBuff = hero:getTotalAttrFactors()
    heroInfo.__battleValue = hero:getBattleValue(heroInfo, skillInfo.factor or 0, sauceBuff)
    heroInfo.id = hero.id
    heroInfo.type = hero:getDressType()
    heroInfo.realType = hero.type
    heroInfo.quality = hero.quality
    heroInfo.fieldLevel = hero.fieldLevel
    heroInfo.fullHp = heroInfo.hp
    heroInfo.skillInfo = skillInfo
    heroInfo.hurtChange = hero:getHurtChange()
    heroInfo.battleTag = hero:getBattleTag()
    table.insert(result.heros, heroInfo)
    tempheros[hero.id] = {
      type = hero:getProperty("type"),
      fieldLevel = hero:getProperty("fieldLevel"),
      formationId = hero:getFormationId()
    }
  end
  local format = {}
  for index, pos in pairs(formation.pos) do
    format[pos] = formation.list[index]
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function Role:getTowerAttrs(formation, formationHp)
  local result = {
    heros = {}
  }
  local tempheros = {}
  for slot, heroId in pairs(formation.list) do
    local hero = self.heros[heroId]
    local heroInfo = hero:getTotalAttrValues({battle = true})
    local skillInfo, sauceBuff = hero:getTotalAttrFactors()
    heroInfo.__battleValue = hero:getBattleValue(heroInfo, skillInfo.factor or 0, sauceBuff)
    heroInfo.id = hero.id
    heroInfo.type = hero:getDressType()
    heroInfo.quality = hero.quality
    heroInfo.fieldLevel = hero.fieldLevel
    heroInfo.fullHp = heroInfo.hp
    heroInfo.hp = heroInfo.fullHp * (formationHp[heroId] or 1000) / 1000
    heroInfo.hp = (formationHp[heroId] or 1000) > 500 and math.floor(heroInfo.hp) or math.ceil(heroInfo.hp)
    heroInfo.hurtChange = hero:getHurtChange()
    heroInfo.battleTag = hero:getBattleTag()
    heroInfo.skillInfo = skillInfo
    table.insert(result.heros, heroInfo)
    tempheros[hero.id] = {
      type = hero.type,
      fieldLevel = hero.fieldLevel,
      formationId = hero:getFormationId()
    }
  end
  local format = {}
  for index, pos in pairs(formation.pos) do
    format[pos] = formation.list[index]
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function Role:getPvpAttrs(formation)
  local result = {
    heros = {}
  }
  local tempheros = {}
  for slot, heroId in pairs(formation.list) do
    local hero = self.heros[heroId]
    local heroInfo = hero:getTotalAttrValues({battle = true})
    local skillInfo, sauceBuff = hero:getTotalAttrFactors()
    heroInfo.__battleValue = hero:getBattleValue(heroInfo, skillInfo.factor or 0, sauceBuff)
    heroInfo.id = hero.id
    heroInfo.type = hero:getDressType()
    heroInfo.quality = hero.quality
    heroInfo.fieldLevel = 1
    heroInfo.fullHp = heroInfo.hp
    heroInfo.skillInfo = skillInfo
    heroInfo.pvpSkillOrder = formation.skillOrder[slot]
    heroInfo.hurtChange = hero:getHurtChange()
    heroInfo.battleTag = hero:getBattleTag()
    table.insert(result.heros, heroInfo)
    tempheros[hero.id] = {
      type = hero.type,
      fieldLevel = 1,
      formationId = hero:getFormationId()
    }
  end
  local format = {}
  for index, pos in pairs(formation.pos) do
    format[pos] = formation.list[index]
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function Role:getPvpEnemyAttrs(formatData)
  local result = {
    heros = {}
  }
  local tempheros = {}
  local format = {}
  local DressCsv = require("csvdata.hero_skin")
  
  local function getDressType(type, dress)
    local dressId = type * 10 + dress
    local dressSet = DressCsv[dressId]
    if not dressSet then
      return type
    else
      return dressSet.hero
    end
  end
  
  for slot, data in pairs(formatData) do
    local heroInfo = data.attrs
    local skillInfo = data.skillInfo
    heroInfo.id = tonumber(slot)
    heroInfo.type = getDressType(data.type, data.dress)
    heroInfo.quality = data.quality
    heroInfo.fieldLevel = 1
    heroInfo.fullHp = heroInfo.hp
    heroInfo.skillInfo = skillInfo
    heroInfo.pvpSkillOrder = data.skillOrder
    heroInfo.hurtChange = data.hurtChange or {}
    heroInfo.battleTag = data.battleTag
    table.insert(result.heros, heroInfo)
    tempheros[tonumber(slot)] = {
      type = data.type,
      fieldLevel = 1,
      formationId = data.formationId
    }
    format[data.pos] = tonumber(slot)
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function Role:getFormationRelation(format)
  local formationData = self.formation[tostring(format)]
  local listData = formationData.list
  local posData = formationData.pos
  for index = 1, 5 do
    if not posData[tostring(index)] then
      posData[tostring(index)] = 0
    end
  end
  local posIds = {}
  local tempheros = {}
  for slot, value in pairs(listData) do
    posIds[posData[slot]] = value
    local hero = self.heros[value]
    tempheros[value] = {
      type = hero:getProperty("type"),
      fieldLevel = hero.fieldLevel,
      formationId = hero:getFormationId()
    }
  end
  local activeStatus = FormatLogic.getActiveStatus(posIds, tempheros)
  local relations = {}
  for heroId, status in pairs(activeStatus) do
    if status.active then
      local hero = self.heros[heroId]
      local formatData = FormationCsv[hero:getFormationId()][hero.fieldLevel]
      local lastPro = {}
      for _, effect in pairs(formatData.effectValue:toTableArray(" ")) do
        local pro = tonumber(effect[2])
        if not lastPro[pro] then
          if not relations[pro] then
            relations[pro] = {}
          end
          table.insert(relations[pro], {
            name = formatData.name,
            desc = formatData.desc
          })
          lastPro[pro] = true
        end
      end
    end
  end
  return relations
end

function Role:initBoxTalent(talentStr)
  local talent = {
    global = {},
    hero = {}
  }
  for _, str in pairs(talentStr or {}) do
    local talentId, heroId = str:match("(%d+)=(%d+)")
    local talentData = DinerTalentCsv[tonumber(talentId)]
    if talentData then
      if talentData.type <= 1000 then
        talent.global[talentData.type] = talent.global[talentData.type] or {}
        talent.global[talentData.type][talentData.condition1] = talent.global[talentData.type][talentData.condition1] or {}
        talent.global[talentData.type][talentData.condition1][talentData.condition2] = (talent.global[talentData.type][talentData.condition1][talentData.condition2] or 0) + talentData.value
      else
        local hero = self.heros[tonumber(heroId)]
        if hero then
          local have = false
          if hero.unit.profession == talentData.condition1 or talentData.condition1 == 0 then
            have = true
          end
          if have then
            talent.hero[tonumber(heroId)] = talent.hero[tonumber(heroId)] or {}
            talent.hero[tonumber(heroId)][talentData.type] = (talent.hero[tonumber(heroId)][talentData.type] or 0) + talentData.value
          end
        end
      end
    end
  end
  self.talentData = talent
end

function Role:getTalentValue(type, con1, con2, con3)
  local value = 0
  con1 = con1 or 0
  con2 = con2 or 0
  con3 = con3 or 0
  if type <= 1000 then
    if self.talentData.global[type] then
      local condition1 = {con1}
      if con1 ~= 0 then
        table.insert(condition1, 0)
      end
      local condition2 = {con2}
      if con2 ~= 0 then
        table.insert(condition2, 0)
      end
      for i = 1, #condition1 do
        for j = 1, #condition2 do
          if self.talentData.global[type][condition1[i]] then
            value = value + (self.talentData.global[type][condition1[i]][condition2[j]] or 0)
          end
        end
      end
    end
  elseif self.talentData.hero[con1] then
    value = value + (self.talentData.hero[con1][type] or 0)
  end
  return value
end

function Role:isMaxHero()
  local heroNum = table.nums(self.heros)
  return heroNum >= self.heroMaxNum
end

function Role:isMaxGift(num)
  local sum = num or 0
  for itemId, count in pairs(game.role.items) do
    local item = ItemCsv[itemId]
    if item.type == ItemType.LoveItem then
      sum = sum + count
    end
  end
  return sum >= self.giftMaxNum
end

function Role:isMaxEquip()
  local equipNum = table.nums(self.equips)
  return equipNum >= self.equipMaxNum
end

function Role:isMaxAccess()
  local temp = self.diner and (self.diner.accessories or {}) or {}
  return table.nums(temp) >= globalCsv.dinerAccNumInit
end

function Role:getMaxSauce()
  local sauceAdd = self.sauceMaxAdd and self.sauceMaxAdd or 0
  return globalCsv.sauceNumMax + sauceAdd
end

function Role:isMaxSauce()
  return table.nums(self.sauces) >= self:getMaxSauce()
end

function Role:drawMaterial(mtype)
  local farmData = self.farmData
  local unionData = self.unionData
  local now = game:nowTime()
  local oldTime = farmData["drawTime" .. mtype]
  local openTime = farmData.openTime
  local nT = CommonHelper.date(now)
  local oT = CommonHelper.date(oldTime)
  local openT = CommonHelper.date(openTime)
  local time1 = now - nT.hour * 3600 - nT.min * 60 - nT.sec
  local time2 = oldTime - oT.hour * 3600 - oT.min * 60 - oT.sec
  local time3 = openTime - openT.hour * 3600 - openT.min * 60 - openT.sec
  local oldWeek = math.floor(math.floor((time2 - time3) / 86400) / 7) + 1
  local nowWeek = math.floor(math.floor((time1 - time3) / 86400) / 7) + 1
  local buildData1 = FBuildCsv[2][farmData.level2]
  local buildData2 = FBuildCsv[3][farmData.level3]
  local unionTechCarry = 0
  local unionTechStorage = 0
  if unionData.unionTech and unionData.unionTechHaveCost == 1 then
    local unionTechList = unionData.unionTech:toNumMap()
    for id, data in pairs(unionTechList) do
      if UnionTechCsv[id].type == 1 and data == 1 then
        unionTechCarry = unionTechCarry + UnionTechCsv[id].count
      end
      if UnionTechCsv[id].type == 5 and data == 1 then
        unionTechStorage = unionTechStorage + UnionTechCsv[id].count
      end
    end
  end
  local carry = self["material" .. mtype]
  local carryMax = buildData2.carry + unionTechCarry
  local weekTime = 604800
  local exp = farmData["reset" .. mtype]
  local maxExp = buildData2.storage + unionTechStorage
  local speeds = buildData1.speed:toTableArray()
  local speed = 1 / tonumber(speeds[mtype][2])
  local num = table.nums(FTermsCsv)
  if oldWeek ~= nowWeek then
    local deltaTime = openTime + oldWeek * weekTime - oldTime
    oldTime = oldWeek * weekTime + openTime
    local curTerm = oldWeek % num + 1
    local expValue = math.floor(speed * deltaTime)
    local effects = FTermsCsv[curTerm].effect:toNumMap()
    expValue = math.floor(expValue * (1 + effects[mtype] / 100))
    exp = exp + expValue
    oldWeek = oldWeek + 1
  end
  while now > oldTime + weekTime and maxExp > exp do
    oldTime = oldTime + weekTime
    local curTerm = oldWeek % num + 1
    local expValue = math.floor(604800 * speed)
    local effects = FTermsCsv[curTerm].effect:toNumMap()
    expValue = math.floor(expValue * (1 + effects[mtype] / 100))
    exp = exp + expValue
    oldWeek = oldWeek + 1
  end
  if maxExp > exp then
    local curTerm = oldWeek % num + 1
    local expValue = math.floor(speed * (now - oldTime))
    local effects = FTermsCsv[curTerm].effect:toNumMap()
    expValue = math.floor(expValue * (1 + effects[mtype] / 100))
    exp = exp + expValue
  end
  if exp == 0 then
    return 0
  end
  if maxExp <= exp then
    return 1
  end
  return 2
end

function Role:drawMaoxianItem(mtype)
  local farmData = self.farmData
  local now = game:nowTime()
  local oldTime = farmData["maoxianTime" .. mtype]
  local buildData1 = FBuildCsv[7][farmData.level7]
  local items = globalCsv.buildingMaoXianRewards
  local carry = self.items[items[mtype]] or 0
  local carryMax = buildData1.carry
  if carry > carryMax then
    carry = carryMax
  end
  local maxExp = buildData1.storage
  local speeds = buildData1.speed:toTableArray()
  local unionData = self.unionData
  local unionTechCarry = 0
  local otherMax = 0
  if unionData.unionTech and unionData.unionTechHaveCost == 1 then
    local unionTechList = unionData.unionTech:toNumMap()
    for id, data in pairs(unionTechList) do
      if unionTechCsv[id].type == 9 and data == 1 then
        unionTechCarry = unionTechCarry + unionTechCsv[id].count
      end
      if unionTechCsv[id].type == 10 and data == 1 then
        otherMax = otherMax + unionTechCsv[id].count
      end
    end
  end
  maxExp = maxExp + otherMax
  local speed = tonumber(speeds[mtype][2])
  local exp = math.floor((now - oldTime) / speed)
  exp = math.floor(exp * (1 + unionTechCarry / 100))
  if exp <= 0 then
    return 0
  end
  if maxExp <= exp then
    return 1
  end
  return 2
end

function Role:getTotalBattleValue(format)
  local totalValue = 0
  local formationData = self.formation[tostring(format)] or {
    list = {},
    pos = {}
  }
  for slot = 1, 5 do
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = self.heros[heroId]
      totalValue = totalValue + hero:getAllValue()
    end
  end
  return totalValue
end

function Role:requestDinerInfo(callback)
  local needUpdate = false
  if self.diner and self.diner.lastUpdateTime then
    local lastT = CommonHelper.date(self.diner.lastUpdateTime, nil, true)
    local nowT = CommonHelper.date(nil, nil, true)
    if lastT.month ~= nowT.month or lastT.day ~= nowT.day then
      needUpdate = true
    end
  end
  if not needUpdate and self.diner and self.diner.diners and self.diner.accessories then
    callback()
    return
  end
  self.wave = 0
  self.diner = {}
  NetManager:sendData(actionCodes.Diner_loadRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  NetManager:addResponseHandler(actionCodes.Diner_loadRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if msg.wave == 1 then
      self.diner.accessories = msg.accessories or {}
      self.diner.boxReward = msg.diner.boxReward
      self.diner.sellInfo = msg.diner.sellInfo
      self.diner.comfortPoints = msg.diner.comfortPoints
      self.diner.item_car = msg.diner.item_car
      self.diner.item_box = msg.diner.item_box
      self.diner.item_fitment = msg.diner.item_fitment
      self.diner.drawEnsure = msg.diner.drawEnsure
      self.diner.lastUpdateTime = game:nowTime()
      self.wave = self.wave + 1
      print("dinerwave1")
    end
    if msg.wave == 2 then
      for i = 1, 10 do
        self.diner["diner" .. i] = msg.diner["diner" .. i]
      end
      self.diner.dinerMaxNum = msg.diner.dinerMaxNum
      self.wave = self.wave + 1
      print("dinerwave2")
    end
    if msg.wave == 3 then
      for i = 1, 8 do
        self.diner["box" .. i] = msg.diner["box" .. i]
      end
      self.diner.dinerBoxMaxNum = msg.diner.dinerBoxMaxNum
      self.wave = self.wave + 1
      print("dinerwave3")
    end
    if msg.wave == 5 then
      for i = 9, globalCsv.dinerBoxNumMax do
        self.diner["box" .. i] = msg.diner["box" .. i]
      end
      self.diner.dinerBoxMaxNum = msg.diner.dinerBoxMaxNum
      self.wave = self.wave + 1
      print("dinerwave5")
    end
    if msg.wave == 4 then
      self.diner.dinerShop = msg.diner.dinerShop
      self.wave = self.wave + 1
      print("dinerwave4")
    end
    if self.wave == 5 then
      self.diner.diners = {}
      for i = 1, self.diner.dinerMaxNum do
        self.diner.diners[i] = require("app.models.Diner"):create(json.decode(self.diner["diner" .. i]) or {})
      end
      callback()
      NetManager:removeResponseHandler(actionCodes.Diner_loadRpc)
      print("dinerwave finish")
    end
  end, true)
end

function Role:requestFarmInfo(callback)
  if self.farmData and self.farmData.lastUpdateTime then
    callback()
    return
  end
  game:sendData(actionCodes.Farm_farmInfoRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Farm_farmInfoRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    self.farmData = msg
    self.farmData.lastUpdateTime = game:nowTime()
    callback()
  end)
end

function Role:getBuffHero()
  local startDate = CommonHelper.date(0, nil, true)
  local weekDay = startDate.wday - 1
  if weekDay == 0 then
    weekDay = 7
  end
  local startTime = 0 - (weekDay - 1) * 86400
  local curWeek = math.ceil((game:nowTime() - startTime) / 604800)
  local curId = curWeek % #SauceBonusCsv
  curId = curId == 0 and #SauceBonusCsv or curId
  local curData = SauceBonusCsv[curId]
  local heros = {}
  for _, heroType in pairs(curData.heros:toArray("=", true)) do
    heros[heroType] = 1
  end
  local needBuff = {
    "hp",
    "atk",
    "phyDef",
    "hit",
    "miss"
  }
  local buff = {}
  for _, attr in ipairs(needBuff) do
    buff[attr] = (curData[attr] or 100) / 100
  end
  return {
    id = curData.id,
    heros = heros,
    buff = buff
  }
end

function Role:getAutoBattleId()
  if not self.autoBattle.idxs then
    return false
  end
  local idxs = (self.autoBattle.idxs or ""):toArray("=", true)
  return idxs[1]
end

function Role:checkAutoBattleError()
  local idxs = (self.autoBattle.idxs or ""):toArray("=", true)
  if idxs[1] and (idxs[2] == 0 or idxs[3] == 0) then
    game:sendData(actionCodes.Carbon_autoCleanFormsRpc, MsgPack.pack({}))
  end
end

function Role:checkTimeLimit()
  local desc = ""
  local date = CommonHelper.date()
  local canPlay = DateCsv[tonumber(string.format("%d%02d%02d", date.year, date.month, date.day))] and true or false
  if not canPlay or date.hour >= 21 or date.hour < 20 then
    desc = "未成年用户无法在此时间段登录游戏，请您谅解"
  end
  if desc ~= "" then
    if self.timerHandler then
      scheduler.unscheduleGlobal(self.timerHandler)
      self.timerHandler = nil
    end
    local dialog = MDialog:single({text = desc}, function()
      cc.Director:getInstance():endToLua()
    end)
    local endTime = game:nowTime() + 10
    local setTime
    
    function setTime()
      local leftTime = endTime - game:nowTime()
      dialog.okBtn:setTitleText(string.format("确定(%d)", leftTime))
      if leftTime <= 0 then
        dialog.callback()
        dialog:close()
      else
        dialog:runAction(transition.sequence({
          cc.DelayTime:create(1),
          cc.CallFunc:create(function()
            setTime()
          end)
        }))
      end
    end
    
    setTime()
  end
end

function Role:checkCanCharge(rmb)
  if not game.checkAge then
    return true
  end
  if game.age >= 18 then
    return true
  end
  if game.visit then
    MFlashMsg:show({
      text = "游客账号无法充值，请您谅解"
    })
    return
  end
  local ageLevel, showTip = 1, ""
  for level, set in pairs(globalCsv.AgeLevel or {}) do
    if game.age >= set[1] and game.age <= set[2] then
      ageLevel = level
      break
    end
  end
  local temp = globalCsv.ChargeLimits[ageLevel]
  if ageLevel == 1 then
    showTip = "您未达到实名认证年龄，无法充值，请您谅解"
  elseif self.mCharge >= temp[2] then
    showTip = "您的充值额度已经达到相应额度，无法充值，请您谅解"
  elseif rmb > temp[1] then
    showTip = "您的单笔充值额度超过相应限制，无法充值，请您谅解"
  end
  if showTip ~= "" then
    MFlashMsg:show({text = showTip})
    return false
  end
  return true
end

function Role:checkSign()
  local sid = string.sub(game.platform_uid, -2, -1)
  local ids = {
    ["10"] = 1,
    ["21"] = 1,
    ["22"] = 1,
    ["23"] = 1,
    ["24"] = 1,
    ["25"] = 1,
    ["26"] = 1,
    ["49"] = 1,
    ["91"] = 1,
    ["90"] = 1
  }
  return ids[sid]
end

function Role:showNewPayLayer(name)
  local names = {
    zhaolu = 1,
    haoyou = 1,
    taptap = 1,
    secret = 1
  }
  return names[name]
end

function Role:checkNotRechargeChannel()
  if CHANNEL_KEY == "qihu360" or CHANNEL_KEY == "oppo" then
    SysError(SYS_ERR_NOT_RECHARGE)
    return true
  else
    return false
  end
end

return Role
