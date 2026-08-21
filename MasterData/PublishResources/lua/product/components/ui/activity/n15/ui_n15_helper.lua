local N15ToolFunctions = {
  GetRemainTime = function(time, color)
    local colorStart, colorEnd, day, hour, minute, daystr, hourstr, minutestr
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    if color then
      colorStart = "<color=#" .. color .. ">"
      colorEnd = "</color>"
      if day then
        daystr = colorStart .. day .. colorEnd
      else
        daystr = day
      end
      if hour then
        hourstr = colorStart .. hour .. colorEnd
      else
        hourstr = hour
      end
      if minute then
        minutestr = colorStart .. minute .. colorEnd
      else
        minutestr = minute
      end
    else
      daystr = day
      hourstr = hour
      minutestr = minute
    end
    local timestring = ""
    if 0 < day then
      timestring = daystr .. StringTable.Get("str_activity_common_day")
      if 0 < hour then
        timestring = timestring .. hourstr .. StringTable.Get("str_activity_common_hour")
      end
    elseif 0 < hour then
      timestring = hourstr .. StringTable.Get("str_activity_common_hour")
      if 0 < minute then
        timestring = timestring .. minutestr .. StringTable.Get("str_activity_common_minute")
      end
    elseif 0 < minute then
      timestring = minutestr .. StringTable.Get("str_activity_common_minute")
    else
      timestring = StringTable.Get("str_activity_common_less_minute")
    end
    return timestring
  end,
  GetRemainTimer = function(endtime)
    local remainTime = 0
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curtime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    remainTime = endtime - curtime
    return remainTime
  end,
  ShowRewards = function(rewards, callback)
    local petIdList = {}
    local mPet = GameGlobal.GetModule(PetModule)
    for _, reward in pairs(rewards) do
      if mPet:IsPetID(reward.assetid) then
        table.insert(petIdList, reward)
      end
    end
    if table.count(petIdList) > 0 then
      GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
          if callback then
            callback()
          end
        end)
      end)
      return
    end
    GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
      if callback then
        callback()
      end
    end)
  end,
  SetGrey = function(objs, gray)
    if not objs then
      return
    end
    for _, obj in pairs(objs) do
      local rawimg = obj.gameObject:GetComponent("RawImage")
      local emiMat = UnityEngine.Material:New(rawimg.material)
      local texture = rawimg.material.mainTexture
      rawimg.material = emiMat
      rawimg.material.mainTexture = texture
      rawimg.material:SetFloat("_LuminosityAmount", gray)
    end
  end,
  GetItemIcon = function(itemid)
    local cfg = Cfg.cfg_item[itemid]
    if not cfg then
      return ""
    end
    return cfg.Icon
  end,
  GetLottleryNewName = function()
    local dbStr = "N15LottleryNew"
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    dbStr = dbStr .. pstid
    return dbStr
  end,
  GetLocalPoltNewName = function(polt_id)
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstid = roleModule:GetPstId()
    local dbStr = "n15" .. polt_id .. pstid
    return dbStr
  end,
  GetBigRawrdData = function()
    local data = {}
    data.size = {356, 357}
    data.state = {
      nomarl = "n15_shop_grand1",
      select = "n15_shop_grand2",
      pop = "n15_shop_grand3",
      grey = "n15_shop_grand4"
    }
    data.getPos = {}
    return data
  end
}
_enum("N15ToolFunctions", N15ToolFunctions)
local N15LotteryState = {
  None = 1,
  WaitRequestResult = 2,
  LotterySpine = 3,
  LotteryResultSpine = 4,
  ShowRewards = 5
}
_enum("N15LotteryState", N15LotteryState)
local N15LotteryTitle = {
  "str_n15_desert_award_pool",
  "str_n15_volcano_award_pool",
  "str_n15_gorge_award_pool"
}
_enum("N15LotteryTitle", N15LotteryTitle)
_class("DrawAnimData", Object)
DrawAnimData = DrawAnimData

function DrawAnimData:Constructor()
  self.award_idx = 0
  self.anim_idx = 0
  self.anim_speed = 0
  self.anim_time = 0
  self.anim_idx_tab = {}
  self.anim_view = false
  self.anim_end = true
end

function DrawAnimData:RefData()
  self.award_idx = 0
  self.anim_idx = 0
  self.anim_speed = 0
  self.anim_time = 0
  self.anim_view = false
  self.anim_end = true
end

function DrawAnimData:RefIDXTab()
  self.anim_idx_tab = {}
end
