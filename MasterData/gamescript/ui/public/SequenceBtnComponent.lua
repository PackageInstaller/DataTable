local SequenceBtnComponent, Super = System.NewComponent("SequenceBtnComponent")

function SequenceBtnComponent:ctor(res, isInitUp, downCallback, upCallback)
  Super.ctor(self)
  self.ui = Btn_SortResource(res)
  self.downCallback = downCallback
  self.upCallback = upCallback
  self.curAngle = Vue.ref(0)
  self.curAngle.value = isInitUp and 180 or 0
end

function SequenceBtnComponent:OnBind(binder)
  binder:BindToRaw(function(_, nVal, _)
    if 180 == nVal then
      binder:SetText(self.ui.Text_Shrink, LT.Text("CopyBag_6"))
      self.ui.Image_Shrink_Arrow.transform.localEulerAngles = CS.UnityEngine.Vector3(180, 0, 0)
      if self.upCallback then
        self.upCallback()
      end
    else
      binder:SetText(self.ui.Text_Shrink, LT.Text("CopyBag_5"))
      self.ui.Image_Shrink_Arrow.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
      if self.downCallback then
        self.downCallback()
      end
    end
  end, function()
    return self.curAngle.value
  end)
  binder:BindButtonClick(self.ui.uiNode, function()
    self.curAngle.value = 0 == self.curAngle.value and 180 or 0
  end)
end

return SequenceBtnComponent
