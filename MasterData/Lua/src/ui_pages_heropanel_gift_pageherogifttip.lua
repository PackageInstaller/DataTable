local this = class("pageHeroGiftTip", G_UIPageBase)
local giftTpl = L_GameTpl:getStargiftTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this:bind()
  return {
    giftInfo = false,
    giftInfo_closeBtn1 = true,
    giftInfo_closeBtn2 = true,
    giftInfo_giveBtn = true,
    giftInfo_tipBg = false,
    name = "",
    num = "",
    giftTip = "",
    heroGivePropertyItemList = {
      moduleName = "pages/HeroPanel/gift/cellHeroGivePropertyItemList"
    },
    module_icon = L_Const.ModuleInfo.CellIcon
  }
end

function this.methods()
  return {
    onClick_closeGiftInfo = function(self)
      self:closePage()
    end,
    onClick_closeGiftInfo2 = function(self)
      self:closePage()
    end,
    onClick_closeGiftInfo3 = function(self)
      self:closePage()
    end,
    onClick_equipStarGift = function(self)
      local data = {
        star_ids = {
          self.starGift
        },
        hero_id = self.heroId
      }
      L_StarGiftStore:req_changeCSProtoStarGiftEquip(data, function()
        local attribute = giftTpl:getAttribute(giftTpl:getTplById(self.starGift))
        local showText
        for i, v in pairs(attribute) do
          showText = battleInfoTpl:getName(battleInfoTpl:getTplById(i)) .. "  +  " .. battleInfoTpl:getShowTxt(i, v)
          L_FlyMsgManager:showNormalMsg(showText)
        end
        self:closePage()
      end)
    end
  }
end

function this:closePage()
  L_UI:close("pageHeroGiftTip")
end

function this:preOpen(options)
  self.heroId = 0
  local id = 0
  local equip = false
  if options then
    self.heroId = options.heroId
    id = options.starGift
    equip = options.equip
  end
  self:starGiftsBgInfo(id, equip)
end

function this:close()
end

function this:starGiftsBgInfo(id, equip)
  self.bind.giftInfo = true
  self.starGift = id
  self.bind.giftInfo_giveBtn = false
  self.bind.giftInfo_closeBtn1 = false
  self.bind.giftInfo_closeBtn2 = false
  self.bind.giftInfo_tipBg = false
  if equip then
    self.bind.giftTip = L_WordsTpl:getValue("ui_heroRole_24")
    self.bind.giftInfo_tipBg = true
    self.bind.giftInfo_closeBtn1 = true
  elseif L_StarGiftStore:getStarGiftNum(id) > 0 then
    self.bind.giftTip = L_WordsTpl:getValue("ui_heroRole_25")
    self.bind.giftInfo_giveBtn = true
    self.bind.giftInfo_closeBtn2 = true
  else
    self.bind.giftTip = L_WordsTpl:getValue("ui_heroRole_26")
    self.bind.giftInfo_closeBtn1 = true
  end
  local giftAttributes = giftTpl:getAttribute(giftTpl:getTplById(id))
  self.bind.name = giftTpl:getName(giftTpl:getTplById(id))
  self.modules.module_icon:setGeneralContent(L_Const.resType.stargift, id)
  self.bind.heroGivePropertyItemList:clear()
  local tempData = {}
  for attributeId, value in pairs(giftAttributes) do
    table.insert(tempData, {
      id = value,
      icon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(attributeId)),
      attribute = battleInfoTpl:getName(battleInfoTpl:getTplById(attributeId)) .. "  +" .. battleInfoTpl:getShowTxt(attributeId, value)
    })
  end
  self.bind.heroGivePropertyItemList:insert_array(tempData)
  self.bind.num = L_WordsTpl:getValue("ui_heroRole_27") .. tostring(L_StarGiftStore:getStarGiftNum(id))
end

return this
