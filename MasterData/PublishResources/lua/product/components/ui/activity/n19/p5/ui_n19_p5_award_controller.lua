_class("UIN19P5AwardController", UIController)
UIN19P5AwardController = UIN19P5AwardController

function UIN19P5AwardController:LoadDataOnEnter(TT, res, uiParams)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._uiModule = GameGlobal.GetModule(RoleModule).uiModule
  local roleModule = GameGlobal.GetModule(RoleModule)
  self._openID = roleModule:GetPstId()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N19_P5, ECampaignN19P5ComponentID.POWER_SHOP)
  self._lotteryComponent = self._campaign:GetComponent(ECampaignN19P5ComponentID.POWER_SHOP)
  self._lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN19P5ComponentID.POWER_SHOP)
  self._player = EZTL_Player:New()
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UIN19P5AwardController:OnShow()
  CutsceneManager.ExcuteCutsceneOut()
  self:GetComponents()
  self:AddListener()
  self:OnValue()
end

function UIN19P5AwardController:AddListener()
  self:AttachEvent(GameEventType.OnN19P5SkipBigView, self.OnN19P5SkipBigView)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN19P5AwardController:Close()
  local shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  shot.width = shotRect.rect.width
  shot.height = shotRect.rect.height
  Log.debug("#############width " .. shot.width)
  Log.debug("#############height " .. shot.height)
  shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  shot.UseAllCamerasCapture = true
  shot.blurTimes = 0
  shot:CleanRenderTexture()
  Log.debug("############## shot")
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  local rt = shot:RefreshBlurTexture()
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    YIELD(TT)
    self._campaignModule:CampaignSwitchState(true, UIStateType.UIN19P5, UIStateType.UIMain, {cache_rt}, self._campaign._id)
  end)
end

function UIN19P5AwardController:Close2()
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIN19P5DrawCard .. "Close", function()
    local shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
    shot.gameObject:SetActive(true)
    shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = shot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self._campaignModule:CampaignSwitchState(true, UIStateType.UIN19P5, UIStateType.UIMain, {cache_rt}, self._campaign._id)
    end)
  end)
end

function UIN19P5AwardController:GetComponents()
  self.uiAnim = self:GetUIComponent("Animation", "uiAnim")
  self.Name = self:GetUIComponent("RawImageLoader", "Name")
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.sinIcon = self:GetUIComponent("RawImageLoader", "sinIcon")
  self.mulIcon = self:GetUIComponent("RawImageLoader", "mulIcon")
  self.SinIconImg = self:GetUIComponent("RawImage", "sinIcon")
  self.MulIconImg = self:GetUIComponent("RawImage", "mulIcon")
  self.SinCostImgBg = self:GetUIComponent("Image", "SinCostImgBg")
  self.MulCostImgBg = self:GetUIComponent("Image", "MulCostImgBg")
  self.IconCount = self:GetUIComponent("UILocalizationText", "IconCount")
  self.Pool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.PoolRect = self:GetUIComponent("RectTransform", "Content")
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:Close()
  end, nil, nil, true)
  self.Idx = self:GetUIComponent("UILocalizationText", "Idx")
  self.LeftArrowBtn = self:GetGameObject("LeftArrowBtn")
  self.RightArrowBtn = self:GetGameObject("RightArrowBtn")
  self.SinBtn = self:GetUIComponent("Button", "SinBtn")
  self.MulBtn = self:GetUIComponent("Button", "MulBtn")
  self.Full = self:GetGameObject("Full")
  self.MonsterHP = self:GetUIComponent("RectTransform", "MonsterHP")
  self.LessCount = self:GetUIComponent("UILocalizationText", "LessCount")
  self.LessCountImg = self:GetUIComponent("Image", "LessCountImg")
  self.SinTex = self:GetUIComponent("UILocalizationText", "SinTex")
  self.MulTex = self:GetUIComponent("UILocalizationText", "MulTex")
  self.SinCost = self:GetUIComponent("UILocalizationText", "SinCost")
  self.MulCost = self:GetUIComponent("UILocalizationText", "MulCost")
  self.SinBtnView = self:GetUIComponent("RawImage", "SinBtnView")
  self.MulBtnView = self:GetUIComponent("RawImage", "MulBtnView")
  self.empty = self:GetGameObject("empty")
  self.testBtnPanel = self:GetGameObject("testBtnPanel")
  self.TestBtn = self:GetGameObject("TestBtn")
end

function UIN19P5AwardController:SinBtnOnClick(go)
  if self.notDrawCount then
    return
  end
  if self.cantDrawCard then
    local tips = "str_n19_p5_pool_lock_tips"
    ToastManager.ShowToast(StringTable.Get(tips))
  elseif self._sinEnough then
    self:_DoDraw(ECampaignLotteryType.E_CLT_SINGLE)
  else
    ToastManager.ShowToast(StringTable.Get("str_n19_p5_cost_not_enough", self._costName))
  end
end

function UIN19P5AwardController:MulBtnOnClick(go)
  if self.notDrawCount then
    return
  end
  if self.cantDrawCard then
    local tips = "str_n19_p5_pool_lock_tips"
    ToastManager.ShowToast(StringTable.Get(tips))
  elseif self._mulEnough then
    self:_DoDraw(ECampaignLotteryType.E_CLT_MULTI)
  else
    ToastManager.ShowToast(StringTable.Get("str_n19_p5_cost_not_enough", self._costName))
  end
end

function UIN19P5AwardController:_DoDraw(lotteryType)
  self:Lock("UIN19P5AwardController:_DoDraw")
  self._uiModule:LockAchievementFinishPanel(true)
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local poolidx = self._currentIdx
    local drawCount = 1
    if lotteryType == ECampaignLotteryType.E_CLT_MULTI then
      drawCount = self:GetAllCount()
      if 10 < drawCount then
        drawCount = 10
      end
    end
    local getRewards, isOpenNew = self:_SendDrawReq(TT, res, poolidx, lotteryType)
    if res:GetSucc() then
      self:UnLock("UIN19P5AwardController:_DoDraw")
      self:ShowAnim(getRewards, isOpenNew, lotteryType, poolidx, function()
        self._uiModule:LockAchievementFinishPanel(false)
        self:ShowUnLock(isOpenNew, poolidx)
        self:ShowAwards(true)
        self:ShowPetOutLine()
      end, drawCount)
    else
      self:UnLock("UIN19P5AwardController:_DoDraw")
      self._uiModule:LockAchievementFinishPanel(false)
      self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, function()
        self:_ForceRefresh(isOpenNew)
      end, function()
        self:SwitchState(UIStateType.UIMain)
      end)
    end
  end, self)
end

function UIN19P5AwardController:ShowPetOutLine()
  local data = self.poolData[self._currentIdx]
  local petList = data:PetList()
  for idx, petid in pairs(petList) do
    local petGo = self.petGoMap[petid]
    if idx == self._currentSelectPetIdx then
      self:ShowHideOutLine(petid, petGo, true)
    else
      self:ShowHideOutLine(petid, petGo, false)
    end
  end
end

function UIN19P5AwardController:HidePetOutLine(petid, go)
  self:ShowHideOutLine(petid, go, false)
end

function UIN19P5AwardController:ShowHideOutLine(petid, go, active)
  local anim = self._MaterialAnimationMap[petid]
  if active then
    anim:Play("eff_p5_choujiang_outline")
  else
    anim:Stop()
  end
  if self.chooseEffGoMap then
    local chooseEff = self.chooseEffGoMap[petid]
    if chooseEff then
      chooseEff:SetActive(active)
    end
  end
end

function UIN19P5AwardController:ShowUnLock(isOpenNew, poolIdx)
  if isOpenNew then
    local poolData = self.poolData[poolIdx]
    local bigAward = poolData:BigID()
    local cfg_item = Cfg.cfg_item[bigAward]
    local itemName = StringTable.Get(cfg_item.Name)
    local nextIdx = poolIdx + 1
    local nextPoolData = self.poolData[nextIdx]
    local monsterID = nextPoolData:MonsterID()
    local cfg_monster_class = Cfg.cfg_monster_class[monsterID]
    local monsterName = StringTable.Get(cfg_monster_class.Name)
    local txt = StringTable.Get("str_n19_p5_shop_open_next_text", itemName, monsterName)
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", txt, function()
      self:RightArrowBtnOnClick()
    end)
  end
end

function UIN19P5AwardController:SortShowAssets()
  table.sort(self.showAssets, function(a, b)
    local weightA = 0
    local weightB = 0
    if a.m_reward_type == ECampaignLRType.E_CLRT_big then
      weightA = weightA + 3000
    elseif a.m_reward_type == ECampaignLRType.E_CLRT_rare then
      weightA = weightA + 2000
    else
      weightA = weightA + 1000
    end
    if b.m_reward_type == ECampaignLRType.E_CLRT_big then
      weightB = weightB + 3000
    elseif b.m_reward_type == ECampaignLRType.E_CLRT_rare then
      weightB = weightB + 2000
    else
      weightB = weightB + 1000
    end
    if a.m_awaid_id < b.m_awaid_id then
      weightA = weightA + 100
    else
      weightB = weightB + 100
    end
    return weightA > weightB
  end)
end

function UIN19P5AwardController:ShowAnim(getRewards, isOpenNew, lotteryType, poolidx, callback, drawCount)
  local haveBig = false
  self.showAssets = {}
  self.callback = callback
  for i = 1, #getRewards do
    local item = getRewards[i]
    if item.m_is_big_reward or item.m_reward_type == ECampaignLRType.E_CLRT_rare then
      haveBig = true
    end
    table.insert(self.showAssets, item)
  end
  self:SortShowAssets()
  local pool = self.poolData[poolidx]
  local petList = pool:PetList()
  local petid = petList[self._currentSelectPetIdx]
  local model = self.petGoMap[petid]
  local monsterid = pool:MonsterID()
  local monsterModel = self.bossGoMap[monsterid]
  self:HidePetOutLine(petid, model)
  if self._player:IsPlaying() then
    self._player:Stop()
  end
  if haveBig then
    self:Anim_Big_P5(petid, monsterModel)
  elseif lotteryType == ECampaignLotteryType.E_CLT_SINGLE then
    self:Anim_Chain_P5(petid, model, monsterModel)
  else
    self:Anim_Active_P5(petid, model, monsterModel)
  end
  self:SetCurrentSelectPet()
end

function UIN19P5AwardController:TestBtnOnClick(go)
  if self.testBtnPanel then
    self.testBtnPanel:SetActive(true)
  end
end

function UIN19P5AwardController:ShowTestBtn()
  if HelperProxy:GetInstance():GetConfig("EnableTestFunc", "false") == "true" or EDITOR then
    Log.debug("###[UIN19P5AwardController] is debug !")
    if self.TestBtn then
      Log.debug("###[UIN19P5AwardController] is debug ! open !")
      self.TestBtn:SetActive(true)
    end
  else
    Log.debug("###[UIN19P5AwardController] not is debug !")
    if self.TestBtn then
      Log.debug("###[UIN19P5AwardController] not is debug ! close !")
      self.TestBtn:SetActive(false)
    end
  end
end

function UIN19P5AwardController:PlaySkillBtnOnClick(go)
  local petid
  local petidInp = self:GetUIComponent("InputField", "InputField")
  if petidInp then
    local txt = petidInp.text
    if not txt or string.isnullorempty(txt) then
      ToastManager.ShowToast("请输入星灵id")
    else
      petid = tonumber(txt)
    end
  end
  local type
  local skillTypeInp = self:GetUIComponent("InputField", "InputField2")
  if skillTypeInp then
    local txt = skillTypeInp.text
    if not txt or string.isnullorempty(txt) then
      ToastManager.ShowToast("请输入技能类型,1-连锁，2-大招，3-处决")
    else
      type = tonumber(txt)
    end
  end
  if petid and type then
    self:TestSkillView(type, petid)
  end
  if self.testBtnPanel then
    self.testBtnPanel:SetActive(false)
  end
end

function UIN19P5AwardController:TestSkillView(type, petid)
  local pool = self.poolData[self._currentIdx]
  local model = self.petGoMap[petid]
  local monsterid = pool:MonsterID()
  local monsterModel = self.bossGoMap[monsterid]
  if pool and model and monsterModel then
    if type == 1 then
      self:Anim_Chain_P5(petid, model, monsterModel)
    elseif type == 2 then
      self:Anim_Active_P5(petid, model, monsterModel)
    elseif type == 3 then
      self:Anim_Big_P5(petid, monsterModel)
    end
  else
    local tips = "error:petid[" .. petid .. "] currIdx[" .. self._currentIdx .. "]"
    ToastManager.ShowToast(tips)
  end
end

function UIN19P5AwardController:OnN19P5SkipBigView()
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
  end
  self:ShowHideUIAndSceneGo(true, self._bigViewPetID)
  local count = self:GetAllCount()
  if count <= 0 then
    local poolidx = self._currentIdx
    local pool = self.poolData[poolidx]
    local monsterid = pool:MonsterID()
    local monsterModel = self.bossGoMap[monsterid]
    monsterModel:SetActive(false)
  end
  self:ShowMonsterHpPos()
  self:UnLock("N19P5SkillView")
  GameGlobal.UIStateManager():ShowDialog("UIN19P5ShowAwards", self.showAssets, function()
    self:SetMonsterHP()
    if self.callback then
      self.callback()
      self.callback = nil
    end
  end)
end

function UIN19P5AwardController:Anim_Big_P5(petid, monsterModel)
  local tls = {}
  self._bigViewPetID = petid
  tls[#tls + 1] = EZTL_Callback:New(function()
    local go = self.petNbGoMap[petid]
    local effCam = go.transform:Find("UIEffCamera"):GetComponent(typeof(UnityEngine.Camera))
    local petHead
    local petWord = "str_voice_" .. petid .. "_58"
    if petid == 1601581 then
      petHead = "n19p5_chujue_tx01"
    elseif petid == 1501611 then
      petHead = "n19p5_chujue_tx02"
    elseif petid == 1601591 then
      petHead = "n19p5_chujue_tx03"
    elseif petid == 1501621 then
      petHead = "n19p5_chujue_tx04"
    elseif petid == 1501601 then
      petHead = "n19p5_chujue_tx05"
    end
    local enterAnim = "uieff_UIBattlePersonaSkillEffTop_In"
    GameGlobal.UIStateManager():ShowDialog("UIBattlePersonaSkillEffTop", effCam, petHead, petWord, true, enterAnim)
  end, "0,打开右上角界面")
  tls[#tls + 1] = EZTL_Callback:New(function()
    self:ShowHideUIAndSceneGo(false, petid)
  end, "1.隐藏ui和场景go,激活处决动画go,把人物节点激活")
  if petid == 1601581 then
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.2秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9043
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
      local voiceid = 15800058
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(voiceid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2300, "2.等2.7秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9041
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(900, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9042
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(3200, "2.等3.2秒")
  elseif petid == 1601591 then
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.2秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9043
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
      local voiceid = 15900058
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(voiceid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2300, "2.等2.7秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9041
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(800, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9042
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(1800, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Wait:New(1500, "2.等3.2秒")
  elseif petid == 1501601 then
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.2秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9043
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
      local voiceid = 16000058
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(voiceid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2200, "2.等2.7秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9041
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9042
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(1800, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Wait:New(1800, "2.等3.2秒")
  elseif petid == 1501611 then
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.2秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9043
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
      local voiceid = 16100058
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(voiceid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2300, "2.等2.7秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9041
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9042
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(1600, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Wait:New(1900, "2.等3.2秒")
  elseif petid == 1501621 then
    tls[#tls + 1] = EZTL_Wait:New(600, "2.等0.2秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9043
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
      local voiceid = 16200058
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(voiceid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2300, "2.等2.7秒")
    tls[#tls + 1] = EZTL_Callback:New(function()
      local audioid = 9041
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
    tls[#tls + 1] = EZTL_Wait:New(2400, "2.等0.9秒")
    tls[#tls + 1] = EZTL_Wait:New(1700, "2.等3.2秒")
  end
  tls[#tls + 1] = EZTL_Callback:New(function()
    self:ShowUIScene()
  end, "7.打开场景go和ui节点,隐藏处决动画go,把人物节点隐藏")
  tls[#tls + 1] = EZTL_Wait:New(2200, "2.等1.2秒")
  tls[#tls + 1] = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():CloseDialog("UIBattlePersonaSkillEffTop")
    self:HideNbSkillGo(petid)
    self:SetMonsterHP()
  end, "7.打开场景go和ui节点,隐藏处决动画go,把人物节点隐藏")
  local count = self:GetAllCount()
  if count <= 0 then
    tls[#tls + 1] = EZTL_Callback:New(function()
      self:PlayMonsterDie(monsterModel)
    end, "怪物死亡")
    local dieLength = 3000
    tls[#tls + 1] = EZTL_Wait:New(dieLength, "等待死亡播完")
    tls[#tls + 1] = EZTL_Callback:New(function()
      self:ShowMonsterHpPos()
      monsterModel:SetActive(false)
    end, "怪物消失")
  end
  tls[#tls + 1] = EZTL_Callback:New(function()
    self:UnLock("N19P5SkillView")
  end, "解锁")
  tls[#tls + 1] = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():ShowDialog("UIN19P5ShowAwards", self.showAssets, function()
      self:SetMonsterHP()
      if self.callback then
        self.callback()
        self.callback = nil
      end
    end)
  end, "8,弹奖励")
  self:Lock("N19P5SkillView")
  local tl = EZTL_Sequence:New(tls, "P5处决 petid[" .. petid .. "]")
  self._player:Play(tl)
end

function UIN19P5AwardController:CreatePhaseView(phase, petid, model, monsterModel)
  local type = phase.Type
  local param = phase.Param
  local tl
  if type == "Anim" then
    local animName = param
    tl = EZTL_Callback:New(function()
      local anim = model:GetComponentInChildren(typeof(UnityEngine.Animator))
      anim:SetTrigger(animName)
    end, "view_Anim")
  elseif type == "Audio" then
    local audioid = param
    tl = EZTL_Callback:New(function()
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioid)
    end, "view_Audio")
  elseif type == "Wait" then
    local waitTime = param
    tl = EZTL_Wait:New(waitTime, "view_Wait")
  elseif type == "Effect" then
    local effectid = param
    local show = model
    local be = monsterModel
    tl = EZTL_Callback:New(function()
      local cfgEffect = Cfg.cfg_effect[effectid]
      if cfgEffect then
        local go
        if self._skillEffectReqMap[effectid] then
          local req = self._skillEffectReqMap[effectid]
          go = req.Obj
        else
          local effResName = cfgEffect.ResPath
          local effReq = ResourceManager:GetInstance():SyncLoadAsset(effResName, LoadType.GameObject)
          self._skillEffectReqMap[effectid] = effReq
          go = effReq.Obj
        end
        if go then
          do
            local holder = cfgEffect.Holder
            local holderGo
            if holder == "caster" then
              holderGo = show
            else
              holderGo = be
            end
            if holderGo then
              local bindPos = cfgEffect.BindPos
              local skillRootTr = GameObjectHelper.FindChild(holderGo.transform, bindPos)
              if skillRootTr then
                go.transform.position = skillRootTr.position
              end
              go.transform.rotation = Quaternion.identity
              go.transform.localScale = Vector3(1, 1, 1)
              go:SetActive(true)
              if cfgEffect.FollowMove or cfgEffect.FollowMove == nil or cfgEffect.FollowRotate or cfgEffect.FollowRotate == nil then
                if skillRootTr then
                  go.transform:SetParent(skillRootTr)
                  go.transform.localPosition = Vector3(0, 0, 0)
                  go.transform.localRotation = Quaternion.identity
                  go.transform.localScale = Vector3(1, 1, 1)
                else
                  go.transform.rotation = Quaternion.identity
                  go.transform.localScale = Vector3(1, 1, 1)
                end
              else
                go.transform:SetParent(self.HiddenTr)
                if skillRootTr then
                  go.transform.position = skillRootTr.position
                end
                go.transform.rotation = Quaternion.identity
                go.transform.localScale = Vector3(1, 1, 1)
              end
              local length = cfgEffect.Duration
              if 0 < length then
                self._timer[#self._timer + 1] = GameGlobal.Timer():AddEvent(length, function()
                  go:SetActive(false)
                end)
              end
            end
          end
        end
      else
        Log.error("###[UIN19P5AwardController] cfgEffect is nil ! id --> ", effectid)
      end
    end, "view_Effect")
  elseif type == "Hit" then
    local hitAnim = param
    local be = monsterModel
    tl = EZTL_Callback:New(function()
      local anim = be:GetComponentInChildren(typeof(UnityEngine.Animator))
      anim:SetTrigger(hitAnim)
    end, "view_Hit")
  end
  return tl
end

function UIN19P5AwardController:Anim_Chain_P5(petid, model, monsterModel)
  self:PlaySkillView(2, petid, model, monsterModel)
end

function UIN19P5AwardController:Anim_Active_P5(petid, model, monsterModel)
  self:PlaySkillView(1, petid, model, monsterModel)
end

function UIN19P5AwardController:GetPhaseLastHitLength(monsterModel, phaseParam)
  if phaseParam then
    for i = #phaseParam, 1, -1 do
      local phase = phaseParam[i]
      if phase.Type == "Hit" then
        local hitAnim = phase.Param
        return GameObjectHelper.GetActorAnimationLength(monsterModel, hitAnim) * 1000
      end
    end
  end
end

function UIN19P5AwardController:PlaySkillView(type, petid, model, monsterModel)
  local viewCfg = Cfg["cfg_n19_p5_award_skill_" .. petid]()
  if viewCfg then
    local view = viewCfg[type]
    local phaseParam = view.PhaseParam[1]
    if phaseParam then
      local tls = {}
      for i = 1, #phaseParam do
        local phase = phaseParam[i]
        local tl = self:CreatePhaseView(phase, petid, model, monsterModel)
        tls[#tls + 1] = tl
      end
      tls[#tls + 1] = EZTL_Callback:New(function()
        self:SetMonsterHP()
      end)
      local length = 1000
      tls[#tls + 1] = EZTL_Wait:New(length, "等待受击播完")
      local count = self:GetAllCount()
      if count <= 0 then
        tls[#tls + 1] = EZTL_Callback:New(function()
          self:PlayMonsterDie(monsterModel)
        end, "怪物死亡")
        local dieLength = 3000
        tls[#tls + 1] = EZTL_Wait:New(dieLength, "等待死亡播完")
        tls[#tls + 1] = EZTL_Callback:New(function()
          self:ShowMonsterHpPos()
          monsterModel:SetActive(false)
        end, "怪物消失")
      end
      tls[#tls + 1] = EZTL_Callback:New(function()
        self:UnLock("N19P5SkillView")
      end, "解锁")
      tls[#tls + 1] = EZTL_Callback:New(function()
        GameGlobal.UIStateManager():ShowDialog("UIN19P5ShowAwards", self.showAssets, function()
          if self.callback then
            self.callback()
            self.callback = nil
          end
        end)
      end, ",弹奖励")
      self:Lock("N19P5SkillView")
      local tl = EZTL_Sequence:New(tls, "P5技_pet[" .. petid .. "]_type[" .. type .. "]")
      self._player:Play(tl)
    end
  else
    Log.error("###[UIN19P5AwardController] viewCfg is nil ! id --> ", petid)
  end
end

function UIN19P5AwardController:HideNbSkillGo(petid)
  local go = self.petNbGoMap[petid]
  go:SetActive(false)
end

function UIN19P5AwardController:ShowUIScene()
  self.Full:SetActive(true)
  self.sceneGo:SetActive(true)
end

function UIN19P5AwardController:ShowHideUIAndSceneGo(active, petid)
  self.Full:SetActive(active)
  self.sceneGo:SetActive(active)
  local go = self.petNbGoMap[petid]
  go:SetActive(not active)
end

function UIN19P5AwardController:PlayPetChain(model)
  local animName = "AtkChain"
  local animator = model:GetComponentInChildren(typeof(UnityEngine.Animator))
  animator:SetTrigger(animName)
end

function UIN19P5AwardController:PlayPetActive(model)
  local animName = "AtkUlt"
  local animator = model:GetComponentInChildren(typeof(UnityEngine.Animator))
  animator:SetTrigger(animName)
end

function UIN19P5AwardController:PlayMonsterHit(model)
  local animName = "Hit"
  local animator = model:GetComponentInChildren(typeof(UnityEngine.Animator))
  animator:SetTrigger(animName)
end

function UIN19P5AwardController:PlayMonsterDie(model)
  local anim = model:GetComponentInChildren(typeof(UnityEngine.Animator))
  anim:SetTrigger("Death")
  local matAnimMonoCmpt = model:GetComponent(typeof(MaterialAnimation))
  if matAnimMonoCmpt then
    matAnimMonoCmpt:Play("monster_death_dark")
  end
end

function UIN19P5AwardController:GetLessCount()
  local lessTime = self:GetAllCount()
  if 10 < lessTime then
    lessTime = 10
  end
  return lessTime
end

function UIN19P5AwardController:GetAllCount()
  local awards = self:GetPoolAwards()
  local lessTime = 0
  for i = 1, #awards do
    local award = awards[i]
    lessTime = lessTime + award.m_lottery_count
  end
  return lessTime
end

function UIN19P5AwardController:GetMaxCount()
  local awards = self:GetPoolAwards()
  local maxTime = 0
  for i = 1, #awards do
    local award = awards[i]
    maxTime = maxTime + award.m_lottery_limit_count
  end
  return maxTime
end

function UIN19P5AwardController:_SendDrawReq(TT, res, boxIndex, lotteryType)
  if self._lotteryComponent then
    return self._lotteryComponent:HandleLottery(TT, res, boxIndex, lotteryType)
  end
  res:SetSucc(false)
  return nil
end

function UIN19P5AwardController:_ForceRefresh(isOpenNew)
end

function UIN19P5AwardController:LeftArrowBtnOnClick(go)
  local currentIdx = self._currentIdx - 1
  if currentIdx < 1 then
    currentIdx = 1
  end
  if currentIdx == self._currentId then
    return
  end
  self._currentIdx = currentIdx
  self:GetCurrentPoolLock()
  self:SwitchPool()
  self:PlayInAnim()
end

function UIN19P5AwardController:RightArrowBtnOnClick(go)
  local currentIdx = self._currentIdx + 1
  if currentIdx > #self._lotteryComponentInfo.m_jackpots then
    currentIdx = #self._lotteryComponentInfo.m_jackpots
  end
  if currentIdx == self._currentId then
    return
  end
  self._currentIdx = currentIdx
  self:GetCurrentPoolLock()
  self:SwitchPool()
  self:PlayInAnim()
end

function UIN19P5AwardController:PlayInAnim()
  self.uiAnim:Play("UIN19P5AwardController_in")
  self:LockInAnim()
end

function UIN19P5AwardController:LockInAnim()
  self:Lock("Play(UIN19P5AwardController_in")
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
  end
  self.animEvent = GameGlobal.Timer():AddEvent(600, function()
    self:UnLock("Play(UIN19P5AwardController_in")
  end)
end

function UIN19P5AwardController:SetArrow()
  if self._currentIdx == 1 then
    self.LeftArrowBtn:SetActive(false)
  else
    self.LeftArrowBtn:SetActive(true)
  end
  if self._currentIdx == #self._lotteryComponentInfo.m_jackpots then
    self.RightArrowBtn:SetActive(false)
  else
    self.RightArrowBtn:SetActive(true)
  end
end

function UIN19P5AwardController:SwitchPool()
  self:ShowPool()
  self:ShowInfo()
end

function UIN19P5AwardController:ShowPool()
  self:ShowModel()
  self:CurrentSelectPet()
  self:ShowMonsterHpPos()
end

function UIN19P5AwardController:CurrentSelectPet()
  local key = self._currentIdx .. "N19P5Award" .. self._openID
  local idx = LocalDB.GetInt(key, 0)
  if idx == 0 then
    self._currentSelectPetIdx = 1
  else
    self._currentSelectPetIdx = idx
  end
  self:ShowPetOutLine()
end

function UIN19P5AwardController:SetCurrentSelectPet()
  self._currentSelectPetIdx = self._currentSelectPetIdx + 1
  if self._currentSelectPetIdx > 4 then
    self._currentSelectPetIdx = 1
  end
  local key = self._currentIdx .. "N19P5Award" .. self._openID
  LocalDB.SetInt(key, self._currentSelectPetIdx)
end

function UIN19P5AwardController:ShowMonsterHpPos()
  local lessCount = self:GetAllCount()
  if lessCount <= 0 then
    self.MonsterHP.gameObject:SetActive(false)
  else
    self.MonsterHP.gameObject:SetActive(true)
    local poolidx = self._currentIdx
    local root = self.posRootMap[poolidx]
    local MonsterTr = root.Monster
    local hpRoot = MonsterTr:Find("ui")
    local pos = self:GetHpPos(hpRoot)
    self.MonsterHP.anchoredPosition = pos
  end
end

function UIN19P5AwardController:GetHpPos(tr)
  local petPos = tr.position
  local camera3d = self.sceneGo:GetComponentInChildren(typeof(UnityEngine.Camera))
  local screenPos = camera3d:WorldToScreenPoint(petPos)
  local camera2d = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local uiParent = self:GetUIComponent("RectTransform", "HpParent")
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(uiParent, screenPos, camera2d, nil)
  return pos
end

function UIN19P5AwardController:ShowModel()
  for id, go in pairs(self.bossGoMap) do
    go:SetActive(false)
  end
  for id, go in pairs(self.petGoMap) do
    go:SetActive(false)
  end
  local poolidx = self._currentIdx
  local pool = self.poolData[poolidx]
  local petList = pool:PetList()
  local monsterid = pool:MonsterID()
  local root = self.posRootMap[poolidx]
  local PetMapTr = root.PetMap
  local MonsterTr = root.Monster
  for i = 1, #petList do
    local petid = petList[i]
    local go = self.petGoMap[petid]
    go:SetActive(true)
    local pos = PetMapTr[petid]
    local tr = go.transform
    tr:SetParent(pos)
    tr.localPosition = Vector3(0, 0, 0)
    tr.localRotation = Quaternion.identity
    tr.localScale = Vector3(1, 1, 1)
  end
  local monsterGo = self.bossGoMap[monsterid]
  local count = self:GetAllCount()
  if 0 < count then
    monsterGo:SetActive(true)
  end
  local monsterTr = monsterGo.transform
  local monsterPos = MonsterTr
  monsterTr:SetParent(monsterPos)
  monsterTr.localPosition = Vector3(0, 0, 0)
  monsterTr.localRotation = Quaternion.identity
  monsterTr.localScale = Vector3(1, 1, 1)
end

function UIN19P5AwardController:ShowInfo()
  self:SetIdx()
  self:FlushName()
  self:SetArrow()
  self:ShowAwards()
  self:SetMonsterHP()
end

function UIN19P5AwardController:SetMonsterHP()
  local lessCount = self:GetAllCount()
  local maxCount = self:GetMaxCount()
  self.LessCount:SetText("<size=35>" .. lessCount .. "/</size>" .. maxCount)
  if maxCount == 0 then
    maxCount = 50
  end
  local rate = lessCount / maxCount
  self.LessCountImg.fillAmount = rate
end

function UIN19P5AwardController:OnHide()
  if self._matAnimEvent then
    GameGlobal.Timer():CancelEvent(self._matAnimEvent)
    self._matAnimEvent = nil
  end
  if self.animEvent then
    GameGlobal.Timer():CancelEvent(self.animEvent)
    self.animEvent = nil
  end
  if self._MaterialAnimationContainerMap then
    for id, req in pairs(self._MaterialAnimationContainerMap) do
      req:Dispose()
    end
    self._MaterialAnimationContainerMap = nil
  end
  if self.chooseEffReqMap then
    for id, req in pairs(self.chooseEffReqMap) do
      req:Dispose()
    end
    self.chooseEffReqMap = nil
  end
  if self.sceneReq then
    self.sceneReq:Dispose()
    self.sceneReq = nil
  end
  if self.bossReqMap then
    for id, req in pairs(self.bossReqMap) do
      req:Dispose()
    end
    self.bossReqMap = nil
  end
  if self.bossAssetReqMap then
    for id, req in pairs(self.bossAssetReqMap) do
      req:Dispose()
    end
    self.bossAssetReqMap = nil
  end
  if self.petReqMap then
    for id, req in pairs(self.petReqMap) do
      req:Dispose()
    end
    self.petReqMap = nil
  end
  if self.petAnimReqMap then
    for id, req in pairs(self.petAnimReqMap) do
      req:Dispose()
    end
  end
  if self.petNbReqMap then
    for id, req in pairs(self.petNbReqMap) do
      req:Dispose()
    end
  end
  if self._player and self._player:IsPlaying() then
    self._player:Stop()
    self._player = nil
  end
  if self._timer and #self._timer > 0 then
    for i = 1, #self._timer do
      local timer = self._timer[i]
      GameGlobal.Timer():CancelEvent(timer)
    end
  end
  if self._skillEffectReqMap then
    for id, req in pairs(self._skillEffectReqMap) do
      req:Dispose()
    end
    self._skillEffectReqMap = nil
  end
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.OnN19P5SkipBigView, self.OnN19P5SkipBigView)
end

function UIN19P5AwardController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN19P5AwardController:OnValue()
  self._poolCount = #self._lotteryComponentInfo.m_jackpots
  self:GetCurrentPoolIdx()
  self:GetCurrentPoolLock()
  self:SetIcon()
  self:CreatePoolData()
  self:ShowPool()
  self:ShowInfo()
  self:ShowTestBtn()
  self:LockInAnim()
end

function UIN19P5AwardController:GetCurrentPoolLock()
  if self._lotteryComponentInfo.m_unlock_jackpots[self._currentIdx] then
    self.cantDrawCard = false
  else
    self.cantDrawCard = true
  end
end

function UIN19P5AwardController:GetCurrentPoolIdx()
  local allList = self._lotteryComponentInfo.m_jackpots
  local unLockList = self._lotteryComponentInfo.m_unlock_jackpots
  if #unLockList == #allList then
    local awardInfoList = self._lotteryComponentInfo.m_jackpots[#unLockList]
    for i = 1, #awardInfoList do
      local awardInfo = awardInfoList[i]
      if awardInfo.m_is_big_reward then
        if awardInfo.m_lottery_count <= 0 then
          for j = 1, #self._lotteryComponentInfo.m_jackpots do
            local awardInfoList2 = self._lotteryComponentInfo.m_jackpots[j]
            for k = 1, #awardInfoList2 do
              local info = awardInfoList2[k]
              if info.m_lottery_count > 0 then
                self._currentIdx = j
                return
              end
            end
          end
          self._currentIdx = 1
        else
          self._currentIdx = #unLockList
        end
        return
      end
    end
  else
    self._currentIdx = #unLockList
  end
end

function UIN19P5AwardController:SetIcon()
  self._costItemID = self._lotteryComponentInfo.m_cost_item_id
  local cfg_item = Cfg.cfg_item[self._costItemID]
  if not cfg_item then
    Log.error("###[UIN19P5AwardController] cfg item is nil !id --> ", self._costItemID)
  end
  self._costName = StringTable.Get(cfg_item.Name)
  self:ShowIconCount()
  self.Icon:LoadImage(cfg_item.Icon)
  self.sinIcon:LoadImage(cfg_item.Icon)
  self.mulIcon:LoadImage(cfg_item.Icon)
end

function UIN19P5AwardController:ShowIconCount()
  local count = self._itemModule:GetItemCount(self._costItemID)
  self.IconCount:SetText(count)
end

function UIN19P5AwardController:ChangeCameraFov()
  local defaultRate = BattleConst.CameraDefaultAspect
  local width = ResolutionManager.ScreenWidth()
  local height = ResolutionManager.ScreenHeight()
  local currentRate = width / height
  local maxRate = 1.333984375
  if currentRate < maxRate then
    currentRate = maxRate
  end
  if self.sceneGo then
    local camera = self.sceneGo:GetComponentInChildren(typeof(UnityEngine.Camera))
    if camera then
      local maxFov = 33
      local minFov = 30
      local fov = minFov
      if defaultRate > currentRate then
        fov = (defaultRate - currentRate) / (defaultRate - maxRate) * (maxFov - minFov) + minFov
      end
      camera.fieldOfView = fov
    end
  end
  if self.petNbGoMap then
    for id, go in pairs(self.petNbGoMap) do
      local maxFov = 75
      local minFov = 60
      local fov = minFov
      if defaultRate > currentRate then
        fov = (defaultRate - currentRate) / (defaultRate - maxRate) * (maxFov - minFov) + minFov
      end
      local camera1 = go.transform:Find("Root/eff_p5_chujue_atk/camera/Camera1"):GetComponent(typeof(UnityEngine.Camera))
      if camera1 then
        camera1.fieldOfView = fov
      end
      local camera2 = go.transform:Find("Root/eff_p5_" .. id .. "/camera/MainCamera"):GetComponent(typeof(UnityEngine.Camera))
      if camera2 then
        camera2.fieldOfView = fov
      end
      go:SetActive(false)
    end
  end
end

function UIN19P5AwardController:CreatePoolData()
  self.poolData = {}
  local bgName = "eff_p5_choujiang_01.prefab"
  self.sceneReq = ResourceManager:GetInstance():SyncLoadAsset(bgName, LoadType.GameObject)
  self.sceneGo = self.sceneReq.Obj
  self.sceneGo:SetActive(true)
  local hidden = UnityEngine.GameObject.Find("Hidden")
  self.HiddenTr = hidden.transform
  self.bossReqMap = {}
  self.bossAssetReqMap = {}
  self.bossGoMap = {}
  self.petReqMap = {}
  self.petGoMap = {}
  self.petNbGoMap = {}
  self.petNbReqMap = {}
  self.petAnimReqMap = {}
  self._timer = {}
  self._MaterialAnimationMap = {}
  self._MaterialAnimationContainerMap = {}
  self._skillEffectReqMap = {}
  self.posRootMap = {}
  for i = 1, #self._lotteryComponentInfo.m_jackpots do
    local poolidx = i
    local root = self.sceneGo.transform:Find("role/" .. tostring(poolidx))
    local petPosMap = {}
    local petList = {}
    local monsterid
    for k = 1, 4 do
      local pos = root:GetChild(k - 1)
      local petid = tonumber(pos.name)
      table.insert(petList, petid)
      petPosMap[petid] = pos
    end
    local monster = root:GetChild(4)
    monsterid = tonumber(monster.name)
    local rootMap = {}
    rootMap.PetMap = petPosMap
    rootMap.Monster = monster
    self.posRootMap[poolidx] = rootMap
    for j = 1, #petList do
      local petid = petList[j]
      if not self.petReqMap[petid] then
        local cfg_pet = Cfg.cfg_pet[petid]
        if not cfg_pet then
          Log.error("###[UIN19P5AwardController] cfg pet is nil ! id --> ", petid)
        end
        local petSkin = cfg_pet.SkinId
        local cfg_pet_skin = Cfg.cfg_pet_skin[petSkin]
        if not cfg_pet_skin then
          Log.error("###[UIN19P5AwardController] cfg_pet_skin is nil ! id --> ", petSkin)
        end
        local petPrefab = cfg_pet_skin.Prefab
        local req = ResourceManager:GetInstance():SyncLoadAsset(petPrefab, LoadType.GameObject)
        if req then
          self.petReqMap[petid] = req
          local go = req.Obj
          go:SetActive(true)
          self.petGoMap[petid] = go
          local _MaterialAnimation = go:GetComponent(typeof(MaterialAnimation))
          _MaterialAnimation = _MaterialAnimation or go:AddComponent(typeof(MaterialAnimation))
          local MaterialAnimationContainer = ResourceManager:GetInstance():SyncLoadAsset("n19p5PetOutLineEffects.asset", LoadType.Asset)
          self._MaterialAnimationContainerMap[petid] = MaterialAnimationContainer
          _MaterialAnimation:AddClips(MaterialAnimationContainer.Obj)
          self._MaterialAnimationMap[petid] = _MaterialAnimation
          go:SetActive(false)
        end
        local ancName = HelperProxy:GetPetAnimatorControllerName(petPrefab, PetAnimatorControllerType.Battle)
        if ancName then
          local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
          if req2 then
            self.petAnimReqMap[petid] = req2
            local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
            if anim then
              local go = self.petGoMap[petid]
              local petAnim = go:GetComponentInChildren(typeof(UnityEngine.Animator))
              petAnim.runtimeAnimatorController = anim.runtimeAnimatorController
            end
          end
        end
        local nbName = "eff_chujue_p5_" .. petid .. ".prefab"
        local nbReq = ResourceManager:GetInstance():SyncLoadAsset(nbName, LoadType.GameObject)
        if nbReq then
          self.petNbReqMap[petid] = nbReq
          local nbGo = nbReq.Obj
          self.petNbGoMap[petid] = nbGo
        end
      end
    end
    if not self.bossReqMap[monsterid] then
      local cfg_monster_class = Cfg.cfg_monster_class[monsterid]
      if not cfg_monster_class then
        Log.error("###[UIN19P5AwardController] cfg_monster_class is nil ! id --> ", monsterid)
      end
      local monsterPrefab = cfg_monster_class.ResPath
      local req = ResourceManager:GetInstance():SyncLoadAsset(monsterPrefab, LoadType.GameObject)
      self.bossReqMap[monsterid] = req
      local go = req.Obj
      local matAnimMonoCmpt = go:GetComponent(typeof(MaterialAnimation))
      if matAnimMonoCmpt then
        UnityEngine.Object.Destroy(matAnimMonoCmpt)
      end
      matAnimMonoCmpt = go:AddComponent(typeof(MaterialAnimation))
      local assetReq = ResourceManager:GetInstance():SyncLoadAsset("n19p5ShaderEffects.asset", LoadType.Asset)
      self.bossAssetReqMap[monsterid] = assetReq
      matAnimMonoCmpt:AddClips(assetReq.Obj)
      go:SetActive(false)
      self.bossGoMap[monsterid] = go
    end
    local bigID
    local awardList = self._lotteryComponentInfo.m_jackpots[i]
    for i = 1, #awardList do
      local awardInfo = awardList[i]
      if awardInfo.m_is_big_reward then
        bigID = awardInfo.m_item_id
        break
      end
    end
    local N19P5PoolData = N19P5PoolData:New(poolidx, petList, monsterid, bigID)
    self.poolData[poolidx] = N19P5PoolData
  end
  local effRootName = "Bip001 Head"
  local effRootPosName = "Root"
  self.chooseEffReqMap = {}
  self.chooseEffGoMap = {}
  self.chooseEffReqList = {
    [1601581] = "eff_p5_select03.prefab",
    [1601591] = "eff_p5_select02.prefab",
    [1501601] = "eff_p5_select03.prefab",
    [1501611] = "eff_p5_select02.prefab",
    [1501621] = "eff_p5_select01.prefab"
  }
  for id, reqName in pairs(self.chooseEffReqList) do
    local req = ResourceManager:GetInstance():SyncLoadAsset(reqName, LoadType.GameObject)
    if req then
      self.chooseEffReqMap[id] = req
      local go = req.Obj
      self.chooseEffGoMap[id] = go
      if self.petGoMap then
        local petGo = self.petGoMap[id]
        if petGo then
          local tr = GameObjectHelper.FindChild(petGo.transform, effRootName)
          local trPos = GameObjectHelper.FindChild(petGo.transform, effRootPosName)
          if tr then
            go.transform:SetParent(tr)
            go.transform.position = trPos.position
            go.transform.rotation = Quaternion.identity
            go.transform.localScale = Vector3(1, 1, 1)
            go:SetActive(false)
          end
        end
      end
    end
  end
  self:ChangeCameraFov()
end

function UIN19P5AwardController:GetPoolAwards()
  local jackpots = self._lotteryComponentInfo.m_jackpots
  local awards = jackpots[self._currentIdx]
  return awards
end

function UIN19P5AwardController:GetPrice()
  return self._lotteryComponentInfo.m_cost_count
end

function UIN19P5AwardController:GetCostID()
  return self._lotteryComponentInfo.m_cost_item_id
end

function UIN19P5AwardController:SortAwards(list)
  local awards = {}
  table.sort(list, function(a, b)
    local weightA = 0
    local weightB = 0
    if 0 < a.m_lottery_count then
      weightA = weightA + 10000
    end
    if 0 < b.m_lottery_count then
      weightB = weightB + 10000
    end
    if a.m_reward_type == ECampaignLRType.E_CLRT_big then
      weightA = weightA + 3000
    elseif a.m_reward_type == ECampaignLRType.E_CLRT_rare then
      weightA = weightA + 2000
    else
      weightA = weightA + 1000
    end
    if b.m_reward_type == ECampaignLRType.E_CLRT_big then
      weightB = weightB + 3000
    elseif b.m_reward_type == ECampaignLRType.E_CLRT_rare then
      weightB = weightB + 2000
    else
      weightB = weightB + 1000
    end
    if a.m_award_id < b.m_award_id then
      weightA = weightA + 100
    else
      weightB = weightB + 100
    end
    return weightA > weightB
  end)
  for i = #list, 1, -1 do
    local value = list[i]
    table.insert(awards, value)
  end
  return awards
end

function UIN19P5AwardController:ShowAwards()
  self:ShowIconCount()
  local awards = self:GetPoolAwards()
  awards = self:SortAwards(awards)
  self.Pool:SpawnObjects("UIN19P5AwardItem", #awards)
  local pools = self.Pool:GetAllSpawnList()
  for i = 1, #awards do
    local item = pools[i]
    local award = awards[i]
    local yieldTime
    local unitTime = 0.04
    yieldTime = unitTime * (#awards - i)
    item:SetData(award, function(award)
      self:ShowDialog("UIN19P5Tip", award)
    end, false, yieldTime)
  end
  self.PoolRect.anchoredPosition = Vector2(0, 0)
  self.notDrawCount = true
  local canDrawCardCount = 0
  for i = 1, #awards do
    local award = awards[i]
    if award.m_lottery_count and 0 < award.m_lottery_count then
      canDrawCardCount = canDrawCardCount + award.m_lottery_count
      self.notDrawCount = false
    end
  end
  if canDrawCardCount <= 0 then
    self.empty:SetActive(true)
  else
    self.empty:SetActive(false)
  end
  local color
  if self.cantDrawCard or self.notDrawCount then
    color = Color(0.27450980392156865, 0.27450980392156865, 0.27450980392156865, 1)
  else
    color = Color(1, 1, 1, 1)
  end
  self.SinBtnView.color = color
  self.MulBtnView.color = color
  self.SinTex.color = color
  self.MulTex.color = Color(0, 0, 0, 1)
  self.SinCostImgBg.color = color
  self.SinIconImg.color = color
  self.SinCost.color = color
  self.MulCostImgBg.color = color
  self.MulIconImg.color = color
  self.MulCost.color = color
  if self.cantDrawCard or self.notDrawCount then
    canDrawCardCount = 10
  elseif 10 < canDrawCardCount then
    canDrawCardCount = 10
  end
  self.SinTex:SetText(1)
  self.MulTex:SetText(canDrawCardCount)
  local costID = self:GetCostID()
  local currentHave = self._itemModule:GetItemCount(costID)
  self._sinEnough = true
  local price = self:GetPrice()
  local costSin = 1 * price
  if currentHave < costSin then
    if self.cantDrawCard or self.notDrawCount then
    else
      self.SinTex.color = Color(1, 0, 0, 1)
      self.SinCost.color = Color(1, 0, 0, 1)
    end
    self._sinEnough = false
  elseif self.cantDrawCard or self.notDrawCount then
  else
    self.SinTex.color = Color(1, 1, 1, 1)
    self.SinCost.color = Color(1, 1, 1, 1)
  end
  self.SinCost:SetText(costSin)
  self._mulEnough = true
  local costMul = canDrawCardCount * price
  if currentHave < costMul then
    if self.cantDrawCard or self.notDrawCount then
    else
      self.MulTex.color = Color(1, 0, 0, 1)
      self.MulCost.color = Color(1, 0, 0, 1)
    end
    self._mulEnough = false
  elseif self.cantDrawCard or self.notDrawCount then
  else
    self.MulTex.color = Color(0, 0, 0, 1)
    self.MulCost.color = Color(1, 1, 1, 1)
  end
  self.MulCost:SetText(costMul)
end

function UIN19P5AwardController:SetIdx()
  self.Idx:SetText("<size=60>" .. self._currentIdx .. "/</size>" .. self._poolCount)
end

function UIN19P5AwardController:FlushName()
  local data = self.poolData[self._currentIdx]
  local monsterName = data:MonsterName()
  self.Name:LoadImage(monsterName)
end

function UIN19P5AwardController:IntrBtnOnClick(go)
  self:ShowDialog("UIN19P5IntrController", "UIN19P5Award")
end

function UIN19P5AwardController:IconOnClick(go)
end
