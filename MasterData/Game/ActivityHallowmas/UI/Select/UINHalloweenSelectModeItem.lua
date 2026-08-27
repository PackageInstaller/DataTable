local UINHalloweenSelectModeItem = class("UINHalloweenSelectModeItem", UIBaseNode)
local base = UIBaseNode

function UINHalloweenSelectModeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickConfirm)
end

function UINHalloweenSelectModeItem:InitModelItem(hallowStageInfoCfg, callback)
  self._hallowStageInfoCfg = hallowStageInfoCfg
  self._callback = callback
  self.ui.tex_ModeENName.text = hallowStageInfoCfg.difficulty_name_en
  self.ui.tex_ModeCNName.text = LanguageUtil.GetLocaleText(hallowStageInfoCfg.difficulty_name)
  self.ui.tex_Recommend:SetIndex(0, tostring(hallowStageInfoCfg.combat))
  self.ui.tex_EPoints.text = LanguageUtil.GetLocaleText(hallowStageInfoCfg.forecast_des)
end

function UINHalloweenSelectModeItem:SetModelItemUnLocke(flag)
  if not IsNull(self.ui.obj_Locked) then
    self.ui.obj_Locked:SetActive(not flag)
    if not flag then
      local conditionList = self._hallowStageInfoCfg.preConditions
      local unlockStr = ""
      if self._hallowStageInfoCfg.preConditionsNum > 1 then
        unlockStr = CheckCondition.GetUnlockInfoLuaByManyList(conditionList)
      elseif self._hallowStageInfoCfg.preConditionsNum == 1 then
        local firstCond = conditionList[1]
        unlockStr = CheckCondition.GetUnlockInfoLua(firstCond[1], firstCond[2], firstCond[3])
      end
      self.ui.tex_unlock.text = ConfigData:GetTipContent(8708, unlockStr)
    end
  end
end

function UINHalloweenSelectModeItem:SetModelColor(index)
  local color = self.ui.color_state[index]
  if color == nil then
    color = self.ui.color_state[#self.ui.color_state]
  end
  self.ui.img_ModeBg.color = color
end

function UINHalloweenSelectModeItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self)
  end
end

function UINHalloweenSelectModeItem:GetModeItemDiffInfoCfg()
  return self._hallowStageInfoCfg
end

return UINHalloweenSelectModeItem
