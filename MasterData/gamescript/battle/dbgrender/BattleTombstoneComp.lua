local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject
local GameObjectUtil = CS.Framework.GameObjectUtil
local SkeletonAnimation = CS.Spine.Unity.SkeletonAnimation
local BattleTombstoneComp, Super = System.NewClass("BattleTombstoneComp", BattleComponent)

function BattleTombstoneComp:ctor(entity, parentNode)
  Super.ctor(self, entity)
  self.binder = bg.battleScene:GetChildBinder()
  local tombstonePrefab = self.binder:LoadAsset(bc.TombstonePrefab)
  self.tombstone = self.binder:Instantiate(tombstonePrefab, bg.battleScene.sceneLayer)
  self.tombstone.transform:SetParent(parentNode.transform)
  self.tombstone.transform.localPosition = Vector3(0, 0, 0)
  self.tombstone:SetActive(false)
  local spineGO = GameObjectUtil.DeepFindChild(self.tombstone.transform, "Phase_1").gameObject
  self.tombAnimState = spineGO:GetComponent(typeof(SkeletonAnimation)).AnimationState
end

function BattleTombstoneComp:Appear()
  self.tombstone:SetActive(true)
  self:_StopTimeline()
  self:_PlayTimeline()
end

function BattleTombstoneComp:Show()
  self.tombstone:SetActive(true)
end

function BattleTombstoneComp:Hide()
  self.tombstone:SetActive(false)
  self:_StopTimeline()
end

function BattleTombstoneComp:_StopTimeline()
  if self.tombstoneTL then
    self.tombstoneTL:Stop()
    self.tombstoneTL = nil
  end
end

function BattleTombstoneComp:_PlayTimeline()
  if not self.tombstoneTL then
    local childCount = self.tombstone.transform.childCount
    for i = 0, childCount - 1 do
      local child = self.tombstone.transform:GetChild(i)
      child.gameObject:SetActive(false)
    end
    self.tombstoneTL = BattleTimeline.Get(bc.TombstoneTimeline)
    self.tombstoneTL:SetSpeed(1):Play(self.tombstone, 0, 0, function()
      self.tombAnimState:SetAnimation(0, "Idle", true)
    end)
  end
end

function BattleTombstoneComp:Dispose()
  self:_StopTimeline()
  if self.binder then
    self.binder:teardown()
  end
  if self.tombstone then
    GameObject.Destroy(self.tombstone)
  end
  self.tombAnimState = nil
  self.tombstone = nil
  self.binder = nil
end

return BattleTombstoneComp
