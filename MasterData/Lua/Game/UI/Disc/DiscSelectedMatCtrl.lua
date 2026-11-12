local DiscSelectedMatCtrl = class("DiscSelectedMatCtrl", BaseCtrl)
DiscSelectedMatCtrl._mapNodeConfig = {
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  btnReduce = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reduce"
  },
  ctrlMat = {
    sNodeName = "tc_mat_grid_01",
    sCtrlName = "Game.UI.TemplateEx.TemplateMatGridCtrl"
  }
}
DiscSelectedMatCtrl._mapEventConfig = {}

function DiscSelectedMatCtrl:Refresh(mapData)
  self.mapData = mapData
  self._mapNode.ctrlMat:RerfeshSelected(mapData)
end

function DiscSelectedMatCtrl:SetCount(nCount)
  self._mapNode.ctrlMat:SetSelectedCount(nCount)
end

function DiscSelectedMatCtrl:ReduceMat(btn)
  if btn.Operate_Type == 0 then
    self.mapData.nCost = 0
  elseif btn.Operate_Type == 3 then
    return
  end
  self.mapData.nCost = 0
  self._panel:ChangeMatList(self.mapData, true)
  EventManager.Hit("DiscChangeSelectedMat", true)
  EventManager.Hit("DiscChangeGridMat")
end

function DiscSelectedMatCtrl:Awake()
end

function DiscSelectedMatCtrl:OnEnable()
end

function DiscSelectedMatCtrl:OnDisable()
end

function DiscSelectedMatCtrl:OnDestroy()
end

function DiscSelectedMatCtrl:OnBtnClick_Add(btn)
  EventManager.Hit("DiscOpenMatList")
end

function DiscSelectedMatCtrl:OnBtnClick_Reduce(btn)
  self:ReduceMat(btn)
end

return DiscSelectedMatCtrl
