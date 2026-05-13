local unitCsv = require("csvdata.unit")
local expCsv = require("csvdata.hero_exp")
local formCsv = require("csvdata.formation")
local specialCsv = require("csvdata.skill_special")
local blockCsv = require("csvdata.skill_block")
local evolutionCsv = require("csvdata.evolution")
local TalkCsv = require("csvdata.talk")
local EquipCsv = require("csvdata.equip")
local FoodCsv = require("csvdata.food_pic")
local EffectCsv = require("csvdata.love_effect")
local LovePlusCsv = require("csvdata.love_plus")
local SuitCsv = require("csvdata.equip_suit")
local TreeCsv = require("csvdata.tree")
local AdvanceCsv = require("csvdata.sauce_advance")
local AwakenCsv = require("csvdata.awaken")
local awakeSkillCsv = require("csvdata.skill_awake")
local innateCsv = require("csvdata.innate")
local detailRes = "ui/hero/detail/"
local awakeRes = "ui/hero/awake/"
local TAG_NORMAL = 1
local TAG_SELECT = 2
local uiData = {
  csbFile = "ui/hero/HeroDetailLayer.csb",
  mask = true,
  widgets = {
    center = "center",
    Panel_1 = "Panel_1",
    heroNode = "heroNode",
    downBar = "downBar",
    detail_bg = "detail_bg",
    zoomBtn = "zoomBtn",
    name = "detail_bg/name",
    lock = "lock",
    maskNode = "maskNode",
    zeroNode = "zeroNode",
    angle2 = "angle2",
    angle3 = "angle3",
    bgNode = "detail_bg/bgNode",
    loveNode = "detail_bg/loveNode",
    starNode = "detail_bg/starBg/starNode",
    lv_lv = "detail_bg/lv_bar/lv",
    lv_bar = "detail_bg/lv_bar/bar",
    lv_num = "detail_bg/lv_bar/num",
    hp_bar = "detail_bg/hp_bar/bar",
    hp_num = "detail_bg/hp_bar/num",
    baseNode = "detail_bg/baseNode",
    attrNode = "detail_bg/attrNode",
    equipBtn = "detail_bg/equipBtn",
    skillBtn = "detail_bg/skillBtn",
    comboBtn = "detail_bg/comboBtn",
    sauceBtn = "detail_bg/sauceBtn",
    awakeBtn = "detail_bg/awakeBtn",
    innateBtn = "detail_bg/innateBtn",
    changeBtn = "changeBtn",
    presetBtn = "presetBtn",
    dressBtn = "dressBtn",
    cgBtn = "cgBtn",
    equipPanel = "detail_bg/describe/equipPanel",
    equip1 = "detail_bg/describe/equipPanel/equip1",
    equip2 = "detail_bg/describe/equipPanel/equip2",
    equip3 = "detail_bg/describe/equipPanel/equip3",
    suitDesc = "detail_bg/describe/equipPanel/suitDescBg/suitDesc",
    skillPanel = "detail_bg/describe/skillPanel",
    comboPanel = "describe/comboPanel",
    skillList = "detail_bg/describe/skillPanel/scrollView",
    skillNode = "detail_bg/describe/skillPanel/scrollView/node",
    comboNode = "detail_bg/describe/comboPanel/node",
    saucePanel = "detail_bg/describe/saucePanel",
    sauceNode = "detail_bg/describe/saucePanel/sauceNode",
    awakePanel = "detail_bg/describe/awakePanel",
    awakeList = "detail_bg/describe/awakePanel/scrollView",
    awakeNode = "detail_bg/describe/awakePanel/scrollView/node",
    innatePanel = "detail_bg/describe/innatePanel",
    innateList = "detail_bg/describe/innatePanel/scrollView",
    innateNode = "detail_bg/describe/innatePanel/scrollView/node",
    crownBtn = "detail_bg/crownBg/crownBtn",
    upBar = "up_bar",
    btnRight = "btnRight",
    btnLeft = "btnLeft"
  }
}
local btnNames = {
  "equipBtn",
  "skillBtn",
  "comboBtn",
  "sauceBtn",
  "awakeBtn",
  "innateBtn"
}
local HeroDetailLayer = class("HeroDetailLayer", UIBase)

function HeroDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local play = false

function HeroDetailLayer:init(params)
  self.heroId = params.heroId
  self.hero = game.role.heros[self.heroId]
  self.curIndex = params.index
  self.heros = params.heros
  TopBar:show(TopBarType.full, "食灵资料")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.Panel_1)
    UIHelper.fitForiPhoneX(self.maskNode)
    UIHelper.fitForiPhoneX(self.upBar, true)
    UIHelper.fitForiPhoneX(self.downBar, true)
    self.Panel_1:setPositionX(self.Panel_1:getPositionX() - UIHelper.getMoveXForX())
    self.maskNode:setPositionX(self.maskNode:getPositionX() - UIHelper.getMoveXForX())
    self.changeBtn:setPositionX(self.changeBtn:getPositionX() - UIHelper.getMoveXForX())
    self.angle2:setPositionX(self.angle2:getPositionX() - UIHelper.getMoveXForX())
    self.angle3:setPositionX(self.angle3:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.upBar
  })
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 5)
    end
  })
  if not self.curIndex or not self.heros then
    self.btnLeft:hide()
    self.btnRight:hide()
    self.cgBtn:setVisible(checkbool(TreeCsv[self.hero.type]))
  else
    self:GetNextId(0)
  end
  self.btnLeft:setCallback(function()
    self:GetNextId(-1)
    self.innateBtn:setVisible(self.hero.unit.star >= 6)
    self.awakeBtn:setVisible(self.hero.unit.star < 6)
    group:chooseByName("skillBtn")
  end)
  self.btnRight:setCallback(function()
    self:GetNextId(1)
    self.innateBtn:setVisible(self.hero.unit.star >= 6)
    self.awakeBtn:setVisible(self.hero.unit.star < 6)
    group:chooseByName("skillBtn")
  end)
  self.innateBtn:setVisible(self.hero.unit.star >= 6)
  self.awakeBtn:setVisible(self.hero.unit.star < 6)
  for index, name in ipairs(btnNames) do
    local btn = self[name]
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
    btn:setGroup(group)
    btn:setCallback(function()
      if name == "equipBtn" then
        self:showEquip()
      elseif name == "comboBtn" then
        self:showCombo()
      elseif name == "skillBtn" then
        self:showSkill()
      elseif name == "sauceBtn" then
        self:showSauce()
      elseif name == "awakeBtn" then
        self:showAwake()
      elseif name == "innateBtn" then
        self:showInnate()
      end
    end)
  end
  group:chooseByName("skillBtn")
  self.zoomBtn:setTouchScale()
  self.zoomBtn:setCallback(function()
    self:showBigCard()
  end)
  self.crownBtn:setTouchScale()
  self.crownBtn:setCallback(function()
    if game.role.crown == self.heroId then
      self.crownBtn:setState(2)
      MFlashMsg:show({
        text = self.hero:getName() .. "已经设置为偏好食灵"
      })
      return
    end
    game:sendData(actionCodes.Role_setCrownRpc, MsgPack.pack({
      heroId = self.heroId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_setCrownRpc, function(event)
      UIHelper.removeWaiting()
      self.crownBtn:setState(2)
      self:showLock()
      MFlashMsg:show({
        text = self.hero:getName() .. "设置为偏好食灵"
      })
    end)
  end)
  self.dressBtn:setCallback(function()
    local layer = game:createView("hero.HeroDressLayer", {
      heroId = self.hero.id
    })
    self:hide()
    BackManager:push(function()
      self:show()
      if layer:needUpdate() then
        self:showHero()
      end
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "偏好",
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#4c3605"), 2):pos(60, 20):addTo(self.crownBtn)
  self.lock:setCallback(function()
    if self.hero.id == game.role.crown and self.hero.lock == 1 then
      SysError(SYS_ERR_CROWN_HERO_LOCKED)
      return
    end
    game:sendData(actionCodes.Hero_lockRpc, MsgPack.pack({
      heroId = self.hero.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_lockRpc, function(event)
      UIHelper.removeWaiting()
      if self.hero.lock == 0 then
        SysError(SYS_ERR_HERO_PROTECT_OFF)
      else
        SysError(SYS_ERR_HERO_PROTECT_ON)
      end
      self:showLock()
    end)
  end)
  self.bFood = false
  self.changeBtn:setCallback(function()
    if self.bFood then
      self.heroNode:removeAllChildren()
      HeroBigCard.new({
        heroId = self.heroId,
        quality = self.hero.quality
      }):addTo(self.heroNode)
      self.changeBtn:setImage(detailRes .. "state_a.png")
      self.zoomBtn:show()
      self.dressBtn:show()
      self.bFood = false
    else
      local curBreak = UIHelper.getMaxLoveBreak(self.hero.type)
      local FoodData = FoodCsv[self.hero.type]
      if not FoodData or FoodData.res == "" then
        SysError(SYS_ERR_FOOD_PIC_DOES_NOT_HAVE)
        return
      end
      if curBreak < FoodCsv[self.hero.type].unlock then
        SysError(SYS_ERR_FOOD_PIC_LOCK)
        return
      end
      self.heroNode:removeAllChildren()
      display.newSprite(FoodData.res):pos(5, 120):addTo(self.heroNode)
      self.changeBtn:setImage(detailRes .. "state_b.png")
      self.zoomBtn:hide()
      self.dressBtn:hide()
      self.bFood = true
    end
  end)
  self.cgBtn:setCallback(function()
    if self.hero:getCgOpen() then
      UIHelper.showOnleImgTip("icon/cg/" .. string.format("%s.png", self.hero.type))
    else
      SysError(SYS_ERR_HERO_CG_LOCK)
    end
  end)
  self.presetBtn:setCallback(function()
    game:createView("hero.HeroPresetLayer", {
      hero = self.hero,
      callback = function()
        if group:getCurrentChooseName() == "equipBtn" then
          self:showEquip()
        elseif group:getCurrentChooseName() == "sauceBtn" then
          self:showSauce()
        end
        self:showAttrs()
      end
    })
  end)
end

function HeroDetailLayer:showData()
  local proBg = self.detail_bg:getChildByName("proBg")
  if not tolua.isnull(proBg) then
    proBg:removeSelf()
  end
  self.starNode:removeAllChildren()
  self.loveNode:removeAllChildren()
  self.baseNode:removeAllChildren()
  self.bgNode:removeAllChildren()
  local status = game.role.crown == self.heroId and 2 or 1
  self.crownBtn:setState(status)
  local unitData = unitCsv[self.hero:getDressType()]
  local proBg = UIHelper.newImageView(string.format("ui/global/profession_bg_%d.png", self.hero.quality)):pos(25, 497):addTo(self.detail_bg):name("proBg")
  local imageName = self.hero:showTreeTag() and "ui/global/profession_s_%d.png" or "ui/global/profession_%d.png"
  UIHelper.newImageView(string.format(imageName, unitData.profession)):center(proBg):addTo(proBg)
  local star, interval = unitData.star, 30
  local bMax = self.hero:isTreeMax()
  local isBlack = self.hero:isBlackHero()
  local isMengJing = self.hero:isMengJingHero()
  local isShengcan = self.hero:isShengcanHero()
  local temStar = math.min(star, 5)
  if isShengcan then
    for index = 1, temStar do
      local offset = index == 1 and 0 or -interval / 2
      display.newSprite(detailRes .. (bMax and "star_tree_red.png" or "star.png")):pos((index - (unitData.star + 1) / 2) * interval, 0):addTo(self.starNode)
    end
  else
    for index = 1, temStar do
      local offset = index == 1 and 0 or -interval / 2
      display.newSprite(detailRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos((index - (unitData.star + 1) / 2) * interval, 0):addTo(self.starNode)
    end
  end
  self.lv_lv:setString(self.hero.level)
  if self.hero.level >= self.hero:getLevelLimit() then
    self.lv_num:setString("max")
    self.lv_bar:setPercent(100)
  else
    self.lv_num:setString(self.hero.exp .. "/" .. expCsv[self.hero.level].exp)
    self.lv_bar:setPercent(self.hero.exp / expCsv[self.hero.level].exp * 100)
  end
  self.hp_bar:setPercent(self.hero.hpPercent / 10)
  local limit = LovePlusCsv[self.hero.type].limit
  if limit ~= 0 then
    local heart = UIHelper.newImageView("ui/global/heart.png"):pos(0, 0):addTo(self.loveNode)
    display.newTTFLabel({
      text = math.min(limit, self.hero.loveBreak),
      size = 24,
      color = UIHelper.hex2rgb("#5b0a15")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
    if 5 <= self.hero.loveBreak then
      display.newSprite("ui/global/marry.png"):center(heart):addTo(heart)
    end
    heart:setCallback(function()
      game:createView("hero.MarryLayer", {
        heroId = self.hero.id,
        callback = function()
          self:showData()
        end
      })
    end)
  end
  if 5 <= self.hero.loveBreak then
    display.newSprite(detailRes .. "name_bg.png"):anch(0, 0.5):addTo(self.bgNode)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(detailRes, {
      "btn_rename.png",
      "btn_rename.png"
    })
    btn:setTouchScale()
    btn:pos(320, 0):addTo(self.bgNode)
    btn:setCallback(function()
      local layer = game:createView("hero.ChangeHeroNameLayer", {
        heroId = self.hero.id
      })
      BackManager:push(function()
        self.name:setString(self.hero:getName())
        layer:close()
      end)
    end)
  end
  for i = 1, 2 do
    local value = self.hero["material" .. i]
    local image = 40 < value and "kuang_4.png" or "kuang_3.png"
    local bg = display.newSprite(detailRes .. "material_bg.png"):pos(0 + (i - 1) * 100, 0):addTo(self.baseNode)
    local baseBg = display.newProgressTimer("ui/carbon/battle/" .. image, display.PROGRESS_TIMER_RADIAL)
    baseBg:pos(20, 20):addTo(bg)
    baseBg:setPercentage(value)
    baseBg:setScaleX(-1)
    display.newSprite("ui/carbon/battle/kuang_2.png"):center(baseBg):addTo(baseBg)
    display.newSprite(string.format("ui/global/base_%d.png", i)):scale(0.75):center(baseBg):addTo(baseBg)
    display.newTTFLabel({
      text = math.floor(self.hero:getCailiao(i)),
      size = 18,
      color = UIHelper.hex2rgb("#000000")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(55, 22):addTo(bg)
  end
  self:showAttrs()
  self:showHero()
  self:showLock()
  self:showSkill()
end

function HeroDetailLayer:GetNextId(direct)
  self.curIndex = self.curIndex + direct
  if self.curIndex == 1 then
    self.btnLeft:hide()
  else
    self.btnLeft:show()
  end
  if self.curIndex == #self.heros then
    self.btnRight:hide()
  else
    self.btnRight:show()
  end
  if #self.heros == 1 then
    self.btnLeft:hide()
    self.btnRight:hide()
  end
  self.hero = self.heros[self.curIndex]
  self.heroId = self.hero.id
  self.cgBtn:setVisible(checkbool(TreeCsv[self.hero.type]))
  self:resetFoodBtn()
  self:showData()
end

function HeroDetailLayer:resetFoodBtn()
  if not self.bFood then
    return
  end
  self.changeBtn:setImage(detailRes .. "state_a.png")
  self.heroNode:removeAllChildren()
  self.zoomBtn:show()
  self.bFood = false
end

function HeroDetailLayer:showAttrs()
  self.attrNode:removeAllChildren()
  local totalAttr = self.hero:getTotalAttrValues({battle = true})
  local baseAttr = self.hero:getBaseAttrValues()
  local hp = totalAttr.hp * self.hero.hpPercent / 1000
  hp = self.hero.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  self.hp_num:setString(string.format("%d/%d", hp, totalAttr.hp))
  for index = 1, 7 do
    local name = AttsEnumEx[index]
    local attrBg = display.newSprite(detailRes .. "attrs_bg.png"):anch(0, 0.5):pos(0, (index - 1) * -21):addTo(self.attrNode)
    display.newSprite(detailRes .. name .. ".png"):pos(20, 10):addTo(attrBg)
    display.newTTFLabel({
      text = AttrDesc[index] .. ":",
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(30, 10):addTo(attrBg)
    local value = ROUND[index] and math.ceil(totalAttr[name]) or math.floor(totalAttr[name])
    display.newTTFLabel({
      text = value,
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(90, 10):addTo(attrBg)
    local add = totalAttr[name] - baseAttr[name]
    if 0.1 < add then
      display.newTTFLabel({
        text = string.format("(+%.01f)", add),
        size = 16,
        color = UIHelper.hex2rgb("#228801")
      }):anch(0, 0.5):pos(130, 11):addTo(attrBg)
    end
  end
end

function HeroDetailLayer:showHero()
  self.heroNode:removeAllChildren()
  HeroBigCard.new({
    heroId = self.heroId,
    quality = self.hero.quality
  }):addTo(self.heroNode)
  self.name:setString(self.hero:getName())
end

function HeroDetailLayer:showEquip(part)
  self.equipPanel:show()
  self.skillPanel:hide()
  self.comboPanel:hide()
  self.saucePanel:hide()
  self.awakePanel:hide()
  self.innatePanel:hide()
  local parts = self.hero:getCanEquip()
  local active = self.hero:isSuitAcitve()
  if active then
    self.suitDesc:setString(SuitCsv[active].name .. "套装效果已激活")
  else
    self.suitDesc:setString("装备套装效果未激活")
  end
  
  local function rule(equip)
    if self.hero.level < equip.csvData.level then
      return true
    end
    return false
  end
  
  local equips = self.hero.equips:toNumMap()
  
  local function refreshEquip(index)
    local equipId = equips[index]
    local bg = self["equip" .. index]
    bg:removeAllChildren()
    bg:setCallback(function()
      if not CommonHelper.funcOpen("equip") then
        SysError(SYS_ERR_FUNCOPEN_EQUIP)
        return
      end
      local layer = game:createView("equip.EquipWearLayer", {
        profession = index,
        heroId = self.hero.id,
        rule = rule,
        equipId = equipId,
        callback = function(choose, slot, callback)
          local states = self.hero:getState()
          if states[2] or states[3] then
            SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
            return true
          end
          if choose ~= 0 then
            local equip = game.role.equips[choose]
            if slot ~= equip.csvData.profession then
              SysError(SYS_ERR_EQUIP_TYPE_NOT_FIT)
              return true
            end
            if self.hero.level < equip.csvData.level then
              SysError(SYS_ERR_EQUIP_HERO_LEVEL_LOW)
              return true
            end
            local hero = game.role.heros[equip.masterId]
            if hero then
              states = hero:getState()
              if states[2] or states[3] then
                SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
                return true
              end
            end
          end
          game:sendData(actionCodes.Equip_wearEquipRpc, MsgPack.pack({
            equipId = choose,
            part = slot,
            heroId = self.hero.id
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Equip_wearEquipRpc, function(event)
            UIHelper.removeWaiting()
            self:showEquip(slot)
            self:showAttrs()
            if callback then
              callback()
            end
          end)
        end
      })
      BackManager:push(function()
        layer:close()
        TopBar:show(TopBarType.full, "食灵资料")
      end)
    end)
    if equipId then
      EquipIcon.new({id = equipId, big = true}):center(bg):addTo(bg)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(detailRes, {
        "btn_info.png",
        "btn_info.png"
      })
      btn:pos(59, -17):addTo(bg)
      btn:setCallback(function()
        local mask = UIHelper.newMask({
          size = cc.size(display.width, display.height),
          opacity = 0
        })
        mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
        mask:setTouchEnabled(true)
        mask:setSwallowTouches(false)
        mask:setCallback(function()
          mask:removeSelf()
        end)
        local node = display.newNode():pos(UIHelper.isiPhoneX() and 515 or 395, 565):addTo(mask)
        game:createView("equip.EquipDetailLayer", {
          scene = node,
          equipId = equipId,
          showBg = 1
        })
      end)
    else
      display.newSprite(detailRes .. "circle.png"):center(bg):addTo(bg)
      local add = UIHelper.newImageView("ui/equip/reforge/add.png"):scale(0.8):center(bg):addTo(bg)
      if not parts[index] then
        UIHelper.setImageViewGray(add)
      end
    end
  end
  
  if equips[part] then
    refreshEquip(part)
  else
    for index = 1, 3 do
      refreshEquip(index)
    end
  end
end

function HeroDetailLayer:showSkill()
  self.equipPanel:hide()
  self.skillPanel:show()
  self.comboPanel:hide()
  self.saucePanel:hide()
  self.awakePanel:hide()
  self.innatePanel:hide()
  self.skillNode:removeAllChildren()
  self.skillList:setScrollBarEnabled(false)
  local levels = self.hero:getTotalAttrFactors()
  local specialId = self.hero:getSpecialId()
  if specialId ~= 0 then
    local level = levels.specialLv
    local specialData = specialCsv[specialId][level]
    local textBg = display.newSprite(detailRes .. "text_bg1.png"):anch(0, 1):pos(-45, 215):addTo(self.skillNode)
    local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 70):addTo(textBg)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = specialData.icon
    }):scale(0.47):center(content):addTo(content)
    display.newTTFLabel({
      text = specialData.name,
      size = 16,
      color = UIHelper.hex2rgb("#0d92ae")
    }):anch(0, 0.5):pos(75, 95):addTo(textBg)
    display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
    local desc = MRichText.new({
      text = specialData.desc,
      size = 16,
      color = UIHelper.hex2rgb("#703803"),
      font = display.DEFAULT_TTF_FONT_NORMAL,
      lineSpace = 4,
      maxWidth = 360
    })
    desc:anch(0, 1):pos(75, 83):addTo(textBg)
    for index = 1, 6 do
      local image = level < index and "star1.png" or "star2.png"
      display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 95):addTo(textBg)
    end
    local bg1 = display.newSprite(detailRes .. "func_bg_2.png"):pos(305, 105):addTo(textBg)
    display.newTTFLabel({
      text = specialData.coolDown .. "s",
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(54, 17):addTo(bg1)
    local bg2 = display.newSprite(detailRes .. "func_bg_1.png"):pos(400, 105):addTo(textBg)
    display.newTTFLabel({
      text = "x" .. specialData.manaCost,
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(50, 17):addTo(bg2)
  end
  local textBg2 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, 102):addTo(self.skillNode)
  local blockId = self.hero:getBlockId()
  if blockId ~= 0 then
    local level = levels.blockLv
    local blockData = blockCsv[blockId][level]
    local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 110):addTo(textBg2)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = blockData.icon
    }):scale(0.47):center(content):addTo(content)
    display.newTTFLabel({
      text = blockData.name,
      size = 16,
      color = UIHelper.hex2rgb("#0d92ae")
    }):anch(0, 0.5):pos(75, 135):addTo(textBg2)
    display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
    local desc = MRichText.new({
      text = blockData.desc,
      size = 16,
      color = UIHelper.hex2rgb("#703803"),
      font = display.DEFAULT_TTF_FONT_NORMAL,
      lineSpace = 4,
      maxWidth = 360
    })
    desc:anch(0, 1):pos(75, 123):addTo(textBg2)
    for index = 1, 6 do
      local image = level < index and "star1.png" or "star2.png"
      display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 135):addTo(textBg2)
    end
  else
    display.newSprite(detailRes .. "text.png"):pos(220, 95):addTo(textBg2)
  end
  local textBg3 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, -60):addTo(self.skillNode)
  local awakeId = self.hero:getAwakeIdShow()
  if awakeId and 0 < awakeId then
    local level = 1
    local awakeData = awakeSkillCsv[awakeId][level]
    local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 110):addTo(textBg3)
    local imagePath = self.hero:getAwakeId() and 0 < self.hero:getAwakeId() and awakeData.icon or "ui/kitchen/tree/main/circle_lock.png"
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = imagePath
    }):scale(0.47):center(content):addTo(content)
    display.newTTFLabel({
      text = awakeData.name,
      size = 16,
      color = UIHelper.hex2rgb("#0d92ae")
    }):anch(0, 0.5):pos(75, 135):addTo(textBg3)
    display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
    local desc = MRichText.new({
      text = awakeData.desc,
      size = 16,
      color = UIHelper.hex2rgb("#703803"),
      font = display.DEFAULT_TTF_FONT_NORMAL,
      lineSpace = 4,
      maxWidth = 360
    })
    desc:anch(0, 1):pos(75, 123):addTo(textBg3)
  else
    display.newTTFLabel({
      text = "此食灵暂时未开放觉醒",
      size = 16,
      color = UIHelper.hex2rgb("#703803")
    }):pos(220, 95):addTo(textBg3)
  end
end

function HeroDetailLayer:showAwake()
  self.equipPanel:hide()
  self.comboPanel:hide()
  self.skillPanel:hide()
  self.saucePanel:hide()
  self.awakePanel:show()
  self.innatePanel:hide()
  self.awakeNode:removeAllChildren()
  self.awakeList:setScrollBarEnabled(false)
  local awakeData = AwakenCsv[self.hero.type]
  if not awakeData or not CommonHelper.funcOpen("awake") then
    local bg = display.newSprite("ui/hero/tip_bg.png"):scale(0.5):pos(170, -15):addTo(self.awakeNode)
    display.newTTFLabel({
      text = ":主厨，暂未开放觉醒哦",
      size = 26,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(400, 120):addTo(bg)
    if not CommonHelper.funcOpen("awake") then
      SysError(SYS_ERR_FUNCOPEN_AWAKE)
      return
    end
  else
    local posy = 73
    for i = 1, #awakeData do
      local textBg = display.newSprite(detailRes .. "text_bg2.png"):anch(0, 1):pos(-45, posy):addTo(self.awakeNode)
      local awakeStageImage = i <= self.hero.awake and awakeRes .. string.format("awake_done_%d.png", i) or awakeRes .. string.format("awake_able_%d.png", i)
      local awakeStage = UIHelper.newImageView(awakeStageImage):scale(0.6):anch(0, 0.5):pos(11, 31):addTo(textBg)
      if i > self.hero.awake + 1 then
        UIHelper.newImageView("ui/kitchen/tree/main/circle_lock.png"):center(awakeStage):addTo(awakeStage)
      end
      display.newTTFLabel({
        text = awakeData[i].desc,
        size = 16,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0, 0.5):pos(280, 30):addTo(textBg)
      display.newTTFLabel({
        text = string.format("%d阶觉醒", i),
        size = 16,
        color = UIHelper.hex2rgb("#703902")
      }):anch(0, 0.5):pos(130, 30):addTo(textBg)
      if i <= self.hero.awake + 1 then
        awakeStage:setCallback(function()
          local mask = UIHelper.newMask({
            size = cc.size(display.width, display.height),
            opacity = 200
          })
          mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(self, 100)
          mask:setTouchEnabled(true)
          mask:setCallback(function()
            mask:removeSelf()
          end)
          local node = display.newNode():pos(UIHelper.isiPhoneX() and 515 or 395, 560):addTo(mask)
          if awakeData[i].open ~= "" then
            for limitType, value in pairs(awakeData[i].open:toNumMap()) do
              if limitType == 1 then
                if value > self.hero.level then
                  SysError(SYS_ERR_HERO_AWAKE_STAGE_LOCK)
                  return
                end
              elseif limitType == 2 and value > self.hero.quality then
                SysError(SYS_ERR_HERO_AWAKE_STAGE_LOCK)
                return
              end
            end
          end
          game:createView("hero.AwakeDetailNewLayer", {
            scene = node,
            type = i,
            data = awakeData[i],
            hero = self.hero,
            callback = function()
              self:showAwake()
              self:showAttrs()
            end
          })
        end)
      end
      posy = posy - 64
    end
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/activity/23/", {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(380, 50):addTo(self.awakeNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    UIHelper.showOnleImgTip(awakeRes .. "info.png")
  end)
end

function HeroDetailLayer:showInnate()
  self.equipPanel:hide()
  self.comboPanel:hide()
  self.skillPanel:hide()
  self.saucePanel:hide()
  self.awakePanel:hide()
  self.innatePanel:show()
  self.innateNode:removeAllChildren()
  self.innateList:setScrollBarEnabled(false)
  local innateLevel = self.hero.innate + evolutionCsv[self.hero.quality].innateLevel
  self.innateData = innateCsv[self.hero.type][innateLevel]
  local textBg = display.newSprite(detailRes .. "text_bg3.png"):anch(0, 1):pos(-45, 352):addTo(self.innateNode)
  local innateBtn = UIHelper.extend(ccui.Button:create())
  innateBtn:setImages(detailRes, {
    "innate_level.png",
    "innate_level.png"
  })
  innateBtn:pos(45, 25):addTo(textBg)
  innateBtn:setCallback(function()
    local mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      opacity = 200
    })
    mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(self, 100)
    mask:setTouchEnabled(true)
    mask:setCallback(function()
      mask:removeSelf()
    end)
    local node = display.newNode():pos(UIHelper.isiPhoneX() and 515 or 395, 560):addTo(mask)
    game:createView("hero.InnateDetailLayer", {
      scene = node,
      hero = self.hero,
      callback = function()
        self:showInnate()
        self:showAttrs()
      end
    })
  end)
  local innateLevelText = display.newTTFLabel({
    text = string.format("天赋等级：" .. innateLevel),
    size = 16,
    color = UIHelper.hex2rgb("#703902")
  }):anch(0.5, 0.5):pos(227, 25):addTo(textBg)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/activity/23/", {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(419, 25):addTo(textBg)
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "innate_detail"
    })
  end)
  local level = self.innateData.skillLevel
  local textBg2 = display.newSprite(detailRes .. "text_bg2.png"):anch(0, 1):pos(-45, 299):addTo(self.innateNode)
  local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 32):addTo(textBg2)
  UIHelper.newImageView(detailRes .. "skill_level_up.png"):scale(0.47):center(content):addTo(content)
  if level == 0 then
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = "ui/kitchen/tree/main/circle_lock.png"
    }):scale(0.47):center(content):addTo(content)
  end
  display.newTTFLabel({
    text = "技能等级",
    size = 16,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(75, 50):addTo(textBg2)
  display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
  for index = 1, 3 do
    local image = index > level - 1 and "star1.png" or "star2.png"
    display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 50):addTo(textBg2)
  end
  display.newTTFLabel({
    text = "固有技和料理技等级加" .. level - 1,
    size = 16,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0, 0.5):pos(75, 32):addTo(textBg2)
  local level = self.innateData.statusLevel
  local textBg3 = display.newSprite(detailRes .. "text_bg2.png"):anch(0, 1):pos(-45, 233):addTo(self.innateNode)
  local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 32):addTo(textBg3)
  UIHelper.newImageView(detailRes .. "status_up.png"):scale(0.47):center(content):addTo(content)
  if level == 0 then
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = "ui/kitchen/tree/main/circle_lock.png"
    }):scale(0.47):center(content):addTo(content)
  end
  display.newTTFLabel({
    text = "属性提升",
    size = 16,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(75, 50):addTo(textBg3)
  display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
  for index = 1, 6 do
    local image = level < index and "star1.png" or "star2.png"
    display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 50):addTo(textBg3)
  end
  local innateUpAttrs = self.hero:getInnateUpAttrValues()
  local cname = {
    "血量",
    "攻击",
    "防御",
    "命中",
    "闪避",
    "暴击",
    "暴击伤害"
  }
  local attrUpStr = ""
  local temp = 0
  for index = 1, 7 do
    local name = AttsEnumEx[index]
    if index == 7 then
      name = AttsEnumEx[8]
    end
    if innateUpAttrs[name] and 0 < innateUpAttrs[name] then
      attrUpStr = attrUpStr .. cname[index] .. " +" .. innateUpAttrs[name] .. " "
      temp = temp + 1
    end
    if temp == 4 then
      attrUpStr = attrUpStr .. "\n"
    end
  end
  if attrUpStr == "" then
    attrUpStr = "尚未获得属性提升"
  end
  display.newTTFLabel({
    text = attrUpStr,
    size = 16,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0, 1):pos(75, 40):addTo(textBg3)
  local level = self.innateData.formationUp
  local textBg4 = display.newSprite(detailRes .. "text_bg2.png"):anch(0, 1):pos(-45, 167):addTo(self.innateNode)
  local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 32):addTo(textBg4)
  UIHelper.newImageView(detailRes .. "formation_up.png"):scale(0.47):center(content):addTo(content)
  if level == 0 then
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = "ui/kitchen/tree/main/circle_lock.png"
    }):scale(0.47):center(content):addTo(content)
  end
  display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
  display.newTTFLabel({
    text = "进阶装盘",
    size = 16,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(75, 50):addTo(textBg4)
  local str = string.gsub(formCsv[self.innateData.formationId][1].totalDesc, [[


]], "\n", 1)
  display.newTTFLabel({
    text = str,
    size = 16,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0, 0.5):pos(75, 24):addTo(textBg4)
  local temp = self.innateData.characteristic == 0 and 1 or self.innateData.characteristic
  local characteristicData = blockCsv[self.innateData.characteristicId][temp]
  local level = self.innateData.characteristic
  local textBg5 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, 101):addTo(self.innateNode)
  local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 110):addTo(textBg5)
  UIHelper.newImageView(detailRes .. "characteristic.png"):scale(0.47):center(content):addTo(content)
  if level == 0 then
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = "ui/kitchen/tree/main/circle_lock.png"
    }):scale(0.47):center(content):addTo(content)
  end
  display.newTTFLabel({
    text = characteristicData.name,
    size = 16,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(75, 135):addTo(textBg5)
  display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
  local desc = MRichText.new({
    text = characteristicData.desc,
    size = 16,
    color = UIHelper.hex2rgb("#703803"),
    font = display.DEFAULT_TTF_FONT_NORMAL,
    lineSpace = 4,
    maxWidth = 360
  })
  desc:anch(0, 1):pos(75, 123):addTo(textBg5)
  for index = 1, 5 do
    local image = level < index and "star1.png" or "star2.png"
    display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 135):addTo(textBg5)
  end
  local temp = self.innateData.dreamLevel == 0 and 1 or self.innateData.dreamLevel
  local dreamData = blockCsv[self.innateData.dreamId][temp]
  local level = self.innateData.dreamLevel
  local textBg6 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, -61):addTo(self.innateNode)
  local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 110):addTo(textBg6)
  UIHelper.newImageView(detailRes .. "dream_skill.png"):scale(0.47):center(content):addTo(content)
  if level == 0 then
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = "ui/kitchen/tree/main/circle_lock.png"
    }):scale(0.47):center(content):addTo(content)
  end
  display.newTTFLabel({
    text = dreamData.name,
    size = 16,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(75, 135):addTo(textBg6)
  display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
  local desc = MRichText.new({
    text = dreamData.desc,
    size = 16,
    color = UIHelper.hex2rgb("#703803"),
    font = display.DEFAULT_TTF_FONT_NORMAL,
    lineSpace = 4,
    maxWidth = 360
  })
  desc:anch(0, 1):pos(75, 123):addTo(textBg6)
  for index = 1, 5 do
    local image = level < index and "star1.png" or "star2.png"
    display.newSprite(detailRes .. image):pos(180 + (index - 1) * 15, 135):addTo(textBg6)
  end
end

function HeroDetailLayer:showSauce()
  self.equipPanel:hide()
  self.comboPanel:hide()
  self.skillPanel:hide()
  self.saucePanel:show()
  self.awakePanel:hide()
  self.innatePanel:hide()
  self.sauceNode:removeAllChildren()
  if not self.hero.sauce or self.hero.sauce < 0 then
    display.newTTFLabel({
      text = "酱料ID值错误",
      size = 20
    }):addTo(self.sauceNode)
    return
  end
  if self.hero.sauce == 0 then
    local bg = UIHelper.newImageView("ui/sauce/card/card_top_bg.png"):scale(0.8):pos(0, 30):addTo(self.sauceNode)
    if self.hero:getCanEquipSauce() then
      UIHelper.newImageView("ui/equip/reforge/add.png"):pos(58, 75):addTo(bg)
      display.newTTFLabel({
        text = "添加酱料",
        size = 18,
        color = UIHelper.hex2rgb("#b5f831")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(58, 22):addTo(bg)
      bg:setCallback(function()
        self:chooseSauce()
      end)
    else
      UIHelper.newImageView("ui/sauce/card/image_cook.png"):pos(58, 75):addTo(bg)
      display.newTTFLabel({
        text = "暂无可用酱料",
        size = 18,
        color = UIHelper.hex2rgb("#bdafa2")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(56, 25):addTo(bg)
    end
    display.newSprite(detailRes .. "sauce_lock.png"):pos(0, -50):addTo(self.sauceNode)
    return
  end
  local sauce = game.role.sauces[self.hero.sauce]
  local btn = UIHelper.newImageView(sauce:getBigImg()):scale(0.4):pos(-120, 0):addTo(self.sauceNode)
  btn:setCallback(function()
    self:chooseSauce()
  end)
  local descBg = display.newSprite(detailRes .. "sauce_bg_2.png"):anch(0, 0.5):pos(0, 0):addTo(self.sauceNode)
  display.newTTFLabel({
    text = sauce.csvData.name,
    size = 30,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0, 0.5):pos(8, 142):addTo(descBg)
  display.newTTFLabel({
    text = "Lv" .. sauce.breakL,
    size = 24,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0, 0.5):pos(17, 96):addTo(descBg)
  for i = 1, #AdvanceCsv[sauce.type] do
    display.newSprite("ui/sauce/card/special_gray.png"):pos(36 + (i - 1) * 32, 55):addTo(descBg)
    if i <= sauce.advanceL then
      display.newSprite("ui/sauce/card/special_green.png"):pos(36 + (i - 1) * 32, 55):addTo(descBg)
    end
  end
  local btnInfo = UIHelper.newImageView(detailRes .. "btn_sauce.png")
  btnInfo:anch(0, 0.5):pos(19, 14):addTo(descBg)
  display.newTTFLabel({
    text = "酱料详情",
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#703803"), 1):pos(96, 16):addTo(btnInfo)
  btnInfo:setCallback(function()
    local mask = UIHelper.newMask({
      size = cc.size(display.width, display.height),
      opacity = 0
    })
    mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
    mask:setTouchEnabled(true)
    mask:setSwallowTouches(true)
    mask:setCallback(function()
      mask:removeSelf()
    end)
    local node = display.newNode():pos(UIHelper.isiPhoneX() and 515 or 395, 565):addTo(mask)
    game:createView("sauce.SauceDetailLayer", {
      scene = node,
      sauceId = sauce.id,
      showBg = 1
    })
  end)
end

function HeroDetailLayer:chooseSauce()
  local states = self.hero:getState()
  if states[1] or states[2] or states[3] then
    SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
    return true
  end
  
  local function rule(sauce)
    if sauce.masterId and sauce.masterId ~= 0 then
      local hero = game.role.heros[sauce.masterId]
      if hero then
        local states = hero:getState()
        if states[1] or states[2] or states[3] then
          return true
        end
      end
    end
    return false
  end
  
  local barType, barText = TopBar:getShowType()
  local layer = game:createView("sauce.SauceWearLayer", {
    rule = rule,
    sauceId = self.hero.sauce,
    heroId = self.hero.id,
    callback = function(choose, callback)
      game:sendData(actionCodes.Sauce_wearRpc, MsgPack.pack({
        id = choose,
        heroId = self.hero.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_wearRpc, function(event)
        UIHelper.removeWaiting()
        if tolua.isnull(self) then
          return
        end
        if callback then
          callback()
        end
        self:showAttrs()
        self:showSauce()
      end)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(barType, barText)
  end)
end

function HeroDetailLayer:showLock()
  if self.hero.lock == 0 then
    self.lock:setImage(detailRes .. "lock_b.png")
  else
    self.lock:setImage(detailRes .. "lock_a.png")
  end
end

function HeroDetailLayer:showCombo()
  self.equipPanel:hide()
  self.skillPanel:hide()
  self.saucePanel:hide()
  self.comboPanel:show()
  self.awakePanel:hide()
  self.innatePanel:hide()
  self.comboNode:removeAllChildren()
  local totalDesc = formCsv[self.hero:getFormationId()][self.hero.fieldLevel].totalDesc
  local indexs = string.find(totalDesc, "\n")
  totalDesc = string.sub(totalDesc, 1, indexs) .. string.sub(totalDesc, indexs + 2, -1)
  display.newSprite(detailRes .. "yandou.png"):pos(-18, 4):addTo(self.comboNode)
  local desc = display.newTTFLabel({
    text = totalDesc,
    size = 18,
    color = UIHelper.hex2rgb("#6E3804"),
    dimensions = cc.size(380, 150)
  }):anch(0.5, 1):pos(200, 15):addTo(self.comboNode)
  desc:setLineSpacing(18)
end

function HeroDetailLayer:showBigCard()
  self.heroNode:hide()
  TopBar:hide()
  local maskLayer = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    color = "#000000",
    opacity = 230
  })
  maskLayer:addTo(self.maskNode)
  maskLayer:setCallback(function()
  end)
  local maxScale = 1.5
  local scrollView = cc.ScrollView:create()
  scrollView:anch(0.5, 0.5):pos(display.cx, display.cy):addTo(maskLayer)
  scrollView:setViewSize(cc.size(display.width, display.height))
  scrollView:setContentSize(cc.size(display.width * maxScale, display.height * maxScale))
  scrollView:setContentOffset(cc.p(-display.width * (maxScale - 1) / 2, -display.height * (maxScale - 1) / 2))
  scrollView:setMinScale(1)
  scrollView:setMaxScale(maxScale)
  _G.touchMaskEnabled = false
  local card = HeroBigCard.new({
    heroId = self.heroId,
    quality = self.hero.quality
  }):pos(300 * maxScale, 270 * maxScale):addTo(scrollView)
  local broken = 300 >= self.hero.hpPercent
  local changeBtn = UIHelper.extend(ccui.Button:create())
  changeBtn:setImages(detailRes, {
    "break_a.png",
    "break_a.png"
  })
  changeBtn:pos(display.width - 30, display.height / 2 - 50):addTo(maskLayer):hide()
  changeBtn:setTouchScale()
  changeBtn:setCallback(function()
    broken = not broken
    local res = UIHelper.getCardRes("normal", self.hero:getDressType(), broken, self.hero.quality)
    if card and not tolua.isnull(card) then
      card:setImage(res)
    end
  end)
  local closeBtn = UIHelper.extend(ccui.Button:create())
  closeBtn:setImages(detailRes, {
    "close_a.png",
    "close_a.png"
  })
  closeBtn:pos(display.width - 30, display.height / 2 + 50):addTo(maskLayer):hide()
  closeBtn:setTouchScale()
  closeBtn:setCallback(function()
    _G.touchMaskEnabled = true
    TopBar:show()
    self.maskNode:removeAllChildren()
    self.heroNode:show()
  end)
  card:runAction(transition.sequence({
    cc.Spawn:create({
      cc.RotateBy:create(0.5, -90),
      cc.ScaleTo:create(0.5, 1.2),
      cc.MoveTo:create(0.5, cc.p(600 * maxScale, 350 * maxScale))
    }),
    cc.CallFunc:create(function()
      changeBtn:show()
      closeBtn:show()
    end)
  }))
end

return HeroDetailLayer
