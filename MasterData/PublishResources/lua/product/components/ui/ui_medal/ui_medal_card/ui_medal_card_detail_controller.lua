_class("UIMedalCardDetailController", UIController)
UIMedalCardDetailController = UIMedalCardDetailController

function UIMedalCardDetailController:OnShow(uiParams)
  self:InitWidget()
  local visitData = uiParams[1]
  local cb = uiParams[2]
  self:_SetData(visitData, cb)
end

function UIMedalCardDetailController:InitWidget()
  self.btnEdit = self:GetGameObject("btnEdit")
  local cardPool = self:GetUIComponent("UISelectObjectPath", "card")
  self.card = cardPool:SpawnObject("UIMedalCardSimple")
  self.jinianWallRed = self:GetGameObject("jinianWallRed")
  self.jinianWallRed:SetActive(false)
end

function UIMedalCardDetailController:_SetData(visitData, closeCB)
  self.isVisit = nil
  if visitData then
    self.btnEdit:SetActive(false)
    self.isVisit = true
  else
    self.btnEdit:SetActive(true)
    local medalMoule = GameGlobal.GetModule(MedalModule)
    visitData = medalMoule:GetPlacementInfo()
  end
  self.card:SetData(1800, visitData, self.isVisit)
  self.closeCB = closeCB
  if not self.isVisit then
    self.mMedal = GameGlobal.GetModule(MedalModule)
    self.data = self.mMedal:GetN22MedalEditData()
    self.listData = UIMedalListData:New()
    local client_medal_info = self.mMedal:GetMedalVec()
    self.listData:Init(client_medal_info)
    local listAll = self.listData:GetItemsByFilter(0)
    local jinianRed = false
    for _, item in ipairs(listAll) do
      if item:IsReceive() then
        local id = item:GetID()
        local boardMedal = self.data:GetBoardMedalById(id)
        if boardMedal then
        elseif item:IsNew() then
          jinianRed = true
        end
      end
    end
    self.jinianWallRed:SetActive(jinianRed)
  end
end

function UIMedalCardDetailController:BgOnClick(go)
  self:CloseDialog()
  if self.closeCB then
    self.closeCB()
    self.closeCB = nil
  end
end

function UIMedalCardDetailController:BtnBackOnClick(go)
  self:CloseDialog()
  if self.closeCB then
    self.closeCB()
    self.closeCB = nil
  end
end

function UIMedalCardDetailController:BtnEditOnClick(go)
  self:ShowDialog("UIN22MedalEdit", false, function()
    if not self.isVisit then
      self.mMedal = GameGlobal.GetModule(MedalModule)
      self.data = self.mMedal:GetN22MedalEditData()
      self.listData = UIMedalListData:New()
      local client_medal_info = self.mMedal:GetMedalVec()
      self.listData:Init(client_medal_info)
      local listAll = self.listData:GetItemsByFilter(0)
      local jinianRed = false
      for _, item in ipairs(listAll) do
        if item:IsReceive() then
          local id = item:GetID()
          local boardMedal = self.data:GetBoardMedalById(id)
          if boardMedal then
          elseif item:IsNew() then
            jinianRed = true
          end
        end
      end
      self.jinianWallRed:SetActive(jinianRed)
    end
  end)
end
