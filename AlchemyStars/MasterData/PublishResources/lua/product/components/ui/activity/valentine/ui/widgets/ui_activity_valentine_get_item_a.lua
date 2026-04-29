require("ui_item_node")
_class("UIActivityValentineGetItemA", UICustomWidget)
UIActivityValentineGetItemA = UIActivityValentineGetItemA

function UIActivityValentineGetItemA:Constructor()
  self._longTrigger = false
  self._perSecondCout = 2
  self._perNextSecondCout = 5
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityValentineGetItemA:OnShow(uiParams)
  self._transform = self:GetGameObject().transform
  self._nodes = {}
  self._nodes[UIItemNode.Normal] = UIItemNormalNode:New(self:GetUIComponent("UIView", "g_normal"), self)
  self._nodes[UIItemNode.Exp] = UIItemExpNode:New(self:GetUIComponent("UIView", "g_exp"), self)
  self._nodes[UIItemNode.Res] = UIItemResNode:New(self:GetUIComponent("UIView", "g_res"), self)
  self._nodes[UIItemNode.Reduce] = UIItemReduceNode:New(self:GetUIComponent("UIView", "g_reduce"), self)
  self._nodes[UIItemNode.Love] = UIItemLoveNode:New(self:GetUIComponent("UIView", "g_love"), self)
  self._nodes[UIItemNode.Award] = UIItemAwardNode:New(self:GetUIComponent("UIView", "g_award"), self)
  self._nodes[UIItemNode.Result] = UIItemResultNode:New(self:GetUIComponent("UIView", "g_result"), self)
  self._nodes[UIItemNode.TopAward] = UIItemTopAwardNode:New(self:GetUIComponent("UIView", "g_topaward"), self)
  self._nodes[UIItemNode.Activity] = UIItemActivityNode:New(self:GetUIComponent("UIView", "g_activity"), self)
  self._nodes[UIItemNode.ReturnHelp] = UIItemReturnHelpNode:New(self:GetUIComponent("UIView", "g_returnHelp"), self)
  self._chooseGO = self:GetGameObject("choose")
  self:Select(false)
  self._btnGO = self:GetGameObject("btn")
  self._btnImage = self:GetUIComponent("Image", "btn")
  self._anim = self:GetGameObject().transform:GetComponent("Animation")
  self:SetBtnImage(true)
end

function UIActivityValentineGetItemA:OnHide()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
  end
  self._longTrigger = false
  for uiItemNode, node in pairs(self._nodes) do
    node:Hide()
  end
  self._nodes = nil
end

function UIActivityValentineGetItemA:PlayAni(aniName)
end

function UIActivityValentineGetItemA:SetForm(type, scale, dontPlayAni)
  self._uiItemForm = type
  self._curNodes = {}
  local customer = UIItemCustomer[self._uiItemForm]
  for uiItemNode, node in pairs(self._nodes) do
    local i = table.ikey(customer, uiItemNode)
    if i and 0 < i then
      node:Enable(true)
      table.insert(self._curNodes, node)
    else
      node:Enable(false)
    end
  end
  if dontPlayAni then
    self:PlayAni("uieff_uiItem_In")
  end
  self:SetScale(scale)
end

function UIActivityValentineGetItemA:SetData(params)
  if not self._uiItemData then
    self._uiItemData = UIItemData:New()
  end
  self._uiItemData:SetParams(params)
  for _, node in pairs(self._curNodes) do
    node:Show(self._uiItemData, self._uiItemForm)
  end
end

function UIActivityValentineGetItemA:ShowNodes(uiItemNode, enable)
  if self._nodes[uiItemNode] then
    self._nodes[uiItemNode]:Enable(enable)
  end
end

local middleScaleCls = {UIStage = true, UIExtraMissionStageController = true}

function UIActivityValentineGetItemA:SetScale(scale)
  scale = scale or 1
  if self._transform then
    self._transform.localScale = Vector3(scale, scale, scale)
  end
end

function UIActivityValentineGetItemA:Select(select, noAnim)
  if self._chooseGO then
    self._chooseGO:SetActive(select)
    if select then
      if noAnim then
        return
      end
      if self._tweener then
        self._tweener:Kill(true)
      end
      self._tweener = self._transform:DOPunchScale(Vector3(0.1, 0.1, 0.1), 0.2)
    end
  end
end

function UIActivityValentineGetItemA:SetClickCallBack(callBack, param)
  self._clickCallBack = callBack
  self._param = param
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Click, function(go)
    if self._longTrigger == false then
      self:BtnOnClick(go)
    end
  end)
end

function UIActivityValentineGetItemA:BtnOnClick(go)
  if self._clickCallBack then
    self._clickCallBack(go)
  end
end

function UIActivityValentineGetItemA:SetBtnImage(bImage)
  if bImage then
    self._btnImage.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang10_frame")
  else
    self._btnImage.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang1_frame")
  end
end

function UIActivityValentineGetItemA:SetLongPressCallBack(longPressCallBack, longPressUpCallBack, pressTime, update)
  self._longPressCallBack = longPressCallBack
  self._longPressUpCallBack = longPressUpCallBack
  self._pressTimeConst = pressTime
  self._pressTime = self._pressTimeConst
  self._update = update
  self:InitLongPress()
end

function UIActivityValentineGetItemA:SetReduceLongPressCallBack(sec)
  if self._nodes[UIItemNode.Reduce] then
    self._nodes[UIItemNode.Reduce]:SetReduceLongPressCallBack(sec)
  end
end

function UIActivityValentineGetItemA:InitLongPress()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Press, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    self:LongEvent()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Unhovered, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._pressTime = self._pressTimeConst
      self._longTrigger = false
      self._timerEvent = nil
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Release, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._pressTime = self._pressTimeConst
      self._longTrigger = false
      if self._longPressUpCallBack then
        self._longPressUpCallBack()
      end
      self._timerEvent = nil
    end
  end)
end

function UIActivityValentineGetItemA:LongEvent()
  self._timerEvent = GameGlobal.Timer():AddEvent(self._pressTime, function()
    if GuideHelper.IsUIGuideShow() then
      return
    end
    self._longTrigger = true
    if self._longPressCallBack then
      local count = self._longPressCallBack()
      if count then
        self:Calculate(count)
      end
    end
    if self._update then
      self:LongEvent()
    end
  end)
end

function UIActivityValentineGetItemA:Calculate(count)
  local presse_count = Cfg.cfg_global.pet_up_level_presse_count.IntValue
  local next_presse_count = Cfg.cfg_global.pet_up_level_next_presse_count.IntValue
  local real_presse_count = count
  if presse_count <= real_presse_count then
    self._pressTime = self._pressTimeConst / self._perSecondCout
  end
  if next_presse_count <= real_presse_count then
    self._pressTime = self._pressTimeConst / self._perNextSecondCout
  end
end

function UIActivityValentineGetItemA:GetBtn()
  return self._btnGO
end

function UIActivityValentineGetItemA:RealBtnBgOnClick(go)
  if self._clickCallBack then
    self._clickCallBack(go)
  end
end
