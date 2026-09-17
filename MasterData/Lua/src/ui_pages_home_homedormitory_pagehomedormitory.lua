local this = class("pageHomeDormitory", G_UIPageBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this.bind()
  return {
    txt_name = "",
    go_editName = false,
    list_cellHomeDormitory = {
      moduleName = "pages/home/homeDormitory/cellHomeDormitory"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_editNameBtn = function(self)
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_home_dorm_changename"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsgByKey("ui_home_dorm_changename")
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_02")
            return
          end
          
          local function contains_special_char(str)
            local special_char_pattern = "[^%w一-龥]"
            return string.find(str, special_char_pattern) ~= nil
          end
          
          local hasSpecial = contains_special_char(txt)
          if hasSpecial == true then
            L_FlyMsgManager:showNormalMsgByKey("ui_modulePetBoxName_04")
            return
          end
          local msg = {
            build_guid = self.pageData.buildingGuid,
            name = txt
          }
          L_Net:sendMessage(MsgGenCode.CSProtoHomeDormChangeName, msg, function()
            self.bind.txt_name = txt
            L_FlyMsgManager:showNormalMsgByKey("ui_home_dorm_changename_success")
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    onClick_upGrade = function(self)
      L_UI:open("pageBuildingUpgrade", {
        guid = self.pageData.buildingGuid
      })
    end,
    list_cellHomeDormitory = {
      onClick_addHero = function(self, index)
        self:onClickAddHero(index)
      end,
      onClick_switch = function(self, curExchangeHeroGuid, index)
        self:onClickSwitch(curExchangeHeroGuid, index)
      end,
      onClick_visit = function(self, heroGuidOfVisit)
        self:onClickVisit(heroGuidOfVisit)
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.pageData = {}
  self.pageData.buildingGuid = options.buildingGuid
  self.pageData.buildingId = options.buildingId
  self.pageData.isInit = true
end

function this:open()
  self:refreshView()
  self.pageData.isInit = false
  self.onHomeBuildSyncHandler = handler(self, self.refreshView)
  L_HomeStore:getCsHomeStore():RegisterEvent(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
end

function this:close()
  L_HomeStore:getCsHomeStore():UnregisterEvent(C_EHomeStoreEvent.HomeBuildSync, self.onHomeBuildSyncHandler)
end

function this:refreshView()
  self:refreshHomeDormitoryList()
end

function this:refreshHomeDormitoryList()
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  local homeBuildData = csHomeStore:GetBuildData(self.pageData.buildingGuid)
  local csHomeDormHeroGuidList = homeBuildData:GetHomeDormHeroGuidList()
  local heroInfoList = {}
  for i = 0, csHomeDormHeroGuidList.Count - 1 do
    local id = csHomeDormHeroGuidList[i]
    local index = homeBuildData:GetHeroIndex(id)
    if index ~= 0 then
      heroInfoList[index] = id
    end
  end
  local name = homeBuildData:GetHomeDormName()
  local homeBuildingTpl = _homeBuildingTpl:getTplById(self.pageData.buildingId)
  if name == "" then
    self.bind.txt_name = _homeBuildingTpl:getName(homeBuildingTpl)
  else
    self.bind.txt_name = name
  end
  local homeDormCharacterMaxNum = _homeBuildingTpl:getHomeDormCharacterMaxNum(homeBuildingTpl)
  local maxNum = _homeBuildingTpl:getHomeDormMaxNum()
  local insertArray = {}
  for i = 1, homeDormCharacterMaxNum do
    table.insert(insertArray, {})
  end
  if homeDormCharacterMaxNum < maxNum then
    local num = maxNum - homeDormCharacterMaxNum
    for idx = 1, num do
      table.insert(insertArray, {
        lock = true,
        unLockLv = _homeBuildingTpl:getUnlockDormSlotNeedLv(homeDormCharacterMaxNum + idx)
      })
    end
  end
  if self.pageData.isInit or #self.bind.list_cellHomeDormitory ~= homeDormCharacterMaxNum then
    self.bind.list_cellHomeDormitory:clear()
    self.bind.list_cellHomeDormitory:insert_array(insertArray)
  end
  for idx = 1, homeDormCharacterMaxNum do
    local cellHomeDormitory = self.bind.list_cellHomeDormitory:getItemCls(idx)
    cellHomeDormitory:setHeroGuid(heroInfoList[idx])
    cellHomeDormitory:setIndex(idx)
  end
  for i = 1, #self.bind.list_cellHomeDormitory do
    local cellHomeDormitory = self.bind.list_cellHomeDormitory:getItemCls(i)
    cellHomeDormitory:refreshView()
  end
end

function this:onClickAddHero(index)
  L_UI:open("pageHomeDormitoryReplaceRole", {
    buildingGuid = self.pageData.buildingGuid,
    index = index,
    curExchangeHeroGuid = nil
  })
end

function this:onClickSwitch(curExchangeHeroGuid, index)
  L_UI:open("pageHomeDormitoryReplaceRole", {
    buildingGuid = self.pageData.buildingGuid,
    index = index,
    curExchangeHeroGuid = curExchangeHeroGuid
  })
end

function this:onClickVisit(heroGuidOfVisit)
  local IsStrolling = AzurWorld.HomeMgr:CheckHeroIsStrollingInHome(heroGuidOfVisit)
  if not IsStrolling then
    L_HomeStore:req_enterDorm(heroGuidOfVisit, self.pageData.buildingGuid)
  else
    L_FlyMsgManager:showNormalMsgByKey("ui_home_dorm_cannotvisit")
  end
end

return this
