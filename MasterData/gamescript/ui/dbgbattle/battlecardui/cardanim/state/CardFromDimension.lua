local UIAnimationController = CS.Z1Client.UIAnimationController
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local Instantiate = CS.UnityEngine.GameObject.Instantiate
local DestroyGameObject = CS.UnityEngine.GameObject.Destroy
local CardFromDimension = System.NewClass("CardFromDimension", CardBaseAnimState)

function CardFromDimension:Enter()
  self:ResetTwSequence()
  self:ResetCard()
  local cardBaseUI = self.cardItem.cardBaseUI
  local uiAnimCtr = cardBaseUI.uiNode:GetComponent(typeof(UIAnimationController))
  local UI_Vx_Battle_Chaowei_CardAppear01 = self.binder:LoadAsset("UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Chaowei_CardAppear01.prefab")
  self.UI_Vx_Battle_Chaowei_CardAppear01 = Instantiate(UI_Vx_Battle_Chaowei_CardAppear01)
  self.UI_Vx_Battle_Chaowei_CardAppear01.name = "UI_Vx_Battle_Chaowei_CardAppear01"
  local transform = self.UI_Vx_Battle_Chaowei_CardAppear01.transform
  transform:SetParent(cardBaseUI.uiNode.transform, false)
  transform.anchoredPosition = Vector2(-8, 8)
  transform.localScale = Vector3(1.341, 1.341, 1.341)
  uiAnimCtr:PlayState("UI_Vx_Battle_Chaowei_CardAppear01", function()
    cardBaseUI.Card_Content.transform.localScale = Vector3.one
    DestroyGameObject(self.UI_Vx_Battle_Chaowei_CardAppear01)
    self.UI_Vx_Battle_Chaowei_CardAppear01 = nil
    self:SetFinish()
  end)
end

function CardFromDimension:Exit()
  if self.UI_Vx_Battle_Chaowei_CardAppear01 then
    DestroyGameObject(self.UI_Vx_Battle_Chaowei_CardAppear01)
    self.UI_Vx_Battle_Chaowei_CardAppear01 = nil
  end
  CardBaseAnimState.Exit(self)
  self:ResetTwSequence()
end

return CardFromDimension
