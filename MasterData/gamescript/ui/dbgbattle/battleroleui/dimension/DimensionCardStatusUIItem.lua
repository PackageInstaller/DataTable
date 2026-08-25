local typeof = _ENV.typeof
local UIAnimationController = CS.Z1Client.UIAnimationController
local DimentionStatusState = CommonDefine.DimentionStatusState
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local DimensionCardStatusUIItem, Super = System.NewComponent("DimensionCardStatusUIItem")

function DimensionCardStatusUIItem:ctor(uiNode, card, isMonster)
  Super.ctor(self)
  self.ui = Item_Battle_Chaowei_FeatureResource(uiNode)
  self.card = card
  self.root = uiNode
  self.isMonster = isMonster
  self.state = Vue.ref(DimentionStatusState.Empty)
  self.showAnim = Vue.ref(false)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function DimensionCardStatusUIItem:OnBind(binder)
  self.binder = binder
  self.uiAnimationController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.card then
      UIManager.Instance:Reopen(Urls.FuncBattleCardInfoPanel, self.card, {
        0,
        0,
        0
      })
    else
      local desc, iconPath
      if not self.isMonster then
        local playerRole = bg.battleScene:GetPlayerRole()
        desc = playerRole:GetSchoolTips(cd.SchoolId.Dimension)
        iconPath = playerRole:GetSchoolTipsIcon(cd.SchoolId.Dimension)
      else
        desc = LT.Text("Battle_Tips_MonsterDimensionTips")
      end
      local tipsData = {
        title = LT.Text("Battle_Tips_DimensionName", true),
        desc = desc,
        iconPath = iconPath
      }
      UIManager.Instance:Reopen(Urls.AlertIconToolBattleTipsPanel, tipsData, BattleGlobal.battlePanel.ui.School_Effect_Tips_Node, true)
    end
  end)
  if bg.battleDataCenter.boutData.isExtraBout and not self.isMonster then
    self.ui.Group_Lock:SetActive(true)
    self.ui.Group_Activate:SetActive(false)
    self.ui.Group_Nor:SetActive(false)
  end
  binder:BindToRaw(function(_, nVal, oVal)
    if nil == oVal then
      return
    end
    if true == nVal then
      self:PlayAnimSlotLock()
    elseif false == nVal then
      self:PlayAnimSlotUnlock()
    end
  end, function()
    if self.isMonster then
      return false
    end
    return bg.battleDataCenter.boutData.isExtraBout
  end)
end

function DimensionCardStatusUIItem:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  if not IsNil(self.uiAnimationController) then
    self.uiAnimationController:StopPlayableGraph()
    self.uiAnimationController = nil
  end
end

function DimensionCardStatusUIItem:SetCard(card)
  self.card = card
  if not self.isMonster and bg.battleDataCenter.boutData.isExtraBout then
    self.ui.Group_Lock:SetActive(true)
    self.ui.Group_Activate:SetActive(false)
    self.ui.Group_Nor:SetActive(false)
    return
  end
  self.ui.Group_Lock:SetActive(false)
  if card then
    local cardCfg = CardDataUtils.GetCardConfig(card.configId)
    local awakerTid = card.configData.AwakerID
    local ownerUid = card.ownerUid
    local owner = bg.battleDataCenter:GetAwakerDataModel(ownerUid)
    if owner and owner.tid then
      awakerTid = owner.tid
    end
    if awakerTid then
      self:SetMiniAwakerIconSize()
      self.ui.Group_Activate:SetActive(true)
      self.ui.Group_Nor:SetActive(false)
      self.binder:SetImage(self.ui.Image_Awaker_Icon, AwakerDataUtils.GetLittleIcon(awakerTid))
    elseif cardCfg.Icon then
      self:SetCardIconSize()
      self.ui.Group_Activate:SetActive(true)
      self.ui.Group_Nor:SetActive(false)
      self.binder:SetImage(self.ui.Image_Awaker_Icon, cardCfg.Icon)
    elseif not cardCfg.AwakerID then
      self:SetMiniAwakerIconSize()
      self.ui.Group_Activate:SetActive(true)
      self.ui.Group_Nor:SetActive(false)
      local imgPath = DT.GetConstant("Card_CommonMinihead")
      self.binder:SetImage(self.ui.Image_Awaker_Icon, imgPath)
    end
  else
    self.ui.Group_Activate:SetActive(false)
    if not bg.battleDataCenter.boutData.isExtraBout then
      self.ui.Group_Nor:SetActive(true)
      self.binder:SetCanvasGroup(self.ui.Group_Nor, 1)
    end
  end
end

function DimensionCardStatusUIItem:SetMiniAwakerIconSize()
  local tf = self.ui.Image_Awaker_Icon.transform
  tf.localScale = Vector3.one
  tf.sizeDelta = Vector2(84, 84)
  tf.anchoredPosition = Vector2.one
end

function DimensionCardStatusUIItem:SetCardIconSize()
  local tf = self.ui.Image_Awaker_Icon.transform
  tf.localScale = Vector3(0.22, 0.22, 1)
  tf.sizeDelta = Vector2(382, 590)
  tf.anchoredPosition = Vector2(-1, -9)
end

function DimensionCardStatusUIItem:PlayAnimSlotRecharge()
  Logger.Info("Dimension PlayAnimSlotRecharge")
  self.uiAnimationController:PlayState("Item_Battle_Chaowei_Feature_Open", function()
    self:SetCard(self.card)
  end)
end

function DimensionCardStatusUIItem:PlayAnimSlotLock()
  Logger.Info("Dimension PlayAnimSlotLock")
  self.uiAnimationController:PlayState("Item_Battle_Chaowei_Feature_Locked", function()
    self:SetCard(self.card)
  end)
end

function DimensionCardStatusUIItem:PlayAnimSlotUnlock()
  Logger.Info("Dimension PlayAnimSlotUnlock")
  self.uiAnimationController:PlayState("Item_Battle_Chaowei_Feature_LockBroken", function()
    self:SetCard(self.card)
  end)
end

return DimensionCardStatusUIItem
