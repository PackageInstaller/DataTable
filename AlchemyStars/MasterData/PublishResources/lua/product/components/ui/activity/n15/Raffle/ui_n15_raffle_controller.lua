_class("UIN15RaffleController", UIController)
UIN15RaffleController = UIN15RaffleController

function UIN15RaffleController:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN15RaffleController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  if self._campaign._type == -1 or self._campaign._id == -1 then
    self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N15)
  else
    self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N15)
  self._draw_cpt = self._campaign:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY)
  self._raffle_info = self._campaign:GetComponentInfo(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY)
end

function UIN15RaffleController:OnShow(uiParams)
  self:_InitParmams(uiParams)
  self:_InitAnim()
  self:_InitWidget()
  self:_RefView()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._RefRedState)
end

function UIN15RaffleController:OnHide()
end

function UIN15RaffleController:_InitParmams(uiParams)
  self._select_info = nil
  self._jackpots = nil
  self._raffle_pool = {}
  self._totalpage = 0
  self._curpage = 0
  self._jackpots = self._raffle_info.m_jackpots
  self._totalpage = #self._jackpots
  self._isOpenNew = false
  self._taskids = {}
  self:_InitSpineParm()
end

function UIN15RaffleController:_InitWidget()
  self._left_btn_obj = self:GetGameObject("_left_btn")
  self._right_btn_obj = self:GetGameObject("_right_btn")
  self._polt_view_btn_obj = self:GetGameObject("_polt_view_btn")
  self._raffel_state_obj = self:GetGameObject("_raffel_state")
  self._singleMask = self:GetGameObject("singleMask")
  self._moreMask = self:GetGameObject("moreMask")
  self._lockState = self:GetGameObject("lockState")
  self._raffle_single_btn_obj = self:GetGameObject("_raffle_single_btn")
  self._raffle_more_btn_obj = self:GetGameObject("_raffle_more_btn")
  self._title_txt = self:GetUIComponent("UILocalizationText", "_title_txt")
  self._remain_award_txt = self:GetUIComponent("UILocalizationText", "_remain_award_txt")
  self._single_count_txt = self:GetUIComponent("UILocalizationText", "_single_count_txt")
  self._more_count_txt = self:GetUIComponent("UILocalizationText", "_more_count_txt")
  self._prop_txt = self:GetUIComponent("UILocalizationText", "_prop_txt")
  self._more_txt = self:GetUIComponent("UILocalizationText", "_more_txt")
  self._raffle_token_i = self:GetUIComponent("UILocalizationText", "_raffle_token_i")
  self._raffle_token_ii = self:GetUIComponent("UILocalizationText", "_raffle_token_ii")
  self._raffle_single_btn_cgp = self:GetUIComponent("CanvasGroup", "_raffle_single_btn")
  self._raffle_more_btn_cgp = self:GetUIComponent("CanvasGroup", "_raffle_more_btn")
  self._wheel1 = self:GetUIComponent("RawImageLoader", "wheel1")
  self._wheel2 = self:GetUIComponent("RawImageLoader", "wheel2")
  self._wheel3 = self:GetUIComponent("RawImageLoader", "wheel3")
  self._anim = self.view.gameObject:GetComponent("Animation")
  self._dgAnim = self:GetUIComponent("Animation", "dg")
  self._jump_obj = self:GetGameObject("jump")
  self._jump_obj:SetActive(false)
  self._redObj = self:GetGameObject("red")
  self:_InitSpineWidget()
end

function UIN15RaffleController:_RefView()
  self:_InitPolt()
  self._polt_view_btn_obj:SetActive(false)
  self._lockState:SetActive(false)
  local dbStr = N15ToolFunctions.GetLottleryNewName()
  LocalDB.SetInt(dbStr, 1)
  local back_btn = self:GetUIComponent("UISelectObjectPath", "_point_back")
  self._commonTopBtn = back_btn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    if self._draw_state or self._polt_state then
      return
    end
    if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
      ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
      self:SwitchState(UIStateType.UIMain)
      return
    end
    self:SwitchState(UIStateType.UIN15MainController)
  end, nil, function()
    if self._draw_state or self._polt_state then
      return
    end
    self:SwitchState(UIStateType.UIMain)
  end, false)
  self._commonTopBtn:HideHomeBtn()
  local select_info_pool = self:GetUIComponent("UISelectObjectPath", "_select_info_pool")
  self._select_info = select_info_pool:SpawnObject("UISelectInfo")
  local raffle_pool = self:GetGameObject("_raffle_pool").transform
  for i = 1, raffle_pool.childCount do
    local item = raffle_pool:GetChild(i - 1)
    local loader = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local raffle_item = loader:SpawnObject("UIN15RaffleItem")
    self._raffle_pool[#self._raffle_pool + 1] = raffle_item
  end
  for idx, jackpot in ipairs(self._jackpots) do
    if not self._draw_cpt:IsLotteryJeckpotNoRestBigReward(idx) and self:_CheckLotteryState(idx) then
      self._curpage = idx
      self:_RefRafflePool()
      break
    end
  end
  if self._curpage == 0 then
    self._curpage = #self._jackpots
    self:_RefRafflePool()
  end
  if 1 >= self._curpage then
    self._left_btn_obj:SetActive(false)
    self._right_btn_obj:SetActive(true)
  end
  if self._curpage >= self._totalpage then
    self._right_btn_obj:SetActive(false)
    self._left_btn_obj:SetActive(true)
  end
  self:_SetTxt()
  self:_SpineLoader()
end

function UIN15RaffleController:_RefRafflePool()
  self:_SetTxt()
  self:_RefRedState()
  self._polt_view_btn_obj:SetActive(false)
  if self._curpage <= 1 then
    self._left_btn_obj:SetActive(false)
    self._right_btn_obj:SetActive(true)
  elseif self._curpage >= self._totalpage then
    self._right_btn_obj:SetActive(false)
    self._left_btn_obj:SetActive(true)
  else
    self._right_btn_obj:SetActive(true)
    self._left_btn_obj:SetActive(true)
  end
  local gray = self:_RefGrey()
  for idx, raffle_item in ipairs(self._raffle_pool) do
    raffle_item:SetData(self._jackpots[self._curpage][idx], function(item_id, pos)
      self._select_info:SetData(item_id, pos)
    end, idx == 1, function(animName)
      self._anim:Stop()
      self._anim:Play(animName)
    end)
  end
  if gray == 0 then
    for idx, raffle_item in ipairs(self._raffle_pool) do
      raffle_item:SetGrey(0)
    end
  end
end

function UIN15RaffleController:_RefGrey()
  local gray = 0
  if self._draw_cpt:IsLotteryJeckpotEmpty(self._curpage) or not self._draw_cpt:IsLotteryJackpotUnlock(self._curpage) then
    self._wheel1:LoadImage("n15_shop_light4")
    self._wheel2:LoadImage("n15_shop_light5")
    self._wheel3:LoadImage("n15_shop_light6")
  end
  if self._draw_cpt:IsLotteryJackpotUnlock(self._curpage) then
    self._raffle_single_btn_obj:SetActive(true)
    self._raffle_more_btn_obj:SetActive(true)
    self._lockState:SetActive(false)
    self._wheel1:LoadImage("n15_shop_light1")
    self._wheel2:LoadImage("n15_shop_light2")
    self._wheel3:LoadImage("n15_shop_light3")
    gray = 1
  else
    self._lockState:SetActive(true)
    self._raffle_single_btn_obj:SetActive(false)
    self._raffle_more_btn_obj:SetActive(false)
    gray = 0
  end
  return gray
end

function UIN15RaffleController:_JumpJackpot()
  if self._draw_state or self._polt_state then
    return
  end
  if self._curpage <= self._totalpage then
    self:StartTask(function(TT)
      local lockName = "UIN15RaffleController:_Page"
      self:Lock(lockName)
      self._anim:Play("uieffanim_N15_Raffle_Center_out")
      YIELD(TT, 500)
      self._curpage = self._curpage + 1
      self:_RefRafflePool()
      self._anim:Play("uieffanim_N15_Raffle_Center_in")
      YIELD(TT, 500)
      self:UnLock(lockName)
    end)
  end
end

function UIN15RaffleController:_DoRaffle(lotteryType)
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if self._draw_state or self._polt_state then
    return
  end
  self:_RefSpineState()
  self._polt_view_btn_obj:SetActive(false)
  local lockName = "AsyncRequestRes:_N15Raffle"
  self:Lock(lockName)
  self._drawTask = self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local getRewards, isOpenNew = self._draw_cpt:HandleLottery(TT, res, self._curpage, lotteryType)
    self._isOpenNew = isOpenNew
    self._getRewards_tab = getRewards
    if res:GetSucc() then
      self:UnLock(lockName)
      self._jump_obj:SetActive(true)
      self._draw_state = true
      self:_DrawSpineAnim(lotteryType)
      local canDrawOnceMore = self._draw_cpt:IsLotteryJeckpotEmpty(lotteryType)
      local curBoxHasRest = self._draw_cpt:IsLotteryJeckpotEmpty(lotteryType)
      if getRewards then
        self:_GetRewards(getRewards)
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15RaffleBGM)
      end
    else
      self:UnLock(lockName)
      if res:GetResult() == CampaignErrorType.E_COMPONENT_LOTTERY_COST_ITEM_NOT_ENOUGH then
        ToastManager.ShowToast(StringTable.Get("str_n15_raffle_not_enough"))
      end
    end
  end)
end

function UIN15RaffleController:_GetRewards(getRewards)
  self._awards = {}
  self._big_award = {}
  if 0 < #getRewards then
    for i = 1, #getRewards do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = getRewards[i].m_item_id
      roleAsset.count = getRewards[i].m_count
      if getRewards[i].m_is_big_reward then
        table.insert(self._big_award, roleAsset)
      else
        table.insert(self._awards, roleAsset)
      end
    end
  end
  self:StartTask(function(TT)
    self._get_award_tab = {}
    for idx, award in ipairs(getRewards) do
      if not table.iskey(self._get_award_tab, award.m_awaid_id) then
        self._get_award_tab[award.m_awaid_id] = 1
      else
        self._get_award_tab[award.m_awaid_id] = self._get_award_tab[award.m_awaid_id] + 1
      end
    end
    self:_RefDrawAward(getRewards)
  end)
end

function UIN15RaffleController:_SetTxt()
  local curCount = ClientCampaignDrawShop.GetMoney(self._raffle_info.m_cost_item_id)
  self:_RefreshMoney()
  self._title_txt:SetText(StringTable.Get(N15LotteryTitle[self._curpage]))
  local rest, total = self._draw_cpt:GetLotteryCount(self._curpage)
  self._remain_award_txt:SetText(rest .. "/" .. total)
  self._single_count_txt:SetText(self._raffle_info.m_cost_count)
  local remain_count = 0
  if rest < self._raffle_info.m_multi_lottery and rest ~= 0 then
    remain_count = rest
  else
    remain_count = self._raffle_info.m_multi_lottery
  end
  local str = StringTable.Get("str_n15_more", StringTable.Get("str_n15_number_" .. remain_count))
  self._more_txt:SetText(str)
  self._more_count_txt:SetText(self._raffle_info.m_cost_count * remain_count)
  if rest <= 0 then
    self._raffle_more_btn_cgp.blocksRaycasts = false
    self._raffle_single_btn_cgp.blocksRaycasts = false
    self._singleMask:SetActive(true)
    self._moreMask:SetActive(true)
  else
    self._raffle_more_btn_cgp.blocksRaycasts = true
    self._raffle_single_btn_cgp.blocksRaycasts = true
    self._singleMask:SetActive(false)
    self._moreMask:SetActive(false)
  end
  if curCount < self._raffle_info.m_cost_count then
    if rest <= 0 then
      self._raffle_more_btn_cgp.blocksRaycasts = false
      self._raffle_single_btn_cgp.blocksRaycasts = false
    else
      self._raffle_more_btn_cgp.blocksRaycasts = true
      self._raffle_single_btn_cgp.blocksRaycasts = true
    end
    self._singleMask:SetActive(true)
    self._moreMask:SetActive(true)
  else
    if curCount < self._raffle_info.m_cost_count * self._raffle_info.m_multi_lottery then
      if curCount < self._raffle_info.m_cost_count then
        self._singleMask:SetActive(true)
      else
        self._singleMask:SetActive(false)
      end
      if rest <= 0 then
        self._raffle_single_btn_cgp.blocksRaycasts = false
        self._raffle_more_btn_cgp.blocksRaycasts = false
      else
        self._raffle_single_btn_cgp.blocksRaycasts = true
        self._raffle_more_btn_cgp.blocksRaycasts = true
      end
      self._moreMask:SetActive(true)
    else
    end
  end
end

function UIN15RaffleController:_RefRedState()
  self:_SpineLoader()
  self:_RefSpineState()
  local poltRed = self._process:GetPoltRedDot()
  self:StartTask(function(TT)
    YIELD(TT, 10)
    self._redObj:SetActive(poltRed)
  end)
end

function UIN15RaffleController:_RefreshMoney()
  local count = ClientCampaignDrawShop.GetMoney(self._raffle_info.m_cost_item_id)
  self._raffle_token_i:SetText(string.format("%07d", count))
  self._raffle_token_ii:SetText(count)
end

function UIN15RaffleController:_CheckLotteryState(lottery_idx)
  return self._draw_cpt:IsLotteryJackpotUnlock(lottery_idx)
end

function UIN15RaffleController:_GetAward(TT)
  self._jump_obj:SetActive(false)
  for idx, raffle in ipairs(self._raffle_pool) do
    if table.iskey(self._get_award_tab, raffle:GetAwardId()) then
      raffle:SetGetAward(self._get_award_tab[raffle:GetAwardId()])
    end
  end
  YIELD(TT, 800)
  if #self._big_award ~= 0 then
    N15ToolFunctions.ShowRewards(self._big_award, function()
      if #self._awards ~= 0 then
        self:_ShowReward()
      end
      self:_ClearDirSpine()
    end)
  else
    self:_ShowReward()
    self:_ClearDirSpine()
  end
end

function UIN15RaffleController:_ShowReward()
  N15ToolFunctions.ShowRewards(self._awards, function()
    self:_RefRafflePool()
    self:_GetNewPolt()
    if self._polt then
      self._polt_state = true
      self:ShowDialog("UIN15RafflePopController", function()
        self:_PoltSpineLoader(self._polt.event_id)
      end)
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N15RafflePop)
    elseif self._isOpenNew then
      self:_JumpJackpot()
    end
  end)
end

function UIN15RaffleController:_PlayPolt(polt_id)
  self:ShowDialog("UIStoryController", polt_id, function()
    local dbstr = N15ToolFunctions.GetLocalPoltNewName(polt_id)
    LocalDB.SetInt(dbstr, 1)
    self._polt_view_btn_obj:SetActive(false)
    if self._isOpenNew then
      self:_JumpJackpot()
    end
  end)
end

function UIN15RaffleController:_InitPolt()
  local polts, draw_time = self._draw_cpt:RandEventInfo()
  self._polt_tab = polts
  self._draw_time = draw_time
  self._polt_state = false
  self._polt = nil
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  self._polt_time_local_name = "n15_polt_time_" .. pstid
end

function UIN15RaffleController:RefPolt()
  local polts, draw_time = self._draw_cpt:RandEventInfo()
  self._draw_time = draw_time
end

function UIN15RaffleController:_GetNewPolt()
  self:RefPolt()
  local last_draw_time = LocalDB.GetInt(self._polt_time_local_name, 0)
  local diff_total = self._draw_time - last_draw_time
  local diff_polt
  if 0 < diff_total then
    for idx, polt in ipairs(self._polt_tab) do
      local diff = polt.lottery_times - last_draw_time
      if diff_total >= diff and 0 < diff then
        diff_polt = polt
      end
    end
  end
  self._polt = diff_polt
  LocalDB.SetInt(self._polt_time_local_name, self._draw_time)
end

function UIN15RaffleController:_InitAnim()
  self._draw_cfg = Cfg.cfg_n15_draw_time[1]
  self._draw_state = false
  self._limit = 5
  self._award_time = 0
  self._award_count = 0
  self._draw_anim_tab = {}
  for i = 1, 5 do
    local anim_data = DrawAnimData.New()
    self._draw_anim_tab[i] = anim_data
  end
end

function UIN15RaffleController:_RefDrawAward(award_tab)
  self._dgAnim.gameObject:SetActive(true)
  self._dgAnim:Play("uieffanim_N15_Raffle_deng")
  self._award_count = 0
  local award_time = #award_tab
  for idx, anim_data in ipairs(self._draw_anim_tab) do
    anim_data:RefData()
    anim_data:RefIDXTab()
  end
  for idx, v in ipairs(self._draw_anim_tab) do
    if idx > award_time then
      break
    end
    v.award_idx = award_tab[idx].m_awaid_id
  end
  for i, v in ipairs(self._draw_anim_tab) do
    for index, value in ipairs(self._raffle_pool) do
      if index > #self._jackpots[self._curpage] then
        break
      end
      if not value:GetState() then
        table.insert(v.anim_idx_tab, index)
      end
    end
  end
  self._award_time = award_time
  if 1 < award_time then
    self:_PlayMoreAnim(award_time)
  else
    self:_PlaySingleAnim(self._draw_anim_tab[1])
  end
end

function UIN15RaffleController:_PlayMoreAnim(award_time)
  self._award_time = award_time
  local id = self:StartTask(function(TT)
    if self._award_time <= self._limit then
      local v = self._draw_anim_tab[1]
      self:_PlaySingleAnim(v)
      for i = 2, self._award_time do
        local var = self._draw_anim_tab[i]
        var.anim_view = true
      end
    else
      for i = 1, #self._draw_anim_tab do
        local v = self._draw_anim_tab[i]
        self:_PlaySingleAnim(v)
        YIELD(TT, 500)
      end
    end
  end)
  table.insert(self._taskids, id)
end

function UIN15RaffleController:_PlaySingleAnim(anim_data)
  anim_data.anim_end = false
  anim_data.anim_idx = 0
  local id = self:StartTask(function(anim_data, TT)
    self:_StartAnim(TT, anim_data)
  end, anim_data)
  table.insert(self._taskids, id)
end

function UIN15RaffleController:_StartAnim(TT, anim_data)
  anim_data.anim_speed = 0.8
  for i = 1, 5 do
    YIELD(TT, 100)
    anim_data.anim_speed = anim_data.anim_speed - 0.1
  end
  YIELD(TT, 2000)
  anim_data.anim_view = true
  return anim_data
end

function UIN15RaffleController:_SetHaloPos(anim_data, last_idx, idx, anim_idx)
  self._raffle_pool[anim_data.anim_idx_tab[last_idx]]:SetRaffleHighLight(false)
  self._raffle_pool[anim_data.anim_idx_tab[idx]]:SetRaffleHighLight(true)
  local award_idx = self._raffle_pool[anim_data.anim_idx_tab[idx]]:GetAwardId()
  if anim_data.anim_view and award_idx == self._getRewards_tab[self._award_count + 1].m_awaid_id then
    self._raffle_pool[anim_data.anim_idx_tab[idx]]:PlayAnim()
    anim_data.anim_end = true
    self._award_count = self._award_count + 1
    anim_data.award_idx = self._getRewards_tab[self._award_count].m_awaid_id
    self._raffle_pool[anim_data.award_idx]:SetSelectHighLight()
    if self._award_count < self._award_time then
      if self._award_count >= self._limit or self._award_time <= self._limit then
        self:_PlaySingleAnim(self._draw_anim_tab[self._award_count % 5 + 1])
      end
    else
      self:StartTask(function(TT)
        self._dgAnim:Stop("uieffanim_N15_Raffle_deng")
        self._dgAnim.gameObject:SetActive(false)
        self:_GetAward(TT)
        self._draw_state = false
      end)
    end
  end
end

function UIN15RaffleController:_PlayDrawAnim(ms)
  if self._award_time ~= 0 then
    ms = self._draw_cfg.Ms[self._award_time]
  end
  for idx, v in ipairs(self._draw_anim_tab) do
    self:_PlayAnim(v, idx, ms)
  end
end

function UIN15RaffleController:_PlayAnim(anim_data, idx, ms)
  if anim_data.anim_end then
    return
  end
  anim_data.anim_time = anim_data.anim_time + ms / 1000
  if anim_data.anim_time >= anim_data.anim_speed then
    anim_data.anim_time = 0
    anim_data.anim_idx = anim_data.anim_idx + 1
    local last_idx = anim_data.anim_idx - 1
    if last_idx == 0 then
      last_idx = #anim_data.anim_idx_tab
    end
    if anim_data.anim_idx > #anim_data.anim_idx_tab then
      anim_data.anim_idx = 1
      last_idx = #anim_data.anim_idx_tab
    end
    self:_SetHaloPos(anim_data, last_idx, anim_data.anim_idx, idx)
  end
end

function UIN15RaffleController:_StopDrawAnim()
  for _, id in ipairs(self._taskids) do
    GameGlobal.TaskManager():KillTask(id)
  end
  self._taskids = {}
  self:StartTask(function(TT)
    self._dgAnim:Stop("uieffanim_N15_Raffle_deng")
    self._dgAnim.gameObject:SetActive(false)
    if #self._big_award ~= 0 then
      N15ToolFunctions.ShowRewards(self._big_award, function()
        if #self._awards ~= 0 then
          self:_ShowReward()
        end
        self:_ClearDirSpine()
      end)
    else
      self:_ShowReward()
      self:_ClearDirSpine()
    end
    self._draw_state = false
  end)
  for idx, anim_data in ipairs(self._draw_anim_tab) do
    anim_data:RefData()
    anim_data:RefIDXTab()
  end
  self._jump_obj:SetActive(false)
end

function UIN15RaffleController:_InitSpineParm()
  self._jackpotSpineCfg = Cfg.cfg_n15_jackpot_spine({})
  self._poltCfg = Cfg.cfg_n15_polt_event({})
  self._spineAnimCfg = Cfg.cfg_n15_polt_spine_anim({})
end

function UIN15RaffleController:_InitSpineWidget()
  self._bgNeraSpine = self:GetUIComponent("SpineLoader", "_bgNeraSpine")
  self._bgFarSpine = self:GetUIComponent("SpineLoader", "_bgFarSpine")
  self._mainSpine = self:GetUIComponent("SpineLoader", "_mainSpine")
  self._poltSpien = self:GetUIComponent("SpineLoader", "_poltSpine")
  local spienDir = self:GetGameObject("spineDir").transform
  self._dirSpines = {}
  self._dirRects = {}
  for i = 0, spienDir.childCount - 1 do
    if spienDir:GetChild(i).gameObject.name ~= "mainSpine" then
      local dirSpine = spienDir:GetChild(i):GetComponent("SpineLoader")
      local dirRect = spienDir:GetChild(i):GetComponent("RectTransform")
      table.insert(self._dirSpines, dirSpine)
      table.insert(self._dirRects, dirRect)
    end
  end
  self._poltRect = self:GetUIComponent("RectTransform", "_poltSpine")
  self._mainRect = self:GetUIComponent("RectTransform", "_mainSpine")
end

function UIN15RaffleController:_SpineLoader()
  local cfg = self._jackpotSpineCfg[self._curpage]
  self._bgNeraSpine:LoadSpine(cfg.BgNera)
  self._bgFarSpine:LoadSpine(cfg.BgFar)
  self._bgNeraSpineSke = self._bgNeraSpine.CurrentSkeleton
  self._bgFarSpineSke = self._bgFarSpine.CurrentMultiSkeleton
  self._bgFarSpineSke.UseInstanceMaterials = true
  
  function self._bgFarSpineSke.OnInstanceMaterialCreated(material)
    material:SetFloat("_StencilComp", 3)
    material:SetFloat("_StencilWriteMask", 0)
    material:SetFloat("_StencilReadMask", 1)
  end
  
  self:_MianSpineLoader(cfg)
end

function UIN15RaffleController:_PauseSpine(spine, timeScale)
  spine.timeScale = timeScale
end

function UIN15RaffleController:_PlaySpine(spine, animName, isLoop)
  spine.AnimationState:SetAnimation(0, animName, isLoop)
end

function UIN15RaffleController:_ClearSpine(spineLoder)
  spineLoder:DestroyCurrentSpine()
end

function UIN15RaffleController:_BgSpineTimeScale(timeScale)
  self:_PauseSpine(self._bgFarSpineSke, timeScale)
  self:_PauseSpine(self._bgNeraSpineSke, timeScale)
end

function UIN15RaffleController:_DirSpineLoader(type)
  local cfg = self._jackpotSpineCfg[self._curpage]
  local dirCfg = Cfg.cfg_n15_dir_spine_anim({})
  local dirCount = 1
  if ECampaignLotteryType.E_CLT_SINGLE == type then
    dirCount = 1
  elseif ECampaignLotteryType.E_CLT_MULTI == type then
    dirCount = 3
  end
  self:_ClearDirSpine()
  for i = 1, dirCount do
    local dir = dirCfg[i]
    local exitPos = Vector2(dir.ExitPos[1], dir.ExitPos[2])
    local startPos = Vector2(dir.StarPos[1], dir.StarPos[2])
    self._dirRects[i].anchoredPosition = startPos
    local endPos = Vector2(dir.EndPos[1], dir.EndPos[2])
    self._dirSpines[i]:LoadSpine(cfg.Dir)
    self._dirSpines[i]:SetAnimation(0, "drive", true)
    local dirDoMoveCB = self._dirRects[i]:DOAnchorPos(endPos, dir.Time):OnComplete(function()
      local dirCB = self:StartTask(function(TT)
        self._dirSpines[i]:SetAnimation(0, "damage", false)
        YIELD(TT, 1000)
        self._dirSpines[i]:SetAnimation(0, "damage_idle", true)
        local dirTweerCB = self._dirRects[i]:DOAnchorPos(exitPos, dir.Time):OnComplete(function()
          self:_ClearSpine(self._dirSpines[i])
        end)
        table.insert(self._dirTweerCBs, dirTweerCB)
      end)
      table.insert(self._dirCBs, dirCB)
    end)
    table.insert(self._dirDoMoveCB, dirDoMoveCB)
  end
end

function UIN15RaffleController:_ClearDirSpine()
  for i = 1, 3 do
    self:_ClearSpine(self._dirSpines[i])
  end
  if self._dirTweerCBs and #self._dirTweerCBs > 0 then
    for _, v in ipairs(self._dirTweerCBs) do
      v:Kill()
    end
  end
  if self._dirCBs and 0 < #self._dirCBs then
    for _, v in ipairs(self._dirCBs) do
      GameGlobal.TaskManager():KillTask(v)
    end
  end
  if self._dirDoMoveCB then
    for _, v in ipairs(self._dirDoMoveCB) do
      v:Kill()
    end
  end
  self._dirTweerCBs = {}
  self._dirCBs = {}
  self._dirDoMoveCB = {}
end

function UIN15RaffleController:_MianSpineLoader(cfg)
  self._mainSpine:LoadSpine(cfg.Main)
  self._mainSpine:SetAnimation(0, "drive", true)
  self._mainRect.anchoredPosition = Vector2(-150, 150)
end

function UIN15RaffleController:_PoltSpineLoader(poltId)
  local lockName = "N15Polt:SpinePolt_Lock"
  self:Lock(lockName)
  local poltCfg = self._poltCfg[poltId]
  local jackpotCfg = self._jackpotSpineCfg[self._curpage]
  local spineAnimCfg = self._spineAnimCfg[poltCfg.Polt[2]]
  local poltRoleSpienName = jackpotCfg.Polts[poltCfg.Polt[2]]
  self._poltRect.anchoredPosition = Vector2(spineAnimCfg.StarPos[1], spineAnimCfg.StarPos[2])
  self._poltSpien:LoadSpine(poltRoleSpienName)
  if spineAnimCfg.StarState then
    self._poltSpien:SetAnimation(0, spineAnimCfg.StarState, true)
  end
  local endPos = Vector2(spineAnimCfg.EndPos[1], spineAnimCfg.EndPos[2])
  self._poltRect:DOAnchorPos(endPos, spineAnimCfg.Time):OnComplete(function()
    self:StartTask(function(TT)
      self._mainSpine:SetAnimation(0, "brake", false)
      self:_BgSpineTimeScale(0)
      YIELD(TT, 1000)
      self._mainSpine:SetAnimation(0, spineAnimCfg.Ingreet, true)
      for idx, animName in ipairs(spineAnimCfg.AnimNames) do
        local animTime = spineAnimCfg.AnimTime[idx]
        if animTime ~= 99999 then
          self._poltSpien:SetAnimation(0, animName, false)
          YIELD(TT, animTime)
        else
          self._poltSpien:SetAnimation(0, animName, true)
        end
      end
      self._polt_view_btn_obj:SetActive(true)
      self:UnLock(lockName)
      self._polt_state = false
    end, self)
  end)
end

function UIN15RaffleController:_DrawSpineAnim(type)
  local cfg = Cfg.cfg_n15_main_anim[type]
  local drawAnim = ""
  if type == ECampaignLotteryType.E_CLT_MULTI then
    drawAnim = "7_2"
  elseif type == ECampaignLotteryType.E_CLT_SINGLE then
    drawAnim = "7_1"
  end
  self.mainTaskID = self:StartTask(function(TT)
    YIELD(TT, cfg.Time)
    self._mainSpine:SetAnimation(0, drawAnim, false)
    YIELD(TT, cfg.BongTime)
    self._mainSpine:SetAnimation(0, "8", true)
    YIELD(TT, 2664)
    self._mainSpine:SetAnimation(0, "drive", true)
  end, self)
  self:_DirSpineLoader(type)
end

function UIN15RaffleController:_RefSpineState()
  self:_SpineLoader()
  self:_ClearSpine(self._poltSpien)
  self:_ClearDirSpine()
  self:_BgSpineTimeScale(1)
  if self.mainTaskID then
    GameGlobal.TaskManager():KillTask(self.mainTaskID)
    self.mainTaskID = nil
  end
end

function UIN15RaffleController:OnUpdate(ms)
  self:_PlayDrawAnim(ms)
end

function UIN15RaffleController:_JumpDrawAnim()
  self:_RefSpineState()
  self:_StopDrawAnim()
end

function UIN15RaffleController:Left_BtnOnClick(go)
  if self._draw_state or self._polt_state then
    return
  end
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local curState = self:_CheckLotteryState(self._curpage)
  local nextState
  if self._curpage > 1 then
    nextState = self:_CheckLotteryState(self._curpage - 1)
  end
  self:StartTask(function(TT)
    local lockName = "UIN15RaffleController:_Page"
    self:Lock(lockName)
    if not curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out_maskL")
    elseif not curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out_maskL")
    elseif curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out")
    elseif curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out")
    end
    YIELD(TT, 500)
    if self._curpage <= 1 then
      self._left_btn_obj:SetActive(false)
      self._right_btn_obj:SetActive(true)
    else
      self._curpage = self._curpage - 1
      self:_RefRafflePool()
    end
    if not curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in_maskL")
    elseif not curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in")
    elseif curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in")
    elseif curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in_maskL")
    end
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UIN15RaffleController:Right_BtnOnClick(go)
  if self._draw_state or self._polt_state then
    return
  end
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local curState = self:_CheckLotteryState(self._curpage)
  local nextState
  if self._curpage < self._totalpage then
    nextState = self:_CheckLotteryState(self._curpage + 1)
  end
  self:StartTask(function(TT)
    local lockName = "UIN15RaffleController:_Page"
    self:Lock(lockName)
    if curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out_R")
    elseif not curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out_maskR")
    elseif curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_out_R")
    end
    YIELD(TT, 500)
    if self._curpage >= self._totalpage then
      self._right_btn_obj:SetActive(false)
      self._left_btn_obj:SetActive(true)
    else
      self._curpage = self._curpage + 1
      self:_RefRafflePool()
    end
    if curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in_maskR")
    elseif not curState and not nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in_maskR")
    elseif curState and nextState then
      self._anim:Play("uieffanim_N15_Raffle_Center_in_R")
    end
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UIN15RaffleController:Raffle_Single_BtnOnClick(go)
  self:_DoRaffle(ECampaignLotteryType.E_CLT_SINGLE)
end

function UIN15RaffleController:Raffle_More_BtnOnClick(go)
  self:_DoRaffle(ECampaignLotteryType.E_CLT_MULTI)
end

function UIN15RaffleController:Raffle_Intro_BtnOnClick(go)
  if self._draw_state or self._polt_state then
    return
  end
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIN15IntroController", "str_n15_intro_draw_title", "str_n15_intro_draw")
end

function UIN15RaffleController:Plot_BtnOnClick(go)
  if self._draw_state or self._polt_state then
    return
  end
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIN15PoltController")
end

function UIN15RaffleController:Polt_View_BtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY) then
    ToastManager.ShowToast(StringTable.Get("str_n15_over_activity"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._polt or self._polt_state then
    return
  end
  self:_PlayPolt(self._polt.event_id)
end

function UIN15RaffleController:JumpOnClick(go)
  self:_JumpDrawAnim()
end
