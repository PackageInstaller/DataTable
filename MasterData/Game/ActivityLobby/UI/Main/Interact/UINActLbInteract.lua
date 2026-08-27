local base = UIBaseNode
local UINActLbInteract = class("UINActLbInteract", base)
local UINActLbInteractItem = require("Game.ActivityLobby.UI.Main.Interact.UINActLbInteractItem")
local cs_Tweening = CS.DG.Tweening
local cs_Ease = cs_Tweening.Ease
local cs_DoTween = cs_Tweening.DOTween

function UINActLbInteract:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._interactList = UIItemPool.New(UINActLbInteractItem, self.ui.intractItem, false)
  self._resLoader = CS.ResLoader.Create()
  local atlasPath = PathConsts:GetSpriteAtlasPath("UI_ActivityLobbyMain")
  self._iconAtlas = self._resLoader:LoadABAsset(atlasPath)
end

function UINActLbInteract:UpdateLbInteractList(interActionList)
  self._interactList:HideAll()
  for _, interAction in pairs(interActionList) do
    local interactItem = self._interactList:GetOne()
    interactItem:InitActLbInteractItem(interAction, self._iconAtlas)
    interactItem.gameObject.name = "interactItem_" .. tostring(interAction:GetLbIntrctActionId())
  end
  if self._listCount == #interActionList then
    return
  end
  if #interActionList ~= 0 then
    if self._listSeq ~= nil then
      self._listSeq:Restart()
    else
      self.ui.fade_List.transform.localScale = Vector3.one
      self.ui.fade_List.alpha = 1
      local listSeq = cs_DoTween.Sequence()
      listSeq:Append(self.ui.fade_List.transform:DOScale(Vector3.New(0.98, 0.98, 1), 0.95):From():SetEase(cs_Ease.OutElastic))
      listSeq:Join(self.ui.fade_List:DOFade(0.6, 0.25):From())
      listSeq:SetAutoKill(false)
      self._listSeq = listSeq
    end
    AudioManager:PlayAudioById(1275)
  end
  self._listCount = #interActionList
end

function UINActLbInteract:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self._listSeq ~= nil then
    self._listSeq:Kill()
    self._listSeq = nil
  end
  base.OnDelete(self)
end

return UINActLbInteract
