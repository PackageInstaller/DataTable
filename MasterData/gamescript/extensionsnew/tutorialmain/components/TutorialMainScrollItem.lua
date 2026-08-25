local TutorialMainScrollItem, Super = NewViewComponent("TutorialMainScrollItem")

function TutorialMainScrollItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Course_Panel_Main_ItemResource(uiNode)
  self._tid = data and data.tid
  self._clickFunc = data and data.clickFunc
end

function TutorialMainScrollItem:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:_Refresh()
end

function TutorialMainScrollItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function TutorialMainScrollItem:Refresh(data)
  self._tid = data and data.tid
  self._clickFunc = data and data.clickFunc
  self:_Refresh()
end

function TutorialMainScrollItem:_Refresh()
  local tid = self._tid
  if not tid then
    return
  end
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(tid)
  self:SetText(self.ui.Text_Name, tutorialCfg and LT.Text(tutorialCfg.Title) or "")
  local isSelected = tid == TutorialMainModel.Instance:GetCurSelectTutorialItemTid()
  self.ui.Group_Sel:SetActive(isSelected)
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    if TutorialMainModel.Instance:HasItemReceiveRed(tid) then
      return RedPointDataUtils.RedAttrType.Red
    end
    return false
  end)
end

function TutorialMainScrollItem:_OnClick()
  if self._clickFunc then
    self._clickFunc()
  end
end

return TutorialMainScrollItem
