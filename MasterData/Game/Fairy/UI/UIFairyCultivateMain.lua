local UIFairyCultivateMain = class("UIFairyCultivateMain", UIBaseWindow)
local base = UIBaseWindow
local cs_Ease = CS.DG.Tweening.Ease
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon
local FairyCultivateMainUIData = require("Game.Fairy.Data.UIData.FairyCultivateMainUIData")
local UINFairyCultivateCardItemList = require("Game.Fairy.UI.UINFairyCultivateCardItemList")
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local UINFairyAttrItem = require("Game.Fairy.UI.UINFairyAttrItem")
local UINCommonStars = require("Game.Fairy.UI.UINCommonStars")
local UINFairyLeftMulRowPartNode = require("Game.Fairy.UI.LeftPartMul.UINFairyLeftMulRowPartNode")
local UINFairyRecommendHeroNode = require("Game.Fairy.UI.Recommend.UINFairyRecommendNode")
local UINFairySkillUpgradeNode = require("Game.Fairy.UI.UINFairySkillUpgradeNode")
local UINFairyAttriListNode = require("Game.Fairy.UI.Attribute.UINFairyAttriListNode")
local UINFairyTopFilterNode = require("Game.Fairy.UI.Common.UINFairyTopFilterNode")
local UINFairyUpgradeTipItem = require("Game.Fairy.UI.UINFairyUpgradeTipItem")
local UINFairyRightConsumeItem = require("Game.Fairy.UI.Right.UINFairyRightConsumeItem")
local UINFairySkillSelectedNode = require("Game.Fairy.UI.SkillSelect.UINFairySkillSelectedNode")
local UINFairySiftCondition = require("Game.Fairy.UI.ListFilter.UINFairySiftCondition")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local FairyHelper = require("Game.Fairy.FairyHelper")
local eFairyEnum = require("Game.Fairy.eFairyEnum")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local cs_ResLoader = CS.ResLoader
local upgradeState = {
  upgrade = 1,
  upStar = 2,
  recombine = 3,
  quickLvUp = 4
}

function UIFairyCultivateMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.SetTopStatus(self, self.OnClickBack, {
    ConstGlobalItem.FairyExp,
    ConstGlobalItem.FairyStarUpItem,
    ConstGlobalItem.FairyRecombineItem
  }, function()
    local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
    GuidePicture.OpenGuidePicture(56, nil)
  end)
  self.skillItemPool = UIItemPool.New(UINFairySkillItem, self.ui.uINElfSkillItem, false)
  self.upgradeTipItemPool = UIItemPool.New(UINFairyUpgradeTipItem, self.ui.obj_tipItem, false)
  UIUtil.AddButtonListener(self.ui.btn_AttriCheck, self, self.__OnClickFairyAttrDetail)
  UIUtil.AddButtonListener(self.ui.btn_SkillCheck, self, self.__OnClickFairySkillDetail)
  UIUtil.AddButtonListener(self.ui.btn_Recommend, self, self.__OnClickFairyRecommendHero)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self.__OnClickFairyUpgrade)
  self.ui.btn_Upgrade.onPress:AddListener(BindCallback(self, self.__OnClickFairyFastUpgrade))
  self.ui.btn_Upgrade.onPressDown:AddListener(BindCallback(self, self.__OnClickFairyUpgradeDown))
  UIUtil.AddButtonListener(self.ui.btn_ChangeName, self, self.__OnClickChangeFairyName)
  UIUtil.AddButtonListener(self.ui.btn_Recovery, self, self.__OnClickRecoveryFairy)
  UIUtil.AddButtonListener(self.ui.btn_Like, self, self.__OnClickFairyLike)
  UIUtil.AddButtonListener(self.ui.skillCardBottom, self, self.OnClickSkillCardBottom)
  self.__onItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onFairyUpdate = BindCallback(self, self.OnFairyUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  self.__onBtnNormalFairyFilterClickBind = BindCallback(self, self.NormalFairyFilterClick)
  self.__onBtnMulFairyFilterClickBind = BindCallback(self, self.MulFairyFilterClick)
  self.__onClickSkillCardItem = BindCallback(self, self.OnClickNormalSkillItem)
  self.__onFairyFilterConfirmActionBind = BindCallback(self, self.OnFairyFilterConfirmAction)
  self.__checkFairyFilterCanConfirmBind = BindCallback(self, self.CheckFairyFilterCanConfirm)
  self.__onOpenUseExpPacket = BindCallback(self, self._OpenUseExpPacket)
  self.OnClickFairyCallback = BindCallback(self, self.OnClickFairy)
  self.fairyCardList = UINFairyCultivateCardItemList.New()
  self.fairyCardList:Init(self.ui.list)
  self.skillUpgradeNode = UINFairySkillUpgradeNode.New()
  self.skillUpgradeNode:Init(self.ui.obj_skillUpgradeNode)
  self.skillSelectedNode = UINFairySkillSelectedNode.New()
  self.skillSelectedNode:Init(self.ui.obj_skillSelectedNode)
  self.costItem = UINFairyCultivateCardItem.New()
  self.costItem:Init(self.ui.obj_costItem)
  self.ui.img_star.gameObject:SetActive(false)
  self.starGoList = {}
  self.ui.img_upStar.gameObject:SetActive(false)
  self.upStarGoList = {}
  self.fairyQuality = UINFairyQualityItem.New()
  self.fairyQuality:Init(self.ui.img_Quality)
  self.upStarQuality = UINFairyQualityItem.New()
  self.upStarQuality:Init(self.ui.img_upStarQuality)
  self.attrItemPool = UIItemPool.New(UINFairyAttrItem, self.ui.obj_attriItem)
  self.ui.obj_attriItem:SetActive(false)
  self.btnUpgradeState = upgradeState.upgrade
  self.recommendHeroNode = UINFairyRecommendHeroNode.New()
  self.recommendHeroNode:Init(self.ui.recommendNode)
  self.filterTopNode = UINFairyTopFilterNode.New()
  self.filterTopNode:Init(self.ui.filterTopNode)
  self.leftPartNode = UINFairyLeftMulRowPartNode.New()
  self.leftPartNode:Init(self.ui.obj_leftListMulRow)
  self.skillCardItem = UINFairySkillUpgradeItem.New()
  self.skillCardItem:Init(self.ui.uINFairySkillCard)
  self.fairyAttrNode = UINFairyAttriListNode.New()
  self.fairyAttrNode:Init(self.ui.attriListNode)
  self.commonStars = UINCommonStars.New()
  self.commonStars:Init(self.ui.starsItem)
  self.consumeCostItem1 = UINFairyRightConsumeItem.New()
  self.consumeCostItem1:Init(self.ui.obj_cost1)
  self.consumeCostItem2 = UINFairyRightConsumeItem.New()
  self.consumeCostItem2:Init(self.ui.obj_cost2)
  self._switchTogQkLv = UINCommonSwitchToggle.New()
  self._switchTogQkLv:Init(self.ui.tog_SwitchQuickLv)
  self._isQuickLv = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):IsFairyQuickLvOn()
  if ConfigData.game_config.fairyBanQuickLvUp then
    self._isQuickLv = false
  end
  self._switchTogQkLv:InitCommonSwitchToggle(self._isQuickLv, BindCallback(self, self._OnChangeQuickLvUp))
end

function UIFairyCultivateMain:InitFairyCultivateMain(defaultUid, exitFunc)
  self.resloader = cs_ResLoader.Create()
  self.defaultUid = defaultUid
  self.skillItemPool:HideAll()
  self.fairyDataDic = self:GetFairyCtrl():GetFairyDataDic()
  self.exitFunc = exitFunc
  for k, v in pairs(self.fairyDataDic) do
    local keepDataDic, keepStar = v:GetFairyKeepData()
    if keepDataDic ~= nil and not table.IsEmptyTable(keepDataDic) then
      self:GetFairyCtrl():ShowFyKeepSkillSelect(v)
      self.defaultUid = k
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(22021))
      break
    end
  end
  local cardUIMainDataList = self:_GenUIMainData()
  local cardUIMainDataMulList = self:_GenUIMainData()
  self.fairyCardList:InitFairyCultivateCardItemList(self.resloader, self.OnClickFairyCallback, cardUIMainDataList)
  self.nowFairyCardList = self.fairyCardList
  self.filterTopNode:InitFairyTopFilterNode(self.__onBtnNormalFairyFilterClickBind, BindCallback(self, self.OnFairySortTypeChangeAction))
  self.leftPartNode:InitFairyLeftMulRowPartNode(self.resloader, cardUIMainDataMulList, self.__onBtnMulFairyFilterClickBind, BindCallback(self, self.OnFairySortTypeChangeMulAction), self.OnClickFairyCallback)
  self.fairyMulCardList = self.leftPartNode:GetFairyCardMulRowItemList()
  self.flag = false
  self.fairyCardList:PlayFairyCultivateCardItemListAnim(true)
end

function UIFairyCultivateMain:_GenUIMainData()
  local uiMainData = FairyCultivateMainUIData.CreateNewFairyCultivateMainUIData(self.fairyDataDic)
  uiMainData:SetRefreshFunc(BindCallback(self, self.RefreshCardItemList))
  uiMainData:SetSiftFunc(BindCallback(self, self.SiftFunction))
  return uiMainData
end

function UIFairyCultivateMain:GetFairyCtrl()
  if self.fairyCtrl == nil then
    self.fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  end
  return self.fairyCtrl
end

function UIFairyCultivateMain:RefreshCardItemList(isNotChange, isReSelect)
  local fairyCardList = self:GetNowFairyList()
  if self.flag then
    fairyCardList:ResetSelectedIndex()
  end
  if isNotChange then
    fairyCardList:RefreshCardListItem()
    return
  end
  if isReSelect then
    fairyCardList:Roll2IndexByUid(self:_GetCurQuickLvFyUID())
    return
  end
  fairyCardList:RefreshCultivateCardList()
end

function UIFairyCultivateMain:_GetCurQuickLvFyUID()
  local uid
  local isSelectSkill = UIManager:GetWindow(UIWindowTypeID.FairyQuickLvSkillSave) ~= nil
  if self._isQuickLv or isSelectSkill then
    uid = self:GetNowSelectFairyUID()
  end
  return uid
end

function UIFairyCultivateMain:_SetStarUI(fairyData)
  if #self.starGoList == 0 then
    for i = 1, fairyData:GetMaxStar() do
      local go = self.ui.img_star.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.starGoList, go)
    end
  end
  local count = fairyData:GetFairyCurStar()
  for i = 1, count do
    self.starGoList[i].gameObject:SetActive(true)
  end
  for i = count + 1, #self.starGoList do
    self.starGoList[i].gameObject:SetActive(false)
  end
end

function UIFairyCultivateMain:_SetUpStarUI(fairyData)
  if #self.upStarGoList == 0 then
    for i = 1, fairyData:GetMaxStar() do
      local go = self.ui.img_upStar.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.upStarGoList, go)
    end
  end
  self.commonStars:RefreshStarsByNum(fairyData:GetFairyCurStar())
  local count = fairyData:GetFairyCurStar() + 1
  for i = 1, count do
    self.upStarGoList[i].gameObject:SetActive(true)
  end
  for i = count + 1, #self.upStarGoList do
    self.upStarGoList[i].gameObject:SetActive(false)
  end
end

function UIFairyCultivateMain:__RefreshFairyAttr(fairyData)
  local attrDic = fairyData:GetFairyAttrAdd()
  self.attrItemPool:HideAll()
  local attrAddList = {
    100,
    200,
    0
  }
  local totalAttrNum = 0
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    for _, add in ipairs(attrAddList) do
      local realAttrId = attrId + add
      local attrValue = attrDic[realAttrId]
      if attrValue ~= nil and 0 < attrValue then
        local attrItem = self.attrItemPool:GetOne()
        attrItem:InitHeroAttrItem(realAttrId, attrValue)
        totalAttrNum = totalAttrNum + 1
      end
      if 5 < totalAttrNum then
        warn("fairy attr above 5.")
        return
      end
    end
  end
end

function UIFairyCultivateMain:RefreshFairyCountShow()
  FairyHelper.SetFairyCountText(self.ui.tex_FairyCount, self.fairyCtrl)
end

function UIFairyCultivateMain:RefreshUIInfo(fairyData)
  if fairyData == nil then
    return
  end
  self.ui.tex_ElfName.text = fairyData:GetFairyCurName()
  self.ui.tex_UpStarElfName.text = fairyData:GetFairyCurName()
  self.fairyQuality:InitFairyQualityItem(fairyData:GetCurFairyQuality())
  self.upStarQuality:InitFairyQualityItem(fairyData:GetCurFairyQuality())
  self.ui.tex_Lvl:SetIndex(0, tostring(fairyData:GetFairyCurLevel()), tostring(fairyData:GetCurStarMaxLevel()))
  self:_SetStarUI(fairyData)
  self.ui.img_LikeIcon.color = fairyData:GetIsFavouriteFairy() and self.ui.color_like or self.ui.color_notLike
  self.skillItemPool:HideAll()
  local nowMaxSkillNum = fairyData:GetMaxSkillNum()
  local ultMaxSkillNum = fairyData:GetMaxStateSkillNum()
  for i = 1, nowMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItem(fairyData:GetFairySkillBySlotIndex(i), self.resloader, self.__onClickSkillCardItem)
  end
  for i = nowMaxSkillNum + 1, ultMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItemEmpty(true)
  end
  self:__RefreshFairyAttr(fairyData)
  self:__RefreshFairyUpgrade(fairyData)
end

function UIFairyCultivateMain:ShowFlagListObj(bool)
  self.ui.obj_leftListOneRow:SetActive(not bool)
  self.ui.obj_leftListMulRow:SetActive(bool)
end

function UIFairyCultivateMain:ChangeFlagState()
  local listChange = false
  if self.flag then
    self.ui.obj_infoGroup:SetActive(false)
    self.ui.obj_skillNode:SetActive(false)
    self.skillUpgradeNode:Show()
    self.ui.obj_costFairy:SetActive(true)
    self.ui.obj_attriNode:SetActive(false)
    self.ui.obj_upgrade:SetActive(false)
    self.costItem:Hide()
    self.skillUpgradeNode:InitNFairySkillUpgradeNode(self.nowSelectFairy, self.resloader)
    listChange = self.nowFairyCardList ~= self.fairyMulCardList
    self.nowFairyCardList = self.fairyMulCardList
    MsgCenter:Broadcast(eMsgEventId.OnChangeFairyCultivateState, eFairyEnum.FairyCultivateState.upgradeStar)
  else
    self.ui.obj_infoGroup:SetActive(true)
    self.ui.obj_upStarsItem:SetActive(false)
    self.commonStars:Hide()
    self.ui.obj_normalStarsItem:SetActive(true)
    self.ui.obj_arrow:SetActive(false)
    self.ui.obj_tipGroup:SetActive(false)
    self.ui.obj_skillNode:SetActive(true)
    self.skillUpgradeNode:Hide()
    self.ui.obj_costFairy:SetActive(false)
    self.ui.obj_attriNode:SetActive(true)
    self.ui.tex_Lvl.gameObject:SetActive(true)
    self.ui.obj_upgrade:SetActive(true)
    self.upgradeTipItemPool:HideAll()
    listChange = self.nowFairyCardList ~= self.fairyCardList
    self.nowFairyCardList = self.fairyCardList
    self.leftPartNode:SetCostCard(nil)
    self:RefreshFairyCountShow()
    MsgCenter:Broadcast(eMsgEventId.OnChangeFairyCultivateState, eFairyEnum.FairyCultivateState.check)
  end
  if listChange then
    if self.flag then
      self:RefreshCardItemList()
    else
      self.fairyCardList:Roll2IndexByUid(self.nowSelectFairy:GetFairyUID())
    end
  end
  self:RefreshConsumeNum()
  local showQuickLv = not self.flag and not ConfigData.game_config.fairyBanQuickLvUp and self.nowSelectFairy and self.nowSelectFairy:GetMaxStarMaxLevel() > self.nowSelectFairy:GetFairyCurLevel()
  self._switchTogQkLv.transform.parent.gameObject:SetActive(showQuickLv)
end

local function upLvFunc(self)
  self.ui.costBottom:SetActive(true)
  self:ShowFlagListObj(false)
  self:ChangeFlagState()
  self.ui.tex_Upgrade:SetIndex(1)
  self.ui.obj_Tips:SetActive(not self.upgradeFlag)
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tex_UpgradeRect)
end

local upgradeStateFunc = {
  [upgradeState.upgrade] = upLvFunc,
  [upgradeState.upStar] = function(self)
    self.ui.costBottom:SetActive(true)
    self.ui.tex_Upgrade:SetIndex(0)
    self.ui.obj_Tips:SetActive(false)
    local flag = self.flag
    self:ShowFlagListObj(flag)
    if flag then
      local deleteDic = {}
      for id, data in pairs(self.fairyDataDic) do
        if not self.nowSelectFairy:GetIsSatisfyConsume(data) then
          deleteDic[id] = data
        end
      end
      local cardList = self:GetNowFairyList()
      cardList:GetMainUIData():RejectFairyDic(deleteDic, true)
      self:RefreshBottomTipUI()
      self.ui.obj_upStarsItem:SetActive(true)
      self.commonStars:Show()
      self.ui.obj_normalStarsItem:SetActive(false)
      self.ui.obj_arrow:SetActive(true)
      self.ui.obj_tipGroup:SetActive(true)
      self.ui.tex_Lvl.gameObject:SetActive(false)
      self:_SetUpStarUI(self.nowSelectFairy)
      self.upgradeTipItemPool:HideAll()
      local tipOne = self.upgradeTipItemPool:GetOne(true)
      tipOne:InitFairyUpgradeTipItem(0, self.nowSelectFairy)
      local nowSkillNum = self.nowSelectFairy:GetMaxSkillNum()
      local nextSkillNum = self.nowSelectFairy:GetNextMaxSkillNum()
      if nowSkillNum < nextSkillNum then
        local tipTow = self.upgradeTipItemPool:GetOne(true)
        tipTow:InitFairyUpgradeTipItem(1, self.nowSelectFairy)
      end
      self:ChangeFlagState()
      CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tex_UpgradeRect)
      self.leftPartNode:GetFairyCardMulRowItemList():PlayFairyCultivateCardItemListAnim()
      self:__PlayFairyCultivateMainRightAnim()
    else
      self.ui.img_Upgrade.color = self.ui.color_canClick
      self:ChangeFlagState()
    end
  end,
  [upgradeState.recombine] = function(self)
    self.ui.costBottom:SetActive(true)
    self.ui.tex_Upgrade:SetIndex(2)
    self.ui.obj_Tips:SetActive(false)
    local flag = self.flag
    self:ShowFlagListObj(flag)
    if flag then
      local deleteDic = {
        [self.nowSelectFairy:GetFairyUID()] = self.nowSelectFairy
      }
      local cardList = self:GetNowFairyList()
      cardList:GetMainUIData():RejectFairyDic(deleteDic, true)
      self:RefreshBottomTipUI()
      self.ui.obj_upStarsItem:SetActive(false)
      self.commonStars:Hide()
      self.ui.obj_normalStarsItem:SetActive(true)
      self.ui.obj_arrow:SetActive(false)
      self.ui.obj_tipGroup:SetActive(false)
      self.ui.tex_Lvl.gameObject:SetActive(true)
      self:ChangeFlagState()
      CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tex_UpgradeRect)
      self.leftPartNode:GetFairyCardMulRowItemList():PlayFairyCultivateCardItemListAnim()
      self:__PlayFairyCultivateMainRightAnim()
    else
      self.ui.img_Upgrade.color = self.ui.color_canClick
      self:ChangeFlagState()
    end
  end,
  [upgradeState.quickLvUp] = function(self)
    upLvFunc(self)
    self.ui.obj_Tips:SetActive(false)
    self.ui.costBottom:SetActive(false)
  end
}

function UIFairyCultivateMain:__RefreshFairyUpgrade(fairyData)
  if fairyData:GetIsUpgradeState() then
    self.btnUpgradeState = upgradeState.upgrade
  elseif fairyData:GetIsUpStarState() then
    self.btnUpgradeState = upgradeState.upStar
  else
    self.btnUpgradeState = upgradeState.recombine
  end
  if self.btnUpgradeState ~= upgradeState.recombine and self._isQuickLv then
    self.btnUpgradeState = upgradeState.quickLvUp
  end
  upgradeStateFunc[self.btnUpgradeState](self)
end

function UIFairyCultivateMain:RefreshBottomTipUI()
  if not self.flag then
    return
  end
  local tipId = self.btnUpgradeState == upgradeState.upStar and 22013 or 22014
  local cardLIst = self:GetNowFairyList()
  local uiList = cardLIst:GetMainUIData():GetFairyDataUIList()
  if #uiList == 0 then
    self.ui.tex_bottomTip.gameObject:SetActive(true)
    self.ui.tex_bottomTip.text = ConfigData:GetTipContent(tipId)
  else
    self.ui.tex_bottomTip.gameObject:SetActive(false)
  end
end

function UIFairyCultivateMain:RefreshConsumeFairyUI(isCancel)
  self.ui.obj_upgrade:SetActive(not isCancel)
  self.leftPartNode:SetCostCard(self.selectConsumeFairy)
  self.skillUpgradeNode:SetConsumeFairy(self.selectConsumeFairy)
end

function UIFairyCultivateMain:OpenSkillSelectedNode()
  self.skillSelectedNode:Show()
  local fairyDataList = {}
  table.insert(fairyDataList, self.nowSelectFairy)
  table.insert(fairyDataList, self.selectConsumeFairy)
  self.skillSelectedNode:InitUINFairySkillSelectedNode(fairyDataList, self.resloader, self.skillUpgradeNode, BindCallback(self, self.__OnClickFairyUpgrade), self)
end

function UIFairyCultivateMain:OnClickFairy(fairyData)
  self.selectConsumeFairy = nil
  if fairyData == nil then
    return
  end
  if self.flag then
    self.selectConsumeFairy = fairyData
    self:RefreshConsumeFairyUI()
    return
  end
  self.upgradeFlag = false
  self.nowSelectFairy = fairyData
  self:RefreshUIInfo(fairyData)
  self:UpdateFairyModel(fairyData)
end

function UIFairyCultivateMain:UpdateFairyModel(fairyData)
  MsgCenter:Broadcast(eMsgEventId.OnShowFairyChange, fairyData)
end

function UIFairyCultivateMain:PlayFairyLevelUpAnimation()
  MsgCenter:Broadcast(eMsgEventId.OnShowFairyLevelUp)
end

function UIFairyCultivateMain:PlayFairyNormalLevelUpEffect()
  MsgCenter:Broadcast(eMsgEventId.OnShowFairyNormalLevelUp)
end

function UIFairyCultivateMain:RefreshConsumeNum()
  if self.nowSelectFairy == nil then
    return
  end
  self.consumeCostItem1:Show()
  self.consumeCostItem2:Hide()
  if self.btnUpgradeState == upgradeState.upgrade then
    local needUpgradeNum = self.nowSelectFairy:GetIsFairyCurLevelMaxExp() - self.nowSelectFairy:GetFairyCurExp()
    self.consumeCostItem1:InitFairyRightConsumeItem(ConstGlobalItem.FairyExp, needUpgradeNum, self.__onOpenUseExpPacket)
  elseif self.btnUpgradeState == upgradeState.upStar and self.flag then
    local ids, nums = self.nowSelectFairy:GetUpStarMainItemList()
    self.consumeCostItem1:InitFairyRightConsumeItem(ids[1], nums[1], self.__onOpenUseExpPacket)
    if 1 < #ids then
      self.consumeCostItem2:Show()
      self.consumeCostItem2:InitFairyRightConsumeItem(ids[2], nums[2], self.__onOpenUseExpPacket)
    end
  elseif self.btnUpgradeState == upgradeState.recombine and self.flag then
    local itemId, itemCount = self.nowSelectFairy:GetRecombineItem()
    self.consumeCostItem1:InitFairyRightConsumeItem(itemId, itemCount, self.__onOpenUseExpPacket)
  else
    self.consumeCostItem1:Hide()
  end
end

function UIFairyCultivateMain:OnItemUpdate()
  self:RefreshConsumeNum()
end

function UIFairyCultivateMain:OnFairyUpdate(haveChange, fairyCtrl)
  local isSelectSkill = UIManager:GetWindow(UIWindowTypeID.FairyQuickLvSkillSave) ~= nil
  if haveChange or isSelectSkill then
    self.fairyDataDic = fairyCtrl:GetFairyDataDic()
    self.fairyMulCardList:GetMainUIData():UpdateFairyCultivateMainUIData(self.fairyDataDic)
    self.fairyCardList:GetMainUIData():UpdateFairyCultivateMainUIData(self.fairyDataDic)
    self:RefreshCardItemList(false, true)
    local fairyDataList = self.fairyCardList:GetMainUIData():GetFairyDataUIList()
    if #fairyDataList == 0 then
      self:UpdateFairyModel(nil)
    end
  else
    self:RefreshCardItemList(true)
    self:RefreshUIInfo(self.nowSelectFairy)
  end
  self:RefreshFairyCountShow()
  self.leftPartNode:RefreshFairyCountShow()
end

function UIFairyCultivateMain:__OnClickFairyRecommendHero()
  self.recommendHeroNode:InitNFairyRecommendNode(self.nowSelectFairy, self.resloader)
  UIUtil.HideTopStatus()
end

function UIFairyCultivateMain:__OnClickFairyAttrDetail()
  self.fairyAttrNode:InitUINFairyAttriListNode(self.nowSelectFairy)
  UIUtil.HideTopStatus()
end

function UIFairyCultivateMain:__OnClickFairySkillDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.FairySkillDetails, function(window)
    if window == nil then
      return
    end
    window:InitFairySkillDetailsNode(self.nowSelectFairy)
  end)
end

function UIFairyCultivateMain:__OnClickFairyLike()
  self:GetFairyCtrl().network:CS_Fairy_Favor(self.nowSelectFairy:GetFairyUID(), function()
    self.nowSelectFairy:SetIsFavouriteFairy(not self.nowSelectFairy:GetIsFavouriteFairy())
  end)
end

function UIFairyCultivateMain:__OnClickFairyUpgradeDown()
  self.canClick = true
end

function UIFairyCultivateMain:__OnClickFairyFastUpgrade()
  self.canClick = false
  if self.btnUpgradeState == upgradeState.upgrade then
    local maxUpLevel = self.nowSelectFairy:GetMaxUpLevel()
    if maxUpLevel > self.nowSelectFairy:GetFairyCurLevel() then
      self.upgradeFlag = true
      self:GetFairyCtrl().network:CS_Fairy_Upgrade(self.nowSelectFairy:GetFairyUID(), maxUpLevel, function()
        self:PlayFairyNormalLevelUpEffect()
      end)
    end
  else
    self.canClick = true
    self:__OnClickFairyUpgrade()
  end
end

function UIFairyCultivateMain:__OnClickFairyUpgrade()
  if self.nowSelectFairy == nil then
    return false
  end
  if not self.canClick then
    return
  end
  if self.btnUpgradeState == upgradeState.quickLvUp then
    UIManager:ShowWindowAsync(UIWindowTypeID.FairyQuickLv, function(win)
      if win == nil then
        return
      end
      win:InitFairyQkLvUp(self.nowSelectFairy, function()
        UIManager:ShowWindowOnly(UIWindowTypeID.FairyCultivateMain)
      end)
      UIManager:HideWindow(UIWindowTypeID.FairyCultivateMain)
    end)
    return true
  end
  if self.btnUpgradeState == upgradeState.upgrade and self.nowSelectFairy:GetIsFairyCouldLevelUp() then
    local level = self.nowSelectFairy:GetFairyCurLevel() + 1
    self.upgradeFlag = true
    self:GetFairyCtrl().network:CS_Fairy_Upgrade(self.nowSelectFairy:GetFairyUID(), level, function()
      self:PlayFairyNormalLevelUpEffect()
    end)
  elseif self.btnUpgradeState == upgradeState.upgrade then
    self:_OpenUseExpPacket(ConstGlobalItem.FairyExp)
  end
  if self.btnUpgradeState == upgradeState.upStar then
    if self.flag then
      if self.selectConsumeFairy == nil then
        return false
      end
      local nowNum, maxNum = self.skillUpgradeNode:GetNowSelectNum()
      if nowNum ~= maxNum then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22005))
        return false
      end
      local orginSkillList = self.skillUpgradeNode:GetAllCouldSelectSkillList()
      local skillSelectList = self.skillUpgradeNode:GetSelectSkillList()
      local canUpStar, needItemId = self.nowSelectFairy:GetIsFairyCouldStarUp()
      if canUpStar and self.nowSelectFairy:GetIsSatisfyConsume(self.selectConsumeFairy) then
        UIManager:ShowWindowAsync(UIWindowTypeID.FairyNotice, function(win)
          if win == nil then
            return
          end
          win:SetSkillList(skillSelectList, orginSkillList)
          win:InitFairyNotice(self.nowSelectFairy, false, true, function()
            self:GetFairyCtrl().network:CS_Fairy_AddRank(self.nowSelectFairy:GetFairyUID(), self.selectConsumeFairy:GetFairyUID(), skillSelectList, BindCallback(self, self.OnFairyUpStarSuccess))
          end)
        end)
      elseif needItemId then
        self:_OpenUseExpPacket(needItemId)
      end
    else
      self.flag = true
      UIUtil.SetTopStatusBtnShow(false, false)
      upgradeStateFunc[self.btnUpgradeState](self)
    end
  end
  if self.btnUpgradeState == upgradeState.recombine then
    if self.flag then
      if self.selectConsumeFairy == nil then
        return false
      end
      local nowNum, maxNum = self.skillUpgradeNode:GetNowSelectNum()
      if nowNum ~= maxNum then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22005))
        return false
      end
      local orginSkillList = self.skillUpgradeNode:GetAllCouldSelectSkillList()
      local skillSelectList = self.skillUpgradeNode:GetSelectSkillList()
      if self.nowSelectFairy:GetIsFairyCouldRecombine() then
        UIManager:ShowWindowAsync(UIWindowTypeID.FairyNotice, function(win)
          if win == nil then
            return
          end
          win:SetSkillList(skillSelectList, orginSkillList)
          win:InitFairyNotice(self.nowSelectFairy, true, true, function()
            self:GetFairyCtrl().network:CS_Fairy_Skill_Restructuring(self.nowSelectFairy:GetFairyUID(), self.selectConsumeFairy:GetFairyUID(), skillSelectList, BindCallback(self, self.OnFairyRecombineSuccess))
          end)
        end)
      else
        self:_OpenUseExpPacket(ConstGlobalItem.FairyRecombineItem)
      end
    else
      self.flag = true
      UIUtil.SetTopStatusBtnShow(false, false)
      upgradeStateFunc[self.btnUpgradeState](self)
    end
  end
  return true
end

function UIFairyCultivateMain:_OnChangeQuickLvUp(isOn)
  self._isQuickLv = isOn
  self:__RefreshFairyUpgrade(self.nowSelectFairy)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetFairyQuickLvOn(self._isQuickLv)
end

function UIFairyCultivateMain:ClearSortDataSelect(needRefresh)
  local sortKindData = self.fairyCardList:GetMainUIData():GetSortKindData()
  if sortKindData == nil then
    return
  end
  for k, v in pairs(FairyFilterEnum.eKindType) do
    for i = 1, FairyFilterEnum.eKindMaxCount[v] do
      local kindItem = sortKindData[v].kindItems[i]
      if kindItem ~= nil then
        kindItem.select = false
        kindItem:SetSelectUIActive()
        sortKindData[v].selectIndexs[i] = false
      end
    end
    sortKindData[v].nocondition = true
  end
  if needRefresh then
    self:OnFairyFilterConfirmAction()
  end
end

function UIFairyCultivateMain:OnFairyUpStarSuccess(objList, startStar)
  self:ClearSortDataSelect(false)
  self:ReturnFlagState()
  self:PlayFairyLevelUpAnimationHaveCallback(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.FairyNotice, function(win)
      if win == nil then
        return
      end
      if startStar then
        win:SetFyNoticeStarFrom(startStar)
      end
      win:InitFairyNotice(self.nowSelectFairy, false, false)
    end)
  end)
end

function UIFairyCultivateMain:OnFairyRecombineSuccess()
  self:ReturnFlagState()
  self:PlayFairyLevelUpAnimationHaveCallback(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.FairyNotice, function(win)
      if win == nil then
        return
      end
      win:InitFairyNotice(self.nowSelectFairy, true, false)
    end)
  end)
end

function UIFairyCultivateMain:CloseLvUpAniTimer()
  if self.lvTimer then
    TimerManager:StopTimer(self.lvTimer)
    self.lvTimer = nil
  end
end

function UIFairyCultivateMain:PlayFairyLevelUpAnimationHaveCallback(callback)
  self:PlayFairyLevelUpAnimation()
  self:CloseLvUpAniTimer()
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(function()
    self:CloseLvUpAniTimer()
    callback()
  end, nil, nil, nil, true)
  local time = self.nowSelectFairy:GetLvUpTime()
  self.lvTimer = TimerManager:StartTimer(time, function()
    callback()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self.lvTimer = nil
  end, self, true)
end

function UIFairyCultivateMain:_OpenUseExpPacket(itemId)
  local selectItemId
  local list = {}
  table.insertto(list, ConfigData.item.fixedPacketMappingDic[itemId] or table.emptytable)
  table.insertto(list, ConfigData.item.selectPacketMappingDic[itemId] or table.emptytable)
  if 0 < #list then
    for _, expPacketid in ipairs(list) do
      if 0 < PlayerDataCenter:GetItemCount(expPacketid) then
        selectItemId = expPacketid
        break
      end
    end
  end
  if selectItemId == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
      if window == nil then
        return
      end
      window:InitCommonItemDetail(ConfigData.item[itemId])
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(window)
      if window == nil then
        return
      end
      window:InitCommonUseGift(ConfigData.item[selectItemId])
    end)
  end
end

function UIFairyCultivateMain:GetUpgradeStateTex()
  return self.ui.tex_Upgrade.text.text
end

function UIFairyCultivateMain:GetConsumeCostItem()
  if self.consumeCostItem2.active then
    return self.consumeCostItem1, self.consumeCostItem2
  end
  return self.consumeCostItem1
end

function UIFairyCultivateMain:ReturnFlagState()
  UIUtil.SetTopStatusBtnShow(true, true)
  self.flag = false
  local cardList = self:GetNowFairyList()
  cardList:GetMainUIData():RejectFairyDic({}, false)
  upgradeStateFunc[self.btnUpgradeState](self)
end

function UIFairyCultivateMain:OnClickBack()
  if self.ui.skillCardBottom.gameObject.activeSelf then
    self.ui.skillCardBottom.gameObject:SetActive(false)
    return false
  end
  if self.recommendHeroNode.active then
    UIUtil.ReShowTopStatus()
    self.recommendHeroNode:Hide()
    return false
  end
  if self.fairyAttrNode.active then
    UIUtil.ReShowTopStatus()
    self.fairyAttrNode:Hide()
    return false
  end
  if self.flag then
    self:ReturnFlagState()
    return false
  end
  self:__RewindIntoAnim()
  if self.exitFunc ~= nil then
    self.exitFunc()
    self.exitFunc = nil
  end
  self.__RewindAnimTimerId = TimerManager:StartTimer(self.animStateLength / 2.4, function()
    if IsNull(self.transform) then
      return
    end
    self:OnCloseWin()
    self:Delete()
  end, self, true)
end

function UIFairyCultivateMain:OnClickSkillCardBottom()
  self.ui.skillCardBottom.gameObject:SetActive(false)
end

function UIFairyCultivateMain:OnClickNormalSkillItem(fairySkillData, isSelect, cardItem)
  if not cardItem then
    return
  end
  self.ui.skillCardBottom.gameObject:SetActive(true)
  self.skillCardItem:InitFairySkillUpgradeItem(fairySkillData, self.resloader)
  local parentTrans = cardItem.transform
  local vector3 = parentTrans:TransformPoint(Vector3.zero)
  self.skillCardItem.transform.position = vector3
  local xOffset = self.skillCardItem.transform.sizeDelta.x / 2 + cardItem.transform.sizeDelta.x / 2
  self.skillCardItem.transform.anchoredPosition = Vector2.Temp(self.skillCardItem.transform.anchoredPosition.x - xOffset, self.skillCardItem.transform.anchoredPosition.y)
end

function UIFairyCultivateMain:OnBtnFairyFilterClick()
  if self.siftCondition == nil then
    local SiftConditionPage = UINFairySiftCondition.New()
    SiftConditionPage:Init(self.ui.sortConditionNode)
    self.siftCondition = SiftConditionPage
    self.siftCondition:InitFairySiftCondition(FairyFilterEnum.eKindType, FairyFilterEnum.eKindMaxCount, self.__onFairyFilterConfirmActionBind, nil, self.__checkFairyFilterCanConfirmBind)
  end
  self.siftCondition:Show()
end

function UIFairyCultivateMain:NormalFairyFilterClick()
  self:OnBtnFairyFilterClick()
  self.siftCondition:SetSortKindData(self.fairyCardList:GetMainUIData():GetSortKindData())
end

function UIFairyCultivateMain:MulFairyFilterClick()
  self:OnBtnFairyFilterClick()
  self.siftCondition:SetSortKindData(self.fairyMulCardList:GetMainUIData():GetSortKindData())
end

function UIFairyCultivateMain:GetNowSelectFairy()
  if self.flag then
    return self.selectConsumeFairy
  else
    return self.nowSelectFairy
  end
end

function UIFairyCultivateMain:GetNowSelectFairyUID()
  if self.flag then
    return self.selectConsumeFairy and self.selectConsumeFairy:GetFairyUID() or nil
  else
    return self.nowSelectFairy and self.nowSelectFairy:GetFairyUID() or self.defaultUid
  end
end

function UIFairyCultivateMain:GetNowFairyList()
  if self.flag then
    return self.fairyMulCardList
  else
    return self.fairyCardList
  end
end

function UIFairyCultivateMain:OnFairySortTypeChangeBaseAction(sortFunc)
  local cardList = self:GetNowFairyList()
  cardList:GetMainUIData():SetFairySortRuleFunc(sortFunc)
  cardList:GetMainUIData():SetSortRule()
end

function UIFairyCultivateMain:OnFairySortTypeChangeAction(sortFunc)
  if self.flag then
    return
  end
  self:OnFairySortTypeChangeBaseAction(sortFunc)
  self.fairyCardList:Roll2IndexByUid(self:_GetCurQuickLvFyUID())
end

function UIFairyCultivateMain:OnFairySortTypeChangeMulAction(sortFunc)
  if not self.flag then
    return
  end
  self:OnFairySortTypeChangeBaseAction(sortFunc)
  self.selectConsumeFairy = nil
  self:RefreshConsumeFairyUI(true)
  self.fairyMulCardList:ResetSelectedIndex()
  self.fairyMulCardList:RefreshCultivateCardList()
end

function UIFairyCultivateMain:OnFairyFilterConfirmAction(sortKindData)
  local cardList = self:GetNowFairyList()
  cardList:GetMainUIData():FilterFairyDic(sortKindData)
  local nowFairyCardList = self:GetNowFairyList()
  if self.flag then
    self.selectConsumeFairy = nil
    self:RefreshConsumeFairyUI(true)
    nowFairyCardList:ResetSelectedIndex()
    nowFairyCardList:RefreshCultivateCardList()
  else
    local nowSelectFairyUID = self:GetNowSelectFairyUID()
    nowFairyCardList:Roll2IndexByUid(nowSelectFairyUID)
  end
  self:RefreshBottomTipUI()
end

function UIFairyCultivateMain:CheckFairyFilterCanConfirm(sortKindData)
  local cardList = self:GetNowFairyList()
  local dataList = cardList:GetMainUIData():GetRealFairyDataList()
  for i, data in pairs(dataList) do
    if self:SiftFunction(data, sortKindData) then
      return true
    end
  end
  return false
end

function UIFairyCultivateMain:SiftFunction(fairyData, sortKindData)
  local realSortKindData = sortKindData
  if realSortKindData == nil then
    return true
  end
  local rankConfig = realSortKindData[FairyFilterEnum.eKindType.Rank]
  local rankOk = rankConfig.nocondition or rankConfig.selectIndexs[fairyData:GetFairyCurStar()]
  local qualityConfig = realSortKindData[FairyFilterEnum.eKindType.Quality]
  local qualityOk = qualityConfig.nocondition or qualityConfig.selectIndexs[fairyData:GetCurFairyQuality()]
  local typeConfig = realSortKindData[FairyFilterEnum.eKindType.Type]
  local typeOk = typeConfig.nocondition or typeConfig.selectIndexs[fairyData:GetFairyID()]
  if rankOk and qualityOk and typeOk then
    return true
  else
    return false
  end
end

function UIFairyCultivateMain:__OnClickChangeFairyName()
  self:ShowChangeFairyNameWindiw()
end

function UIFairyCultivateMain:ShowChangeFairyNameWindiw()
  if self.nowSelectFairy == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyChangeName, function(window)
    if window ~= nil then
      window:InitChangeFairyName(self.nowSelectFairy)
    end
  end)
end

function UIFairyCultivateMain:__OnClickRecoveryFairy()
  self:ShowRecoveryFairyNameWindiw()
  MsgCenter:Broadcast(eMsgEventId.OnChangeFairyCultivateState, eFairyEnum.FairyCultivateState.recovery)
end

function UIFairyCultivateMain:ShowRecoveryFairyNameWindiw()
  if self.nowSelectFairy == nil then
    return
  end
  if self:GetFairyCtrl() == nil then
    return
  end
  local fairyDic = self:GetFairyCtrl():GetFairyDataDic()
  if fairyDic == nil then
    return
  end
  self:Hide()
  UIManager:ShowWindowAsync(UIWindowTypeID.FairyRecovery, function(window)
    window:RegistFromeWindowTypeID(UIWindowTypeID.FairyCultivateMain)
    window:InitFairyRecovery(fairyDic, self.resloader)
  end)
end

function UIFairyCultivateMain:__PlayFairyCultivateMainRightAnim()
  self:__StopTween()
  self.ui.anim_rightCanvasGroup:DOFade(0, 0.7):From():SetEase(cs_Ease.OutQuart):SetLink(self.ui.anim_rightCanvasGroup.gameObject)
  self.ui.anim_rightCanvasGroup.gameObject.transform:DOLocalMoveX(212, 0.7):From():SetEase(cs_Ease.OutQuart):SetLink(self.ui.anim_rightCanvasGroup.gameObject)
end

function UIFairyCultivateMain:__StopTween()
  self.ui.anim_rightCanvasGroup:DOComplete()
  self.ui.anim_rightCanvasGroup.gameObject.transform:DOComplete()
end

function UIFairyCultivateMain:__RewindIntoAnim()
  local animState = self.ui.anim_root:get_Item("UI_FairyList")
  animState.speed = -2
  animState.time = animState.length
  self.animStateLength = animState.length
  if self.ui.canvasGroup.blocksRaycasts == nil then
    error("返回动效预制体需要有canvasGroup组件")
    return
  end
  self.ui.canvasGroup.blocksRaycasts = false
  self.ui.anim_root:Play()
end

function UIFairyCultivateMain:OnDelete()
  self._switchTogQkLv:Delete()
  self:__StopTween()
  self:CloseLvUpAniTimer()
  self.fairyCardList:Delete()
  self.leftPartNode:Delete()
  if self.siftCondition then
    self.siftCondition:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.__RewindAnimTimerId then
    TimerManager:StopTimer(self.__RewindAnimTimerId)
    self.__RewindAnimTimerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  if self.exitFunc ~= nil then
    self.exitFunc()
    self.exitFunc = nil
  end
end

return UIFairyCultivateMain
