local this = class("pageTalentBreakConfirm", G_UIPageBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()

function this.bind()
  return {
    module_commonTipSmall = L_Const.ModuleInfo.ModuleCommonTip,
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    sortingOrder_page = nil,
    beforeLevelLimit = "",
    curLevelLimit = "",
    propList = {
      moduleName = "pages/heroPanel/hero/heroProperty"
    },
    costList = L_Const.ModuleInfo.CellIconBag,
    breakBtn = L_Const.ModuleInfo.ModuleBtn,
    active_cost = false
  }
end

function this.methods()
  return {
    module_commonTipSmall = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        if self._params.confirmCallback then
          self._params.confirmCallback()
        end
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.selectedIndex = 1
  self:refreshPage(options)
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipSmall:initModule(params)
  if not math.isEmpty(params.overrideSortingOrder) then
    self.bind.sortingOrder_page = params.overrideSortingOrder
  end
  local hero = L_HeroStore:getHero(params.heroGuid)
  local configId = L_HeroStore:getHeroConfigId(hero)
  local currentRank = L_HeroStore:getHeroRank(hero)
  local nextRank = currentRank + 1
  local currentTpl = talentRankTpl:getHeroRankTpl(configId, currentRank)
  local nextTpl = talentRankTpl:getHeroRankTpl(configId, nextRank)
  self.bind.beforeLevelLimit = "Lv." .. tostring(talentRankTpl:getRank(currentTpl))
  self.bind.curLevelLimit = "Lv." .. tostring(talentRankTpl:getRank(nextTpl))
  local costs = talentRankTpl:getRankBreakthroughCoin(currentTpl)
  local breakBtnData
  for _, v in pairs(costs) do
    if v[1] == L_Const.resType.currency then
      breakBtnData = {
        itemType = v[1],
        itemId = v[2],
        itemNum = v[3]
      }
    end
  end
  local btnParams = {
    txtName = L_WordsTpl:getValue("ui_hero_rune_level_up"),
    callback = function()
      if self._params.confirmCallback then
        self._params.confirmCallback()
      end
    end
  }
  if breakBtnData ~= nil then
    btnParams.itemType = breakBtnData.itemType
    btnParams.itemId = breakBtnData.itemId
    btnParams.itemNum = breakBtnData.itemNum
    btnParams.itemNumTxt = tostring(breakBtnData.itemNum)
  end
  self.modules.breakBtn:setData(btnParams)
  self:initPropList(currentTpl)
  self:initCostList(currentTpl)
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.heroTalent)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
end

function this:initPropList(rankTpl)
  local data = {}
  local attributes = talentRankTpl:getAttribute(rankTpl)
  local property = L_HeroStore:getHeroPropertyMap(self._params.heroGuid)
  for k, v in pairs(attributes) do
    local curValue = property[k] or 0
    if table.containsValue(L_Const.SpecialAttList, k) then
      curValue = k == 5 and math.floor(curValue / 10000) or math.round(curValue / 10000)
    else
      curValue = math.round(curValue)
    end
    if curValue < 0 then
      curValue = 0
    end
    local nextValue = curValue + v
    local tpl = battleInfoTpl:getTplById(k)
    table.insert(data, {
      toggle_state = true,
      curAttr = battleInfoTpl:getShowTxtComma(k, curValue),
      nextAttr = battleInfoTpl:getShowTxtComma(k, nextValue),
      name = battleInfoTpl:getName(tpl),
      icon = battleInfoTpl:getIcon(tpl),
      active_icon = true
    })
  end
  self.bind.propList:clear()
  self.bind.propList:insert_array(data)
end

function this:initCostList(rankTpl)
  local data = {}
  local costs = talentRankTpl:getRankBreakthroughCoin(rankTpl)
  for _, v in pairs(costs) do
    if v[1] ~= L_Const.resType.currency then
      local needNum = v[3]
      local hadNum = L_ItemTplManager:getItemNum(v[1], v[2])
      local itemNumTxt = needNum <= hadNum and tostring(hadNum) or L_GameUtil.fillColor(hadNum, "#FF7E6D")
      itemNumTxt = string.format("%s/%s", itemNumTxt, needNum)
      table.insert(data, {
        itemType = v[1],
        itemId = v[2],
        itemNum = needNum,
        itemNumTxt = itemNumTxt
      })
    end
  end
  self.bind.costList:clear()
  self.bind.costList:insert_array(data)
  if 0 < #data then
    self.bind.active_cost = true
  else
    self.bind.active_cost = false
  end
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
end

function this:escHandle()
  if self._params.closeCallbackTemp then
    self._params.closeCallbackTemp()
  end
  L_UI:close(self.pageName)
end

return this
