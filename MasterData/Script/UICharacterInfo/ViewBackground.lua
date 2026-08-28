local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local module = {
  Load = function(self, skinId, isSkin)
    local portraitId = DataModel.RoleData.current_skin[1]
    if skinId then
      portraitId = skinId
    end
    if portraitId == nil or portraitId == 0 then
      local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
      portraitId = DataModel.RoleCA.viewId
    end
    View.Group_Middle.SpineAnimation_Character:SetActive(false)
    View.Group_Middle.SpineSecondMode_Character:SetActive(false)
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
    DataModel.live2D = live2D
    local isSpine2 = false
    local isVideo = portrailData.videoSpine and live2D == 0 and portrailData.videoPath ~= ""
    if isVideo then
      View.Group_Middle.Video_Character:SetActive(true)
      local resPath = portrailData.videoPath
      if portrailData.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        resPath = portrailData.videoFemale
      end
      View.Group_Middle.Video_Character:Play(resPath, true, false, false)
      View.Group_Middle.Video_Character:SetAnchoredPosition(Vector2(portrailData.videoX, portrailData.videoY))
      View.Group_Middle.Video_Character:SetLocalScale(Vector3.one * portrailData.videoScale)
    else
      View.Group_Middle.Video_Character:SetActive(false)
      if portrailData.spineUrl ~= "" or portrailData.spine2Url ~= "" then
        View.Group_Middle.Group_Character.self:SetActive(false)
        View.Group_Middle.SpineAnimation_Character:SetActive(true)
        local spineUrl = portrailData.spineUrl
        local state = false
        if DataModel.RoleData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" and DataModel.RoleData.current_skin[2] == 1 then
          state = true
        end
        if isSkin ~= nil then
          state = isSkin
        end
        if state == true then
          spineUrl = portrailData.spine2Url
          isSpine2 = true
        end
        View.Group_Middle.SpineAnimation_Character:SetActive(not isSpine2)
        View.Group_Middle.SpineSecondMode_Character:SetActive(isSpine2)
        View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
        if live2D == 1 then
          View.Group_Middle.SpineAnimation_Character:SetActive(false)
          View.Group_Middle.SpineSecondMode_Character:SetActive(false)
          View.Group_Middle.Group_Character.self:SetActive(true)
          if isSpine2 == true then
            View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.State2Res)
          else
            local resPath = portrailData.resUrl
            if portrailData.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
              resPath = portrailData.pngFemale
            end
            View.Group_Middle.Group_Character.Img_Character:SetSprite(resPath)
          end
          View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
          DataModel.InfoInitPos.isRecord = true
          if DataModel.InfoInitPos.isRecord then
            DataModel.InfoInitPos.isRecord = false
            local transform = View.Group_Middle.transform
            View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
            DataModel.InfoInitPos.y = transform.localPosition.y
            DataModel.InfoInitPos.scale = transform.localScale.x
          end
          DataModel.InfoInitPos.offsetX = portrailData.offsetX
          DataModel.InfoInitPos.offsetY = portrailData.offsetY
        elseif isSpine2 then
          View.Group_Middle.SpineSecondMode_Character:SetPrefab(spineUrl)
          View.Group_Middle.SpineAnimation_Character:SetData("")
          local spine2X = portrailData.spine2X
          local spine2Y = portrailData.spine2Y
          if portrailData.moveBoolen then
            spine2X = -275 + portrailData.spineX + portrailData.spine2X
            spine2Y = -1200 + portrailData.spineY + portrailData.spine2Y
          end
          View.Group_Middle.SpineSecondMode_Character.transform.localPosition = Vector3(spine2X, spine2Y, 0)
          if portrailData.state2Overturn == true then
            View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
          end
        else
          if portrailData.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
            spineUrl = portrailData.spineFemale
          end
          View.Group_Middle.SpineAnimation_Character:SetActive(true)
          View.Group_Middle.SpineSecondMode_Character:SetPrefab("")
          View.Group_Middle.SpineAnimation_Character:SetData(spineUrl)
          View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
          local spineX = -275 + portrailData.spineX
          local spineY = -1200 + portrailData.spineY
          if portrailData.moveBoolen then
            spineX = spineX + portrailData.spine2X
            spineY = spineY + portrailData.spine2Y
          end
          View.Group_Middle.SpineAnimation_Character.transform.localPosition = Vector3(spineX, spineY, 0)
        end
      else
        View.Group_Middle.SpineAnimation_Character:SetActive(false)
        View.Group_Middle.Group_Character.self:SetActive(true)
        local resPath = portrailData.resUrl
        if portrailData.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
          resPath = portrailData.pngFemale
        end
        View.Group_Middle.Group_Character.Img_Character:SetSprite(resPath)
        View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
        if DataModel.InfoInitPos.isRecord then
          DataModel.InfoInitPos.isRecord = false
          local transform = View.Group_Middle.transform
          View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
          DataModel.InfoInitPos.y = transform.localPosition.y
          DataModel.InfoInitPos.scale = transform.localScale.x
        end
        DataModel.InfoInitPos.offsetX = portrailData.offsetX
        DataModel.InfoInitPos.offsetY = portrailData.offsetY
      end
      if DataModel.InfoInitPos.isRecord == false then
        local pos = DataModel.InfoInitPos
        local posX = pos.x + portrailData.offsetX * pos.scale
        local posY = pos.y + portrailData.offsetY * pos.scale
        local imgX = -275 + portrailData.offsetX
        local imgY = portrailData.offsetY
        if portrailData.moveBoolen then
          imgX = imgX + portrailData.offsetX2
          imgY = imgY + portrailData.offsetY2
        end
        View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(imgX, imgY, 0))
        View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(portrailData.offsetScale, portrailData.offsetScale, portrailData.offsetScale))
        if isSpine2 == true then
          posX = pos.x + portrailData.offsetX2 * pos.scale
          posY = pos.y + portrailData.offsetY2 * pos.scale
          View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(1, 1, 1))
          local img2X = portrailData.offsetX2
          local img2Y = portrailData.offsetY2
          if portrailData.moveBoolen then
            img2X = -275 + portrailData.offsetX + portrailData.offsetX2
            img2Y = portrailData.offsetY + portrailData.offsetY2
          end
          View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(img2X, img2Y, 0))
        end
      end
    end
    View.Group_Middle.Group_Mask.self:SetActive(portrailData.videoSpine or isSpine2 or portrailData.moveBoolen)
    DataModel.NowSkin = {}
    DataModel.NowSkin.portraitId = tonumber(portraitId)
    DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
    DataModel.isVideo = isVideo
    DataModel.LoadSpineBg()
  end
}
return module
