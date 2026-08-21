_class("UIN12MapGetRewardsController", UIController)
UIN12MapGetRewardsController = UIN12MapGetRewardsController

function UIN12MapGetRewardsController:OnShow(uiParam)
  self._itemModule = self:GetModule(ItemModule)
  self._title = uiParam[1] or ""
  self._rewards = uiParam[2]
  self._closeCb = uiParam[3]
  self._notSort = uiParam[4]
  if self._notSort then
  else
    self._rewards = self._itemModule:SortRoleAsset(self._rewards)
  end
  self:GetComponents()
  self:OnValue()
  self:SetTextMat()
end

function UIN12MapGetRewardsController:GetComponents()
  self._titleTex = self:GetUIComponent("UILocalizationText", "title")
  self.selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self._pools = self:GetUIComponent("UISelectObjectPath", "Content")
  self._mainBgPanel = self:GetGameObject("mainBgPanel")
  self._mainBgPanel:SetActive(false)
end

function UIN12MapGetRewardsController:SetTextMat()
  local tex = self:GetUIComponent("UILocalizedTMP", "btnTex")
  self:SetFontMat(tex, "uieff_n12_map_leave_tex.mat")
end

function UIN12MapGetRewardsController:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN12MapGetRewardsController:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self.selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIN12MapGetRewardsController:OnValue()
  self._titleTex:SetText(self._title)
  self._getMainBgList = {}
  local cfg_item = Cfg.cfg_item({})
  for key, value in pairs(self._rewards) do
    local id = value.assetid
    local cfg = cfg_item[id]
    if cfg.ItemSubType == ItemSubType.ItemSubType_BackGroudPicture then
      table.insert(self._getMainBgList, id)
    end
  end
  self._pools:SpawnObjects("UIN12MapGetRewardsItem", #self._rewards)
  local items = self._pools:GetAllSpawnList()
  for i = 1, #items do
    local award = Award:New()
    award:InitWithCount(self._rewards[i].assetid, self._rewards[i].count)
    local item = items[i]
    item:SetData(award, function(id, pos)
      self:OnItemSelect(id, pos)
    end)
  end
end

function UIN12MapGetRewardsController:btnOnClick(go)
  self:ClosePanel()
end

function UIN12MapGetRewardsController:ClosePanel()
  if #self._getMainBgList > 0 then
    self._mainBgPanel:SetActive(true)
    self:ShowMainBgList()
  else
    self:CloseDialog()
  end
end

function UIN12MapGetRewardsController:ShowMainBgList()
  if #self._getMainBgList > 0 then
    local mainBgID = self._getMainBgList[1]
    table.remove(self._getMainBgList, 1)
    self:ShowMainBgUnit(mainBgID)
  else
    self:CloseDialog()
  end
end

function UIN12MapGetRewardsController:mainBgPanelOnClick(go)
  self:ShowMainBgList()
end

function UIN12MapGetRewardsController:OnHide()
  if self._closeCb then
    Log.debug("###[UIN12MapGetRewardsController] 关闭回调调用")
    self._closeCb()
  end
  if self._res then
    self._res:Dispose()
    self._res = nil
  end
end
