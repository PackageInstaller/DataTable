_class("UIN34DispatchComplete", UIController)
UIN34DispatchComplete = UIN34DispatchComplete

function UIN34DispatchComplete:Constructor()
end

function UIN34DispatchComplete:LoadDataOnEnter(TT, res, uiParams)
  self._archId = uiParams[1]
end

function UIN34DispatchComplete:OnShow(uiParams)
  self:UIWidget()
  self:CreateRewards()
  self:FlushRewards()
  self:InAnimation()
end

function UIN34DispatchComplete:OnHide()
end

function UIN34DispatchComplete:BtnAnywhereOnClick(go)
  self:OutAnimation(function()
    self:CloseDialog()
  end)
end

function UIN34DispatchComplete:OnShowItemInfo(reward, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UICommonItemInfo", reward, deltaPosition)
end

function UIN34DispatchComplete:UIWidget()
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._btnAnywhere = self:GetUIComponent("RectTransform", "btnAnywhere")
  self._rewardContent = self:GetUIComponent("UISelectObjectPath", "rewardContent")
  self._safeArea = self:GetUIComponent("RectTransform", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchComplete:CreateRewards()
  local cfg = Cfg.cfg_component_dispatch_arch[self._archId]
  self._rewards = {}
  for k, v in pairs(cfg.Rewards) do
    if 2 <= #v then
      local asset = RoleAsset:New()
      asset.assetid = v[1]
      asset.count = v[2]
      table.insert(self._rewards, asset)
    end
  end
  local assetCount = #self._rewards
  self._widgetRewards = self._rewardContent:SpawnObjects("UIItem", assetCount)
end

function UIN34DispatchComplete:FlushRewards()
  for k, v in pairs(self._rewards) do
    local cfgItem = Cfg.cfg_item[v.assetid]
    local data = {
      icon = cfgItem.Icon,
      quality = cfgItem.Color,
      text1 = tostring(v.count)
    }
    local reward = v
    local uiWidget = self._widgetRewards[k]
    uiWidget:SetForm(UIItemForm.Base, UIItemScale.Level1)
    uiWidget:SetData(data)
    uiWidget:SetClickCallBack(function(go)
      self:OnShowItemInfo(reward, go)
    end)
  end
end

function UIN34DispatchComplete:InAnimation()
  local lockName = "UIN34DispatchComplete:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchComplete_in")
    YIELD(TT, 400)
    self:UnLock(lockName)
  end)
end

function UIN34DispatchComplete:OutAnimation(endCb)
  local lockName = "UIN34DispatchComplete:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchComplete_out")
    YIELD(TT, 167)
    if endCb ~= nil then
      endCb()
    end
    self:UnLock(lockName)
  end)
end

_class("UIN34DispatchReward", UICustomWidget)
UIN34DispatchReward = UIN34DispatchReward

function UIN34DispatchReward:Constructor()
end

function UIN34DispatchReward:OnShow()
  self._iconLoader = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._iconImg = self:GetUIComponent("RawImage", "imgIcon")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIN34DispatchReward:OnHide()
end

function UIN34DispatchReward:ButtonOnClick(go)
  self:RootUIOwner():OnShowItemInfo(self._reward, go)
end

function UIN34DispatchReward:SetData(data)
  self._reward = data
  local cfgItem = Cfg.cfg_item[self._reward.assetid]
  if cfgItem ~= nil then
    self._iconLoader:LoadImage(cfgItem.Icon)
  end
  self._txtName.gameObject:SetActive(false)
  self._txtCount:SetText(string.format("X %d", self._reward.count))
end
