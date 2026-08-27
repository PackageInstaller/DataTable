local UINEventNoviceSignItem = class("UINEventNoviceSignItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local TaskEnum = require("Game.Task.TaskEnum")

function UINEventNoviceSignItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.LuaBindings = {}
  UIUtil.LuaUIBindingTable(self.ui.obj_BaseWithCount.transform, self.LuaBindings)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.LuaBindings.uINBaseItem)
end

function UINEventNoviceSignItem:InitNoviceSignItemsItem(data, awardCfg, awardId, awardCount, resloader)
  self.data = data
  self.awardCfg = awardCfg
  self.awardId = awardId
  self.awardCount = awardCount
  self.resloader = resloader
  self.LuaBindings.tex_TotalCount.text = "x" .. tostring(self.awardCount)
  local itemCfg = ConfigData.item[self.awardId]
  self.itemCfg = itemCfg
  self.LuaBindings.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.baseItem:SetNotNeedAnyJump(true)
  self.baseItem:InitBaseItem(itemCfg)
  self:RefreshNoviceSignItemsItem()
end

function UINEventNoviceSignItem:RefreshNoviceSignItemsItem()
  local state = self.data:GetReceiveState(self.awardCfg.day)
  if state == TaskEnum.eTaskState.Picked then
    self.baseItem:CloseGreatRewardLoopFx()
  elseif state == TaskEnum.eTaskState.Completed then
    if self.isFxInited then
      return
    end
    local path = ItemEffPatch[self.itemCfg.quality]
    self.resloader:LoadABAssetAsync(path, function(prefab)
      self.isFxInited = true
      if IsNull(prefab) or self.__stop then
        return
      end
      local go = prefab:Instantiate(self.baseItem.transform)
      local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
      local usIParticle = go:GetComponentInChildren(typeof(CS.Coffee.UIExtensions.UIParticle))
      particleSystem:Stop()
      go.transform.sizeDelta = self.baseItem.transform.sizeDelta
      go.transform.localScale = self.baseItem.transform.localScale
      particleSystem:Play()
      self.wait4RewardTimerId = TimerManager:StartTimer(1.5, function()
        self.wait4RewardTimerId = nil
        DestroyUnityObject(go)
        self.resloader:LoadABAssetAsync(ItemEffPatch.loop, function(prefab)
          local go = prefab:Instantiate(self.baseItem.transform)
          local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
          local usIParticle = go:GetComponentInChildren(typeof(CS.Coffee.UIExtensions.UIParticle))
          go.transform.sizeDelta = self.baseItem.transform.sizeDelta
          go.transform.localScale = self.baseItem.transform.localScale
          particleSystem:Play()
          self.fxGo = go
        end)
      end, self, true, nil, nil)
    end)
  end
end

function UINEventNoviceSignItem:hasClicked()
  TimerManager:StopTimer(self.wait4RewardTimerId)
  if self.fxGo ~= nil then
    DestroyUnityObject(self.fxGo)
  end
  self.baseItem:CloseGreatRewardLoopFx()
end

function UINEventNoviceSignItem:OnDelete()
  TimerManager:StopTimer(self.wait4RewardTimerId)
  base.OnDelete(self)
end

return UINEventNoviceSignItem
