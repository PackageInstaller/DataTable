local base = UIBaseWindow
local UILtrSpecialSelectHeroWin = class("UILtrSpecialSelectHeroWin", base)
local UINLtrSpeSelectHeroWinItem = require("Game.Lottery.UI.SpecialSelectHero.Win.UINLtrSpeSelectHeroWinItem")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local CS_MessageCommon = CS.MessageCommon

function UILtrSpecialSelectHeroWin:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
  self._heroItemPool = UIItemPool.New(UINLtrSpeSelectHeroWinItem, self.ui.HeroItem, false)
  self._resLoader = CS.ResLoader.Create()
  self._OnSelectHeroFunc = BindCallback(self, self._OnSelectHero)
end

function UILtrSpecialSelectHeroWin:InitLtrSpecialSelectHeroWin(ltrPool, completeFunc)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
  self._ltrPool = ltrPool
  self._completeFunc = completeFunc
  local itemIdList = self._ltrPool:GetLtrSpeSelectTotalList()
  self._itemIdList = itemIdList
  for k, itemId in ipairs(itemIdList) do
    local heroItem = self._heroItemPool:GetOne()
    heroItem:InitLtrSpeSelectHeroWinItem(itemId, self._resLoader, self._OnSelectHeroFunc)
  end
  self._selectedItemDic = {}
  self:_UpdSelectState()
end

function UILtrSpecialSelectHeroWin:_UpdSelectState()
  self.ui.tex_Num:SetIndex(0, tostring(table.count(self._selectedItemDic)), tostring(LotteryEnum.SpecialSelectHeroNum))
  local selectable = table.count(self._selectedItemDic) >= LotteryEnum.SpecialSelectHeroNum
  self.ui.img_Confirm.color = self.ui.color_Confirm[selectable and 1 or 2]
end

function UILtrSpecialSelectHeroWin:_OnSelectHero(itemId, heroItem)
  local isSelecte = self._selectedItemDic[itemId] == nil
  if isSelecte then
    if table.count(self._selectedItemDic) >= LotteryEnum.SpecialSelectHeroNum then
      return
    end
    self._selectedItemDic[itemId] = true
  else
    self._selectedItemDic[itemId] = nil
  end
  heroItem:SelectLtrSpeHeroWinItem(isSelecte)
  self:_UpdSelectState()
end

function UILtrSpecialSelectHeroWin:_OnClickConfirm()
  if table.count(self._selectedItemDic) ~= LotteryEnum.SpecialSelectHeroNum then
    return
  end
  local itemIdList = {}
  local nameList = {}
  for k, itemId in ipairs(self._itemIdList) do
    if self._selectedItemDic[itemId] ~= nil then
      local heroId = ConfigData:GetHeroIdByItem(itemId)
      table.insert(itemIdList, itemId)
      local heroCfg = ConfigData.hero_data[heroId]
      local heroName = heroCfg and LanguageUtil.GetLocaleText(heroCfg.name)
      table.insert(nameList, heroName)
    end
  end
  
  local function confimFunc()
    local ltrCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
    if ltrCtrl == nil then
      return
    end
    ltrCtrl:ReqLtrSpeSelectHero(self._ltrPool, itemIdList, function()
      self:Delete()
      if self._completeFunc then
        self._completeFunc()
      end
    end)
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    local msg = string.format(ConfigData:GetTipContent(9715), table.unpack(nameList))
    win:ShowTextBoxWithYesAndNo(msg, confimFunc, nil)
  end)
end

function UILtrSpecialSelectHeroWin:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UILtrSpecialSelectHeroWin:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self._heroItemPool:DeleteAll()
  base.OnDelete(self)
end

return UILtrSpecialSelectHeroWin
