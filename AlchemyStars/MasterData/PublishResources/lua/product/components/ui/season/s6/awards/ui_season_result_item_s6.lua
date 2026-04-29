require("ui_item_node")
_class("UISeasonResultItemS6", UICustomWidget)
UISeasonResultItemS6 = UISeasonResultItemS6

function UISeasonResultItemS6:Constructor()
  self._longTrigger = false
  self._perSecondCout = 2
  self._perNextSecondCout = 5
  self._uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonResultItemS6:OnShow(uiParams)
  self._transform = self:GetGameObject().transform
  self._nodes = {}
  self._nodes[UIItemNode.Normal] = UIItemNormalNodeForSeasonS6:New(self:GetUIComponent("UIView", "g_normal"), self)
  self._nodes[UIItemNode.Exp] = UIItemExpNode:New(self:GetUIComponent("UIView", "g_exp"), self)
  self._nodes[UIItemNode.Res] = UIItemResNode:New(self:GetUIComponent("UIView", "g_res"), self)
  self._nodes[UIItemNode.Reduce] = UIItemReduceNode:New(self:GetUIComponent("UIView", "g_reduce"), self)
  self._nodes[UIItemNode.Love] = UIItemLoveNode:New(self:GetUIComponent("UIView", "g_love"), self)
  self._nodes[UIItemNode.Award] = UIItemAwardNode:New(self:GetUIComponent("UIView", "g_award"), self)
  self._nodes[UIItemNode.Result] = UIItemResultNode:New(self:GetUIComponent("UIView", "g_result"), self)
  self._nodes[UIItemNode.TopAward] = UIItemTopAwardNode:New(self:GetUIComponent("UIView", "g_topaward"), self)
  self._nodes[UIItemNode.Activity] = UIItemActivityNode:New(self:GetUIComponent("UIView", "g_activity"), self)
  self._nodes[UIItemNode.ReturnHelp] = UIItemReturnHelpNode:New(self:GetUIComponent("UIView", "g_returnHelp"), self)
  self._nodes[UIItemNode.Toggle] = UIItemPackBackNode:New(self:GetUIComponent("UIView", "g_backpack"), self)
  self._nodes[UIItemNode.ItemUseCount] = PetLevelUpFastNode:New(self:GetUIComponent("UIView", "g_usecount"), self)
  self._chooseGO = self:GetGameObject("choose")
  self:Select(false)
  self._btnGO = self:GetGameObject("btn")
  self._btnImage = self:GetUIComponent("Image", "btn")
  self._anim = self:GetGameObject().transform:GetComponent("Animation")
end

function UISeasonResultItemS6:OnHide()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
  end
  self._longTrigger = false
  for uiItemNode, node in pairs(self._nodes) do
    node:Hide()
  end
  self._nodes = nil
end

function UISeasonResultItemS6:PlayAni(aniName)
  self._anim:Play(aniName)
end

function UISeasonResultItemS6:SetForm(type, scale, dontPlayAni)
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

function UISeasonResultItemS6:EnableNode(nodeId, isEnable)
  local node = self._nodes[nodeId]
  if node ~= nil then
    node:Enable(isEnable)
  end
end

function UISeasonResultItemS6:SetData(params)
  if not self._uiItemData then
    self._uiItemData = UIItemData:New()
  end
  self._uiItemData:SetParams(params)
  for _, node in pairs(self._curNodes) do
    node:Show(self._uiItemData, self._uiItemForm)
  end
end

function UISeasonResultItemS6:ShowNodes(uiItemNode, enable)
  if self._nodes[uiItemNode] then
    self._nodes[uiItemNode]:Enable(enable)
  end
end

local middleScaleCls = {UIStage = true, UIExtraMissionStageController = true}

function UISeasonResultItemS6:SetScale(scale)
  scale = scale or 1
  if self._transform then
    self._transform.localScale = Vector3(scale, scale, scale)
  end
end

function UISeasonResultItemS6:Select(select, noAnim)
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

function UISeasonResultItemS6:SetClickCallBack(callBack, param)
  self._clickCallBack = callBack
  self._param = param
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Click, function(go)
    if self._longTrigger == false then
      self:BtnOnClick(go)
    end
  end)
end

function UISeasonResultItemS6:BtnOnClick(go)
  if self._clickCallBack then
    self._clickCallBack(go)
  end
end

function UISeasonResultItemS6:SetBtnImage(bImage)
end

function UISeasonResultItemS6:SetLongPressCallBack(longPressCallBack, longPressUpCallBack, pressTime, update)
  self._longPressCallBack = longPressCallBack
  self._longPressUpCallBack = longPressUpCallBack
  self._pressTimeConst = pressTime
  self._pressTime = self._pressTimeConst
  self._update = update
  self:InitLongPress()
end

function UISeasonResultItemS6:SetReduceLongPressCallBack(sec)
  if self._nodes[UIItemNode.Reduce] then
    self._nodes[UIItemNode.Reduce]:SetReduceLongPressCallBack(sec)
  end
end

function UISeasonResultItemS6:InitLongPress()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Press, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    self:LongEvent()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Unhovered, function(go)
    if self._timerEvent then
      self._startTime = nil
      self._lastTime = nil
      self._addTime = nil
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._pressTime = self._pressTimeConst
      self._longTrigger = false
      self._timerEvent = nil
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Release, function(go)
    if self._timerEvent then
      self._startTime = nil
      self._lastTime = nil
      self._addTime = nil
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

function UISeasonResultItemS6:LongEvent()
  local gradeLv = HelperProxy:GetInstance():GetLongEventGrade()
  if gradeLv then
    self._timerEvent = self:LongEventUpLv(gradeLv)
  else
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
end

function UISeasonResultItemS6:LongEventUpLv(gradeLv)
  local cfg = Cfg.cfg_up_lv_long_press[gradeLv]
  if not cfg then
    Log.fatal("###[UISeasonResultItemS6] LongEventUpLv cfg is nil ! grade:", gradeLv)
  end
  local arr = cfg.Value
  local datas = {}
  for i = 1, #arr do
    local time = arr[i][1]
    local count = arr[i][2]
    local data = {
      time = time * 1000,
      count = count
    }
    table.insert(datas, data)
  end
  local timer = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    if GuideHelper.IsUIGuideShow() then
      return
    end
    self._longTrigger = true
    if self._update then
      if not self._startTime then
        self._startTime = 0
      end
      if not self._addTime then
        self._addTime = 0
      end
      self._nextTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime()
      if not self._lastTime then
        self._lastTime = self._nextTime
      end
      for i = 1, #datas do
        local data = datas[i]
        local time = data.time
        if time > self._startTime then
          local count = data.count
          self._addVal = 1000 / count
          break
        end
      end
      if self._addTime >= self._addVal then
        local cbTimes = math.modf(self._addTime / self._addVal)
        for j = 1, cbTimes do
          self._longPressCallBack()
        end
        self._addTime = 0
      end
      local gapTime = self._nextTime - self._lastTime
      self._startTime = self._startTime + gapTime
      self._addTime = self._addTime + gapTime
      self._lastTime = self._nextTime
    end
  end)
  return timer
end

function UISeasonResultItemS6:Calculate(count)
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

function UISeasonResultItemS6:GetBtn()
  return self._btnGO
end

function UISeasonResultItemS6:SetToggleGroup(group)
  self._toggleGroup = group
  if self._nodes[UIItemNode.Toggle] then
    self._nodes[UIItemNode.Toggle]:SetToggleGroup(self._toggleGroup)
  end
end

function UISeasonResultItemS6:SetToggleOnValueChangedCallBack(onValueChangedCallBack)
  if self._nodes[UIItemNode.Toggle] then
    self._nodes[UIItemNode.Toggle]:SetToggleOnValueChangedCallBack(onValueChangedCallBack)
  end
end

function UISeasonResultItemS6:SetToggleValue(isOn)
  if self._nodes[UIItemNode.Toggle] then
    self._nodes[UIItemNode.Toggle]:SetToggleValue(isOn)
  end
end

function UISeasonResultItemS6:GetItemData()
  return self._uiItemData
end

function UISeasonResultItemS6:ClearItemData()
  self._uiItemData = nil
end

function UISeasonResultItemS6:SetBtnImageByName(imgName, atlasName)
end

_class("UIItemNormalNodeForSeasonS6", UIItemNormalNode)
UIItemNormalNodeForSeasonS6 = UIItemNormalNodeForSeasonS6

function UIItemNormalNodeForSeasonS6:SetQuality(quality)
  if quality <= 0 then
    self:ShowQuality(false)
    return
  end
  local qualityName = "exp_s6_map_daoju_pinji0" .. tostring(quality)
  if qualityName ~= "" then
    self:ShowQuality(true)
    local atlas = self._owner:GetAsset("UIS6Scene.spriteatlas", LoadType.SpriteAtlas)
    self._quality.sprite = atlas:GetSprite(qualityName)
  else
    self:ShowQuality(false)
  end
end

function UIItemNormalNodeForSeasonS6:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 12)
  else
    self._iconRect.anchoredPosition = Vector2(0, 12)
  end
end

function UIItemNormalNodeForSeasonS6:SetOffset(showText1)
end
