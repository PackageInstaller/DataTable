local UIWin21SectorBar = class("UIWin21SectorBar", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local ActivitySectorIIEnum = require("Game.ActivitySectorII.ActivitySectorIIEnum")

function UIWin21SectorBar:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickWAMapTask)
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.OnClickWinterShop)
  UIUtil.AddButtonListener(self.ui.btn_Tree, self, self.__OnClickOpenTech)
  UIUtil.AddButtonListener(self.ui.btn_ReprintShop, self, self.__OnClickJumpShop)
  self.__refreshShopTokenCount = BindCallback(self, self.__RefreshShopTokenCount)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshShopTokenCount)
  self.resloader = CS.ResLoader.Create()
end

function UIWin21SectorBar:InitSectorBar(actId)
  self.actId = actId
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  self.sectorIIData = sectorIICtrl:GetSectorIIDataByActId(self.actId)
  self.shopCurrencyId = self.sectorIIData:GetSectorIITokenId()
  self.actFrameId = self.sectorIIData:GetSectorIIActFrameId()
  self.reprintShopId = self.sectorIIData:GetSectorIIReprintShopId()
  self.reprintShopIcon = self.sectorIIData:GetSectorIIReprintShopIcon()
  self:__RefreshShopTokenIcon()
  self:__RefreshShopTokenCount()
  self:__RefreshReprintShopTokenIcon()
  self:__RefreshReprintShopTokenName()
  self:__InitSectorIITaskReddot()
  self:__InitSectorIIShopReddot()
  self:__InitSectorIITechReddot()
  local isFinished = not self.sectorIIData:IsActivityRunning()
  self:SetIsTreeFinishedUI(isFinished)
end

function UIWin21SectorBar:SetIsTreeFinishedUI(active)
  self.ui.obj_TreeIsOver:SetActive(active)
end

function UIWin21SectorBar:OnClickWAMapTask()
  JumpManager:Jump(JumpManager.eJumpTarget.DynTask, nil, nil, {
    TaskEnum.eTaskType.LargeActivityTask
  }, true)
end

function UIWin21SectorBar:OnClickWinterShop()
  if self.sectorIIData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Win21Shop, function(window)
    window:InitActivityWinterShop(self.sectorIIData)
  end)
end

function UIWin21SectorBar:__RefreshShopTokenIcon()
  local itemCfg = ConfigData.item[self.shopCurrencyId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(self.shopCurrencyId))
    return
  end
  self.ui.img_TokenIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
end

function UIWin21SectorBar:__RefreshShopTokenCount()
  local itemCount = PlayerDataCenter:GetItemCount(self.shopCurrencyId)
  self.ui.tex_TokenCount.text = tostring(itemCount)
end

function UIWin21SectorBar:__OnClickJumpShop()
  if self.reprintShopId ~= 0 then
    JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {
      self.reprintShopId
    })
  end
end

function UIWin21SectorBar:__RefreshReprintShopTokenIcon()
  if not string.IsNullOrEmpty(self.reprintShopIcon) then
    self.ui.img_ReprintShopIcon.sprite = AtlasUtil.GetSpriteFromAtlas("UI_Shop", self.reprintShopIcon, self.resloader)
  end
end

function UIWin21SectorBar:__RefreshReprintShopTokenName()
  local shopCfg = ConfigData.shop[self.reprintShopId]
  if shopCfg then
    self.ui.btn_ReprintShop.gameObject:SetActive(true)
    self.ui.tex_ReprintShopName.text = LanguageUtil.GetLocaleText(shopCfg.name)
  else
    self.ui.btn_ReprintShop.gameObject:SetActive(false)
  end
end

function UIWin21SectorBar:__InitSectorIIShopReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.recommendShop)
  if isOk then
    if self.__refresnShopReddot == nil then
      function self.__refresnShopReddot(node)
        self.ui.blueDot_shop:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnShopReddot)
    self.__refresnShopReddot(node)
  end
end

function UIWin21SectorBar:__RemoveSectorIIShopReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.recommendShop)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnShopReddot)
  end
  self.__refresnShopReddot = nil
end

function UIWin21SectorBar:__InitSectorIITaskReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIITask)
  if isOk then
    if self.__refresnTaskReddot == nil then
      function self.__refresnTaskReddot(node)
        self.ui.redDot_task:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnTaskReddot)
    self.__refresnTaskReddot(node)
  end
end

function UIWin21SectorBar:__RemoveSectorIITaskReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIITask)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnTaskReddot)
  end
  self.__refresnTaskReddot = nil
end

function UIWin21SectorBar:__OnClickOpenTech()
  local isFinished = not self.sectorIIData:IsActivityRunning()
  if isFinished then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivityWinterTech, function(win)
    if win ~= nil then
      win:InitWATech(self.actId)
    end
  end)
end

function UIWin21SectorBar:__InitSectorIITechReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techRoot)
  if isOk then
    if self.__refresnTechReddot == nil then
      function self.__refresnTechReddot(node)
        self.ui.blueDot_tree:SetActive(node:GetRedDotCount() > 0)
      end
    end
    RedDotController:AddListener(node.nodePath, self.__refresnTechReddot)
    self.__refresnTechReddot(node)
  end
end

function UIWin21SectorBar:__RemoveSectorIITechReddot()
  local isOk, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.actFrameId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techRoot)
  if isOk then
    RedDotController:RemoveListener(node.nodePath, self.__refresnTechReddot)
  end
  self.__refresnTechReddot = nil
end

function UIWin21SectorBar:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshShopTokenCount)
  self:__RemoveSectorIITaskReddot()
  self:__RemoveSectorIIShopReddot()
  self:__RemoveSectorIITechReddot()
  base.OnDelete(self)
end

return UIWin21SectorBar
