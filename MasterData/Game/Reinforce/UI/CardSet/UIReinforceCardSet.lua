local base = UIBaseWindow
local UIReinforceCardSet = class("UIReinforceCardSet", base)
local UINReinforceCardNormalItem = require("Game.Reinforce.UI.CardSet.Card.UINReinforceCardNormalItem")
local UINReinforceCardSetDiffNode = require("Game.Reinforce.UI.CardSet.DiffSelect.UINReinforceCardSetDiffNode")
local UINReinforceCardSetBuffNode = require("Game.Reinforce.UI.CardSet.BuffDes.UINReinforceCardSetBuffNode")
local UINRfCardSetGroupItem = require("Game.Reinforce.UI.CardSet.Card.UINRfCardSetGroupItem")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")
local cs_InputUtility = CS.InputUtility
local cs_camera = CS.UnityEngine.Camera
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local CS_RotateMode = CS.DG.Tweening.RotateMode
local util = require("XLua.Common.xlua_util")
local color_gray = Color.New(0.5058823529411764, 0.5058823529411764, 0.5058823529411764)

function UIReinforceCardSet:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseFunc, {
    ConstGlobalItem.SKey
  }, self.TipGuideFunc)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickBtnStart)
  UIUtil.AddButtonListener(self.ui.btn_Edit, self, self.OnClickBtnEdit)
  UIUtil.AddButtonListener(self.ui.btn_RemoveAll, self, self.OnClickBtnRemoveAll)
  UIUtil.AddButtonListener(self.ui.btn_DiffChange, self, self.OnClickDiff)
  UIUtil.AddButtonListener(self.ui.Btn_ChipCheck, self, self.OnClickChipDetail)
  UIUtil.AddButtonListener(self.ui.Btn_EffectCheck, self, self.OnClickEffectDetail)
  UIUtil.AddButtonListener(self.ui.btn_Group, self, self.OnClickGroup)
  UIUtil.AddButtonListener(self.ui.btn_CloseGroup, self, self.OnClickCloseGroup)
  self.rfCardItemPool = UIItemPool.New(UINReinforceCardNormalItem, self.ui.cardItem, false)
  self.rfGroupSelectItemPool = UIItemPool.New(UINRfCardSetGroupItem, self.ui.obj_GroupItem, false)
  self.onClickGroupItemCallback = BindCallback(self, self.SwitchReinforceGroup)
  self.onClickEditCallback = BindCallback(self, self.OnClickBtnEdit)
  self.onCardNormalItemDragBeginCallback = BindCallback(self, self.OnCardNormalItemDragBegin)
  self.onCardNormalItemDragCallback = BindCallback(self, self.OnCardNormalItemDrag)
  self.onCardNormalItemDragEndCallback = BindCallback(self, self.OnCardNormalItemDragEnd)
  self.onCardNormalItemPointEnterCallback = BindCallback(self, self.OnCardNormalItemPointEnter)
  self.onCardNormalItemPointExitCallback = BindCallback(self, self.OnCardNormalItemPointExit)
  self.onEditGroupNameCompleteCallback = BindCallback(self, self.__OnEditGroupNameComplete)
  self._resLoader = cs_ResLoader.Create()
  if CloseCustomBename then
    self.ui.btn_Rename.interactable = false
    CS.EventTriggerListener.Get(self.ui.btn_Rename.gameObject):onClick("+", function()
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    end)
  else
    self.ui.btn_Rename.onEndEdit:AddListener(BindCallback(self, self.EditGroupName))
  end
  self.characterLimit = self.ui.btn_Rename.characterLimit
  self.diffNode = UINReinforceCardSetDiffNode.New()
  self.diffNode:Init(self.ui.DiffSelectedWindow)
  self.diffNode:Hide()
  self.buffNode = UINReinforceCardSetBuffNode.New()
  self.buffNode:Init(self.ui.EffectPreviewWindow)
  self.buffNode:Hide()
  self.effectBtnBind = {}
  UIUtil.LuaUIBindingTable(self.ui.Btn_EffectCheck.transform, self.effectBtnBind)
  self.chipBtnBind = {}
  UIUtil.LuaUIBindingTable(self.ui.Btn_ChipCheck.transform, self.chipBtnBind)
  self._OnSysCardChangeFunc = BindCallback(self, self._OnSysCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCardChangeFunc)
end

function UIReinforceCardSet:InitReinforceCardSet(actData, closeFunc)
  self.actData = actData
  self.closeFunc = closeFunc
  local actId = self.actData:GetActId()
  local actFrameId = self.actData:GetActFrameId()
  self.rfCardItemPool:HideAll()
  self.dataList = {}
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  self.curGroupId = self.actData:GetAnni24RfGroupId()
  local maxNum = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].need_card
  local cardIdList = self:GenNowCard(self.curGroupId)
  
  local function DelayInit()
    for index = 1, maxNum do
      local item = self.rfCardItemPool:GetOne()
      local data
      if self.facIndex == index then
        local facDataDic = dataAll:GetRfFactorCardDataDic()
        data = facDataDic[cardIdList[index]]
      elseif self.supportFacIndex == index then
        local needWait = true
        local cardUID = cardIdList[index]
        dataAll:TryGetSupportFacCardByUID(cardUID, function(cardData)
          data = cardData
          needWait = false
        end)
        while needWait do
          coroutine.yield(nil)
        end
        if data == nil then
          self.supportFacIndex = 0
        end
      else
        if cardIdList[index] == 0 then
        end
        data = dataAll:GetRfCardSysDataById(cardIdList[index])
      end
      item:InitCardNormalItem(data, index, index == 5, self._resLoader, self.onClickEditCallback)
      item:InitCardNormalItemEvent(self.onCardNormalItemDragBeginCallback, self.onCardNormalItemDragCallback, self.onCardNormalItemDragEndCallback, self.onCardNormalItemPointEnterCallback, self.onCardNormalItemPointExitCallback)
      self.dataList[index] = data
    end
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local lastDffId = userDataCache:GetAnni24LastDiffIndex(actId)
    if lastDffId == nil or lastDffId == 0 or ConfigData.reinforce_exploration_continue_diff[actFrameId][lastDffId] == nil then
      self.diffId = 1
    else
      self.diffId = lastDffId
    end
    local ticketID = ConstGlobalItem.SKey
    self.ui.img_Icon.sprite = CRH:GetDefaultKeySprite(ticketID)
    self:GenRfGroupItem()
    self:RefreshRfCardSet()
    self:PlayCardSetItemDoTween()
    self.__initCo = nil
  end
  
  if self.__initCo ~= nil then
    GR.StopCoroutine(self.__initCo)
    self.__initCo = nil
  end
  self.__initCo = GR.StartCoroutine(util.cs_generator(DelayInit))
end

function UIReinforceCardSet:TipGuideFunc()
  local tipId = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].tips_id
  if 0 < tipId then
    GuidePicture.OpenGuidePicture(tipId, nil)
  end
end

function UIReinforceCardSet:PlayCardSetItemDoTween(notNeedBeginTime)
  self.ui.obj_list:SetActive(false)
  if self.cardSetSequence then
    self.cardSetSequence:Rewind()
    self.cardSetSequence:Restart()
    return
  end
  self.cardSetSequence = cs_DoTween.Sequence()
  self.cardSetSequence:SetAutoKill(false)
  if not notNeedBeginTime then
    self.cardSetSequence:AppendInterval(self.ui.delayBeginTime)
  end
  self.cardSetSequence:AppendCallback(function()
    self.ui.obj_list:SetActive(true)
  end)
  for id, item in pairs(self.rfCardItemPool.listItem) do
    local time = notNeedBeginTime and self.ui.delayItemTime * (id - 1) or self.ui.delayBeginTime + self.ui.delayItemTime * (id - 1)
    self.cardSetSequence:Insert(time, item:PlayItemTween(0, self.ui.constTime))
  end
end

function UIReinforceCardSet:GenRfGroupItem()
  local maxNum = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].slots_num
  self.rfGroupSelectItemPool:HideAll()
  for i = 1, maxNum do
    local item = self.rfGroupSelectItemPool:GetOne()
    local dataAll = self.actData:GetActAnv24RfCardDataAll()
    local groupData = dataAll:GetRfCardGroupByGroupId(i)
    item:InitRfCardSetGroupItem(i, groupData.name, self.onClickGroupItemCallback)
  end
  self:OnEditGroupNameError()
end

function UIReinforceCardSet:SwitchReinforceGroup(groupId)
  local function DelaySwitch()
    self.curGroupId = groupId
    
    local dataAll = self.actData:GetActAnv24RfCardDataAll()
    local cardIdList = self:GenNowCard(groupId)
    for index, item in pairs(self.rfCardItemPool.listItem) do
      local data
      if self.facIndex == index then
        local facDic = dataAll:GetRfFactorCardDataDic()
        data = facDic[cardIdList[index]]
      elseif self.supportFacIndex == index then
        local needWait = true
        local cardUID = cardIdList[index]
        dataAll:TryGetSupportFacCardByUID(cardUID, function(cardData)
          data = cardData
          needWait = false
        end)
        ::lbl_33::
        if needWait then
          coroutine.yield(nil)
          goto lbl_33
        end
      else
        data = dataAll:GetRfCardSysDataById(cardIdList[index])
      end
      item:InitCardNormalItem(data, index, index == 5, self._resLoader, self.onClickEditCallback)
      self.dataList[index] = data
    end
    self:RefreshRfCardSet()
    self:OnEditGroupNameError()
    self:PlayCardSetItemDoTween(true)
    self.__refreshCo = nil
  end
  
  if self.__refreshCo ~= nil then
    GR.StopCoroutine(self.__refreshCo)
    self.__refreshCo = nil
  end
  self.__refreshCo = GR.StartCoroutine(util.cs_generator(DelaySwitch))
end

function UIReinforceCardSet:GenNowCard(groupId)
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local groupData = dataAll:GetRfCardGroupByGroupId(groupId)
  self.facIndex = 0
  self.supportFacIndex = 0
  local cardList = {}
  for index, cardId in pairs(groupData.reinforceCardId) do
    table.insert(cardList, cardId)
    if cardId ~= 0 and cardId == groupData.factorCardId then
      self.facIndex = index
    end
    if cardId ~= 0 and cardId == groupData.friendFactorCardId then
      self.supportFacIndex = index
    end
  end
  local maxNum = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].need_card
  if #groupData.reinforceCardId == 0 then
    for i = 1, maxNum do
      table.insert(groupData.reinforceCardId, 0)
    end
  end
  return cardList
end

function UIReinforceCardSet:SetGroupDataCardId(index, num)
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local groupData = dataAll:GetRfCardGroupByGroupId(self.curGroupId)
  groupData.reinforceCardId[index] = num
  if self.facIndex == index then
    groupData.factorCardId = num
  end
  if self.supportFacIndex == index then
    groupData.friendFactorCardId = num
  end
end

function UIReinforceCardSet:RefreshRfCardSet()
  local actFrameId = self.actData:GetActFrameId()
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][self.diffId]
  local stageId = diffCfg.stage_id
  local stageCfg = ConfigData.sector_stage[stageId]
  self.ui.tex_Num.text = tostring(stageCfg.cost_strength_num)
  self:CalEffectNum()
  self:CalBonusNum()
  self:RefreshEffectAndChipBtn()
  self.ui.Tex_DifferLevel:SetIndex(0, tostring(self.diffId))
end

function UIReinforceCardSet:CalBonusNum()
  local actFrameId = self.actData:GetActFrameId()
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][self.diffId]
  local bonusNum = diffCfg.infinite_coe
  for i, data in pairs(self.rfCardItemPool.listItem) do
    local infiniteCoe = data:GetCardInfiniteCoe() or 0
    bonusNum = bonusNum + infiniteCoe
  end
  local str = tostring(bonusNum) .. "%"
  self.ui.tex_Bonus.text = str
  self.ui.tex_Bonus:StartScrambleTypeWriter(true)
end

function UIReinforceCardSet:CalEffectNum()
  local actFrameId = self.actData:GetActFrameId()
  local diffCfg = ConfigData.reinforce_exploration_continue_diff[actFrameId][self.diffId]
  local effectNum = ReinforceUtil.CalEffectBySelectCardData(self.dataList, actFrameId, self.diffId)
  self.ui.tex_Effect.text = tostring(effectNum)
  self.ui.tex_Effect:StartScrambleTypeWriter(true)
end

function UIReinforceCardSet:OnEditGroupNameError()
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local groupData = dataAll:GetRfCardGroupByGroupId(self.curGroupId)
  if groupData ~= nil and not string.IsNullOrEmpty(groupData.name) then
    self.ui.btn_Rename.text = groupData.name
  else
    self.ui.btn_Rename.text = self.ui.tex_NowGroupName:GetIndex(0, tostring(self.curGroupId))
  end
end

function UIReinforceCardSet:EditGroupName(groupName)
  if string.IsNullOrEmpty(groupName) then
    self:OnEditGroupNameError()
    return
  end
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local groupData = dataAll:GetRfCardGroupByGroupId(self.curGroupId)
  if groupData ~= nil and groupData.name == groupName then
    return
  end
  local inputLength = RenameHelper:GetNameLength(groupName)
  if inputLength > self.characterLimit then
    groupName = RenameHelper:ClampNameInLength(groupName, self.characterLimit)
    self.ui.btn_Rename.text = groupName
  end
  local reinforceNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Reinforce)
  reinforceNetCtrl:CS_Reinforce_ListReName(self.actData:GetActFrameId(), self.curGroupId, groupName, self.onEditGroupNameCompleteCallback)
end

function UIReinforceCardSet:__OnEditGroupNameComplete()
  local name = self.ui.btn_Rename.text
  local groupItem = self.rfGroupSelectItemPool.listItem[self.curGroupId]
  if groupItem ~= nil then
    groupItem:ResetName(name)
  end
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local groupData = dataAll:GetRfCardGroupByGroupId(self.curGroupId)
  groupData.name = name
end

function UIReinforceCardSet:OnDiffChange(newDiff)
  self.diffId = newDiff
  self:RefreshRfCardSet()
  local actId = self.actData:GetActId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24LastDiffIndex(actId, newDiff)
end

function UIReinforceCardSet:OnClickDiff()
  local actFrameId = self.actData:GetActFrameId()
  self.diffNode:InitReinforceCSDN(actFrameId, self.diffId, function(newDiff)
    self:OnDiffChange(newDiff)
  end)
  self.diffNode:Show()
end

function UIReinforceCardSet:OnClickChipDetail()
  local chipDataDic = {}
  local startChipDataDic = {}
  for _, cardData in pairs(self.dataList) do
    local chipList = cardData:GetRfCardLibChipList()
    local startChipList = cardData:GetRfCdStartChipList()
    for _, chipData in pairs(chipList) do
      if chipDataDic[chipData.dataId] == nil then
        chipDataDic[chipData.dataId] = chipData
      end
    end
    for _, chipData in pairs(startChipList) do
      if startChipDataDic[chipData.dataId] == nil then
        startChipDataDic[chipData.dataId] = chipData
      end
    end
  end
  local chipDataList = {}
  for _, chipData in pairs(chipDataDic) do
    table.insert(chipDataList, chipData)
  end
  local startChipDataList = {}
  for _, chipData in pairs(startChipDataDic) do
    table.insert(startChipDataList, chipData)
  end
  if #chipDataList == 0 and #startChipDataList == 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59014))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    window:InitCurrentChip(chipDataList, startChipDataList)
  end, UIWindowTypeID.CurrentChip4CardSet)
end

function UIReinforceCardSet:OnClickEffectDetail()
  local buffDataDic = {}
  for _, cardData in pairs(self.dataList) do
    local bufflist = cardData:GetRfCdBuffList()
    for _, buffData in pairs(bufflist) do
      local buffId = buffData:GetBuffDataId()
      if buffDataDic[buffId] == nil then
        buffDataDic[buffId] = buffData
      end
    end
  end
  local buffDataList = {}
  for _, buffData in pairs(buffDataDic) do
    table.insert(buffDataList, buffData)
  end
  if #buffDataList == 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59016))
    return
  end
  self.buffNode:Show()
  self.buffNode:InitReinforceCSDN(buffDataList)
end

function UIReinforceCardSet:RefreshEffectAndChipBtn()
  local isHavingChip, isHavingEffect
  for _, cardData in pairs(self.dataList) do
    local chipList = cardData:GetRfCardLibChipList()
    local startChipList = cardData:GetRfCdStartChipList()
    if 0 < #chipList or 0 < #startChipList then
      isHavingChip = true
      break
    end
  end
  for _, cardData in pairs(self.dataList) do
    local bufflist = cardData:GetRfCdBuffList()
    if 0 < #bufflist then
      isHavingEffect = true
      break
    end
  end
  if isHavingEffect then
    self.effectBtnBind.img_bg.color = Color.white
    self.effectBtnBind.Text.color = Color.white
    self.effectBtnBind.Image.color = Color.white
  else
    self.effectBtnBind.img_bg.color = color_gray
    self.effectBtnBind.Text.color = color_gray
    self.effectBtnBind.Image.color = color_gray
  end
  if isHavingChip then
    self.chipBtnBind.img_bg.color = Color.white
    self.chipBtnBind.Text.color = Color.white
    self.chipBtnBind.Image.color = Color.white
  else
    self.chipBtnBind.img_bg.color = color_gray
    self.chipBtnBind.Text.color = color_gray
    self.chipBtnBind.Image.color = color_gray
  end
end

function UIReinforceCardSet:OnClickBtnStart()
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if ctrl == nil then
    return
  end
  local isError = false
  local maxNum = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].need_card
  local list = {}
  for i = 1, maxNum do
    if self.dataList[i] ~= nil then
      if self.dataList[i]:GetRfCdType() == eReinforce.eRfCardType.System then
        table.insert(list, self.dataList[i].dataId)
      elseif self.dataList[i]:GetIsSupport() then
        table.insert(list, self.dataList[i]:GetRfCdUID())
      else
        table.insert(list, self.dataList[i]:GetRfCdFactorOrder())
      end
    else
      isError = true
      break
    end
  end
  if isError then
    local err = ConfigData:GetTipContent(59015)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  local facCardId = 0
  if self.facIndex ~= 0 then
    facCardId = self.dataList[self.facIndex]:GetRfCdFactorOrder()
  end
  local supportfacCardUID = 0
  if self.supportFacIndex ~= 0 then
    supportfacCardUID = self.dataList[self.supportFacIndex]:GetRfCdUID()
  end
  
  local function startFunc()
    ctrl:EnterAnniversaryEp(self.actData, self.diffId, list, facCardId, supportfacCardUID)
  end
  
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local facDic = dataAll:GetRfFactorCardDataDic()
  if facCardId == 0 and 0 < table.count(facDic) and PlayerDataCenter.cacheSaveData:GetEnableCardSetFacEquipTip() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(59029), startFunc)
    window:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableCardSetFacEquipTip(not flag)
    end, false)
    return
  end
  startFunc()
end

function UIReinforceCardSet:OnClickBtnEdit()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardSetSelect, function(win)
    if win == nil then
      return
    end
    win:InitRfCardSetSelect(self.actData:GetActAnv24RfCardDataAll(), self.dataList, self.actData:GetActFrameId(), self.facIndex, self.supportFacIndex)
  end)
end

function UIReinforceCardSet:OnClickBtnRemoveAll()
  local function removeAllFunc()
    local maxNum = ConfigData.reinforce_exploration_main[self.actData:GetActFrameId()].need_card
    
    for i = 1, maxNum do
      if self.dataList[i] and self.dataList[i]:GetRfCdType() == eReinforce.eRfCardType.Factor then
        self.facIndex = 0
      end
      self.dataList[i] = nil
      self:SetCardItem(i)
    end
  end
  
  if PlayerDataCenter.cacheSaveData:GetEnableCardSetRemoveAll() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(59023), removeAllFunc)
    windonw:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableCardSetRemoveAll(not flag)
    end, false)
    return
  end
  removeAllFunc()
end

function UIReinforceCardSet:OnClickGroup()
  self.ui.lineDropDownList:SetActive(not self.ui.lineDropDownList.activeSelf)
  local z = self.ui.lineDropDownList.activeSelf and 0 or -180
  self.ui.btn_CloseGroup.gameObject:SetActive(self.ui.lineDropDownList.activeSelf)
  local rot = Vector3.New(0, 0, z)
  self.ui.trans_arrow:DOLocalRotate(rot, 0.5, CS_RotateMode.Fast)
end

function UIReinforceCardSet:OnClickCloseGroup()
  if self.ui.lineDropDownList.activeSelf then
    self:OnClickGroup()
    return
  end
end

function UIReinforceCardSet:SetCardItem(index)
  if self.supportFacIndex == index then
    self.supportFacIndex = 0
  end
  if self.facIndex == index then
    self.facIndex = 0
  end
  local num = 0
  if self.dataList[index] ~= nil and self.dataList[index]:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if self.dataList[index]:GetIsSupport() then
      self.supportFacIndex = index
      num = self.dataList[index]:GetRfCdUID()
    else
      self.facIndex = index
      num = self.dataList[index]:GetRfCdFactorOrder()
    end
  elseif self.dataList[index] ~= nil and self.dataList[index]:GetRfCdType() == eReinforce.eRfCardType.System then
    num = self.dataList[index].dataId
  end
  self:SetGroupDataCardId(index, num)
  self.rfCardItemPool.listItem[index]:ResetCardData(self.dataList[index])
  self:RefreshRfCardSet()
  MsgCenter:Broadcast(eMsgEventId.ReinforceFactorCardSetCardChange)
end

function UIReinforceCardSet:_OnSysCardChange()
  for id, item in pairs(self.rfCardItemPool.listItem) do
    item:RefreshNormalItem()
  end
  self:RefreshRfCardSet()
end

function UIReinforceCardSet:GetDataIndexByObj(go)
  for id, item in pairs(self.rfCardItemPool.listItem) do
    if item.gameObject == go then
      return item.index
    end
  end
  return 0
end

function UIReinforceCardSet:OnCardNormalItemDragBegin(go, eventData)
  local index = self:GetDataIndexByObj(go)
  local item = self.rfCardItemPool.listItem[index]
  if self.dataList[index] == nil then
    return
  end
  item:SetNormalMask(true)
  self.ui.img_MovePic.gameObject:SetActive(true)
  self.ui.img_MovePic.texture = item:GetNormalItemTexture()
  local pos = UIManager:Screen2UIPosition(cs_InputUtility.MousePosition, self.ui.img_MovePic.transform.parent, UIManager:GetUICamera())
  self.ui.img_MovePic.transform.anchoredPosition = pos
end

function UIReinforceCardSet:OnCardNormalItemDrag(go, eventData)
  local index = self:GetDataIndexByObj(go)
  if self.dataList[index] == nil then
    return
  end
  local pos = UIManager:Screen2UIPosition(cs_InputUtility.MousePosition, self.ui.img_MovePic.transform.parent, UIManager:GetUICamera())
  self.ui.img_MovePic.transform.anchoredPosition = pos
end

function UIReinforceCardSet:OnCardNormalItemDragEnd(go, eventData)
  local curIndex = self:GetDataIndexByObj(go)
  local item = self.rfCardItemPool.listItem[curIndex]
  if self.dataList[curIndex] == nil then
    return
  end
  self.ui.img_MovePic.gameObject:SetActive(false)
  item:SetNormalMask(false)
  if self.dragEnterIndex == nil or self.dragEnterIndex == 0 then
    return
  end
  if self.dragEnterIndex == curIndex then
    return
  end
  local cardTempData = self.dataList[curIndex]
  if cardTempData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if cardTempData:GetIsSupport() then
      self.supportFacIndex = self.dragEnterIndex
    else
      self.facIndex = self.dragEnterIndex
    end
  end
  local targetCardTempData = self.dataList[self.dragEnterIndex]
  if targetCardTempData and targetCardTempData:GetRfCdType() == eReinforce.eRfCardType.Factor then
    if targetCardTempData:GetIsSupport() then
      self.supportFacIndex = curIndex
    else
      self.facIndex = curIndex
    end
  end
  self.dataList[curIndex] = targetCardTempData
  self.dataList[self.dragEnterIndex] = cardTempData
  self:SetCardItem(curIndex)
  self:SetCardItem(self.dragEnterIndex)
  self.dragEnterIndex = nil
end

function UIReinforceCardSet:OnCardNormalItemPointEnter(go, eventData)
  local index = self:GetDataIndexByObj(go)
  self.dragEnterIndex = index
end

function UIReinforceCardSet:OnCardNormalItemPointExit(go, eventData)
  local index = self:GetDataIndexByObj(go)
  self.dragEnterIndex = nil
end

function UIReinforceCardSet:OnCloseFunc()
  if self.closeFunc then
    self.closeFunc()
  end
  self:Delete()
end

function UIReinforceCardSet:OnDelete()
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  ReinforceUtil.SetRfCardGroupData(dataAll)
  self.actData:SetAnni24RfGroupId(self.curGroupId)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self.__initCo ~= nil then
    GR.StopCoroutine(self.__initCo)
    self.__initCo = nil
  end
  if self.__refreshCo ~= nil then
    GR.StopCoroutine(self.__refreshCo)
    self.__refreshCo = nil
  end
  self.rfCardItemPool:DeleteAll()
  self.diffNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self._OnSysCardChangeFunc)
  if self.cardSetSequence ~= nil then
    self.cardSetSequence:Kill()
    self.cardSetSequence = nil
  end
  base.OnDelete(self)
end

return UIReinforceCardSet
