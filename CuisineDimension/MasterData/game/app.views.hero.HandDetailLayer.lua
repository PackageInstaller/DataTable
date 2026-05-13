local unitCsv = require("csvdata.unit")
local expCsv = require("csvdata.hero_exp")
local formCsv = require("csvdata.formation")
local specialCsv = require("csvdata.skill_special")
local blockCsv = require("csvdata.skill_block")
local evolutionCsv = require("csvdata.evolution")
local BookCsv = require("csvdata.handbook")
local FoodCsv = require("csvdata.food_pic")
local TalkCsv = require("csvdata.talk")
local TalkFCsv = require("csvdata.talk_f")
local AwakenCsv = require("csvdata.awaken")
local awakeSkillCsv = require("csvdata.skill_awake")
local detailRes = "ui/hero/detail/"
local handRes = "ui/hero/handbook/"
local TAG_NORMAL = 1
local TAG_SELECT = 2
local uiData = {
  csbFile = "ui/hero/HandBookLayer.csb",
  mask = true,
  widgets = {
    center = "center",
    downBar = "downBar",
    Panel_1 = "Panel_1",
    heroNode = "heroNode",
    angle2 = "angle2",
    angle3 = "angle3",
    detail_bg = "detail_bg",
    zoomBtn = "zoomBtn",
    name = "detail_bg/name",
    maskNode = "maskNode",
    zeroNode = "zeroNode",
    starNode = "detail_bg/starBg/starNode",
    attrNode = "detail_bg/attrNode",
    equipBtn = "detail_bg/equipBtn",
    skillBtn = "detail_bg/skillBtn",
    comboBtn = "detail_bg/comboBtn",
    changeBtn = "changeBtn",
    equipPanel = "detail_bg/describe/equipPanel",
    skillPanel = "detail_bg/describe/skillPanel",
    comboPanel = "describe/comboPanel",
    skillList = "detail_bg/describe/skillPanel/scrollView",
    skillNode = "detail_bg/describe/skillPanel/scrollView/node",
    comboNode = "detail_bg/describe/comboPanel/node",
    descNode = "detail_bg/describe/equipPanel/list",
    heroSpine = "detail_bg/heroSpine",
    storyBtn = "storyBtn",
    painter = "detail_bg/painter",
    cver = "detail_bg/cvers",
    circle = "detail_bg/circle",
    upBar = "up_bar",
    number = "detail_bg/number",
    btnRight = "btnRight",
    btnLeft = "btnLeft",
    cvBtn = "cvBtn",
    list_bg = "list_bg",
    list = "list_bg/list"
  }
}
local btnNames = {
  "equipBtn",
  "skillBtn",
  "comboBtn"
}
local HandDesc = {
  [1] = "技能",
  [2] = "装盘",
  [3] = "生命",
  [4] = "攻击",
  [5] = "攻速",
  [6] = "命中",
  [7] = "防御",
  [8] = "闪避"
}
local AttsEnumExtra = {
  [1] = "skill",
  [2] = "formation",
  [3] = "hp",
  [4] = "atk",
  [5] = "atkSpeed",
  [6] = "hit",
  [7] = "phyDef",
  [8] = "miss"
}
local cvkeys = {
  [1] = "gain",
  [2] = "normalStandby1",
  [3] = "normalStandby2",
  [4] = "normalStandby3",
  [5] = "marryStandby1",
  [6] = "marryStandby2",
  [7] = "marryStandby3",
  [8] = "consignationStart",
  [9] = "consignationFinish",
  [10] = "set",
  [11] = "victory",
  [12] = "repair",
  [13] = "broken",
  [14] = "quality",
  [15] = "specialSkill"
}
local HandDetailLayer = class("HandDetailLayer", UIBase)

function HandDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HandDetailLayer:init(params)
  self.heroId = params.heroId
  self.curIndex = params.handbook
  self.bookCsv = BookCsv[params.handbook]
  self.unit = unitCsv[self.heroId]
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
  self:GetNextId(0)
  self.btnLeft:setCallback(function()
    group:chooseByName("skillBtn")
    self:resetFoodBtn()
    self:GetNextId(-1)
    self:GetNextId(0)
  end)
  self.btnRight:setCallback(function()
    group:chooseByName("skillBtn")
    self:resetFoodBtn()
    self:GetNextId(1)
    self:GetNextId(0)
  end)
  self.storyBtn:setCallback(function()
    local layer = game:createView("talk.TalkLayer", {
      selected = 2,
      type = self.unit.type
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "食灵资料")
    end)
  end)
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
      end
    end)
  end
  group:chooseByName("skillBtn")
  self.bFood = false
  self.changeBtn:setCallback(function()
    if self.bFood then
      self.heroNode:removeAllChildren()
      self.heroImage = HeroBigCard.new({
        type = self.unit.type
      }):addTo(self.heroNode)
      self.changeBtn:setImage(detailRes .. "state_a.png")
      self.zoomBtn:show()
      self.bFood = false
    else
      local curBreak = UIHelper.getMaxLoveBreak(self.heroId)
      local FoodData = FoodCsv[self.heroId]
      if not FoodData or FoodData.res == "" then
        SysError(SYS_ERR_FOOD_PIC_DOES_NOT_HAVE)
        return
      end
      if curBreak < FoodCsv[self.unit.type].unlock then
        SysError(SYS_ERR_FOOD_PIC_LOCK)
        return
      end
      self.heroNode:removeAllChildren()
      display.newSprite(FoodData.res):pos(5, 120):addTo(self.heroNode)
      self.changeBtn:setImage(detailRes .. "state_b.png")
      self.zoomBtn:hide()
      self.bFood = true
    end
  end)
  self.showCV = false
  self.cvBtn:show()
  self.cvBtn:setCallback(function()
    self:changeCVUI()
  end)
end

function HandDetailLayer:changeCVUI()
  self.showCV = not self.showCV
  self.list_bg:setVisible(self.showCV)
end

function HandDetailLayer:initCV()
  self.list:removeAllChildren()
  for idx, key in ipairs(cvkeys) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(460, 51)):addTo(self.list)
    local cell = UIHelper.newImageView(handRes .. "cv_cell.png"):pos(235, 27):addTo(viewNode)
    cell:setCallback(function()
      if self.content then
        return
      end
      CommonHelper.stopCV()
      if (idx == 5 or idx == 6 or idx == 7) and 5 > UIHelper.getMaxLoveBreak(self.unit.type) then
        MFlashMsg:show({
          text = textByKey("hand_detail_cv_0")
        })
        return
      end
      local talk = TalkCsv[self.unit.type][key]
      local talkF = TalkCsv[self.unit.type][string.format("f%s", key)]
      talk = talk or textByKey("hand_detail_cv_0")
      self.content = display.newSprite("ui/home/talk_bg2.png"):pos(-5, 0):addTo(self.heroNode)
      local seq = {}
      if not talkF or talkF == "" then
        local label = MRichText.new({
          text = talk,
          color = UIHelper.hex2rgb("#000000"),
          size = 18,
          maxWidth = 350,
          lineSpace = 1
        })
        label:anch(0, 1):pos(20, 128):addTo(self.content)
        label:playAnimation(20, nil, nil)
        table.insert(seq, cc.DelayTime:create(5))
      else
        for _, data in ipairs(talkF:toTableArray()) do
          local fId, delay = tonumber(data[1]), tonumber(data[2])
          table.insert(seq, cc.CallFunc:create(function()
            self.content:removeAllChildren()
            local label = MRichText.new({
              text = TalkFCsv[fId].content,
              color = UIHelper.hex2rgb("#000000"),
              size = 18,
              maxWidth = 350,
              lineSpace = 1
            })
            label:anch(0, 1):pos(20, 128):addTo(self.content)
            label:playAnimation(20, nil, nil)
          end))
          table.insert(seq, cc.DelayTime:create(delay))
        end
      end
      table.insert(seq, cc.CallFunc:create(function()
        self.content:removeSelf()
        self.content = nil
      end))
      UIHelper.MoveToUp({
        node = self.content,
        time = 0.25,
        pos = {0, 30}
      })
      CommonHelper.playCV(self.unit.type, key)
      self.heroNode:runAction(cc.Sequence:create(seq))
    end)
    display.newTTFLabel({
      text = textByKey(string.format("hand_detail_cv_%d", idx)),
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):anch(0, 0.5):pos(167, 25):addTo(viewNode)
  end
  self.list:requestDoLayout()
end

function HandDetailLayer:showData()
  self.zoomBtn:setTouchScale()
  self.zoomBtn:setCallback(function()
    self:showBigCard()
  end)
  self.heroSpine:removeAllChildren()
  self.heroNode:removeAllChildren()
  self.starNode:removeAllChildren()
  self.attrNode:removeAllChildren()
  self.painter:setString(self.bookCsv.painter)
  self.cver:setString(self.bookCsv.cv1)
  UIHelper.makeFontClear(self.painter)
  UIHelper.makeFontClear(self.cver)
  local spineNode = UIHelper.createSpineNode(self.unit.type):addTo(self.heroSpine)
  spineNode:setAnimation(0, "idle", true)
  spineNode:registerSpineEventHandler(function(event)
    if event.type == "end" and event.animation ~= "idle" then
      spineNode:setToSetupPose()
      spineNode:setAnimation(0, "idle", true)
    end
  end, sp.EventType.ANIMATION_END)
  local animationDatas = {
    move = {track = 2, loop = true},
    dead = {track = 3, loop = false},
    cheer = {track = 4, loop = true}
  }
  local animationNames = table.keys(animationDatas)
  local nameIndex = 1
  self.circle:setTouchEnabled(true)
  self.circle:setCallback(function()
    local name = animationNames[nameIndex]
    nameIndex = nameIndex % #animationNames + 1
    spineNode:clearTracks()
    spineNode:setToSetupPose()
    spineNode:setAnimation(animationDatas[name].track, name, animationDatas[name].loop)
  end)
  local unitData = self.unit
  self.name:setString(unitData.name)
  self.number:setString("No." .. string.format("%03d", self.bookCsv.order))
  self.heroImage = HeroBigCard.new({
    type = unitData.type
  }):addTo(self.heroNode)
  local isBlack = globalCsv.blackHeroUnitIds[unitData.type] == 1
  local isMengJing = globalCsv.mengJingHeroUnitIds[unitData.type] == 1
  local star, xInterval = unitData.star, 30
  local temStar = math.min(star, 5)
  for index = 1, temStar do
    local offset = index == 1 and 0 or -xInterval / 2
    display.newSprite(detailRes .. (isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos((index - (temStar + 1) / 2) * xInterval, 0):addTo(self.starNode)
  end
  for index = 1, 8 do
    local name = AttsEnumExtra[index]
    local xPos = math.floor((index - 1) % 2) * 100
    local yPos = math.floor((index - 1) / 2) * -22
    local color = 2 < index and "#b78262" or "#3a220a"
    yPos = 2 < index and yPos - 8 or yPos
    display.newSprite(detailRes .. name .. ".png"):pos(xPos, yPos):addTo(self.attrNode)
    display.newTTFLabel({
      text = HandDesc[index] .. ":",
      size = 16,
      color = UIHelper.hex2rgb(color)
    }):pos(35 + xPos, yPos + 2):addTo(self.attrNode)
    display.newSprite(handRes .. "score_" .. self.bookCsv[name] .. ".png"):pos(75 + xPos, yPos):addTo(self.attrNode)
  end
  self:showSkill()
  self:initCV()
  CommonHelper.stopCV()
  local proBg = UIHelper.newImageView(string.format("ui/global/profession_bg_%d.png", 0)):pos(25, 497):addTo(self.detail_bg)
  UIHelper.newImageView(string.format("ui/global/profession_%d.png", unitData.profession)):center(proBg):addTo(proBg)
end

function HandDetailLayer:GetNextId(direct)
  local leftInfo, rightInfo = {}, {}
  local nextId = self.curIndex - 1
  for index = nextId, 1, -1 do
    local bookData = BookCsv[index]
    if game.role.heroBook[tostring(bookData.id)] or bookData.open ~= 0 then
      leftInfo.heroId = bookData.id
      leftInfo.curIndex = index
      leftInfo.bookCsv = BookCsv[index]
      leftInfo.count = 1
      leftInfo.unit = unitCsv[bookData.id]
      leftInfo.state = true
      break
    end
  end
  nextId = self.curIndex + 1
  for index = nextId, #BookCsv do
    local bookData = BookCsv[index]
    if game.role.heroBook[tostring(bookData.id)] or bookData.open ~= 0 then
      rightInfo.heroId = bookData.id
      rightInfo.curIndex = index
      rightInfo.bookCsv = BookCsv[index]
      rightInfo.count = 1
      rightInfo.unit = unitCsv[bookData.id]
      rightInfo.state = true
      break
    end
  end
  if leftInfo.state then
    self.btnLeft:show()
  else
    self.btnLeft:hide()
  end
  if rightInfo.state then
    self.btnRight:show()
  else
    self.btnRight:hide()
  end
  if direct == 0 then
  elseif direct == -1 then
    if leftInfo.state then
      self.heroId = leftInfo.heroId
      self.curIndex = leftInfo.curIndex
      self.bookCsv = leftInfo.bookCsv
      self.count = leftInfo.count
      self.unit = leftInfo.unit
      self:showData()
    end
  elseif direct == 1 and rightInfo.state then
    self.heroId = rightInfo.heroId
    self.curIndex = rightInfo.curIndex
    self.bookCsv = rightInfo.bookCsv
    self.count = rightInfo.count
    self.unit = rightInfo.unit
    self:showData()
  end
end

function HandDetailLayer:resetFoodBtn()
  if not self.bFood then
    return
  end
  self.changeBtn:setImage(detailRes .. "state_a.png")
  self.heroNode:removeAllChildren()
  self.zoomBtn:show()
  self.bFood = false
end

function HandDetailLayer:showEquip()
  self.equipPanel:show()
  self.skillPanel:hide()
  self.comboPanel:hide()
  self.descNode:removeAllChildren()
  local ttf = display.newTTFLabel({
    text = self.bookCsv.desc,
    size = 18,
    color = UIHelper.hex2rgb("#703803"),
    dimensions = cc.size(420, 0)
  })
  local viewNode = ccui.Widget:create()
  local nodeSize = ttf:getContentSize()
  nodeSize.height = nodeSize.height + 30
  viewNode:size(nodeSize):addTo(self.descNode)
  ttf:pos(225, (nodeSize.height + 10) / 2):addTo(viewNode)
  self.descNode:setInnerContainerSize(nodeSize)
end

function HandDetailLayer:showSkill()
  self.equipPanel:hide()
  self.skillPanel:show()
  self.comboPanel:hide()
  self.skillNode:removeAllChildren()
  self.skillList:setScrollBarEnabled(false)
  self.skillList:setInnerContainerSize(cc.size(450, 450))
  if self.unit.specialId ~= 0 then
    local specialDatas = specialCsv[self.unit.specialId]
    local maxLevel = #specialDatas
    local specialData = specialDatas[maxLevel]
    local textBg = display.newSprite(detailRes .. "text_bg1.png"):anch(0, 1):pos(-45, 220):addTo(self.skillNode)
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
    for index = 1, maxLevel do
      local image = maxLevel < index and "star1.png" or "star2.png"
      display.newSprite(detailRes .. image):pos(194 + (index - 1) * 15, 100):addTo(textBg)
    end
    local bg1 = display.newSprite(detailRes .. "func_bg_2.png"):pos(308, 105):addTo(textBg)
    display.newTTFLabel({
      text = specialData.coolDown .. "s",
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(54, 17):addTo(bg1)
    local bg2 = display.newSprite(detailRes .. "func_bg_1.png"):pos(403, 105):addTo(textBg)
    display.newTTFLabel({
      text = "x" .. specialData.manaCost,
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(50, 17):addTo(bg2)
  end
  local textBg2 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, 105):addTo(self.skillNode)
  if self.unit.blockId ~= 0 then
    local blockDatas = blockCsv[self.unit.blockId]
    local maxLevel = #blockDatas
    local blockData = blockDatas[maxLevel]
    local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 120):addTo(textBg2)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = blockData.icon
    }):scale(0.47):center(content):addTo(content)
    display.newTTFLabel({
      text = blockData.name,
      size = 16,
      color = UIHelper.hex2rgb("#0d92ae")
    }):anch(0, 0.5):pos(75, 145):addTo(textBg2)
    display.newSprite(detailRes .. "mask.png"):center(content):addTo(content)
    local desc = MRichText.new({
      text = blockData.desc,
      size = 16,
      color = UIHelper.hex2rgb("#703803"),
      font = display.DEFAULT_TTF_FONT_NORMAL,
      lineSpace = 4,
      maxWidth = 360
    })
    desc:anch(0, 1):pos(75, 133):addTo(textBg2)
    for index = 1, maxLevel do
      local image = maxLevel < index and "star1.png" or "star2.png"
      display.newSprite(detailRes .. image):pos(194 + (index - 1) * 15, 145):addTo(textBg2)
    end
  else
    display.newSprite(detailRes .. "text.png"):pos(220, 55):addTo(textBg2)
  end
  local awakes = AwakenCsv[self.heroId]
  local textBg3 = display.newSprite(detailRes .. "text_bg.png"):anch(0, 1):pos(-45, -60):addTo(self.skillNode)
  if awakes and #awakes == 3 then
    local awakeId = awakes[#awakes].id
    local level = 1
    local awakeData = awakeSkillCsv[awakeId][level]
    local content = display.newSprite(detailRes .. "skill_bg.png"):pos(45, 110):addTo(textBg3)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = awakeData.icon
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

function HandDetailLayer:showCombo()
  self.equipPanel:hide()
  self.skillPanel:hide()
  self.comboPanel:show()
  self.comboNode:removeAllChildren()
  local totalDesc = formCsv[self.unit.formation][1].totalDesc
  display.newSprite(detailRes .. "yandou.png"):pos(-18, 4):addTo(self.comboNode)
  local desc = display.newTTFLabel({
    text = totalDesc,
    size = 18,
    color = UIHelper.hex2rgb("#6E3804"),
    dimensions = cc.size(380, 150)
  }):anch(0.5, 1):pos(200, 15):addTo(self.comboNode)
end

function HandDetailLayer:showBigCard()
  self.heroImage:hide()
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
    type = self.heroId
  }):pos(300 * maxScale, 270 * maxScale):addTo(scrollView)
  local broken = false
  local changeBtn = UIHelper.extend(ccui.Button:create())
  changeBtn:setImages(detailRes, {
    "break_a.png",
    "break_a.png"
  })
  changeBtn:pos(display.width - 30, display.height / 2 - 50):addTo(maskLayer):hide()
  changeBtn:setTouchScale()
  changeBtn:setCallback(function()
    broken = not broken
    local res = UIHelper.getCardRes("normal", self.heroId, broken)
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
    self.heroImage:show()
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

function HandDetailLayer:onExit()
  CommonHelper.stopCV()
end

return HandDetailLayer
