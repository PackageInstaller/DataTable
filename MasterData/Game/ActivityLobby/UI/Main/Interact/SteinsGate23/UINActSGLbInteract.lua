local base = UIBaseNode
local UINActSGLbInteract = class("UINActSGLbInteract", base)
local UINActLbInteractItem = require("Game.ActivityLobby.UI.Main.Interact.SteinsGate23.UINActSGLbInteractItem")
local cs_Tweening = CS.DG.Tweening
local cs_Ease = cs_Tweening.Ease
local cs_DoTween = cs_Tweening.DOTween

function UINActSGLbInteract:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._interactList = UIItemPool.New(UINActLbInteractItem, self.ui.intractItem, false)
  self._resLoader = CS.ResLoader.Create()
end

function UINActSGLbInteract:UpdateLbInteractList(interActionList)
  self._interactList:HideAll()
  local needPlayAudio = false
  for _, interAction in pairs(interActionList) do
    local interactItem = self._interactList:GetOne()
    interactItem:InitActLbInteractItem(interAction)
    interactItem.gameObject.name = "interactItem_" .. tostring(interAction:GetLbIntrctActionId())
    needPlayAudio = interactItem.gameObject.activeSelf == true and true or needPlayAudio
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
      listSeq:Append(self.ui.fade_List.transform:DOScale(Vector3.New(1, 0, 1), 0.2):From():SetEase(cs_Ease.OutQuart))
      listSeq:Join(self.ui.fade_List.transform:DOLocalMoveX(-10, 0.2):From())
      listSeq:Join(self.ui.fade_List:DOFade(0.6, 0.2):From())
      for i, interactItem in ipairs(self._interactList.listItem) do
        local tex = interactItem:GetInteractTexDes()
        listSeq:Join(tex.transform:DOLocalMoveX(-5, 0.25):From())
      end
      listSeq:SetAutoKill(false)
      self._listSeq = listSeq
    end
    if needPlayAudio then
      AudioManager:PlayAudioById(1275)
    end
  end
  self._listCount = #interActionList
end

function UINActSGLbInteract:OnDelete()
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

return UINActSGLbInteract
