local base = UIBaseNode
local UINMlstTaskOverviewItem = class("UINMlstTaskOverviewItem", base)

function UINMlstTaskOverviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self._OnClickJump)
end

function UINMlstTaskOverviewItem:InitMlstTaskOverviewItem(taskOverviewData, jumpFunc)
  self._taskOverviewData = taskOverviewData
  self._jumpFunc = jumpFunc
  self.ui.tex_TitleName.text = LanguageUtil.GetLocaleText(taskOverviewData.mlstTaskCfg.name)
  self.ui.img_Progress.fillAmount = taskOverviewData.progress
  self.ui.tex_Precent:SetIndex(0, GetPreciseDecimalStr(taskOverviewData.progress * 100, 1))
  self.ui.obj_Tag:SetActive(false)
  self.ui.obj_Clear:SetActive(false)
  self.ui.btn_Jump.gameObject:SetActive(true)
  if taskOverviewData.isRecommend then
    self.ui.obj_Tag:SetActive(true)
  elseif taskOverviewData.progress >= 1 then
    self.ui.obj_Clear:SetActive(true)
    self.ui.btn_Jump.gameObject:SetActive(false)
  end
end

function UINMlstTaskOverviewItem:_OnClickJump()
  if self._jumpFunc then
    local cfg = self._taskOverviewData.mlstTaskCfg
    self._jumpFunc(cfg.jump_id, cfg.jump_arg)
  end
end

function UINMlstTaskOverviewItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstTaskOverviewItem
