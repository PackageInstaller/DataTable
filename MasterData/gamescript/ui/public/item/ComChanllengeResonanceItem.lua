local ComChanllengeResonanceItem, Super = System.NewComponent("ComChanllengeResonanceItem")

function ComChanllengeResonanceItem:ctor(res, resonanceTid)
  Super.ctor(self)
  self.ui = UI_Common_Item_ResonanceResource(res)
  self.resonanceTid = resonanceTid
end

function ComChanllengeResonanceItem:OnBind(binder)
  self.model = binder:createModel(ComChanllengeResonanceItemModel, self.resonanceTid)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    local item = binder:BindNewComponentWithMask(CS.UnityEngine.GameObject.Find("UIRoot/SafeArea/TipPopRoot"), PublicKeyWordTipItem, Func_Public_Keyword_TipResource, self.model.resonanceDesc)
    local pos = self.ui.Image_Resonance_Icon.transform.position
    item:SetItemPos2(pos)
  end)
  binder:BindToText(self.ui.Text_Resonance, function()
    return self.model.resonanceText
  end)
  binder:BindToImage(self.ui.Image_Resonance_Icon, function()
    return self.model.imageIcon
  end)
end

function ComChanllengeResonanceItem:SetResonanceTid(tid)
  self.model:SetResonanceTid(tid)
end

return ComChanllengeResonanceItem
