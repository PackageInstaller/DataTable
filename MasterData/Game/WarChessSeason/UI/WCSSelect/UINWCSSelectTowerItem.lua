local UINWCSSelectTowerItem = class("UINWCSSelectTowerItem", UIBaseNode)
local base = UIBaseNode

function UINWCSSelectTowerItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickConfirm)
end

function UINWCSSelectTowerItem:InitModelItem(stageInfoCfg, callback)
  self._stageInfoCfg = stageInfoCfg
  self._callback = callback
  self.ui.tex_ModeENName.text = stageInfoCfg.difficulty_name_en
  self.ui.tex_ModeCNName.text = LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name)
  self.ui.tex_Recommend:SetIndex(0, tostring(stageInfoCfg.combat))
  self.ui.tex_EPoints.text = LanguageUtil.GetLocaleText(stageInfoCfg.forecast_des)
end

function UINWCSSelectTowerItem:SetModelItemUnLocke(flag)
  if not IsNull(self.ui.obj_Locked) then
    self.ui.obj_Locked:SetActive(not flag)
    if not flag then
      local conditionList = self._stageInfoCfg.preConditions
      local unlockStr = ""
      if self._stageInfoCfg.preConditionsNum > 1 then
        unlockStr = CheckCondition.GetUnlockInfoLuaByManyList(conditionList)
      elseif self._stageInfoCfg.preConditionsNum == 1 then
        local firstCond = conditionList[1]
        unlockStr = CheckCondition.GetUnlockInfoLua(firstCond[1], firstCond[2], firstCond[3])
      end
      self.ui.tex_unlock.text = ConfigData:GetTipContent(8708, unlockStr)
    end
  end
end

function UINWCSSelectTowerItem:SetModelColor(index)
  local color = self.ui.color_state[index]
  if color == nil then
    color = self.ui.color_state[#self.ui.color_state]
  end
  self.ui.img_ModeBg.color = color
end

function UINWCSSelectTowerItem:OnClickConfirm()
  if self._callback ~= nil then
    self._callback(self)
  end
end

function UINWCSSelectTowerItem:GetModeItemDiffInfoCfg()
  return self._stageInfoCfg
end

return UINWCSSelectTowerItem
