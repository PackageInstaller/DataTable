local TypeUIGrabPassRawImage = typeof(CS.UIGrabPassRawImage)
local Animator = CS.UnityEngine.Animator
local UIAnimationController = CS.Z1Client.UIAnimationController
local WorldStageBattleRewardPanel, Super = System.NewClass("WorldStageBattleRewardPanel", UIBasePanel)
WorldStageBattleRewardPanel.uiResCls = UI_Dbgcopy_Panel_Select_ExtraResource
local MAXREWARDNUM = 4

function WorldStageBattleRewardPanel:ctor(isShowCardReward, showData, callback, reqFunc)
  Super.ctor(self)
  
  local function reqFunction(param, returnFunc)
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("WorldRequest", "OnGearGainBattlePrize", function(data)
      if returnFunc then
        returnFunc(data)
      end
    end, function()
      Logger.Warn("领奖失败，直接关闭界面，防止卡住")
      if self.callback then
        self.callback()
      end
      Super.Close(self)
    end, param)
  end
  
  self.showData = showData
  self.isShowCardReward = isShowCardReward
  self.callback = callback
  self.reqFunc = reqFunc or reqFunction
  self.selectObjs = {}
  self.creationAnimMap = {
    [1] = {"L", "Left"},
    [2] = {"M", "Middle"},
    [3] = {"R", "Right"}
  }
  self:InitData()
end

function WorldStageBattleRewardPanel:OnBind(binder)
  self.ui.uiNode:SetActive(true)
  self.uiAniController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local MAX_RELIC_NUM = DT.GetConstant("RelicMaximumNumber")
  local maxLit = CopyAwakerDataUtils.GetAwakerAttrs(0, "relic_num_limit")
  if MAX_RELIC_NUM < maxLit then
    self.uiAniController:PlayState("UI_Dbgcopy_Panel_Select_Extra_Title")
  end
  binder:SetText(self.ui.Text_Desc, self.textDesc)
  binder:BindToVisible(self.ui.Btn_Cancel, function()
    return self.showData.giveUpEnchantArg ~= nil
  end)
  binder:BindToText(self.ui.Text_Bonus, function()
    do return string.format, "%s +%s", (LT.Textf("ExploreStressMaxReduceMaxHP", "")) end
    return string.format, "%s +%s", LT.Textf("ExploreStressMaxReduceMaxHP", ""), self.showData.giveUpEnchantArg or 0, ""
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnBtnCancel))
  self.ui.Group_Card:SetActive(self.isShowCardReward and 0 ~= #self.cardGroup)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      local layoutGroup = self.ui.Group_Card:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
      layoutGroup.enabled = false
    end
  end)
  self.ui.Group_Get_Creation_Anim:SetActive(not self.isShowCardReward and 0 ~= #self.creationGroup)
  if self.isShowCardReward then
    local enchantCount = 0
    for idx = 1, MAXREWARDNUM do
      local enchantInfo = self.cardGroup[idx]
      local cardUid = enchantInfo and enchantInfo.cardUid or 0
      self.ui["Card_" .. idx]:SetActive(0 ~= cardUid)
      if 0 ~= cardUid then
        enchantCount = enchantCount + 1
        self.selectObjs[idx] = binder:BindComponent(WorldStageCardSelectItem(self.ui["Card_" .. idx], enchantInfo, System.fn(self, self.RuneClickCb)))
      end
    end
    if 0 == enchantCount then
      self.reqFunc({})
      self.ui.uiNode:SetActive(false)
      local noEnchatCardId = 10612
      Alert.Show(noEnchatCardId)
      Super.Close(self)
      return
    end
  else
    for idx = 1, MAXREWARDNUM do
      local creationGo = self.ui["Creation_" .. idx]
      if creationGo then
        creationGo:SetActive(self.creationGroup[idx] ~= nil)
        if self.creationGroup[idx] then
          local creation = self.creationGroup[idx]
          binder:BindToImage(self.ui["Image_Creation_Icon_" .. self.creationAnimMap[idx][1]], function()
            return DT.RelicConfig[creation.tid].SmallIcon
          end)
          self.selectObjs[idx] = binder:BindComponent(WorldStageBigRelicItem(creationGo, creation, System.fn(self, self.CreationClickCb)))
        end
      end
    end
  end
  self.btnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.Close), function()
    return self.btnState.value
  end, function()
    return self.btnText
  end, nil, nil, nil)
  self.animator = self.ui.Group_Get_Creation_Anim:GetComponent(typeof(Animator))
  self:RegistAnimCallback()
  self.animator.enabled = true
  self.binder:SetActive(self.ui.UI_Common_Btn_Vibes, false)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnBtnMask))
  binder:BindEvent(EventMgr.Instance.MapEnterFinished, System.fn(self, self.OnMapEnterFinished))
  FrameWaiter.OnNextFrame(function()
    if not ClientDataUtils.GetClientSubData(cd.ClientSubKey.EventRunePanel) then
      ClientDataUtils.SetClientSubData(cd.ClientSubKey.EventRunePanel, 1)
      UIManager.Instance:Reopen(Urls.TutorialSimpleView, 17806)
    end
  end, 10)
end

function WorldStageBattleRewardPanel:OnMapEnterFinished()
  if self.ui.GlassMask then
    local grabPassRawImage = self.ui.GlassMask:GetComponentInChildren(TypeUIGrabPassRawImage)
    if grabPassRawImage then
      grabPassRawImage.enabled = false
      grabPassRawImage.enabled = true
    end
  end
end

function WorldStageBattleRewardPanel:InitData()
  self.textDesc = ""
  self.cardGroup = {}
  self.creationGroup = {}
  self.btnText = self.isShowCardReward and LT.Text("EnchantmentAwardButton") or LT.Text("RelicAwardButton")
  if self.showData then
    local retData = self.showData
    if retData.type == "relic" then
      self.creationGroup = self:GetCreationGroup(retData.items)
    elseif retData.type == "enchant" then
      self.cardGroup = self:GetCardGroup(retData.items)
    end
  end
  self.textDesc = self.isShowCardReward and (0 == #self.cardGroup and LT.Text("EnchantmentAwardFull") or LT.Text("EnchantmentAwardTitle")) or LT.Text("RelicAwardTitle")
  self:RefreshData()
end

function WorldStageBattleRewardPanel:RefreshData()
end

function WorldStageBattleRewardPanel:OnBtnMask()
  for _, cardItem in pairs(self.selectObjs) do
    cardItem:SetKeyWordVisible(false)
  end
end

function WorldStageBattleRewardPanel:OnBtnCancel()
  self.reqFunc({}, function()
    Super.Close(self)
  end)
end

function WorldStageBattleRewardPanel:ReqCardReward(curSelectIdx)
  local data = self.cardGroup[curSelectIdx]
  local curRuneTid = data.runeTid
  local uid = data.uid
  local param = {
    [1] = {
      itemType = "enchant",
      tid = curRuneTid,
      uid = uid
    }
  }
  self.binder:SetButtonInteractable(self.ui.UI_Common_Item_Btn_2, false, 2)
  self.reqFunc(param, function()
    local curCardUid = self.cardGroup[curSelectIdx].cardUid
    local cardData = CardDataUtils.GetCardInfo(curCardUid)
    if not cardData then
      self:OnClose()
      return
    end
    local upgradeRune
    if cardData.runes[1] ~= curRuneTid then
      upgradeRune = cardData.runes[1]
      cardData.runes[1] = curRuneTid
    end
    if upgradeRune then
      self.binder:BindTimer(0.3, 1, nil, function()
        cardData.runes[1] = upgradeRune
        local panelData = {
          cardUid = curCardUid,
          cardTid = cardData.configId,
          cardLevel = cardData.level
        }
        local cardFeatureInfoPanel = UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
        cardFeatureInfoPanel:ShowEffect()
        self.PostSound(upgradeRune, curRuneTid)
        self:OnClose()
      end)
    else
      self.binder:BindTimer(0.2, 1, function()
        self.PostSound(upgradeRune, curRuneTid)
        self:OnClose()
      end)
    end
  end)
end

function WorldStageBattleRewardPanel:ReqRelicReward(curSelectIdx)
  local param = {
    [1] = {
      itemType = "relic",
      tid = self.creationGroup[curSelectIdx].tid
    }
  }
  self.reqFunc(param, function()
    local str = self.creationAnimMap[curSelectIdx][2]
    local hash = Animator.StringToHash(str)
    if self.animator then
      self.animator:SetTrigger(hash)
    end
  end)
end

function WorldStageBattleRewardPanel:Close()
  if 0 == #self.selectObjs then
    local param = {}
    self.reqFunc(param)
    if self.callback then
      self.callback()
    end
    Super.Close(self)
  end
  local curSelectIdx
  for idx, item in pairs(self.selectObjs) do
    if item:GetIsShow() == true then
      curSelectIdx = idx
    end
  end
  if nil == curSelectIdx then
    local showText = self.isShowCardReward and LT.Text("EnchantmentAwardUncheck") or LT.Text("RelicAwardUncheck")
    UIManager.Instance:Show(Urls.PopMsgPanel, showText)
  else
    EventMgr.Instance.OpenReqMask:Dispatch()
    for idx = 1, MAXREWARDNUM do
      if self.selectObjs[idx] then
        self.selectObjs[idx]:EnableBtnClick(false)
      end
    end
    if self.isShowCardReward then
      self:ReqCardReward(curSelectIdx)
    else
      self:ReqRelicReward(curSelectIdx)
    end
  end
end

function WorldStageBattleRewardPanel:RuneClickCb(item)
  self:ResetSelectImage()
  item:EnableSelectShow(true)
  self.btnState.value = CommonDefine.BtnType.High
  AudioManager.Instance:PostSoundEvent("EXPLORE_SELECTCARD_POP")
end

function WorldStageBattleRewardPanel:CreationClickCb(item)
  self:ResetSelectImage()
  item:EnableSelectShow(true)
  self.btnState.value = CommonDefine.BtnType.High
  AudioManager.Instance:PostSoundEvent("EXPLORE_SELECTPROPS_POP")
end

function WorldStageBattleRewardPanel:ResetSelectImage()
  for _, item in pairs(self.selectObjs) do
    item:EnableSelectShow(false)
  end
end

function WorldStageBattleRewardPanel:GetCardGroup(runeList)
  local returnList = {}
  for _, runeItem in pairs(runeList) do
    table.insert(returnList, {
      runeTid = runeItem.tid,
      cardUid = runeItem.cardUid,
      uid = runeItem.index,
      cardTid = runeItem.cardTid
    })
  end
  return returnList
end

function WorldStageBattleRewardPanel:GetCreationGroup(creationList)
  local returnList = {}
  for _, creationItem in pairs(creationList) do
    table.insert(returnList, {
      tid = creationItem.tid
    })
  end
  return returnList
end

function WorldStageBattleRewardPanel:RegistAnimCallback()
  if not self.animator then
    return
  end
  local behaviors = self.animator:GetAnimatorStateBehaviors()
  local size = behaviors.Length
  for i = 0, size - 1 do
    behaviors[i]:onStateEnd("+", function(_)
      if self.callback then
        self.callback()
      end
      Super.Close(self)
    end)
  end
end

function WorldStageBattleRewardPanel.PostSound(upgradeRune, curRuneTid)
  if upgradeRune then
    AudioManager.Instance:PostSoundEvent("CARD_ENCHANT_LUCKY")
  end
end

function WorldStageBattleRewardPanel:OnClose()
  if self.callback then
    local callback = self.callback
    self.callback = nil
    callback()
  end
  Super.Close(self)
end

return WorldStageBattleRewardPanel
