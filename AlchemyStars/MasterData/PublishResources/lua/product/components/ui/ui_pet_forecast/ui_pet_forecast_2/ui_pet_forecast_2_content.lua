require("ui_side_enter_center_content_base")
_class("UIPetForecast2Content", UISideEnterCenterContentBase)
UIPetForecast2Content = UIPetForecast2Content

function UIPetForecast2Content:DoInit(params)
  self:GetGameObject("CloseBtn"):SetActive(self._type == ESideEnterContentType.Single)
end

function UIPetForecast2Content:DoShow()
  self._dataLoader = UIPetForecastDataLoader:New()
  self.data = self._data
  self.atlas = self:GetAsset("UIPetForecast.spriteatlas", LoadType.SpriteAtlas)
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self.pieces = self:GetUIComponent("UISelectObjectPath", "pieces")
  self.sv = self:GetUIComponent("ScrollRect", "sv")
  self.imgLeftTime = self:GetUIComponent("Image", "imgLeftTime")
  self.imgClock = self:GetUIComponent("Image", "imgClock")
  self.txtLeftTimeHint = self:GetUIComponent("UILocalizationText", "txtLeftTimeHint")
  self.txtLeftTime = self:GetUIComponent("UILocalizationText", "txtLeftTime")
  local s = self:GetUIComponent("UISelectObjectPath", "tips")
  self._tips = s:SpawnObject("UISelectInfo")
  self.imgTitle = self:GetUIComponent("RawImageLoader", "imgTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.goSentence = self:GetGameObject("imgSentence")
  self.imgSentence = self:GetUIComponent("RawImageLoader", "imgSentence")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
  self.pieces:SpawnObjects("UIPetForecastItem2", table.count(self.data.pieces))
  self.pieceList = self.pieces:GetAllSpawnList()
  self.te = UIActivityHelper.StartTimerEvent(self.te, function()
    self:FlushLeftTime()
  end)
  self.curSelectDay = 0
  self:Flush()
end

function UIPetForecast2Content:DoHide()
  self.te = UIActivityHelper.CancelTimerEvent(self.te)
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.RolePropertyChanged, self.ItemCountChanged)
  self.imgTitle:DestoryLastImage()
  self._bg:DestoryLastImage()
end

function UIPetForecast2Content:DoDestroy()
end

function UIPetForecast2Content:RequestPrediction(TT)
  local lockName = "UIPetForecast2Content_RequestPrediction"
  self:Lock(lockName)
  self._data = self._dataLoader:LoadData(TT)
  self:Flush()
  self:UnLock(lockName)
end

function UIPetForecast2Content:Flush()
  if not self.data then
    Log.warn("### self.data nil.")
    return
  end
  self:FlushLeftTimeColor()
  self:FlushLeftTime()
  self.txtDesc:SetText(StringTable.Get("str_prediction_info_" .. self.data.id))
  self:FlushDesc()
  self.imgTitle:LoadImage(self.data.imgTitle)
  self._bg:LoadImage(self.data:GetBG())
  self:FlushPieces()
end

function UIPetForecast2Content:FlushPieces()
  local len = table.count(self.data.pieces)
  for i, v in ipairs(self.pieceList) do
    v:Flush(i, function(day)
      local piece = self.data.pieces[day]
      if not piece or piece.state ~= PredictionStatus.PRES_Accepted then
        return
      end
      if day < 1 or day > len then
        Log.fatal("### invalid param. day = ", day)
        return
      end
      if self.pieceList[self.curSelectDay] then
        self.pieceList[self.curSelectDay]:Select(false)
      end
      if self.curSelectDay == day then
        self.curSelectDay = 0
        self:FlushDesc()
      else
        self.pieceList[day]:Select(true)
        self.curSelectDay = day
        self:FlushDesc()
      end
    end)
  end
end

function UIPetForecast2Content:FlushLeftTimeColor()
  local colorBG, colorHint, color = self.data:GetLeftTimeColor()
  self.imgLeftTime.color = colorBG
  self.imgClock.color = colorHint
  self.txtLeftTimeHint.color = colorHint
  self.txtLeftTime.color = color
end

function UIPetForecast2Content:FlushLeftTime()
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < self.data.endTime then
    local leftSeconds = UICommonHelper.CalcLeftSeconds(self.data.endTime)
    local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
    if 1 <= d then
      self.txtLeftTime:SetText(StringTable.Get("str_prediction_left_time_d_h", math.floor(d), math.floor(h)))
    elseif 1 <= h then
      self.txtLeftTime:SetText(StringTable.Get("str_prediction_left_time_h_m", math.floor(h), math.floor(m)))
    elseif 1 <= m then
      self.txtLeftTime:SetText(StringTable.Get("str_prediction_left_time_m", math.floor(m)))
    else
      self.txtLeftTime:SetText(StringTable.Get("str_prediction_left_time_m", "<" .. 1))
    end
  else
    self.txtLeftTime:SetText(StringTable.Get("str_prediction_error_code_1"))
    UIActivityHelper.CancelTimerEvent(self.te)
  end
end

function UIPetForecast2Content:FlushDesc()
  if self.curSelectDay == 0 then
    self.goSentence:SetActive(false)
  else
    self.goSentence:SetActive(true)
    local piece = self.data.pieces[self.curSelectDay]
    self.imgSentence:LoadImage(piece.imgSentence)
  end
end

function UIPetForecast2Content:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIPetForecast2Content:CloseBtnOnClick(go)
  self:CloseDialog(true)
end

function UIPetForecast2Content:ItemCountChanged()
  self:StartTask(self.RequestPrediction, self)
end
