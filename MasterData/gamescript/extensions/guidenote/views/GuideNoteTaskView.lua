local GuideNoteTaskView, Super = NewClass("GuideNoteTaskView", BaseView)
GuideNoteTaskView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Panel_Task.prefab"

function GuideNoteTaskView:ctor(isWeekly)
  Super.ctor(self)
  self.isWeekly = true == isWeekly
end

function GuideNoteTaskView:RegisterEvents()
  local closeBtn = self:FindChildRecursively(self.ui.uiNode, "Btn_Close")
  if closeBtn then
    self:AddButtonClickListener(closeBtn, System.fn(self, self._OnClose))
  end
end

function GuideNoteTaskView:OnEnterView()
  Super.OnEnterView(self)
end

function GuideNoteTaskView:RefreshOnRendered()
end

function GuideNoteTaskView:_OnClose()
  self:Close()
end

return GuideNoteTaskView
