local UINWCSSelectTower = class("UINWCSSelectTower", UIBaseNode)
local base = UIBaseNode
local UINWCSSelectTowerItem = require("Game.WarChessSeason.UI.WCSSelect.UINWCSSelectTowerItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_MessageCommon = CS.MessageCommon

function UINWCSSelectTower:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_Back) then
    UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickCloseMode)
  end
  self._itemPool = UIItemPool.New(UINWCSSelectTowerItem, self.ui.modeItems)
  self.ui.modeItems:SetActive(false)
  self.__OnSelectItemCallback = BindCallback(self, self.__OnSelectItem)
end

function UINWCSSelectTower:InitWCSSelectTower(seasonId, envId, selectCallback, closeCallback)
  self._seasonId = seasonId
  self._selectCallback = selectCallback
  self._closeCallback = closeCallback
  self._itemPool:HideAll()
  local stageInfoCfgs = WarChessSeasonManager:GetWCSTowerList(seasonId, envId)
  for i, cfg in ipairs(stageInfoCfgs) do
    local item = self._itemPool:GetOne()
    item:InitModelItem(cfg, self.__OnSelectItemCallback)
    item:SetModelColor(cfg.difficulty_color + 1)
    item:SetModelItemUnLocke(WarChessSeasonManager:GetWCSTowerIsUnlock(seasonId, cfg.difficulty_id))
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform)
  local defaultSelect = self._itemPool.listItem[1]
  if defaultSelect ~= nil then
    self:__OnSelectItem(defaultSelect)
  end
  local saveData = WarChessSeasonManager:GetWCSSavingData()
  if not IsNull(self.ui.btn_Back) then
    self.ui.btn_Back.gameObject:SetActive(saveData ~= nil and table.count(saveData) > 0)
  end
end

function UINWCSSelectTower:__OnSelectItem(item)
  local diffcultyInfoCfg = item:GetModeItemDiffInfoCfg()
  if not WarChessSeasonManager:GetWCSTowerIsUnlock(self._seasonId, diffcultyInfoCfg.difficulty_id) then
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
  self._diffcultyInfoCfg = diffcultyInfoCfg
  self.ui.select.transform.anchoredPosition = item.transform.anchoredPosition
  self.ui.select:SetActive(true)
  if self._selectCallback ~= nil then
    self._selectCallback()
  end
end

function UINWCSSelectTower:GetWCSSelectDiffId()
  return self._selectDiffId
end

function UINWCSSelectTower:GetWCSSelectDiffInfoCfg()
  return self._diffcultyInfoCfg
end

function UINWCSSelectTower:OnClickCloseMode()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

return UINWCSSelectTower
