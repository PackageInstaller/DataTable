local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local m_cookInfo, m_recipeRecord, m_cacheInfo, m_tab, m_preTab
local Enum_state = {
  Prepare = 1,
  Cooking = 2,
  Finish = 3
}
local m_enterSoundTime, m_delayToWork, m_delayToLeave
local m_plateMaxNum = 8
local m_isSilent

function SetupWindow()
  for i = 1, 3 do
    local tab = REF.TabGrid[i - 1]
    tab["$$SetTabText"]("", "")
    tab["$$SetNew"](false)
    tab["$$SetClickCallback"](function()
      SwitchCooktop(i)
    end)
  end
  REF.TabGrid[3]["$$SetClickCallback"](function()
    SwitchRecipeRecord()
  end)
  WU.TraverseChildren(REF.NodeMain, function(go)
    _ENV["$"](go)["$$SetClickCallback"](OnIngredientClick)
  end)
  WU.TraverseChildren(REF.NodeSupplementary, function(go)
    _ENV["$"](go)["$$SetClickCallback"](OnIngredientClick)
  end)
  WU.TraverseChildren(REF.NodeSauce, function(go)
    _ENV["$"](go)["$$SetClickCallback"](OnIngredientClick)
  end)
  WU.BindButtonEvent(REF.BtnReceive, OnBtnReceiveClick)
  WU.BindButtonEvent(REF.BtnProduction, OnBtnProduction)
  LU.Bind(REF.WrapContentRecipe, {
    updateRow = UpdateRecipeSlot
  })
end

function InitWindow()
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:Bind("NavigationContext", OnTopMostWindow)
  RU.SetRedMark("Welfare/ChineseNewYear/HotPot/Research/First", false)
  WU.RecordFirstTimeInClient("Welfare2019CNYHotPotResearch")
  m_recipeRecord = this:GetData("fci/cooking-summary/").recipeGots
  m_preTab = nil
  m_tab = nil
  m_enterSoundTime = CS.SoundManager.Instance:GetEmoteVolume("Sound/system/s_System_Whisk01") / 1.5
  m_delayToWork = nil
  m_delayToLeave = nil
  m_isSilent = true
  table.sort(m_recipeRecord, function(a, b)
    return a.recipeGotTime > b.recipeGotTime
  end)
  m_cacheInfo = this:GetData("HotPot/ResearchCache") or {
    [1] = {},
    [2] = {},
    [3] = {}
  }
  WU.SetActive(REF.NodePrepare, false)
  WU.SetActive(REF.NodeCuisine, false)
  WU.SetActive(REF.NodeProgress, false)
  WU.SetActive(REF.BtnReceive, false)
  WU.SetActive(REF.NodeCover, false)
  WU.SetActive(REF.NodeIngredients, false)
  InitIngredientsView()
  this:BindRemote(DB:GameRequest("fci/cooking-recipe/"), OnCookInfoChange)
end

function UninitWindow()
  this:UnregisterGameEvent("UI/WindowUninited", OnWindowUninited)
  if m_tab ~= 4 then
    EndSound(m_cacheInfo[m_tab].state ~= Enum_state.Cooking)
  end
  m_tab = nil
end

function OnTopMostWindow(windowName)
  if m_tab == nil then
    return
  end
  local state = 0
  if m_cacheInfo[m_tab] then
    state = m_cacheInfo[m_tab].state
  end
  if windowName == "HotPotResearch" then
    if state == Enum_state.Cooking then
      StartSound()
      REF.EffectTool.EffectGenerator:Play()
    elseif state == Enum_state.Finish then
      REF.EffectCuisine.EffectGenerator:Play()
    end
  else
    if m_isSilent then
      return
    end
    EndSound(state ~= Enum_state.Cooking)
  end
end

function OnWindowUninited(window)
  if window.name == "HotPotResearchResult" then
    SetTabContent(m_tab, Enum_state.Prepare)
    UpdatePrepareView()
  end
end

function UpdateWindow()
  if m_cookInfo == nil then
    return
  end
  for i = 1, 3 do
    if m_cacheInfo[i].state == Enum_state.Cooking then
      local state = GetCookTopState(i)
      SetTabContent(i, state)
      if state == Enum_state.Cooking and i == m_tab then
        SetCookProgress(i)
      elseif state == Enum_state.Finish then
        RU.SetRedMark("Welfare/ChineseNewYear/HotPot/Research/" .. i, true)
        if i == m_tab then
          UpdateFinishView()
        end
      end
    end
  end
end

function OnCookInfoChange(res)
  if res == nil then
    return
  end
  m_cookInfo = res
  IniteTabGridView()
  SwitchCooktop(1)
end

function InitIngredientsView()
  local itemConfigs = PB.all("ItemInfo"):where(function(k, v)
    return v.bindActivityType == PB.enum.ActivityType.Cooking and v.funcType == PB.enum.ItemFuncType.Ingredients
  end):distinct():sort(function(a, b)
    return a.id < b.id
  end)
  local mainIndex = 0
  local supplementaryIndex = 0
  local sauceIndex = 0
  for i = 1, #itemConfigs do
    local itemConfig = itemConfigs[i]
    local itemInfo = this:GetData("fci/item/" .. itemConfig.id)
    local ref
    if itemConfig.param[1] == 1 then
      ref = REF.NodeMain[mainIndex]
      mainIndex = mainIndex + 1
      ref["@index"] = mainIndex
    elseif itemConfig.param[1] == 2 then
      ref = REF.NodeSupplementary[supplementaryIndex]
      supplementaryIndex = supplementaryIndex + 1
      ref["@index"] = supplementaryIndex
    else
      ref = REF.NodeSauce[sauceIndex]
      sauceIndex = sauceIndex + 1
      ref["@index"] = sauceIndex
    end
    ref["@itemConfig"] = itemConfig
    ref["@itemInfo"] = itemInfo
    local count = 0
    if itemInfo then
      count = itemInfo.count
    end
    local item = {
      id = itemConfig.id,
      count = count
    }
    ref["$$SetItem"](item)
  end
  WU.SetActive(REF.NodeIngredients, true)
end

function IniteTabGridView()
  for i = 1, 3 do
    local state = GetCookTopState(i)
    SetTabContent(i, state)
  end
end

function SwitchCooktop(index)
  REF.TabGrid[index - 1]["$UIToggle"].value = true
  m_preTab = m_tab
  m_tab = index
  WU.SetActive(REF.NodeCookDetail, true)
  WU.SetActive(REF.NodeRecipeRecord, false)
  if m_cacheInfo[index].state == Enum_state.Prepare then
    UpdatePrepareView()
  elseif m_cacheInfo[index].state == Enum_state.Cooking then
    UpdateCookingView()
  elseif m_cacheInfo[index].state == Enum_state.Finish then
    UpdateFinishView()
  end
  ChangeSound()
end

function SwitchRecipeRecord()
  m_preTab = m_tab
  m_tab = 4
  UpdateIngredientsSelected()
  WU.SetActive(REF.NodeCookDetail, false)
  WU.SetActive(REF.NodeRecipeRecord, true)
  LU.Set(REF.WrapContentRecipe, #m_recipeRecord)
  ChangeSound()
end

function UpdatePrepareView()
  local items = m_cacheInfo[m_tab].items or _ENV["!"]({})
  for i = 0, #REF.NodeSelectedIngredients - 1 do
    local ref = REF.NodeSelectedIngredients[i]
    local ingredient = items[i + 1] and items[i + 1].item
    if ingredient == nil then
      SetPlateView(ref)
    else
      local item = this:GetData("fci/item/" .. ingredient.id)
      if item == nil or item.count == 0 then
        items[i + 1] = nil
        SetPlateView(ref)
      else
        SetPlateView(ref, {
          id = ingredient.id,
          count = 1
        })
      end
    end
  end
  WU.SetActive(REF.LabelResearch, true)
  WU.SetActive(REF.LabelReceive, false)
  UpdateIngredientsSelected()
  WU.SetActive(REF.NodePrepare, true)
  WU.SetActive(REF.NodeCuisine, false)
  WU.SetActive(REF.NodeProgress, false)
  WU.SetActive(REF.BtnReceive, true)
  WU.SetActive(REF.TextureTool, true)
  WU.SetActive(REF.EffectTool, false)
end

function UpdateCookingView(clearCache)
  local cookInfo = m_cookInfo.recipeProgressDetails[m_tab]
  local recipeId = cookInfo.recipeId
  local ingredients = PB.get("RecipeInfo", recipeId).ingredients
  for i = 0, #REF.NodeSelectedIngredients - 1 do
    local ref = REF.NodeSelectedIngredients[i]
    local ingredient = ingredients[i + 1]
    SetPlateView(ref, {
      id = ingredient.id,
      count = 1
    })
  end
  SetCookProgress(m_tab)
  UpdateIngredientsSelected(clearCache)
  WU.SetActive(REF.NodePrepare, true)
  WU.SetActive(REF.NodeCuisine, false)
  WU.SetActive(REF.NodeProgress, true)
  WU.SetActive(REF.BtnReceive, false)
  WU.SetActive(REF.TextureTool, false)
  WU.SetActive(REF.EffectTool, true)
  REF.EffectTool.EffectGenerator:Play()
end

function UpdateFinishView()
  local recipeId = m_cookInfo.recipeProgressDetails[m_tab].recipeId
  local cuisineId = PB.get("RecipeInfo", recipeId).food.id
  local tex = WU.AcquireAsset("Texture/Welfare/new_year/Food_" .. cuisineId)
  _ENV["$"](REF.EffectCuisine).FoodIcon.MeshRenderer.material:SetTexture("_MainTex", tex)
  WU.SetActive(REF.EffectCuisine, true)
  REF.EffectCuisine.EffectGenerator:Play()
  WU.SetActive(REF.LabelResearch, false)
  WU.SetActive(REF.LabelReceive, true)
  UpdateIngredientsSelected()
  WU.SetActive(REF.NodePrepare, false)
  WU.SetActive(REF.NodeCuisine, true)
  WU.SetActive(REF.NodeProgress, false)
  WU.SetActive(REF.BtnReceive, true)
  WU.SetActive(REF.TextureTool, true)
  WU.SetActive(REF.EffectTool, false)
end

function SetTabContent(index, state)
  m_cacheInfo[index].state = state
  local ref = REF.TabGrid[index - 1]
  local title = WU.GetString("HotPot_Place", index)
  if state == Enum_state.Prepare then
    ref["$$SetTabText"](title, WU.GetString("HotPot_Empty"))
    ref["$$SetNew"](false)
  elseif state == Enum_state.Cooking then
    local cookTop = m_cookInfo.recipeProgressDetails[index]
    ref["$$SetTabText"](title, RenderTimeSpan(cookTop.researchEndTime - CS.GameTime.serverUtc))
    ref["$$SetNew"](false)
  elseif state == Enum_state.Finish then
    ref["$$SetTabText"](title, WU.GetString("HotPot_Finish"))
    ref["$$SetNew"](true)
  end
end

function UpdateIngredientsSelected(clearCache)
  local items
  if m_preTab and m_preTab ~= 4 then
    items = m_cacheInfo[m_preTab].items
    if items then
      local item = items[1]
      if item then
        SwitchItemSelected(REF.NodeMain[item.index - 1], false)
      end
      item = items[2]
      if item then
        SwitchItemSelected(REF.NodeSupplementary[item.index - 1], false)
      end
      item = items[3]
      if item then
        SwitchItemSelected(REF.NodeSauce[item.index - 1], false)
      end
    end
  end
  if m_tab == 4 then
    return
  end
  local showSelect = m_cacheInfo[m_tab].state == Enum_state.Prepare
  WU.SetActive(REF.NodeCover, not showSelect)
  items = m_cacheInfo[m_tab].items
  if items then
    local item = items[1]
    if item then
      SwitchItemSelected(REF.NodeMain[item.index - 1], showSelect and not clearCache)
    end
    item = items[2]
    if item then
      SwitchItemSelected(REF.NodeSupplementary[item.index - 1], showSelect and not clearCache)
    end
    item = items[3]
    if item then
      SwitchItemSelected(REF.NodeSauce[item.index - 1], showSelect and not clearCache)
    end
  end
  if clearCache then
    m_cacheInfo[m_tab].items = _ENV["!"]({})
  end
end

function SwitchItemSelected(ref, selcted)
  local item = ref["@itemInfo"]
  local deta = fif(selcted, -1, 0)
  ref["$$SetItem"]({
    id = item.id,
    count = item.count + deta
  })
  ref["$$SetSelected"](selcted)
end

function SetCookProgress(index)
  local cookInfo = m_cookInfo.recipeProgressDetails[index]
  local remainTime = cookInfo.researchEndTime - CS.GameTime.serverUtc
  local duringTime = PB.get("RecipeInfo", cookInfo.recipeId).researchTime
  REF.LabelTime.UILabel.text = RenderTimeSpan(remainTime)
  REF.SpriteProgress.UIProgressBar.value = math.min(1 - remainTime * 1.0 / duringTime, 1)
end

function SetPlateView(ref, item)
  if item then
    ref.LabelName.UILabel.text = WU.GetString("ItemName_" .. item.id)
    ref.WidgetIconSlotHotPot["$SetItem"]({
      id = item.id,
      count = 1
    })
    WU.SetActive(ref.Content, true)
  else
    ref.LabelName.UILabel.text = ""
    WU.SetActive(ref.SelectedNode, false)
    WU.SetActive(ref.Content, false)
    WU.SetActive(ref.TextureQuestion, false)
  end
end

function SetItemView(ref, item)
  if item == nil then
    ref.WidgetIconSlotHotPot["$SetItem"]({})
    ref.WidgetIconSlotHotPot["$ShowCustom"]({hideCount = true})
    ref.SpriteIconBG.UISprite.spriteName = "icon_bg_0"
    ref.TextureIcon.UITexture.mainTexturePath = "Texture/ItemIcon/Empty"
    return
  end
end

function OnIngredientClick(go)
  local status = m_cacheInfo[m_tab].state
  if status ~= Enum_state.Prepare then
    return
  end
  local ref = _ENV["$"](go)
  local itemConfig = ref["@itemConfig"]
  local itemInfo = ref["@itemInfo"]
  local index = ref["@index"]
  if itemInfo == nil or itemInfo.count == 0 then
    WU.ShowResourceDetail(11, itemInfo.id)
    return
  end
  local tempInfo = m_cacheInfo[m_tab]
  local kind = itemConfig.param[1]
  local plateRef = REF.NodeSelectedIngredients[kind - 1]
  if ref.SelectedNode.gameObject.activeSelf then
    SetPlateView(plateRef)
    SwitchItemSelected(ref, false)
    tempInfo.items[itemConfig.param[1]] = nil
    return
  end
  local item = {
    id = itemInfo.id,
    count = 1
  }
  SetPlateView(plateRef, item)
  SwitchItemSelected(ref, true)
  if tempInfo.items == nil then
    tempInfo.items = _ENV["!"]({})
  end
  local kind = itemConfig.param[1]
  if tempInfo.items[kind] then
    local oldRefIndex = tempInfo.items[kind].index - 1
    local oldRef
    if kind == 1 then
      oldRef = REF.NodeMain[oldRefIndex]
    elseif kind == 2 then
      oldRef = REF.NodeSupplementary[oldRefIndex]
    elseif kind == 3 then
      oldRef = REF.NodeSauce[oldRefIndex]
    end
    SwitchItemSelected(oldRef, false)
  end
  tempInfo.items[kind] = {item = itemInfo, index = index}
end

function OnBtnReceiveClick()
  local state = m_cacheInfo[m_tab].state
  if state == Enum_state.Prepare then
    OnResearchClick()
  elseif state == Enum_state.Finish then
    OnReceiveClick()
  end
end

function OnResearchClick()
  local items = m_cacheInfo[m_tab].items
  if items == nil then
    WU.ShowHintText(WU.GetString("HotPot_ChooseMoreIngredients"))
    return
  end
  for i = 1, 3 do
    if items[i] == nil then
      WU.ShowHintText(WU.GetString("HotPot_ChooseMoreIngredients"))
      return
    end
  end
  local _, recipe = PB.all("RecipeInfo"):find(function(k, v)
    local same = true
    for i = 1, #v.ingredients do
      if v.ingredients[i].id ~= items[i].item.id then
        same = false
        break
      end
    end
    return same
  end)
  local _, has1 = table.find(m_recipeRecord, function(k, v)
    return v.recipeId == recipe.recipeId
  end)
  if has1 then
    WU.ShowHintText(WU.GetString("HotPot_RecipeHasGot"))
    return
  end
  local _, has2 = table.find(m_cookInfo.recipeProgressDetails, function(k, v)
    return v.recipeId == recipe.recipeId
  end)
  if has2 then
    WU.ShowHintText(WU.GetString("HotPot_RecipeIsResearchingNow"))
    return
  end
  local postData = {
    researchIngredients = {
      [1] = {},
      [2] = {},
      [3] = {}
    }
  }
  for i = 1, #postData.researchIngredients do
    local data = postData.researchIngredients[i]
    data.type = 11
    data.id = items[i].item.id
    data.count = 1
  end
  this:GameRequest("fci/cooking-recipe/" .. m_tab):Post(postData, function(res)
    m_cookInfo.recipeProgressDetails[m_tab] = res.recipeInfo
    this:SetData("HotPot/ResearchProgress", m_cookInfo.recipeProgressDetails)
    DBH.ResChange(res.resChange)
    SetTabContent(m_tab, Enum_state.Cooking)
    UpdateCookingView(true)
    ChangeSound(true)
  end)
end

function OnReceiveClick()
  local summary = this:GetData("fci/cooking-summary/")
  local cuisines = summary.placedFoods
  local count = #cuisines
  if count >= m_plateMaxNum then
    WU.ShowHintText(WU.GetString("HotPot_TableFull"))
    return
  end
  this:GameRequest("fci/cooking-recipe/" .. m_tab):Post({}, function(res)
    DBH.ResChange(res.resChange)
    table.insert(summary.recipeGots, 1, res.recipeGot)
    summary.placedFoods = res.placedFoods
    if res.placedFoods and res.placedFoods[1] and WU.IsFirstTimeInClient("Welfare2019CNYHotPotEat") then
      RU.SetRedMark("Welfare/ChineseNewYear/HotPot/EatFirst", true)
    end
    this:SetData("fci/cooking-summary/", summary)
    RU.SetRedMark("Welfare/ChineseNewYear/HotPot/Research/" .. m_tab, false)
    m_cookInfo.recipeProgressDetails[m_tab] = nil
    this:SetData("HotPot/ResearchProgress", m_cookInfo.recipeProgressDetails)
    this:SetData("HotPot/ResearchResult", res.recipeGot)
    WU.AcquireWindowAsync("HotPotResearchResult")
  end)
end

function OnBtnProduction()
  local summary = this:GetData("fci/cooking-summary/")
  local cuisines = summary.placedFoods
  local count = #cuisines
  if count >= m_plateMaxNum then
    WU.ShowHintText(WU.GetString("HotPot_TableFull"))
    return
  end
  WU.AcquireWindowAsync("HotPotProduction")
end

function UpdateRecipeSlot(ref, wrapIndex, realIndex)
  if realIndex < 0 or m_recipeRecord == nil or realIndex >= #m_recipeRecord then
    return
  end
  local count = #m_recipeRecord
  local info = m_recipeRecord[realIndex + 1]
  ref.LabelIndex.UILabel.text = count - realIndex
  ref.LabelTime1.UILabel.text = WU.RenderTime2(info.recipeGotTime)
  ref.LabelTime2.UILabel.text = RendTimeHSM(info.recipeGotTime)
  local recipeConfig = PB.get("RecipeInfo", info.recipeId)
  for i = 0, #ref.NodeSelectedIngredients - 1 do
    local ingredient = recipeConfig.ingredients[i + 1]
    ref.NodeSelectedIngredients[i]["$$SetItem"](ingredient)
    ref.NodeSelectedIngredients[i]["$$SetClickCallback"](function(go)
      WU.ShowItemDetail(ingredient.id)
    end)
  end
  ref.NodeRecipe[0]["$$SetItem"](recipeConfig.food)
  ref.NodeRecipe[0]["$$SetClickCallback"](function(go)
    WU.ShowItemDetail(recipeConfig.food.id)
  end)
end

function ChangeSound(force)
  local nowState
  if m_tab == 4 then
    nowState = 0
  else
    nowState = m_cacheInfo[m_tab].state
  end
  local preState
  if m_preTab == nil or m_preTab == 4 then
    preState = 0
  else
    preState = m_cacheInfo[m_preTab].state
  end
  if preState ~= Enum_state.Cooking and nowState == Enum_state.Cooking or force then
    StartSound()
  elseif preState == Enum_state.Cooking and nowState ~= Enum_state.Cooking then
    EndSound()
  elseif preState == Enum_state.Cooking and nowState == Enum_state.Cooking then
    RestartSound()
  end
end

function GetCookTopState(index)
  local cookTop = m_cookInfo.recipeProgressDetails[index]
  if cookTop == nil then
    return Enum_state.Prepare
  end
  if cookTop.researchEndTime < CS.GameTime.serverUtc and cookTop.recipeGot == 0 then
    return Enum_state.Finish
  end
  return Enum_state.Cooking
end

function RenderTimeSpan(seconds)
  local result = ""
  local m = math.floor(seconds / 60)
  local s = seconds - m * 60
  local strM = fif(m < 10, "0" .. m, tostring(m))
  local strS = fif(s < 10, "0" .. s, tostring(s))
  return strM .. ":" .. strS
end

function RendTimeHSM(time)
  local dateTime = CS.GameTime.UtcToLocal(time)
  local h = dateTime.Hour
  local m = dateTime.Minute
  local s = dateTime.Second
  local strH = fif(h < 10, "0" .. h, tostring(h))
  local strM = fif(m < 10, "0" .. m, tostring(m))
  local strS = fif(s < 10, "0" .. s, tostring(s))
  return strH .. ":" .. strM .. ":" .. strS
end

function StartSound()
  m_isSilent = false
  if m_delayToWork ~= nil then
    this:StopCoroutine(m_delayToWork)
    m_delayToWork = nil
  end
  if m_delayToLeave ~= nil then
    this:StopCoroutine(m_delayToLeave)
    m_delayToLeave = nil
  end
  local cookInfo = m_cookInfo.recipeProgressDetails[m_tab]
  local remainTime = cookInfo.researchEndTime - CS.GameTime.serverUtc
  local workT = remainTime - m_enterSoundTime
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk01")
  m_delayToWork = this:DelayInvokeInSeconds(m_enterSoundTime - 0.1, function()
    CS.SoundManager.Instance:PlayStateSound(1, "Sound/system/s_System_Whisk02")
  end)
  m_delayToLeave = this:DelayInvokeInSeconds(remainTime + 0.7, function()
    CS.SoundManager.Instance:StopStateSound(1)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk03")
    m_isSilent = true
  end)
end

function EndSound(all)
  if m_delayToWork ~= nil then
    this:StopCoroutine(m_delayToWork)
    m_delayToWork = nil
  end
  if m_delayToLeave ~= nil then
    this:StopCoroutine(m_delayToLeave)
    m_delayToLeave = nil
  end
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_Whisk01")
  CS.SoundManager.Instance:StopStateSound(1)
  if not all then
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk03")
  end
  m_isSilent = true
end

function RestartSound()
  m_isSilent = false
  if m_delayToWork ~= nil then
    this:StopCoroutine(m_delayToWork)
    m_delayToWork = nil
  end
  if m_delayToLeave ~= nil then
    this:StopCoroutine(m_delayToLeave)
    m_delayToLeave = nil
  end
  CS.SoundManager.Instance:StopSound("Sound/system/s_System_Whisk01")
  CS.SoundManager.Instance:StopStateSound(1)
  local cookInfo = m_cookInfo.recipeProgressDetails[m_tab]
  local workT = cookInfo.researchEndTime - CS.GameTime.serverUtc
  CS.SoundManager.Instance:PlayStateSound(1, "Sound/system/s_System_Whisk02")
  m_delayToLeave = this:DelayInvokeInSeconds(workT + 0.7, function()
    CS.SoundManager.Instance:StopStateSound(1)
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Whisk03")
    m_isSilent = true
  end)
end
