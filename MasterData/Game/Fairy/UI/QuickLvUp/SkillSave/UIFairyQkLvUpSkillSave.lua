local base = UIBaseWindow
local UIFairyQkLvUpSkillSave = class("UIFairyQkLvUpSkillSave", base)
local UINFyQkLvSkillSvItem = require("Game.Fairy.UI.QuickLvUp.SkillSave.UINFyQkLvSkillSvItem")
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local cs_MessageCommon = CS.MessageCommon

function UIFairyQkLvUpSkillSave:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickClose):SetTopStatusVisible(false):SetTopstatusBlockEsc(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfrm)
  self._resloader = CS.ResLoader()
  self._skillItemPool = UIItemPool.New(UINFyQkLvSkillSvItem, self.ui.skillItem, false)
  self._skillDetailPool = UIItemPool.New(UINFairySkillUpgradeItem, self.ui.uINFairySkillCard, false)
  self._OnClickSkillItemFunc = BindCallback(self, self._OnClickSkillItem)
end

function UIFairyQkLvUpSkillSave:InitFairyQkLvUpSkillSave(fairyData, fySkillDataList, targetStar)
  self._fairyData = fairyData
  self._startStar = self._fairyData:GetFairyCurStar()
  self._skillNumMax = fairyData:GetFyStarSkillNum(targetStar)
  self._curSkillNum = 0
  table.sort(fySkillDataList, function(a, b)
    local aq = a:GetFairySkillRareLevel()
    local bq = b:GetFairySkillRareLevel()
    if aq ~= bq then
      return aq < bq
    end
    return a.fairySkillId < b.fairySkillId
  end)
  self._skillItemPool:HideAll()
  for k, skillData in ipairs(fySkillDataList) do
    local item = self._skillItemPool:GetOne()
    item:InitFyQkLvSkillSvItem(skillData, self._resloader, self._OnClickSkillItemFunc)
  end
  self._selectedSkillDic = {}
  self._selectedSkillList = {}
  self:_UpdState()
end

function UIFairyQkLvUpSkillSave:_UpdState()
  self.ui.tex_Confirm:SetIndex(0, tostring(self._curSkillNum), tostring(self._skillNumMax))
  self._skillDetailPool:HideAll()
  for k, uid in ipairs(self._selectedSkillList) do
    local skillData = self._selectedSkillDic[uid]
    local item = self._skillDetailPool:GetOne()
    item:InitFairySkillUpgradeItem(skillData, self._resloader)
  end
  self.ui.obj_Tip:SetActive(self._curSkillNum == 0)
  local isSelectedOk = self._curSkillNum == self._skillNumMax
  local btColor = isSelectedOk and Color.white or Color.gray
  self.ui.btn_Confirm.targetGraphic.color = btColor
  self.ui.tex_Confirm.text.color = btColor
  for k, v in ipairs(self._skillItemPool.listItem) do
    local uid = v.fairySkillData:GetSkillUid()
    v:ShowFySkillItemMask(isSelectedOk and self._selectedSkillDic[uid] == nil)
  end
end

function UIFairyQkLvUpSkillSave:_OnClickSkillItem(fairySkillData, isSelected, item)
  local uid = fairySkillData:GetSkillUid()
  if self._selectedSkillDic[uid] ~= nil then
    self._selectedSkillDic[uid] = nil
    table.removebyvalue(self._selectedSkillList, uid)
  else
    if self._curSkillNum >= self._skillNumMax then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22020))
      return
    end
    self._selectedSkillDic[uid] = fairySkillData
    table.insert(self._selectedSkillList, uid)
  end
  item:SetSelected()
  self._curSkillNum = #self._selectedSkillList
  self:_UpdState()
end

function UIFairyQkLvUpSkillSave:_OnClickConfrm()
  if self._curSkillNum < self._skillNumMax then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22005))
    return
  end
  local uid = self._fairyData:GetFairyUID()
  NetworkManager:GetNetwork(NetworkTypeID.Fairy):CS_Fairy_FastUpgradeKeep(uid, self._selectedSkillList, function(objList)
    local win = UIManager:GetWindow(UIWindowTypeID.FairyCultivateMain)
    if win then
      win:OnFairyUpStarSuccess(nil, self._startStar)
    end
    UIUtil.OnClickBackByUiTab(self)
  end)
end

function UIFairyQkLvUpSkillSave:_OnClickClose()
  self:Delete()
  if self._closeFunc then
    self._closeFunc()
  end
end

function UIFairyQkLvUpSkillSave:OnDelete()
  self._resloader:Put2Pool()
  self._resloader = nil
  self._skillDetailPool:DeleteAll()
  self._skillItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIFairyQkLvUpSkillSave
