local base = UIBaseWindow
local UIWarChessObjDetail = class("UIWarChessObjDetail", base)
local UINEnemyTagItem = require("Game.Battle.UI.UINEnemyTagItem")

function UIWarChessObjDetail:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.OnClickBG)
  self.ui.obj_tag:SetActive(false)
  self.tagItemPool = UIItemPool.New(UINEnemyTagItem, self.ui.obj_tag)
  self.resloader = CS.ResLoader.Create()
end

function UIWarChessObjDetail:InitWCIntro(desId, pos, closeCallback)
  if desId ~= nil and desId ~= self.__cacheDes then
    local desCfg = ConfigData.warchess_des[desId]
    if desCfg == nil then
      desCfg = ConfigData.warchess_des[1000]
    end
    self.ui.tex_Title.text = LanguageUtil.GetLocaleText(desCfg.name)
    self.ui.tex_Contex.text = LanguageUtil.GetLocaleText(desCfg.info)
    self.ui.img_ObjIcon.sprite = AtlasUtil.GetSpriteFromAtlas("WarChess", desCfg.icon, self.resloader)
    self.tagItemPool:HideAll()
    local tag_des = desCfg.tag_des
    if tag_des ~= nil then
      local tagEnd = #tag_des
      local tagStart = 1
      for i = tagStart, tagEnd do
        local tag = tag_des[i]
        local item = self.tagItemPool:GetOne()
        item:InitEnemyTagItem(LanguageUtil.GetLocaleText(tag))
      end
    end
    self.__cacheDes = desId
  end
  self.__closeCallback = closeCallback
  self:UpdDetailPanelPos(pos)
end

function UIWarChessObjDetail:UpdDetailPanelPos(worldPos)
  local rolePosX = UIManager:World2UIPosition(worldPos, self.transform).x
  local targetPosX = rolePosX - self.ui.uINWCObjDetail.sizeDelta.x / 2 - 150
  if targetPosX <= self.ui.panelPosRangeX - self.transform.rect.width / 2 then
    targetPosX = rolePosX + self.ui.uINWCObjDetail.sizeDelta.x / 2 + 150
  end
  local anchoredPos = self.ui.uINWCObjDetail.anchoredPosition
  anchoredPos.x = targetPosX
  self.ui.uINWCObjDetail.anchoredPosition = anchoredPos
end

function UIWarChessObjDetail:OnClickBG()
  if self.__closeCallback ~= nil then
    self.__closeCallback()
  end
  self:Hide()
end

function UIWarChessObjDetail:OnDelete()
  self.tagItemPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIWarChessObjDetail
