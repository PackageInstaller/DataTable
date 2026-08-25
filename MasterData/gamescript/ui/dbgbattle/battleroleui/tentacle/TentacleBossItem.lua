local UIAnimationController = CS.Z1Client.UIAnimationController
local SkeletonGraphic = CS.Spine.Unity.SkeletonGraphic
local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local TentacleBossItem, Super = System.NewComponent("TentacleBossItem")

function TentacleBossItem:ctor(uiNode, role, index)
  Super.ctor(self)
  self.ui = UI_Battle_TentacleResource(uiNode)
  self.role = role
  self.index = index
  self.slotUIAnimCtr = self.ui.VX_Animation_Bg:GetComponent(typeof(UIAnimationController))
  self.tentacleAnimCtr = self.ui.VX_Tentacle_Animation_Bg:GetComponent(typeof(UIAnimationController))
  self.tentacleSkeleton = self.ui.SkeletonGraphic_Chushou:GetComponent(typeof(SkeletonGraphic))
  self.tentacleSlotBgMat = self.ui.Image_VX_Trangle_Bg:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material
  self.spineAnimationState = self.tentacleSkeleton.AnimationState
  self.isHaveTenacle = false
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function TentacleBossItem:OnBind(binder)
  self.binder = binder
  self:InitDefault()
  self.spineAnimationState:Complete("+", System.fn(self, self.OnSkeletonAnimComplete))
end

function TentacleBossItem:OnUnbind()
  Super.OnUnbind(self)
  self.spineAnimationState:Complete("-", System.fn(self, self.OnSkeletonAnimComplete))
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
  ResLoadMgr.UnloadAssetByTarget(self)
  if not IsNil(self.slotUIAnimCtr) then
    self.slotUIAnimCtr:StopPlayableGraph()
    self.slotUIAnimCtr = nil
  end
  if not IsNil(self.tentacleAnimCtr) then
    self.tentacleAnimCtr:StopPlayableGraph()
    self.tentacleAnimCtr = nil
  end
end

function TentacleBossItem:InitDefault()
  self.ui.Tentacle_Slot:SetActive(false)
  self.ui.Tentacle_Item:SetActive(false)
end

function TentacleBossItem:OnSkeletonAnimComplete()
  self.spineAnimationState:SetAnimation(0, "loop", true)
end

function TentacleBossItem:OpenSlot(skipAnim)
  self.ui.Tentacle_Slot:SetActive(true)
  if not skipAnim then
    self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Open")
  end
  self.binder:StopTimer(self._closeSlotTimer)
end

function TentacleBossItem:CloseSlot(callback)
  self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Close")
  self.binder:StopTimer(self._closeSlotTimer)
  self._closeSlotTimer = self.binder:BindTimer(0.7, 0, nil, function()
    self.ui.Tentacle_Slot:SetActive(false)
    if callback then
      callback()
    end
  end)
end

function TentacleBossItem:SlotReset()
  self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Reset")
end

function TentacleBossItem:CreateTentacle(skipAnim)
  if self.isHaveTenacle then
    return
  end
  self.isHaveTenacle = true
  self.ui.Tentacle_Item:SetActive(true)
  self:ShowTentacleAttrBg()
  if skipAnim then
    self:PlaySpineAnim("loop", true)
  else
    self:PlaySpineAnim("fadein", false)
    self:PlayTentacleModelAnim("UI_Vx_Battle_ShenHai_Tentacle_01_Open")
  end
end

function TentacleBossItem:ClearTentacle(callback)
  if not self.isHaveTenacle then
    return
  end
  self.isHaveTenacle = false
  self.tentacleAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Tentacle_01_Close", function()
    if self.isHaveTenacle == false then
      self:SetTentacleMat(CommonRes.TentacleSlotBg.BattleTentacle)
      self.ui.Tentacle_Item:SetActive(false)
      if callback then
        callback()
      end
    end
  end)
  self:PlaySpineAnim("fadeout", false)
  self:PlayTentacleModelAnim("UI_Vx_Battle_ShenHai_Tentacle_01_Close")
end

function TentacleBossItem:UpdateTentacle()
  if not self.isHaveTenacle then
    return
  end
  self.tentacleAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Tentacle_01_Up")
  self:PlaySpineAnim("up", false)
end

function TentacleBossItem:SetTentacleDamage(damage, isFrist, damageShow)
  self:ShowDamageText(isFrist)
  local count = self.role:GetTentacleAttackCount() or 1
  local totalDamage = damage * count
  local damageDesc = damage
  if count > 1 then
    damageDesc = LT.Text(string.format("%s<size=24> x %s</size>", damage, count))
  end
  self.binder:SetText(self.ui.TotalDamageText, LT.Text(string.format("<size=20>(</size>%s<size=20>)</size>", totalDamage)))
  self.binder:SetText(self.ui.DamageText, damageDesc)
end

function TentacleBossItem:PlaySpineAnim(animName, isLoop)
  self.spineAnimationState:SetAnimation(0, animName, isLoop)
end

function TentacleBossItem:PlayAppearEffect()
  local effectAsset = self.binder:LoadAsset(CommonRes.TentacleAppearPrefab)
  local effectGo = self.binder:Instantiate(effectAsset, self.ui.uiNode.transform)
  effectGo:SetActive(true)
end

function TentacleBossItem:PlayTentacleModelAnim(animName)
  self.ui.UI_Vx_ShaihaiLoop:SetActive(false)
  self.tentacleAnimCtr:PlayState(animName)
end

function TentacleBossItem:ShowDamageText(isShow)
  local count = self.role:GetTentacleAttackCount()
  self.ui.DamageText:SetActive(isShow)
  self.ui.TotalDamageText:SetActive(isShow and count > 1)
end

function TentacleBossItem:ShowTentacleAttrBg()
  local slotLimit = 0
  if self.role.GetTentacleBattleSlotLimit then
    slotLimit = self.role:GetTentacleBattleSlotLimit() or 0
  else
    slotLimit = self.role:GetTentacleFixedCount() or 0
  end
  if slotLimit < self.index then
    self:SetTentacleMat(CommonRes.TentacleSlotBg.BoutTentacle)
    return
  end
  self:SetTentacleMat(CommonRes.TentacleSlotBg.BattleTentacle)
end

function TentacleBossItem:SetTentacleMat(tentacleAttr)
  local meshRenderer = self.ui.Image_VX_Trangle_Bg:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  if not self._ownTentacleMat then
    self.tentacleSlotBgMat = CS.UnityEngine.Object.Instantiate(meshRenderer.sharedMaterial)
    meshRenderer.material = self.tentacleSlotBgMat
    self._ownTentacleMat = true
  end
  self.tentacleSlotBg = ResLoadMgr.LoadAsset(tentacleAttr, self, CsTexture2D)
  self.tentacleSlotBgMat:SetTexture("_MainTex", self.tentacleSlotBg)
end

function TentacleBossItem:UpdateTentacleInfo(newIndex)
  if self.index ~= newIndex then
    self.index = newIndex
    self.ui.uiNode.transform:SetSiblingIndex(newIndex - 2)
  end
  local skipEnterAnim = bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim()
  self:CreateTentacle(skipEnterAnim)
end

return TentacleBossItem
