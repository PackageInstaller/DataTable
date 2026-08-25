local WorldStageCurseCardPanel, Super = System.NewClass("WorldStageCurseCardPanel", UIBasePanel)
WorldStageCurseCardPanel.uiResCls = UI_Dbgcopy_Panel_Select_CurseResource

function WorldStageCurseCardPanel:ctor(cardInfo, callFunc)
  Super.ctor(self)
  self.cardInfo = cardInfo
  self.callFunc = callFunc
end

function WorldStageCurseCardPanel:OnBind(binder)
  self.binder = binder
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      local layoutGroup = self.ui.Group_Card:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
      layoutGroup.enabled = false
    end
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    if 1 == #self.cardInfo then
      do return LT.Text end
      return LT.Text, "获得一张诅咒卡"
    elseif 2 == #self.cardInfo then
      do return LT.Text end
      return LT.Text, "获得两张诅咒卡"
    else
      return ""
    end
  end)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.OnBtnConfirm), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  for i = 1, 2 do
    if self.cardInfo[i] then
      binder:SetActive(self.ui["Card_" .. i], true)
      binder:BindComponent(WorldStageCardSelectItem(self.ui["Card_" .. i], {
        cardTid = self.cardInfo[i].tid
      }, nil))
    else
      binder:SetActive(self.ui["Card_" .. i], false)
    end
  end
end

function WorldStageCurseCardPanel:OnBtnConfirm()
  self:Close()
end

return WorldStageCurseCardPanel
