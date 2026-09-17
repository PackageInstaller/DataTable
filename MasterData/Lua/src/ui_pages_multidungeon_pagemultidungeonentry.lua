local this = class("pageMultiDungeonEntry", G_UIPageBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _staminaChestDropTpl = L_GameTpl:getStaminaChestDropTpl()
local _multiDungeonTpl = L_GameTpl:getMultiDungeonTpl()
local _multiDungeonGroupTpl = L_GameTpl:getMultiDungeonGroupTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _skillTpl = L_GameTpl:getSkillTpl()
local MaxDifficulty = 5
local MinDifficulty = 1

function this.bind()
  return {
    isOn_menu = false,
    module_star = {
      moduleName = "modulePages/moduleStarRating"
    },
    txt_recommendLevel = nil,
    scrollList_dungeon = {
      moduleName = "pages/multiDungeon/cellMultiDungeon"
    },
    txt_name = nil,
    txt_address = nil,
    txt_score = nil,
    img_grade = nil,
    list_skill = {
      moduleName = "pages/heroPanel/skill/cellHeroSkillIcon"
    },
    txt_desc = nil,
    list_bossElement = {
      moduleName = "pages/elementalRestraint/cellElementIcon"
    },
    img_boss = nil,
    list_challenge = {
      moduleName = "pages/multiDungeon/cellMultiDungeonChallenge"
    },
    list_reward = L_Const.ModuleInfo.CellIconBag,
    btn_start = L_Const.ModuleInfo.ButtonSingle
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_switch = function(self)
      self:initMenu()
    end,
    onClick_pre = function(self)
      self:changeDifficulty(-1)
    end,
    onClick_next = function(self)
      self:changeDifficulty(1)
    end,
    scrollList_dungeon = {
      onClick_select = function(self, bind)
        self._selectDungeonId = bind.dungeonId
        self:initDetail()
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._difficulty = 1
  self:initMenu()
end

function this:initMenu()
  self.bind.isOn_menu = true
  self.modules.module_star:refreshStar(self._difficulty)
  self.bind.txt_recommendLevel = L_WordsTpl:getValue("notice_pageMultiDungeonEntry_01", {
    [0] = L_GameConstTpl:getData("MULIT_DUNGEON_DIFFICULTY", L_Const.GameTplType.list_list_int)[self._difficulty][2]
  })
  local dataList = _multiDungeonGroupTpl:getOpenTplList()
  local tmp = {}
  for i, v in pairs(dataList) do
    local tpl_multiDungeon = _multiDungeonTpl:getTplByGroupAndDifficult(_multiDungeonGroupTpl:getDungeonGroupId(v), self._difficulty)
    table.insert(tmp, {
      dungeonId = _multiDungeonTpl:getId(tpl_multiDungeon)
    })
  end
  self.bind.scrollList_dungeon:clear()
  self.bind.scrollList_dungeon:insert_array(tmp)
end

function this:initDetail()
  self.bind.isOn_menu = false
  self.bind.txt_score = nil
  self.bind.txt_grade = nil
  local tpl_dungeon = _multiDungeonTpl:getTplById(self._selectDungeonId)
  self.bind.txt_desc = _multiDungeonTpl:getBossDes(tpl_dungeon)
  self.bind.txt_address = _multiDungeonTpl:getBossPos(tpl_dungeon)
  local bossId = _multiDungeonTpl:getBossId(tpl_dungeon)
  local tpl_enemy = _enemyTpl:getTplById(bossId)
  local skillList = _enemyTpl:getSkillList(tpl_enemy)
  local tmp_skill = {}
  for skillSlotType, skillId in pairs(skillList) do
    local tpl = _skillTpl:getTplById(skillId)
    table.insert(tmp_skill, {
      iconPath = _skillTpl:getIcon(tpl),
      borderImgColor = L_Const.skillBorderIcon[type],
      skillId = skillId
    })
  end
  self.bind.list_skill:clear()
  self.bind.list_skill:insert_array(tmp_skill)
  local tmp_element = {}
  local bossElement = _enemyTpl:getElement(tpl_enemy)
  for i, v in pairs(bossElement) do
    local tpl_ele = _elementTypeTpl:getTplById(v)
    local _, color = C_ColorUtility.TryParseHtmlString(_elementTypeTpl:getDungeonElementColor(tpl_ele))
    table.insert(tmp_element, {
      icon = _elementTypeTpl:getDungeonElementIcon(tpl_ele),
      iconColor = color
    })
  end
  self.bind.list_bossElement:clear()
  self.bind.list_bossElement:insert_array(tmp_element)
  self.bind.img_boss = _multiDungeonTpl:getBossPic(tpl_dungeon)
  local challenge = _multiDungeonTpl:getChallenge(tpl_dungeon)
  local challengeDesc = _multiDungeonTpl:getChallengeDes(tpl_dungeon)
  local tmp_challenge = {}
  for i, v in ipairs(challenge) do
    table.insert(tmp_challenge, {
      txt_name = challengeDesc[i]
    })
  end
  self.bind.list_challenge:clear()
  self.bind.list_challenge:insert_array(tmp_challenge)
  local tpl_staminaChest = _staminaChestDropTpl:getTplByWorldFilter(L_Const.StaminaBoxSystemType.SBST_MULTI_CAMPAIGN, self._selectDungeonId)
  local leftRewardTime, isUp = L_StaminaChestManager:getStaminaRewardTimes(_staminaChestDropTpl:getId(tpl_staminaChest))
  local reward = L_DataUtil.parseRangeRewardConfig(isUp and _staminaChestDropTpl:getRewardDisplayUp(tpl_staminaChest) or _staminaChestDropTpl:getRewardDisplay(tpl_staminaChest))
  self.bind.list_reward:clear()
  self.bind.list_reward:insert_array(reward)
  local needCost = L_DataUtil.parseRewardConfig(_staminaChestDropTpl:getNeed(tpl_staminaChest))[1]
  local isCostEnough = L_ItemTplManager:getItemNum(needCost.itemType, needCost.itemId) >= needCost.itemNum
  self.modules.btn_start:setData(L_WordsTpl:getValue("notice_pageMultiDungeonEntry_02"), handler(self, self.onClickStart), {
    itemType = L_Const.resType.currency,
    itemId = L_Const.currencyType.stamina,
    txtNum = isCostEnough and tostring(needCost.itemNum) or L_GameUtil.fillColor(needCost.itemNum, L_Const.colorHtml.red01)
  })
end

function this:onClickStart()
  local matchStatus = L_MultiDungeonStore:getMatchStatus()
  if matchStatus ~= L_MultiDungeonConst.MatchStatus.None then
    L_FlyMsgManager:showNormalMsgByKey("notice_pageMultiDungeonEntry_03")
    return
  end
  L_MultiDungeonStore:req_CSProtoCreateMatchTeam(self._selectDungeonId, function()
    L_UI:close(self.pageName)
  end)
end

function this:changeDifficulty(index)
  self._difficulty = self._difficulty + index
  if self._difficulty > MaxDifficulty then
    self._difficulty = MinDifficulty
  elseif self._difficulty < MinDifficulty then
    self._difficulty = MaxDifficulty
  end
  self:initMenu()
end

return this
