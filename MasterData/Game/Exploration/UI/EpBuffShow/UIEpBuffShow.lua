local UIEpBuffShow = class("UIBaseWindow", UIBaseWindow)
local base = UIBaseWindow
local UIEpBuffShowItem = require("Game.Exploration.UI.EpBuffShow.UIEpBuffShowItem")

function UIEpBuffShow:OnInit()
  self.ui.iconItem:SetActive(false)
  self.ui.nameItem:SetActive(false)
  self.buffItemList = {}
  self.ui.ani_buffShow.onComplete:AddListener(BindCallback(self, self.__OnBuffAniPlayerComplete))
end

function UIEpBuffShow:InitEpBuffShow(buffList)
  for k, epBuffCfg in pairs(buffList) do
    local iconObj = self.ui.iconItem:Instantiate()
    iconObj:SetActive(true)
    local nameObj = self.ui.nameItem:Instantiate()
    nameObj:SetActive(true)
    local buffItem = UIEpBuffShowItem.New()
    buffItem:InitEpBuffShowItem(iconObj, nameObj, epBuffCfg)
    table.insert(self.buffItemList, buffItem)
  end
end

function UIEpBuffShow:BindBuffShowEnd(endEvent, needCover)
  self.__endEvent = endEvent
  self.__needCover = needCover
  if self.__needCover then
    UIUtil.AddOneCover("UIEpBuffShow")
  end
end

function UIEpBuffShow:__OnBuffAniPlayerComplete()
  self:Delete()
  if self.__endEvent ~= nil then
    self.__endEvent()
  end
end

function UIEpBuffShow:OnDelete()
  if self.__needCover then
    UIUtil.CloseOneCover("UIEpBuffShow")
  end
  base.OnDelete(self)
end

return UIEpBuffShow
