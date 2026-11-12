local SoldierHandbookBossCtrl = class("SoldierHandbookBossCtrl", BaseCtrl)
SoldierHandbookBossCtrl._mapNodeConfig = {
  sv_loop = {
    sNodeName = "sv_bossGroup",
    sComponentName = "LoopScrollView"
  }
}
SoldierHandbookBossCtrl._mapEventConfig = {}
SoldierHandbookBossCtrl._mapRedDotConfig = {}

function SoldierHandbookBossCtrl:OnDestroy()
  self:Clear()
end

function SoldierHandbookBossCtrl:Clear()
  if self.tbItemCtrl ~= nil then
    for _, v in ipairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbItemCtrl = {}
  end
end

function SoldierHandbookBossCtrl:Init()
  self.tbItemCtrl = {}
  self:InitList()
end

function SoldierHandbookBossCtrl:InitList()
  self.tbTemplateList = PlayerData.SoldierData:GetAllBossTemplates() or {}
  self._mapNode.sv_loop:SetAnim(0.06)
  self._mapNode.sv_loop:Init(#self.tbTemplateList, self, self.OnRefreshGrid)
end

function SoldierHandbookBossCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbTemplateList[nIndex]
  if mapData == nil then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  local ctrl = self.tbItemCtrl[nInstanceId]
  if ctrl == nil then
    ctrl = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.BossTemplate.SoldierBossTemplateItemCtrl")
    self.tbItemCtrl[nInstanceId] = ctrl
  end
  ctrl:SetItemData(mapData)
end

return SoldierHandbookBossCtrl
