local base = UIBaseWindow
local UIDeliverySimulatorSelect = class("UIDeliverySimulatorSelect", base)
local UINDeliverySimulatorSelectItem = require("Game.ActivityDeliverySimulator.UI.Select.UINDeliverySimulatorSelectItem")
local UINDeliverySimulatorSelectTipItem = require("Game.ActivityDeliverySimulator.UI.Select.UINDeliverySimulatorSelectTipItem")
local UINDSSkinItem = require("Game.ActivityDeliverySimulator.UI.Select.UINDSSkinItem")
local UINDeliverySimulatorSelectRank = require("Game.ActivityDeliverySimulator.UI.Select.UINDeliverySimulatorSelectRank")
local JumpManager = require("Game.Jump.JumpManager")
local CS_MessageCommon = CS.MessageCommon
local cs_tweening = CS.DG.Tweening
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local BtnState = {
  Can = 1,
  CanBuy = 2,
  CantBuy = 3
}

function UIDeliverySimulatorSelect:OnInit()
  self.resloader = CS.ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_Start, self, self.OnClickStart)
  UIUtil.AddButtonListener(self.ui.btn_ShowCharacter, self, self.OnClickShowCharacter)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  self.selectItemPool = UIItemPool.New(UINDeliverySimulatorSelectItem, self.ui.obj_selectItem, false)
  self.tipItemPool = UIItemPool.New(UINDeliverySimulatorSelectTipItem, self.ui.obj_tipItem, false)
  self.UINDSSkinItemPool = UIItemPool.New(UINDSSkinItem, self.ui.obj_skinItem, false)
  self.clickLevelCallbackBind = BindCallback(self, self.OnClickLevelCallback)
  self.clickSkinItemCallbackBind = BindCallback(self, self.ClickSkinItemCallback)
  self.refreshAllSkinItem = BindCallback(self, self.RefreshAllSkinItem)
  self.rankItem = UINDeliverySimulatorSelectRank.New()
  self.rankItem:Init(self.ui.rank)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.refreshAllSkinItem)
end

function UIDeliverySimulatorSelect:InitDeliverySimulatorSelect(actData)
  self.actData = actData
  local topData = UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true)
  local guideId = self.actData:GetMainCfg().guide_id
  if 0 < guideId then
    topData:SetTopStatusInfoFunc(function()
      GuidePicture.OpenGuidePicture(guideId, nil)
    end)
  end
  topData:PushTopStatusDataToBackStack(true)
  self.levelCfgList = {}
  self.btnState = BtnState.CantBuy
  self:RefreshSelect()
end

function UIDeliverySimulatorSelect:RefreshSelect()
  for i, cfg in pairs(ConfigData.delivery_activity_sector_group[self.actData:GetActId()]) do
    table.insert(self.levelCfgList, cfg)
  end
  table.sort(self.levelCfgList, function(a, b)
    return a.num < b.num
  end)
  local selectId = self.actData:GetDSSelectLevel() or 1
  local selectItem
  for id, cfg in pairs(self.levelCfgList) do
    local item = self.selectItemPool:GetOne()
    local lockData = {}
    lockData.isLock = not CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    if lockData.isLock then
      lockData.lockDes = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    end
    item:InitDeliverySimulatorSelectItem(id, lockData, self.clickLevelCallbackBind)
    local isLooked = self.actData:GetDSSelectLevelIsLooked(id)
    item:RefreshBlueDot(not lockData.isLock and not isLooked)
    if id == selectId then
      selectItem = item
    end
  end
  self:OnClickLevelCallback(selectId, selectItem)
end

function UIDeliverySimulatorSelect:OnClickLevelCallback(index, item)
  if item.lockData.isLock then
    return
  end
  if item.isSelect then
    return
  end
  self.selectedCfg = self.levelCfgList[index]
  for i, item in pairs(self.selectItemPool.listItem) do
    item:RefreshSelect(index == item.index)
  end
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.selectedCfg.name)
  self.ui.btn_Rank.gameObject:SetActive(self.selectedCfg.is_friend_rank)
  self.ui.tex_startTip:SetIndex(0, tostring(self.selectedCfg.game_time))
  self.tipItemPool:HideAll()
  for i, des in pairs(self.selectedCfg.tips) do
    local tipItem = self.tipItemPool:GetOne()
    tipItem:InitDeliverySimulatorSelectTipItem(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(des)))
  end
  local picPath = PathConsts:GetDeliverySimulatorPic(self.selectedCfg.image_path)
  self.ui.img_MapPic.enabled = false
  self.resloader:LoadABAssetAsync(picPath, function(texture)
    if not IsNull(self.ui.img_MapPic) then
      self.ui.img_MapPic.enabled = true
      self.ui.img_MapPic.texture = texture
    end
  end)
  self.UINDSSkinItemPool:HideAll()
  local roleGroup = self.actData:GetSectorGroupCfg()[index].role_group
  local roleDic = ConfigData.delivery_activity_role_group[roleGroup]
  local roleList = {}
  for skinId, cfg in pairs(roleDic) do
    table.insert(roleList, cfg)
  end
  table.sort(roleList, function(a, b)
    return a.order_id < b.order_id
  end)
  local skinNormalItem
  for _, cfg in ipairs(roleList) do
    local skinId = cfg.skin_id
    local heroId = ConfigData.delivery_role[skinId].hero_id
    local isNeedOwn = cfg.need_own
    local skinItem = self.UINDSSkinItemPool:GetOne()
    skinItem:InitDSSkinItem(heroId, skinId, isNeedOwn, self.resloader, self.clickSkinItemCallbackBind)
    if skinNormalItem == nil then
      skinNormalItem = skinItem
    end
  end
  self.nowSelectItem = nil
  self:ClickSkinItemCallback(skinNormalItem)
  self.ui.tex_Score.text = self.actData:GetHighestScore(index)
  self.isInRank = false
  self.needRefreshRank = true
  self:RefreshRankInfo()
  self.actData:SetDSSelectLevel(index)
  self.actData:SetDSSelectLevelIsLooked(index)
  local isLooked = self.actData:GetDSSelectLevelIsLooked(index)
  item:RefreshBlueDot(not isLooked)
  if self.infoSeq == nil then
    self.infoSeq = cs_tweening.DOTween.Sequence()
    self.infoSeq:AppendInterval(0.15):Append(self.ui.mid.transform:DOAnchorPosY(self.ui.mid.transform.anchoredPosition.y - 50, 0.5):From()):Join(self.ui.right.transform:DOAnchorPosY(self.ui.right.transform.anchoredPosition.y - 50, 0.5):From()):Join(self.ui.mid:DOFade(0, 0.5):From()):Join(self.ui.right:DOFade(0, 0.5):From()):SetAutoKill(false)
  else
    self.infoSeq:Restart()
  end
end

function UIDeliverySimulatorSelect:RefreshAllSkinItem()
  for id, item in pairs(self.UINDSSkinItemPool.listItem) do
    item:RefreshSkinShow()
  end
  local selectItem = self.nowSelectItem
  self.nowSelectItem = nil
  self:ClickSkinItemCallback(selectItem)
end

function UIDeliverySimulatorSelect:ClickSkinItemCallback(skinItem)
  if self.nowSelectItem and skinItem.skinId == self.nowSelectItem.skinId then
    return
  end
  self.nowSelectItem = skinItem
  for id, item in pairs(self.UINDSSkinItemPool.listItem) do
    item:SetSkinItemSelect(self.nowSelectItem.skinId == item.skinId)
  end
  if not skinItem.isNeedOwn then
    self.btnState = BtnState.Can
    self:RefreshBuyBtnState()
    return
  end
  local heroId = skinItem.heroId
  local haveHero = PlayerDataCenter:ContainsHeroData(heroId)
  if haveHero == false then
    self.btnState = BtnState.CantBuy
    self:RefreshBuyBtnState()
    return
  end
  local isHave = PlayerDataCenter.skinData:IsHaveSkin(skinItem.skinId)
  if isHave then
    self.btnState = BtnState.Can
    self:RefreshBuyBtnState()
    return
  end
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local flag, condition = skinCtr:CheckSourceValid(skinItem.skinId)
  if skinItem.shopGoodsData ~= nil then
    self.btnState = BtnState.CanBuy
    self:RefreshBuyBtnState()
    return
  elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active or skinItem.skinCfg.jumpId ~= nil and skinItem.skinCfg.jumpId > 0 then
    self.btnState = BtnState.CanBuy
    self:RefreshBuyBtnState()
    return
  elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Gift then
    self.btnState = BtnState.CanBuy
    self:RefreshBuyBtnState()
    return
  end
  self.btnState = BtnState.CantBuy
  self:RefreshBuyBtnState()
end

function UIDeliverySimulatorSelect:RefreshBuyBtnState()
  self.ui.img_StartBk:SetIndex(self.btnState - 1)
  self.ui.tex_Start:SetIndex(self.btnState - 1)
end

function UIDeliverySimulatorSelect:OnClickShowCharacter()
  if self.nowSelectItem == nil then
    return
  end
  local showCharacterSkinCtrl = ControllerManager:GetController(ControllerTypeId.ShowCharacterSkin, true)
  local heroId = self.nowSelectItem.heroId
  local skinId = self.nowSelectItem.skinId
  showCharacterSkinCtrl:InitShowCharacterSkinCtrl(heroId, skinId, nil, nil)
end

function UIDeliverySimulatorSelect:OnClickReturn()
  UIUtil.OnClickBackByWinId(UIWindowTypeID.DeliverySimulatorSelect)
end

function UIDeliverySimulatorSelect:OnClickStart()
  if self.btnState == BtnState.Can then
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
    actCtrl:EnterDeliverySimulatorGame(self.actData, self.selectedCfg.sector_id, self.nowSelectItem.skinId)
    return
  end
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local flag, condition = skinCtr:CheckSourceValid(self.nowSelectItem.skinCfg.id)
  if self.btnState == BtnState.CanBuy then
    if self.nowSelectItem.shopGoodsData ~= nil then
      local shopGoodsData = self.nowSelectItem.shopGoodsData
      local resIds = {}
      table.insert(resIds, shopGoodsData.currencyId)
      if not table.contain(resIds, ConstGlobalItem.PaidItem) and (shopGoodsData.currencyId == ConstGlobalItem.PaidSubItem or shopGoodsData.currencyId == ConstGlobalItem.SkinTicket) then
        table.insert(resIds, 1, ConstGlobalItem.PaidItem)
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
        window:SlideIn()
        window:InitBuyFixedCountGood(1, shopGoodsData, true, resIds, function()
          self.nowSelectItem:RefreshSkinShow()
          local normalSkinItem = self.nowSelectItem
          self.nowSelectItem = nil
          self:ClickSkinItemCallback(normalSkinItem)
        end)
      end)
    elseif condition == proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active or self.nowSelectItem.skinCfg.jumpId ~= nil and self.nowSelectItem.skinCfg.jumpId > 0 then
      if (self.nowSelectItem.skinCfg.jumpId or 0) == 0 and self.nowSelectItem.skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active] ~= nil then
        local actData = skinCtr:GetActFrameDataBySkinCfg(self.nowSelectItem.skinCfg)
        if actData ~= nil then
          local frameId = actData:GetActivityFrameId()
          JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {frameId})
        end
      elseif self.nowSelectItem.skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Gift] ~= nil then
        local giftInfo = skinCtr:GetGiftBySkinCfg(self.nowSelectItem.skinCfg)
        if giftInfo ~= nil then
          local jumpParam = skinCfg.conditionParamDic[proto_csmsg_SystemFunctionID.SystemFunctionID_Gift]
          JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {
            ConfigData.pay_gift_type[jumpParam[1]].inShop,
            jumpParam[1]
          })
        end
      else
        JumpManager:Jump(self.nowSelectItem.skinCfg.jumpId)
      end
    else
      error("skinClickIsError skinId:" .. self.nowSelectItem.skinCfg.id)
    end
  end
  if self.btnState == BtnState.CantBuy then
    local err = ConfigData:GetTipContent(58003)
    CS_MessageCommon.ShowMessageTips(err)
  end
end

function UIDeliverySimulatorSelect:OnClickRank()
  self.isInRank = not self.isInRank
  self:RefreshRankInfo()
end

function UIDeliverySimulatorSelect:RefreshRankInfo()
  if self.isInRank then
    self.rankItem:Show()
  else
    self.rankItem:RealHideFunc()
  end
  self.ui.obj_clickAfter:SetActive(self.isInRank)
  self.ui.obj_clickBefore:SetActive(not self.isInRank)
  if self.isInRank and self.needRefreshRank then
    self.rankItem:InitDeliverySimulatorSelectRank(self.actData:GetDSFriendRankData(self.selectedCfg.sector_id), self.selectedCfg.sector_id)
  end
end

function UIDeliverySimulatorSelect:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.refreshAllSkinItem)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.infoSeq then
    self.infoSeq:Kill()
    self.infoSeq = nil
  end
  self.rankItem:Delete()
end

return UIDeliverySimulatorSelect
