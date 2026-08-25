local Record_Container_Width_6 = 635.5
local Record_Container_Width_5 = 509.5
local Record_Container_PosX_6 = -606
local Record_Container_PosX_5 = -543
local Instantiate = CS.UnityEngine.Object.Instantiate
local Vector3 = CS.UnityEngine.Vector3
local PvPCardRecordComp, Super = System.NewComponent("PvPCardRecordComp")

function PvPCardRecordComp:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Pvp_Panel_BattleResource(uiNode)
  self.histItems = {}
  self.baseGo = self.ui.UI_Pvp_Item_Avatar
  self.baseGo:SetActive(false)
  self.histCount = 0
  self.histItemWidth = self.baseGo.transform.sizeDelta.x
  self.histItemHeight = self.baseGo.transform.sizeDelta.y
  self.container = self.ui.ScrollView_Recording
  self.waitInsertDataList = {}
end

function PvPCardRecordComp:OnBind(binder)
  self.binder = binder
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.InsertHistory, self.OnInsertHistory, self)
  self:_InitContainerRT()
end

function PvPCardRecordComp:_InitContainerRT()
  local showCount = bg.battleDataCenter:GetShowHistoryNum()
  local targetPosX = 6 == showCount and Record_Container_PosX_6 or Record_Container_PosX_5
  local targetWidth = 6 == showCount and Record_Container_Width_6 or Record_Container_Width_5
  CS.Framework.TransformUtil.SetLocalPos(self.ui.Image_Recording.transform, targetPosX, self.ui.Image_Recording.transform.localPosition.y, 0)
  CS.Framework.TransformUtil.SetWidth(self.ui.Image_Recording.transform, targetWidth)
end

function PvPCardRecordComp:OnUnbind()
  Super.OnUnbind(self)
  if bg.battleRender then
    if bg.battleRender.eventMgr then
      bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
    end
    bg.battleRender:UnperformWithAllDelaysByTarget(self)
  end
end

function PvPCardRecordComp:OnInsertHistory(data)
  if self.isInspectCard then
    table.insert(self.waitInsertDataList, data)
    return
  end
  self.histCount = self.histCount + 1
  if self.histCount > bg.battleDataCenter:GetShowHistoryNum() then
    local histItem = table.remove(self.histItems, 1)
    table.insert(self.histItems, histItem)
    histItem.data.value = data
    self:PlayInsertAnim(histItem, true)
    return
  end
  local gameObj
  if 0 == #self.histItems then
    gameObj = self.baseGo
  elseif #self.histItems < bg.battleDataCenter:GetShowHistoryNum() then
    gameObj = Instantiate(self.baseGo)
    gameObj.transform:SetParent(self.container.transform)
    gameObj.transform.localScale = Vector3.one
  end
  gameObj.transform.localPosition = Vector3((self.histCount - 1) * self.histItemWidth, 0, 0)
  local histItem = self.binder:BindComponent(BattleHistoryItem(gameObj, data, self))
  table.insert(self.histItems, histItem)
  self:PlayInsertAnim(histItem)
end

function PvPCardRecordComp:SetIsInspectCard(isInspectCard)
  self.isInspectCard = isInspectCard
  if not isInspectCard then
    self.binder:BindTimer(0.1, 0, nil, System.fn(self, self.ShowWaitList))
  end
end

function PvPCardRecordComp:ShowWaitList()
  if not self.isInspectCard then
    for _, data in ipairs(self.waitInsertDataList) do
      self:OnInsertHistory(data)
    end
    self.waitInsertDataList = {}
  end
end

function PvPCardRecordComp:PlayInsertAnim(histItem, isMoveForward)
  if not histItem.ui then
    return
  end
  local gameObj = histItem.ui.uiNode
  gameObj:SetActive(false)
  gameObj.transform.anchoredPosition3D = Vector3((self.histCount - 1) * self.histItemWidth, self.histItemHeight * 0.5, 0)
  if isMoveForward then
    self.container.transform:DOAnchorPosX((bg.battleDataCenter:GetShowHistoryNum() - self.histCount) * self.histItemWidth, 0.3):OnComplete(function()
      gameObj:SetActive(true)
      gameObj.transform:DOAnchorPosY(0, 0.3)
    end)
  else
    gameObj:SetActive(true)
    gameObj.transform:DOAnchorPosY(0, 0.3)
  end
end

return PvPCardRecordComp
