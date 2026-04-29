_class("UICollectCardReceive", UIController)
UICollectCardReceive = UICollectCardReceive

function UICollectCardReceive:LoadDataOnEnter(TT, res, uiParams)
  self._cardCom = uiParams[3]
  self._cardCom:HandleClearSendCardInfoReq(TT, res)
  if res and res:GetSucc() then
    local result = res:GetResult()
    Log.error("###[UICollectCardReceive] HandleClearSendCardInfoReq fail,result:", result)
  end
end

function UICollectCardReceive:OnShow(uiParams)
  self._cards = uiParams[1]
  self._cb = uiParams[2]
  self:GetComponents()
  self:OnValue()
end

function UICollectCardReceive:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._ScrollRect = self:GetUIComponent("Transform", "Pool").parent.parent.gameObject:GetComponent("ScrollRect")
end

function UICollectCardReceive:OnValue()
  self:SetPool()
end

function UICollectCardReceive:SetPool()
  self._pool:SpawnObjects("UICollectCardReceiveItem", #self._cards)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._cards do
    local item = pools[i]
    local info = self._cards[i]
    item:SetData(i, info)
  end
  self._ScrollRect.enabled = #self._cards > 15
end

function UICollectCardReceive:BtnOnClick(go)
  self:CloseDialog()
end

function UICollectCardReceive:OnHide()
  if self._cb then
    self._cb()
  end
end
