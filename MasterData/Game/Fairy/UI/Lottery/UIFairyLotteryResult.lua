local UIFairyLotteryResult = class("UIFairyLotteryResult", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINFairyLotteryFairyItem = require("Game.Fairy.UI.Lottery.UINFairyLotteryFairyItem")
local UINFairyLotteryNormalItem = require("Game.Fairy.UI.Lottery.UINFairyLotteryNormalItem")
local cs_Ease = CS.DG.Tweening.Ease
local cs_DoTween = CS.DG.Tweening.DOTween

function UIFairyLotteryResult:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickClose)
  self.fairyItemPool = UIItemPool.New(UINFairyLotteryFairyItem, self.ui.go_fairy, false)
  self.normalItemPool = UIItemPool.New(UINFairyLotteryNormalItem, self.ui.go_item, false)
  self.resloader = cs_ResLoader.Create()
end

function UIFairyLotteryResult:InitFairyLotteryResult(rewardList, index2fairyDataDic, callback)
  self.callback = callback
  local isMult = 1 < #rewardList
  local deplay
  local sequence = cs_DoTween.Sequence()
  self.fairyItemPool:HideAll()
  self.normalItemPool:HideAll()
  for index, rewardMsg in ipairs(rewardList) do
    local fairyData = index2fairyDataDic[index]
    local item
    if fairyData ~= nil then
      item = self.fairyItemPool:GetOne(true)
      item:InitFLFairyItem(fairyData, self.resloader)
    else
      item = self.normalItemPool:GetOne(true)
      item:InitFLNormalItem(rewardMsg.item, rewardMsg.num)
    end
    if isMult then
      if index <= 5 then
        deplay = (index - 1) * 0.1
        item.transform:SetParent(self.ui.heroList_Up)
        sequence:Insert(0, item.ui.root.transform:DOLocalMoveY(50, 1):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(deplay))
      else
        item.transform:SetParent(self.ui.heroList_Low)
        deplay = (10 - index) * 0.1
        sequence:Insert(0, item.ui.root.transform:DOLocalMoveY(-50, 1):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(deplay))
      end
      sequence:Insert(0, item.ui.root:DOFade(0, 1):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(deplay))
    else
      item.transform:SetParent(self.ui.obj_isOne)
      sequence:Insert(0, item.ui.root.transform:DOLocalMoveY(50, 1):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject))
      sequence:Insert(0, item.ui.root:DOFade(0, 1):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject))
    end
  end
  self.showSeq = sequence
  NoticeManager:ContinueShowNotice("lottery")
end

function UIFairyLotteryResult:__OnClickClose()
  UIUtil.OnClickBackByWinId(UIWindowTypeID.FairyLotteryResult)
end

function UIFairyLotteryResult:OnDelete()
  if self.showSeq ~= nil then
    self.showSeq:Kill()
    self.showSeq = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  if self.callback ~= nil then
    self.callback()
  end
  base.OnDelete(self)
end

return UIFairyLotteryResult
