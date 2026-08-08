local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_socialPhoto = -1
local m_photos = {}
local m_frames = {}
local m_enumHeadBox = 1
local m_enumHeadFrame = 2
local m_frameCallBack, m_currentHeadPhoto, m_currentHeadFrame
local m_initializeFinish = false

function SetupWindow()
  WU.BindButtonEvent(REF.DefaultHeadPhoto, function()
    this:GameRequest("fci/playerpageinfo/"):Patch({headPhoto = m_socialPhoto}, function(result)
      this:SetData("Space/SelectedPlayer", result)
      this:SetData("PlayerHeadPhoto", result.headPhoto)
      this:SetData("PlayerHeadFrame", result.headFrame)
      local baseInfo = this:GetData("fci/baseinfo/")
      baseInfo.headPhoto = result.headPhoto
      this:SetData("fci/baseinfo/", baseInfo)
      WU.RecycleWindow(this)
    end)
  end)
  WU.BindButtonEvent(_ENV["$"](REF.NodePreview).BtnFinish, FrameSetCallBack)
  LU.Bind(_ENV["$"](REF.HeadBoxDragScrollView).WrapContent, {
    dataSource = function(dataIndex)
      return m_photos and m_photos[dataIndex]
    end,
    updateSlot = function(ref, data)
      OnUpdateImpl(ref, data, m_enumHeadBox)
    end,
    delta = 0.02
  })
  LU.Bind(_ENV["$"](REF.HeadFrameDragScrollView).WrapContent, {
    dataSource = function(dataIndex)
      return m_frames and m_frames[dataIndex]
    end,
    updateSlot = function(ref, data)
      OnUpdateImpl(ref, data, m_enumHeadFrame)
    end,
    delta = 0.02
  })
end

function UninitWindow()
  REF.NodePreview["$Hide"]()
  m_photos = {}
  m_frames = {}
  m_initializeFinish = false
end

function InitWindow()
  WU.SetActive(_ENV["$"](REF.HeadBoxDragScrollView).BottomBarSpace, false)
  WU.SetActive(_ENV["$"](REF.HeadFrameDragScrollView).BottomBarSpace, false)
  REF.HeadBoxTab["$SetSelected"]()
  REF.HeadBoxTab["$SetTab"](WU.GetString("Window_TabPlayerHeadPhoto"), "Lobby", "setting/setting_playerhead")
  REF.HeadBoxTab["$SetClickCallback"](function()
    OnTabChange(m_enumHeadBox)
  end)
  REF.HeadFrameTab["$SetTab"](WU.GetString("Window_TabPlayerHeadFrame"), "Lobby", "setting/setting_playerhead_2")
  REF.HeadFrameTab["$SetClickCallback"](function()
    OnTabChange(m_enumHeadFrame)
  end)
  WU.ToggleRendering(REF.DefaultHeadPhoto, false)
  local platform = this:GetData("accountCache").socialPlatform
  if platform == PB.enum.MSDKLoginPlatform.MSDK_Wechat or platform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    WU.ToggleRendering(REF.DefaultHeadPhoto, true)
    REF.WidgetIconPlayerHeadPhotoDefault["$SetPlayerInfo"]({
      headPhoto = m_socialPhoto,
      socialPicture = this:GetData("fci/baseinfo/").socialPicture
    })
  end
  InitDragScrollView(m_enumHeadBox)
  InitDragScrollView(m_enumHeadFrame)
end

function InitDragScrollView(index)
  local dragScrollViewRef = fif(index == m_enumHeadBox, _ENV["$"](REF.HeadBoxDragScrollView), _ENV["$"](REF.HeadFrameDragScrollView))
  local dataName = fif(index == m_enumHeadBox, "PlayerHeadPhoto", "PlayerHeadFrame")
  local data = this:GetData(dataName)
  local currentHead
  data = fif(data == -1, 0, data)
  local url = fif(index == m_enumHeadBox, "fci/headphoto/", "fci/headframe/")
  WU.SetActive(dragScrollViewRef["$"], false)
  this:BindRemote(DB:GameRequest(url), function(result)
    if result ~= nil then
      WU.SetActive(dragScrollViewRef["$"], true)
      local photos = PB.all(dataName)
      local unlocked = _ENV["!"]({})
      local locked = _ENV["!"]({})
      for i = 1, #photos do
        local photo = photos[i]
        if data == photo.id then
          currentHead = photo
        end
        local find = table.find(result, function(_, v)
          return v.id == photo.id
        end)
        photo.locked = find == nil
        if index == m_enumHeadFrame then
          if find ~= nil and result[find].expireTime ~= nil then
            photo.expireTime = result[find].expireTime
          else
            photo.expireTime = 0
          end
        end
        if photo.id == 0 or photo.id == 9999 then
          photo.locked = false
          table.insert(unlocked, photo)
        elseif find then
          table.insert(unlocked, photo)
        else
          table.insert(locked, photo)
        end
      end
      local aimTable = _ENV["!"]({})
      aimTable:append(unlocked)
      aimTable:append(locked)
      if index == m_enumHeadBox then
        m_photos = aimTable
        m_currentHeadPhoto = fif(currentHead ~= nil, currentHead, {id = 9999})
      elseif index == m_enumHeadFrame then
        m_frames = aimTable
        m_currentHeadFrame = currentHead
      end
      local row = math.ceil(#fif(index == m_enumHeadBox, m_photos, m_frames) / #dragScrollViewRef.WidgetHeadRow)
      LU.Set(dragScrollViewRef.WrapContent, row)
      dragScrollViewRef.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * dragScrollViewRef.WrapContent.UIWrapContent.itemSize, 0)
      WU.SetActive(dragScrollViewRef.BottomBarSpace, 0 < row)
      this:DelayInvokeInFrames(1, function()
        dragScrollViewRef.ScrollView.UIScrollView:ResetPosition()
        WU.SetActive(dragScrollViewRef["$"], false)
      end)
      if m_initializeFinish then
        this:DelayInvokeInFrames(2, function()
          OnTabChange(m_enumHeadBox)
        end)
      else
        m_initializeFinish = true
      end
    end
  end)
end

function OnUpdateImpl(ref, data, index)
  WU.SetActive(ref["$"], data ~= nil)
  if data ~= nil then
    ref["$UIPlayTween"]:Play(true)
    if index == m_enumHeadBox then
      ref["$$SetHeadBox"](data.id, nil, nil, nil)
      local alpha = fif(data.locked, 0.4, 1)
      ref["$$SetContentAlpha"](alpha)
    elseif index == m_enumHeadFrame then
      local remainTime = 0
      if data.expireTime ~= 0 then
        if CS.GameTime.serverUtc < data.expireTime then
          remainTime = fif(data.expireTime == 0, 0, math.modf((data.expireTime - CS.GameTime.serverUtc) / 3600 / 24) + 1)
        else
          data.locked = true
        end
      end
      ref["$$SetHeadBox"](nil, data.id, remainTime, data.locked)
    end
    local dataName = fif(index == m_enumHeadBox, "PlayerHeadPhoto", "PlayerHeadFrame")
    if fif(index == m_enumHeadBox, m_currentHeadPhoto, m_currentHeadFrame).id == data.id then
      ref["$$SetHighlighted"](true)
    end
    local dragScrollViewRef = fif(index == m_enumHeadBox, _ENV["$"](REF.HeadBoxDragScrollView), _ENV["$"](REF.HeadFrameDragScrollView))
    ref["$$SetClickCallback"](function(go)
      WU.TraverseChildren(dragScrollViewRef.WrapContent, function(g)
        WU.TraverseChildren(_ENV["$"](g)["$"], function(g2)
          _ENV["$"](g2)["$$SetHighlighted"](false)
        end)
      end)
      ref["$$SetHighlighted"](true)
      SetCurrentData(data, index)
      UpdateNodePreview(data, index)
    end)
  end
end

function OnTabChange(index)
  local dragScrollView = fif(index == m_enumHeadBox, _ENV["$"](REF.HeadBoxDragScrollView), _ENV["$"](REF.HeadFrameDragScrollView))
  WU.SetActive(REF.HeadBoxDragScrollView, fif(index == m_enumHeadBox, true, false))
  WU.SetActive(REF.HeadFrameDragScrollView, fif(index == m_enumHeadFrame, true, false))
  WU.ToggleRendering(REF.DefaultHeadPhoto, fif(index == m_enumHeadBox, true, false))
  UpdateNodePreview(fif(index == m_enumHeadBox, m_currentHeadPhoto, m_currentHeadFrame), index)
  local row = math.ceil(#fif(index == m_enumHeadBox, m_photos, m_frames) / #dragScrollView.WidgetHeadRow)
  LU.Set(dragScrollView.WrapContent, row)
end

function UpdateNodePreview(data, index)
  if data == nil then
    REF.NodePreview["$Hide"]()
    return
  else
    REF.NodePreview["$Show"]()
  end
  local node = _ENV["$"](REF.NodePreview)
  local dataName = fif(index == m_enumHeadBox, "PlayerHeadPhoto", "PlayerHeadFrame")
  local info = PB.get(dataName, data.id)
  if index == m_enumHeadBox then
    node.WidgetIconPlayerHeadPhoto["$SetHeadBox"](data.id, m_currentHeadFrame.id, nil, false)
    node.FrameNameLabel.UILabel.text = WU.GetString("ActorHeadPhotoName_" .. data.id)
    if data.id == 9999 then
      node.FrameGetWayLabel.UIHtmlLabel.text = ""
    else
      node.FrameGetWayLabel.UIHtmlLabel.text = WU.GetString("Window_PlayerHeadLocked" .. info.getWay, WU.GetString("RoleName_" .. data.imageRoleId))
    end
  elseif index == m_enumHeadFrame then
    node.WidgetIconPlayerHeadPhoto["$SetHeadBox"](m_currentHeadPhoto.id, data.id, nil, false)
    node.FrameNameLabel.UILabel.text = WU.GetString("PlayerHeadFrameName_" .. data.id)
    node.FrameGetWayLabel.UIHtmlLabel.text = WU.GetString("PlayerHeadFrameDesc_" .. data.id)
    local expireTimeText = ""
    if data.id ~= 0 and info.expireDay ~= 0 then
      expireTimeText = WU.GetString("Window_HeadFrameExpireTime") .. WU.GetString("Window_Day", info.expireDay)
    else
      expireTimeText = WU.GetString("Window_UseForever")
    end
    node.FrameExpireDay.UIHtmlLabel.text = expireTimeText
  end
  node.LabelCurrent.UILabel.text = WU.GetString(fif(index == m_enumHeadBox, "Window_CurrentHeadPhoto", "Window_CurrentHeadFrame"))
  local currentId = this:GetData(dataName)
  WU.SetActive(node.BtnFinish, currentId ~= data.id)
  WU.SetActive(node.FrameExpireDay, index ~= m_enumHeadBox)
  node.BtnFinish.UIButton.isEnabled = not data.locked
  _ENV["$"](node.BtnFinish).LabelName.UIHtmlLabel.text = WU.GetString(fif(data.locked, "Window_Locked", "WindowSystem_Confirm"))
  local patchData = {}
  local otherData, otherCurrent
  if index == m_enumHeadBox then
    patchData.headPhoto = data.id
    otherData = m_currentHeadFrame
    otherCurrent = this:GetData("PlayerHeadFrame")
    if not otherData.locked and otherData.id ~= otherCurrent then
      patchData.headFrame = otherData.id
    end
  elseif index == m_enumHeadFrame then
    patchData.headFrame = data.id
    otherData = m_currentHeadPhoto
    otherCurrent = this:GetData("PlayerHeadPhoto")
    if not otherData.locked and otherData.id ~= otherCurrent then
      patchData.headPhoto = otherData.id
    end
  end
  if patchData.headPhoto ~= nil and patchData.headPhoto == 0 then
    patchData.headPhoto = -1
  end
  if patchData.headFrame ~= nil and patchData.headFrame == 0 then
    patchData.headFrame = -1
  end
  
  function m_frameCallBack()
    this:GameRequest("fci/playerpageinfo/"):Patch(patchData, SetHeadCallback)
  end
end

function SetHeadCallback(result)
  this:SetData("Space/SelectedPlayer", result)
  if this:GetData("PlayerHeadPhoto") ~= result.headPhoto then
    this:SetData("PlayerHeadPhoto", result.headPhoto)
  end
  if this:GetData("PlayerHeadFrame") ~= result.headFrame then
    this:SetData("PlayerHeadFrame", result.headFrame)
  end
  local baseInfo = this:GetData("fci/baseinfo/")
  baseInfo.headPhoto = result.headPhoto
  baseInfo.headFrame = result.headFrame
  this:SetData("fci/baseinfo/", baseInfo)
  WU.RecycleWindow(this)
end

function FrameSetCallBack()
  if m_frameCallBack ~= nil then
    m_frameCallBack()
  end
end

function SetCurrentData(data, index)
  if index == m_enumHeadBox then
    m_currentHeadPhoto = data
  elseif index == m_enumHeadFrame then
    m_currentHeadFrame = data
  end
end
