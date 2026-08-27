local base = require("Game.ActivityLobby.Entity.Interact.LbInteractEntityBase")
local LbIntrctHeroEntity = class("LbIntrctHeroEntity", base)

function LbIntrctHeroEntity:ctor()
end

function LbIntrctHeroEntity:InitLbInteractEntityGo()
  base.InitLbInteractEntityGo(self)
  if IsNull(self.gameObject) then
    return
  end
  self.animator = self.gameObject:FindComponent(eUnityComponentID.Animator)
  self._characterUnit = self.gameObject:GetComponent(typeof(CS.CharacterUnit))
  if IsNull(self._characterUnit) then
    error("cant get CharacterUnit on character, obj:" .. self.gameObject.name)
  end
end

function LbIntrctHeroEntity:LbHAnimatorCrossFade(aniName, transTime)
  transTime = transTime or 0.25
  self.animator:CrossFadeInFixedTime(aniName, transTime)
end

function LbIntrctHeroEntity:HideLbEnttRenderer(hide)
  if IsNull(self._characterUnit) then
    return
  end
  if self._renderList == nil then
    self._renderList = {}
    for i = 0, self._characterUnit.smrArray.Length - 1 do
      table.insert(self._renderList, self._characterUnit.smrArray[i])
    end
    for i = 0, self._characterUnit.extraRendererArray.Length - 1 do
      table.insert(self._renderList, self._characterUnit.extraRendererArray[i])
    end
  end
  for k, renderer in ipairs(self._renderList) do
    renderer.gameObject:SetActive(not hide)
  end
end

return LbIntrctHeroEntity
