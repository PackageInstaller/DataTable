_class("UI_CN6_N35_GameController", UIController)
UI_CN6_N35_GameController = UI_CN6_N35_GameController

function UI_CN6_N35_GameController:SmeltComponentID()
  return ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM
end

function UI_CN6_N35_GameController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N6
end

function UI_CN6_N35_GameController:QuestComponentID()
  return ECampaignCN6ComponentID.ECAMPAIGN_N6_QUEST
end

function UI_CN6_N35_GameController:ProcessComponentID()
  return ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS
end

function UI_CN6_N35_GameController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self:GetCampaignType(), self:SmeltComponentID(), self:QuestComponentID(), self:ProcessComponentID())
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self:CreateData()
end

function UI_CN6_N35_GameController:CreateData()
  local questComInfo = self._campaign:GetComponentInfo(self:QuestComponentID())
  self._questData = UI_CN6_N35_Game_Quest_Data:New()
  self._questData:SetData(questComInfo)
  local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
  self._smeltData = UI_CN6_N35_Game_Smelt_Data:New()
  local smelt_cfgid = self._campaign:GetComponent(self:SmeltComponentID()):GetComponentCfgId()
  self._smeltData:SetData(smeltInfo, smelt_cfgid)
  self._openType = 1
  local processInfo = self._campaign:GetComponentInfo(self:ProcessComponentID())
  self._processData = UI_CN6_N35_Game_Process_Data:New()
  self._processData:SetData(processInfo)
end

function UI_CN6_N35_GameController:OnShow(uiParams)
  self:GetComponents()
  self:OnValue()
  UIActivityCustomHelper.SetNewFlagStatus("ACTIVITY_NEW" .. self:GetCampaignType() .. self:ProcessComponentID())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange)
end

function UI_CN6_N35_GameController:StoryBtnOnClick(go)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  local key = self:GetName() .. "_2_" .. pstid
  local val = LocalDB.GetInt(key, 0)
  if val == 0 then
    local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
    local storyid = smeltInfo.m_first_story_id
    self:ShowDialog("UIStoryController", storyid)
  else
    local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
    local storyid = smeltInfo.m_first_story_id
    self:ShowDialog("UIStoryController", storyid, function()
      self:PlayLastStory(6)
    end)
  end
end

function UI_CN6_N35_GameController:GetComponents()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  local backBtn = self._backBtn:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowInfoController()
  end)
  self._awardTips = self:GetUIComponent("UILocalizedTMP", "awardTips")
  self._rate = self:GetUIComponent("Image", "rate")
  self._stepPool = self:GetUIComponent("UISelectObjectPath", "stepPool")
  self._clothesIcon = self:GetUIComponent("RawImageLoader", "clothesIcon")
  self._questPool = self:GetUIComponent("UISelectObjectPath", "questPool")
  self._questAlpha = self:GetUIComponent("CanvasGroup", "quest")
  self._clothesAlpha = self:GetUIComponent("CanvasGroup", "clothes")
  self._clothesPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._clothesBtn = self:GetUIComponent("Image", "ClothesBtn")
  self._questBtn = self:GetUIComponent("Image", "QuestBtn")
  self._noQuestGo = self:GetGameObject("noQuestGo")
  self._questListGo = self:GetGameObject("questListGo")
  self._atlas = self:GetAsset("CN6_N35_Game.spriteAtlas", LoadType.SpriteAtlas)
  self._clothesImg = self:GetUIComponent("Image", "ClothesBtnView")
  self._questImg = self:GetUIComponent("Image", "QuestBtnView")
  self._getBtn = self:GetGameObject("GetBtn")
  self._gotBtn = self:GetGameObject("GetBtn_got")
  self._talkGo = self:GetGameObject("talk")
  self._talkTex = self:GetUIComponent("UILocalizationText", "talkTex")
  self._talkHeadImg = self:GetUIComponent("Image", "talkHeadImg")
  self._clothesRed = self:GetGameObject("clothesRed")
  self._questRed = self:GetGameObject("questRed")
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineName = "n35_g_spine_idle"
  self._spineDefauleSkin = "0"
  self._spineIdleAnim = "idle"
  self._spineHelloAnimList = {"random1", "random2"}
  self._helloSpineAnimPlaying = true
  self._helloSpineAnimYieldTime = 15000
  self._helloSpineAnimStartTime = 0
  self._anim = self:GetUIComponent("Animation", "UI_CN6_N35_GameController")
  self._anim:Play("effanim_UI_CN6_N35_GameController")
  self:Lock("PlayEnterAnim")
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
  self._animTimer = GameGlobal.Timer():AddEvent(600, function()
    self:UnLock("PlayEnterAnim")
  end)
  self._talkAlpha = self:GetUIComponent("CanvasGroup", "talk")
  self._talkAnim = self:GetUIComponent("Animation", "talk")
  self._spineEffAnim = self:GetGameObject("uieff_UI_CN6_N35_GameController")
  self._questAnim = self:GetUIComponent("Animation", "Right")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._itemTips = self._itemInfo:SpawnObject("UISelectInfo")
  self._clothesContent = self:GetUIComponent("RectTransform", "Content")
end

function UI_CN6_N35_GameController:ItemTips(id, pos)
  if self._itemTips then
    self._itemTips:SetData(id, pos)
  end
end

function UI_CN6_N35_GameController:ShowInfoController()
  local key = "UICN6N35_Smelt_Intro"
  self:ShowDialog("UIIntroLoader", key)
end

function UI_CN6_N35_GameController:OnValue()
  self:BtnState()
  self:SetRate()
  self:ClothesList()
  self:SetQuestList()
  self:CloseTimer()
  self:HideTalk()
  self:ShowSpine()
  self:SetPanelActive()
  self:PlayEnterStory()
end

function UI_CN6_N35_GameController:PlayEnterStory()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  local key = self:GetName() .. "_1_" .. pstid
  local val = LocalDB.GetInt(key, 0)
  if val == 0 then
    local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
    local storyid = smeltInfo.m_first_story_id
    self:ShowDialog("UIStoryController", storyid, function()
      LocalDB.SetInt(key, 1)
      self._anim:Play("effanim_UI_CN6_N35_GameController")
      self:Lock("PlayEnterAnim")
      if self._animTimer then
        GameGlobal.Timer():CancelEvent(self._animTimer)
      end
      self._animTimer = GameGlobal.Timer():AddEvent(600, function()
        self:UnLock("PlayEnterAnim")
      end)
    end)
  end
end

function UI_CN6_N35_GameController:ShowSpine()
  self._spine:LoadSpine(self._spineName)
  self._spineSke = self._spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._spine.CurrentMultiSkeleton
  end
  self:ShowSpineSkin()
end

function UI_CN6_N35_GameController:PlayTalkShowAnim()
  self._talkAlpha.alpha = 0
  if self._talkAnim then
    self._talkAnim:Play("effanim_UI_CN6_N35_GameController_talk_show")
  end
end

function UI_CN6_N35_GameController:PlayTalkHideAnim()
  self._talkAlpha.alpha = 1
  if self._talkAnim then
    self._talkAnim:Play("effanim_UI_CN6_N35_GameController_talk_hide")
  end
end

function UI_CN6_N35_GameController:ActiveTalk(active, data, withAnim)
  if active then
    local cfg = Cfg.cfg_cn6_n35_game_client({
      StepID = data.cfg.ID
    })[1]
    local tips = cfg.Talk
    local head = cfg.TalkHead
    local sprite = self._atlas:GetSprite(head)
    self._talkHeadImg.sprite = sprite
    local yieldTime = cfg.YieldTime
    self._talkTex:SetText(StringTable.Get(tips))
    if self._talkTimer then
      GameGlobal.Timer():CancelEvent(self._talkTimer)
    end
    self._talkTimer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self:ActiveTalk(false, false, true)
    end)
  end
  if withAnim then
    if active then
      self:PlayTalkShowAnim()
    else
      self:PlayTalkHideAnim()
    end
  end
end

function UI_CN6_N35_GameController:HideTalk()
  self._talkGo:SetActive(true)
  self._talkAlpha.alpha = 0
end

function UI_CN6_N35_GameController:BtnState()
  local clothesSpriteName, questSpriteName
  if self._openType == 1 then
    clothesSpriteName = "N35_xyx_icon05"
    questSpriteName = "N35_xyx_icon06"
  else
    clothesSpriteName = "N35_xyx_icon04"
    questSpriteName = "N35_xyx_icon07"
  end
  local clothesSprite = self._atlas:GetSprite(clothesSpriteName)
  local questSprite = self._atlas:GetSprite(questSpriteName)
  self._clothesImg.sprite = clothesSprite
  self._questImg.sprite = questSprite
end

function UI_CN6_N35_GameController:OnHide()
  if self._closeTimer then
    GameGlobal.Timer():CancelEvent(self._closeTimer)
  end
  if self._talkTimer then
    GameGlobal.Timer():CancelEvent(self._talkTimer)
  end
  if self._spineAnimTimer then
    GameGlobal.Timer():CancelEvent(self._spineAnimTimer)
  end
  if self._spineHelloTimer then
    GameGlobal.Timer():CancelEvent(self._spineHelloTimer)
  end
  self:UnLock("PlayEnterAnim")
  self:UnLock("UI_CN6_N35_GameController:FinishClothesReq")
  self:UnLock("UI_CN6_N35_GameController:ChangeClothesView")
  self:UnLock("UI_CN6_N35_GameController:SetPanelActive_1")
  self:UnLock("UI_CN6_N35_GameController:SetPanelActive_2")
  if self._activePanelTimer then
    GameGlobal.Timer():CancelEvent(self._activePanelTimer)
  end
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
end

function UI_CN6_N35_GameController:GetBtnOnClick(go)
  self:FinishProcessReq()
end

function UI_CN6_N35_GameController:ClothesBtnOnClick(go)
  if self._openType == 2 then
    return
  end
  self._openType = 2
  self:SetPanelActive(true)
  self:BtnState()
end

function UI_CN6_N35_GameController:QuestBtnOnClick(go)
  if self._openType == 1 then
    return
  end
  self._openType = 1
  self:SetPanelActive(true)
  self:BtnState()
  self:CheckRateRedAndQuest()
end

function UI_CN6_N35_GameController:SetPanelActive(switchAnim)
  self._questAlpha.blocksRaycasts = self._openType == 1
  self._clothesAlpha.blocksRaycasts = self._openType == 2
  if switchAnim then
    self._questAlpha.alpha = self._openType == 2 and 1 or 0
    if self._activePanelTimer then
      GameGlobal.Timer():CancelEvent(self._activePanelTimer)
    end
    if self._openType == 1 then
      self._questAnim:Play("effanim_UI_CN6_N35_GameController_switch_show")
      local clothesPools = self._clothesPool:GetAllSpawnList()
      for i = 1, 6 do
        local item = clothesPools[i]
        item:PlayAnim(false)
      end
      self:Lock("UI_CN6_N35_GameController:SetPanelActive_1")
      self._activePanelTimer = GameGlobal.Timer():AddEvent(500, function()
        self:UnLock("UI_CN6_N35_GameController:SetPanelActive_1")
      end)
    else
      self._questAnim:Play("effanim_UI_CN6_N35_GameController_switch_hide")
      local clothesPools = self._clothesPool:GetAllSpawnList()
      for i = 1, 6 do
        local item = clothesPools[i]
        item:PlayAnim(true, (i - 1) * 20)
      end
      self:Lock("UI_CN6_N35_GameController:SetPanelActive_2")
      self._activePanelTimer = GameGlobal.Timer():AddEvent(560, function()
        self:UnLock("UI_CN6_N35_GameController:SetPanelActive_2")
      end)
    end
  else
    local clothesAlpha = self._openType == 2 and 1 or 0
    local clothesPools = self._clothesPool:GetAllSpawnList()
    for i = 1, 3 do
      local item = clothesPools[i]
      item:SetAlpha(clothesAlpha)
    end
    self._questAlpha.alpha = self._openType == 1 and 1 or 0
  end
  if self._openType == 1 then
    self:SaveQuestOpenTag()
  else
    self._clothesContent.anchoredPosition = Vector2(self._clothesContent.anchoredPosition.x, 0)
  end
end

function UI_CN6_N35_GameController:SetQuestList()
  local questFinish = false
  local specialQuest = self._questData:SpecialQuest()
  if specialQuest:QuestInfo().status >= QuestStatus.QUEST_Completed then
    questFinish = true
  else
    questFinish = false
  end
  self._noQuestGo:SetActive(questFinish)
  self._questListGo:SetActive(not questFinish)
  if not questFinish then
    local questList = self._questData:QuestList()
    self._questPool:SpawnObjects("UI_CN6_N35_GameQuestItem", #questList)
    local pools = self._questPool:GetAllSpawnList()
    for i = 1, #questList do
      local quest = questList[i]
      local questInfo = quest:QuestInfo()
      local desc = StringTable.Get(questInfo.CondDesc) .. "(" .. questInfo.cur_progress .. "/" .. questInfo.total_progress .. ")"
      local item = pools[i]
      local finish = false
      if questInfo.status >= QuestStatus.QUEST_Completed then
        finish = true
      end
      item:SetData(desc, finish)
    end
  end
  self:CheckRateRedAndQuest()
end

function UI_CN6_N35_GameController:SetRate()
  local poolRT = self:GetUIComponent("RectTransform", "stepPool")
  local width = poolRT.rect.width
  local list = self._processData:ProcessList()
  local len = #list
  self._stepPool:SpawnObjects("UI_CN6_N35_GameQuestStepItem", len)
  local pools = self._stepPool:GetAllSpawnList()
  for i = 1, len do
    local item = pools[i]
    local posx = width / len * i
    local data = list[i]
    local got = data.finish
    local spName
    if got then
      spName = "N35_xyx_icon01"
    else
      spName = "N35_xyx_icon02"
    end
    local sp = self._atlas:GetSprite(spName)
    item:SetData(tostring(data.step), posx, sp)
  end
  local currentProcess = self._processData:CurrentShowStepAward()
  local awards = currentProcess.awards
  local awd = awards[1]
  local cfg_item = Cfg.cfg_item[awd.assetid]
  self._clothesIcon:LoadImage(cfg_item.Icon)
  local lastCount = self._processData:LastStepNeedCount()
  local itemid = self._processData:ItemID()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveCount = itemModule:GetItemCount(itemid)
  if lastCount < haveCount then
    haveCount = lastCount
  end
  self._rate.fillAmount = haveCount / lastCount
  local tex
  if currentProcess.got then
    tex = StringTable.Get("str_cn6_n35_all_get")
  elseif currentProcess.finish then
    tex = StringTable.Get("str_cn6_n35_wait_get", StringTable.Get(cfg_item.Name))
  else
    tex = StringTable.Get("str_cn6_n35_mission_get", StringTable.Get(cfg_item.Name))
  end
  self._awardTips:SetText(tex)
  self._getBtn:SetActive(not currentProcess.got and currentProcess.finish)
  self._gotBtn:SetActive(currentProcess.got)
end

function UI_CN6_N35_GameController:CheckRateRedAndQuest()
  local redRate = self:CheckRateRed()
  local redQuest = UI_CN6_N35_GameController.CheckQuestRed()
  self._questRed:SetActive(redRate or redQuest)
end

function UI_CN6_N35_GameController:CheckRateRed()
  local red = false
  local com = self._campaign:GetComponent(self:ProcessComponentID())
  red = com:HaveRedPoint()
  return red
end

function UI_CN6_N35_GameController:SaveQuestOpenTag()
  local key = UI_CN6_N35_GameController.QuestUpdateKey()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local timeStr = tostring(svrTime)
  LocalDB.SetString(key, timeStr)
end

function UI_CN6_N35_GameController.CheckQuestRed()
  local red
  local key = UI_CN6_N35_GameController.QuestUpdateKey()
  local val = LocalDB.GetString(key, "")
  if string.isnullorempty(val) then
    red = true
  else
    local num = tonumber(val)
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
    if 86400 < svrTime - num then
      red = true
    else
      local loginModule = GameGlobal.GetModule(LoginModule)
      local zero = loginModule:GetNextZeroTime()
      zero = zero + -68400
      if svrTime >= zero and num < zero then
        red = true
      end
    end
  end
  return red
end

function UI_CN6_N35_GameController.QuestUpdateKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  return "QuestUpdateKey" .. pstid
end

function UI_CN6_N35_GameController:ClothesList()
  local sortedList = {}
  local smeltList = self._smeltData:SmeltList()
  for index, value in ipairs(smeltList) do
    table.insert(sortedList, value)
  end
  table.sort(sortedList, function(a, b)
    local weight_a = 0
    local weight_b = 0
    if a.state == UI_CN6_N35_SmeltState.Finish then
      weight_a = weight_a + 100
    end
    if b.state == UI_CN6_N35_SmeltState.Finish then
      weight_b = weight_b + 100
    end
    weight_a = weight_a + a.number
    weight_b = weight_b + b.number
    return weight_a < weight_b
  end)
  local len = #sortedList
  self._clothesPool:SpawnObjects("UI_CN6_N35_GameClothesItem", len)
  local pools = self._clothesPool:GetAllSpawnList()
  for i = 1, len do
    local item = pools[i]
    local data = sortedList[i]
    item:SetData(i, data, function(data)
      self:OnClothesItemClick(data)
    end, function(id, pos)
      self:ItemTips(id, pos)
    end)
  end
  self:CheckClothesRed()
end

function UI_CN6_N35_GameController:CheckClothesRed()
  local red = false
  local com = self._campaign:GetComponent(self:SmeltComponentID())
  red = com:HaveRedPoint()
  self._clothesRed:SetActive(red)
end

function UI_CN6_N35_GameController:OnClothesItemClick(data)
  if data.state == UI_CN6_N35_SmeltState.Finish then
    self:ChangeClothesView(data)
  elseif data.state == UI_CN6_N35_SmeltState.CanFinish then
    self:FinishClothesReq(data)
  elseif data.state == UI_CN6_N35_SmeltState.NotItem then
    local tips = "str_cn6_n35_no_item"
    ToastManager.ShowToast(StringTable.Get(tips))
  elseif data.state == UI_CN6_N35_SmeltState.NotLast then
    local tips = "str_cn6_n35_no_last"
    ToastManager.ShowToast(StringTable.Get(tips))
  end
end

function UI_CN6_N35_GameController:ShowSpineSkin(resetSpine)
  local smeltList = self._smeltData:SmeltList()
  local spineSkin
  for index, value in ipairs(smeltList) do
    if not value.got then
      break
    end
    local cfg = Cfg.cfg_cn6_n35_game_client({
      StepID = value.cfg.ID
    })[1]
    spineSkin = cfg.SpineSkin
  end
  spineSkin = spineSkin or self._spineDefauleSkin
  if resetSpine then
    self._spine:DestroyCurrentSpine()
    self._spine:LoadSpine(self._spineName)
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
  end
  self._spineSke.Skeleton:SetSkin(spineSkin)
  self._spineSke:Update(0)
end

function UI_CN6_N35_GameController:ChangeClothesView(data, changeSkin)
  self:Lock("UI_CN6_N35_GameController:ChangeClothesView")
  self:StartTask(function(TT)
    self._helloSpineAnimPlaying = false
    self:ShowClothesEff(data, true)
    if changeSkin then
      YIELD(TT, 1033)
      changeSkin()
      YIELD(TT, 1000)
    else
      YIELD(TT, 2033)
    end
    self:ShowClothesEff(data, false)
    self:UnLock("UI_CN6_N35_GameController:ChangeClothesView")
    self:ChangeClothesSpineAnim(data)
    self:ActiveTalk(true, data, true)
  end, self)
end

function UI_CN6_N35_GameController:ShowClothesEff(data, active)
  self._spineEffAnim:SetActive(active)
  if active then
    AudioHelperController.PlayUISoundAutoRelease(1656)
  end
end

function UI_CN6_N35_GameController:ChangeClothesSpineAnim(data)
  local cfg = Cfg.cfg_cn6_n35_game_client({
    StepID = data.cfg.ID
  })[1]
  local spineAnim = cfg.SpineAnim
  if self._spineSke then
    local entry = self._spine.AnimationState:SetAnimation(0, spineAnim, false)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
    local anim = entry.Animation
    local duration = anim.Duration
    local yieldTime = math.floor(duration * 1000)
    if self._spineAnimTimer then
      GameGlobal.Timer():CancelEvent(self._spineAnimTimer)
    end
    self._spineAnimTimer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._helloSpineAnimPlaying = true
      self._spine.AnimationState:SetAnimation(0, self._spineIdleAnim, true)
      self._spine.AnimationState.Data.DefaultMix = 0
      self._spineSke:Update(0)
    end)
  end
end

function UI_CN6_N35_GameController:FinishClothesReq(data)
  self:Lock("UI_CN6_N35_GameController:FinishClothesReq")
  self:StartTask(function(TT)
    local smeltCom = self._campaign:GetComponent(self:SmeltComponentID())
    local res = AsyncRequestRes:New()
    local response = smeltCom:HandleReceiveSmeltItemReward(TT, res, data.cfg.ID)
    self:UnLock("UI_CN6_N35_GameController:FinishClothesReq")
    if res and res:GetSucc() then
      local cfg = Cfg.cfg_component_smelt_item[data.cfg.ID]
      local awards = cfg.Output or {}
      local sawards = cfg.SOutput or {}
      local tab = {}
      for i = 1, #awards do
        local roleAsset = RoleAsset:New()
        roleAsset.assetid = awards[i][1]
        roleAsset.count = awards[i][2]
        table.insert(tab, roleAsset)
      end
      for i = 1, #sawards do
        local roleAsset = RoleAsset:New()
        roleAsset.assetid = sawards[i][1]
        roleAsset.count = sawards[i][2]
        table.insert(tab, roleAsset)
      end
      self._helloSpineAnimPlaying = false
      self:ShowDialog("UIGetItemController", tab, function()
        self:ChangeClothesView(data, function()
          self:ShowSpineSkin(true)
        end)
        self:PlayLastStory(data.number)
      end)
      local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
      local smelt_cfgid = self._campaign:GetComponent(self:SmeltComponentID()):GetComponentCfgId()
      self._smeltData:SetData(smeltInfo, smelt_cfgid)
      self:ClothesList()
    else
      Log.error("###[UI_CN6_N35_GameController] FinishClothesReq HandleOneKeyReceiveRewards fail! result is :", res:GetResult())
    end
  end, self)
end

function UI_CN6_N35_GameController:PlayLastStory(idx)
  local cfg = Cfg.cfg_cn6_n35_game_client[idx]
  local storyid = cfg.StoryID
  if storyid then
    self:ShowDialog("UIStoryController", storyid, function()
      local roleModule = GameGlobal.GetModule(RoleModule)
      local pstid = roleModule:GetPstId()
      local key = self:GetName() .. "_2_" .. pstid
      LocalDB.SetInt(key, 1)
    end)
  end
end

function UI_CN6_N35_GameController:FinishProcessReq()
  self:StartTask(function(TT)
    local processCom = self._campaign:GetComponent(self:ProcessComponentID())
    local res = AsyncRequestRes:New()
    local rewards = processCom:HandleOneKeyReceiveRewards(TT, res)
    if rewards and next(rewards) then
      self:ShowDialog("UI_CN6_N35_GameGetClothes", rewards)
      local processInfo = self._campaign:GetComponentInfo(self:ProcessComponentID())
      self._processData:SetData(processInfo)
      self:SetRate()
      self:CheckRateRedAndQuest()
      local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
      local smelt_cfgid = self._campaign:GetComponent(self:SmeltComponentID()):GetComponentCfgId()
      self._smeltData:SetData(smeltInfo, smelt_cfgid)
      self:ClothesList()
    else
      Log.error("###[UI_CN6_N35_GameController] FinishProcessReq HandleOneKeyReceiveRewards fail! rewards is nil!")
    end
  end, self)
end

function UI_CN6_N35_GameController:CloseTimer()
  local smeltInfo = self._campaign:GetComponentInfo(self:SmeltComponentID())
  local endTime = smeltInfo.m_close_time
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = svrTimeModule:GetServerTime() * 0.001
  local gapTime = math.floor(endTime - nowTime)
  if 0 < gapTime then
    if self._closeTimer then
      GameGlobal.Timer():CancelEvent(self._closeTimer)
    end
    self._closeTimer = GameGlobal.Timer():AddEvent(gapTime * 1000, function()
      Log.debug("###[UI_CN6_N35_GameController] 时间到了，踢出！")
      local tips = StringTable.Get("str_activity_error_109")
      ToastManager.ShowToast(tips)
      self:SwitchState(UIStateType.UIMain)
    end)
  else
    Log.error("###[UI_CN6_N35_GameController] CloseTimer 活动已结束了,now:", nowTime, "|endTime:", endTime, "|gapTime:", gapTime)
  end
end

function UI_CN6_N35_GameController:OnUpdate(dms)
  if self._helloSpineAnimPlaying then
    self._helloSpineAnimStartTime = self._helloSpineAnimStartTime + dms
    if self._helloSpineAnimStartTime >= self._helloSpineAnimYieldTime then
      self._helloSpineAnimStartTime = 0
      self:PlaySpineHelloAnim()
    end
  end
end

function UI_CN6_N35_GameController:PlaySpineHelloAnim()
  local randomIdx = math.random(1, #self._spineHelloAnimList)
  local randomName = self._spineHelloAnimList[randomIdx]
  local entry = self._spine.AnimationState:SetAnimation(0, randomName, false)
  self._spine.AnimationState.Data.DefaultMix = 0
  self._spineSke:Update(0)
  if not entry then
    return
  end
  local anim = entry.Animation
  local duration = anim.Duration
  local yieldTime = math.floor(duration * 1000)
  if self._spineHelloTimer then
    GameGlobal.Timer():CancelEvent(self._spineHelloTimer)
  end
  self._spineHelloTimer = GameGlobal.Timer():AddEvent(yieldTime, function()
    self._spine.AnimationState:SetAnimation(0, self._spineIdleAnim, true)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
  end)
end
