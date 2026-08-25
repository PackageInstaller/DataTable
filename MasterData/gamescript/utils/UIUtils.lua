local System = require("System.System")
local table = _ENV.table
local string = _ENV.string
local RectTransform = CS.UnityEngine.RectTransform
local Vector2 = CS.UnityEngine.Vector2
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local TYPEOF_UITableview = typeof(CS.UITableview)
local TYPEOF_UITableGrid = typeof(CS.UITableGrid)
local TYPEOF_CircularScrollView = typeof(CS.UICircularScrollView.CircularScrollView)
local TYPEOF_GridLayoutGroup = typeof(CS.UnityEngine.UI.GridLayoutGroup)
local TYPEOF_VerticalLayoutGroup = typeof(CS.UnityEngine.UI.VerticalLayoutGroup)
local TYPEOF_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local GridConstraint = CS.UnityEngine.UI.GridLayoutGroup.Constraint
local CircularFadeInAnimType = CS.UICircularScrollView.FadeInAnimType
local TableFadeInAnimType = CS.UITableview.FadeInAnimType
local TopLeftAnchor = Vector2(0, 1)
local BottomLeftAnchor = Vector2(0, 0)
local UIUtils = System.NewClass("UIUtils")

local function SubStringGetByteCount(str, index)
  local curByte = string.byte(str, index)
  local byteCount = 1
  local count = 1
  if nil == curByte then
    byteCount = 0
  elseif curByte > 0 and curByte <= 127 then
    byteCount = 1
  elseif curByte >= 192 and curByte <= 223 then
    byteCount = 2
  elseif curByte >= 224 and curByte <= 239 then
    byteCount = 3
  elseif curByte >= 240 and curByte <= 247 then
    byteCount = 4
  end
  if nil == curByte then
    count = 0
  elseif curByte > 0 and curByte <= 127 then
    count = 1
  elseif curByte > 127 then
    count = 2
  end
  return byteCount, count
end

local function SubStringGetTrueIndex(str, index)
  local curIndex = 0
  local i = 1
  local lastCount
  repeat
    lastCount = SubStringGetByteCount(str, i)
    i = i + lastCount
    curIndex = curIndex + 1
  until index <= curIndex
  return i - lastCount
end

local function SubStringGetTotalIndex(str)
  local curIndex = 0
  local i = 1
  local lastCount
  repeat
    lastCount = SubStringGetByteCount(str, i)
    i = i + lastCount
    curIndex = curIndex + 1
  until 0 == lastCount
  return curIndex - 1
end

local function SubStringGetTotalGame(str)
  local count = 0
  local i = 1
  local lastCount, gameCount
  repeat
    lastCount, gameCount = SubStringGetByteCount(str, i)
    i = i + lastCount
    count = count + gameCount
  until 0 == lastCount
  return count
end

local function GetAllCharFormString(str)
  local strList = {}
  local wordCount = SubStringGetTotalIndex(str)
  local tempList = {}
  local temp = false
  for i = 1, wordCount do
    local curWord = UIUtils.SubStringUTF8(str, i, i)
    if "{" == curWord and not temp then
      temp = true
      tempList = {}
    end
    if temp then
      if "{" ~= curWord and "}" ~= curWord then
        table.insert(tempList, curWord)
      end
      if "}" == curWord then
        temp = false
        table.insert(strList, table.concat(tempList))
      end
    else
      table.insert(strList, curWord)
    end
  end
  return strList
end

local function GetUIByUINode(owner)
  if not owner then
    return
  end
  local uiExport = owner:GetComponent(typeof(CS.FrameWork.UIExport)) or {}
  local retUI = {}
  for i = 0, uiExport.uiNodeList.Count - 1 do
    retUI[uiExport.uiNodeList[i].name] = uiExport.uiNodeList[i].obj
  end
  return retUI
end

local function SubStringUTF8(str, startIndex, endIndex)
  if startIndex < 0 then
    startIndex = SubStringGetTotalIndex(str) + startIndex + 1
  end
  if nil ~= endIndex and endIndex < 0 then
    endIndex = SubStringGetTotalIndex(str) + endIndex + 1
  end
  if nil == endIndex then
    do return string.sub, str, SubStringGetTrueIndex(str, startIndex) end
    return string.sub, str, SubStringGetTrueIndex(str, startIndex)
  else
    do return string.sub, str, (SubStringGetTrueIndex(str, startIndex)) end
    return string.sub, str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1, str, endIndex + 1
  end
end

UIUtils.SubStringGetTotalIndex = SubStringGetTotalIndex
UIUtils.SubStringUTF8 = SubStringUTF8
UIUtils.SubStringGetTotalGame = SubStringGetTotalGame
UIUtils.GetAllCharFormString = GetAllCharFormString
UIUtils.GetUIByUINode = GetUIByUINode

function UIUtils.AdjustTipsPosition(selfNode, parentNode, YPos, XPos)
  local rootPosition = UIUtils.GetRootPosition(parentNode)
  local margin = 10
  local sizeDelta = selfNode:GetComponent(typeof(RectTransform)).sizeDelta
  local width = sizeDelta.x
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local UIwidth = bgWidth < UISize.x and bgWidth or UISize.x
  rootPosition.x = (XPos or rootPosition.x) - width / 2
  rootPosition.y = YPos or -140
  if rootPosition.x + width / 2 > UIwidth / 2 then
    rootPosition.x = rootPosition.x - (width / 2 + rootPosition.x + margin - UIwidth / 2)
  elseif rootPosition.x - width / 2 < -UIwidth / 2 then
    rootPosition.x = rootPosition.x + width + margin
  end
  selfNode.transform.anchoredPosition = rootPosition
end

function UIUtils.GetRootPosition(parentNode)
  local parentTf = parentNode.transform
  local parentNodePos = parentTf.position
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(parentNodePos, CS.UnityEngine.GameObject.Find("UIRoot").transform, require("Managers.CameraManager"):GetUICamera())
  local rootSize = parentTf.sizeDelta
  local Pivot = parentTf.pivot
  do return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x, localPos.y + (1 - Pivot.y) * rootSize.y, (1 - Pivot.y) * rootSize.y, rootSize.y
end

function UIUtils.RemoveCloneName(go)
  local name = go.name
  if name:find("%(Clone%)") then
    go.name = name:gsub("%(Clone%)", "")
  end
end

function UIUtils.FillContainerToWidth(containerWidth, contentList, gapx, gapy, shiftX, shiftY)
  local curWidth = shiftX or 0
  local curHeight = shiftY or 0
  local contentHeight = 0
  for _, contentInfo in ipairs(contentList) do
    local sizeX, sizeY = 0, 0
    local gameObj = contentInfo
    if contentInfo.gameObj then
      gameObj = contentInfo.gameObj
      if contentInfo.GetSize then
        sizeX, sizeY = contentInfo:GetSize()
      else
        local sizeDelta = gameObj.transform.sizeDelta
        sizeX = sizeDelta.x
        sizeY = sizeDelta.y
      end
    else
      gameObj = contentInfo
      local sizeDelta = gameObj.transform.sizeDelta
      sizeX = sizeDelta.x
      sizeY = sizeDelta.y
    end
    contentHeight = sizeY
    local newWidth = curWidth + sizeX + (gapx or 0)
    if containerWidth < newWidth then
      curWidth = shiftX or 0
      curHeight = curHeight + sizeY + (gapy or 0)
      gameObj.transform.localPosition = CS.UnityEngine.Vector3(curWidth, -curHeight, 0)
      curWidth = curWidth + sizeX + (gapx or 0)
    else
      gameObj.transform.localPosition = CS.UnityEngine.Vector3(curWidth, -curHeight, 0)
      curWidth = newWidth
    end
  end
  curHeight = curHeight + contentHeight + (gapy or 0)
  return curHeight
end

function UIUtils.SetWeaponStar(binder, fourStarGameObjs, level)
  for i = 1, 3 do
    local gameObj = fourStarGameObjs[i]
    local resUI = UI_Awaker_Item_PlanetResource(gameObj)
    binder:SetActive(resUI.Image_Bright, false)
    binder:SetActive(resUI.Image_Breathe, i <= level)
  end
  local forthGameObj = fourStarGameObjs[4]
  binder:SetActive(forthGameObj, level > 3)
  local star4UI = UI_Awaker_Item_PlanetResource(forthGameObj)
  binder:SetText(star4UI.Text_Attribute, level >= 3 and level - 3 or "")
end

local MISSING_CHAR = 9633

function UIUtils.IsHaveMissingCharacter(tmpGameObj)
  local tmpComp = tmpGameObj:GetComponent(TYPEOF_TMP_Text)
  tmpComp:ForceMeshUpdate()
  local textInfo = tmpComp.textInfo
  for i = 0, textInfo.characterCount - 1 do
    local charInfo = textInfo.characterInfo[i]
    local char = charInfo.character
    if char == MISSING_CHAR then
      return true
    end
  end
end

function UIUtils.SetWeaponStar(binder, fourStarGameObjs, level)
  for i = 1, 3 do
    local gameObj = fourStarGameObjs[i]
    local resUI = UI_Awaker_Item_PlanetResource(gameObj)
    binder:SetActive(resUI.Image_Bright, false)
    binder:SetActive(resUI.Image_Breathe, i <= level)
  end
  local forthGameObj = fourStarGameObjs[4]
  binder:SetActive(forthGameObj, level > 3)
  local star4UI = UI_Awaker_Item_PlanetResource(forthGameObj)
  binder:SetText(star4UI.Text_Attribute, level >= 3 and level - 3 or "")
end

function UIUtils.ReplaceCircularListWithTable(scrollViewGo, dequeueCellGo)
  if IsNil(scrollViewGo) then
    return nil
  end
  local circularScrollView = scrollViewGo:GetComponent(TYPEOF_CircularScrollView)
  if not circularScrollView or IsNil(circularScrollView.itemGameObject) then
    return nil
  end
  local cellTemplate = circularScrollView.itemGameObject
  circularScrollView:RecycleObjs()
  circularScrollView:ResetCallback()
  circularScrollView.enabled = false
  local scrollRect = scrollViewGo:GetComponent(TYPEOF_ScrollRect)
  if scrollRect then
    scrollRect.onValueChanged:RemoveAllListeners()
    scrollRect.enabled = true
  end
  local anchor = scrollRect and scrollRect.horizontal and BottomLeftAnchor or TopLeftAnchor
  local cellRect = cellTemplate:GetComponent(typeof(RectTransform))
  if cellRect then
    cellRect.anchorMin = anchor
    cellRect.anchorMax = anchor
    cellRect.pivot = anchor
  end
  local dequeueCellRect
  if dequeueCellGo and not IsNil(dequeueCellGo) then
    dequeueCellRect = dequeueCellGo:GetComponent(typeof(RectTransform))
    if dequeueCellRect then
      dequeueCellRect.anchorMin = anchor
      dequeueCellRect.anchorMax = anchor
      dequeueCellRect.pivot = anchor
    end
  end
  local content = scrollRect and scrollRect.content
  if content then
    local contentWidth = content.rect.width
    local contentHeight = content.rect.height
    content.anchorMin = anchor
    content.anchorMax = anchor
    content.pivot = anchor
    content.sizeDelta = Vector2(contentWidth, contentHeight)
    content.anchoredPosition = Vector2.zero
  end
  local gridLayout = content and content:GetComponent(TYPEOF_GridLayoutGroup)
  if gridLayout then
    local itemWidth = gridLayout.cellSize.x
    local itemHeight = gridLayout.cellSize.y
    local spacingX = gridLayout.spacing.x
    local spacingY = gridLayout.spacing.y
    local colNum = math.floor(scrollViewGo.transform.rect.width / (itemWidth + spacingX))
    if gridLayout.constraint == GridConstraint.FixedColumnCount then
      colNum = gridLayout.constraintCount
    elseif scrollViewGo.transform.rect.width >= itemWidth * (colNum + 1) + spacingX * colNum then
      colNum = colNum + 1
    end
    if colNum < 1 then
      colNum = 1
    end
    local tableGrid = scrollViewGo:GetComponent(TYPEOF_UITableGrid) or AddComponentOnce(scrollViewGo, TYPEOF_UITableGrid)
    tableGrid.gridWidth = itemWidth
    tableGrid.gridHeight = itemHeight
    tableGrid.numRowsOrCols = colNum
    tableGrid.cellSpacing = Vector2(spacingX, spacingY)
    tableGrid.cellOffset = Vector2(gridLayout.padding.left, 0)
    tableGrid.forceAnchorPoint = false
    tableGrid.useAnchorPosition = true
    gridLayout.enabled = false
  else
    local tableView = scrollViewGo:GetComponent(TYPEOF_UITableview) or AddComponentOnce(scrollViewGo, TYPEOF_UITableview)
    tableView.forceAnchorPoint = false
    tableView.useAnchorPosition = true
    if content then
      local vlg = content:GetComponent(TYPEOF_VerticalLayoutGroup)
      if vlg then
        tableView.cellSpacing = Vector2(0, vlg.spacing or 0)
        tableView.cellOffset = Vector2(vlg.padding and vlg.padding.left or 0, vlg.padding and vlg.padding.top or 0)
        vlg.enabled = false
      end
      local hlg = content:GetComponent(TYPEOF_HorizontalLayoutGroup)
      if hlg then
        if not vlg then
          tableView.cellSpacing = Vector2(hlg.spacing or 0, 0)
          local padTop = hlg.padding and hlg.padding.top or 0
          local cellHeightRect = dequeueCellRect or cellRect
          local offsetY = 0
          if cellHeightRect then
            offsetY = content.sizeDelta.y - cellHeightRect.sizeDelta.y - padTop
            if offsetY < 0 then
              offsetY = 0
            end
          end
          tableView.cellOffset = Vector2(hlg.padding and hlg.padding.left or 0, offsetY)
        end
        hlg.enabled = false
      end
    end
    if circularScrollView.fadeInAnimName and circularScrollView.fadeInAnimName ~= "" then
      tableView.fadeInAnimName = circularScrollView.fadeInAnimName
      if circularScrollView.fadeInAnimType == CircularFadeInAnimType.NotFixed then
        tableView.fadeInAnimType = TableFadeInAnimType.NotFixed
      else
        tableView.fadeInAnimType = TableFadeInAnimType.Fixed
      end
      tableView.fadeInInterval = circularScrollView.fadeInInterval
      if circularScrollView.fadeInIntervalArr then
        tableView.fadeInIntervalArr = circularScrollView.fadeInIntervalArr
      end
    end
  end
  return cellTemplate
end

function UIUtils.DestroyRuntimeTableComponent(scrollViewGo)
  if IsNil(scrollViewGo) then
    return
  end
  local tableGrid = scrollViewGo:GetComponent(TYPEOF_UITableGrid)
  if tableGrid then
    CS.UnityEngine.Object.Destroy(tableGrid)
    return
  end
  local tableView = scrollViewGo:GetComponent(TYPEOF_UITableview)
  if tableView then
    CS.UnityEngine.Object.Destroy(tableView)
  end
end

function UIUtils.AutoSetScrollToTextHeight(scrollOrContentGo, tmpTextGo)
  local contentGo
  local scrollRect = scrollOrContentGo:GetComponent(TYPEOF_ScrollRect)
  if scrollRect then
    contentGo = scrollRect.content
  else
    contentGo = scrollOrContentGo
  end
  local tmp = tmpTextGo:GetComponent(TYPEOF_TMP_Text)
  if tmp and tmp.textInfo then
    local sizeDelta = contentGo.transform.sizeDelta
    sizeDelta.y = tmp.preferredHeight + 15
    contentGo.transform.sizeDelta = sizeDelta
  end
end

local SelectCountMaxDigitCount = 5
local SelectCountLayoutConfig = {
  [1] = {
    textPosX = 58,
    textWidth = 52,
    bgPosX = 52,
    bgWidth = 52
  },
  [2] = {
    textPosX = 58,
    textWidth = 52,
    bgPosX = 52,
    bgWidth = 52
  },
  [3] = {
    textPosX = 50,
    textWidth = 68,
    bgPosX = 40,
    bgWidth = 76
  },
  [4] = {
    textPosX = 42,
    textWidth = 84,
    bgPosX = 28,
    bgWidth = 100
  },
  [5] = {
    textPosX = 34,
    textWidth = 100,
    bgPosX = 16,
    bgWidth = 124
  }
}

function UIUtils.RefreshSelectCountLayout(textObj, bgObj, selectNum)
  if IsNil(textObj) or IsNil(bgObj) then
    return
  end
  if type(selectNum) ~= "number" or selectNum <= 0 then
    return
  end
  local digitCount = #tostring(math.floor(selectNum))
  digitCount = math.min(digitCount, SelectCountMaxDigitCount)
  local config = SelectCountLayoutConfig[digitCount]
  local textTF = textObj.transform
  local bgTF = bgObj.transform
  CS.Framework.TransformUtil.SetAnchoredPos(textTF, config.textPosX, textTF.anchoredPosition.y)
  CS.Framework.TransformUtil.SetWidth(textTF, config.textWidth)
  CS.Framework.TransformUtil.SetAnchoredPos(bgTF, config.bgPosX, bgTF.anchoredPosition.y)
  CS.Framework.TransformUtil.SetWidth(bgTF, config.bgWidth)
end

function UIUtils.BindBoundTrinketIconWithLight(binder, imageObj, getTrinketDataFn, partIndex)
  local lightComp = UICompTrinketIconMat(imageObj, {binder = binder})
  binder:BindToRaw(function(_, hasBound, _)
    binder:SetActive(imageObj, hasBound)
    lightComp:EnableLight(true == hasBound, partIndex)
  end, function()
    return nil ~= getTrinketDataFn()
  end)
  binder:BindToImage(imageObj, function()
    local trinket = getTrinketDataFn()
    if not trinket then
      return
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, trinket.tid
  end)
  return lightComp
end

return UIUtils
