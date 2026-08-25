local UIComMonsterIconComponent, Super = System.NewComponent("UIComMonsterIconComponent")

function UIComMonsterIconComponent:ctor(node, view, stageId, monsterTid, callBack)
  Super.ctor(self, node, view)
  self.ui = UI_Dungeous_Item_MonsterResource(node)
  self.stageId = stageId
  self.monsterTid = monsterTid
  self.callBack = callBack
end

function UIComMonsterIconComponent:OnEnterComponent()
  local config = CopyDataUtils.GetMonsterConfig(self.monsterTid)
  if config then
    self:SetImage(self.ui.Image_icon, config.MiniIcon)
    if config.MonsterClass == CommonDefine.MonsterClass.Boss then
      self:SetActive(self.ui.Image_Boss, true)
      self:SetText(self.ui.Text_Boss, "首领")
    elseif config.MonsterClass == CommonDefine.MonsterClass.Elite then
      self:SetActive(self.ui.Image_Boss, true)
      self:SetText(self.ui.Text_Boss, "精英")
    else
      self:SetActive(self.ui.Image_Boss, false)
    end
    local level = CopyDataUtils.GetMonsterLevel(self.stageId, self.monsterTid)
    self:SetText(self.ui.Text_Level, "Lv." .. level)
    self:SetActive(self.ui.Text_Level, false)
  else
    Logger.Error("Monster Config没有找到, Config Id为：" .. self.monsterTid)
  end
  self:AddButtonClickListener(self.ui.Btn_Monster, function()
    if self.callBack then
      self.callBack(self.monsterTid)
    end
  end)
end

return UIComMonsterIconComponent
