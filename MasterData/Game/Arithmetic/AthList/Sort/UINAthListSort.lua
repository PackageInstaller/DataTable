local UINAthListSort = class("UINAthListSort", UIBaseNode)
local base = UIBaseNode
local UINAthListSortKindItem = require("Game.Arithmetic.AthList.Sort.UINAthListSortKindItem")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local AthUtil = require("Game.Arithmetic.AthUtil")

function UINAthListSort:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickBg)
  self._SelectSortKindFunc = BindCallback(self, self._SelectSortKind)
  self.ui.sortKindItem:SetActive(false)
  self.sortItemPool = UIItemPool.New(UINAthListSortKindItem, self.ui.sortKindItem)
end

function UINAthListSort:InitAthListSort(athListRoot, isConsumeAth)
  self.athListRoot = athListRoot
  self._isInit = true
  local kindCount = isConsumeAth and 2 or AthSortEnum.KindTypeMaxCount
  for kindType = 1, kindCount do
    if kindType ~= AthSortEnum.eKindType.SignHero or FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Sign) then
      for kindValue = 1, AthSortEnum.eKindTypeNum[kindType] do
        local sortItem = self.sortItemPool:GetOne()
        sortItem:InitAthListSortKindItem(kindType, kindValue, self._SelectSortKindFunc)
      end
    end
  end
  self.sortItemPool.listItem[2]:SetAthListSortKindItemTogOn()
  self.athListRoot:ChangeAthListSort(self.curKindType, self.curKindValue, self.curName, true)
  self._isInit = false
end

function UINAthListSort:ShowAthListSort()
  self:Show()
  UIUtil.SetTopStatus(self, self.Hide, nil, AthUtil.ShowATHInfoFunc)
end

function UINAthListSort:_SelectSortKind(kindType, kindValue, name)
  self.curKindType = kindType
  self.curKindValue = kindValue
  self.curName = name
  if not self._isInit then
    self:_OnClickBg()
  end
end

function UINAthListSort:_OnClickBg()
  UIUtil.OnClickBackByUiTab(self)
  self.athListRoot:ChangeAthListSort(self.curKindType, self.curKindValue, self.curName)
end

function UINAthListSort:OnDelete()
  self.sortItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthListSort
