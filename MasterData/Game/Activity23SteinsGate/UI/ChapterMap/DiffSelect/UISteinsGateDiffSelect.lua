local base = UIBaseWindow
local UISteinsGateDiffSelect = class("UISteinsGateDiffSelect", base)
local CS_DOTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local cs_LoopType = CS.DG.Tweening.LoopType
local UINSteinsGateDiffSelectItem = require("Game.Activity23SteinsGate.UI.ChapterMap.DiffSelect.UINSteinsGateDiffSelectItem")

function UISteinsGateDiffSelect:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__ClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnCloseFunc)
  self.diffItemPool = UIItemPool.New(UINSteinsGateDiffSelectItem, self.ui.btn_DiffSwitch, false)
  self.__onItemClick = BindCallback(self, self.__OnItemClick)
end

function UISteinsGateDiffSelect:InitSteinsGateDiffSelect(curDiffIndex, diffCfgList, confirmCallback)
  self.curDiffIndex = curDiffIndex
  self.confirmCallback = confirmCallback
  self.diffCfgList = diffCfgList
  self:__RefreshDiffItem()
  self:__PlayEnterTween()
end

function UISteinsGateDiffSelect:__RefreshDiffItem()
  self.diff2ItemDic = {}
  self.diffItemPool:HideAll()
  for _, diffCfg in ipairs(self.diffCfgList) do
    local diffIndex = diffCfg.difficulty_id
    local item = self.diffItemPool:GetOne(true)
    item:InitSteinsGateDiffSelectItem(diffCfg, self.__onItemClick)
    self.diff2ItemDic[diffIndex] = item
    if diffIndex == self.curDiffIndex then
      self:__SetItemSelected(item)
    end
  end
end

function UISteinsGateDiffSelect:__SetItemSelected(item)
  self.ui.obj_Selected:SetActive(true)
  self.ui.obj_Selected.transform:SetParent(item.transform)
  self.ui.obj_Selected.transform.anchoredPosition = Vector2.zero
  self:SteinsGateDiffSelectAnim(0)
end

function UISteinsGateDiffSelect:__OnItemClick(diffIndex)
  self.curDiffIndex = diffIndex
  local item = self.diff2ItemDic[diffIndex]
  self:__SetItemSelected(item)
end

function UISteinsGateDiffSelect:SteinsGateDiffSelectAnim(delayTime)
  self:__StopSelectAnim()
  if delayTime == nil then
    delayTime = 0
  end
  self.ui.anim_SelectedCircle:DOFade(0, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedCircle.transform:DOScale(1.3, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_SelectedArrow:DOFade(0, 0.25):From():SetDelay(delayTime + 0.2):SetLink(self.gameObject)
  self.__SelectedArrowAnim = self.ui.anim_SelectedArrow.transform:DOLocalMove(Vector3.New(130, 231, 0), 0.4):SetDelay(delayTime + 0.2):SetLink(self.gameObject):SetLoops(-1, cs_LoopType.Yoyo):SetEase(cs_Ease.OutQuart)
end

function UISteinsGateDiffSelect:__StopSelectAnim()
  self.ui.anim_SelectedCircle:DOComplete()
  self.ui.anim_SelectedCircle.transform:DOComplete()
  self.ui.anim_SelectedArrow:DOComplete()
  if self.__SelectedArrowAnim ~= nil then
    self.__SelectedArrowAnim:Rewind()
    self.__SelectedArrowAnim:Kill()
    self.__SelectedArrowAnim = nil
  end
end

function UISteinsGateDiffSelect:__ClickConfirm()
  if self.confirmCallback ~= nil then
    self.confirmCallback(self.curDiffIndex)
  end
  UIUtil.OnClickBackByWinId(UIWindowTypeID.UISteinsGateDiffSelect)
end

function UISteinsGateDiffSelect:__OnCloseFunc()
  UIUtil.OnClickBackByUiTab(self)
end

function UISteinsGateDiffSelect:__PlayEnterTween()
  local sequence = CS_DOTween.Sequence():Append(self.ui.cg_Total:DOFade(0, 0.1):From()):AppendInterval(0.3):Append(self.ui.cg_holder:DOFade(0, 0.35):From()):Join(self.ui.btn_Confirm.transform:DOAnchorPosY(-406, 0.5):From()):Join(self.ui.List:DOAnchorPosY(-85, 0.5):From()):Join(self.ui.DesBg:DOAnchorPosY(-73, 0.5):From()):Join(self.ui.Title:DOAnchorPosY(50, 0.5):From()):SetLink(self.gameObject)
end

function UISteinsGateDiffSelect:OnDelete()
  self:__StopSelectAnim()
  base.OnDelete(self)
end

return UISteinsGateDiffSelect
