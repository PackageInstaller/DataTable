local PvpBtnListView, Super = NewClass("PvpBtnListView", BaseView)
PvpBtnListView.uiResCls = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_Copy_Formation.prefab"

function PvpBtnListView:ctor(positionNode, offsetPosition, btnList)
  Super.ctor(self)
  self.positionNode = positionNode
  self.offsetPosition = offsetPosition or CS.UnityEngine.Vector3.zero
  self.btnList = btnList
  if not btnList then
    self.btnList = self:GetBtnList()
  end
end

function PvpBtnListView:GetBtnList()
end

function PvpBtnListView:OnBuildView()
  Super.OnBuildView(self)
  self:RefreshBtnList()
end

function PvpBtnListView:RefreshBtnList()
  if not self.btnGameObjs then
    self.btnGameObjs = {
      self.ui.Btn_Copy
    }
  end
  local cnt = math.max(#self.btnList, #self.btnGameObjs)
  for i = 1, cnt do
    local btnGameObj = self.btnGameObjs[i]
    local btnData = self.btnList[i]
    if btnGameObj and not btnData then
      self:SetActive(btnGameObj, false)
    end
    if btnData then
      if not btnGameObj then
        btnGameObj = self:Instantiate(self.ui.Btn_Copy, self.ui.uiNode.transform)
        table.insert(self.btnGameObjs, btnGameObj)
      end
      self:AddButtonClickListener(btnGameObj, System.fn(self, btnData.btnFunc))
      self:SetButtonText(btnGameObj, btnData.btnText)
    end
  end
end

function PvpBtnListView:RegisterEvents()
  self:SetActive(self.ui.Btn_Mask, false)
  self:AddUICustomInputlistener(self.ui.uiNode, function(hover)
    if not hover then
      self:Close()
    end
  end)
end

function PvpBtnListView:OnEnterView()
  Super.OnEnterView(self)
  self:_UpdatePosition()
  LateUpdateBeat.Instance:Add(self._UpdatePosition, self)
end

function PvpBtnListView:OnExitView()
  LateUpdateBeat.Instance:Remove(self._UpdatePosition, self)
  Super.OnExitView(self)
end

function PvpBtnListView:_UpdatePosition()
  local parentTf = self.ui.uiNode.transform.parent
  local localPos = parentTf:InverseTransformPoint(self.positionNode.transform.position)
  self.ui.uiNode.transform.localPosition = localPos + self.offsetPosition
end

return PvpBtnListView
