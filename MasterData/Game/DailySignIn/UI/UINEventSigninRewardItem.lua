local UINEventSigninRewardItem = class("UINEventSigninRewardItem", UIBaseNode)
local base = UIBaseNode

function UINEventSigninRewardItem:OnInit()
  self.dateNum = nil
  self.clickEvent = nil
  self.isPicked = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_dailyItem, self, self.OnClick)
end

function UINEventSigninRewardItem:InitSigninRewardItem(dateNum, clickEvent)
  self.dateNum = dateNum
  self.clickEvent = clickEvent
  if dateNum < 10 then
    self.ui.tex_date.text = "0" .. tostring(dateNum)
  else
    self.ui.tex_date.text = tostring(dateNum)
  end
  local itemIds, itemNums = PlayerDataCenter.dailySignInData:GetSingInRewardByDayNum(dateNum)
  if itemIds == nil then
    error("not config " .. dateNum .. "'s daily sing in reward")
    self.ui.img_itemIcon.gameObject:SetActive(false)
    self.ui.tex_count.gameObject:SetActive(false)
    return
  end
  self.itemCfg = ConfigData.item[itemIds[1]]
  if self.itemCfg == nil then
    error("can't read itemCfg with id:" .. tostring(itemIds[1]))
  else
    self.ui.img_itemIcon.sprite = CRH:GetSpriteByItemConfig(self.itemCfg)
  end
  local num = itemNums[1]
  self.ui.tex_count.text = tostring("x" .. num)
end

function UINEventSigninRewardItem:SetIsReceived(bool)
  self.ui.obj_Received:SetActive(bool)
  self.isPicked = bool
end

function UINEventSigninRewardItem:SetCurDayMArker()
end

function UINEventSigninRewardItem:LoadAndPlayFx(resloader, xRotate, uiItemScaleRate, callback)
  local path = ItemEffPatch[self.itemCfg.quality]
  if self._isInitedFx then
    self._particleSystem:Play()
    TimerManager:StopTimer(self.wait4RewardTimerId)
    self.wait4RewardTimerId = TimerManager:StartTimer(0.5, function()
      self.wait4RewardTimerId = nil
      if callback ~= nil then
        callback()
      end
    end, self, true, nil, nil)
  end
  resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) or self.__stop then
      return
    end
    local go = prefab:Instantiate(self.transform)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    local usIParticle = go:GetComponentInChildren(typeof(CS.Coffee.UIExtensions.UIParticle))
    particleSystem:Stop()
    if usIParticle.ignoreCanvasScaler then
      local scaleRate = uiItemScaleRate ~= nil or uiItemScaleRate and 1.5
      usIParticle.scale = self.transform.sizeDelta.x * scaleRate
    else
      go.transform.sizeDelta = self.transform.sizeDelta
      go.transform.localScale = Vector3.New(1.5, 1.2, 1)
    end
    go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
    particleSystem:Play()
    if self.wait4RewardTimerId == nil then
      self.wait4RewardTimerId = TimerManager:StartTimer(0.5, function()
        self.wait4RewardTimerId = nil
        if callback ~= nil then
          callback()
        end
      end, self, true, nil, nil)
    end
    self._isInitedFx = true
    self._particleSystem = particleSystem
  end)
end

function UINEventSigninRewardItem:OnClick()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINEventSigninRewardItem:OnDelete()
  TimerManager:StopTimer(self.wait4RewardTimerId)
  base.OnDelete(self)
end

return UINEventSigninRewardItem
