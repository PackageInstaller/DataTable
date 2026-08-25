local TaskSchoolView, Super = NewClass("TaskSchoolView", TaskParentChildView)

function TaskSchoolView:_ChildTaskCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Task_Popup_Career_Item)
  local taskData = self.childsTasks[index]
  self:AddViewComponentOnce(cell.gameObject, CompTaskSchoolItem, taskData)
  return cell
end

return TaskSchoolView
