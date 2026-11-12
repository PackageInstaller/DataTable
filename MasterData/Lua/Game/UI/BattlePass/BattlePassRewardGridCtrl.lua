local BattlePassRewardGridCtrl = class("BattlePassRewardGridCtrl", BaseCtrl)
BattlePassRewardGridCtrl._mapNodeConfig = {
  TMPGridLevel = {sComponentName = "TMP_Text"},
  btnItemNormal = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NormalItem"
  },
  btnItemVip1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_VipItem1"
  },
  btnItemVip2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_VipItem2"
  },
  btnReceIveNormal = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NormalReward"
  },
  btnReceIveVip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_VipReward"
  },
  tcRewardItemNormal = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  tcRewardItemVip = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  imgLockNormalVip = {nCount = 2},
  imgLockNormalNormal = {},
  tcRewardItemFXNormal = {},
  tcRewardItemFXVip = {nCount = 2},
  tcRewardItemReplaceVip = {nCount = 2, sComponentName = "Animator"},
  tcRewardItemReplaceNormal = {sComponentName = "Animator"}
}
BattlePassRewardGridCtrl._mapEventConfig = {}
BattlePassRewardGridCtrl._mapRedDotConfig = {}

function BattlePassRewardGridCtrl:Awake()
end

function BattlePassRewardGridCtrl:FadeIn()
end

function BattlePassRewardGridCtrl:FadeOut()
end

function BattlePassRewardGridCtrl:OnEnable()
end

function BattlePassRewardGridCtrl:OnDisable()
end

function BattlePassRewardGridCtrl:OnDestroy()
end

function BattlePassRewardGridCtrl:OnRelease()
end

function BattlePassRewardGridCtrl:Refresh(mapReward, bPremium, nBattlePassLevel)
  self.mapReward = mapReward
  self.nBattlePassLevel = nBattlePassLevel
  NovaAPI.SetTMPText(self._mapNode.TMPGridLevel, orderedFormat(ConfigTable.GetUIText("BattlePass_RewardLevel"), mapReward.nLevel))
  if mapReward.nNormalTid ~= 0 then
    self._mapNode.btnItemNormal.gameObject:SetActive(true)
    self._mapNode.tcRewardItemNormal:SetItem(mapReward.nNormalTid, nil, mapReward.nNormalQty, nil, mapReward.bNormalReceive, false, false, false, false)
    self._mapNode.imgLockNormalNormal:SetActive(nBattlePassLevel < mapReward.nLevel)
  else
    self._mapNode.btnItemNormal.gameObject:SetActive(false)
  end
  if mapReward.nVipTid1 ~= 0 then
    self._mapNode.btnItemVip1.gameObject:SetActive(true)
    self._mapNode.tcRewardItemVip[1]:SetItem(mapReward.nVipTid1, nil, mapReward.nVipQty1, nil, mapReward.bVipReceive, false, false, false, false)
    self._mapNode.imgLockNormalVip[1]:SetActive(nBattlePassLevel < mapReward.nLevel or not bPremium)
  else
    self._mapNode.btnItemVip1.gameObject:SetActive(false)
  end
  if mapReward.nVipTid2 ~= 0 then
    self._mapNode.btnItemVip2.gameObject:SetActive(true)
    self._mapNode.tcRewardItemVip[2]:SetItem(mapReward.nVipTid2, nil, mapReward.nVipQty2, nil, mapReward.bVipReceive, false, false, false, false)
    self._mapNode.imgLockNormalVip[2]:SetActive(nBattlePassLevel < mapReward.nLevel or not bPremium)
  else
    self._mapNode.btnItemVip2.gameObject:SetActive(false)
  end
  self._mapNode.tcRewardItemFXNormal.gameObject:SetActive(nBattlePassLevel >= mapReward.nLevel and not mapReward.bNormalReceive)
  self._mapNode.tcRewardItemFXVip[1].gameObject:SetActive(nBattlePassLevel >= mapReward.nLevel and not mapReward.bVipReceive and bPremium and (mapReward.nVipTid1 ~= 0 or mapReward.nVipTid2 ~= 0))
  self._mapNode.tcRewardItemFXVip[2].gameObject:SetActive(nBattlePassLevel >= mapReward.nLevel and not mapReward.bVipReceive and bPremium and (mapReward.nVipTid1 ~= 0 or mapReward.nVipTid2 ~= 0))
  self._mapNode.btnReceIveNormal.gameObject:SetActive(nBattlePassLevel >= mapReward.nLevel and not mapReward.bNormalReceive)
  self._mapNode.btnReceIveVip.gameObject:SetActive(nBattlePassLevel >= mapReward.nLevel and not mapReward.bVipReceive and bPremium and (mapReward.nVipTid1 ~= 0 or mapReward.nVipTid2 ~= 0))
end

function BattlePassRewardGridCtrl:OnBtnClick_NormalReward()
  local function callback()
  end
  
  PlayerData.BattlePass:NetMsg_BattlePassRewardReceive(false, self.mapReward.nLevel, true, callback)
end

function BattlePassRewardGridCtrl:OnBtnClick_VipReward()
  local function callback()
  end
  
  PlayerData.BattlePass:NetMsg_BattlePassRewardReceive(false, self.mapReward.nLevel, false, callback)
end

function BattlePassRewardGridCtrl:OnBtnClick_NormalItem()
  if self.mapReward == nil then
    return
  end
  if self.mapReward.nNormalTid ~= 0 then
    UTILS.ClickItemGridWithTips(self.mapReward.nNormalTid, self._mapNode.tcRewardItemNormal.gameObject.transform, true, true, false)
  end
end

function BattlePassRewardGridCtrl:OnBtnClick_VipItem1()
  if self.mapReward == nil then
    return
  end
  if self.mapReward.nVipTid1 ~= 0 then
    UTILS.ClickItemGridWithTips(self.mapReward.nVipTid1, self._mapNode.tcRewardItemVip[1].gameObject.transform, true, true, false)
  end
end

function BattlePassRewardGridCtrl:OnBtnClick_VipItem2()
  if self.mapReward == nil then
    return
  end
  if self.mapReward.nVipTid2 ~= 0 then
    UTILS.ClickItemGridWithTips(self.mapReward.nVipTid2, self._mapNode.tcRewardItemVip[2].gameObject.transform, true, true, false)
  end
end

function BattlePassRewardGridCtrl:BattlePassRewardShowEnableEffect(bPremium, nDelay)
  local function waitDelay()
    if bPremium then
      local bEnableVip1 = self.nBattlePassLevel >= self.mapReward.nLevel and not self.mapReward.bVipReceive and bPremium and self.mapReward.nVipTid1 ~= 0
      
      local bEnableVip2 = self.nBattlePassLevel >= self.mapReward.nLevel and not self.mapReward.bVipReceive and bPremium and self.mapReward.nVipTid2 ~= 0
      if bEnableVip1 then
        self._mapNode.tcRewardItemReplaceVip[1]:Play("tcRewardItemReplace_in")
      end
      if bEnableVip2 then
        self._mapNode.tcRewardItemReplaceVip[2]:Play("tcRewardItemReplace_in")
      end
    end
    local bNormal = self.nBattlePassLevel >= self.mapReward.nLevel and not self.mapReward.bNormalReceive
    if bNormal then
      self._mapNode.tcRewardItemReplaceNormal:Play("tcRewardItemReplace_in")
    end
  end
  
  self:AddTimer(1, nDelay, waitDelay, true, true, true, nil)
end

return BattlePassRewardGridCtrl
