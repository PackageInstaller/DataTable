local this = class("moduleHomeScienceRight", G_UIModuleBase)
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()
local UnityEngine = CS.UnityEngine
local RectOffset = UnityEngine.RectOffset
local _typeIcon = {
  [1] = "UI/Page/HomeScience/tex_homescience_icon_sj1.png",
  [2] = "UI/Page/HomeScience/tex_homescience_icon_sj2.png"
}

function this.bind()
  return {
    txt_name = "",
    activeImgIcon = false,
    activeImgIcon2 = false,
    img_icon = "",
    img_icon2 = "",
    go_effectLastOrNow = false,
    go_effectNext = false,
    txt_effectLastOrNowTag = "",
    txt_effectNextTag = "",
    txt_effectLastOrNow = "",
    txt_effectNext = "",
    active_effectDescScroll = true,
    active_maxLevelPanel = true,
    txt_effectMaxLevel = "",
    txt_maxLevel = "",
    active_study = true,
    active_study_btn = true,
    text_limit = "",
    ative_limit = false,
    active_look = false,
    cellItem = L_Const.ModuleInfo.CellIconBag,
    activeLockIcon = false,
    activeUpgradeIcon = false,
    activeMaxLevelIcon = false,
    activeStudyIcon = false,
    txt_needMaterial = L_WordsTpl:getValue("ui_pet_rank_cost")
  }
end

function this.methods()
  return {
    onClick_study = function(self)
      self:study()
    end,
    onClick_look = function(self)
      local tplTechTree = _homeTechnologyTreeTpl:getTplById(self.techTreeId)
      local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.techTreeId, self.techLevel)
      local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
      local products = _homeTechnologyTpl:getNewTechnologyProduct(homeTechnologyTpl)
      local items = {}
      for _, v in ipairs(products) do
        table.insert(items, {
          itemType = L_Const.resType.commonItem,
          itemId = v
        })
      end
      L_UI:open("pageAddItemTip", {
        title = _homeTechnologyTreeTpl:getName(tplTechTree),
        content1 = L_WordsTpl:getValue("science_newItem"),
        showType = L_Const.commonTipsShowType.OnlyClose,
        items = items
      })
    end,
    onClick_Close = function(self)
      self:close()
    end
  }
end

function this:open(techTreeId)
  if not self._isOpened then
    this.super.open(self)
  end
  if techTreeId then
    self:updatePage(techTreeId)
    self:onPlayAnim("anim_sciencetip_in")
  end
  self._isOpened = true
end

function this:close()
  if self._isOpened then
    this.super.close(self)
    self:onPlayAnim("anim_sciencetip_out")
  end
  self.parent:clearSelect()
  self._isOpened = nil
end

function this:updatePage(techTreeId)
  self.techTreeId = techTreeId
  local tplTechTree = _homeTechnologyTreeTpl:getTplById(techTreeId)
  if not tplTechTree then
    errorf("homeTechnologyTree缺少配置 " .. tostring(techTreeId))
    return
  end
  self.techLevel = L_TechnologyStore:getCurTechnologyLevelById(techTreeId)
  local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.techTreeId, self.techLevel)
  local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
  self.bind.txt_name = _homeTechnologyTpl:getObjName(homeTechnologyTpl)
  if _homeTechnologyTreeTpl:getNodeType(tplTechTree) == 1 then
    self.bind.activeImgIcon = false
    self.bind.activeImgIcon2 = true
    self.bind.img_icon2 = _homeTechnologyTreeTpl:getIcon(tplTechTree)
  else
    self.bind.activeImgIcon = true
    self.bind.activeImgIcon2 = false
    self.bind.img_icon = _homeTechnologyTreeTpl:getIcon(tplTechTree)
  end
  local maxLevel = self.techLevel == 0 and 1 or L_TechnologyStore:getCurTechnologyMaxLevelById(techTreeId)
  self.maxLevel = maxLevel
  self:setTechStateIcon()
  if self.techLevel > 0 then
    self.bind.go_effectLastOrNow = true
    self.bind.txt_effectLastOrNowTag = L_WordsTpl:getValue("science_levelUp_01")
    self.bind.txt_effectLastOrNow = _homeTechnologyTpl:getEffectDescription(homeTechnologyTpl)
  else
    self.bind.go_effectLastOrNow = false
  end
  local nextLevel = self.techLevel + 1
  if maxLevel >= nextLevel then
    self.bind.go_effectNext = true
    local nextLevelHomeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.techTreeId, nextLevel)
    local nextLevelHomeTechnologyTpl = _homeTechnologyTpl:getTplById(nextLevelHomeTechnologyTplId)
    self.bind.txt_effectNextTag = L_WordsTpl:getValue("science_levelUp_02")
    self.bind.txt_effectNext = _homeTechnologyTpl:getEffectDescription(nextLevelHomeTechnologyTpl)
  else
    self.bind.go_effectNext = false
  end
  if maxLevel <= self.techLevel then
    self.bind.active_study = false
    self.bind.active_effectDescScroll = false
    self.bind.active_maxLevelPanel = true
    self.bind.txt_effectMaxLevel = _homeTechnologyTpl:getEffectDescription(homeTechnologyTpl)
    self.bind.txt_maxLevel = L_WordsTpl:getValue("science_maxLevel")
  else
    self.bind.active_study = true
    self.bind.active_effectDescScroll = true
    self.bind.active_maxLevelPanel = false
    local curLevel = L_PlayerStore:getLv()
    local upgradeCondition = _homeTechnologyTpl:getUnlockCondi1(homeTechnologyTpl)
    local isSatisfy, _ = L_ConditionManager:isComplete(upgradeCondition)
    self.bind.ative_limit = not isSatisfy
    self.bind.active_study_btn = isSatisfy
    if not isSatisfy then
      local ifLevelNotEnough = false
      local conditionLv
      for _, eachCondition in pairs(upgradeCondition) do
        local conditionType = eachCondition[1]
        if conditionType == L_CodConst.enum.reachLv then
          conditionLv = eachCondition[2]
          if curLevel < conditionLv then
            ifLevelNotEnough = true
            break
          end
        end
      end
      if ifLevelNotEnough then
        self.bind.text_limit = L_WordsTpl:getValue("science_limitLevel", {
          [0] = conditionLv
        })
      else
        self.bind.text_limit = L_WordsTpl:getValue("science_limitPrevious")
      end
    end
    local type = _homeTechnologyTreeTpl:getType(tplTechTree)
    local pointNow = L_TechnologyStore:getTechTypeInfo(type).point
    local num = _homeTechnologyTpl:getPoint(homeTechnologyTpl)
    if pointNow < num then
      num = L_GameUtil.fillColor(num, L_Const.colorHtml.red001)
    end
    self.bind.active_look = 0 < #_homeTechnologyTpl:getNewTechnologyProduct(homeTechnologyTpl)
    self.modules.cellItem:setGeneralContent(L_Const.resType.currency, self.parent.currencyID, {
      itemNumTxt = tostring(num)
    })
  end
  local contentRect = self.bindComponents.contentRect
  local scollView = self.bindComponents.descScroll
  if self.bind.go_effectLastOrNow and self.bind.go_effectNext then
    contentRect.anchoredPosition = C_Vector2(contentRect.anchoredPosition.x, 0)
    scollView.enabled = true
  else
    scollView.enabled = false
    contentRect.anchoredPosition = C_Vector2(contentRect.anchoredPosition.x, -30)
  end
end

function this:setTechStateIcon()
  self.bind.activeLockIcon = false
  self.bind.activeUpgradeIcon = false
  self.bind.activeMaxLevelIcon = false
  self.bind.activeStudyIcon = false
  local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.techTreeId, self.techLevel)
  local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
  local upgradeCondition = _homeTechnologyTpl:getUnlockCondi1(homeTechnologyTpl)
  local isSatisfy, _ = L_ConditionManager:isComplete(upgradeCondition)
  if self.techLevel == self.maxLevel then
    self.bind.activeMaxLevelIcon = true
  elseif self.techLevel > 0 then
    self.bind.activeUpgradeIcon = true
  elseif isSatisfy then
    self.bind.activeStudyIcon = true
  else
    self.bind.activeLockIcon = true
  end
end

function this:study()
  local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.techTreeId, self.techLevel)
  local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
  local needPoint = _homeTechnologyTpl:getPoint(homeTechnologyTpl)
  local tplTechTree = _homeTechnologyTreeTpl:getTplById(self.techTreeId)
  local type = _homeTechnologyTreeTpl:getCategory(tplTechTree)
  local pointNow = L_TechnologyStore:getTechTypeInfo(type).point
  if needPoint > pointNow then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("science_limitPointTip"))
    return
  end
  self.parent:setPendingNode(self.techTreeId, self.techLevel)
  if self._job then
    co.stop(self._job)
  end
  self._job = co.start(function()
    co.call(L_TechnologyStore.req_homeTechnologyLevelUp, L_TechnologyStore, type, self.techTreeId, co.callback)
    self.parent:pendingNodeUpgrade()
    co.wait(0.5, co.phase.unscaled)
    self.parent:lockingNodesUnlock()
  end)
  self:close()
end

function this:onEventRefreshData()
  self:updatePage(self.techTreeId)
end

function this:onPlayAnim(animName)
  self.bindComponents.anim_dyna:Play(animName)
end

return this
