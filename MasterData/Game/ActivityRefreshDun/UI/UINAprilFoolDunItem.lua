local UINAprilFoolDunItem = class("UINAprilFoolDunItem", UIBaseNode)
local base = UIBaseNode
local cs_Material = CS.UnityEngine.Material
local cs_MessageCommon = CS.MessageCommon

function UINAprilFoolDunItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_dungeonItem, self, self.__OnClickLevel)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.__OnClickRefresh)
end

function UINAprilFoolDunItem:InitAprilFoolDunItem(index, ARDctrl, ARDDunData, resloader)
  self.index = index
  self.ARDctrl = ARDctrl
  self.ARDDunData = ARDDunData
  self.resloader = resloader
  self.ARDData = self.ARDDunData.ARDData
  self:__RefreshLevelHeroPic()
  self:__RefreshIsComplete()
  self:__RefreshTag()
  self:__RefreshCouldExchange()
end

function UINAprilFoolDunItem:__RefreshLevelHeroPic()
  local picName = self.ARDDunData:GetARDDLevelPicName()
  if string.IsNullOrEmpty(picName) then
    return
  end
  local path = PathConsts:GetAprilFoolLevelPath(picName)
  self.ui.img_HeroPIc.enabled = false
  self.resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(self.ui.img_HeroPIc.transform) then
      return
    end
    self.ui.img_HeroPIc.texture = texture
    self.ui.img_HeroPIc.enabled = true
    self.ui.img_Completed.texture = texture
  end)
end

function UINAprilFoolDunItem:__RefreshIsComplete()
  local isComplete = self.ARDDunData:GetARDDunIsCompleted()
  self.ui.img_Completed.gameObject:SetActive(isComplete)
  if isComplete and self.__completeMaskMat == nil then
    self.__completeMaskMat = cs_Material(self.ui.mat_ImageMask)
  end
end

function UINAprilFoolDunItem:__RefreshTag()
  local diff = self.ARDDunData:GetARDDLevelTag()
  self.ui.tex_Tag:SetIndex(diff - 1)
end

function UINAprilFoolDunItem:__RefreshCouldExchange()
  local couldExchange = self.ARDDunData:GetCouldExchange()
  self.ui.btn_Refresh.gameObject:SetActive(couldExchange)
end

function UINAprilFoolDunItem:__OnClickLevel()
  if not self.ARDDunData:GetARDDunIsCompleted() then
    self.ARDctrl:EnterARDDungeonFormation(self.ARDDunData)
  end
end

function UINAprilFoolDunItem:__OnClickRefresh()
  local ARDData = self.ARDDunData.ARDData
  local exchangeMaxNum = ARDData:GetARDMAXExchangeTime()
  local exchangeNum = ARDData:GetARDExchangeTime()
  
  local function RealRefrsh()
    local actId = self.ARDDunData.ARDData:GetActId()
    local dunId = self.ARDDunData:GetARDDunId()
    self.ARDctrl:ARDDunRefresh(actId, dunId, function()
      AudioManager:PlayAudioById(1212)
      self.ARDDunData = self.ARDData:GetARDDataByDunIndex(self.index)
      self:__RefreshLevelHeroPic()
      self:__RefreshIsComplete()
      self:__RefreshTag()
      self:__RefreshCouldExchange()
    end)
  end
  
  if exchangeMaxNum <= exchangeNum then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7302))
  else
    local message = string.format(ConfigData:GetTipContent(7305), tostring(exchangeMaxNum - exchangeNum))
    cs_MessageCommon.ShowMessageBox(message, RealRefrsh, nil)
  end
end

function UINAprilFoolDunItem:OnDelete()
  if self.__completeMaskMat ~= nil then
    DestroyUnityObject(self.__completeMaskMat)
  end
  base.OnDelete(self)
end

return UINAprilFoolDunItem
