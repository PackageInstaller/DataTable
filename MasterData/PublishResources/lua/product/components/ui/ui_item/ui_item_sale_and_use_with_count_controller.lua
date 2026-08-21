_class("UIItemSaleAndUseWithCountController", UIController)
UIItemSaleAndUseWithCountController = UIItemSaleAndUseWithCountController

function UIItemSaleAndUseWithCountController:OnShow(uiParams)
  self._itemdata = uiParams[1]
  self._openType = uiParams[2]
  self._callBack = uiParams[3]
  self._itemID = self._itemdata:GetID()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._inputItemCount = self:GetUIComponent("InputField", "input_item_count")
  self._txtItemName = self:GetUIComponent("UILocalizationText", "txt_item_name")
  self._itemCountText = self:GetUIComponent("UILocalizationText", "itemCount")
  self:DoAnimation()
  self._saleGo = self:GetGameObject("sale")
  self._useGo = self:GetGameObject("use")
  if self._openType == EnumItemSaleAndUseState.Sale then
    self._useGo:SetActive(false)
    self._itemSaleMoney = self:GetUIComponent("UILocalizationText", "txt_sale_money")
  else
    self._saleGo:SetActive(false)
  end
  local templetaData = self._itemdata:GetTemplate()
  self._itemCount = self._itemdata:GetCount()
  self._itemCountText:SetText(StringTable.Get("str_item_public_owned") .. UIItemSaleAndUseWithCountController._FormatItemCount(self._itemCount))
  self._itemPerPiece = templetaData.SaleGold
  self._txtItemName:SetText(StringTable.Get(templetaData.Name))
  local icon = templetaData.Icon
  local quality = templetaData.Color
  local itemId = templetaData.ID
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    itemId = itemId
  })
  self._currentCount = 1
  self._inputItemCount.keyboardType = UnityEngine.TouchScreenKeyboardType.NumberPad
  self._inputItemCount.onValueChanged:AddListener(function(inputString)
    self:OnValueChange(inputString)
  end)
  self:SetInputText(self._currentCount)
  self._addBtn = self:GetGameObject("addBtn")
  self._subBtn = self:GetGameObject("subBtn")
  self._isAddMouseDown = false
  self._isSubMouseDown = false
  self._anim = self:GetUIComponent("Animation", "anim")
  local etlAdd = UILongPressTriggerListener.Get(self._addBtn)
  
  function etlAdd.onLongPress(go)
    if self._isAddMouseDown == false then
      self._isAddMouseDown = true
    end
  end
  
  function etlAdd.onLongPressEnd(go)
    if self._isAddMouseDown == true then
      self._isAddMouseDown = false
    end
  end
  
  function etlAdd.onClick(go)
    self:itemaddOnClick()
  end
  
  local etlSub = UILongPressTriggerListener.Get(self._subBtn)
  
  function etlSub.onLongPress(go)
    if self._isSubMouseDown == false then
      self._isSubMouseDown = true
    end
  end
  
  function etlSub.onLongPressEnd(go)
    if self._isSubMouseDown == true then
      self._isSubMouseDown = false
    end
  end
  
  function etlSub.onClick(go)
    self:itemsubOnClick()
  end
  
  self._pressTime = Cfg.cfg_global.sale_and_use_press_long_deltaTime.IntValue
  self._updateTime = 0
end

function UIItemSaleAndUseWithCountController:DoAnimation()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "panel")
  self._canvasGroup.alpha = 1
  self._bg = self:GetUIComponent("RectTransform", "bg")
  self._panel = self:GetUIComponent("RectTransform", "panel")
end

function UIItemSaleAndUseWithCountController._FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

function UIItemSaleAndUseWithCountController:SetInputText(count)
  if count == nil then
    return
  end
  if count < 1 then
    count = 1
  elseif count > self._itemCount then
    count = self._itemCount
  end
  self._currentCount = count
  self._inputItemCount.text = tostring(self._currentCount)
  if self._openType == 1 then
    local allPrice
    if self._currentCount * self._itemPerPiece > 99999999 then
      allPrice = "9999" .. StringTable.Get("str_item_public_unit")
    else
      allPrice = tostring(self._currentCount * self._itemPerPiece)
    end
    self._itemSaleMoney:SetText(tostring(allPrice))
  end
end

function UIItemSaleAndUseWithCountController:OnValueChange(inputString)
  local num = 0
  if inputString == nil then
    num = 1
  elseif inputString == "" then
    num = 1
  else
    num = tonumber(inputString)
  end
  if num < 1 then
    num = 1
  else
    num = self:_ComputeMaxItemCount(num)
  end
  self:SetInputText(num)
end

function UIItemSaleAndUseWithCountController:OnUpdate(deltaTimeMS)
  self._updateTime = self._updateTime + deltaTimeMS
  if self._updateTime > self._pressTime then
    self._updateTime = self._updateTime - self._pressTime
    if self._isAddMouseDown then
      self:itemaddOnClick()
    end
    if self._isSubMouseDown then
      self:itemsubOnClick()
    end
  end
end

function UIItemSaleAndUseWithCountController:_ComputeMaxItemCount(nCount)
  local itemData = self._itemdata:GetTemplate()
  local stUseEffect = itemData.UseEffect
  local nMaxLimitCount = 99
  local isPhy = false
  if stUseEffect == "PhyGift" then
    isPhy = true
    nMaxLimitCount = 1
    local roleModule = self:GetModule(RoleModule)
    local itemModule = self:GetModule(ItemModule)
    local nPhyData = roleModule:GetHealthPoint()
    local cfgRoleLevel = Cfg.cfg_role_level[roleModule:GetLevel()]
    if cfgRoleLevel then
      local nPhyMaxLevel = cfgRoleLevel.TotalMaxPhyPoint or 100
      local nPhyMaxLimit = Cfg.cfg_global.role_phy_max_limit.IntValue or 999
      local nPhyMax = 0
      if nPhyMaxLevel < nPhyMaxLimit then
        nPhyMax = nPhyMaxLevel
      else
        nPhyMax = nPhyMaxLimit
      end
      if nPhyData < nPhyMax then
        local nPhyEffect = itemModule:GetPhyGiftData(itemData.ID)
        if 0 < nPhyEffect then
          local nMaxCount = (nPhyMax - nPhyData) / nPhyEffect
          nMaxLimitCount = math.floor(nMaxCount)
        end
      end
    end
  end
  if nCount > nMaxLimitCount then
    if isPhy then
      local tips = StringTable.Get("str_item_public_use_phy_more_than_max")
      ToastManager.ShowToast(tips)
    end
    return nMaxLimitCount
  end
  return nCount
end

function UIItemSaleAndUseWithCountController:itemaddOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._inputItemCount.text == nil then
    self._inputItemCount.text = "1"
  end
  local num = tonumber(self._inputItemCount.text)
  num = self:_ComputeMaxItemCount(num + 1)
  self:SetInputText(num)
end

function UIItemSaleAndUseWithCountController:itemsubOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._inputItemCount.text == nil then
    self._inputItemCount.text = "1"
  end
  local num = tonumber(self._inputItemCount.text)
  if 1 < num then
    num = num - 1
  else
    num = 1
  end
  self:SetInputText(num)
end

function UIItemSaleAndUseWithCountController:itemmaxOnClick()
  if self._inputItemCount.text == nil then
    self._inputItemCount.text = "1"
  end
  local num = tonumber(self._inputItemCount.text)
  num = self:_ComputeMaxItemCount(self._itemCount)
  self:SetInputText(num)
end

function UIItemSaleAndUseWithCountController:itemsaleOnClick()
  if self._currentCount ~= 0 then
    self._callBack(self._itemdata, self._currentCount)
  end
  self:ClosePanel()
end

function UIItemSaleAndUseWithCountController:ClosePanel(TT)
  GameGlobal.TaskManager():StartTask(self.OnClosePanel, self)
end

function UIItemSaleAndUseWithCountController:OnClosePanel(TT)
  if self._exit then
    return
  end
  self._exit = true
  local a = 1
  self._anim:Play("uieffanim_UIItemSaleAndUseWithCountController_out")
  YIELD(TT, 333)
  self._exit = false
  self:CloseDialog()
end

function UIItemSaleAndUseWithCountController:itemuseOnClick()
  if self._currentCount ~= 0 then
    self._callBack(self._itemdata, self._currentCount)
  end
  self:ClosePanel()
end

function UIItemSaleAndUseWithCountController:closeOnClick()
  self:ClosePanel()
end
