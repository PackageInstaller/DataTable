local UINHalloweenSelectMode = class("UINHalloweenSelectMode", UIBaseNode)
local base = UIBaseNode
local UINHalloweenSelectModeItem = require("Game.ActivityHallowmas.UI.Select.UINHalloweenSelectModeItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon

function UINHalloweenSelectMode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_Back) then
    UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickCloseMode)
  end
  self._itemPool = UIItemPool.New(UINHalloweenSelectModeItem, self.ui.modeItems)
  self.ui.modeItems:SetActive(false)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
end

function UINHalloweenSelectMode:InitHalloweenSelectMode(hallowmasData, envId, selectCallback, closeCallback)
  self._data = hallowmasData
  self._selectCallback = selectCallback
  self._closeCallback = closeCallback
  self._itemPool:HideAll()
  local stageInfoCfgs = self._data:GetHallowmasStageInfoCfg()
  for i, cfg in ipairs(stageInfoCfgs) do
    if (envId or 0) == 0 or self._data:IsHallowmasEnvDiffcultyExist(envId, cfg.difficulty_id) then
      local item = self._itemPool:GetOne()
      item:InitModelItem(cfg, self.__OnSelectItemCallback)
      item:SetModelColor(cfg.difficulty_color + 1)
      item:SetModelItemUnLocke(self._data:IsHallowmasDiffUnlock(cfg.difficulty_id))
    end
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
  local defaultSelect = self._itemPool.listItem[1]
  self:__OnSelectItem(defaultSelect)
  local saveData = WarChessSeasonManager:GetWCSSavingData()
  if not IsNull(self.ui.btn_Back) then
    self.ui.btn_Back.gameObject:SetActive(saveData ~= nil and 0 < table.count(saveData))
  end
end

function UINHalloweenSelectMode:__OnSelectItem(item)
  local diffcultyInfoCfg = item:GetModeItemDiffInfoCfg()
  if not self._data:IsHallowmasDiffUnlock(diffcultyInfoCfg.difficulty_id) then
    local conditionList = diffcultyInfoCfg.preConditions
    local unlockStr
    if diffcultyInfoCfg.preConditionsNum > 1 then
      unlockStr = CheckCondition.GetUnlockInfoLuaByManyList(conditionList)
    elseif diffcultyInfoCfg.preConditionsNum == 1 then
      local firstCond = conditionList[1]
      unlockStr = CheckCondition.GetUnlockInfoLua(firstCond[1], firstCond[2], firstCond[3])
    end
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8708, unlockStr))
    return
  end
  self._selectDiffId = diffcultyInfoCfg.difficulty_id
  self.ui.select.transform.anchoredPosition = item.transform.anchoredPosition
  self.ui.select:SetActive(true)
  if self._selectCallback ~= nil then
    self._selectCallback()
  end
end

function UINHalloweenSelectMode:GetSelectHallowDiffId()
  return self._selectDiffId
end

function UINHalloweenSelectMode:OnClickCloseMode()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

return UINHalloweenSelectMode
