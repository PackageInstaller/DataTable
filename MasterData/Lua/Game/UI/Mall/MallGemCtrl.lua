local MallGemCtrl = class("MallGemCtrl", BaseCtrl)
MallGemCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  }
}
MallGemCtrl._mapEventConfig = {MallOrderClear = "Refresh"}

function MallGemCtrl:Refresh()
  if self._panel.nCurTog ~= AllEnum.MallToggle.Gem then
    return
  end
  
  local function callback(tbList)
    table.sort(tbList, function(a, b)
      return ConfigTable.GetData("MallGem", a.Id).Order < ConfigTable.GetData("MallGem", b.Id).Order
    end)
    self.tbList = tbList
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self._mapNode.sv:SetAnim(0.04)
    self._mapNode.sv:Init(#self.tbList, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
  
  PlayerData.Mall:SendMallGemListReq(callback)
end

function MallGemCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Mall.MallGemItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function MallGemCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  PlayerData.Mall:BuyGem(self.tbList[nIndex].Id, ConfigTable.GetData("MallGem", self.tbList[nIndex].Id).StatisticalGroup)
end

function MallGemCtrl:Awake()
  self.tbGridCtrl = {}
end

function MallGemCtrl:OnEnable()
end

function MallGemCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function MallGemCtrl:OnDestroy()
end

return MallGemCtrl
