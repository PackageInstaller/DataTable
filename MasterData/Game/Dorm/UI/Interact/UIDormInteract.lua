local UIDormInteract = class("UIDormInteract", UIBaseWindow)
local base = UIBaseWindow
local UINDormInteractItem = require("Game.Dorm.UI.Interact.UINDormInteractItem")
local cs_Tweening = CS.DG.Tweening
local cs_Ease = cs_Tweening.Ease
local cs_DoTween = cs_Tweening.DOTween

function UIDormInteract:OnInit()
  self.interactList = UIItemPool.New(UINDormInteractItem, self.ui.interactItem)
  self.ui.interactItem:SetActive(false)
  self._resLoader = CS.ResLoader.Create()
  local iconPath = PathConsts:GetSpriteAtlasPath("UI_DormRoom")
  self._iconAtlas = self._resLoader:LoadABAsset(iconPath)
end

function UIDormInteract:UpdateInteractList(interActionList)
  self.interactList:HideAll()
  for _, interAction in pairs(interActionList) do
    local interactItem = self.interactList:GetOne()
    interactItem:InitInteractActionItem(interAction, self._iconAtlas)
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
  end
  self._listCount = #interActionList
end

function UIDormInteract:HideInteractList()
  self.interactList:HideAll()
end

function UIDormInteract:OnDelete()
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

return UIDormInteract
