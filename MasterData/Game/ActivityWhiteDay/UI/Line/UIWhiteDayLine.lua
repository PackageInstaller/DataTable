local UIWhiteDayLine = class("UIWhiteDayLine", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local UINWhiteDayOrderItem = require("Game.ActivityWhiteDay.UI.Line.UINWhiteDayOrderItem")
local ActivityWhiteDayUtil = require("Game.ActivityWhiteDay.ActivityWhiteDayUtil")

function UIWhiteDayLine:OnInit()
  self.orderItemPool = UIItemPool.New(UINWhiteDayOrderItem, self.ui.obj_productItem)
  self.ui.obj_productItem:SetActive(false)
  self.__onClickkStartProduce = BindCallback(self, self.__OnClickkStartProduce)
  self.__refreshWDAssistHero = BindCallback(self, self.RefreshWDAssistHero)
  self.__onConfirmSelectHero = BindCallback(self, self.__OnConfirmSelectHero)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_AddHero, self, self.__OnClickSelectHeto)
  UIUtil.AddButtonListener(self.ui.btn_Switch, self, self.__OnClickSelectHeto)
end

function UIWhiteDayLine:InitWDLine(AWDCtrl, AWDLineData)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self:RefreshFactoryLineIntro()
  self:RefreshWDOrderList()
  self:RefreshWDAssistHero()
end

function UIWhiteDayLine:RefreshWDOrderList()
  self.orderItemPool:HideAll()
  local orderDataList = self.AWDLineData:GetWDLineOrderDataList()
  for index, orderData in ipairs(orderDataList) do
    if orderData:GetWDLineOrderCouldShow() then
      local orderItem = self.orderItemPool:GetOne()
      orderItem:InitWDOrderItem(orderData, self.__onClickkStartProduce)
    end
  end
end

function UIWhiteDayLine:RefreshFactoryLineIntro()
  local lineCfg = self.AWDLineData:GetWDLineCfg()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(lineCfg.line_name)
  self.ui.tex_Describe.text = LanguageUtil.GetLocaleText(lineCfg.line_des)
  local linePicRes = lineCfg.line_res
  if not string.IsNullOrEmpty(linePicRes) then
    if self.bigResLoader ~= nil then
      self.bigResLoader:Put2Pool()
      self.bigResLoader = nil
    end
    self.bigResLoader = cs_ResLoader.Create()
    local path = PathConsts:GetWhiteDayLinePath(linePicRes)
    UIUtil.LoadABAssetAsyncAndSetTexture(self.bigResLoader, path, self.ui.img_ProductionLine)
  end
end

function UIWhiteDayLine:RefreshWDAssistHero()
  local AWDData = self.AWDLineData:GetAWDData()
  local assistHeroId = self.AWDLineData:GetWDLDAssistHeroID()
  local isHaveHero = assistHeroId ~= nil
  self.ui.obj_hero:SetActive(isHaveHero)
  self.ui.obj_empty:SetActive(not isHaveHero)
  if not isHaveHero then
    return
  end
  local heroCfg = ConfigData.hero_data[assistHeroId]
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local heroData = PlayerDataCenter.heroDic[assistHeroId]
  if self.heroResLoader ~= nil then
    self.heroResLoader:Put2Pool()
    self.heroResLoader = nil
  end
  self.heroResLoader = cs_ResLoader.Create()
  self.heroResLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData:GetResPicName()), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_HeroPic.texture = texture
  end)
  local assistTypeId, assistCfg = ActivityWhiteDayUtil.GetAssistHeroTypeByHeroId(AWDData, heroData.heroCfg)
  self.ui.img_RewardIcon:SetIndex(assistTypeId - 1)
  self.ui.tex_RewardInfo.text = LanguageUtil.GetLocaleText(assistCfg.effect_text)
end

function UIWhiteDayLine:__OnClickkStartProduce(orderData)
  local AWDData = self.AWDLineData:GetAWDData()
  local actFrameId = AWDData:GetActFrameId()
  local orderId = orderData:GetWDLineOrderId()
  local assistHeroId = self.AWDLineData:GetWDLDAssistHeroID()
  local lineId = self.AWDLineData:GetWDLDLineID()
  if assistHeroId == nil then
    self:__OnClickSelectHeto(function()
      local assistHeroId = self.AWDLineData:GetWDLDAssistHeroID()
      if assistHeroId ~= nil then
        self.AWDCtrl:WDStartLineOrder(actFrameId, orderId, assistHeroId, lineId)
        AudioManager:PlayAudioById(1202)
        self:OnClickClose()
      end
    end)
    AudioManager:PlayAudioById(1200)
    return
  end
  self.AWDCtrl:WDStartLineOrder(actFrameId, orderId, assistHeroId, lineId)
  AudioManager:PlayAudioById(1202)
  self:OnClickClose()
end

function UIWhiteDayLine:__OnClickSelectHeto(afterSelectCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayHeroList, function(window)
    if window == nil then
      return
    end
    local AWDData = self.AWDLineData:GetAWDData()
    window:InitWDHeroList(self.AWDCtrl, AWDData, self.AWDLineData, false, self.__onConfirmSelectHero, function()
      self.__refreshWDAssistHero()
      if afterSelectCallback ~= nil then
        afterSelectCallback()
      end
    end)
  end)
end

function UIWhiteDayLine:__OnConfirmSelectHero(selectedHeroId)
  self.AWDLineData:SetWDLDAssistHeroID(selectedHeroId)
end

function UIWhiteDayLine:_BackAction()
  if not self.AWDLineData:GetIsInProduction() then
    self.AWDLineData:SetWDLDAssistHeroID(nil)
  end
  self:Hide()
end

function UIWhiteDayLine:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDayLine:OnShow()
  base.OnShow(self)
end

function UIWhiteDayLine:OnDelete()
  if self.bigResLoader ~= nil then
    self.bigResLoader:Put2Pool()
    self.bigResLoader = nil
  end
  if self.heroResLoader ~= nil then
    self.heroResLoader:Put2Pool()
    self.heroResLoader = nil
  end
  base.OnDelete(self)
end

return UIWhiteDayLine
