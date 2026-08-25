local CardChange = System.NewClass("CardChange", CardBaseAnimState)

function CardChange:Enter(onChangeFunc)
  self:ResetTwSequence()
  if not self.cardItem.cardBaseUI then
    if onChangeFunc then
      onChangeFunc()
    end
    self:SetFinish()
    return
  end
  self.cardItem:StopAnim()
  if onChangeFunc then
    onChangeFunc()
  end
  self:PlayChangeEnd()
end

function CardChange:PlayChangeBegin(callback)
  local binder = self.cardItem.binder
  local asset = binder:LoadAsset(CommonRes.CardChangeDisappearPrefab)
  local changeEffGo = binder:Instantiate(asset, self.cardItem.rootRectTransform)
  UIUtils.RemoveCloneName(changeEffGo)
  self.cardItem:PlayState("UI_Vx_Battle_Card_CardDisappear", function()
    if not IsNil(changeEffGo) then
      CS.UnityEngine.GameObject.Destroy(changeEffGo)
    end
    callback()
  end)
end

function CardChange:PlayChangeEnd()
  if not self.cardItem or not self.cardItem.binder then
    return
  end
  local pos = self:GetCardPosAndAngle()
  self:SetPos(pos)
  local binder = self.cardItem.binder
  local asset1 = binder:LoadAsset(CommonRes.CardChangeAppearPrefab)
  local appearEffGo = binder:Instantiate(asset1, self.cardItem.rootRectTransform)
  UIUtils.RemoveCloneName(appearEffGo)
  self.cardItem:PlayState("UI_Vx_Battle_Card_CardAppear", function()
    if not IsNil(appearEffGo) then
      CS.UnityEngine.GameObject.Destroy(appearEffGo)
    end
    self:SetFinish()
  end)
  self:SetFinishDelay(3)
end

function CardChange:Exit()
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
  if self.cardPanel then
    self.cardPanel:DelayRelayoutHandCard()
  end
end

return CardChange
