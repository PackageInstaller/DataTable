_class("UIHomelandMovieSaveName", UIController)
UIHomelandMovieSaveName = UIHomelandMovieSaveName

function UIHomelandMovieSaveName:OnShow(uiParams)
  self:InitWidget()
  self.roomName.text = ""
  self._maxChar = 14
  self._homelandModule = self:GetModule(HomelandModule)
  self._pstId = MoviePrepareData:GetInstance():GetPstId()
  self._movieId = MoviePrepareData:GetInstance():GetMovieId()
end

function UIHomelandMovieSaveName:InitWidget()
  self.roomName = self:GetUIComponent("EmojiFilteredInputField", "roomName")
  
  function self.OnIptValueChanged()
    local s = self.roomName.text
    if string.isnullorempty(s) then
      return
    end
    local len = #s
    local curIdx = 1
    local asciiCount = 0
    while len >= curIdx do
      local c = string.byte(s, curIdx, curIdx)
      local charSize = self:GetCharSize(c)
      if charSize == 1 then
        if asciiCount + 1 > self._maxChar then
          break
        end
        asciiCount = asciiCount + 1
      elseif 1 < charSize then
        if asciiCount + 2 > self._maxChar then
          break
        end
        asciiCount = asciiCount + 2
      end
      local tmp = string.sub(s, curIdx, curIdx + charSize - 1)
      curIdx = curIdx + charSize
    end
    self.roomName.text = string.sub(s, 1, curIdx - 1)
  end
  
  self.roomName.onValueChanged:AddListener(self.OnIptValueChanged)
end

function UIHomelandMovieSaveName:GetCharSize(char)
  if not char then
    return 0
  elseif 240 < char then
    return 4
  elseif 225 < char then
    return 3
  elseif 192 < char then
    return 2
  else
    return 1
  end
end

function UIHomelandMovieSaveName:bgOnClick(go)
  self:CloseDialog()
end

function UIHomelandMovieSaveName:btnCancelOnClick(go)
  self:CloseDialog()
end

function UIHomelandMovieSaveName:btnEnsureOnClick(go)
  self:StartTask(self.change, self)
end

function UIHomelandMovieSaveName:change(TT)
  local str = self.roomName.text
  if string.isnullorempty(str) then
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_name_tips_empty"))
    return
  end
  local length = HelperProxy:GetInstance():GetCharLength(str)
  if length > self._maxChar then
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_name_tips_toolong"))
    return
  end
  local res = self._homelandModule:HandleSubmitRecordName(TT, self._pstId, str)
  if res:GetSucc() then
    self:SaveMovieName()
  else
    local errorCode = res:GetResult()
    Log.fatal("###domitory - RequestChangeName fail ! result - ", errorCode)
    if errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_LIMIT then
      ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_name_tips_toolong"))
    elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_DIRTY_NICK then
      ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_name_tips_banword"))
    elseif errorCode == ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_INVALID then
      ToastManager.ShowToast(StringTable.Get("str_movie_save_name_tips_specialchar"))
    else
      ToastManager.ShowHomeToast(res:GetResult())
    end
  end
end

function UIHomelandMovieSaveName:SaveMovieName()
  local movieId = MoviePrepareData:GetInstance():GetMovieId()
  local records = MovieDataManager:GetInstance():GetMovieHistoryDataByID(movieId)
  local recordCount = table.count(records)
  if recordCount == 3 then
    self:ShowDialog("UIHomelandMovieSaveReplaceController", records)
    self:CloseDialog()
  else
    self:Lock("UIHomelandMovieSaveName_SaveMovieName")
    MovieDataManager:GetInstance():SaveRecordData(0, function()
      self:UnLock("UIHomelandMovieSaveName_SaveMovieName")
      self:CloseDialog()
      ToastManager.ShowHomeToast(StringTable.Get("str_movie_save_success_tip"))
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMovieSaved)
    end)
  end
end
