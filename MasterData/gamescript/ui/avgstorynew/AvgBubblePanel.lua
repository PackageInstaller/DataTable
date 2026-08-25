local table_remove = table.remove
local table_insert = table.insert
local initInterval = 1.5
local updateShowSec = 2
local fadeOutSec = 0.8
local fadeInSec = 0.2
local CanvasGroup = CS.UnityEngine.CanvasGroup
local RectTransform = CS.UnityEngine.RectTransform
local battleFadeOutSubTime = 0.5
local battleStaySubTime = 0.2
local AvgBubblePanel, Super = System.NewClass("AvgBubblePanel", UIBasePanel)
AvgBubblePanel.uiResCls = UI_Dbgcopy_Item_AvgBubbleResource

function AvgBubblePanel:ctor(storyId, chatIndex, startBubbleTime)
  Super.ctor(self)
  self.storyId = storyId
  self.chatIndex = chatIndex
  self.tBubbleDatas = nil
  self.showTipsTimer = nil
  self.speed = 10
  self.tBubbleComs = {}
  self.itemheight = nil
  self.startBubbleTime = startBubbleTime
  self.totalShowCnt = 1
end

function AvgBubblePanel:OnBind(binder)
  self.binder = binder
  self.avgModel = binder:createModel(AvgDialogModel, self.storyId, self.chatIndex)
  self:ShowDialogText()
end

function AvgBubblePanel:ShowDialogText()
  self.tBubbleDatas = self.avgModel:GetBubbleItemDatas()
  local delaytime = self.startBubbleTime ~= nil and self.startBubbleTime or 0.3
  self.binder:BindTimer(delaytime, 0, nil, System.fn(self, self.InitBubbleItems))
end

function AvgBubblePanel:InitBubbleItems()
  local dataCnt = #self.tBubbleDatas
  local initCnt = dataCnt >= self.totalShowCnt and self.totalShowCnt or dataCnt
  if dataCnt <= 0 then
    return
  end
  for i = 1, initCnt do
    self.binder:BindTimer(initInterval * (i - 1), 0, nil, System.fn(self, self.CreateBubbleItem))
  end
  self.binder:BindTimer(initInterval * (initCnt - 1), 0, nil, System.fn(self, self.UpdateStart))
end

function AvgBubblePanel:UpdateStart()
  local updateTick = DataCenter.barrierData.InBattle and updateShowSec - battleStaySubTime or updateShowSec
  self.showTipsTimer = self.binder:BindTimer(updateTick, -1, System.fn(self, self.UpdateShow))
end

function AvgBubblePanel:CreateBubbleItem()
  local itemData = table_remove(self.tBubbleDatas, 1)
  local itemCom = self.binder:BindNewComponent(self.ui.LayoutGroup, AvgBubbleItem, Group_AvgBubbleResource, self.speed, itemData)
  local canvasGroup = itemCom.ui.uiNode:GetComponent(typeof(CanvasGroup))
  canvasGroup.alpha = 0
  canvasGroup:DOFade(1, fadeInSec)
  table_insert(self.tBubbleComs, itemCom)
end

function AvgBubblePanel:UpdateShow()
  if #self.tBubbleComs <= 0 then
    self:StopShowTipsTimer()
    return
  end
  local bubbleItem = table_remove(self.tBubbleComs, 1)
  if self.itemheight == nil then
    local rectTransform = bubbleItem.ui.uiNode:GetComponent(typeof(RectTransform))
    self.itemheight = rectTransform.sizeDelta.y
  end
  local layoutTrans = self.ui.LayoutGroup.transform
  local canvasGroup = bubbleItem.ui.uiNode:GetComponent(typeof(CanvasGroup))
  local sec = DataCenter.barrierData.InBattle and fadeOutSec - battleFadeOutSubTime or fadeOutSec
  layoutTrans:DOLocalMoveY(layoutTrans.localPosition.y + self.itemheight, sec)
  canvasGroup:DOFade(0, sec):OnComplete(System.fn(self, self.FinishTween))
end

function AvgBubblePanel:FinishTween()
  if #self.tBubbleDatas > 0 then
    self:CreateBubbleItem()
  end
  if #self.tBubbleComs <= 0 then
    self:Close()
  end
end

function AvgBubblePanel:StopShowTipsTimer()
  if self.showTipsTimer ~= nil then
    self.binder:StopTimer(self.showTipsTimer)
    self.showTipsTimer = nil
  end
end

return AvgBubblePanel
