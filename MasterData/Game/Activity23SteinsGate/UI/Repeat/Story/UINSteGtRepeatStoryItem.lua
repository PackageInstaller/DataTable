local base = UIBaseNode
local UINSteGtRepeatStoryItem = class("UINSteGtRepeatStoryItem", base)

function UINSteGtRepeatStoryItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
end

function UINSteGtRepeatStoryItem:InitSteGtRepeatStoryItem(idx, repeatStoryCfg, clickFunc)
  self._clickFunc = clickFunc
  local avgId = repeatStoryCfg.story_id
  self._avgId = avgId
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return
  end
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(avgCfg.name)
  self._unlock = CheckCondition.CheckLua(repeatStoryCfg.pre_condition, repeatStoryCfg.pre_para1, repeatStoryCfg.pre_para2)
  self.ui.obj_Lock:SetActive(not self._unlock)
  if not self._unlock then
    self.ui.tex_LockDes.text = CheckCondition.GetUnlockInfoLua(repeatStoryCfg.pre_condition, repeatStoryCfg.pre_para1, repeatStoryCfg.pre_para2)
  end
  self.ui.img_bottom:SetIndex(idx - 1)
end

function UINSteGtRepeatStoryItem:_OnClickRoot()
  if not self._unlock then
    return
  end
  if self._clickFunc ~= nil then
    self._clickFunc(self._avgId)
  end
end

function UINSteGtRepeatStoryItem:OnDelete()
  base.OnDelete(self)
end

return UINSteGtRepeatStoryItem
