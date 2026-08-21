local GlobalRes = "ui/global/"
local HeroRes = "ui/hero/"
local BattleRes = "ui/battle/"
local PresetRes = "ui/hero/preset/"
local TaskRes = "ui/carbon/task/"
local cookRes = "ui/kitchen/cook/"
local StrengthRes = "ui/kitchen/strength/"
local EquipRes = "ui/equip/card/"
local SauceRes = "ui/sauce/card/"
local UnitCsv = require("csvdata.unit")
local ItemCsv = require("csvdata.item")
local equipCsv = require("csvdata.equip")
local AccessCsv = require("csvdata.diner_accessory")
local FitmentCsv = require("csvdata.diner_fitment")
local SauceCsv = require("csvdata.sauce")
local SauceBreakCsv = require("csvdata.sauce_break")
local FoodPicCsv = require("csvdata.food_pic")
BattleHeroHead = class("BattleHeroHead", function(params)
  local hero = params.id and game.role.heros[params.id] or nil
  local type = hero and hero.type or params.type or 0
  local unit = UnitCsv[type]
  local star = hero and hero.star or params.star or unit.star
  local leader = params.leader
  local index = (params.index - 1) % 3 + 1
  local head = display.newSprite(BattleRes .. "hero_head_bg.png")
  head:scale(0.72):anch(0, 0)
  display.newSprite(unit.headRes):center(head):addTo(head)
  local size = cc.size(head:getContentSize().width * 0.72, head:getContentSize().height * 0.72)
  local content = display.newLayer()
  content:size(size):anch(0.5, 0.5):addChild(head)
  display.newSprite(HeroRes .. string.format("battle_hero_%d.png", index)):center(head):addTo(head)
  local xInterval = 14
  local temStar = math.min(star, 5)
  local xBegin = head:getContentSize().width / 2 - (temStar - 1) * xInterval / 2
  local isBlack = globalCsv.blackHeroUnitIds[type] == 1
  local isMengJing = globalCsv.mengJingHeroUnitIds[type] == 1
  for index = 1, temStar do
    UIHelper.newImageView(GlobalRes .. (isMengJing and "small_star_extra.png" or isBlack and "small_star_black.png" or "small_star.png")):pos(xBegin + (index - 1) * xInterval, 17):addTo(head)
  end
  if leader then
    display.newSprite(HeroRes .. "captain.png"):scale(0.62):anch(1, 1):pos(size.width, size.height + 5):addTo(content)
  end
  if params.beBoss then
    display.newSprite("ui/carbon/detail_1/boss_jingying.png"):scale(0.72):flipX(true):anch(0, 1):pos(size.width - 37, size.height):addTo(content)
  end
  return content
end)
MonsterHead = class("MonsterHead", function(params)
  local type = params.type
  local itemData = ItemCsv[type]
  local star = params.star or itemData.star
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(GlobalRes .. "item_bg.png")
  if params.showTip then
    content:setTouchEnabled(true)
    content:setCallback(function()
      MTip:show({
        type = MTipType.manster,
        node = content,
        itemType = type,
        itemData = itemData,
        count = params.count
      })
    end)
  end
  UIHelper.getClipNode({
    steRes = "ui/global/mask_1.png",
    clipRes = itemData.icon
  }):scale(0.7):center(content):addTo(content)
  display.newSprite(string.format("%sframe_%d.png", GlobalRes, star)):center(content):addTo(content)
  if DEBUG > 0 then
    UIHelper.newText({
      text = itemData.itemId,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):center(content):addTo(content):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
  return content
end)
SkillIcon = class("SkillIcon", function(params)
  local desc = params.desc
  local heroType = params.heroType
  local unitData = UnitCsv[heroType]
  local skillicon, icontype = nil, 0
  if desc == "block" then
    local id = unitData.blockId
    skillicon = blockCCsv[id].icon
    icontype = blockCCsv[id].type
  elseif desc == "special" then
    local id = unitData.specialBlock
    skillicon = id ~= 0 and blockSCsv[id].icon or nil
    icontype = blockSCsv[id].type
  else
    return
  end
  local steRes = desc == "block" and "block_stencil.png" or "special_stencil.png"
  local frame = desc == "block" and string.format("head_frame_%d.png", params.level) or string.format("special_frame_%d.png", params.level)
  local bg = desc == "block" and string.format("head_bg_%d.png", params.level) or "special_bg.png"
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage("ui/hero/" .. bg)
  if params.callback then
    content:setTouchEnabled(true)
    content:setCallback(params.callback)
  end
  if skillicon then
    UIHelper.newImageView(skillicon):center(content):addTo(content)
  end
  UIHelper.newImageView("ui/hero/" .. frame):anch(0.5, 0.5):center(content):addTo(content)
  if icontype ~= 0 then
    local hheight = desc == "block" and 97 or 100
    local typeString = {
      [1] = "物理",
      [2] = "魔法",
      [3] = "支援"
    }
    local color = {
      [1] = UIHelper.hex2rgb("#51fef4"),
      [2] = UIHelper.hex2rgb("#fd48ff"),
      [3] = UIHelper.hex2rgb("#ffee7e")
    }
    UIHelper.newText({
      text = typeString[icontype],
      size = 16,
      color = color[icontype]
    }):anch(0.5, 1):pos(content:getContentSize().width / 2, hheight):addTo(content):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
  local height = desc == "block" and 33 or 38
  if skillicon and params.level and 0 < params.level then
    UIHelper.newText({
      text = string.format("Lv%d", params.level),
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 1):pos(content:getContentSize().width / 2, height):addTo(content):enableOutline(UIHelper.hex2rgb("#151515"), 1)
  end
  return content
end)
BreakItem = class("BreakItem", function(params)
  local itemData = ItemCsv[params.type]
  local content = ItemIcon.new({
    type = params.type
  })
  local size = content:getContentSize()
  UIHelper.newImageView(GlobalRes .. "quality_frame" .. itemData.quality .. ".png"):center(content):addTo(content)
  local count = params.count or 0
  if count == 0 then
    local icon = content:getChildByName("icon")
    UIHelper.setImageViewGray(icon)
  end
  local status = {
    ["无镶嵌"] = {color = "#FFFFFF"},
    ["可合成"] = {color = "#77EB21"},
    ["未镶嵌"] = {color = "#FFFFFF"},
    ["可镶嵌"] = {color = "#77EB21"},
    ["可获得"] = {color = "#77EB21"}
  }
  if params.text then
    UIHelper.newText({
      text = params.text,
      size = 16,
      color = UIHelper.hex2rgb(status[params.text].color)
    }):pos(size.width / 2, 19):addTo(content):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
  content:setCallback(params.callback)
  return content
end)
ItemIcon = class("ItemIcon", function(params)
  local type = params.type or params.id or 0
  local count = 0
  local itemData = ItemCsv[type]
  if not itemData then
    print("错误，物品表id没有找到，id=", type)
  end
  local count = params.id and game.role.items[params.id] or params.count or 0
  local star = params.star or itemData.star
  local content = UIHelper.extend(ccui.ImageView:create())
  if itemData.type == ItemType.HeadIcon then
    content:setImage("ui/home/roleDetail/icon_bg.png")
    content:scale(0.9591836734693877)
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite("ui/global/head_circle_bg.png"):center(content):addTo(content)
  elseif itemData.type == ItemType.HeadFarme then
    content:setImage("ui/home/roleNode/head_bg.png")
    content:scale(0.8)
    display.newSprite(itemData.icon):scale(0.8):center(content):addTo(content)
  elseif itemData.type == ItemType.Equip or itemData.type == ItemType.NewEquip then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star - 2))
  elseif itemData.type == ItemType.LoveItem or itemData.type == ItemType.PangCi or itemData.type == ItemType.LoveExp then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star - 2))
  elseif itemData.type == ItemType.Accessory or itemData.type == ItemType.DinerCar or itemData.type == ItemType.TreeItem then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star))
  elseif itemData.type == ItemType.Ring or itemData.type == ItemType.Sauce then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star - 1))
  else
    content:setImage(GlobalRes .. "item_bg.png")
  end
  if params.callback then
    content:setCallback(params.callback)
  elseif params.showTip then
    content:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = content,
        itemType = type,
        itemData = itemData,
        count = count,
        equipId = params.equipId
      })
      if params.selectCallback then
        params.selectCallback(type, content)
      end
    end)
  end
  if itemData.type == ItemType.HeadIcon or itemData.type == ItemType.HeadFarme then
    return content
  end
  local size = content:getContentSize()
  if itemData.type == ItemType.Hero or itemData.type == ItemType.AwakeHero then
    UIHelper.getClipNode({
      steRes = GlobalRes .. "mask_1.png",
      clipRes = itemData.icon
    }):scale(0.7):center(content):addTo(content)
    UIHelper.newImageView(GlobalRes .. "star_bg.png"):pos(size.width / 2, 11):addTo(content)
    UIHelper.newImageView(GlobalRes .. "item_frame.png"):anch(0.5, 0.5):pos(size.width / 2, size.height / 2):addTo(content)
    local proBg = UIHelper.newImageView(GlobalRes .. "profession_bg_0.png"):scale(0.75):pos(15, 77):addTo(content)
    UIHelper.newImageView(GlobalRes .. string.format("profession_%s.png", itemData.content)):center(proBg):addTo(proBg)
    if itemData.type == ItemType.AwakeHero then
      local awakeType = math.floor((itemData.itemId - ItemStartId.awakeHero) / 10)
      local awakeLevel = (itemData.itemId - ItemStartId.awakeHero) % 10
      local awakeLogoPath = CommonHelper.getAwakeNoTypePath(1, awakeType, awakeLevel, star)
      if awakeLogoPath then
        display.newSprite(string.format("ui/hero/awake/awake%d.png", awakeLogoPath)):pos(100, 20):addTo(proBg)
      end
    end
  elseif itemData.type == ItemType.Dress then
    UIHelper.getClipNode({
      steRes = GlobalRes .. "mask_1.png",
      clipRes = itemData.icon
    }):scale(0.7):center(content):addTo(content)
    UIHelper.newImageView(GlobalRes .. "item_frame.png"):anch(0.5, 0.5):pos(size.width / 2, size.height / 2):addTo(content)
    display.newSprite(GlobalRes .. "dress_tag.png"):pos(15, 77):addTo(content)
  elseif itemData.type == ItemType.Equip then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star - 2)):center(content):addTo(content)
    local equipData = equipCsv[itemData.itemId - ItemStartId.equip]
    local proBg = UIHelper.newImageView(string.format("%sequip_pro_bg_%d.png", EquipRes, star - 2)):scale(0.75):pos(12, 80):addTo(content)
    display.newSprite(string.format("%sprofession_tag_%d.png", EquipRes, equipData.profession)):center(proBg):addTo(proBg)
  elseif itemData.type == ItemType.NewEquip then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star - 2)):center(content):addTo(content)
    local equipData = equipCsv[itemData.itemId - ItemStartId.newEquip]
    local proBg = UIHelper.newImageView(string.format("%sequip_pro_bg_%d.png", EquipRes, star - 2)):scale(0.75):pos(12, 80):addTo(content)
    display.newSprite(string.format("%sprofession_tag_%d.png", EquipRes, equipData.profession)):center(proBg):addTo(proBg)
  elseif itemData.type == ItemType.LoveItem or itemData.type == ItemType.PangCi or itemData.type == ItemType.LoveExp then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star - 2)):center(content):addTo(content)
  elseif itemData.type == ItemType.Accessory or itemData.type == ItemType.DinerCar then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star)):center(content):addTo(content)
  elseif itemData.type == ItemType.Ring or itemData.type == ItemType.TreeItem then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star)):center(content):addTo(content)
  elseif itemData.type == ItemType.Sauce then
    display.newSprite(itemData.icon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star - 1)):center(content):addTo(content)
    local proBg = UIHelper.newImageView(GlobalRes .. string.format("profession_bg_%d.png", star - 1)):scale(0.75):pos(15, 80):addTo(content)
    UIHelper.newImageView(GlobalRes .. string.format("profession_%s.png", SauceCsv[itemData.itemId - ItemStartId.sauce].profession)):center(proBg):addTo(proBg)
  else
    local icon = UIHelper.newImageView(itemData.icon):pos(47, 46):addTo(content)
    if itemData.type == ItemType.Medel then
      icon:scale(0.9)
    end
    UIHelper.newImageView(GlobalRes .. "item_frame.png"):anch(0.5, 0.5):pos(size.width / 2, size.height / 2):addTo(content)
  end
  if 0 < star then
    if itemData.type == ItemType.Seed then
      for index = 1, star do
        local x = 10 + (index - 1) * 15
        display.newSprite("ui/carbon/chooseTravel/worth.png"):anch(0.5, 1):pos(x, 92):addTo(content)
      end
    elseif itemData.type == ItemType.Equip or itemData.type == ItemType.NewEquip or itemData.type == ItemType.LoveItem or itemData.type == ItemType.PangCi or itemData.type == ItemType.Ring or itemData.type == ItemType.TreeItem or itemData.type == ItemType.Sauce or itemData.type == ItemType.LoveExp or itemData.type == ItemType.BuildDraw or itemData.type == ItemType.RandGiftOpen or itemData.type == ItemType.RandSauce or itemData.type == ItemType.Dress or itemData.type == ItemType.JobItem then
    else
      local xInterval = 14
      local temStar = math.min(star, 5)
      local isBlack = globalCsv.blackHeroUnitIds[itemData.itemId % 1000] == 1
      local isMengJing = globalCsv.mengJingHeroUnitIds[itemData.itemId % 1000] == 1
      local xBegin = size.width / 2 - (temStar - 1) * xInterval / 2
      for index = 1, temStar do
        UIHelper.newImageView(GlobalRes .. (isMengJing and itemData.star > 5 and itemData.type == ItemType.Hero and "small_star_extra.png" or isBlack and "small_star_black.png" or "small_star.png")):pos(xBegin + (index - 1) * xInterval, 12):addTo(content)
      end
    end
  end
  if params.needCount and 0 < params.needCount then
    local numLabel = UIHelper.newText({
      text = string.format("%d/%d", count, params.needCount),
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 2):anch(1, 0.5):pos(size.width - 9, 15):addTo(content)
    if count >= params.needCount then
      numLabel:setTextColor(UIHelper.hex2rgb("#00ff00"))
    else
      numLabel:setTextColor(UIHelper.hex2rgb("#ff0000"))
    end
  elseif 1 < count or params.needShowCount then
    UIHelper.newText({
      text = count,
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(size.width - 8, 6):addTo(content)
  end
  if 0 < DEBUG then
    UIHelper.newText({
      text = itemData.itemId,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):center(content):addTo(content):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
  return content
end)
TalentIcon = class("TalentIcon", function(params)
  local content = UIHelper.newImageView("ui/pet/talent_bg.png")
  UIHelper.newImageView(params.res):center(content):addTo(content)
  UIHelper.newImageView("ui/pet/talent_frame.png"):center(content):addTo(content)
  if params.talentData then
    content:setCallback(function()
      MTip:show({
        type = MTipType.talent,
        node = content,
        talentData = params.talentData
      })
    end)
  end
  return content
end)
HaloIcon = class("HaloIcon", function(params)
  local content = UIHelper.newImageView("ui/beauty/halo_frame.png")
  local haloCsv = require("csvdata.goddess_halo")
  local haloData = haloCsv[params.type]
  local icon = UIHelper.newImageView(haloData.icon):center(content):addTo(content)
  if params.level > 0 then
    display.newTTFLabel({
      text = "Lv" .. params.level,
      color = UIHelper.hex2rgb("#ffffff"),
      size = 22
    }):pos(content:getContentSize().width / 2, 16):enableOutline(UIHelper.hex2rgb("#000000"), 2):addTo(content)
  else
    UIHelper.newImageView("ui/pet/talent_mengban.png"):center(content):addTo(content)
    icon:setColor(UIHelper.hex2rgb("#7F7F7F"))
  end
  content:setCallback(function()
    MTip:show({
      type = MTipType.halo,
      node = content,
      talentData = haloData
    })
  end)
  return content
end)
PetIcon = class("PetIcon", function(params)
  local type = params.itemid or params.id or 0
  local count = 0
  local itemData = ItemCsv[type]
  if not itemData then
    print("错误，物品表id没有找到，id=", type)
  end
  local star = params.star or itemData.star
  local content = UIHelper.extend(ccui.ImageView:create())
  if params.callback then
    content:setCallback(params.callback)
  elseif params.showTip then
    content:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = content,
        itemType = type,
        itemData = itemData,
        count = count
      })
    end)
  end
  content:setImage("ui/global/item_content.png")
  local size = content:getContentSize()
  UIHelper.newImageView(itemData.icon):center(content):addTo(content):scale(0.95)
  UIHelper.newImageView(GlobalRes .. "new_frame_" .. star .. ".png"):center(content):addTo(content)
  local pet = game.role.pets[params.itemid - ItemStartId.pet]
  if pet then
    local strength = params.strength or pet.strength
    local level = params.level or pet.level
    display.newTTFLabel({
      text = strength == 0 and "" or "+" .. strength,
      size = 26,
      color = UIHelper.hex2rgb("#33f624")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(content:getContentSize().width / 2 + 22, 74):addTo(content)
    display.newTTFLabel({
      text = "Lv" .. level .. "/100",
      size = 16,
      color = UIHelper.hex2rgb("#33f624")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(content:getContentSize().width / 2 + 2, 13):addTo(content)
  end
  return content
end)
EquipIcon = class("EquipIcon", function(params)
  local equip = game.role.equips[params.id]
  local unitData = equipCsv[equip.type]
  local star = unitData.star - 2
  local showHero = params.showHero and true
  local big = params.big or false
  local content = UIHelper.extend(ccui.ImageView:create())
  if not big then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star))
    local size = content:getContentSize()
    display.newSprite(unitData.cardIcon):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star)):center(content):addTo(content)
    local proBg = UIHelper.newImageView(string.format("%sequip_pro_bg_%d.png", EquipRes, star)):scale(0.75):pos(12, 82):addTo(content)
    display.newSprite(string.format("%sprofession_tag_%d.png", EquipRes, unitData.profession)):center(proBg):addTo(proBg)
  else
    content:setImage(string.format("ui/equip/detail/bg_%d.png", star))
    local size = content:getContentSize()
    display.newSprite(unitData.cardIcon):center(content):addTo(content)
    display.newSprite("ui/hero/detail/equip_frame.png"):center(content):addTo(content)
    local proBg = UIHelper.newImageView(string.format("%sequip_pro_bg_%d.png", EquipRes, star)):scale(0.85):pos(10, 90):addTo(content)
    display.newSprite(string.format("%sprofession_tag_%d.png", EquipRes, unitData.profession)):center(proBg):addTo(proBg)
  end
  if showHero and equip.masterId ~= 0 then
    local hero = game.role.heros[equip.masterId]
    if hero then
      local heroBg = display.newSprite(EquipRes .. "hero_bg.png"):scale(0.7):pos(66, 26):addTo(content)
      UIHelper.getClipNode({
        steRes = GlobalRes .. "mask_2.png",
        clipRes = UIHelper.getCardRes("book", hero:getDressType(), nil, hero.quality)
      }):scale(0.6):center(heroBg):addTo(heroBg)
      display.newSprite(EquipRes .. "hero_fram.png"):scale(0.7):pos(62, 30):addTo(content)
    end
  end
  return content
end)
SauceIcon = class("SauceIcon", function(params)
  local sauce = game.role.sauces[params.id]
  local unitData = ItemCsv[sauce:getItemId()]
  local star = unitData.star
  local showHero = params.showHero and true
  local big = params.big or false
  local content = UIHelper.extend(ccui.ImageView:create())
  if not big then
    content:setImage(string.format("%sbg_%d.png", GlobalRes, star - 1))
    display.newSprite("icon/sauce/" .. sauce:getIconImg()):center(content):addTo(content)
    display.newSprite(string.format("%sframe_%d.png", GlobalRes, star - 1)):center(content):addTo(content)
    local proBg = UIHelper.newImageView(SauceRes .. string.format("sauce_pro_bg_%d.png", star)):scale(0.75):pos(15, 80):addTo(content)
    display.newSprite(string.format("ui/global/profession_%d.png", sauce.csvData.profession)):center(proBg):addTo(proBg)
  else
    content:setImage(SauceRes .. string.format("card_bg_%d.png", star))
    display.newSprite(sauce:getSmallImg()):center(content):addTo(content)
    display.newSprite(SauceRes .. "card_top_frame.png"):center(content):addTo(content)
    local proBg = UIHelper.newImageView(SauceRes .. string.format("sauce_pro_bg_%d.png", star)):scale(0.6):pos(10, 126):addTo(content)
    display.newSprite(string.format("ui/global/profession_%d.png", sauce.csvData.profession)):center(proBg):addTo(proBg)
  end
  display.newTTFLabel({
    text = sauce.breakL >= #SauceBreakCsv[sauce.type] and "MAX" or string.format("Lv%d", sauce.breakL),
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(3, 3):addTo(content)
  if showHero and sauce.masterId ~= 0 then
    local hero = game.role.heros[sauce.masterId]
    if hero then
      local heroBg = display.newSprite(SauceRes .. "hero_bg.png"):scale(0.7):pos(66, 26):addTo(content)
      UIHelper.getClipNode({
        steRes = GlobalRes .. "mask_2.png",
        clipRes = UIHelper.getCardRes("book", hero:getDressType(), nil, hero.quality)
      }):scale(0.6):center(heroBg):addTo(heroBg)
      display.newSprite(SauceRes .. "hero_fram.png"):scale(0.7):pos(62, 30):addTo(content)
    end
  end
  return content
end)
AccessIcon = class("AccessIcon", function(params)
  local access = game.role.diner.accessories[params.id]
  local data = AccessCsv[access.type]
  local itemData = ItemCsv[data.item]
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(GlobalRes .. "bg_" .. itemData.star .. ".png")
  display.newSprite(itemData.icon):center(content):addTo(content)
  display.newSprite(string.format("%sframe_%d.png", GlobalRes, itemData.star)):center(content):addTo(content)
  if access.level > 0 and data.type ~= 3 then
    local level = data.maxLevel == access.level and "Max" or tostring(access.level)
    display.newTTFLabel({
      text = string.format("Lv%s", level),
      size = 18,
      color = UIHelper.hex2rgb("#fff600")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(85, 80):addTo(content)
  end
  if data.type ~= 3 and params.energy and not params.recycle then
    local bg = display.newSprite("ui/diner/choose/energy_bg.png"):pos(45, 15):addTo(content)
    display.newSprite("ui/diner/choose/" .. (data.type == 1 and "energy_add.png" or "energy_sub.png")):pos(21, 12):addTo(bg)
    display.newTTFLabel({
      text = math.floor(data.energy * globalCsv.dinnerEntryStrengthRange:getv(access.level, 1)),
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(52, 13):addTo(bg)
  end
  if params.big then
    local cell = UIHelper.newImageView("ui/diner/choose/cell.png")
    content:pos(55, 82):addTo(cell)
    display.newTTFLabel({
      text = itemData.name,
      size = 16,
      color = UIHelper.hex2rgb("#753613")
    }):pos(55, 18):addTo(cell)
    if params.owner then
      local bg = display.newSprite("ui/diner/choose/ower_bg.png"):anch(0, 0.5):pos(1, 116):addTo(cell)
      display.newTTFLabel({
        text = "餐车" .. params.owner,
        size = 16
      }):enableOutline(UIHelper.hex2rgb("#90230e"), 1):anch(0, 0.5):pos(8, 13):addTo(bg)
    end
    if params.showTip then
      content:setTouchEnabled(true)
      content:setSwallowTouches(false)
      content:setCallback(function()
        MTip:show({
          type = MTipType.acc,
          node = content,
          itemData = itemData,
          access = access
        })
      end)
    end
    return cell
  end
  return content
end)
FitIcon = class("FitIcon", function(params)
  local data = FitmentCsv[params.id]
  local itemData = ItemCsv[data.item]
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(GlobalRes .. "bg_" .. itemData.star .. ".png")
  display.newSprite(itemData.icon):center(content):addTo(content)
  display.newSprite(string.format("%sframe_%d.png", GlobalRes, itemData.star)):center(content):addTo(content)
  if params.count then
    UIHelper.newText({
      text = params.count,
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(content)
  end
  if params.big then
    local cell = UIHelper.newImageView("ui/diner/choose/cell.png")
    content:pos(55, 82):addTo(cell)
    display.newTTFLabel({
      text = itemData.name,
      size = 16,
      color = UIHelper.hex2rgb("#753613")
    }):pos(55, 18):addTo(cell)
    return cell
  end
  return content
end)
TreeIcon = class("FitIcon", function(params)
  local itemData = ItemCsv[params.itemId]
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(GlobalRes .. "bg_" .. itemData.star .. ".png")
  display.newSprite(itemData.icon):center(content):addTo(content)
  display.newSprite(string.format("%sframe_%d.png", GlobalRes, itemData.star)):center(content):addTo(content)
  if params.count and params.count > 0 then
    UIHelper.newText({
      text = params.count,
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(85, 6):addTo(content)
  end
  if params.big then
    local cell = UIHelper.newImageView("ui/diner/choose/cell.png")
    content:pos(55, 82):addTo(cell)
    display.newTTFLabel({
      text = itemData.name,
      size = 16,
      color = UIHelper.hex2rgb("#753613")
    }):pos(55, 18):addTo(cell)
    return cell
  end
  return content
end)
AutoComposeLayer = class("AutoComposeLayer", function(params)
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setBackGroundColorType(1)
  mask:setBackGroundColorOpacity(191)
  mask:setCallback(function(sender)
    mask:removeFromParent()
  end)
  mask:addTo(display.getRunningScene(), POPUP_LAYER_ORDER, mask:getTag())
  local size = cc.size(651, 314)
  local content = UIHelper.newImageView("ui/global/common_dialog_bg.png")
  content:setCapInsets(cc.rect(44, 44, 2, 2))
  content:setScale9Enabled(true)
  content:setContentSize(size):anch(0.5, 0.5):center():addTo(mask)
  content:setTouchEnabled(true)
  display.newTTFLabel({
    text = "一键合成",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(size.width / 2, size.height - 35):addTo(content)
  local list = ccui.ListView:create()
  list:setDirection(ccui.ScrollViewDir.horizontal)
  list:size(cc.size(600, 90))
  list:setInnerContainerSize(cc.size(600, 90))
  list:setItemsMargin(15)
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(size.width / 2, 195):addTo(content)
  local nodeSize = display.newSprite("ui/global/item_bg_1.png"):getContentSize()
  for _, typeId in pairs(params.itemList) do
    local viewNode = ccui.Widget:create()
    viewNode:size(nodeSize):addTo(list)
    local itemIcon = ItemIcon.new({type = typeId})
    itemIcon:anch(0.5, 0.5):pos(nodeSize.width / 2, nodeSize.height / 2):addTo(viewNode)
  end
  local text = string.format("确定花费<div color=#33f624>%d</div><img src='ui/global/icon_gold.png'/>为<div color=#ffae09>%s</div>合并并穿戴上", params.money, params.name)
  local label = MRichText.new({
    text = text,
    color = UIHelper.hex2rgb("#afe7ff"),
    size = 20
  }):anch(0.5, 0.5):pos(size.width / 2, 110):addTo(content)
  local cancelBtn = UIHelper.extend(ccui.Button:create())
  cancelBtn:setImages(GlobalRes, {
    "btn_common_a.png",
    "btn_common_b.png",
    "btn_common_c.png"
  })
  cancelBtn:setString({
    text = textByKey("cancel")
  })
  cancelBtn:anch(0.5, 0.5):pos(200, 55):addTo(content)
  cancelBtn:setCallback(function()
    mask:removeFromParent()
  end)
  local okBtn = UIHelper.extend(ccui.Button:create())
  okBtn:setImages(GlobalRes, {
    "btn_common_a.png",
    "btn_common_b.png",
    "btn_common_c.png"
  })
  okBtn:setString({
    text = textByKey("ok")
  })
  okBtn:anch(0.5, 0.5):pos(480, 55):addTo(content)
  okBtn:name("autoOkBtn")
  okBtn:setCallback(function()
    if params.callback then
      params.callback()
    end
    mask:removeFromParent()
  end)
  return mask
end)
RoleHead = class("RoleHead", function(params)
  local mainHeroType = params.mainHeroType
  local vip = params.vip
  local level = params.level
  local content = UIHelper.newImageView("ui/home/role_node_head.png")
  display.newSprite(UnitCsv[mainHeroType].headRes):scale(0.8):center(content):addTo(content)
  display.newSprite("ui/home/role_node_frame.png"):center(content):addTo(content)
  display.newSprite(string.format("ui/activity/vip/vip_%d.png", vip)):anch(0, 1):scale(0.55):pos(30, 80):addTo(content)
  if level then
    display.newTTFLabel({
      text = "Lv" .. level,
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#11119E"), 2):anch(1, 0.5):pos(content:getContentSize().width - 3, 10):addTo(content)
  end
  return content
end)
FormatHead = class("FormatHead", function(params)
  local type = params.type
  local quality = params.quality or 5
  local content
  if type then
    local unit = UnitCsv[type]
    content = UIHelper.newImageView(PresetRes .. "black_bg.png")
    UIHelper.getClipNode({
      steRes = "ui/global/mask_3.png",
      clipRes = UIHelper.getCardRes("book", type, nil, quality)
    }):scale(0.8):center(content):addTo(content)
    UIHelper.newImageView(PresetRes .. "out_circle.png"):center(content):addTo(content)
  else
    content = UIHelper.newImageView(PresetRes .. "common_bg.png")
  end
  return content
end)
HuoBiIcon = class("HuoBiIcon", function(params)
  local content = UIHelper.newImageView(TaskRes .. "huobi_bg.png")
  display.newSprite(string.format(cookRes .. "material%d.png", params.base)):setScale(0.46):center(content):addTo(content)
  local size = content:getContentSize()
  display.newTTFLabel({
    text = params.count,
    size = 28,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0):pos(size.width - 7, 5):addTo(content):name("count")
  return content
end)
HeroItem = class("HeroItem", function(params)
  local type = params.type
  local unitData = UnitCsv[type]
  local content
  if unitData then
    content = UIHelper.extend(ccui.ImageView:create())
    content:setImage(GlobalRes .. "item_bg.png")
    UIHelper.getClipNode({
      steRes = GlobalRes .. "mask_1.png",
      clipRes = UIHelper.getCardRes("book", type)
    }):scale(0.7):center(content):addTo(content)
    UIHelper.newImageView(GlobalRes .. "item_frame.png"):center(content):addTo(content)
  end
  return content
end)
HeroBigCard = class("HeroBigCard", function(params)
  local type = params.type
  local quality = params.quality or 5
  local broken = false
  if params.heroId then
    local hero = game.role.heros[params.heroId]
    if hero.hpPercent <= 300 then
      broken = true
    end
    type = hero:getDressType()
  end
  if params.showPic and game.role:activityIsOpen(57) then
    local data = FoodPicCsv[type] or FoodPicCsv[math.floor(type / 10) - 3000]
    if data then
      local content = UIHelper.extend(ccui.ImageView:create())
      content:setImage(data.res)
      content:anch(0.5, 0.3)
      if broken then
        UIHelper.setImageViewGray(content)
      end
      return content
    end
  end
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(UIHelper.getCardRes("normal", type, broken, quality))
  return content
end)
StrengthCard = class("StrengthCard", function(params)
  local id = params.id
  local hero = game.role.heros[id]
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(GlobalRes .. string.format("big_card_bg_%d.png", hero.quality))
  display.newSprite(UIHelper.getCardRes("list", hero.type, false, hero.quality)):center(content):addTo(content)
  display.newSprite(StrengthRes .. string.format("bg_%d.png", hero.quality)):center(content):addTo(content)
  local star = hero.unit.star
  local bMax = hero:isTreeMax()
  local isBlack = hero:isBlackHero()
  local isMengJing = hero:isMengJingHero()
  local isShengcan = hero:isShengcanHero()
  local temStar = math.min(star, 5)
  local xPos = 80 - (temStar - 1) / 2 * 20
  if isShengcan then
    for i = 1, temStar do
      display.newSprite(StrengthRes .. (bMax and "star_tree_red.png" or "star_tree.png")):pos(xPos + (i - 1) * 20, 80):addTo(content)
    end
  else
    for i = 1, temStar do
      display.newSprite(StrengthRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos(xPos + (i - 1) * 20, 80):addTo(content)
    end
  end
  UIHelper.getProfessionTag(hero.unit.profession, hero.quality, 18, hero:showTreeTag()):pos(142, 482):addTo(content)
  display.newTTFLabel({
    text = hero:getName(),
    size = 18,
    color = UIHelper.hex2rgb("#000000")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(80, 45):addTo(content)
  local isAdvanceMax = hero:isSauceAdvanceMax()
  display.newTTFLabel({
    text = "Lv" .. hero.level,
    size = 24,
    color = UIHelper.hex2rgb(isAdvanceMax and "#0afff1" or "#000000")
  }):enableOutline(UIHelper.hex2rgb(isAdvanceMax and "#000000" or "#ffffff"), isAdvanceMax and 1 or 2):pos(80, 20):addTo(content)
  return content
end)
