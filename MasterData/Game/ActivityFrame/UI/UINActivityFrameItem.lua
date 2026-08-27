local UINActivityFrameItem = class("UINActivityFrameItem", UIBaseNode)
local base = UIBaseNode
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UINActivityFrameItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_SwitchItem, self, self.OnSwitchValueChange)
end

function UINActivityFrameItem:InitActivitySwitchItem(activityFrameData, changeValueFunc, resloader)
  self.activityFrameData = activityFrameData
  self.changeValueFunc = changeValueFunc
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.activityFrameData.name)
  if self.activityFrameData.icon ~= nil then
    self.ui.img_Icon.enabled = false
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_EventMain"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self.activityFrameData.icon)
      self.ui.img_Icon.enabled = true
    end)
  end
end

function UINActivityFrameItem:SetActivitySwitchLineState(flag)
  self.ui.obj_Line:SetActive(flag)
end

function UINActivityFrameItem:InitActivitySwitchItemWithFakeData(fakeCfg, changeValueFunc)
  self.changeValueFunc = changeValueFunc
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(fakeCfg.name)
end

function UINActivityFrameItem:SelectActivityTag()
  if self.ui.tog_SwitchItem.isOn then
    self:OnSwitchValueChange(true)
  else
    self.ui.tog_SwitchItem.isOn = true
  end
end

function UINActivityFrameItem:OnSwitchValueChange(flag)
  if flag then
    self.ui.tex_Name.color = self.ui.color_selected
    self.ui.img_Icon.color = self.ui.color_selected
  else
    self.ui.tex_Name.color = self.ui.color_unselect
    self.ui.img_Icon.color = self.ui.color_unselect
  end
  if self.changeValueFunc ~= nil then
    self.changeValueFunc(self, flag)
  end
end

function UINActivityFrameItem:ActivityTagReddotShow(flag)
  self.ui.redDot:SetActive(flag)
end

function UINActivityFrameItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityFrameItem
