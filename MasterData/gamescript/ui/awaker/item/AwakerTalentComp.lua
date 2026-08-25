local AwakerPage = CommonDefine.AwakerPage
local TYPEOF_Z1Button = typeof(CS.Z1Client.Z1Button)
local Z1ButtonState = CS.Z1Client.Z1ButtonState
local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector2 = CS.UnityEngine.Vector2
local TalentUpgradeConfirmAlertMap = {
  [CommonDefine.AwakerTalentType.CrazyOmen] = "FrenziedOmenUpgradeConfirm",
  [CommonDefine.AwakerTalentType.AttrTalent] = "GnosticPotentialUpgradeConfirm"
}
local AwakerTalentComp, Super = System.NewComponent("AwakerTalentComp", AwakerBasePageComp)

function AwakerTalentComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Talent_MainResource(uiNode)
  self.model = model
  self.extModel = AwakerTalentExtModel.Instance
  self.isPreviewNextLevel = Vue.ref(false)
  self.talentUIResList = {}
  self.upgradeBtn = self.ui.UI_Common_Btn_Level1_Special:GetComponent(TYPEOF_Z1Button)
  self.uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.isPreview = Vue.ref(false)
end

function AwakerTalentComp:OnBind(binder)
  self.binder = binder
  self:InitTalentUIRes()
  binder:BindToRaw(function(cBinder)
    local page = self.model.page
    local isValid = page == AwakerPage.Talent or page == AwakerPage.TalentDetail
    if not isValid then
      return
    end
    if page == AwakerPage.Talent then
      local defaultIndex = 0
      self.extModel:SetAwakerTid(self.model.selectAwakerId, defaultIndex)
    end
    self:RefreshTalentDetail()
    self:BindTalentItemRed(cBinder)
    if page == AwakerPage.TalentDetail then
      cBinder:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self.RefreshTalentDetail))
    end
    if page == AwakerPage.Talent then
      self.isPreview.value = false
      binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
      local isAllTalentMaxLevel = self.extModel:IsAllTalentMaxLevel()
      self.ui.Btn_MaxLv:SetActive(not isAllTalentMaxLevel)
    end
  end, function()
    return {
      self.model.selectAwakerId,
      self.model.page
    }
  end)
  binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
  binder:BindButtonClick(self.ui.Btn_MaxLv, function()
    if not self.isPreview.value then
      binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.High)
      self.isPreview.value = true
    else
      binder:SetButtonState(self.ui.Btn_MaxLv, CommonDefine.Z1ButtonState.Normal)
      self.isPreview.value = false
    end
    self:SetTalentItemList()
  end)
  binder:BindToRaw(function()
    self.ui.UI_Common_Btn_Level1_Special:SetActive(not self.isPreview.value)
    self.ui.Group_Article:SetActive(not self.isPreview.value)
    self.ui.Image_Condition:SetActive(not self.isPreview.value)
    self:RefreshTalentDetail()
    local selectIndex = self.extModel:GetSelectedIndex()
    local level = self.extModel:GetTalentLevelByIndex(selectIndex)
    local isMocking = AwakerDataUtils.IsMocking()
    self.ui.Btn_Current:SetActive(not self.extModel:IsMaxLevel(selectIndex) and 0 ~= level and not isMocking and not self.isPreview.value)
    self.ui.Btn_Lower:SetActive(not self.extModel:IsMaxLevel(selectIndex) and 0 ~= level and not isMocking and not self.isPreview.value)
  end, function()
    return self.isPreview.value
  end)
  self:BindButtons(binder)
  if self.model:HasOwnedSelectAwaker() then
    PlayerDataUtils.OpenFirstTimeTutorial(self.__name, 83608)
  end
end

function AwakerTalentComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerTalentComp:_GetConfirmAlertTipTid()
  local talentTid = self.extModel.talentTid
  if not talentTid then
    return nil
  end
  local talentCfg = DT.AwakerTalent[talentTid]
  if not (talentCfg and talentCfg.data_list) or not talentCfg.data_list[1] then
    return nil
  end
  local talentType = talentCfg.data_list[1].TalentType
  if not talentType then
    return nil
  end
  return TalentUpgradeConfirmAlertMap[talentType]
end

function AwakerTalentComp:InitTalentUIRes()
  local uiNode = self.ui.ScrollView_Potency_List
  local talentUIResList = {}
  for i = 1, uiNode.transform.childCount do
    local child = uiNode.transform:GetChild(i - 1)
    table.insert(talentUIResList, UI_Awaker_Item_Potency_Point_BigResource(child.gameObject))
  end
  self.talentUIResList = talentUIResList
end

function AwakerTalentComp:BindButtons(binder)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level1_Special, function()
    self:ReqUpgradeTalent()
  end)
  self.ui.UI_Common_Btn_Level1_Special:SetActive(not AwakerDataUtils.IsMocking())
  for i = 1, #self.talentUIResList do
    local talentUIRes = self.talentUIResList[i]
    binder:BindButtonClick(talentUIRes.Btn_Click, function()
      self.model:SetAwakerPage(AwakerPage.TalentDetail)
      AwakerTalentExtModel.Instance:SetSelectedIndex(i)
      self:RefreshTalentDetail()
    end)
  end
  binder:BindZ1Button(self.ui.Btn_Current, function()
    self.isPreviewNextLevel.value = false
    self:ShowTalentLvAndDesc()
  end, function()
    return self.isPreviewNextLevel.value and Z1ButtonState.Normal or Z1ButtonState.High
  end)
  binder:BindZ1Button(self.ui.Btn_Lower, function()
    self.isPreviewNextLevel.value = true
    self:ShowTalentLvAndDesc()
  end, function()
    return self.isPreviewNextLevel.value and Z1ButtonState.High or Z1ButtonState.Normal
  end)
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, {
    DT.GetConstant("GoldItemTid"),
    DT.GetConstant("CommonSummonItemTid")
  }))
  self.ui.UI_Common_Item_Coin_Group:SetActive(not AwakerDataUtils.IsMocking())
  binder:BindButtonClick(self.ui.Image_Location, System.fn(self, self.JumpToTask))
end

function AwakerTalentComp:ReqUpgradeTalent()
  local index = self.extModel:GetSelectedIndex()
  if not index or 0 == index then
    Logger.Warn("index is nil or 0")
    return
  end
  if not self.extModel:IsUnlockedByIndex(index) then
    Logger.Warn("upgrade condition not ok")
    return
  end
  if not self.extModel:IsUpgradeItemEnough(index) then
    local costMoney = self.extModel:GetUpgradeNeedMoney(index)
    if not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(self.extModel:GetRequireItemByIndex(index), false, costMoney) then
      Logger.Warn("ungrade not enough items")
    end
    return
  end
  if self.extModel:IsMaxLevel(index) then
    Logger.Warn("ungrade already max")
    return
  end
  if not AwakerDataUtils.HasOwnedAwaker(self.extModel.awakerTid) then
    Logger.Warn("ungrade not obtained awakekr" .. self.extModel.awakerTid)
    return
  end
  local tipTid = self:_GetConfirmAlertTipTid()
  if tipTid and DT.TipsType[tipTid] then
    Alert.Show(tipTid, nil, function()
      self:_DoUpgradeTalent()
    end)
  else
    if tipTid and not DT.TipsType[tipTid] then
      Logger.Warn("TalentUpgradeConfirm TipsType not found:", tipTid)
    end
    self:_DoUpgradeTalent()
  end
end

function AwakerTalentComp:_DoUpgradeTalent()
  local awakerTid = self.extModel.awakerTid
  local talentTid = self.extModel.talentTid
  local level = self.extModel.level
  ProtoManager.Instance:ReqServer("GameRequest", "UpgradeTalent", function(svrData, errcode)
    Logger.Proto("UpgradeTalent result:", table.tostring(svrData), table.tostring(errcode))
    local levelUpStr = LT.Text("Awaker_LevelUp_Success")
    if 0 == level then
      levelUpStr = LT.Text("BreakThrough_Skill_Active_Success")
    end
    UIManager.Instance:Reopen(Urls.ActiveSuccessPanel, levelUpStr, nil, awakerTid)
    self.extModel:UpdateLevel(level + 1)
    self:RefreshTalentDetail()
    EventMgr.Instance.OnAwakerUpgradeTalent:Dispatch(awakerTid, talentTid, level + 1)
  end, function(...)
    Logger.Proto("UpgradeTalent fail:", table.tostring(...))
  end, awakerTid, talentTid, level)
end

function AwakerTalentComp:JumpToTask()
  local talentTid = self.extModel.talentTid
  local nextCfg = self.extModel:GetNextTalentCfg(talentTid)
  local taskList = nextCfg and nextCfg.TaskCondition or {}
  local taskTid = taskList[1]
  if taskTid then
    FuncJumpManager.Instance:JumpFunc(TaskDataUtils.GetTaskJumpTo(taskTid))
  end
end

function AwakerTalentComp:SetTalentItemList()
  for i = 1, #self.talentUIResList do
    local talentUIRes = self.talentUIResList[i]
    if self.isPreview.value then
      self:SetMaxlvPreviewTalentItem(talentUIRes, i)
    else
      self:SetTalentItem(talentUIRes, i)
    end
  end
end

function AwakerTalentComp:BindTalentItemRed(cbinder)
  for i = 1, #self.talentUIResList do
    local talentUIRes = self.talentUIResList[i]
    cbinder:BindToVisible(talentUIRes.RedDot, function()
      local talentTid = self.extModel:GetTalentIdByIndex(i)
      if talentTid then
        do return RedPointDataUtils.IsShowTalentRed end
        return RedPointDataUtils.IsShowTalentRed, talentTid
      end
    end)
  end
end

function AwakerTalentComp:SetTalentItem(talentUIRes, index)
  local talentId = self.extModel:GetTalentIdByIndex(index)
  if not talentId then
    talentUIRes.uiNode:SetActive(false)
    return
  end
  talentUIRes.uiNode:SetActive(true)
  local talentName = self.extModel:GetTalentNameByIndex(index)
  self.binder:SetText(talentUIRes.Text_Name, talentName)
  self.binder:SetImage(talentUIRes.Image_Icon, self.extModel:GetTalentIconByIndex(index))
  local level = self.extModel:GetTalentLevelByIndex(index)
  local maxLevel = self.extModel:GetTalentMaxLevelByIndex(index)
  local levelDesc = string.format("%s/%s", level, maxLevel)
  self.binder:SetText(talentUIRes.Text_Name_Active, levelDesc)
  talentUIRes.Image_Lock:SetActive(0 == level)
  local colorType = 0 == level and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self.binder:SetTextColorType(talentUIRes.Text_Name, colorType)
  self.binder:SetTextColorType(talentUIRes.Text_Name_Active, colorType)
  if talentUIRes.Group_StageChapter then
    self.binder:SetActive(talentUIRes.Group_StageChapter, false)
  end
  self.binder:SetActive(talentUIRes.Text_Name_Active, maxLevel > 1)
end

function AwakerTalentComp:SetMaxlvPreviewTalentItem(talentUIRes, index)
  local talentId = self.extModel:GetTalentIdByIndex(index)
  if not talentId then
    talentUIRes.uiNode:SetActive(false)
    return
  end
  talentUIRes.uiNode:SetActive(true)
  local maxLevel = self.extModel:GetTalentMaxLevelByIndex(index)
  local levelDesc = LT.Textf("MaxLvPreview_Txt", maxLevel) .. "/" .. maxLevel
  self.binder:SetText(talentUIRes.Text_Name_Active, levelDesc)
  talentUIRes.Image_Lock:SetActive(false)
  local colorType = CommonDefine.ColorType.Light
  self.binder:SetTextColorType(talentUIRes.Text_Name, colorType)
  self.binder:SetTextColorType(talentUIRes.Text_Name_Active, colorType)
  if talentUIRes.Group_StageChapter then
    self.binder:SetActive(talentUIRes.Group_StageChapter, false)
  end
  self.binder:SetActive(talentUIRes.Text_Name_Active, maxLevel > 1)
end

function AwakerTalentComp:RefreshTalentDetail()
  self.isPreviewNextLevel.value = false
  self:SetTalentItemList()
  local selectIndex = self.extModel:GetSelectedIndex()
  self:SetItemSelectedState(selectIndex)
  if not selectIndex or 0 == selectIndex then
    return
  end
  local level = self.extModel:GetTalentLevelByIndex(selectIndex)
  self.binder:SetText(self.ui.Text_Name, self.extModel:GetTalentNameByIndex(selectIndex))
  self:SetReqBtnInfo()
  local isMocking = AwakerDataUtils.IsMocking()
  self.ui.Btn_Current:SetActive(not self.extModel:IsMaxLevel(selectIndex) and 0 ~= level and not isMocking and not self.isPreview.value)
  self.ui.Btn_Lower:SetActive(not self.extModel:IsMaxLevel(selectIndex) and 0 ~= level and not isMocking and not self.isPreview.value)
  local talentTid = self.extModel:GetTalentIdByIndex(selectIndex)
  self.ui.Image_ActiveRedDot:SetActive(RedPointDataUtils.IsShowTalentRed(talentTid))
  local isMockAwaker = AwakerDataUtils.IsMocking()
  self.ui.Image_Condition:SetActive(self.extModel:IsHaveUnlockTask(talentTid) and not isMockAwaker and not self.isPreview.value)
  self:ShowTalentLvAndDesc()
  self:SetRequireItems(selectIndex)
  self:AutoHeightDesc()
  local isAllTalentMaxLevel = self.extModel:IsAllTalentMaxLevel()
  self.ui.Btn_MaxLv:SetActive(not isAllTalentMaxLevel)
end

function AwakerTalentComp:AutoHeightDesc()
  local height = 180
  local goHeightList = {
    self.ui.Image_Condition,
    300,
    self.ui.Group_Article,
    580
  }
  for go, sizey in table.iteraDouble(goHeightList) do
    if go.activeSelf then
      break
    end
    height = sizey
  end
  local sizeDelta = self.ui.DescView.transform.sizeDelta
  self.ui.DescView.transform.sizeDelta = Vector2(sizeDelta.x, height)
end

function AwakerTalentComp:SetReqBtnInfo()
  local level = self.extModel.level
  local selectIndex = self.extModel.selectedIndex
  local maxLevel = self.extModel:GetTalentMaxLevelByIndex(selectIndex)
  local awakerTid = self.extModel.awakerTid
  self.binder:BindToText(self.ui.Text_Levelup_Btn, function()
    do return self._GetLevelUpText end
    return self._GetLevelUpText, self
  end)
  self.binder:SetText(self.ui.Text_Condition, LT.Text(0 == level and "TalentActivationConditions" or "TalentUpgradeConditions"))
  local isUnlocked, unlockDesc, jumpTo = self.extModel:IsUnlockedByIndex(selectIndex)
  self.binder:SetText(self.ui.Text_Special1, LT.Text(unlockDesc))
  self.binder:SetTextColorType(self.ui.Text_Special1, CommonDefine.ColorType.Light)
  self.ui.Image_Location:SetActive(not isUnlocked and nil ~= jumpTo)
  self.ui.Image_Icon_Cond_1:SetActive(not isUnlocked)
  self.ui.Image_Icon_Hook_1:SetActive(isUnlocked)
  if not isUnlocked then
    local unlockTips = 0 == level and "TalentActivationConditionPrompt" or "TalentUpgradeConditionPrompt"
    self.binder:SetText(self.ui.Text_Warning_CN, LT.Text(unlockTips))
    self.binder:SetTextColorType(self.ui.Text_Special1, CommonDefine.ColorType.Dark)
  elseif not self.extModel:IsUpgradeItemEnough(selectIndex) then
    self.binder:SetText(self.ui.Text_Warning_CN, LT.Text("TalentUpgradeInsufficientMaterial"))
  end
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    self.binder:SetText(self.ui.Text_Warning_CN, LT.Text("AwakerNotObtained"))
  end
  self.binder:SetText(self.ui.Text_Actived, LT.Text(1 == maxLevel and "School_Activate" or "MaxLevel_Tips"))
  local btnState = self:GetReqBtnState()
  self.upgradeBtn.BtnState = btnState
  self.upgradeBtn.enabled = btnState == Z1ButtonState.Normal
end

function AwakerTalentComp:_GetLevelUpText()
  local index = self.extModel:GetSelectedIndex()
  local costMoney = self.extModel:GetUpgradeNeedMoney(index)
  if self.extModel:IsUpgradeItemEnough(index) or not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(self.extModel:GetRequireItemByIndex(index), true, costMoney) then
    local level = self.extModel.level
    do return LT.Text end
    return LT.Text, 0 == level and "AwakerPotencyBtnText" or "AwakerUpgradeBtnText", costMoney
  else
    do return LT.Text end
    return LT.Text, "AwakerUpgradeMaterialCompose", 0 == level and "AwakerPotencyBtnText" or "AwakerUpgradeBtnText", costMoney
  end
end

function AwakerTalentComp:GetReqBtnState()
  local index = self.extModel.selectedIndex
  local isConditionOk = self.extModel:IsUnlockedByIndex(index)
  local isMaxLevel = self.extModel:IsMaxLevel(index)
  local isItemEnough = self.extModel:IsUpgradeItemEnough(index)
  local costMoney = self.extModel:GetUpgradeNeedMoney(index)
  local awakerTid = self.extModel.awakerTid
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return Z1ButtonState.Unclickable
  end
  if isMaxLevel then
    return Z1ButtonState.High
  end
  if not isConditionOk then
    return Z1ButtonState.Unclickable
  end
  if not isItemEnough and not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(self.extModel:GetRequireItemByIndex(index), true, costMoney) then
    return Z1ButtonState.Unclickable
  end
  return Z1ButtonState.Normal
end

function AwakerTalentComp:ShowTalentLvAndDesc()
  local selectIndex = self.extModel:GetSelectedIndex()
  local level = self.extModel:GetTalentLevelByIndex(selectIndex)
  local argsColor
  if self.isPreview.value then
    level = self.extModel:GetTalentMaxLevelByIndex(selectIndex)
    argsColor = self:GetPreViewColor()
  elseif self.isPreviewNextLevel.value then
    level = level + 1
    argsColor = self:GetPreViewColor()
  end
  self.binder:SetText(self.ui.Text_Talent_Desc, self.extModel:GetTalentDescByIndex(selectIndex, level, argsColor))
  if self.isPreview.value then
    local lv = LT.Textf("MaxLvPreview_Txt", level)
    self.binder:SetText(self.ui.Text_Current, lv)
  else
    self.binder:SetText(self.ui.Text_Current, level)
  end
  local textColor = self.isPreviewNextLevel.value and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Light
  self.binder:SetTextColorType(self.ui.Text_Current, textColor)
  self.binder:SetText(self.ui.Text_Base, "/" .. self.extModel:GetTalentMaxLevelByIndex(selectIndex))
  self.ui.Text_Current:SetActive(level > 0)
  StrUtils.SetPreferredHeight(self.ui.Text_Talent_Desc)
end

function AwakerTalentComp:GetPreViewColor()
  local colorComp = self.ui.Text_Current:GetComponent(typeof(CS.FrameWork.TextColor))
  local colorKey = colorComp.colorKey
  local colorHexCode = ColorUtils.GetColorHexCode(colorKey, CommonDefine.ColorType.Dark)
  return colorHexCode
end

function AwakerTalentComp:SetRequireItems(index)
  if AwakerDataUtils.IsMocking() or self.isPreview.value then
    self.ui.Group_Article:SetActive(false)
    return
  end
  local requireItems = self.extModel:GetRequireItemByIndex(index)
  local normalItems, goldCount = self:SplitToNormalItemsAndGold(requireItems or {})
  if requireItems then
    self.ui.Group_Article:SetActive(true)
    local luaCenterGroup = AddLuaCompOnce(self.ui.Group_Items, LuaCenterGroupComp)
    luaCenterGroup:Reset()
    self.itemCompList = self.itemCompList or {}
    for i, itemData in ipairs(normalItems) do
      local itemComp = self.itemCompList[i]
      if itemComp then
        itemComp.binder:teardown()
      end
      local gameObject = luaCenterGroup:CreateChild(i)
      itemComp = self.binder:BindComponent(ItemPublicArticleCommon(gameObject, itemData))
      local ownNum = ItemDataUtils.GetItemNum(itemData.itemTid)
      local textOwnCount = CS.Framework.GameObjectUtil.FindChildByPath(gameObject, "Scale/Text_Own_Count")
      self.binder:SetText(textOwnCount, ownNum)
      local ownTextColorType = ownNum >= itemData.itemCount and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
      self.binder:SetTextColorType(textOwnCount, ownTextColorType)
      local textCostCount = CS.Framework.GameObjectUtil.FindChildByPath(gameObject, "Scale/Text_Cost_Count")
      self.binder:SetText(textCostCount, string.format("/%s", itemData.itemCount))
    end
    luaCenterGroup:HorizontalCenterChildren(100, 50)
    if not self.coinComp then
      self.coinComp = self.binder:BindComponent(CommonCoinCostCom(self.ui.UI_Common_Group_Coin))
    end
    self.ui.UI_Common_Group_Coin:SetActive(0 ~= goldCount)
    self.coinComp:UpdateCoinCost(DT.GetConstant("GoldItemTid"), goldCount, "{1}")
  else
    self.ui.Group_Article:SetActive(false)
  end
end

function AwakerTalentComp:SplitToNormalItemsAndGold(requireItems)
  local normalItems = {}
  local goldTid = DT.GetConstant("GoldItemTid")
  local goldCount = 0
  for itemTid, itemCount in table.iteraDouble(requireItems) do
    if itemTid == goldTid then
      goldCount = goldCount + itemCount
    else
      table.insert(normalItems, {
        itemTid = itemTid,
        itemCount = itemCount,
        ifShowAppr = true,
        ifShowDesc = true
      })
    end
  end
  return normalItems, goldCount
end

function AwakerTalentComp:SetItemSelectedState(selectIndex)
  for i = 1, #self.talentUIResList do
    local talentUIRes = self.talentUIResList[i]
    talentUIRes.Image_Select:SetActive(i == selectIndex)
  end
end

function AwakerTalentComp:GetOpenAnim()
end

function AwakerTalentComp:GetCloseAnim()
end

function AwakerTalentComp:GetEnterDetailAnim()
  return "UI_Awaker_Panel_Main_PotencyDetail_Talent_Open"
end

function AwakerTalentComp:GetExitDetailAnim()
  return "UI_Awaker_Panel_Main_PotencyDetail_Talent_Close"
end

function AwakerTalentComp:OnOpen()
  self.isOpend = true
  self.ui.UI_Awaker_Item_Potency_Detail:SetActive(false)
  self.uiAnimCtr:StopPlayableGraph()
  self.ui.uiNode:SetActive(true)
  self.uiAnimCtr:PlayState("UI_Awaker_Popup_Talent_Main_Open")
end

function AwakerTalentComp:OnClose()
  self.isOpend = false
  self.uiAnimCtr:PlayState("UI_Awaker_Popup_Talent_Main_Close", function()
    if not self.isOpend then
      self.ui.uiNode:SetActive(false)
    end
  end)
end

function AwakerTalentComp:OnEnterDetail()
  self.ui.UI_Awaker_Item_Potency_Detail:SetActive(true)
end

function AwakerTalentComp:OnExitDetail()
  self.ui.UI_Awaker_Item_Potency_Detail:SetActive(false)
end

function AwakerTalentComp:OnOpenAnimFinish()
end

function AwakerTalentComp:OnCloseAnimFinish()
end

function AwakerTalentComp:OnEnterDetailAnimFinish()
  StrUtils.SetPreferredHeight(self.ui.Text_Talent_Desc)
end

function AwakerTalentComp:OnExitDetailAnimFinish()
end

return AwakerTalentComp
