local UISectorChapterLvSwitch = class("UISectorChapterLvSwitch", UIBaseWindow)
local base = UIBaseWindow
local UINSectorChapterLvSwitchBtn = require("Game.Sector.SectorLevelChapter.UINSectorChapterLvSwitchBtn")

function UISectorChapterLvSwitch:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickChapterLvConfirm)
  self.__OnSelectLv = BindCallback(self, self.OnSelectSectorChapterLv)
  self.lvBtnPool = UIItemPool.New(UINSectorChapterLvSwitchBtn, self.ui.btn_DiffSwitch)
  self.ui.btn_DiffSwitch:SetActive(false)
end

function UISectorChapterLvSwitch:InitSectorChapterLvSwitch(difficultList, defaultSelectIndex, resloader, callback)
  self._selectIndex = nil
  self.resloader = resloader
  self.callback = callback
  self.difficultList = difficultList
  self.lvBtnPool:HideAll()
  defaultSelectIndex = defaultSelectIndex or 1
  self.difficultCfgList = {}
  for i, v in pairs(self.difficultList) do
    table.insert(self.difficultCfgList, ConfigData.sector_chapter_difficulty[v])
  end
  table.sort(self.difficultCfgList, function(a, b)
    return a.sort <= b.sort
  end)
  defaultSelectIndex = math.clamp(defaultSelectIndex, 1, #self.difficultCfgList)
  for diffcult, diffCfg in ipairs(self.difficultCfgList) do
    local item = self.lvBtnPool:GetOne()
    item:InitSectorChapterLvBtn(diffcult, diffCfg, resloader, self.__OnSelectLv)
    if defaultSelectIndex == diffcult then
      self:OnSelectSectorChapterLv(diffcult)
    end
  end
end

function UISectorChapterLvSwitch:OnSelectSectorChapterLv(index)
  self._selectIndex = index
  for _, switchBtn in ipairs(self.lvBtnPool.listItem) do
    switchBtn:SetSectorChapterLvState(switchBtn.index == index)
  end
  self.ui.obj_Selected.transform:SetParent(self.lvBtnPool.listItem[index].transform)
  self.ui.obj_Selected.transform.localPosition = Vector3.zero
end

function UISectorChapterLvSwitch:OnClickChapterLvConfirm()
  if self._selectIndex == nil then
    return
  end
  if self.difficultCfgList[self._selectIndex] == nil then
    return
  end
  if self.callback == nil then
    return
  end
  self.lvBtnPool:DeleteAll()
  UIUtil.OnClickBackByUiTab(self)
  self.callback(self.difficultCfgList[self._selectIndex].sector_id)
end

return UISectorChapterLvSwitch
