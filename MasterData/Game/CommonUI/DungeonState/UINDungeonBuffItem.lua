local UINDungeonBuffItem = class("UINDungeonBuffItem", UIBaseNode)
local base = UIBaseNode
local OnPressScale = Vector3.New(1.5, 1.5, 1)

function UINDungeonBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_buffItem.onPress:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn_buffItem.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
end

function UINDungeonBuffItem:InitBuffOnlyWithCfg(buffCfg, longPressFunc, pressUpFunc)
  self.buffCfg = buffCfg
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.ui.img_Icon.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  if self.ui.obj_buffNum ~= nil then
    self.ui.obj_buffNum:SetActive(false)
  end
  if self.ui.obj_buffPlus ~= nil then
    self.ui.obj_buffPlus:SetActive(false)
  end
end

function UINDungeonBuffItem:InitBuffByCfg(epBuff, buffCfg, longPressFunc, pressUpFunc, buffCount)
  self:InitBuffOnlyWithCfg(buffCfg, longPressFunc, pressUpFunc)
  if not IsNull(self.ui.obj_buffNum) then
    if epBuff.cnt ~= nil and epBuff.cnt > 0 then
      self.ui.obj_buffNum:SetActive(true)
      self.ui.tex_buffNum.text = tostring(epBuff.cnt)
    else
      self.ui.obj_buffNum:SetActive(false)
    end
  end
  if not IsNull(self.ui.obj_buffPlus) then
    if buffCount ~= nil and 1 < buffCount then
      self.ui.obj_buffPlus:SetActive(true)
      self.ui.tex_buffPlus.text = tostring(buffCount)
    else
      self.ui.obj_buffPlus:SetActive(false)
    end
  end
end

function UINDungeonBuffItem:InitWcDunBuff(wcBuffData, longPressFunc, pressUpFunc)
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.ui.img_Icon.sprite = CRH:GetSprite(wcBuffData:GetWCBuffIcon(), CommonAtlasType.ExplorationIcon)
  self.buffCfg = wcBuffData:GetWcBuffDataCfg()
  self.ui.obj_buffNum:SetActive(false)
  self.ui.obj_buffPlus:SetActive(false)
end

function UINDungeonBuffItem:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.buffCfg)
  end
  self.transform.localScale = OnPressScale
end

function UINDungeonBuffItem:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
  self.transform.localScale = Vector3.one
end

function UINDungeonBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINDungeonBuffItem
