local UIEventBattlePass = require("Game.BattlePass.UI.UIEventBattlePass")
local nora_zh_cn = require("CharacterTextConfig.nora_ZH_CN")
local requestpreview = require("Game.RequestPreview.RequestPreview")
local base = UIEventBattlePass
local UIEventBattlePassV2 = class("UIEventBattlePassV2", base)
local UINReHolderStyleNormal = require("Game.BattlePass.UI.ReHolderStyle.UINReHolderStyleNormal")
local cs_Ease = CS.DG.Tweening.Ease

function UIEventBattlePassV2:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_SkinShop, self, self.OnBtnOpenSkinShop)
  UIUtil.AddButtonListener(self.ui.btn_SkinUpJump, self, self._OnClickSkinUpJump)
  UIUtil.AddButtonListener(self.ui.btn_SkinBoxCheck, self, self._OnclickResidentSkinBox)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Right, self, self._OnclickResidentSkinSwitch, true, true)
  UIUtil.AddButtonListenerWithArg(self.ui.Btn_Left, self, self._OnclickResidentSkinSwitch, false, true)
  self.__OnUpdateHeroSkin = BindCallback(self, self._OnSkinUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroSkin, self.__OnUpdateHeroSkin)
  self.__OnHeroSkinUpgrade = BindCallback(self, self._OnHeroSkinUpgrade)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnHeroSkinUpgrade)
  self.__OnPayGiftCondition = BindCallback(self, self._OnPayGiftCondition)
  MsgCenter:AddListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__OnPayGiftCondition)
end

function UIEventBattlePassV2:InitBattlePassUIV2(activityId)
  local passInfo = PlayerDataCenter.battlepassData.passInfos[activityId]
  self.passInfo = passInfo
  if self.passInfo == nil then
    error("Cant get battlepass passInfo, activityId:" .. tostring(activityId))
    return
  end
  self:InitBattlePassStaticUI()
  self:UpdateBattlePassBase(passInfo)
  self.passTableNode.passTagValueOffset = -0.5
  self.passTableNode:InitBattlePassTable(self.passInfo, true)
  self.ui.btn_SkinShop.gameObject:SetActive(self.passInfo:GetBPSkinShopId() > 0 and not CS.ClientConsts.IsAudit)
  self:_UpdSkinShopTag()
  self:_UpdSkinUpgrade()
  self:_RefreshResidentBPInfo()
  self.upgradeTimer = TimerManager:StartTimer(1, self._UpdSkinUpgrade, self)
  local isResident = self.passInfo:IsResidentBP()
  if isResident then
  end
end

function UIEventBattlePassV2:_OnPayGiftCondition()
  self:_UpdSkinShopTag()
end

function UIEventBattlePassV2:_UpdSkinShopTag()
  local bpSkinShopId = self.passInfo:GetBPSkinShopId()
  local ShopUtil = require("Game.Shop.ShopUtil")
  local exist = ShopUtil.ExistShopPriorityGift(bpSkinShopId)
  self.ui.obj_SkinShopTag:SetActive(exist)
end

function UIEventBattlePassV2:_UpdSkinUpgrade()
  local skinId = self.passInfo:GetCurSkinId()
  local hasSkinUp = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
  local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
  local skinUpOpen = PlayerDataCenter.skinData:IsSkinUpgrageOpen(skinId) and not PlayerDataCenter.skinData:IsSkinUpgrageEnd(skinId)
  skinUpOpen = isInTimeRange and skinUpOpen
  if not skinUpOpen then
    self:OnUpgradeTimerEnd()
  end
  self.ui.obj_SkinUpgrade:SetActive(skinUpOpen and not CS.ClientConsts.IsAudit)
  self.ui.btn_SkinUpJump.gameObject:SetActive(hasSkinUp)
  self.ui.tex_SkinUp:SetIndex(hasSkinUp and 0 or 1)
  local day, hour, minute = PlayerDataCenter.skinData:GetSkinUpgradeLimitTime(skinId)
  if minute < 0 then
    self.ui.obj_SkinUpgrade:SetActive(false)
    return
  end
  if 0 < day then
    self.ui.text_skinUpgradeTime:SetIndex(0, tostring(day))
  elseif 0 < hour then
    self.ui.text_skinUpgradeTime:SetIndex(1, tostring(hour))
  elseif 0 <= minute then
    self.ui.text_skinUpgradeTime:SetIndex(2, tostring(minute))
  end
end

function UIEventBattlePassV2:_RefreshResidentBPInfo()
  local isResident = self.passInfo:IsResidentBP()
  self.ui.SkinBoxCheck:SetActive(false)
  if not isResident then
    return
  end
  local itemCfg = ConfigData.item[ConstGlobalItem.ResidentBpGift]
  self.ui.Img_BoxIcon.sprite = CRH:GetSprite(itemCfg.icon, CommonAtlasType.Common)
  local isAllSkinCollected = self.passInfo:IsResidentBPAllSkinCollected()
  self.ui.SkinAllCollectTip:SetActive(isAllSkinCollected)
end

function UIEventBattlePassV2:InitBattlePassStaticUI(isNext)
end

function UIEventBattlePassV2:OnBtnTipsClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self.passInfo.passCfg.tips_desc), ConfigData:GetTipContent(326))
  end)
end

function UIEventBattlePassV2:OnUpgradeTimerEnd()
  self.ui.obj_SkinUpgrade:SetActive(false)
  if self.upgradeTimer ~= nil then
    TimerManager:StopTimer(self.upgradeTimer)
    self.upgradeTimer = nil
  end
end

function UIEventBattlePassV2:OnBtnOpenSkinShop()
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  ShopController:GetShopData(self.passInfo:GetBPSkinShopId(), function(shopData)
    if shopData == nil then
      return
    end
    local skinIds = {}
    for shelfId, goodData in pairs(shopData.shopGoodsDic) do
      table.insert(skinIds, goodData.itemId)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
      if win == nil then
        return
      end
      local SkinEnum = require("Game.Skin.SkinEnum")
      win:SetSkinFromWhere(SkinEnum.fromWhere.shopOrGift)
      win:InitSkinBySkinList(nil, skinIds, nil, nil)
    end)
  end)
end

function UIEventBattlePassV2:_OnSkinUpdate()
  self.passInfo:GenResidentBPSkinList()
  self:_RefreshResidentBPInfo()
  self:InitBattlePassStaticUI()
  self:_UpdSkinUpgrade()
end

function UIEventBattlePassV2:_OnHeroSkinUpgrade()
  self:_UpdSkinUpgrade()
  if self.active then
    self:InitBattlePassStaticUI()
  else
    self._nextShowLoadSkin = true
  end
end

function UIEventBattlePassV2:CompleteBpV2SkinUpdate()
  self:_UpdSkinUpgrade()
end

function UIEventBattlePassV2:_OnClickSkinUpJump()
  local skinId = self.passInfo:GetCurSkinId()
  local JumpManager = require("Game.Jump.JumpManager")
  JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
    skinId,
    require("Game.Skin.SkinEnum").fromWhere.bp
  }, true)
end

function UIEventBattlePassV2:_OnclickResidentSkinBox()
  local itemId = ConstGlobalItem.ResidentBpGift
  local itemCfg = ConfigData.item[itemId]
  UIManager:ShowWindowAsync(UIWindowTypeID.RewardPreview, function(window)
    if window == nil then
      return
    end
    window:InitRewardPreview(itemId, itemCfg.giftIdList, itemCfg.giftCountList)
  end)
end

function UIEventBattlePassV2:_OnclickResidentSkinSwitch(isNext, isClick)
end

function UIEventBattlePassV2:OnShow()
  base.OnShow(self)
end

function UIEventBattlePassV2:OnDelete()
  if self.upgradeTimer ~= nil then
    TimerManager:StopTimer(self.upgradeTimer)
    self.upgradeTimer = nil
  end
  if self.nextTimer ~= nil then
    TimerManager:StopTimer(self.nextTimer)
    self.nextTimer = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroSkin, self.__OnUpdateHeroSkin)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnHeroSkinUpgrade)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftItemPreConfition, self.__OnPayGiftCondition)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__OnPayGiftCondition)
  base.OnDelete(self)
end

return UIEventBattlePassV2
