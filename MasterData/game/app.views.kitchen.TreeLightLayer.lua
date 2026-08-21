local ItemCsv = require("csvdata.item")
local PointCsv = require("csvdata.treepoint")
local GetCsv = require("csvdata.treeget")
local BattleCsv = require("csvdata.chapter_battle")
local SSkillCsv = require("csvdata.skill_special")
local BSkillCsv = require("csvdata.skill_block")
local FormatCsv = require("csvdata.formation")
local LightRes = "ui/kitchen/tree/light/"
local MainRes = "ui/kitchen/tree/main/"
local ImgRes = "icon/tree/"
local uiData = {
  csbFile = "ui/kitchen/TreeLightLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    panel1 = "panel1",
    title1 = "panel1/title1",
    list = "panel1/list",
    panel2 = "panel2",
    title2 = "panel2/title2",
    title3 = "panel2/title3",
    node2 = "panel2/node2",
    node3 = "panel2/node3",
    btnUp = "panel2/btnUp"
  }
}
local TreeLightLayer = class("TreeLightLayer", UIBase)

function TreeLightLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TreeLightLayer:init(params)
  self.parent = params.parent
  self.title1:setString("入手方式")
  self.title2:setString("消耗材料")
  self.title3:setString("提升效果")
  UIHelper.MoveToLeft({
    node = self.panel2,
    time = 0.15
  })
  UIHelper.MoveToRight({
    node = self.panel1,
    time = 0.15
  })
  self.curStep = (params.curStep or 0) + 1
  self.hero = game.role.heros[params.heroId]
  self.costHeroes = {}
  self.canUp = true
  self.btnUp:setTouchScale()
  self.btnUp:setCallback(function()
    if self.canUp then
      params.callback(self.costHeroes, function()
        if self.hero:checkPointMax(params.step, params.index) then
          self:close()
        else
          self.costHeroes = {}
          MFlashMsg:show({
            text = "当前属性点等级得到提升"
          })
          self:showData(params)
        end
      end)
    else
      SysError(SYS_ERR_TREE_MATERIAL_NOT_ENOUGH)
    end
  end)
end

function TreeLightLayer:showData(params)
  self.node2:removeAllChildren()
  self.node3:removeAllChildren()
  local hero = game.role.heros[params.heroId]
  local curLevel = hero:getPointLevel(params.step, params.index)
  local pointCsv = PointCsv[hero.type][params.step or 1][params.index or 1]
  local pointData = pointCsv[math.min(#pointCsv, curLevel + 1)]
  local cost = pointData.pointMaterial:toTableArray()
  if tonumber(cost[1][1]) > 1000 and (tonumber(cost[1][1]) < 900005 or tonumber(cost[1][1]) > 900500) then
    self:showCostHeros(cost)
  else
    self:showCostItems(cost)
  end
  local attrList = ccui.ListView:create()
  attrList:size(cc.size(354, 228))
  attrList:setInnerContainerSize(cc.size(354, 228))
  attrList:setClippingEnabled(true)
  attrList:setBounceEnabled(true)
  attrList:anch(0, 1):pos(-20, 29):addTo(self.node3)
  local types = pointData.pointType:toTableArray()
  for _, addValue in ipairs(types) do
    local addType, value = tonumber(addValue[1]), tonumber(addValue[2])
    if addType ~= 11 then
      local viewNode = ccui.Widget:create()
      local pointNode = display.newNode():addTo(viewNode)
      local height = 0
      if addType == 7 then
        height = 75
        display.newSprite(ImgRes .. string.format("attr_done_%d.png", value)):scale(0.7):pos(20, -10):addTo(pointNode)
        MRichText.new({
          text = pointData.desc,
          color = UIHelper.hex2rgb("#703902"),
          size = 20,
          maxWidth = 250
        }):anch(0, 1):pos(60, 5):addTo(pointNode)
      elseif addType == 9 or addType == 10 or addType == 13 then
        height = 130
        local levels = hero:getTotalAttrFactors()
        local skillCsv = addType == 9 and SSkillCsv or BSkillCsv
        local level = addType == 9 and levels.specialLv or levels.blockLv
        local dalteY = addType == 9 and 0 or 25
        local skillData = skillCsv[value][level]
        local content = display.newSprite("ui/hero/detail/skill_bg.png"):pos(10, -35 + dalteY):addTo(pointNode)
        UIHelper.getClipNode({
          steRes = "ui/hero/detail/skill_mask.png",
          clipRes = skillData.icon
        }):scale(0.47):center(content):addTo(content)
        display.newTTFLabel({
          text = skillData.name,
          size = 18,
          color = UIHelper.hex2rgb("#0d92ae")
        }):anch(0, 0.5):pos(45, -13 + dalteY):addTo(pointNode)
        display.newSprite("ui/hero/detail/mask.png"):center(content):addTo(content)
        display.newTTFLabel({
          text = skillData.desc,
          size = 16,
          color = UIHelper.hex2rgb("#703803"),
          dimensions = cc.size(290, 130)
        }):anch(0, 1):pos(45, -29 + dalteY):addTo(pointNode)
        for index = 1, 5 do
          local image = level < index and "star1.png" or "star2.png"
          display.newSprite("ui/hero/detail/" .. image):pos(150 + (index - 1) * 15, -15 + dalteY):addTo(pointNode)
        end
        if addType == 9 then
          local bg1 = display.newSprite("ui/hero/detail/func_bg_2.png"):pos(90, 11):addTo(pointNode)
          display.newTTFLabel({
            text = (skillData.coolDown or 0.3) .. "s",
            size = 20,
            color = UIHelper.hex2rgb("#703803")
          }):pos(54, 17):addTo(bg1)
          local bg2 = display.newSprite("ui/hero/detail/func_bg_1.png"):pos(185, 11):addTo(pointNode)
          display.newTTFLabel({
            text = "x" .. (skillData.manaCost or 3),
            size = 20,
            color = UIHelper.hex2rgb("#703803")
          }):pos(50, 17):addTo(bg2)
        end
      elseif addType == 12 then
        height = 130
        local formatData = FormatCsv[tonumber(addValue[2])][1]
        display.newTTFLabel({
          text = "装盘名称",
          size = 18,
          color = UIHelper.hex2rgb("#703803")
        }):anch(0, 1):pos(-10, 20):addTo(pointNode)
        MRichText.new({
          text = formatData.name,
          size = 18,
          color = UIHelper.hex2rgb("#ba6719"),
          maxWidth = 110
        }):anch(0, 1):pos(-5, 0):addTo(pointNode)
        display.newTTFLabel({
          text = "装盘效果",
          size = 18,
          color = UIHelper.hex2rgb("#703803")
        }):anch(0, 1):pos(-10, -20):addTo(pointNode)
        local desc = MRichText.new({
          text = formatData.desc,
          color = UIHelper.hex2rgb("#ba6719"),
          size = 18,
          maxWidth = 336
        }):anch(0, 1):pos(-5, -40):addTo(pointNode)
        display.newTTFLabel({
          text = "激活条件",
          size = 18,
          color = UIHelper.hex2rgb("#703803")
        }):anch(0, 1):pos(-10, -40 - desc:getContentSize().height):addTo(pointNode)
        MRichText.new({
          text = formatData.conDesc,
          size = 18,
          color = UIHelper.hex2rgb("#ba6719"),
          maxWidth = 336
        }):anch(0, 1):pos(-5, -60 - desc:getContentSize().height):addTo(pointNode)
      else
        height = 40
        MRichText.new({
          text = pointData.desc,
          color = UIHelper.hex2rgb("#703902"),
          size = 20,
          maxWidth = 320
        }):anch(0, 1):pos(0, 20):addTo(pointNode)
      end
      viewNode:setContentSize(cc.size(354, height))
      pointNode:pos(20, height - 28)
      viewNode:addTo(attrList)
    end
  end
end

function TreeLightLayer:showCostItems(cost)
  local xPos = (1 - #cost) / 2 * 120
  for index, set in ipairs(cost) do
    local itemId, count = tonumber(set[1]), tonumber(set[2])
    local icon = ItemIcon.new({type = itemId, count = count}):scale(0.9):pos(xPos, 0):addTo(self.node2)
    local color = "#298605"
    local cur = self:getMaterialNum(itemId)
    if count > cur then
      color = "#e54f4b"
      self.canUp = false
    end
    display.newTTFLabel({
      text = string.format("%d/%d", cur, count),
      size = 20,
      color = UIHelper.hex2rgb(color)
    }):pos(xPos, -52):addTo(self.node2)
    if index == 1 then
      self.img = display.newSprite(LightRes .. "item_select.png"):center(icon):addTo(icon)
      self:showList(GetCsv[itemId].path, icon)
    end
    icon:setCallback(function()
      MTip:show({
        type = MTipType.item,
        node = icon,
        itemType = itemId,
        itemData = ItemCsv[itemId]
      })
      self:showList(GetCsv[itemId].path, icon)
    end)
    xPos = xPos + 120
  end
end

function TreeLightLayer:showCostHeros(cost, idx)
  idx = idx or 1
  self.node2:removeAllChildren()
  self.canUp = true
  local itemId, count = tonumber(cost[1][1]), tonumber(cost[1][2])
  local xPos = (1 - count) / 2 * 120
  for index = 1, count do
    local heroId = self.costHeroes[index]
    local icon
    if heroId then
      icon = HeroHead.new({heroId = heroId})
    else
      self.canUp = false
      icon = UIHelper.newImageView("ui/kitchen/quality/bg_1.png")
      display.newSprite("ui/global/equip_add_2.png"):center(icon):addTo(icon)
      UIHelper.newImageView("ui/global/item_frame.png"):center(icon):addTo(icon)
    end
    icon:scale(0.9):pos(xPos, 0):addTo(self.node2)
    if index == idx then
      self.img = display.newSprite(LightRes .. "item_select.png"):center(icon):addTo(icon)
      self.img:setLocalZOrder(-1)
      self:showList(GetCsv[itemId].path, icon)
    end
    icon:setCallback(function()
      self:showList(GetCsv[itemId].path, icon)
      
      local function rule(_hero)
        if _hero.id == heroId or _hero.id == self.hero.id or _hero.type ~= itemId - ItemStartId.hero or _hero.lock ~= 0 then
          return true
        end
        for _, id in pairs(self.costHeroes) do
          if _hero.id == id then
            return true
          end
        end
        return false
      end
      
      self.parent:hide()
      self:hide()
      local layer = game:createView("hero.ChooseHeroLayer", {
        rule = rule,
        type = 0,
        callback = function(choose)
          self.costHeroes[index] = choose
          self:showCostHeros(cost, index)
        end
      })
      BackManager:push(function()
        self.parent:show()
        self:show()
        layer:close()
        TopBar:show(TopBarType.full, "食灵")
      end)
    end)
    xPos = xPos + 120
  end
  display.newTTFLabel({
    text = "选择" .. ItemCsv[itemId].name,
    size = 18,
    color = UIHelper.hex2rgb("#ba471a")
  }):pos(0, -52):addTo(self.node2)
end

function TreeLightLayer:showList(path, parent)
  self.list:removeAllChildren()
  if not tolua.isnull(self.img) then
    self.img:removeFromParent()
    self.img = display.newSprite(LightRes .. "item_select.png"):center(parent):addTo(parent)
    self.img:setLocalZOrder(-1)
  end
  local paths = path:toTableArray()
  for _, set in ipairs(paths) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(356, 96)):addTo(self.list)
    local cell = UIHelper.newImageView(LightRes .. "cell_0.png"):center(viewNode):addTo(viewNode)
    local jumpType, chapterId, chapterType = tonumber(set[1]), tonumber(set[2]), tonumber(set[3] or 0)
    local name, desc = "", ""
    if jumpType == 4 then
      name = BattleCsv[chapterId].name
      desc = 20000 < chapterId and (30000 < chapterId and "(污染源)" or "(重污染)") or "(轻污染)"
    elseif jumpType == 33 then
      name = "乐园任务"
    elseif jumpType == 34 then
      cell:setImage(LightRes .. string.format("cell_%d.png", chapterId))
      name = chapterId == 5 and "深渊秘境" or "秘境副本"
      desc = self:getOpenStr(chapterId)
    elseif jumpType == 42 then
      name = "庄园冒险"
    elseif jumpType == 28 then
      name = "商城-礼包"
    else
      name = "烹饪"
    end
    display.newTTFLabel({
      text = name,
      size = 24,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(13, 67):addTo(cell)
    display.newTTFLabel({
      text = desc,
      size = 20,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(5, 15):addTo(cell)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LightRes, {"btn_go.png", "btn_go.png"})
    btn:setString({
      text = "前往",
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#500303"), 1)
    btn:pos(295, 42):addTo(cell)
    btn:setCallback(function()
      CommonHelper.jumpLayer(jumpType, function()
        self.parent:hide()
        self:hide()
      end, function()
        self.parent:show()
        self:close()
        TopBar:show(TopBarType.full, "食灵")
        CommonHelper.playHomeBGM()
      end, chapterId, chapterType)
    end)
  end
  self.list:requestDoLayout()
  self.list:jumpToTop()
end

function TreeLightLayer:getOpenStr(indexType)
  if indexType == 4 or indexType == 0 or indexType == 5 then
    return ""
  end
  local weeks = {
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
    "日"
  }
  local limit = globalCsv["bosscarbonOpentime" .. indexType]
  local list = limit:toTableArray()
  local str = "每周"
  for index, set in ipairs(list) do
    str = str .. weeks[tonumber(set[1])]
    if index < #list then
      str = str .. "、"
    end
  end
  str = str .. "开放"
  return str
end

function TreeLightLayer:getMaterialNum(costType)
  if costType <= 4 then
    return game.role["material" .. costType]
  elseif costType == 5 then
    return game.role.diamond
  else
    return game.role.items[costType] or 0
  end
end

return TreeLightLayer
