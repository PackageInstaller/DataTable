local UIN3DFactoryRoomInfo = class("UIN3DFactoryRoomInfo", UIBaseNode)
local base = UIBaseNode
local eRoomType = require("Game.Factory.FactoryEnum").eRoomType
local FactoryHelper = require("Game.Factory.FactoryHelper")

function UIN3DFactoryRoomInfo:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_product, self, self.OnClickProductBtn)
end

function UIN3DFactoryRoomInfo:InitRoomInfo(index, roomEntityType, unlockDes)
  self.index = index
  if roomEntityType == eRoomType.locked then
    self.ui.obj_name:SetActive(false)
    self.ui.obj_unopen:SetActive(false)
    self.ui.obj_lock:SetActive(true)
    self.ui.tex_RoomLookName.text = LanguageUtil.GetLocaleText(ConfigData.factory[self.index].name)
    self.ui.tex_Condition.text = unlockDes
    self:SetRoomSeleced(true)
  elseif roomEntityType == eRoomType.notOpen then
    self.ui.obj_name:SetActive(false)
    self.ui.obj_unopen:SetActive(true)
    self.ui.obj_lock:SetActive(false)
    self:SetRoomSeleced(true)
  else
    self.ui.obj_name:SetActive(true)
    self.ui.obj_unopen:SetActive(false)
    self.ui.obj_lock:SetActive(false)
    self.ui.tex_RoomName.text = LanguageUtil.GetLocaleText(ConfigData.factory[self.index].name)
    self:SetRoomSeleced(false)
  end
end

function UIN3DFactoryRoomInfo:RefreshEnergy(value, ceiling, speed)
end

function UIN3DFactoryRoomInfo:RefreshEnteredHeroNum()
end

function UIN3DFactoryRoomInfo:RefreshProcessLine(ProcessingOrders)
  local processingDatas = ProcessingOrders[self.index]
  local notHaveProcessLine = processingDatas == nil or table.count(processingDatas) == 0
  self.ui.obj_product:SetActive(not notHaveProcessLine)
  if notHaveProcessLine then
    return
  end
  for UID, processingData in pairs(processingDatas) do
    local Icon = processingData:GetOutputItemIconName()
    if Icon ~= nil then
      self.ui.img_ItemPic.sprite = CRH:GetSprite(Icon)
    end
    self.ui.tex_ProcessCount.text = tostring(processingData:GetOutputItemProduceNum())
    local isFinish = processingData:GetIsFinish()
    if isFinish then
      self.ui.tex_ProductState:SetIndex(0)
    else
      self.ui.tex_ProductState:SetIndex(1)
    end
    self.ui.obj_isComplete:SetActive(isFinish)
    self.ui.obj_inProduct:SetActive(not isFinish)
    if not isFinish then
      do
        local processRate = processingData:GetProcessRate()
        self.ui.img_ProcessBar.fillAmount = processRate
        local leftTime = processingData:GetLeftProcessTime()
        self.ui.tex_ProcessTime.text = FactoryHelper.ConvertTime2DisplayMode(leftTime)
        self.ui.Img_ProductButtom.color = self.ui.color_NotFinish
      end
      break
    end
    self.ui.Img_ProductButtom.color = self.ui.color_Finish
    break
  end
end

function UIN3DFactoryRoomInfo:OnClickProductBtn()
  local processingDatas = self.factoryController.ProcessingOrders[self.index]
  for UID, processingData in pairs(processingDatas) do
    if processingData:GetIsFinish() then
      self.factoryController:PickOrderReward(processingData)
      return
    end
    break
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryProduceLine, function(win)
    if win ~= nil then
      win:InitAllLines()
    end
  end)
end

function UIN3DFactoryRoomInfo:SetRoomStateImage(roomEntityType)
  if roomEntityType == eRoomType.locked then
    self.ui.img_RoomState:SetIndex(1)
  elseif roomEntityType == eRoomType.notOpen then
    self.ui.img_RoomState:SetIndex(2)
  else
    self.ui.img_RoomState:SetIndex(0)
  end
end

function UIN3DFactoryRoomInfo:SetRoomSeleced(bool)
  self.ui.img_RoomState.gameObject:SetActive(bool)
end

function UIN3DFactoryRoomInfo:OnDelete()
  if self.lineNode ~= nil then
    RedDotController:RemoveListener(self.lineNode.nodePath, self.updateRedDot)
    self.lineNode = nil
  end
  base.OnDelete(self)
end

return UIN3DFactoryRoomInfo
