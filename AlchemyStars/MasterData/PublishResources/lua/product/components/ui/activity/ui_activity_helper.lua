_class("UIActivityHelper", Object)
UIActivityHelper = UIActivityHelper

function UIActivityHelper.LoadCampaign(TT, res, campaignType, campaignId)
  local campaign = UIActivityCampaign:New()
  if campaignId then
    campaign:LoadCampaignInfo_Id(TT, res, campaignId)
  else
    campaign:LoadCampaignInfo(TT, res, campaignType)
  end
  return campaign
end

function UIActivityHelper.LoadCampaign_Local(campaignType, campaignId)
  local campaign = UIActivityCampaign:New()
  if campaignId then
    campaign:LoadCampaignInfo_Id_Local(campaignId)
  else
    campaign:LoadCampaignInfo_Local(campaignType)
  end
  return campaign
end

function UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, campaignType, table.unpack(componentIds))
  if res and res:GetSucc() and not campaign:CheckComponentOpen(table.unpack(componentIds)) then
    res.m_result = campaign:CheckComponentOpenClientError(table.unpack(componentIds))
  end
  if res and not res:GetSucc() then
    campaign:CheckErrorCode(res.m_result, nil, nil)
  end
  return campaign
end

function UIActivityHelper.StartTimerEvent(timerEvent, timerCallback, tick)
  local t = tick or 1000
  local stopSign = timerCallback()
  timerEvent = UIActivityHelper.CancelTimerEvent(timerEvent)
  if not stopSign then
    timerEvent = GameGlobal.Timer():AddEventTimes(t, TimerTriggerCount.Infinite, timerCallback)
  end
  return timerEvent
end

function UIActivityHelper.CancelTimerEvent(timerEvent)
  if timerEvent then
    GameGlobal.Timer():CancelEvent(timerEvent)
  end
  return nil
end

function UIActivityHelper.GetFormatTimerStr(time, id)
  local default_id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107"
  }
  id = id or default_id
  local timeStr = StringTable.Get(id.over)
  if time < 0 then
    return timeStr
  end
  local day, hour, min, second = UIActivityHelper.Time2Str(time)
  if 0 < day then
    timeStr = day .. StringTable.Get(id.day)
    if hour ~= 0 then
      timeStr = timeStr .. hour .. StringTable.Get(id.hour)
    end
  elseif 0 < hour then
    timeStr = hour .. StringTable.Get(id.hour)
    if min ~= 0 then
      timeStr = timeStr .. min .. StringTable.Get(id.min)
    end
  elseif 0 < min then
    timeStr = min .. StringTable.Get(id.min)
  else
    timeStr = StringTable.Get(id.zero)
  end
  return timeStr
end

function UIActivityHelper.GetFormatIntlTimeStr(time)
  local id = {
    day_hour = "str_activity_day_hour",
    day = "str_activity_day",
    hour_min = "str_activity_hour_minute",
    hour = "str_activity_hour",
    min = "str_activity_minus",
    sec = "str_activity_less_one_minus"
  }
  if time < 0 then
    return StringTable.Get(id.sec)
  end
  local timeStr
  local day, hour, min = UIActivityHelper.Time2Str(time)
  if 0 < day then
    if hour == 0 then
      timeStr = StringTable.Get(id.day, day)
    else
      timeStr = StringTable.Get(id.day_hour, day, hour)
    end
  elseif 0 < hour then
    if min == 0 then
      timeStr = StringTable.Get(id.hour, hour)
    else
      timeStr = StringTable.Get(id.hour_min, hour, min)
    end
  elseif 0 < min then
    timeStr = StringTable.Get(id.min, min)
  else
    timeStr = StringTable.Get(id.sec)
  end
  return timeStr
end

function UIActivityHelper.Time2Str(time)
  local second = time % 60
  local min = math.floor(time / 60) % 60
  local hour = math.floor(time / 60 / 60) % 24
  local day = math.floor(time / 60 / 60 / 24)
  return day, hour, min, second
end

function UIActivityHelper.GetActivityLeftTimeStr(timeStamp)
  return UIActivityHelper.GetFormatIntlTimeStrWithParam("str_activity_mission_remaining_time", UICommonHelper.CalcLeftSeconds(timeStamp))
end

function UIActivityHelper.GetActivityUICloseTimeStr(timeStamp)
  return UIActivityHelper.GetFormatIntlTimeStrWithParam("str_activity_time_tips2", UICommonHelper.CalcLeftSeconds(timeStamp))
end

function UIActivityHelper.GetActivityCmptOpenTimeStr(timeStamp)
  return UIActivityHelper.GetFormatIntlTimeStrWithParam("str_activity_start_in", UICommonHelper.CalcLeftSeconds(timeStamp))
end

function UIActivityHelper.GetActivityCmptOpenLevelStr(stageStr)
  return StringTable.Get("str_activity_common_will_open_after_clearance", StringTable.Get(stageStr))
end

function UIActivityHelper.GetFormatIntlTimeStrWithParam(strKey, timeSeconds)
  local timeStr = UIActivityHelper.GetFormatIntlTimeStr(timeSeconds)
  return StringTable.Get(strKey, timeStr)
end

function UIActivityHelper.StartLockEvent(lockName, timerEvent, callback, tick)
  if string.isnullorempty(lockName) then
    return nil
  end
  local t = tick or 1000
  UIActivityHelper.CancelLockEvent(lockName, timerEvent)
  timerEvent = GameGlobal.Timer():AddEventTimes(t, TimerTriggerCount.Once, function()
    UIActivityHelper.CancelLockEvent(lockName, timerEvent)
    if callback then
      callback()
    end
  end)
  GameGlobal.UIStateManager():Lock(lockName)
  return timerEvent
end

function UIActivityHelper.CancelLockEvent(lockName, timerEvent)
  if string.isnullorempty(lockName) then
    return nil
  end
  GameGlobal.UIStateManager():UnLock(lockName)
  if timerEvent then
    GameGlobal.Timer():CancelEvent(timerEvent)
  end
  return nil
end

function UIActivityHelper.GetCampaignMainBg(campaign, idx)
  local cfg_campaign = Cfg.cfg_campaign[campaign._id]
  if cfg_campaign then
    local url = cfg_campaign.BGImage
    return url and url[idx]
  end
end

function UIActivityHelper.GetCampaignFirstEnterStoryID(campaign, idx)
  local cfg_campaign = Cfg.cfg_campaign[campaign._id]
  if cfg_campaign then
    local id = cfg_campaign.FirstEnterStoryID
    return id and id[idx]
  end
end

function UIActivityHelper.PlayFirstPlot_Campaign(campaign, callback, autoCloseStoryUI)
  if not campaign:CheckCampaignOpen() then
    if callback then
      callback()
    end
    return
  end
  local storyId = UIActivityHelper.GetCampaignFirstEnterStoryID(campaign, 1)
  UIActivityHelper._PlayFirstPlot("PlayFirstPlot_Campaign_" .. campaign._id, storyId, callback, autoCloseStoryUI)
end

function UIActivityHelper.PlayFirstPlot_Component(campaign, componentId, callback, autoCloseStoryUI)
  if not campaign:CheckComponentOpen(componentId) then
    if callback then
      callback()
    end
    return
  end
  local component = campaign:GetComponent(componentId)
  local storyId = component:GetComponentInfo().m_first_story_id
  UIActivityHelper._PlayFirstPlot("PlayFirstPlot_Component_" .. campaign._id .. "_" .. componentId, storyId, callback, autoCloseStoryUI)
end

function UIActivityHelper._PlayFirstPlot(keyStr, storyId, callback, autoCloseStoryUI)
  if not (keyStr and storyId) or storyId == 0 then
    Log.info("UIActivityHelper._PlayFirstPlot() keyStr == ", keyStr, ", storyId == ", storyId)
    if callback then
      callback()
    end
    return
  end
  keyStr = UIActivityHelper.GetLocalDBKeyWithPstId(keyStr .. "_")
  if LocalDB.HasKey(keyStr) then
    Log.info("UIActivityHelper._PlayFirstPlot() HasKey! keyStr == ", keyStr)
    if callback then
      callback()
    end
    return
  else
    Log.info("UIActivityHelper._PlayFirstPlot() SetKey! keyStr == ", keyStr)
    LocalDB.SetInt(keyStr, 1)
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", storyId, callback, autoCloseStoryUI)
  end
end

function UIActivityHelper.OpenCampaignShop(campaign)
  local campaignType = campaign._type
  local cfgs = Cfg.cfg_shop_campaign_secret_tab({CampaignType = campaignType})
  local cfg = cfgs and cfgs[1]
  if not cfg then
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIShopController", nil, ShopMainTabType.Secret, cfg.ID, campaign)
end

function UIActivityHelper.IsYJEnough(cost)
  local mShop = GameGlobal.GetModule(ShopModule)
  local count, countFree = mShop:GetDiamondCount()
  local total = count
  local isEnough = cost <= total
  local diff = cost - total
  return isEnough, diff
end

function UIActivityHelper.CheckCampaignSampleNewPoint(campaign)
  local nonuse = UIActivityHelper.CheckCampaignSampleNewPoint_Nonuse(campaign._type)
  local customFunc = UIActivityHelper.CheckCampaignSampleNewPoint_CustomFunc(campaign._type)
  if nonuse then
    return false
  elseif customFunc then
    return customFunc(campaign)
  else
    return campaign:CheckCampaignNew()
  end
end

function UIActivityHelper.CheckCampaignSampleNewPoint_CustomFunc(campaignType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_N19_COMMON] = UIN19Helper.GetNewPoint
  }
  return tb[campaignType]
end

function UIActivityHelper.CheckCampaignSampleNewPoint_Nonuse(campaignType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN] = true,
    [ECampaignType.CAMPAIGN_TYPE_HAVESTTIME] = true,
    [ECampaignType.CAMPAIGN_TYPE_INLAND_FIRSTPET] = true,
    [ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY] = true
  }
  return tb[campaignType]
end

function UIActivityHelper.CheckCampaignSampleRedPoint(campaign)
  local nonuse = UIActivityHelper.CheckCampaignSampleRedPoint_Nonuse(campaign._type)
  local customFunc = UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaign._type)
  if nonuse then
    return false
  elseif customFunc then
    return customFunc(campaign)
  else
    return campaign:CheckCampaignRed()
  end
end

function UIActivityHelper.CheckCampaignSampleRedPoint_CustomFunc(campaignType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_BATTLEPASS] = UIActivityBattlePassHelper.CheckCampaignRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_BACK_PHASE_II] = UIActivityReturnSystemHelper.CheckCampaignRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN] = UIActivityHelper.CheckSeniorSkinRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_ANNIVERSARY] = UIActivityAnniversaryLoginHelper.CheckCampaignRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY] = UIN31SecondAnniversaryContent.CheckCampaignRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY] = UIActivityHelper.CheckSeniorSkinRedPoint,
    [ECampaignType.CAMPAIGN_TYPE_INLAND_FIRSTPET] = UIActivityPetTryHelper.CheckCampaignRedPoint
  }
  return tb[campaignType]
end

function UIActivityHelper.CheckCampaignSampleRedPoint_Nonuse(campaignType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_HAVESTTIME] = true
  }
  return tb[campaignType]
end

function UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
  if not newObj and not redObj then
    return
  end
  if newObj and redObj then
    local same = redObj == newObj
    if same then
      newObj:SetActive(new or red)
    else
      newObj:SetActive(new)
      redObj:SetActive(not new and red)
    end
  elseif newObj then
    newObj:SetActive(new)
  elseif redObj then
    redObj:SetActive(red)
  end
end

function UIActivityHelper.SetCmptRedViewed(cmptKey)
  local nextFive = GameGlobal.GetModule(LoginModule):GetNextTimeStampByHMS(5, 0, 0)
  local key = "UIActivityRed" .. cmptKey
  LocalDB.SetInt(UIActivityHelper.GetLocalDBKeyWithPstId(key), nextFive)
end

function UIActivityHelper.HasCmptRedViewed(cmptKey)
  local key = "UIActivityRed" .. cmptKey
  local val = LocalDB.GetInt(UIActivityHelper.GetLocalDBKeyWithPstId(key))
  if val == 0 then
    return false
  else
    local svrTime = math.modf(GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001)
    return val > svrTime
  end
end

function UIActivityHelper.ShowUIGetRewards(rewards, doNotSort)
  if not rewards then
    return
  end
  local itemList = {}
  local petList = {}
  local petSkinList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, v in pairs(rewards) do
    if petModule:IsPetID(v.assetid) then
      table.insert(petList, v)
    elseif petModule:IsPetSkinID(v.assetid) then
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = petModule:GetSkinIDFromItemID(v.assetid)
      roleAsset.count = v.count
      table.insert(petSkinList, roleAsset)
    else
      table.insert(itemList, v)
    end
  end
  UIActivityHelper.ShowUIGetRewards_Pet(petList, petSkinList, itemList, doNotSort)
end

function UIActivityHelper.ShowUIGetRewards_Pet(petList, petSkinList, itemList, doNotSort)
  if table.count(petList) <= 0 then
    UIActivityHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, doNotSort)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petList, function()
    GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
    UIActivityHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, doNotSort)
  end)
  return
end

function UIActivityHelper.ShowUIGetRewards_PetSkin(petSkinList, itemList, doNotSort)
  if table.count(petSkinList) <= 0 then
    UIActivityHelper.ShowUIGetRewards_Item(itemList, doNotSort)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #petSkinList then
      return petSkinList[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UIPetSkinObtainController")
    local nextAsset = showNextFunc()
    if nextAsset then
      UIActivityHelper.ShowUIGetRewards_PetSkin_Single(nextAsset, callBackFunc)
    else
      UIActivityHelper.ShowUIGetRewards_Item(itemList, doNotSort)
    end
  end
  
  UIActivityHelper.ShowUIGetRewards_PetSkin_Single(showNextFunc(), callBackFunc)
end

function UIActivityHelper.ShowUIGetRewards_PetSkin_Single(roleAsset, callBackFunc)
  if not roleAsset then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIPetSkinObtainController", roleAsset, callBackFunc)
end

function UIActivityHelper.ShowUIGetRewards_Item(itemList, doNotSort)
  if table.count(itemList) <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", itemList, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, 0)
  end, doNotSort)
end

function UIActivityHelper.GetLocalDBKeyWithPstId(keyStr)
  local roleModule = GameGlobal.GetModule(RoleModule)
  return keyStr .. roleModule:GetPstId()
end

function UIActivityHelper.GetDebugOpenKey()
  return UIActivityHelper.GetLocalDBKeyWithPstId("UIActivityHelper_GetDebugOpenKey_")
end

function UIActivityHelper.CheckDebugOpen()
  local show = EngineGameHelper.IsDevelopmentBuild() or HelperProxy:GetInstance():GetConfig("EnableTestFunc", "false") == "true"
  return show and LocalDB.HasKey(UIActivityHelper.GetDebugOpenKey())
end

function UIActivityHelper.GetStringTableArray(key)
  local tb = {}
  local n = 0
  while true do
    n = n + 1
    local b = StringTable.Has(key .. n)
    if b then
      table.insert(tb, key .. n)
    else
      n = n - 1
      break
    end
  end
  if n <= 0 then
    Log.fatal("UIActivityHelper.GetStringTableArray() no [", key, n, "] in str_xxx.xlsx")
  end
  return tb
end

function UIActivityHelper.GetColorText(...)
  local str = ""
  local tb = {
    ...
  }
  for i = 1, #tb, 2 do
    str = string.format("%s<color=%s>%s</color>", str, tb[i], tb[i + 1])
  end
  return str
end

function UIActivityHelper.GetRichText(...)
  local str = ""
  local tb = {
    ...
  }
  for i = 1, #tb, 2 do
    local p = tb[i]
    local t = tb[i + 1]
    for k, v in pairs(p) do
      t = string.format("<%s=%s>%s</%s>", k, v, t, k)
    end
    str = str .. t
  end
  return str
end

function UIActivityHelper._GetRichText(param, text)
  return string.format("<%s=%s>%s</%s>")
end

function UIActivityHelper._DightNum(inNum)
  local num = tonumber(inNum)
  if not num then
    return -1
  end
  if math.floor(num) ~= num or num < 0 then
    return -1
  elseif 0 == num then
    return 1
  else
    local tmp_dight = 0
    while 0 < num do
      num = math.floor(num / 10)
      tmp_dight = tmp_dight + 1
    end
    return tmp_dight
  end
end

function UIActivityHelper.GetZeroStrFrontNum(dest_dight, num)
  local num_dight = UIActivityHelper._DightNum(num)
  if -1 == num_dight then
    return ""
  elseif dest_dight <= num_dight then
    return ""
  else
    local str_e = ""
    for var = 1, dest_dight - num_dight do
      str_e = str_e .. "0"
    end
    return str_e
  end
end

function UIActivityHelper.FormatNumber_PreZero(dest_dight, num, c1, c2)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(dest_dight, num)
  if c1 and c2 then
    return UIActivityHelper.GetColorText(c1, preZero, c2, num)
  else
    return preZero .. num
  end
end

function UIActivityHelper.AddZeroFrontNum(dest_dight, num)
  local num_dight = UIActivityHelper._DightNum(num)
  if -1 == num_dight then
    return num
  elseif dest_dight <= num_dight then
    return tostring(num)
  else
    local str_e = ""
    for var = 1, dest_dight - num_dight do
      str_e = str_e .. "0"
    end
    return str_e .. tostring(num)
  end
end

function UIActivityHelper.CalPlayerPersonProgressRank(cmptCfgId, progress)
  local rank = 1
  local cfgGroup = Cfg.cfg_activity_person_progress_extra_client({ComponentID = cmptCfgId})
  if cfgGroup and 0 < #cfgGroup then
    for index, value in ipairs(cfgGroup) do
      if value.NpcName and progress < value.ItemCount then
        rank = rank + 1
      end
    end
  end
  return rank
end

function UIActivityHelper.ShowActivityIntro(activityIntroKey)
  local introCfg = Cfg.cfg_activityintro[activityIntroKey]
  if introCfg then
    local uiName = "UIActivityIntroController"
    if string.isnullorempty(introCfg.SpecialUi) then
    else
      uiName = introCfg.SpecialUi
    end
    GameGlobal.UIStateManager():ShowDialog(uiName, activityIntroKey)
  end
end

function UIActivityHelper.NoRed()
  return false
end

function UIActivityHelper.GetComponentID(info)
  local componentId = info.m_campaign_id * CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD + info.m_component_type * CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD + info.m_component_id
  return componentId
end

function UIActivityHelper.CheckSeniorSkinRedPoint(campaign)
  local info = campaign:GetComponentInfo(ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  if not info then
    return false
  end
  local componentId = info.m_campaign_id * CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD + info.m_component_type * CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD + info.m_component_id
  local nextShake = info.shake_num + 1
  local cost = Cfg.cfg_component_senior_skin_cost({ComponentID = componentId, SeqID = nextShake})
  if cost then
    return cost[1].CostItemCount == 0
  end
  return false
end

function UIActivityHelper.Snap(blurHelper, safeAreaSize, camera, callback)
  blurHelper.width = safeAreaSize.x
  blurHelper.height = safeAreaSize.y
  blurHelper.OwnerCamera = camera
  blurHelper:CleanRenderTexture()
  local rt = blurHelper:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    if callback then
      callback(cache_rt)
    end
  end)
end

function UIActivityHelper.Snap_SetImgRt(imgRT, uiView, widgetName, callback)
  local setImgRt = imgRT ~= nil
  if setImgRt then
    local rt = uiView:GetUIComponent("RawImage", widgetName)
    rt.texture = imgRT
  end
  if callback then
    callback(setImgRt)
  end
end

function UIActivityHelper.SpawnPetEnhanceArea(uiView, widgetName, componentCfgId, uiStyle)
  local petEnhanceAreaGen = uiView:GetUIComponent("UISelectObjectPath", widgetName)
  if petEnhanceAreaGen then
    local cfgGroup = Cfg.cfg_campaign_mission_pet_correct({ComponentID = componentCfgId})
    local petEnhanceArea = petEnhanceAreaGen:SpawnObject("UIActivityPetEnhanceAreaWidget")
    if petEnhanceArea then
      petEnhanceArea:SetData(componentCfgId, uiStyle)
    end
  end
end

function UIActivityHelper.GetLocalDBKeyWithPstId(keyStr)
  local roleModule = GameGlobal.GetModule(RoleModule)
  return keyStr .. roleModule:GetPstId()
end

function UIActivityHelper.HasLocalDB(key)
  return LocalDB.HasKey(UIActivityHelper.GetLocalDBKeyWithPstId("UIActivity" .. key))
end

function UIActivityHelper.SetLocalDB(key)
  LocalDB.SetInt(UIActivityHelper.GetLocalDBKeyWithPstId("UIActivity" .. key), 1)
end
