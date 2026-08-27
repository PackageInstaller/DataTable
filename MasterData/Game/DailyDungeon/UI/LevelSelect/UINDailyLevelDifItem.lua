local UINDailyLevelDifItem = class("UINDailyLevelDifItem", UIBaseNode)
local base = UIBaseNode
local ItemPosEnum = {Up = 1, Dowm = 2}
local ItemPosDic = {
  [ItemPosEnum.Up] = Vector3.New(0, 150, 0),
  [ItemPosEnum.Dowm] = Vector3.New(0, -180, 0)
}

function UINDailyLevelDifItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_QucikFight, self, self.OnClickQuickBattle)
end

function UINDailyLevelDifItem:InitDailyLevelDifItem(index, matDungeonCfg, clickFunc, dungeonDyncElem)
  self.clickFunc = clickFunc
  self.matDungeonCfg = matDungeonCfg
  self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(matDungeonCfg.name)
  self.ui.tex_SubName:SetIndex(0, string.format("%02d", index))
  self.ui.img_Tag.color = self.ui.diffColor[index]
  self.ui.tex_Tag:SetIndex(index - 1)
  self.ui.tex_Traget:SetIndex(index - 1)
  self:SetItemPos(index % 2 == 0 and ItemPosEnum.Up or ItemPosEnum.Dowm)
  local unlock = FunctionUnlockMgr:ValidateUnlock(matDungeonCfg.id)
  self.ui.unlockCondition:SetActive(not unlock)
  if not unlock then
    self.ui.tex_Unlock.text = FunctionUnlockMgr:GetFuncUnlockDecription(matDungeonCfg.id)
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local enterNum = timePassCtrl:GetCounterModuleDungeonEnter(matDungeonCfg.id)
  local isNew = unlock and enterNum == 0
  self.ui.isNew:SetActive(isNew)
  local dropRangeCfg = matDungeonCfg.drop_range
  if #dropRangeCfg ~= 3 then
    error("matDungeonCfg.drop_range num error, id:" .. tostring(matDungeonCfg.id))
  else
    local itemId = dropRangeCfg[1]
    local itemCfg = ConfigData.item[itemId]
    self.ui.img_Drop.sprite = CRH:GetSpriteByItemConfig(itemCfg)
    self.ui.tex_DropRange:SetIndex(0, tostring(dropRangeCfg[2]), tostring(dropRangeCfg[3]))
  end
  local battleDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
  local inBattle = dungeonDyncElem ~= nil
  self.ui.process:SetActive(inBattle)
  self.ui.unProcess:SetActive(not inBattle)
  if inBattle then
    local allNum = #matDungeonCfg.stage_id
    local curNum = dungeonDyncElem.idx
    local progress = math.floor(curNum / allNum * 100)
    self.ui.tex_Process:SetIndex(0, tostring(progress))
    local profSex = PlayerDataCenter.inforData:GetSex()
    local index = profSex == true and 1 or 0
    self.ui.img_ProfHead:SetIndex(index)
  elseif unlock then
    self.ui.tex_unProcess:SetIndex(battleDyncElem.isDailyDungeonNew and 0 or 1)
  end
  local titltCol = inBattle and self.ui.col_inBattleCol or Color.white
  self.ui.img_title.color = titltCol
  local canQuick = battleDyncElem:IsDailyModuleCanQuick(matDungeonCfg.id)
  local cansShowQuickUI = unlock and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeonQuick)
  self.ui.btn_QucikFight.gameObject:SetActive(cansShowQuickUI)
  if cansShowQuickUI then
    if canQuick then
      local color = self.ui.img_QucikFight.color
      color.a = self.ui.alpha_quickOpen
      self.ui.img_QucikFight.color = color
      self.ui.img_QucikFightIcon.color = self.ui.color_quickOpen
      self.ui.img_QucikFightIcon.color = self.ui.color_quickClose
    else
      local color = self.ui.img_QucikFight.color
      color.a = self.ui.alpha_quickClose
      self.ui.img_QucikFight.color = color
      self.ui.img_QucikFightIcon.color = self.ui.color_quickClose
      self.ui.img_QucikFightIcon.color = self.ui.color_quickClose
    end
    local isOpen = PlayerDataCenter:IsDungeonModuleOpenQuick(matDungeonCfg.id)
    self.ui.obj_Lock:SetActive(not isOpen)
  end
end

function UINDailyLevelDifItem:SetItemPos(pos)
  self.ui.rect_bg.localPosition = ItemPosDic[pos]
end

function UINDailyLevelDifItem:BindQuickBattleFunc(func)
  self._quickBattleFunc = func
end

function UINDailyLevelDifItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.matDungeonCfg)
  end
end

function UINDailyLevelDifItem:OnClickQuickBattle()
  if self._quickBattleFunc ~= nil then
    self._quickBattleFunc(self.matDungeonCfg)
  end
end

function UINDailyLevelDifItem:OnDelete()
  base.OnDelete(self)
end

return UINDailyLevelDifItem
