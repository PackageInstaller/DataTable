local UIWhiteDayFactoryLevel = class("UIWhiteDayFactoryLevel", UIBaseWindow)
local base = UIBaseWindow
local UINWhiteDayFactoryLevelItem = require("Game.ActivityWhiteDay.UI.FactoryLevel.UINWhiteDayFactoryLevelItem")

function UIWhiteDayFactoryLevel:OnInit()
  self.levelItemPool = UIItemPool.New(UINWhiteDayFactoryLevelItem, self.ui.obj_rowItem)
  self.ui.obj_rowItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  self.__genWDFLLevelItems = BindCallback(self, self.GenWDFLLevelItems)
  MsgCenter:AddListener(eMsgEventId.WhiteDayPhotoChange, self.__genWDFLLevelItems)
  MsgCenter:AddListener(eMsgEventId.WhiteDayOrderChange, self.__genWDFLLevelItems)
end

function UIWhiteDayFactoryLevel:InitWDFactoryLevel(AWDData)
  self.AWDData = AWDData
  self:GenWDFLLevelItems()
end

function UIWhiteDayFactoryLevel:GenWDFLLevelItems()
  self.levelItemPool:HideAll()
  local curLevel = self.AWDData:GetAWDFactoryLevel()
  local factoryCfg = self.AWDData:GetAWDFactoryCfg()
  local curExp = self.AWDData:GetAWDFactoryExp()
  local preLevelCfg
  for level, levelCfg in ipairs(factoryCfg) do
    local levelItem = self.levelItemPool:GetOne()
    levelItem:InitWDFactoryLevelItem(self.AWDData, preLevelCfg, levelCfg, curLevel, curExp)
    preLevelCfg = levelCfg
  end
end

function UIWhiteDayFactoryLevel:BackAction()
  self:Hide()
end

function UIWhiteDayFactoryLevel:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayFactoryLevel:OnShow()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  base.OnShow(self)
end

function UIWhiteDayFactoryLevel:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.WhiteDayPhotoChange, self.__genWDFLLevelItems)
  MsgCenter:RemoveListener(eMsgEventId.WhiteDayOrderChange, self.__genWDFLLevelItems)
end

return UIWhiteDayFactoryLevel
