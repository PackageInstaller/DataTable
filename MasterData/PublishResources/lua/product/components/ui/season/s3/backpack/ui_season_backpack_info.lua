_class("UISeasonBackpackInfo", UIController)
UISeasonBackpackInfo = UISeasonBackpackInfo

function UISeasonBackpackInfo:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonBackpackInfo:OnShow(uiParams)
  self._cfg = uiParams[1]
  self._levelCfg = Cfg.cfg_season_debris_level[self._cfg.ID]
  self:InitWidget()
  self:OnValue()
end

function UISeasonBackpackInfo:InitWidget()
  self._name = self:GetUIComponent("UILocalizedTMP", "Name")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._condition = self:GetUIComponent("UILocalizationText", "Condition")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
end

function UISeasonBackpackInfo:OnValue()
  self._name:SetText(StringTable.Get(self._levelCfg.Title))
  self._desc:SetText(StringTable.Get(self._levelCfg.Leveldesc))
  self._condition:SetText(StringTable.Get("str_season_debris_condition", "<size=30>" .. self._cfg.Score .. "</size>"))
  self._icon:LoadImage(self._levelCfg.Icon)
  local items = {}
  local rewards = self._cfg.Reward
  if rewards then
    for _, value in pairs(rewards) do
      items[#items + 1] = {
        id = value[1],
        count = value[2]
      }
    end
    self._content:SpawnObjects("UISeasonBackpackItem", #items)
    local itemWidgets = self._content:GetAllSpawnList()
    for index, widget in ipairs(itemWidgets) do
      widget:SetData(self._cfg.ID, items[index], function(id, pos)
        self:_ShowItemTips(id, pos)
      end)
    end
  end
end

function UISeasonBackpackInfo:ChallengeBtnOnClick(go)
  local controller = GameGlobal.UIStateManager():GetController("UISeasonBackpack")
  if controller and controller:IsClose() then
    self:Lock("UISeasonBackpackInfo:ChallengeBtnOnClick")
    self:StartTask(function(TT)
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
      YIELD(TT, 500)
      controller:GoHome()
      self:UnLock("UISeasonBackpackInfo:ChallengeBtnOnClick")
    end)
    return
  end
  self:ShowDialog("UICN7N36PostInnerGameController", self._cfg.ID, function(firstPass)
    if firstPass then
      local rewards = {}
      for _, value in pairs(self._cfg.Reward) do
        local roleAsset = RoleAsset:New()
        roleAsset.assetid = value[1]
        roleAsset.count = value[2]
        table.insert(rewards, roleAsset)
      end
      UISeasonHelper.ShowUIGetRewards(rewards)
      self:OnValue()
    end
  end)
end

function UISeasonBackpackInfo:CloseBtnOnClick()
  local controller = GameGlobal.UIStateManager():GetController("UISeasonBackpack")
  if controller then
    controller:RefreshUI()
  end
  self:CloseDialog()
end

function UISeasonBackpackInfo:_ShowItemTips(id, pos)
  self._tips:SetData(id, pos)
end
