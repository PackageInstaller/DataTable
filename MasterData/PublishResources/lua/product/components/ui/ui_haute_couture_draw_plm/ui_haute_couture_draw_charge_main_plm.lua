_class("UIHauteCoutureDrawChargeMainPLM", UIHauteCoutureDrawChargeBase)
UIHauteCoutureDrawChargeMainPLM = UIHauteCoutureDrawChargeMainPLM

function UIHauteCoutureDrawChargeMainPLM:Constructor()
end

function UIHauteCoutureDrawChargeMainPLM:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AddEventBase()
end

function UIHauteCoutureDrawChargeMainPLM:InitWidgets()
  self.controller = self.uiOwner
  self._ctx = self.controller._ctx
  local btns = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self._backBtn = btns:SpawnObject("UINewCommonTopButton")
  self._backBtn:SetData(function()
    self:StartTask(function(TT)
      self._anim:Play("UIHauteCoutureDrawChargeMainGL_out")
      YIELD(TT, 450)
      self.controller:CloseDialog()
    end)
  end, nil, nil, false, nil, nil)
  local currency = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  self._topTips = currency:SpawnObject("UINewCurrencyMenu")
  self._topTips:SetData({
    self:GetCoinId()
  }, true)
  self._seniorSkinItem = self._topTips:GetItemByTypeId(self:GetCoinId())
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:RemoveEventBase()
end

function UIHauteCoutureDrawChargeMainPLM:_OnValue()
  self:_OnValueBase()
  local itemPools = self._itemPool:GetAllSpawnList()
  for i = 1, #itemPools do
    local item = itemPools[i]
    item:PlayAnimIn(i)
  end
end

function UIHauteCoutureDrawChargeMainPLM:GetCoinId()
  return 3000378
end

function UIHauteCoutureDrawChargeMainPLM:GetItemImpl()
  return "UIHauteCoutureDrawChargeItemPLM"
end
