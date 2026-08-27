local UIActSummerLvSwitch = class("UIActSummerLvSwitch", UIBaseWindow)
local base = UIBaseWindow
local UINActSummerLvSwitchBtn = require("Game.ActivitySummer.UI.UINActSummerLvSwitchBtn")

function UIActSummerLvSwitch:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.OnClickSummerLvConfirm)
  self.__OnSelectLv = BindCallback(self, self.OnSelectSummerLv)
  self.lvBtnPool = UIItemPool.New(UINActSummerLvSwitchBtn, self.ui.btn_DiffSwitch)
  self.ui.btn_DiffSwitch:SetActive(false)
end

function UIActSummerLvSwitch:InitIActSummerLvSwitch(difficultList, defaultSelectIndex, callback)
  self._selectIndex = nil
  self.callback = callback
  self.difficultList = difficultList
  self.lvBtnPool:HideAll()
  defaultSelectIndex = defaultSelectIndex or 1
  defaultSelectIndex = math.clamp(defaultSelectIndex, 1, #difficultList)
  for diffcult, _ in ipairs(difficultList) do
    local item = self.lvBtnPool:GetOne()
    item:InitSummerLvBtn(diffcult, self.__OnSelectLv)
    if defaultSelectIndex == diffcult then
      self:OnSelectSummerLv(diffcult)
    end
  end
end

function UIActSummerLvSwitch:OnSelectSummerLv(index)
  self._selectIndex = index
  for _, switchBtn in ipairs(self.lvBtnPool.listItem) do
    switchBtn:SetSummerLvState(switchBtn.index == index)
  end
end

function UIActSummerLvSwitch:OnClickSummerLvConfirm()
  if self._selectIndex == nil then
    return
  end
  if self.difficultList[self._selectIndex] == nil then
    return
  end
  if self.callback == nil then
    return
  end
  self.lvBtnPool:DeleteAll()
  UIUtil.OnClickBackByUiTab(self)
  self.callback(self.difficultList[self._selectIndex])
end

return UIActSummerLvSwitch
