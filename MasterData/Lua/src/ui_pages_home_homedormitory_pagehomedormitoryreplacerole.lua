local _homeDormSceneTpl = L_GameTpl:getHomeDormSceneTpl()
local this = class("pageHomeDormitoryReplaceRole", G_UIPageBase)

function this.bind()
  return {
    list_cellDormitoryReplaceRole = {
      moduleName = "pages/home/homeDormitory/cellDormitoryReplaceRole"
    },
    text_btn_confirm = ""
  }
end

function this.methods()
  return {
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_confirm = function(self)
      self:onClickConfirm()
    end,
    list_cellDormitoryReplaceRole = {
      onClick_content = function(self, selectHeroGuid)
        self:setSelectHeroGuid(selectHeroGuid)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self.pageData = {}
  self.pageData.isInit = true
  self.pageData.index = options.index
  self.pageData.buildingGuid = options.buildingGuid
  self.pageData.curExchangeHeroGuid = options.curExchangeHeroGuid
  self.pageData.callback = options.callback
  self.pageData.selectHeroGuid = nil
end

function this:open()
  self:refreshHeroData()
  self:refreshHeroList()
  self:refreshConfirmBtnText()
  self.pageData.isInit = false
end

function this:refreshHeroData()
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  local randomBuildingGuid
  local csBuildingGuid2HomeBuildDataDic = csHomeStore:GetBuildDatas()
  for buildingGuid, _ in pairs(csBuildingGuid2HomeBuildDataDic) do
    randomBuildingGuid = buildingGuid
  end
  local homeBuildData = csHomeStore:GetBuildData(self.pageData.buildingGuid or randomBuildingGuid)
  local csHomeDormHeroGuidList = homeBuildData:GetHomeDormHeroGuidList()
  self.pageData.heroGuidInCurHomeDormDic = {}
  local nowDormDic = {}
  for i, v in pairs(csHomeDormHeroGuidList) do
    nowDormDic[v] = true
  end
  local heroMap = L_HeroStore:getAllHero()
  self.pageData.allHeroGuidList = {}
  for _, v in pairs(heroMap) do
    local heroGuid = v.guid
    local heroItemInfo = L_HeroStore:getHero(v.guid)
    local heroId = L_HeroStore:getHeroConfigId(heroItemInfo)
    local conf = _homeDormSceneTpl:getTplById(heroId)
    if heroGuid ~= L_HeroStore:getDefaultHeroGuid() and conf ~= nil then
      self.pageData.heroGuidInCurHomeDormDic[heroGuid] = csHomeStore:OnCheckPlayerIsInDormById(heroId)
      table.insert(self.pageData.allHeroGuidList, heroGuid)
    end
  end
  table.sort(self.pageData.allHeroGuidList, function(a, b)
    local aInNowDorm = nowDormDic[a] == true
    local bInNowDorm = nowDormDic[b] == true
    local aInHomeDorm = self.pageData.heroGuidInCurHomeDormDic[a] == true
    local bInHomeDorm = self.pageData.heroGuidInCurHomeDormDic[b] == true
    if aInNowDorm ~= bInNowDorm then
      return aInNowDorm
    elseif aInHomeDorm ~= bInHomeDorm then
      return not aInHomeDorm
    else
      return a < b
    end
  end)
end

function this:refreshHeroList()
  local insertArrayTable = {}
  for _ = 1, #self.pageData.allHeroGuidList do
    table.insert(insertArrayTable, {})
  end
  self.bind.list_cellDormitoryReplaceRole:clear()
  self.bind.list_cellDormitoryReplaceRole:insert_array(insertArrayTable)
  for i = 1, #self.bind.list_cellDormitoryReplaceRole do
    local cellDormitoryReplaceRole = self.bind.list_cellDormitoryReplaceRole:getItemCls(i)
    local heroGuid = self.pageData.allHeroGuidList[i]
    local isInCurHomeDorm = self.pageData.heroGuidInCurHomeDormDic[heroGuid] == true
    local curExchangeHeroGuid = self.pageData.curExchangeHeroGuid
    local order = i
    cellDormitoryReplaceRole:setData(heroGuid, isInCurHomeDorm, curExchangeHeroGuid, order)
    cellDormitoryReplaceRole:refreshView()
  end
end

function this:refreshConfirmBtnText()
  if self.pageData.curExchangeHeroGuid ~= nil then
    if self.pageData.selectHeroGuid == nil or self.pageData.selectHeroGuid == self.pageData.curExchangeHeroGuid then
      self.bind.text_btn_confirm = L_Lang:get(L_WordsTpl:getValue("ui_friend_13"))
    else
      self.bind.text_btn_confirm = L_Lang:get(L_WordsTpl:getValue("ui_spirit_switch_btn"))
    end
  else
    self.bind.text_btn_confirm = L_Lang:get(L_WordsTpl:getValue("ui_moduleFriendList_03"))
  end
end

function this:setSelectHeroGuid(selectHeroGuid)
  self.pageData.selectHeroGuid = selectHeroGuid
  for i = 1, #self.bind.list_cellDormitoryReplaceRole do
    local cellDormitoryReplaceRole = self.bind.list_cellDormitoryReplaceRole:getItemCls(i)
    cellDormitoryReplaceRole:setSelectHeroGuid(self.pageData.selectHeroGuid)
  end
  self:refreshConfirmBtnText()
end

function this:request()
  local csHomeDormMgr = AzurWorld.HomeDormMgr
  local csHomeDormStore = csHomeDormMgr:GetHomeDormStore()
  local heroGuidOfOut = self.pageData.curExchangeHeroGuid or 0
  local heroGuidOfIn
  if self.pageData.selectHeroGuid ~= nil then
    heroGuidOfIn = self.pageData.selectHeroGuid == self.pageData.curExchangeHeroGuid and 0 or self.pageData.selectHeroGuid
  else
    heroGuidOfIn = 0
  end
  csHomeDormStore:ReqHeroInOrOutHomeDormitory(self.pageData.buildingGuid, heroGuidOfIn, heroGuidOfOut, self.pageData.index, function()
    L_UI:close(self.pageName)
  end)
end

function this:onClickConfirm()
  if self.pageData.curExchangeHeroGuid ~= nil then
    if self.pageData.selectHeroGuid == nil or self.pageData.selectHeroGuid == self.pageData.curExchangeHeroGuid then
      local heroItemInfo = L_HeroStore:getHero(self.pageData.curExchangeHeroGuid)
      local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroItemInfo))
      local name = heroConf.name
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("ui_home_dorm_remove_character", {
          [0] = name
        }),
        confirmCallback = function()
          self:request()
        end
      })
    else
      local heroItemInfo = L_HeroStore:getHero(self.pageData.selectHeroGuid)
      local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroItemInfo))
      local name = heroConf.name
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("ui_home_dorm_change_character", {
          [0] = name
        }),
        confirmCallback = function()
          self:request()
        end
      })
    end
  else
    local isInDorm = self.pageData.heroGuidInCurHomeDormDic[self.pageData.selectHeroGuid]
    if isInDorm then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("ui_home_dorm_change_room"),
        confirmCallback = function()
          self:request()
        end
      })
    else
      self:request()
    end
  end
end

function this:onClick_selectHero(selectHeroId)
  local isSelect = true
  local focIndex = 0
  for i, v in pairs(self._selectHero) do
    if v == selectHeroId then
      isSelect = false
      focIndex = i
      break
    end
  end
  if isSelect then
    focIndex = self:getMinCanAddDisplayHeroPos()
  end
  if 0 < focIndex then
    self._selectHero[focIndex] = isSelect and selectHeroId or nil
  end
  self:refreshDisplayList()
  self:refreshHeroSelect()
end

return this
