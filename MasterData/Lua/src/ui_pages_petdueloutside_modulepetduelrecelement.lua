local this = class("modulePetDuelRecElement", G_UIModuleBase)
local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local petElementColor = {
  [1] = "#E14F47",
  [2] = "#FF9537",
  [3] = "#CE8556",
  [4] = "#9BCE50",
  [5] = "#59D7D4",
  [6] = "#60BBFF",
  [7] = "#708BFF",
  [8] = "#FFF157",
  [9] = "#8C7195"
}

function this.bind()
  return {
    img_recElementIcon1 = "",
    color_recElementIcon1 = C_Color(1, 1, 1, 1),
    img_recElementIcon2 = "",
    color_recElementIcon2 = C_Color(1, 1, 1, 1),
    txt_recLevel = ""
  }
end

function this:initModule(levelId)
  self._levelId = levelId
  self:calcRecElements(self._levelId)
end

function this:initBoss(boosId)
  local elementScores = {}
  local petCfg = _enemyTpl:getTplById(boosId)
  local elementIds = _enemyTpl:getElement(petCfg)
  for index = 1, #elementIds do
    local tpl = _elementTypeTpl:getTplById(elementIds[index])
    local restraintTable = _elementTypeTpl:getElementRestraint(tpl)
    for attr = 1, #restraintTable do
      local ele = restraintTable[attr][1]
      if not elementScores[ele] then
        elementScores[ele] = 0
      end
      if elementIds[index] == 8 or elementIds[index] == 9 then
        elementScores[ele] = elementScores[ele] - restraintTable[attr][2]
      else
        elementScores[ele] = elementScores[ele] + restraintTable[attr][2]
      end
    end
  end
  local first_attr, first_score = nil, math.huge
  local second_attr, second_score = nil, math.huge
  print("属性得分输出，得分越低的越克制: ")
  for attr, score in pairs(elementScores) do
    print("Element: " .. attr .. " Score: " .. score)
  end
  for attr, score in pairs(elementScores) do
    if score < first_score then
      second_attr, second_score = first_attr, first_score
      first_attr, first_score = attr, score
    elseif score < second_score then
      second_attr, second_score = attr, score
    end
  end
  local etpl = _elementTypeTpl:getTplById(first_attr)
  self.bind.img_recElementIcon1 = _elementTypeTpl:getPetPuzzleIcon(etpl, 2)
  local _, elementIconColor = C_ColorUtility.TryParseHtmlString(petElementColor[first_attr])
  self.bind.color_recElementIcon1 = elementIconColor
  local etpl = _elementTypeTpl:getTplById(second_attr)
  self.bind.img_recElementIcon2 = _elementTypeTpl:getPetPuzzleIcon(etpl, 2)
  local _, elementIconColor = C_ColorUtility.TryParseHtmlString(petElementColor[second_attr])
  self.bind.color_recElementIcon2 = elementIconColor
end

function this:setRecLevel(_levelId)
  local _kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
  local tpl = _kiBoDuelTpl:getTplById(_levelId)
  if not tpl then
    return
  end
  local recommendLevel = _kiBoDuelTpl:getRecommendLevel(tpl)
  self.bind.txt_recLevel = tostring(recommendLevel)
end

function this:calcRecElements(_levelId)
  local elementScores = {}
  local kiBoDuelCfg = _kiBoDuelTpl:getTplById(_levelId)
  for id, lv in pairs(_kiBoDuelTpl:getEnemy(kiBoDuelCfg)) do
    local petCfg = _petTpl:getTplById(id)
    if petCfg == nil then
      return
    end
    local elementIds = _petTpl:getElement(petCfg)
    for index = 1, #elementIds do
      local tpl = _elementTypeTpl:getTplById(elementIds[index])
      local restraintTable = _elementTypeTpl:getElementRestraint(tpl)
      for attr = 1, #restraintTable do
        local ele = restraintTable[attr][1]
        if not elementScores[ele] then
          elementScores[ele] = 0
        end
        if elementIds[index] == 8 or elementIds[index] == 9 then
          elementScores[ele] = elementScores[ele] - restraintTable[attr][2]
        else
          elementScores[ele] = elementScores[ele] + restraintTable[attr][2]
        end
      end
    end
  end
  local first_attr, first_score = nil, math.huge
  local second_attr, second_score = nil, math.huge
  print("属性得分输出，得分越低的越克制: ")
  for attr, score in pairs(elementScores) do
    print("Element: " .. attr .. " Score: " .. score)
  end
  for attr, score in pairs(elementScores) do
    if score < first_score then
      second_attr, second_score = first_attr, first_score
      first_attr, first_score = attr, score
    elseif score < second_score then
      second_attr, second_score = attr, score
    end
  end
  local etpl = _elementTypeTpl:getTplById(first_attr)
  self.bind.img_recElementIcon1 = _elementTypeTpl:getPetPuzzleIcon(etpl, 2)
  local _, elementIconColor = C_ColorUtility.TryParseHtmlString(petElementColor[first_attr])
  self.bind.color_recElementIcon1 = elementIconColor
  local etpl = _elementTypeTpl:getTplById(second_attr)
  self.bind.img_recElementIcon2 = _elementTypeTpl:getPetPuzzleIcon(etpl, 2)
  local _, elementIconColor = C_ColorUtility.TryParseHtmlString(petElementColor[second_attr])
  self.bind.color_recElementIcon2 = elementIconColor
end

return this
