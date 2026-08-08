local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local m_rewardInfo
local m_effectOnIndex = -1
local m_fullscreenEffectOn = false
local m_canClickPiece

function Awake()
  m_canClickPiece = true
  WU.BindButtonEvent(REF.TextureCost, function()
    local cellInfo = PB.all("JigsawPuzzleCell")[1]
    local cost = cellInfo.cost
    WU.ShowResourceDetail(cost.type, cost.id)
  end)
  local cellInfo = PB.all("JigsawPuzzleCell")[1]
  local itemInfo = PB.get("ItemInfo", cellInfo.cost.id)
  REF.TextureCost.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
  WU.BindButtonEvent(REF.TextureFull, function()
    if m_fullscreenEffectOn then
      return
    end
    WU.ShowHintText(WU.GetString("LocalHalloween_Tips12"))
  end)
  m_rewardInfo = PB.all("JigsawPuzzlePrize"):where(function(_, p)
    return p.lightNum ~= 0
  end):toarray()
end

function OnEnable()
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  if halloweenInfo and halloweenInfo.isFirstEnter == true then
    halloweenInfo.isFirstEnter = false
    DB:GameRequest("fci/JigsawPuzzle/"):SyncInput(false):Post({}, function()
    end)
  end
  local flag = ACU.HasHalloweenRedPoint(halloweenInfo)
  RU.SetRedMark("Welfare/Halloween", flag)
  m_canClickPiece = true
  StopPrePieceEffect(true)
  InitContent()
end

function UpdateContent(data)
  if data == nil then
    data = this:GetData("fci/JigsawPuzzle/")
  end
  REF.LabelTime.UILabel.text = ""
  m_activityManager.GetActivityByType(PB.enum.ActivityType.JigsawPuzzle, function(acList)
    if acList then
      local acInfo = acList[1]
      if acInfo then
        local strTime = WU.RenderTime24(acInfo.timestampStart, acInfo.timestampEnd)
        REF.LabelTime.UILabel.text = strTime
      end
    end
  end)
  UpdateProgress()
  ChangeRedStatus()
  UpdateCostNum()
  REF.Pieces.gameObject:SetActive(true)
  REF.TextureFull.gameObject:SetActive(false)
  for k, v in pairs(data.lightenCell) do
    local refCard = REF.Pieces[v - 1]
    if refCard then
      refCard.BlockIcon.gameObject:SetActive(true)
    end
  end
  if IsOver() then
    if not m_fullscreenEffectOn then
      REF.TextureFull.gameObject:SetActive(true)
    end
  else
    REF.TextureFull.gameObject:SetActive(false)
  end
end

function UpdateCostNum()
  local cellInfo = PB.all("JigsawPuzzleCell")[1]
  local costItem = cellInfo.cost
  local storageCnt = 0
  if costItem.type == PB.enum.ResourceType.ResItem then
    local costStock = this:GetData("fci/item/" .. costItem.id)
    if costStock then
      storageCnt = costStock.count
    end
  else
    storageCnt = this:GetData("fci/resource/" .. PB.enum.ResourceType[v.cost.type] .. "_" .. v.cost.id)
  end
  REF.LabelLeft.UILabel.text = storageCnt
end

function InitContent()
  m_activityManager.GetActivityByType(PB.enum.ActivityType.JigsawPuzzle, function(acList)
    if acList then
      for k, v in pairs(acList) do
        if ACU.IsOpenForDoing(v, true) then
          WU.TraverseChildren(REF.Pieces, function(go, index)
            local blockIcon = _ENV["$"](go).BlockIcon
            local path = string.format("Texture/WelfarePostcard/Halloween_puzzle/Halloween_puzzle_%02d", index + 1)
            blockIcon.UITexture.mainTexturePath = path
            blockIcon.gameObject:SetActive(false)
            local container = _ENV["$"](go).Container
            WU.BindButtonEvent(container, function()
              OnPieceClick(index + 1)
            end)
          end)
          this:Unbind("fci/JigsawPuzzle/", UpdateContent)
          this:BindRemote(DB:GameRequest("fci/JigsawPuzzle/"), UpdateContent)
          break
        end
      end
    end
  end)
end

function IsOver()
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  if halloweenInfo == nil then
    return false
  end
  local _, v = table.find(halloweenInfo.receivePrize, function(_, c)
    return c == 0
  end)
  return v ~= nil
end

function OnRewardClick(info)
  if m_fullscreenEffectOn then
    return
  end
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  if halloweenInfo then
    local bHasGet = false
    local content = ""
    local title = WU.GetString("LocalHalloween_Tips4")
    local clickCnt = #halloweenInfo.lightenCell
    local _, v = table.find(halloweenInfo.receivePrize, function(_, c)
      return info.lightNum == c
    end)
    bHasGet = v ~= nil
    local buttonTitle = WU.GetString("WindowGacha_Close")
    if not bHasGet then
      if clickCnt >= info.lightNum then
        DB:GameRequest("fci/JigsawPuzzle/ReceivePrize/"):Post({
          lightNum = info.lightNum
        }, function(res)
          DBH.ResChange(res.resChange)
          WU.ShowRewards(res.resChange)
          local updateHalloweenInfo = this:GetData("fci/JigsawPuzzle/")
          local _, v = table.find(halloweenInfo.receivePrize, function(_, c)
            return info.lightNum == c
          end)
          if v == nil then
            table.insert(updateHalloweenInfo.receivePrize, info.lightNum)
          end
          UpdateContent(updateHalloweenInfo)
        end)
        return
      end
      content = WU.GetString("LocalHalloween_Tips3", info.lightNum)
      buttonTitle = nil
    end
    WU.AcquireWindowAsync("RewardPreview", function(ui)
      _ENV["$"](ui)["$$SetView"](info.prize, title, content, bHasGet, buttonTitle)
    end)
  end
end

function ChangeRedStatus()
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  if halloweenInfo then
    local flag = ACU.HasHalloweenRedPoint(halloweenInfo)
    RU.SetRedMark("Welfare/Halloween", flag)
  end
end

function UpdateProgress()
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  if halloweenInfo == nil then
    return
  end
  local rewardInfo = PB.all("JigsawPuzzlePrize"):where(function(_, p)
    return p.lightNum ~= 0
  end):toarray()
  table.sort(rewardInfo, function(a, b)
    return a.lightNum < b.lightNum
  end)
  local lightNum = #halloweenInfo.lightenCell
  local preCnt = 0
  local stageCnt = #rewardInfo
  local per = 0
  local canGet = {}
  for i, v in ipairs(rewardInfo) do
    local temp = lightNum - v.lightNum
    if temp < 0 then
      per = per + (lightNum - preCnt) / (v.lightNum - preCnt)
      break
    else
      per = per + 1
      preCnt = v.lightNum
      canGet[i] = true
    end
  end
  per = per / stageCnt
  REF.SpriteBone.UISprite.fillAmount = per
  REF.LabelLight.UILabel.text = tostring(lightNum)
  for i, v in ipairs(m_rewardInfo) do
    local refPanel = REF[string.format("Panel%d", i)]
    if refPanel then
      refPanel = _ENV["$"](refPanel)
      local _, v2 = table.find(halloweenInfo.receivePrize, function(_, c)
        return v.lightNum == c
      end)
      local bGet = v2 ~= nil
      refPanel.NoDone.gameObject:SetActive(not bGet)
      local refNoDone = _ENV["$"](refPanel.NoDone)
      local refDone = _ENV["$"](refPanel.Done)
      refNoDone.LabelNeedNum.UIHtmlLabel.text = WU.GetString("Seal_Tips12", v.lightNum)
      refDone.LabelNeedNum.UIHtmlLabel.text = WU.GetString("Seal_Tips12", v.lightNum)
      if not bGet and canGet[i] == true then
        refPanel.PanelEffect.gameObject:SetActive(true)
        refPanel.PanelEffect.EffectGenerator:Play()
      else
        refPanel.PanelEffect.gameObject:SetActive(false)
      end
      refPanel.SpriteBox.gameObject:SetActive(true)
      if bGet then
        refPanel.SpriteBox.UISprite.spriteName = "Halloween/halloween_pumpkin_2"
      elseif not bGet and canGet[i] == true then
        refPanel.SpriteBox.gameObject:SetActive(false)
      else
        refPanel.SpriteBox.UISprite.spriteName = "Halloween/halloween_pumpkin_0"
      end
      refPanel.Done.gameObject:SetActive(bGet)
      WU.BindButtonEvent(refPanel.Sprite, function()
        OnRewardClick(m_rewardInfo[i])
      end)
    end
  end
end

function OnPieceClick(index)
  if not m_canClickPiece then
    return
  end
  local cellInfo = PB.get("JigsawPuzzleCell", index)
  if cellInfo == nil then
    warning("Debug", "Halloween no cellInfo:" .. index)
    return
  end
  local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
  local _, v = table.find(halloweenInfo.lightenCell, function(_, c)
    return c == cellInfo.cellId
  end)
  if v then
    WU.ShowHintText(WU.GetString("LocalHalloween_Tips1"))
    return
  end
  local costItem = cellInfo.cost
  local storageCnt = 0
  if costItem.type == PB.enum.ResourceType.ResItem then
    local costStock = this:GetData("fci/item/" .. costItem.id)
    if costStock then
      storageCnt = costStock.count
    end
  else
    storageCnt = this:GetData("fci/resource/" .. PB.enum.ResourceType[v.cost.type] .. "_" .. v.cost.id)
  end
  if storageCnt < costItem.count then
    WU.ShowHintText(WU.GetString("LocalHalloween_Tips2", WU.GetItemName(costItem.id, costItem.type)))
    return
  end
  DB:GameRequest("fci/JigsawPuzzle/Lighten/"):Post({
    cellId = cellInfo.cellId
  }, function(res)
    DBH.ResChange(res.resChange)
    local data = this:GetData("fci/JigsawPuzzle/")
    if data then
      local _, v = table.find(data.lightenCell, function(k, c)
        return cellInfo.cellId == c
      end)
      if v == nil then
        table.insert(data.lightenCell, cellInfo.cellId)
        local temp = PB.all("JigsawPuzzleCell"):toarray()
        if #data.lightenCell == #temp then
          local halloweenInfo = this:GetData("fci/JigsawPuzzle/")
          table.insert(halloweenInfo.receivePrize, 0)
        end
      end
      UpdateCostNum()
      ChangeRedStatus()
      ShowPutIntoEffect(cellInfo.cellId, res.resChange)
    end
  end)
end

function ToggleFullScreen(visible)
  REF.FullScreen.gameObject:SetActive(visible)
  local window = WU.FindWindow("Welfare")
  WU.ToggleRendering(_ENV["$"](window).Left, not visible)
end

function ShowPutIntoEffect(index, reward)
  m_canClickPiece = false
  StopPrePieceEffect(true)
  m_effectOnIndex = index
  local playTween = REF.Detail.UIPlayTween
  local reff = REF.Pieces[index - 1]
  local indexstr = string.format("%02d", index)
  local postcardTex = WU.AcquireAsset("Texture/WelfarePostcard/Halloween_puzzle" .. "/Halloween_puzzle_" .. indexstr)
  local pMaskTex = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect02/postcardMask02_" .. indexstr)
  local pGlow = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect02/postcardADD02_" .. indexstr)
  _ENV["$"](reff.PieceEffect).Postcard.MeshRenderer.material:SetTexture("_MainTex", postcardTex)
  _ENV["$"](reff.PieceEffect).PostcardMASK.MeshRenderer.material:SetTexture("_MainTex", pMaskTex)
  _ENV["$"](reff.PieceEffect).PostcardGLOW.MeshRenderer.material:SetTexture("_MainTex", pGlow)
  _ENV["$"](reff.PieceEffect).FlowGlow.MeshRenderer.material:SetTexture("_MaskTex", postcardTex)
  TogglePieceEffect(true, reff)
  reff.PieceEffect.EffectGenerator:Play(function()
    TogglePieceEffect(false, reff)
    reff.BlockIcon.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
    reff.BlockIcon.UITexture.solidColor = false
    m_effectOnIndex = -1
    m_canClickPiece = true
    if not IsOver() then
      WU.ShowRewards(reward)
    end
    UpdateContent()
  end)
  REF.TextureTint.TweenAlpha:ResetToBeginning()
  REF.TextureTint.TweenAlpha:PlayForward()
  REF.TexturePieces.TweenAlpha:ResetToBeginning()
  REF.TexturePieces.TweenAlpha:PlayForward()
  playTween.tweenGroup = 102
  playTween:ResetToBeginning()
  playTween:Play(true)
  if IsOver() then
    m_fullscreenEffectOn = true
    REF.TextureFull.gameObject:SetActive(false)
    this:DelayInvokeInSeconds(2.5, function()
      REF.TextureTintADD.gameObject:SetActive(true)
      REF.TextureTintADD.TweenAlpha:ResetToBeginning()
      REF.TextureTintADD.TweenAlpha:PlayForward()
      playTween.tweenGroup = 103
      playTween:ResetToBeginning()
      playTween:Play(true)
      local map = _ENV["!"]({})
      local order = _ENV["!"]({})
      local num = #REF.Pieces
      for i = 1, num do
        table.insert(map, i)
      end
      for i = 1, num do
        local t = math.random(1, num - i + 1)
        table.insert(order, map[t])
        table.remove(map, t)
      end
      for i = 1, #order do
        local t = i
        local index = order[i]
        local indexstr = fif(index < 10, "0" .. tostring(index), tostring(index))
        local pGlow = WU.AcquireAsset("Texture/WelfarePostcard/PostcardEffect02/postcardADD02_" .. indexstr)
        local t = _ENV["$"](REF.Pieces[index - 1].WhiteEffect).PostcardGLOW
        _ENV["$"](REF.Pieces[index - 1].WhiteEffect).PostcardGLOW.MeshRenderer.material:SetTexture("_MainTex", pGlow)
        this:DelayInvokeInSeconds(i * 0.03, function()
          REF.Pieces[index - 1].WhiteEffect.EffectGenerator:Play(function()
          end)
        end)
      end
      this:DelayInvokeInSeconds(1.431, function()
        m_fullscreenEffectOn = false
        REF.Pieces.gameObject:SetActive(false)
        REF.TextureFull.gameObject:SetActive(true)
        WU.ShowRewards(reward)
      end)
    end)
  end
end

function StopPrePieceEffect(current)
  if m_effectOnIndex ~= -1 then
    UpdateContent()
    local preReff = REF.Pieces[m_effectOnIndex - 1]
    TogglePieceEffect(false, preReff)
    if current then
      preReff.BlockIcon.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
      preReff.BlockIcon.UITexture.solidColor = false
    else
      REF.FSStarEffect.gameObject:SetActive(false)
    end
    local playTween = REF.Detail.UIPlayTween
    playTween.tweenGroup = 102
    playTween:Finish()
    m_effectOnIndex = -1
  end
end

function TogglePieceEffect(visible, ref)
  REF.LightEffect.gameObject:SetActive(visible)
  REF.TextureTint.gameObject:SetActive(visible)
  REF.TexturePieces.gameObject:SetActive(visible)
  if ref then
    ref.PieceEffect.gameObject:SetActive(visible)
  end
end
