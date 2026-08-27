local UINOasisResOutput = class("UINOasisResOutput", UIBaseNode)
local base = UIBaseNode
local UINOasisResItem = require("Game.Oasis.UI.ResOutput.UINOasisResItem")

function UINOasisResOutput:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.uI_OasisBuildOutput:SetActive(false)
  self.resItemPool = UIItemPool.New(UINOasisResItem, self.ui.uI_OasisBuildOutput)
  self.resItemDic = {}
  self.mainCam = UIManager:GetMainCamera()
end

function UINOasisResOutput:InitOasisResOutput(oasisCtrl)
  self.oasisCtrl = oasisCtrl
end

function UINOasisResOutput:TryCreateOasisResItem(id, itemId)
  if self.resItemDic[id] ~= nil then
    return
  end
  local resItem = self.resItemPool:GetOne()
  resItem:InitOasisResItem(itemId, id, self.mainCam)
  resItem:PlayOasisResItemShowTween()
  self.resItemDic[id] = resItem
  self:UpdateOasisResPos(id)
end

function UINOasisResOutput:OasisResOutputLateUpdate()
  for buildId, resItem in pairs(self.resItemDic) do
    self:UpdateOasisResPos(buildId)
  end
end

function UINOasisResOutput:UpdateOasisResPos(id)
  local resItem = self.resItemDic[id]
  local buildItem = self.oasisCtrl:GetOasisBuildItemById(id)
  if resItem ~= nil and buildItem ~= nil then
    local position = buildItem:GetUIResPos()
    resItem:RefreshOasisResItemPos(position)
    if IsNull(self.mainCam) then
      return
    end
    local distance = Vector3.Distance(position, self.mainCam.transform.position)
    local t = 1 - (distance - self.ui.distanceRange.x) / (self.ui.distanceRange.y - self.ui.distanceRange.x)
    local scale = Mathf.Lerp(self.ui.scaleRange.x, self.ui.scaleRange.y, t)
    resItem:RefreshOasisResItemScale(scale)
  end
end

function UINOasisResOutput:UpdateOasisResData(id, resTabSort)
  local resItem = self.resItemDic[id]
  local resData = resTabSort[1]
  if resItem ~= nil and resData ~= nil then
    local progress = resData.countMax == 0 and 0 or resData.count / resData.countMax
    resItem:RefreshOasisResItemState(progress)
  end
end

function UINOasisResOutput:ShowOasisResUIItem(id, show)
  local resItem = self.resItemDic[id]
  if resItem ~= nil then
    if show then
      resItem:Show()
      resItem:PlayOasisResItemShowTween()
    else
      resItem:Hide()
    end
  end
end

function UINOasisResOutput:OnShow()
  for k, resItem in pairs(self.resItemDic) do
    resItem:PlayOasisResItemShowTween()
  end
end

function UINOasisResOutput:RecycleOasisResItem(id)
  local resItem = self.resItemDic[id]
  if resItem ~= nil then
    self.resItemPool:HideOne(resItem)
    self.resItemDic[id] = nil
  end
end

function UINOasisResOutput:OnDelete()
  self.resItemPool:DeleteAll()
  self.resItemDic = {}
  base.OnDelete(self)
end

return UINOasisResOutput
