_class("UIBounceInput", UICustomWidget)
UIBounceInput = UIBounceInput

function UIBounceInput:OnShow(uiParams)
  self:InitWidget()
end

function UIBounceInput:InitWidget()
  self._atlas = self:GetAsset("UIN28MinigameIn.spriteatlas", LoadType.SpriteAtlas)
  self._Input = GameGlobal.EngineInput()
  local btnGO = self:GetGameObject("JumpBtn")
  self._jumpImg = btnGO:GetComponent(typeof(UnityEngine.UI.Image))
  local etl = UICustomUIEventListener.Get(btnGO)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    if self._jumpCall then
      self._jumpCall()
    end
  end)
  btnGO = self:GetGameObject("AttackBtn")
  self._attackImg = btnGO:GetComponent(typeof(UnityEngine.UI.Image))
  local etl = UICustomUIEventListener.Get(btnGO)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    if self._attackCall then
      self._attackCall()
    end
  end)
  self.jumpAttackBtnGo = self:GetGameObject("JumpAttackBtn")
  self._jumpAttackImg = self.jumpAttackBtnGo:GetComponent(typeof(UnityEngine.UI.Image))
  local etl = UICustomUIEventListener.Get(self.jumpAttackBtnGo)
  self:AddUICustomEventListener(etl, UIEvent.Release, function(go)
    if self._jumpCall then
      self._jumpCall()
    end
  end)
  if IsPc() or IsUnityEditor() then
  end
  self:ChangeJumpAttackBtnActive(false)
end

function UIBounceInput:Init(attackCall, jumpCall)
  self._attackCall = attackCall
  self._jumpCall = jumpCall
end

function UIBounceInput:OnUpdate(deltaTimeMS)
  self:OnPCInputUpdate()
end

function UIBounceInput:JumpAttackBtnOnClick()
  if self._jumpCall then
    self._jumpCall()
  end
end

function UIBounceInput:AttackBtnOnClick()
  if self._attackCall then
    self._attackCall()
  end
end

function UIBounceInput:OnPCInputUpdate()
  if IsPc() or IsUnityEditor() then
    if self._Input.GetKeyDown(UnityEngine.KeyCode.R) and self._attackCall then
      self._attackCall(true)
    end
    if self._Input.GetKeyDown(UnityEngine.KeyCode.T) and self._jumpCall then
      self._jumpCall(true)
    else
    end
  end
end

function UIBounceInput:ChangeJumpAttackBtnActive(isShow)
  self.jumpAttackBtnGo:SetActive(isShow)
end
