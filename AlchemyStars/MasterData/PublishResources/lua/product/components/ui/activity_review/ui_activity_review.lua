_class("UIActivityReview", UIController)
UIActivityReview = UIActivityReview

function UIActivityReview:LoadDataOnEnter(TT, res)
  local count = GameGlobal.GetModule(RoleModule):GetReviewCoinAddedCount()
  local tmpRes = GameGlobal.GetModule(CampaignModule):EnterCampaignReiew(TT)
  if tmpRes and tmpRes:GetSucc() then
    self._addedCoinCount = count
    res:SetSucc(true)
  else
    GameGlobal.GetModule(CampaignModule):ShowErrorToast(tmpRes:GetResult())
    res:SetSucc(false)
  end
end

function UIActivityReview:OnShow(uiParams)
  self:InitWidget()
  local topWidget = self.topBtn:SpawnObject("UICommonTopButton")
  topWidget:SetData(function()
    self:SwitchState(UIStateType.UIExtraSelect)
  end, function()
    self:ShowDialog("UIHelpController", self:GetName())
  end)
  self._topCurrency = self.toptips:SpawnObject("UICurrencyMenu")
  self._topCurrency:SetData({
    RoleAssetID.RoleAssetActiveToken
  })
  local uiModule = GameGlobal.GetUIModule(CampaignModule)
  self._data = uiModule:GetReviewData()
  self._dataList = self._data:GetAllOpenedList()
  local paddingLeft = -135
  local paddingRight = 414
  local del1 = 580
  local del2 = 241
  local sWidth = self.safeArea.rect.width
  local width = paddingLeft
  for i = 1, #self._dataList do
    local value = i % 2
    if value == 1 then
      width = width + del1
    else
      width = width + del2
    end
  end
  width = width + paddingRight
  self.contentTr.sizeDelta = Vector2(math.max(sWidth, width), self.safeArea.rect.height)
  local items = self.content:SpawnObjects("UIActivityReviewItem", #self._dataList)
  for index, item in ipairs(items) do
    item:SetData(self._dataList[index], index, index == #self._dataList)
  end
  if self._addedCoinCount and self._addedCoinCount > 0 then
    local coinToptip = self._topCurrency:GetItemByTypeId(RoleAssetID.RoleAssetActiveToken)
    local count = GameGlobal.GetModule(ItemModule):GetItemCount(RoleAssetID.RoleAssetActiveToken)
    local from = math.max(count - self._addedCoinCount, 0)
    local to = count
    local max = Cfg.cfg_global.ActiveReviewTokenMax.IntValue
    if from ~= to then
      local tl = EZTL_Sequence:New({
        EZTL_PlayAnimation:New(self.anim, "UIActivityReview_uianim", "Animation"),
        EZTL_TextUpAnimFormat:New(coinToptip:GetUIText(), from, to, 500, "%s/" .. max, "文字滚动")
      }, "顶条物品数量滚动")
      self._eftPlayer = EZTL_Player:New()
      self.anim.gameObject:SetActive(true)
      self.AddValue:SetText("+" .. tostring(self._addedCoinCount))
      coinToptip:GetUIText():SetText(from .. "/" .. max)
      self._eftPlayer:Play(tl)
    end
  end
end

function UIActivityReview:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "topBtn")
  self.toptips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.contentTr = self:GetUIComponent("RectTransform", "Content")
  self.safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.anim.gameObject:SetActive(false)
  self.AddValue = self:GetUIComponent("UILocalizationText", "AddValue")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "shot")
end

function UIActivityReview:OnHide()
  if self._eftPlayer then
    if self._eftPlayer:IsPlaying() then
      self._eftPlayer:Stop()
    end
    self._eftPlayer = nil
  end
end

function UIActivityReview:_InitItem(scrollview, index)
  if index < 0 then
    return nil
  end
  index = index + 1
  local item = scrollview:NewListViewItem("item")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
  end
  local itemWidget = cellPool:SpawnObject("UIActivityReviewItem")
  itemWidget:SetData(self._dataList[index], index, #self._dataList == index)
  return item
end

function UIActivityReview:GetShotImage()
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  return self._shot:RefreshBlurTexture()
end
