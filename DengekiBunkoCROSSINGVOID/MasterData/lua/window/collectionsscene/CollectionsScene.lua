local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local m_sceneList, m_rollerRadius, m_rollerCenterY, m_selectedId
local m_isRandomMode = false
local m_unlocked = false
local m_currentBGM

function SetupWindow()
  REF.WrapContentSceneRoller.UIWrapContent.onInitializeItem = OnItemSceneShow
  REF.WrapContentSceneRoller.UICenterOnChild.onCenter = OnCenterItemScene
  WU.BindButtonEvent(REF.ButtonSet, OnClickSetScene)
  WU.BindButtonEvent(REF.SpriteCheckbox, OnClickSetRandom)
  WU.BindButtonEvent(REF.ButtonSelectBGM, OnClickSelectBGM)
  WU.BindDragStartEvent(REF.SceneRoller, OnDragSceneRoller)
  WU.TraverseChildren(REF.SceneRoller, function(go)
    WU.BindDragStartEvent(_ENV["$"](go).root, OnDragSceneRoller)
  end)
  m_rollerRadius = REF.SceneRoller.UIWidget.height / 2 + REF.SpriteSceneName.UISprite.height / 2
  m_rollerCenterY = REF.SceneRoller.transform.position.y
end

function InitWindow()
  m_sceneList = PB.all("CollectionsScenes"):where(function(k, v)
    return U.IsTimeOpen(v.openTime) and (not v.hide or v.hide and this:GetData("fci/item/" .. v.id).count > 0)
  end):toarray()
  this:Bind("CollectionsScene/selectedId", OnSelectedSceneChange)
  this:Bind("CollectionsScene/isRandomMode", OnRanomModeChange)
  this:DelayInvokeInFrames(1, function()
    if #m_sceneList == 0 then
      WU.ShowHintText(WU.GetString("Window_NoCollectionsScenes"))
      WU.RecycleWindow(this)
      return
    end
    REF.WrapContentSceneRoller.UICenterOnChild:Recenter()
  end)
end

function UpdateWindow()
  for i = 0, #REF.WrapContentSceneRoller - 1 do
    local itemTransform = REF.WrapContentSceneRoller[i]["$transform"]
    local p = REF.SceneRoller.transform:InverseTransformPoint(itemTransform.position)
    local theta = CS.UnityEngine.Mathf.Asin(p.y / m_rollerRadius)
    p = itemTransform.localPosition
    p.x = fif(isNaN(theta), 0, CS.UnityEngine.Mathf.Cos(theta) * m_rollerRadius)
    itemTransform.localPosition = p
    local a = CS.UnityEngine.Mathf.Lerp(1, 0, math.abs(theta) / 1.57)
    local alpha = fif(isNaN(a), 0.25, a)
    _ENV["$"](itemTransform)["$UIWidget"].alpha = alpha
    local s = itemTransform.localScale
    local x = CS.UnityEngine.Mathf.Lerp(1, 0.6, math.abs(theta) / 1.57)
    s.x = fif(isNaN(x), s.x, x)
    s.y = s.x
    itemTransform.localScale = s
  end
end

function OnSelectedSceneChange(id)
  if id then
    if m_selectedId then
      REF.TextureOldBG.UITexture.mainTexturePath = "Texture/Background/" .. PB.get("CollectionsScenes", m_selectedId).textureRes
    end
    m_selectedId = id
    local xlsxConfig = PB.get("CollectionsScenes", id)
    local isDefault = xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Default
    m_unlocked = IsUnlocked(id)
    REF.TextureNewBG.UITexture.mainTexturePath = "Texture/Background/" .. xlsxConfig.textureRes
    REF.NodeBG.UIPlayTween:Play(true)
    WU.ToggleRendering(REF.LabelOwn, m_unlocked)
    WU.ToggleRendering(REF.LabelUnlockCondition, not m_unlocked)
    if not m_unlocked then
      if xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Task then
        local task = GetTaskById(xlsxConfig.taskId)
        if task then
          REF.LabelUnlockCondition.UILabel.text = WU.GetString("TaskDesc_" .. task.id, task.res.maxProgress, TU.GetParamLocalizationText(task.res.taskParam, task.res.goalType)) .. string.format(" (%s/%s)", task.progress, task.res.maxProgress)
          REF.SpriteProgressBarFg.UISprite.width = math.floor(REF.SpriteProgressBarBg.UISprite.width * (task.progress / task.res.maxProgress))
        else
          warning("GamePlay", "there is no scene task, id: " .. xlsxConfig.taskId)
        end
      else
        REF.LabelUnlockCondition.UILabel.text = WU.GetString("Window_SceneUnlockCondition_" .. id)
      end
    end
    local showProgress = not m_unlocked and xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Task
    WU.ToggleRendering(REF.ProgressBar, showProgress)
    WU.ToggleRendering(REF.SpriteLine, not showProgress)
    WU.ToggleRendering(REF.ButtonSet, this:GetData("cityScene") ~= id)
    REF.LabelConfirm.UILabel.text = WU.GetString(fif(m_unlocked, "Window_SetScene", "Window_Locked"))
    REF.ButtonSet.UIButton.isEnabled = m_unlocked
    REF.ButtonSet.UISprite.spriteName = fif(m_unlocked, "white_button_02", "disable_button_02")
    REF.LabelConfirm.UILabel.color = CS.NGUIMath.HexToColor(fif(m_unlocked, 995134463, 1651344127))
    local currentBGMId = this:GetData("cityBGM")
    local config
    if id == this:GetData("cityScene") then
      config = PB.get("CollectionsScenes", currentBGMId)
      m_currentBGM = currentBGMId
    else
      config = xlsxConfig
      m_currentBGM = id
    end
    REF.LabelBGM.UILabel.text = WU.GetString("Window_SceneBGMTitle", config.bgmName)
    REF.SpriteTypeOld.UISprite.spriteName = "stage_setting/stage_setting_" .. fif(xlsxConfig.isDayType, "day", "night")
    REF.SpriteTypeNew.UISprite.spriteName = "stage_setting/stage_setting_" .. fif(xlsxConfig.isDayType, "day", "night")
    this:DelayInvokeInSeconds(1, function()
      CS.SoundManager.Instance:PlayMusic(fif(id == m_selectedId, config.bgmRes, ""))
    end)
  end
end

function OnRanomModeChange(isRandomMode)
  if isRandomMode ~= nil then
    m_isRandomMode = isRandomMode
    REF.SpriteCheckbox.UISprite.spriteName = fif(isRandomMode, "stage_setting/stage_setting_on", "stage_setting/stage_setting_off")
  end
end

function OnCenterItemScene(itemGo)
  local id = _ENV["$"](itemGo)["@id"]
  if id and id ~= m_selectedId then
    this:SetData("CollectionsScene/selectedId", _ENV["$"](itemGo)["@id"])
  end
  WU.ToggleRendering(REF.SpriteTypeNew, true)
  WU.ToggleRendering(REF.SpriteTypeOld, false)
  REF.SpriteTypeNew.TweenAlpha:Begin()
end

function OnItemSceneShow(itemGo, wrapIndex, realIndex)
  if m_sceneList ~= nil and 0 < #m_sceneList then
    local data = m_sceneList[realIndex % #m_sceneList + 1]
    _ENV["$"](itemGo)["@id"] = data.id
    _ENV["$"](itemGo).SpriteSceneName.UISprite.spriteName = "stage/stage_name_" .. data.id
  end
end

function OnClickSetScene()
  if m_unlocked then
    WU.RecordButtonClick(100136801)
    local xlsxConfig = PB.get("CollectionsScenes", m_selectedId)
    if xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Task and this:GetData("fci/item/" .. m_selectedId).count == 0 then
      this:GameRequest("fci/task/" .. xlsxConfig.taskId .. "/reward/"):Post(nil, function(result)
        DBH.ResChange(result.resChange)
        ReqSetScene()
      end)
    else
      ReqSetScene()
    end
  end
end

function OnClickSetRandom()
  m_isRandomMode = not m_isRandomMode
  WU.ToggleRendering(REF.ButtonSet, true)
  REF.SpriteCheckbox.UISprite.spriteName = fif(m_isRandomMode, "stage_setting/stage_setting_on", "stage_setting/stage_setting_off")
end

function OnDragSceneRoller()
  WU.ToggleRendering(REF.SpriteTypeNew, false)
  WU.ToggleRendering(REF.SpriteTypeOld, true)
  REF.SpriteTypeOld.TweenAlpha:Play(true)
end

function ReqSetScene()
  if m_selectedId ~= this:GetData("cityScene") or m_isRandomMode ~= this:GetData("CollectionsScene/isRandomMode") then
    this:GameRequest("fci/home-back-ground"):Post({homeBackGround = m_selectedId, isRandom = m_isRandomMode}, function()
      this:SetData("CollectionsScene/isRandomMode", m_isRandomMode)
      this:SetData("cityScene", m_selectedId)
      if this:GetData("CollectionsScene/isRandomMode") == true then
        this:SetData("cityBGM", m_selectedId)
        local config = PB.get("CollectionsScenes", m_selectedId)
        REF.LabelBGM.UILabel.text = WU.GetString("Window_SceneBGMTitle", config.bgmName)
        m_currentBGM = m_selectedId
      end
    end)
  end
  if m_currentBGM ~= this:GetData("cityBGM") then
    this:GameRequest("fci/home-back-ground/bgm"):Post({bgm = m_currentBGM}, function()
      this:SetData("cityBGM", m_currentBGM)
    end)
  end
  WU.ToggleRendering(REF.ButtonSet, false)
end

function IsUnlocked(id)
  local xlsxConfig = PB.get("CollectionsScenes", id)
  if xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Default then
    return true
  end
  if this:GetData("fci/item/" .. id).count > 0 then
    return true
  end
  if xlsxConfig.unlockType == PB.enum.CollectionsSceneUnlockType.Task then
    local t = GetTaskById(id)
    if t then
      return t.isDone
    end
  end
  return false
end

function GetTaskById(id)
  local tasks = this:GetData("fci/sceneTasks")
  local _, t = table.find(tasks, function(k, v)
    return v.id == id
  end)
  return t
end

function OnClickSelectBGM()
  local isRandom = m_isRandomMode
  if isRandom == nil or isRandom == false then
    WU.AcquireWindowAsync("BGMSelect", function(window)
      local ref = _ENV["$"](window)
      ref["$$SetConfirmCallback"](function(id)
        if id ~= nil then
          m_currentBGM = id
          local xlsxConfig = PB.get("CollectionsScenes", m_currentBGM)
          REF.LabelBGM.UILabel.text = WU.GetString("Window_SceneBGMTitle", xlsxConfig.bgmName)
          if this:GetData("cityScene") ~= m_selectedId or m_isRandomMode ~= this:GetData("CollectionsScene/isRandomMode") then
            WU.ToggleRendering(REF.ButtonSet, true)
          else
            ReqSetScene()
          end
        end
      end)
      ref["$$SetBGMSelect"](m_sceneList, this:GetData("CollectionsScene/selectedId"), m_currentBGM)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_SelectBGMFailed"))
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001368, on)
end
