local unitCsv = require("csvdata.unit")
local skillSet = require("csvdata.skill")
local skillSpecialSet = require("csvdata.skill_special")
local skillBlockSet = require("csvdata.skill_block")
local skillAwakeSet = require("csvdata.skill_awake")
local skillPassiveSet = require("csvdata.skill_passive")
local bulletDataSet = require("csvdata.bullet")
local buffSet = require("csvdata.buff")
local buildSet = require("csvdata.farm_building")
local spineActCsv = require("csvdata.spine_act")
local HomeSkinCsv = require("csvdata.home_skin")
local UnionExpCsv = require("csvdata.union_exp")
local awakeCsv = require("csvdata.awaken")
local innateCsv = require("csvdata.innate")
local unionTechCsv = require("csvdata.union_tech")
local jobBonusCsv = require("csvdata.hero_job_bonus")
local jobStageCsv = require("csvdata.hero_job_stage")
local professionCsv = require("csvdata.profession")
local cvSet = require("csvdata.cv")
local fileUtils = cc.FileUtils:getInstance()
local textureCache = cc.Director:getInstance():getTextureCache()
local CommonHelper = {}
local cvHandler
local cvCache = {}

function CommonHelper.playCV(type, field)
  if SKIP_MUSIC then
    return
  end
  local cv = cvSet[type]
  if not cv or cv == nil then
    return
  end
  local musicId = cv[field]
  table.insert(cvCache, musicId)
  if not cvHandler then
    CommonHelper.playCVFromCache()
  end
end

function CommonHelper.playCVFromCache()
  if #cvCache == 0 then
    return
  end
  local musicId = cvCache[1]
  table.remove(cvCache, 1)
  cvHandler = game:playMusic(musicId, function(handlerId)
    cvHandler = nil
    CommonHelper.playCVFromCache()
  end)
  if not cvHandler then
    CommonHelper.playCVFromCache()
  end
end

function CommonHelper.stopCV()
  if cvHandler then
    cvCache = {}
    game:stopMusic(cvHandler)
    cvHandler = nil
  end
end

function CommonHelper.clearCV()
  cvCache = {}
end

local miguPID = {
  [1] = true,
  [2] = true,
  [99] = true,
  [101] = true,
  [102] = true
}

function CommonHelper.showProduct(id)
  if not CHANNEL_NAME then
    return true
  end
  if CHANNEL_NAME == "migu" then
    return miguPID[id]
  end
  return true
end

function CommonHelper.getBagLimit(type)
  if type == "equip" then
    return globalCsv.equipBagTop + game.role.equipBagBuyCount * functionCsv[9].cellCount + vipCsv[game.role.vip].equipBagUp
  elseif type == "hero" then
    return globalCsv.heroBagTop + game.role.heroBagBuyCount * functionCsv[8].cellCount + vipCsv[game.role.vip].heroBagUp
  end
  return 0
end

function CommonHelper.checkBagFull()
  if table.nums(game.role.heros) >= CommonHelper.getBagLimit("hero") then
    return true
  end
  if CommonHelper.funcOpen("equip") and table.nums(game.role.equips) >= CommonHelper.getBagLimit("equip") then
    return true
  end
  return false
end

function CommonHelper.funcOpen(type)
  if game.role.carbons[globalCsv["funcOpen_" .. type]] then
    return true
  end
  return false
end

function CommonHelper.playHomeBGM(skinId)
  local skinSet = HomeSkinCsv[skinId or game.role.homeBgTag]
  local bgm = skinSet.bgm
  if skinSet.bgmList ~= "" then
    local bgmIndexStr = UserData.homeBgm or ""
    local index = bgmIndexStr:getv(game.role.homeBgTag, 1)
    local bgmList = skinSet.bgmList:toArray("=", true)
    if skinSet.changeByTime == 1 then
      local nowtime = game:nowTime()
      if nowtime % 86400 <= 25200 then
        bgm = bgmList[1]
      elseif nowtime % 86400 <= 46800 then
        bgm = bgmList[2] or bgmList[1]
      else
        bgm = bgmList[3] or bgmList[1]
      end
    else
      bgm = bgmList[index] or bgmList[1]
    end
  end
  game:playMusic(bgm)
end

function CommonHelper.getActivityId(type)
  local serverId = math.floor(game.role.id / 100000)
  local activitySet = activityCsv[serverId]
  local activityId, startTime, endTime
  local curTime = tonumber(CommonHelper.date(nil, "Ymd"))
  for _, time in ipairs(activitySet["activity" .. type]:toTableArray()) do
    if curTime >= tonumber(time[1]) and curTime <= tonumber(time[2]) then
      activityId = tonumber(time[3])
      startTime = time[1]
      endTime = time[2]
      break
    end
  end
  return activityId, startTime, endTime
end

function CommonHelper.getVipMore(field)
  for vip = game.role.vip + 1, MAX_VIP do
    local more = vipCsv[vip][field] - vipCsv[game.role.vip][field]
    if 0 < more then
      return more, vip
    end
  end
  return 0
end

function CommonHelper.cacheUnitRes(type, params)
  params = params or {}
  local unitData = unitCsv[type]
  local star = params.star or unitData.star
  local blockLevel = params.blockLv or 1
  local specialLevel = params.specialLv or 1
  local awakeLevel = params.awakeLv or 0
  local specialId = params.specialId or unitData.specialId
  local awakeId = params.awakeId or unitData.awakeId
  local blockId = params.blockId or unitData.blockId
  local blockId2 = params.blockId2 or unitData.blockId2
  local blockId3 = params.blockId3 or unitData.blockId3
  local characteristicId = params.characteristicId
  local characteristicLv = params.characteristicLv or 0
  local dreamId = params.dreamId
  local dreamLv = params.dreamLv or 0
  local skillIds = unitData.attackId == 0 and {} or {
    unitData.attackId
  }
  local bulletIds = {}
  
  function traBuff(buff)
    bulletIds[buff.bulletId] = true
    if buff.type == 18 then
      for _, data in pairs(buff.effectValue4:toTableArray()) do
        local buffData = buffSet[tonumber(data[1])]
        if buffData then
          bulletIds[buffData.bulletId] = true
        end
      end
    end
  end
  
  if awakeId and 0 < awakeId and 0 < awakeLevel then
    local function traPassive(passiveSet)
      for type, value in pairs(passiveSet.effect:toNumMap()) do
        if type == 51 or type == 52 then
          table.insert(skillIds, value)
        end
        if type == 53 then
          local buff = buffSet[value]
          if buff then
            traBuff(buff)
          end
        end
        if type == 65 or type == 74 or type == 92 then
          local passiveSkill = skillPassiveSet[value]
          traPassive(passiveSkill)
        end
        if type == 70 or type == 71 or type == 72 or type == 73 then
          CommonHelper.cacheUnitRes(tonumber(value), {})
        end
      end
    end
    
    local awakeSet = skillAwakeSet[awakeId][awakeLevel]
    local passiveSet = skillPassiveSet[awakeSet.skillId]
    traPassive(passiveSet)
  end
  if characteristicId and 0 < characteristicId and 0 < characteristicLv then
    local function traPassive(passiveSet)
      for type, value in pairs(passiveSet.effect:toNumMap()) do
        if type == 51 or type == 52 then
          table.insert(skillIds, value)
        end
        if type == 53 then
          local buff = buffSet[value]
          if buff then
            traBuff(buff)
          end
        end
        if type == 65 or type == 74 or type == 92 then
          local passiveSkill = skillPassiveSet[value]
          traPassive(passiveSkill)
        end
        if type == 70 or type == 71 or type == 72 or type == 73 then
          CommonHelper.cacheUnitRes(tonumber(value), {})
        end
      end
    end
    
    local innateSet = skillBlockSet[characteristicId][characteristicLv]
    local passiveSet = skillPassiveSet[innateSet.skillId]
    print("characteristicId skillId", innateSet.skillId)
    traPassive(passiveSet)
  end
  if dreamId and 0 < dreamId and 0 < dreamLv then
    local function traPassive(passiveSet)
      for type, value in pairs(passiveSet.effect:toNumMap()) do
        if type == 51 or type == 52 then
          table.insert(skillIds, value)
        end
        if type == 53 then
          local buff = buffSet[value]
          if buff then
            traBuff(buff)
          end
        end
        if type == 65 or type == 74 or type == 92 then
          local passiveSkill = skillPassiveSet[value]
          traPassive(passiveSkill)
        end
        if type == 70 or type == 71 or type == 72 or type == 73 then
          CommonHelper.cacheUnitRes(tonumber(value), {})
        end
      end
    end
    
    local innateSet = skillBlockSet[dreamId][dreamLv]
    local passiveSet = skillPassiveSet[innateSet.skillId]
    print("dreamId skillId", innateSet.skillId)
    traPassive(passiveSet)
  end
  if 0 < blockId then
    local blocks = {blockId}
    if 0 < blockId2 then
      table.insert(blocks, blockId2)
    end
    if 0 < blockId3 then
      table.insert(blocks, blockId3)
    end
    
    local function traPassive(passiveSet)
      for type, value in pairs(passiveSet.effect:toNumMap()) do
        if type == 51 or type == 52 then
          table.insert(skillIds, value)
        end
        if type == 53 then
          local buff = buffSet[value]
          if buff then
            traBuff(buff)
          end
        end
        if type == 65 or type == 74 or type == 92 then
          local passiveSkill = skillPassiveSet[value]
          traPassive(passiveSkill)
        end
        if type == 70 or type == 71 or type == 72 or type == 73 then
          CommonHelper.cacheUnitRes(tonumber(value), {})
        end
      end
    end
    
    for _, _blockId in ipairs(blocks) do
      print(type, _blockId, blockLevel)
      local blockSet = skillBlockSet[_blockId][blockLevel]
      local passiveSet = skillPassiveSet[blockSet.skillId]
      traPassive(passiveSet)
    end
  end
  if 0 < specialId then
    local specialSet = skillSpecialSet[specialId][specialLevel]
    table.insert(skillIds, specialSet.skillId)
  end
  for index = 2, 5 do
    local _specialId = unitData["specialId" .. index]
    if _specialId and 0 < _specialId then
      local specialSet = skillSpecialSet[_specialId][specialLevel]
      table.insert(skillIds, specialSet.skillId)
    end
  end
  for _, skillId in ipairs(skillIds) do
    local skillData = skillSet[skillId]
    for index = 1, 5 do
      if 0 < skillData["bulletId" .. index] then
        bulletIds[skillData["bulletId" .. index]] = true
      end
    end
    if 0 < skillData.hurtBulletId then
      bulletIds[skillData.hurtBulletId] = true
    end
    if skillData.objectBuff ~= "" then
      local buffs = skillData.objectBuff:toArray(" ", true)
      for _, buffId in ipairs(buffs) do
        local buff = buffSet[buffId]
        if buff then
          traBuff(buff)
        end
      end
    end
    if skillData.selfBuff ~= "" then
      local buffs = skillData.selfBuff:toArray(" ", true)
      for _, buffId in ipairs(buffs) do
        local buff = buffSet[buffId]
        if buff then
          traBuff(buff)
        end
      end
    end
    if skillData.changeBody ~= "" then
      local changeSet = skillData.changeBody:toArray("=")
      CommonHelper.cacheUnitRes(tonumber(changeSet[1]), params)
    end
  end
  local boneRes = unitData.boneRes
  local plists = {}
  local spines = {boneRes}
  for bulletId, _ in pairs(bulletIds) do
    local bulletData = bulletDataSet[bulletId]
    if 0 < bulletData.spineAct then
      local actData = spineActCsv[bulletData.spineAct]
      spines[#spines + 1] = unitCsv[actData.spineId].boneRes
    else
      require(bulletData.actCsv)
      if device.platform ~= "ios" then
        textureCache:setTexturePixelFormat(bulletData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888)
      else
        textureCache:setTexturePixelFormat(bulletData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_PVRTC4A)
      end
      plists[bulletId] = bulletData.res .. ".plist"
    end
  end
  ResourceMgr:addSpineRes(spines)
  ResourceMgr:addPlists(plists)
  ResourceMgr:addBullets(table.keys(bulletIds))
end

function CommonHelper.cacheBeautyRes(beauty)
  local beautyData = beautyCsv[beauty.id]
  local images = {}
  local plists = {}
  local lwfs = {}
  if beautyData.lwfRes ~= "" then
    table.insert(lwfs, beautyData.lwfRes)
  else
    table.insert(images, beautyData.beautyBg)
    table.insert(plists, beautyData.beautyEff .. ".plist")
  end
  local level = 1
  local skillData = skillDataSet[beautyData.skillId][level]
  for _, bulletId in ipairs({
    skillData.bulletId,
    skillData.hurtBulletId
  }) do
    local bulletData = bulletDataSet[bulletId]
    require(bulletData.actCsv)
    if device.platform ~= "ios" then
      textureCache:setTexturePixelFormat(bulletData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888)
    else
      textureCache:setTexturePixelFormat(bulletData.res .. ".pvr.ccz", cc.TEXTURE2D_PIXEL_FORMAT_PVRTC4A)
    end
    table.insert(plists, bulletData.res .. ".plist")
  end
  ResourceMgr:addSpineRes({
    beautyData.bone
  })
  ResourceMgr:addImages(images)
  ResourceMgr:addPlists(plists)
  ResourceMgr:addBullets({
    skillData.bulletId,
    skillData.hurtBulletId
  })
  ResourceMgr:addLWFRes(lwfs)
end

function CommonHelper.displayZOrder(value)
  return value == 0 and DISPLAY_ABOVE_ORDER or DISPLAY_UNDER_ORDER
end

function CommonHelper.toUnixtime(timeStr)
  local strLength = string.len(timeStr)
  if strLength ~= 8 and strLength ~= 10 and strLength ~= 12 then
    return
  end
  local year = string.sub(timeStr, 1, 4)
  local month = string.sub(timeStr, 5, 6)
  local day = string.sub(timeStr, 7, 8)
  local hour, minute = 0, 0
  if strLength == 10 then
    hour = string.sub(timeStr, 9, 10)
    minute = string.sub(timeStr, 11, 12)
  end
  return CommonHelper.time({
    year = year,
    month = month,
    day = day,
    hour = hour,
    min = minute,
    sec = 0
  })
end

function CommonHelper.date(time, formatStr, reset)
  time = (time or game:nowTime()) + 28800
  local timeTab = os.date("!*t", time)
  if reset and timeTab.hour < 4 then
    time = time - 14400
  end
  timeTab = os.date("!*t", time)
  if formatStr == "Ymd" then
    return string.format("%d%02d%02d", timeTab.year, timeTab.month, timeTab.day)
  elseif formatStr == "c" then
    return string.format("%d:%02d:%02d", timeTab.hour, timeTab.min, timeTab.sec)
  elseif formatStr == "x" then
    return string.format("%02d/%02d/%d", timeTab.month, timeTab.day, timeTab.year)
  elseif formatStr == "ymd" then
    return string.format("%d/%02d/%02d", timeTab.year, timeTab.month, timeTab.day)
  elseif formatStr == "YmdX" then
    return string.format("%d%02d%02d %d:%02d:%02d", timeTab.year, timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
  end
  return timeTab
end

function CommonHelper.time(params)
  local nowB = os.time()
  local lmt = os.date("*t", nowB)
  local timeZone = os.difftime(nowB, os.time(os.date("!*t", nowB)))
  if lmt.isdst then
    if timeZone < 0 then
      timeZone = timeZone + 3600
    else
      timeZone = timeZone - 3600
    end
  end
  return os.time(params) + (timeZone - 28800)
end

function CommonHelper.crossWeekTime(nowTime)
  nowTime = nowTime or game:nowTime()
  local time = CommonHelper.date(nowTime)
  local weekDay = time.wday - 1
  if weekDay == 0 then
    weekDay = 7
  end
  local temp_time = nowTime + 86400 * (8 - weekDay)
  local temp_date = CommonHelper.date(temp_time)
  local crossTime = CommonHelper.time({
    year = temp_date.year,
    month = temp_date.month,
    day = temp_date.day,
    hour = RESET_TIME
  })
  return nowTime + (crossTime - nowTime) % 604800
end

function CommonHelper.todayCrossTime(nowTime)
  nowTime = nowTime or game:nowTime()
  local temp_date = CommonHelper.date(nowTime)
  local crossTime = CommonHelper.time({
    year = temp_date.year,
    month = temp_date.month,
    day = temp_date.day,
    hour = RESET_TIME
  })
  return crossTime
end

function CommonHelper.crossTimeForDHMS(timeValue)
  local date = {}
  date.day = math.floor(timeValue / 86400)
  date.hour = math.floor(timeValue % 86400 / 3600)
  date.minute = math.floor(timeValue % 3600 / 60)
  date.second = timeValue % 60
  return date
end

function CommonHelper.randomName()
  local part1 = nameCsv[1][math.random(1, #nameCsv[1])].name
  local part2 = nameCsv[2][math.random(1, #nameCsv[2])].name
  local part3 = nameCsv[3][math.random(1, #nameCsv[3])].name
  return part1 .. part2 .. part3
end

function CommonHelper.hasOpenSpecial(star)
  if game.role.majorGuideStep == 8 or game.role.majorGuideStep == 10 then
    return false
  end
  return true
end

function CommonHelper.checkSourceFull()
  local res = {}
  local storeData = buildSet[3][game.role.storeLevel]
  local unionData = game.role.unionData
  local unionTechCarry = 0
  if unionData.unionTech and unionData.unionTechHaveCost == 1 then
    local unionTechList = unionData.unionTech:toNumMap()
    for id, data in pairs(unionTechList) do
      if unionTechCsv[id].type == 1 and data == 1 then
        unionTechCarry = unionTechCarry + unionTechCsv[id].count
      end
    end
  end
  for type = 1, 4 do
    local num = game.role["material" .. type] or 0
    if num >= storeData.carry + unionTechCarry then
      res[type] = true
    end
  end
  return res
end

local JumpLayerType = {
  [0] = function(selected)
    local layer = game:createView("activity.ActivityMainLayer", {selected = selected})
    return layer
  end,
  [1] = function(carbonId, type)
    local carbonType = 1
    type = type or 0
    if math.floor(carbonId / 10000) == 3 and type ~= 1 then
      carbonType = 2
      local LeYuanCsv = require("csvdata.leyuan_battle")
      local limit = LeYuanCsv[carbonId].type == 1 and globalCsv.ExpLeyuanOpentime or globalCsv.CuisineLeyuanOpentime
      local date = CommonHelper.date(nil, nil, true)
      local wday = date.wday - 1
      if wday == 0 then
        wday = 7
      end
      if 0 >= limit:getv(wday, -1) then
        SysError(SYS_ERR_CAEBON_HAPPY_NOT_OPEN)
        return
      end
    end
    local layer
    if carbonType == 1 then
      layer = game:createView("carbon.CarbonDetailLayer", {
        mapId = math.floor(carbonId / 100),
        carbonId = carbonId
      })
    elseif carbonType == 2 then
      layer = game:createView("carbon.CarbonHappyDetailLayer", {carbonId = carbonId})
    else
      return
    end
    return layer
  end,
  [4] = function(carbonType)
    local layer = game:createView("carbon.CarbonMainLayer", {carbonType = carbonType})
    return layer
  end,
  [5] = function()
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 1})
    return layer
  end,
  [6] = function()
    local layer = game:createView("treat.TreatHeroLayer")
    return layer
  end,
  [7] = function()
    if not CommonHelper.funcOpen("strength") then
      SysError(SYS_ERR_FUNCOPEN_STRENGTH)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 2})
    return layer
  end,
  [8] = function()
    if not CommonHelper.funcOpen("evolution") then
      SysError(SYS_ERR_FUNCOPEN_EVOLUTION)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 3})
    return layer
  end,
  [9] = function()
    if not CommonHelper.funcOpen("gift") then
      SysError(SYS_ERR_FUNCOPEN_GIFT)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 4})
    return layer
  end,
  [16] = function()
    if not CommonHelper.funcOpen("plant") then
      SysError(SYS_ERR_FUNCOPEN_PLANT)
      return
    end
    local layer = game:createView("farm.PlantMainLayer")
    return layer
  end,
  [17] = function()
    if not CommonHelper.funcOpen("equipPower") then
      SysError(SYS_ERR_FUNCOPEN_EQUIPPOWER)
      return
    end
    local layer = game:createView("equip.EquipHomeLayer", {selected = 3})
    return layer
  end,
  [18] = function()
    local layer = game:createView("carbon.CarbonMainLayer")
    return layer
  end,
  [19] = function()
    local layer = game:createView("carbon.CarbonMainLayer", {selected = 2})
    return layer
  end,
  [20] = function()
    if not CommonHelper.funcOpen("travel") then
      SysError(SYS_ERR_FUNCOPEN_TRAVEL)
      return
    end
    local layer = game:createView("carbon.CarbonMainLayer", {selected = 2})
    return layer
  end,
  [21] = function()
    if not CommonHelper.funcOpen("equip") then
      SysError(SYS_ERR_FUNCOPEN_EQUIP)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 4})
    return layer
  end,
  [22] = function()
    local layer = game:createView("trade.TradeMainLayer")
    return layer
  end,
  [23] = function()
    if not CommonHelper.funcOpen("strength") then
      SysError(SYS_ERR_FUNCOPEN_STRENGTH)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 2})
    return layer
  end,
  [24] = function()
    if not CommonHelper.funcOpen("equipStrength") then
      SysError(SYS_ERR_FUNCOPEN_EQUIPSTRENGTH)
      return
    end
    local layer = game:createView("equip.EquipHomeLayer", {selected = 4})
    return layer
  end,
  [25] = function()
    if not CommonHelper.funcOpen("tower") then
      SysError(SYS_ERR_FUNCOPEN_TOWER)
      return
    end
    local layer = game:createView("carbon.CarbonMainLayer", {selected = 3})
    return layer
  end,
  [26] = function()
    if not CommonHelper.funcOpen("equipsuit") then
      SysError(SYS_ERR_FUNCOPEN_EQUIPSUIT)
      return
    end
    local layer = game:createView("carbon.EquipHomeLayer", {selected = 5})
    return layer
  end,
  [27] = function()
    if not CommonHelper.funcOpen("gift") then
      SysError(SYS_ERR_FUNCOPEN_GIFT)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 4})
    return layer
  end,
  [28] = function(selected)
    local layer = game:createView("shop.ShopLayer", {selected = selected})
    return layer
  end,
  [29] = function()
    if not CommonHelper.funcOpen("pvp") then
      SysError(SYS_ERR_FUNCOPEN_PVP)
      return
    end
    local layer = game:createView("carbon.CarbonMainLayer", {selected = 4})
    return layer
  end,
  [30] = function()
    if not CommonHelper.funcOpen("equipStrength") then
      SysError(SYS_ERR_FUNCOPEN_EQUIPSTRENGTH)
      return
    end
    local layer = game:createView("equip.EquipHomeLayer", {selected = 4})
    return layer
  end,
  [31] = function()
    if game.role.createTime < CommonHelper.toUnixtime("201801040930") then
      if not CommonHelper.funcOpen("dinerCar") then
        SysError(SYS_ERR_FUNCOPEN_DINER_CAR)
        return
      end
    elseif not CommonHelper.funcOpen("dinerCarNew") then
      SysError(SYS_ERR_FUNCOPEN_DINER_CAR_NEW)
      return
    end
    local layer = game:createView("diner.DinerMainLayer")
    return layer
  end,
  [32] = function()
    if not CommonHelper.funcOpen("dinerCar") then
      SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
      return
    end
    local layer = game:createView("diner.DinerDrawLayer")
    return layer
  end,
  [33] = function()
    local layer = game:createView("carbon.CarbonMainLayer", {carbonType = 2})
    return layer
  end,
  [34] = function(carbonId)
    local layer = game:createView("carbon.CarbonMainLayer", {carbonType = carbonId})
    return layer
  end,
  [35] = function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 6})
    return layer
  end,
  [36] = function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE_CARBON)
      return
    end
    local layer = game:createView("carbon.CarbonMainLayer", {selected = 1})
    return layer
  end,
  [37] = function()
    if not CommonHelper.funcOpen("tree") then
      SysError(SYS_ERR_FUNCOPEN_TREE)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer1", {selected = 5})
    return layer
  end,
  [38] = function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE_CARBON)
      return
    end
    local layer = game:createView("sauce.SauceHomeLayer", {selected = 1})
    return layer
  end,
  [39] = function()
    if not CommonHelper.funcOpen("awake") then
      SysError(SYS_ERR_FUNCOPEN_AWAKE)
      return
    end
    local layer = game:createView("carbon.CarbonMainLayer", {carbonType = 4})
    return layer
  end,
  [40] = function()
    local layer = game:createView("pass.PassMainLayer", {select = 1})
    return layer
  end,
  [42] = function()
    local layer = game:createView("farm.FarmMainLayer")
    return layer
  end,
  [126] = function()
    if not CommonHelper.funcOpen("extraStar") then
      SysError(SYS_ERR_FUNCOPEN_EXTRASTARDRAW)
      return
    end
    local layer = game:createView("kitchen.KitchenLayer2", {selected = 8})
    return layer
  end
}

function CommonHelper.jumpLayer(layerType, pushCallBack, popCallBack, cond, type)
  pushCallBack = pushCallBack or function()
  end
  popCallBack = popCallBack or function()
  end
  local layer
  
  local function push()
    if not layer then
      return
    end
    pushCallBack()
    BackManager:push(function()
      layer:close()
      popCallBack()
    end)
  end
  
  if layerType == 22 then
    game:sendData(actionCodes.Trade_getInfoRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Trade_getInfoRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      game.role.tradeData = msg
      if next(msg) then
        layer = JumpLayerType[layerType]()
        push()
      end
    end)
  elseif layerType == 16 then
    game.role:requestFarmInfo(function()
      layer = JumpLayerType[layerType]()
      push()
    end)
  elseif layerType == 31 then
    game.role:requestDinerInfo(function()
      layer = JumpLayerType[layerType]()
      push()
    end)
  elseif layerType == 41 then
    game:enterScene("MidAutumnScene", {sceneType = "general1"})
  elseif layerType == 42 then
    if not CommonHelper.funcOpen("farm") then
      SysError(SYS_ERR_FUNCOPEN_FARM)
      return
    end
    game.role:requestFarmInfo(function()
      layer = JumpLayerType[layerType]()
      push()
    end)
  else
    if layerType == 4 and cond and cond ~= 0 then
      if cond == 10000 or cond == 20000 then
        layer = JumpLayerType[4](1)
      elseif cond == 30000 then
        layer = JumpLayerType[4](2)
      else
        layer = JumpLayerType[1](cond, type)
      end
    else
      layer = JumpLayerType[layerType](cond ~= 0 and cond or nil)
    end
    push()
  end
end

function CommonHelper.showHeroAnimation(unitType, count)
  if not unitCsv[unitType] then
    return false
  end
  if (game.role.heroBook[tostring(unitType)] or 0) == count or (UserData.skipHeroAnimation or ""):getv(unitCsv[unitType].star, 0) == 0 then
    return true
  end
  return false
end

function CommonHelper.getUnionTechValue(unionTech, techType)
  local techValue = 0
  if unionTech then
    local unionTechList = unionTech:toNumMap()
    for id, data in pairs(unionTechList) do
      if unionTechCsv[id].type == techType and data == 1 then
        techValue = techValue + unionTechCsv[id].count
      end
    end
  end
  return techValue
end

function CommonHelper.getUnionMemberMax(level, unionTech)
  level = math.min(level or 1, #UnionExpCsv)
  local limits = globalCsv.UnionNumLimit:toArray("=", true)
  return limits[1] + level * limits[2] + CommonHelper.getUnionTechValue(unionTech, 11)
end

local startSet = {
  [3] = {4},
  [4] = {2, 4},
  [5] = {
    2,
    3,
    4
  }
}

function CommonHelper.getAwakeNoTypePath(type, heroType, idxLv, starNeed)
  if type == 1 and not awakeCsv[heroType] then
    return
  end
  if not (idxLv and starNeed) or starNeed < 3 then
    return
  end
  if idxLv == 0 then
    return 1
  end
  return startSet[starNeed][idxLv] or 1
end

function CommonHelper.getAwakeTypePath(heroId)
  local heroData = game.role.heros[heroId]
  if not heroData then
    return
  end
  if not awakeCsv[heroData.type] then
    return
  end
  local awakeLevel = heroData.awake
  local star = heroData.unit.star
  if not (awakeLevel and star) or star < 3 then
    return
  end
  if awakeLevel == 0 then
    return 1
  end
  return startSet[star][awakeLevel] or 1
end

function CommonHelper.isOpenAwake(heroId)
  local heroData = game.role.heros[heroId]
  if awakeCsv[heroData.type] then
    return true
  end
  return false
end

function CommonHelper.getOtherBattleValue(formatData, exp, stage)
  local bvalue = 0
  if not (exp and stage) or exp == "" and stage == "" then
    return bvalue
  end
  for slot = 1, 5 do
    local heroData = formatData[tostring(slot)]
    if heroData then
      local unitData = unitCsv[heroData.type]
      local curExp = exp:getv(unitData.profession, 0)
      local jobStage = stage:getv(unitData.profession, 1)
      local jobLevel = CommonHelper.getJobLevel(unitData.profession, exp, stage)
      local bonusData = jobBonusCsv[unitData.profession][jobStage][jobLevel]
      local professSet = professionCsv[unitData.profession]
      if bonusData then
        bvalue = bvalue + jobStage * 1000 + (jobStage - 1) * 100 * 5 + jobLevel * 5
      end
    end
  end
  return bvalue
end

function CommonHelper.getJobLevel(jobId, exp, stage)
  local curExp = exp:getv(jobId, 0)
  local jobStage = stage:getv(jobId, 1)
  jobStage = math.min(jobStage, #jobStageCsv)
  local curData
  local csvData = jobBonusCsv[jobId][jobStage]
  for index, data in ipairs(csvData) do
    if curExp >= data.exp then
      curData = data
    end
  end
  return curData.level
end

function CommonHelper.calculateDuration(endDateTimeStr)
  local startTime = game:nowTime()
  local year, month, day, hour = string.match(endDateTimeStr, "(%d%d%d%d)(%d%d)(%d%d)(%d%d)")
  local endTime = os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour)
  })
  local durationInSeconds = endTime - startTime
  local timeStr = UIHelper.getTimeDayStr(durationInSeconds)
  return timeStr
end

function CommonHelper.calculateActivityRemainingSeconds(startDate, cycleDays)
  startDate = startDate or "20251016"
  cycleDays = cycleDays or 14
  local now = game:nowTime()
  local startYear = tonumber(startDate:sub(1, 4))
  local startMonth = tonumber(startDate:sub(5, 6))
  local startDay = tonumber(startDate:sub(7, 8))
  local startTime = os.time({
    year = startYear,
    month = startMonth,
    day = startDay,
    hour = 4,
    min = 0,
    sec = 0
  })
  local daysDiff = math.floor((now - startTime) / 86400)
  local currentCycle = math.floor(daysDiff / cycleDays)
  local endTime = startTime + (currentCycle + 1) * cycleDays * 24 * 60 * 60
  if now >= endTime then
    endTime = startTime + (currentCycle + 2) * cycleDays * 24 * 60 * 60
  end
  local remainingSeconds = endTime - now
  return math.max(0, remainingSeconds)
end

function CommonHelper.calculateActRemain()
  local remainingSeconds = CommonHelper.calculateActivityRemainingSeconds()
  return UIHelper.getTimeDayStr(remainingSeconds)
end

return CommonHelper
