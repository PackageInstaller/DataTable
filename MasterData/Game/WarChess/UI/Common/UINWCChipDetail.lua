local base = require("Game.CommonUI.Chip.UINBaseChipDetail")
local UINWCChipDetail = class("UINWCChipDetail", base)
local cs_Ui3DModifier = CS.UGUIExtend.Ui3DModifier
local cs_PropertyNameHash = CS.UGUIExtend.Ui3DModifier.propertyNameHash
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UINWCChipDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.OnInit(self)
  self.defaultChipSize = Vector3.New(self.ui.v_Scale, self.ui.v_Scale, self.ui.v_Scale)
  self._selected = true
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self._OnBtnWCChipSelected)
  if not IsNull(self.ui.root) then
    self._defaultRootPos = self.ui.root.localPosition
    self._refreshRootPos = Vector3.New(self._defaultRootPos.x, self._defaultRootPos.y + 60, self._defaultRootPos.z)
  end
  self.effPrefabDic = {}
  local isHave3DModify = not IsNull(self.gameObject:GetComponentInParent(typeof(cs_Ui3DModifier)))
  self.dissolveMat = CS.UnityEngine.Object.Instantiate(self.ui.Mat_fXMImage)
  self.initDissolveMat = true
  if isHave3DModify and self.initDissolveMat and not IsNull(self.ui.modifier.material) then
    local matrix = self.ui.modifier.material:GetMatrix(cs_PropertyNameHash)
    self.dissolveMat:SetMatrix(cs_PropertyNameHash, matrix)
    self.initDissolveMat = false
  end
  for i = 1, #self.ui.Img_ButtomList do
    local image = self.ui.Img_ButtomList[i]
    if not IsNull(image) then
      image.material = self.dissolveMat
    end
  end
  self.ui.Obj_discard:SetActive(false)
  base.SetBaseBackground(self, self.ui.Fad_Item.transform)
  self:SetIsSellOutActive(false)
end

function UINWCChipDetail:InitWCChipDetail(index, chipData, resloader, selectEvent, isNeedPrice)
  base.InitBaseChipDetail(self, index, chipData, nil, resloader)
  self._selectEvent = selectEvent
  if isNeedPrice then
    self.price = chipData:GetChipBuyPriceForWarChess()
  end
end

function UINWCChipDetail:GetWCChipDetailPanelData()
  return self._chipData
end

function UINWCChipDetail:SetWCChipSelectState(selected, time)
  local tweenTime = time == nil and 0 or 0.3
  if self._selected == selected then
    return
  end
  self._selected = selected
  self.ui.tex_Description.raycastTarget = selected and true or false
  self.ui.img_unSelected:DOFade(self._selected and 0 or 0.4, tweenTime):SetEase(cs_Ease.OutQuad)
  if self._selected then
    self.transform:DOScale(Vector3.New(1, 1, 1), tweenTime):SetEase(cs_Ease.OutQuad)
  else
    self.transform:DOScale(self.defaultChipSize, tweenTime):SetEase(cs_Ease.OutQuad)
  end
end

function UINWCChipDetail:InitWCChipSelectState()
  self._selected = false
  self.ui.tex_Description.raycastTarget = false
  self.ui.img_unSelected.gameObject:SetActive(true)
  self.ui.img_unSelected.color = Color.New(0, 0, 0, 0)
  self.transform.localScale = self.defaultChipSize
end

function UINWCChipDetail:SetIsSellOutActive(bActive)
  if self.ui.obj_isSellout ~= nil and self.ui.obj_isSellout.activeSelf ~= bActive then
    self.ui.obj_isSellout:SetActive(bActive)
  end
end

function UINWCChipDetail:_OnBtnWCChipSelected()
  if self._selectEvent ~= nil then
    self._selectEvent(self, self._chipData)
  end
end

function UINWCChipDetail:ShowWCChipDetailEff(xRotate)
  if self.effItemData ~= nil then
    self.effItemData.go:SetActive(false)
    self.effItemData.eff:Stop()
  end
  if not self.level:HasFlashTween() then
    return
  end
  local quality = self._chipData:GetQuality()
  local path = ChipDetailEffPatch[quality]
  local effItemData = self.effPrefabDic[quality]
  if effItemData ~= nil then
    effItemData.eff:Play()
    effItemData.go:SetActive(true)
    self.effItemData = effItemData
    return
  end
  self._resloader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    if self.ui == nil then
      return
    end
    if self.ui.tran_EffHolder == nil or IsNull(self.ui.tran_EffHolder.gameObject) then
      return
    end
    effItemData = {}
    local go = prefab:Instantiate(self.ui.tran_EffHolder)
    local particleSystem = go:GetComponentInChildren(typeof(CS.UnityEngine.ParticleSystem))
    particleSystem:Stop()
    go.transform:Rotate(Vector3.New(xRotate or 0, 0, 0))
    particleSystem:Play()
    effItemData.go = go
    effItemData.eff = particleSystem
    self.effPrefabDic[quality] = effItemData
    self.effItemData = effItemData
  end)
end

function UINWCChipDetail:OnDissolveTweenCompleteAction(Action)
  self.onDissolveTweenComplete = Action
end

function UINWCChipDetail:PlayDissolveTween()
  self:InitDissolveTweenSetting()
  if self.dissolveSeq ~= nil then
    self.dissolveSeq:Restart()
    return
  end
  local dissolveSeq = cs_DoTween.Sequence()
  dissolveSeq:SetAutoKill(false)
  dissolveSeq:SetLink(self.gameObject)
  dissolveSeq:InsertCallback(0, function()
    self.dissolveMat:DOFloat(0, "_add", 0.35):SetLink(self.gameObject)
    self.dissolveMat:DOFloat(0.36, "_DissolutionAlpha", 0.35):SetLink(self.gameObject)
  end)
  dissolveSeq:AppendInterval(0.35)
  dissolveSeq:AppendCallback(function()
    self.dissolveMat:DOFloat(0.5, "_add", 0.35):SetLink(self.gameObject)
    self.dissolveMat:DOFloat(0, "_DissolutionAlpha", 0.35):SetLink(self.gameObject)
    self.ui.Fad_Item:DOFade(0, 0.35):SetLink(self.gameObject)
    self.ui.Obj_discard:SetActive(true)
  end)
  dissolveSeq:AppendInterval(self.ui.Ani_discard.clip.length)
  dissolveSeq:OnComplete(function()
    self.ui.Obj_discard:SetActive(false)
    if self.onDissolveTweenComplete ~= nil then
      self.onDissolveTweenComplete(self.index)
    end
  end)
  self.dissolveSeq = dissolveSeq
end

function UINWCChipDetail:InitDissolveTweenSetting()
  self.ui.Obj_discard:SetActive(false)
  self.ui.Fad_Item:DOKill()
  self.ui.Fad_Item.alpha = 1
  self.dissolveMat:DOKill()
  self.dissolveMat:SetFloat("_add", 1)
  self.dissolveMat:SetFloat("_DissolutionAlpha", 0)
end

function UINWCChipDetail:UnSelectAlpha(boolean)
end

function UINWCChipDetail:SetSelectAnima(active)
end

function UINWCChipDetail:KillDOTween()
  self.ui.img_unSelected:DOKill()
  self.transform:DOKill()
end

function UINWCChipDetail:OnHide()
  base.OnHide(self)
end

function UINWCChipDetail:OnDelete()
  self:KillDOTween()
  base.OnDelete(self)
end

return UINWCChipDetail
