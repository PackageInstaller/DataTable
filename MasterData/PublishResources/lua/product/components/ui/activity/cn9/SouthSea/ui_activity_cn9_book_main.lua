_class("UIActivityCN9BookMain", UIController)
UIActivityCN9BookMain = UIActivityCN9BookMain

function UIActivityCN9BookMain:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityCN9BookMain:OnShow(uiParams)
  self:InitWidget()
  self:LoadData()
end

function UIActivityCN9BookMain:InitWidget()
  self.itemPool = self:GetUIComponent("UISelectObjectPath", "ItemPool")
end

function UIActivityCN9BookMain:LoadData()
  local cfg = Cfg.cfg_south_sea_antique({})
  local count = table.count(cfg)
  self._item = self.itemPool:SpawnObjects("UICN9SingleBookItem", count)
  for i, v in ipairs(self._item) do
    v:SetData(i)
  end
end

function UIActivityCN9BookMain:CloseBtnOnClick(go)
  self:CloseDialog()
end
