local MAX_WEAPONED_WEAPON_NUM = 2
local TRINKET_SLOT_COUNT = 6
local SocialPlayerOverviewRightComp, Super = System.NewComponent("SocialPlayerOverviewRightComp")

function SocialPlayerOverviewRightComp:ctor(res, model)
  Super.ctor(self)
  self.ui = UIBaseResource(res)
  self.model = model
end

local function _OnClickShowAwakerDetail(serverData)
  local awakerData = serverData.awaker
  local items = serverData.items
  local previewData = {
    items = items,
    awakers = {awakerData},
    hideAwakerChangeForm = true
  }
  local awakerBasePanelData = {
    jumpPage = CommonDefine.AwakerPage.Detail,
    previewAwakersData = previewData
  }
  UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
end

function SocialPlayerOverviewRightComp:OnBind(binder)
  self.binder = binder
  binder:bindEvent(binder, "ChangeAssistAwaker", function()
    if not self.model.playerInfoData then
      return
    end
    self:_UpdateAssistAwaker(binder)
  end)
  binder:on("ChangeShowAwakers", function()
    self:_UpdateDisplayAwakers(binder)
  end)
  self:_UpdateAssistAwaker(binder)
  self:_UpdateDisplayAwakers(binder)
  self:_BindButtons(binder)
  self:_BindAwakerPortraitItem(binder, self.ui.Container_Awaker)
end

function SocialPlayerOverviewRightComp:UpdateOnceSetUI()
  local binder = self.binder
  binder:emit("ChangeAssistAwaker")
  binder:emit("ChangeShowAwakers")
  local assistAwaker = self.model:GetAssistAwaker()
  if not assistAwaker then
    return
  end
  self:_SetAwakerWeaponShow(binder, assistAwaker)
  self:_SetAwakerTrinketShow(binder, assistAwaker)
  self:_SetAwakerTalentInfo(binder)
end

function SocialPlayerOverviewRightComp:_BindButtons(binder)
  local function _OnClickChangeAssistAwaker(chooseAwakers)
    SocialDataUtils.ChangeAssistAwaker(chooseAwakers[1], {
      weapons = {
        [1] = {
          weaponUid = self.model.assistAwakerWeapons[1]
        },
        [2] = {
          weaponUid = self.model.assistAwakerWeapons[2]
        }
      },
      trinkets = self.model.assistAwakerTrinkets
    }, function()
      self.model:UpdateAssistAwaker(chooseAwakers[1])
      self.model:InitAwakerDetailData()
      binder:emit("ChangeAssistAwaker")
    end)
  end
  
  binder:BindButtonClick(self.ui.Button_Click_Add, function()
    if self.model.isMyInfo then
      local assistAwaker = self.model:GetAssistAwaker()
      UIManager.Instance:Reopen(Urls.SocialPlayerChooseAwakerPanel, {
        singleChoose = true,
        confirmCb = _OnClickChangeAssistAwaker,
        chosenAwakers = {
          assistAwaker.tid
        }
      })
      return
    end
    local assistAwakerInfo = self.model:GetAssistAwaker()
    if not assistAwakerInfo then
      return
    end
    SocialDataUtils.ReqQueryAwaker(self.model:GetUid(), assistAwakerInfo.tid, _OnClickShowAwakerDetail)
  end)
  binder:BindToVisible(self.ui.Image_Icon_1, function()
    if not self.model.isMyInfo then
      return false
    end
    if not self.model:HasAssistReward() then
      return false
    end
    return SocialRedUtils.GetSocialRed({
      RedTypeDefine.SocialSubType.AssistReward
    }) == RedPointDataUtils.RedAttrType.Red
  end)
  binder:BindToVisible(self.ui.Click_Assist_1, function()
    return self.model.isMyInfo
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, function()
    local title = LT.Text("AssistanceSystemTitle")
    local content = LT.Text("AssistanceSystemIntroduction")
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end)
  if not self.model.isMyInfo then
    return
  end
  
  local function _OnConfirm(chooseAwakers)
    SocialDataUtils.ChangeShowAwaker(chooseAwakers, function()
      self.model:UpdateShowAwakers(chooseAwakers)
      binder:emit("ChangeShowAwakers")
    end)
  end
  
  binder:BindButtonClick(self.ui.Click_Assist_1, function()
    local awakerInfos = self.model:GetDisplayAwakers()
    local chosenAwakers = {}
    for _, awakerInfo in ipairs(awakerInfos) do
      if awakerInfo then
        table.insert(chosenAwakers, awakerInfo.tid)
      end
    end
    UIManager.Instance:Reopen(Urls.SocialPlayerChooseAwakerPanel, {
      singleChoose = false,
      confirmCb = _OnConfirm,
      chosenAwakers = chosenAwakers,
      allowEmpty = true
    })
  end)
  binder:BindButtonClick(self.ui.Button_Click_Receive, function()
    if not self.model:HasAssistReward() then
      return
    end
    
    local function _OnReqGainRewardSucc(serverData)
      self.model:UpdateGainAssistRewardTimes()
      SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.AssistReward)
    end
    
    SocialDataUtils.ReqGainAssistReward(_OnReqGainRewardSucc)
  end)
end

function SocialPlayerOverviewRightComp:_UpdateAssistAwaker(binder)
  local assistAwaker = self.model:GetAssistAwaker()
  local validAssistAwaker = assistAwaker and assistAwaker.tid and assistAwaker.tid > 0
  binder:SetActive(self.ui.Image_Not, not validAssistAwaker)
  binder:SetActive(self.ui.Image_Add, self.model.isMyInfo)
  binder:SetActive(self.ui.Image_Install, validAssistAwaker)
  if not validAssistAwaker then
    return
  end
  local schoolIconPath
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(assistAwaker.tid)
  if awakerConfig then
    schoolIconPath = AwakerDataUtils.GetSchoolIcon(awakerConfig.School)
  end
  binder:SetImage(self.ui.Image_Job, schoolIconPath)
  if self.ui.Image_PremiumCardFace then
    if self.model.isMyInfo then
    end
    local showPremium = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(assistAwaker.tid, assistAwaker)
    binder:SetActive(self.ui.Image_PremiumCardFace, showPremium)
  end
  if self.ui.Image_AwakerFavor then
    if self.model.isMyInfo then
    end
    local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(assistAwaker.tid, assistAwaker)
    binder:SetActive(self.ui.Image_AwakerFavor, showFavor)
  end
  binder:SetText(self.ui.Text_AwakerName, AwakerDataUtils.GetAwakerName(assistAwaker.tid))
  binder:SetText(self.ui.Text_LvNum2, assistAwaker.level)
  self:_SetAwakerPotencyShow(binder, self.ui, assistAwaker)
  self:_SetAwakerSkillLevelShow(binder, assistAwaker)
  self:_SetAwakerWeaponShow(binder, assistAwaker)
  self:_SetAwakerTrinketShow(binder, assistAwaker)
  self:_SetAwakerTalentInfo(binder)
end

function SocialPlayerOverviewRightComp:_UpdateDisplayAwakers(binder)
  local awakerInfoList = self.model:GetDisplayAwakers()
  local isEmptyAwakerList = not awakerInfoList or #awakerInfoList <= 0
  binder:SetActive(self.ui.Image_Null_1, isEmptyAwakerList and not self.model.isMyInfo)
  binder:SetActive(self.ui.Image_Wake, not isEmptyAwakerList or self.model.isMyInfo)
  for index = 1, 4 do
    local awakerInfo = awakerInfoList[index]
    local obj = self.ui["UI_Awaker_Item_List" .. index]
    if not obj then
    else
      local addIconObj = self.ui["Image_Add_" .. index]
      if addIconObj then
        binder:SetActive(addIconObj, self.model.isMyInfo and nil == awakerInfo)
      end
      self:_RenderDisplayAwakerItem(binder, obj, awakerInfo)
    end
  end
end

function SocialPlayerOverviewRightComp:_RenderDisplayAwakerItem(binder, obj, awakerInfo)
  local ui = UI_Awaker_Item_ListResource(obj)
  self:_SetAwakerPotencyShow(binder, ui, awakerInfo)
  binder:SetActive(obj, nil ~= awakerInfo)
  if not awakerInfo then
    return
  end
  if not self.model.isMyInfo then
    binder:BindButtonClick(ui.Btn_Click, function()
      SocialDataUtils.ReqQueryAwaker(self.model:GetUid(), awakerInfo.tid, _OnClickShowAwakerDetail)
    end)
  end
  local schoolIconPath
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerInfo.tid)
  if awakerConfig then
    schoolIconPath = AwakerDataUtils.GetSchoolIcon(awakerConfig.School)
  end
  binder:SetImage(ui.Image_Career_Icon, schoolIconPath)
  binder:SetImage(ui.Image_Awaker, AwakerDataUtils.GetAwakerBust(awakerInfo.tid, awakerInfo.curSkin))
  binder:SetText(ui.Text_Level, LT.Textf("RoleInterfaceSort_Str_Level", awakerInfo.level))
  binder:SetImage(ui.Image_D_Quality_Color, AwakerDataUtils.GetAwakerQualityColor(awakerInfo.tid))
  if ui.Image_AwakerFavor then
    if self.model.isMyInfo then
    end
    local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerInfo.tid, awakerInfo)
    binder:SetActive(ui.Image_AwakerFavor, showFavor)
  end
end

function SocialPlayerOverviewRightComp:_BindAwakerPortraitItem(binder, imageObj)
  binder:BindToRaw(function(cbinder, resNum)
    local portraitAlign = CommonDefine.PortraitAlign.Center
    if resNum then
      self.awakerPortraitComp = cbinder:BindComponent(AwakerPortraitComp(imageObj, nil, resNum, nil, portraitAlign))
    end
  end, function()
    local assistAwaker = self.model:GetAssistAwaker()
    if not assistAwaker then
      return
    end
    if self.model.isMyInfo then
      do return AwakerDataUtils.GetAwakerResNum, assistAwaker.tid end
      return AwakerDataUtils.GetAwakerResNum, assistAwaker.tid, false
    end
    do return AwakerSkinUtils.GetSkinResNum, assistAwaker.curSkin end
    return AwakerSkinUtils.GetSkinResNum, assistAwaker.curSkin, assistAwaker.tid
  end)
end

function SocialPlayerOverviewRightComp:_SetAwakerPotencyShow(binder, rootUi, assistAwaker)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potencyLevel = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(rootUi.UI_Common_Item_Potency, {awakerTid = awakerTid, potencyLevel = potencyLevel}))
  end, function()
    if not assistAwaker then
      return
    end
    return {
      assistAwaker.tid,
      assistAwaker.potencyLevel
    }
  end)
  binder:BindToVisible(rootUi.UI_Common_Item_Potency, function()
    return assistAwaker
  end)
end

function SocialPlayerOverviewRightComp:_SetAwakerSkillLevelShow(binder, awakerData)
  binder:BindToRaw(function(cBinder)
    local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({
      skills = self.model.assistAwakerSkills
    })
    if not specialSkill then
      return
    end
    table.sort(skillList, function(a, b)
      return a.slot < b.slot
    end)
    cBinder:SetText(self.ui.Text_Mad, specialSkill.level)
    for i = 1, #skillList do
      local ui = self.ui["Text_Skill_0" .. i]
      local skillData = skillList[i]
      if ui and skillData then
        cBinder:SetText(ui, "/" .. skillData.level or 1)
      end
    end
  end, function()
    return self.model.assistAwakerSkills
  end)
end

function SocialPlayerOverviewRightComp:_SetAwakerTalentInfo(binder)
  local talents = self.model.assistAwakerTalents
  if talents then
    binder:SetText(self.ui.Txt_Talent, TalentDataUtils.GetDisplayTalentLvDesc(talents))
  end
end

function SocialPlayerOverviewRightComp:_SetAwakerWeaponShow(binder, awakerData)
  if self._weaponShowBound then
    return
  end
  self._weaponShowBound = true
  binder:BindToRaw(function(cBinder)
    local curAssistAwaker = self.model:GetAssistAwaker()
    local curAwakerTid = curAssistAwaker and curAssistAwaker.tid or 0
    for weaponSlot = 1, MAX_WEAPONED_WEAPON_NUM do
      local uiNode = self.ui["UI_Dungeons_Item_Weapon_" .. weaponSlot]
      local weaponGroup = self.model:GetAssistAwakerWeapons()
      local weaponUid = weaponGroup and weaponGroup[weaponSlot] or 0
      local itemData = {
        uid = weaponUid,
        isPreview = not self.model.isMyInfo,
        awakerTid = curAwakerTid,
        weaponSlot = weaponSlot,
        clickFunc = function()
          local liveAssistAwaker = self.model:GetAssistAwaker()
          local liveAwakerTid = liveAssistAwaker and liveAssistAwaker.tid or 0
          local liveWeaponGroup = self.model:GetAssistAwakerWeapons()
          local liveWeaponUid = liveWeaponGroup and liveWeaponGroup[weaponSlot] or 0
          local panelData = {
            selectWeaponSlot = weaponSlot,
            selectAwakerTid = liveAwakerTid,
            selectWeaponUid = liveWeaponUid,
            weaponedGroup = liveWeaponGroup,
            closeCallback = function(weaponUids)
              self.model:SetAssistAwakerWeapons(weaponUids)
              SocialDataUtils.ChangeAssistAwaker(liveAwakerTid, {
                weapons = {
                  [1] = {
                    weaponUid = self.model.assistAwakerWeapons[1]
                  },
                  [2] = {
                    weaponUid = self.model.assistAwakerWeapons[2]
                  }
                },
                trinkets = self.model.assistAwakerTrinkets
              }, function()
                self.model:InitAwakerDetailData()
              end)
            end
          }
          UIManager.Instance:Reopen(Urls.TeamWeaponEquipView, panelData)
        end
      }
      cBinder:BindComponent(CommonFightWeaponItem(uiNode, itemData))
    end
  end, function()
    local curAssistAwaker = self.model:GetAssistAwaker()
    return {
      curAssistAwaker and curAssistAwaker.tid or 0,
      self.model.assistAwakerWeapons
    }
  end)
end

function SocialPlayerOverviewRightComp:_BindTrinketClick(trinketDatasMap, boundTrinketsArg)
  self.binder:BindButtonClick(self.ui.Btn_Click_Trinket, function()
    local clickAwakerData = self.model:GetAssistAwaker()
    local clickAwakerTid = clickAwakerData and clickAwakerData.tid or 0
    local clickTrinketUids = self.model:GetAssistAwakerTrinkets(clickAwakerTid)
    if not self.model.isMyInfo then
      UIManager.Instance:Reopen(Urls.TrinketGroupDetailTipsView, trinketDatasMap, boundTrinketsArg)
    else
      local trinketEquipedView = UIManager.Instance:Reopen(Urls.TrinketEquipedView, clickAwakerData, {clickAwakerData}, nil, nil, clickTrinketUids)
      trinketEquipedView:RegisterCloseCb(function(trinketsRst)
        self.model:SetAssistAwakerTrinkets(trinketsRst)
        SocialDataUtils.ChangeAssistAwaker(clickAwakerTid, {
          weapons = {
            [1] = {
              weaponUid = self.model.assistAwakerWeapons[1]
            },
            [2] = {
              weaponUid = self.model.assistAwakerWeapons[2]
            }
          },
          trinkets = self.model.assistAwakerTrinkets
        }, function()
          self.model:InitAwakerDetailData()
        end)
      end)
    end
  end)
end

function SocialPlayerOverviewRightComp:_RefreshTrinketIconsAndLight(displayUids, boundTrinketsArg)
  local isEmptyTrinkets = true
  local trinketDatas = {}
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui["Team_Icon_0" .. i]
    if imageObj then
      local uid = displayUids[i]
      local itemData
      if uid and uid > 0 then
        itemData = ItemDataUtils.GetItemByUid(uid)
      end
      imageObj:SetActive(nil ~= itemData)
      trinketDatas[i] = itemData
      if nil ~= itemData then
        isEmptyTrinkets = false
      end
      local lightComp = self._trinketLightComps[i]
      if lightComp then
        local hasBound
        if self.model.isMyInfo then
          hasBound = AwakerTrinketDataUtils.IsTrinketBoundForLight(uid)
        else
          hasBound = AwakerTrinketDataUtils.IsTrinketBoundForLightByBoundTable(uid, boundTrinketsArg)
        end
        lightComp:EnableLight(true == hasBound, i)
      end
    end
  end
  return trinketDatas, isEmptyTrinkets
end

function SocialPlayerOverviewRightComp:_RefreshTrinketSuitAndConversion(displayUids, trinketDatas, isEmptyTrinkets)
  self.ui.Trinket_Add:SetActive(not TrinketModel.Instance:ExistsAnyTrinkets(displayUids) and self.model.isMyInfo)
  local suitId = AwakerTrinketDataUtils.GetSuitIdByTrinketUids(displayUids)
  self.ui.Trinket_Icon:SetActive(suitId)
  if suitId then
    self.binder:SetImage(self.ui.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
  if isEmptyTrinkets then
    self.ui.Image_Conversion:SetActive(false)
    self.binder:SetText(self.ui.Text_Conversion, "")
  else
    self.ui.Image_Conversion:SetActive(true)
    self.binder:SetText(self.ui.Text_Conversion, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinketDatas) .. "%")
  end
end

function SocialPlayerOverviewRightComp:_SetAwakerTrinketShow(_, awakerData)
  if self._trinketShowBound then
    return
  end
  self._trinketShowBound = true
  self._trinketLightComps = {}
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui["Team_Icon_0" .. i]
    if imageObj then
      self._trinketLightComps[i] = UICompTrinketIconMat(imageObj, {
        binder = self.binder
      })
    end
  end
  self.binder:BindToRaw(function()
    local liveAwakerData = self.model:GetAssistAwaker()
    local liveAwakerTid = liveAwakerData and liveAwakerData.tid or 0
    local trinketUids = self.model:GetAssistAwakerTrinkets(liveAwakerTid)
    local boundTrinketsArg = liveAwakerData and liveAwakerData.boundTrinkets or nil
    if not self.model.isMyInfo and not boundTrinketsArg then
      boundTrinketsArg = {}
    end
    local displayUids = AwakerTrinketDataUtils.GetDisplayTrinketUidsWithBound(liveAwakerTid, trinketUids, boundTrinketsArg)
    local trinketDatasMap = {}
    for slot, uid in pairs(displayUids) do
      local trinketData = ItemDataUtils.GetItemByUid(uid)
      trinketDatasMap[slot] = trinketData and trinketData or nil
    end
    AwakerTrinketDataUtils.RefreshBoundTrinketTags(self.ui, liveAwakerTid, trinketUids, boundTrinketsArg)
    self:_BindTrinketClick(trinketDatasMap, boundTrinketsArg)
    local trinketDatas, isEmptyTrinkets = self:_RefreshTrinketIconsAndLight(displayUids, boundTrinketsArg)
    self:_RefreshTrinketSuitAndConversion(displayUids, trinketDatas, isEmptyTrinkets)
  end, function()
    local curAssistAwaker = self.model:GetAssistAwaker()
    local curTid = curAssistAwaker and curAssistAwaker.tid or 0
    return {
      curTid,
      self.model:GetAssistAwakerTrinkets(curTid)
    }
  end)
end

function SocialPlayerOverviewRightComp:_HasAssistReward()
  do return self.model.HasAssistReward end
  return self.model.HasAssistReward, self.model
end

function SocialPlayerOverviewRightComp:_RecycleTrinketLightComps()
  for _, lightComp in ipairs(self._trinketLightComps or {}) do
    lightComp:OnExitComponent()
  end
  self._trinketLightComps = {}
end

function SocialPlayerOverviewRightComp:OnUnbind()
  self:_RecycleTrinketLightComps()
end

return SocialPlayerOverviewRightComp
