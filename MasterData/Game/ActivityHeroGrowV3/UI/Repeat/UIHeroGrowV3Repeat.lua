local UIHeroGrowV3Repeat = class("UIHeroGrowV3Repeat", UIBaseWindow)
local base = UIBaseWindow
local TaskEnum = require("Game.Task.TaskEnum")
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")
local OfficialSupportHeroData = require("Game.Formation.Data.OfficialSupportHeroData")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIHeroGrowV3Repeat:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_ItemPic, self, self.__OnClickTicketItem)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  self.__RefreshHGV3Token = BindCallback(self, self.RefreshHGV3Token)
  self.__RefreshProtocol = BindCallback(self, self.RefreshProtocol)
  self.resloader = CS.ResLoader.Create()
  self.heroHeadPool = UIItemPool.New(UINCommonRankItemHeroHead, self.ui.obj_heroHeadItem, false)
  self.buffItemPool = UIItemPool.New(UINLevelNormalBuffItem, self.ui.obj_protoItem, false)
  self.__onClickHeadItem = BindCallback(self, self.__OnClickHeadItem)
  self.ui.obj_Cost:SetActive(true)
  self.ui.obj_PeroidListNode:SetActive(false)
  self.ui.obj_ChallengeTip:SetActive(false)
  self.ui.tex_ChallengeTip.gameObject:SetActive(false)
  self.ui.obj_RepeatTip:SetActive(true)
  self.ui.obj_Drop:SetActive(true)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshHGV3Token)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__RefreshProtocol)
end

function UIHeroGrowV3Repeat:InitHeroGrowV3Repeat(actData, backCallback)
  self.actData = actData
  self.backCallback = backCallback
  self.repeatCfg = self.actData:GetHGV3ReBrushCfg()
  self:RefreshHGV3Color()
  self:RefreshHGV3RepeatShow()
end

function UIHeroGrowV3Repeat:RefreshHGV3Color()
  local decoColor = self.actData:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
end

function UIHeroGrowV3Repeat:RefreshHGV3Token()
  if self.actData == nil then
    return
  end
  local ticketId = self.actData:GetHGV3RepeatTicketId()
  local ticketMaxNum = self.actData:GetHGV3RepeatMaxTicketNum()
  self.ui.tex_Num.text = string.format("%d/%d", PlayerDataCenter:GetItemCount(ticketId), ticketMaxNum)
end

function UIHeroGrowV3Repeat:RefreshHGV3RepeatShow()
  local logoPath = self.repeatCfg.dungeon_icon
  self.ui.img_Logo.sprite = AtlasUtil.GetSpriteFromAtlas("UI_CharDunRepeatVer3", logoPath, self.resloader)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.actData:GetHGV3RepeatName())
  self.ui.img_battle:SetIndex(0)
  local path = self.repeatCfg.background_pic
  local nameResPath = PathConsts:GetSectorEntrancTex(path)
  self.ui.img_Pic.enabled = false
  self.resloader:LoadABAssetAsync(nameResPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_Pic.enabled = true
    self.ui.img_Pic.texture = texture
  end)
  local dropItemId = self.actData:GetHeroGrowTokenId()
  local dropItemCfg = ConfigData.item[dropItemId]
  self.ui.img_DropIcon.sprite = CRH:GetSpriteByItemConfig(dropItemCfg, true)
  self.ui.tex_Drop:SetIndex(0, LanguageUtil.GetLocaleText(dropItemCfg.name))
  local ticketId = self.actData:GetHGV3RepeatTicketId()
  self.ui.img_ItemPic.sprite = CRH:GetSpriteByItemId(ticketId, false)
  self:RefreshHGV3Token()
  local assistanceId = self.repeatCfg.assistance_id
  local officialAssistCfg = ConfigData.official_assist[assistanceId]
  self.heroHeadPool:HideAll()
  if officialAssistCfg ~= nil then
    for index, heroId in ipairs(officialAssistCfg.param1) do
      local assistCfgId = officialAssistCfg.assist_lvs[index]
      local power = officialAssistCfg.effective[index]
      local assisLvCfg = ConfigData.assist_level[assistCfgId]
      local osHeroData = OfficialSupportHeroData.GenOfficialSupportHeroData(heroId, assisLvCfg, power)
      osHeroData:SetOfficialSupportCfgId(assistanceId)
      local item = self.heroHeadPool:GetOne()
      item:InitHead(heroId, assisLvCfg.hero_level, assisLvCfg.hero_rank, self.__onClickHeadItem)
      item:SetHeadHeroData(osHeroData)
    end
  end
  self:RefreshProtocol()
end

function UIHeroGrowV3Repeat:RefreshProtocol()
  local taskId = self.repeatCfg.buff_task
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
  local complete = taskData:IsPickedTaskReward() or taskData:CheckComplete()
  local schedule, aim = taskData:GetTaskProcess()
  self.ui.obj_Unlock:SetActive(complete)
  self.ui.obj_Lock:SetActive(not complete)
  if complete then
    self.ui.tex_ProRepeatTip:SetIndex(0, LanguageUtil.GetLocaleText(self.repeatCfg.buff_name))
  else
    self.ui.tex_ProRepeatTip:SetIndex(1, taskData:GetTaskFirstStepIntro(), tostring(schedule), tostring(aim))
  end
  self.__showBuffIdList = {}
  local battleCfg = ConfigData.battle_dungeon[self.repeatCfg.dungeon_id]
  local protocol = battleCfg.protocol
  for _, buffId in pairs(protocol) do
    table.insert(self.__showBuffIdList, buffId)
  end
  self.buffItemPool:HideAll()
  for _, buffId in pairs(self.__showBuffIdList) do
    local buffCfg = ConfigData.dungeon_buff[buffId]
    if buffCfg ~= nil then
      local buffItem = self.buffItemPool:GetOne()
      buffItem:InitBuffByCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
end

function UIHeroGrowV3Repeat:OnClickBattle()
  local levelData = self.actData:GetHGV3DunRepeatData()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    window:SetDunLevelDetaiHideStartEvent(function()
    end)
    window:SetDunLevelDetaiHideEndEvent(function()
    end)
    window:InitDungeonLevelDetail(levelData, false)
    window:SetDungeonLevelBgClose(true)
  end)
end

function UIHeroGrowV3Repeat:__OnClickTicketItem()
  local ticketId = self.actData:GetHGV3RepeatTicketId()
  local itemCfg = ConfigData.item[ticketId]
  local win = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  win:InitCommonItemDetail(itemCfg)
end

function UIHeroGrowV3Repeat:__OnClickHeadItem(heroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
    if win == nil then
      return
    end
    win:InitSupportHeroState(heroData)
  end)
end

function UIHeroGrowV3Repeat:ShowBuffDescription(item, buffCfg)
  local window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  window:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  window:FloatTo(item.transform, HAType.autoCenter, VAType.up, 0, 0.62)
end

function UIHeroGrowV3Repeat:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UIHeroGrowV3Repeat:__OnClickClose()
  if self.backCallback ~= nil then
    self.backCallback(false)
  end
  self:Delete()
end

function UIHeroGrowV3Repeat:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.heroHeadPool:DeleteAll()
  self.heroHeadPool = nil
  self.buffItemPool:DeleteAll()
  self.buffItemPool = nil
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshHGV3Token)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__RefreshProtocol)
end

return UIHeroGrowV3Repeat
