local UIAnimationController = CS.Z1Client.UIAnimationController
local SkeletonGraphic = CS.Spine.Unity.SkeletonGraphic
local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local TentacleItem, Super = System.NewComponent("TentacleItem")
local OceanSpineAnim = {
  [BattleConst.OceanModel.OceanModel1] = {
    fadein = "fadein",
    loop = "loop",
    fadeout = "fadeout"
  },
  [BattleConst.OceanModel.OceanModel2] = {
    fadein = "fadein_gray",
    loop = "loop_gray",
    fadeout = "fadeout_gray"
  },
  [BattleConst.OceanModel.OceanModel3] = {
    fadein = "fadein_red",
    loop = "loop_red",
    fadeout = "fadeout_red"
  }
}
local TentacleModelAnim = {
  default = {
    open = "UI_Vx_Battle_ShenHai_Tentacle_01_Open",
    close = "UI_Vx_Battle_ShenHai_Tentacle_01_Close"
  },
  [BattleConst.OceanModel.OceanModel1] = {
    open = "UI_Vx_Battle_ShenHai_Tentacle_Blue_Open01",
    close = "UI_Vx_Battle_ShenHai_Tentacle_Blue_Close01"
  },
  [BattleConst.OceanModel.OceanModel2] = {
    open = "UI_Vx_Battle_ShenHai_Tentacle_Gray_Open",
    close = "UI_Vx_Battle_ShenHai_Tentacle_Gray_Close"
  },
  [BattleConst.OceanModel.OceanModel3] = {
    open = "UI_Vx_Battle_ShenHai_Tentacle_Red_Open",
    close = "UI_Vx_Battle_ShenHai_Tentacle_Red_Close"
  }
}

function TentacleItem:ctor(uiNode, role, index)
  Super.ctor(self)
  self.ui = UI_Battle_TentacleResource(uiNode)
  self.role = role
  self.index = index
  self.slotUIAnimCtr = self.ui.VX_Animation_Bg:GetComponent(typeof(UIAnimationController))
  self.tentacleAnimCtr = self.ui.VX_Tentacle_Animation_Bg:GetComponent(typeof(UIAnimationController))
  self.tentacleLoopAnimCtr = self.ui.UI_Vx_ShaihaiLoop:GetComponent(typeof(UIAnimationController))
  self.tentacleSkeleton = self.ui.SkeletonGraphic_Chushou:GetComponent(typeof(SkeletonGraphic))
  self.tentacleSlotBgMat = self.ui.Image_VX_Trangle_Bg:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material
  self.spineAnimationState = self.tentacleSkeleton.AnimationState
  self.isHaveTenacle = false
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
  self.OceanModel = bg.battleDataCenter:GetOceanModel()
end

function TentacleItem:OnBind(binder)
  self.binder = binder
  self:InitDefault()
  self:BindTips()
  self.spineAnimationState:Complete("+", System.fn(self, self.OnSkeletonAnimComplete))
  binder:BindToRaw(function(_, model)
    if self.OceanModel ~= model then
      self:TentacleModelAnimChange(model)
      self.OceanModel = model
    end
  end, function()
    do return bg.battleDataCenter.GetOceanModel end
    return bg.battleDataCenter.GetOceanModel, bg.battleDataCenter
  end)
end

function TentacleItem:BindTips()
  self.binder:BindButtonClick(self.ui.Btn_Click_Tentacle, function()
    if not bg.battlePanel then
      return
    end
    local battleRole = bg.battleScene:GetRole(self.role.uid)
    if not battleRole then
      return
    end
    AudioManager.Instance:PostSoundEvent("POPUP_CM_WND_INFO_ON")
    local tipsData = {
      title = LT.Text("Battle_Tips_TentacleName", true),
      desc = battleRole:GetSchoolTips(cd.SchoolId.Ocean),
      iconPath = battleRole:GetSchoolTipsIcon(cd.SchoolId.Ocean)
    }
    UIManager.Instance:Reopen(Urls.AlertIconToolBattleTipsPanel, tipsData, bg.battlePanel.ui.School_Effect_Tips_Node, true)
  end)
end

function TentacleItem:OnUnbind()
  Super.OnUnbind(self)
  FrameWaiter.RemoveWaiter(self.frameWaiterHandler)
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
  if not IsNil(self.tentacleLoopAnimCtr) then
    self.tentacleLoopAnimCtr:StopPlayableGraph()
    self.tentacleLoopAnimCtr = nil
  end
end

function TentacleItem:InitDefault()
  self.ui.Tentacle_Slot:SetActive(false)
  self.ui.Tentacle_Item:SetActive(false)
end

function TentacleItem:OnSkeletonAnimComplete()
  local animName = OceanSpineAnim[self.OceanModel].loop
  self.spineAnimationState:SetAnimation(0, animName, true)
end

function TentacleItem:OpenSlot(skipAnim)
  self.ui.Tentacle_Slot:SetActive(true)
  if not skipAnim then
    self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Open")
  end
  self.binder:StopTimer(self._closeSlotTimer)
end

function TentacleItem:CloseSlot(callback)
  self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Close")
  self.binder:StopTimer(self._closeSlotTimer)
  self._closeSlotTimer = self.binder:BindTimer(0.7, 0, nil, function()
    self.ui.Tentacle_Slot:SetActive(false)
    if callback then
      callback()
    end
  end)
end

function TentacleItem:SlotReset()
  self.slotUIAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Rabbet_01_Reset")
end

function TentacleItem:CreateTentacle(skipAnim)
  if self.isHaveTenacle then
    return
  end
  self.OceanModel = bg.battleDataCenter:GetOceanModel()
  self.isHaveTenacle = true
  self.ui.Tentacle_Item:SetActive(true)
  self:ShowTentacleAttrBg()
  if skipAnim then
    local loopAnim = OceanSpineAnim[self.OceanModel] and OceanSpineAnim[self.OceanModel].loop
    if loopAnim then
      self.spineAnimationState:SetAnimation(0, loopAnim, true)
    end
    if self.ui and self.ui.UI_Vx_ShaihaiLoop then
      self.ui.UI_Vx_ShaihaiLoop:SetActive(1 == self.index and not bg.isPVP and self.OceanModel == BattleConst.OceanModel.OceanModel1)
    end
  else
    self:PlaySpineAnim(self.OceanModel, "fadein", false)
    self:PlayTentacleModelAnim(self.OceanModel, "open")
  end
end

function TentacleItem:ClearTentacle(callback)
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
  self:PlaySpineAnim(self.OceanModel, "fadeout", false)
  self:TentacleModelAnimChange(self.OceanModel, "close")
end

function TentacleItem:UpdateTentacle()
  if not self.isHaveTenacle then
    return
  end
  self.tentacleAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Tentacle_01_Up")
  self:PlaySpineAnim(self.OceanModel, "up", false)
end

function TentacleItem:SetTentacleDamage(damage, isFrist, damageShow)
  self:ShowDamageText(isFrist)
  local count = self.role:GetTentacleAttackCount() or 1
  local totalDamage = damage * count
  local damageDesc = damageShow or damage
  if count > 1 then
    damageDesc = LT.Text(string.format("%s<size=24> x %s</size>", damageShow or damage, count))
  end
  self.binder:SetText(self.ui.TotalDamageText, LT.Text(string.format("<size=20>(</size>%s<size=20>)</size>", totalDamage)))
  self.binder:SetText(self.ui.DamageText, damageDesc)
end

function TentacleItem:PlaySpineAnim(model, animName, isLoop)
  if OceanSpineAnim[model][animName] then
    self.spineAnimationState:SetAnimation(0, OceanSpineAnim[model][animName], isLoop)
  else
    self.spineAnimationState:SetAnimation(0, animName, isLoop)
  end
end

function TentacleItem:PlayAppearEffect()
  local effectAsset = self.binder:LoadAsset(CommonRes.TentacleAppearPrefab)
  local effectGo = self.binder:Instantiate(effectAsset, self.ui.uiNode.transform)
  effectGo:SetActive(true)
end

function TentacleItem:PlayTentacleModelAnim(model, animName)
  if self.ui == nil then
    return
  end
  if model == BattleConst.OceanModel.OceanModel1 and 1 == self.index and not bg.isPVP then
    if self.isHaveTenacle == true then
      self.ui.UI_Vx_ShaihaiLoop:SetActive(true)
      self.tentacleLoopAnimCtr:PlayState("UI_Vx_Battle_ShenHai_Tentacle_Blue_Loop")
    end
  else
    self.ui.UI_Vx_ShaihaiLoop:SetActive(false)
  end
  if self.index > self.role:GetTentacleFixedCount() then
    model = "default"
  end
  if TentacleModelAnim[model][animName] and self.isHaveTenacle == true then
    self.tentacleLoopAnimCtr:StopPlayableGraph()
    self.tentacleAnimCtr:PlayState(TentacleModelAnim[model][animName])
  end
end

function TentacleItem:TentacleModelAnimChange(model)
  self:PlaySpineAnim(self.OceanModel, "fadeout", false)
  self:PlayTentacleModelAnim(self.OceanModel, "close")
  self.OceanModel = model
  if self.frameWaiterHandler then
    FrameWaiter.RemoveWaiter(self.frameWaiterHandler)
    self.frameWaiterHandler = nil
  end
  self.frameWaiterHandler = FrameWaiter.OnNextFrame(function()
    self.frameWaiterHandler = nil
    if not self.ui or IsNil(self.ui.UI_Vx_ShaihaiLoop) then
      return
    end
    self:PlaySpineAnim(self.OceanModel, "fadein", false)
    self:PlayTentacleModelAnim(self.OceanModel, "open")
  end, 2)
end

function TentacleItem:ShowDamageText(isShow)
  local count = self.role:GetTentacleAttackCount()
  self.ui.DamageText:SetActive(isShow)
  self.ui.TotalDamageText:SetActive(isShow and count > 1)
end

function TentacleItem:ShowTentacleAttrBg()
  if self.index > self.role:GetTentacleFixedCount() then
    self:SetTentacleMat(CommonRes.TentacleSlotBg.BoutTentacle)
    return
  end
  self:SetTentacleMat(CommonRes.TentacleSlotBg.BattleTentacle)
end

function TentacleItem:SetTentacleMat(tentacleAttr)
  self.tentacleSlotBg = ResLoadMgr.LoadAsset(tentacleAttr, self, CsTexture2D)
  self.tentacleSlotBgMat:SetTexture("_MainTex", self.tentacleSlotBg)
end

function TentacleItem:UpdateTentacleInfo(newIndex)
  if self.index ~= newIndex then
    self.index = newIndex
    self.ui.uiNode.transform:SetSiblingIndex(newIndex - 2)
  end
  local skipEnterAnim = bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim()
  self:CreateTentacle(skipEnterAnim)
end

return TentacleItem
