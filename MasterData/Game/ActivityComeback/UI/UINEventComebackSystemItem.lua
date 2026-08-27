local UINEventComebackSystemItem = class("UINEventComebackSystemItem", UIBaseNode)
local base = UIBaseNode

function UINEventComebackSystemItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Item, self, self.OnClickComebackSystemItem)
end

function UINEventComebackSystemItem:InitComebackSystemItem(index, moduleCfg, taskIds, isDone, clickFunc, resloader)
  self._index = index
  self._moduleCfg = moduleCfg
  self._taskIds = taskIds
  self._clickFunc = clickFunc
  self._isDone = isDone
  self.resLoader = resloader
  self.ui.Tex_Title.text = LanguageUtil.GetLocaleText(moduleCfg.small_title)
  if not string.IsNullOrEmpty(moduleCfg.small_img) then
    local path = PathConsts:GetEventComebackPicPath(moduleCfg.small_img)
    self.resLoader:LoadABAssetAsync(path, function(texture)
      if texture == nil then
        return
      end
      self.ui.Pic.texture = texture
    end)
  end
  self.ui.Obj_Lock:SetActive(self._isDone)
  self:RefreshComebackSystemItemReddot()
end

function UINEventComebackSystemItem:RefreshComebackSystemItemReddot()
  self.ui.RedDot:SetActive(false)
  if self._taskIds == nil then
    return
  end
  local isShow = false
  for _, taskId in ipairs(self._taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData:CheckComplete() then
      isShow = true
      break
    end
  end
  self.ui.RedDot:SetActive(isShow)
end

function UINEventComebackSystemItem:OnClickComebackSystemItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self.ui.Selected.transform, self._moduleCfg, self._taskIds, self._index)
  end
end

function UINEventComebackSystemItem:OnDelete()
  base.OnDelete(self)
end

return UINEventComebackSystemItem
