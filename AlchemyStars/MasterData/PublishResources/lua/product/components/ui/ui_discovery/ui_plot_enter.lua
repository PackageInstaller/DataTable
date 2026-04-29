_class("UIPlotEnter", UIController)
UIPlotEnter = UIPlotEnter

function UIPlotEnter:OnShow(uiParam)
  local node = uiParam[1]
  self._stage = uiParam[2]
  local chapterid = uiParam[3]
  self._module = self:GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  local txtStageIdx = self:GetUIComponent("UILocalizationText", "txtStageIdx")
  local txtStageNameTex = self:GetUIComponent("UILocalizationText", "txtStageName")
  local txtStageName = self:GetUIComponent("RollingText", "txtStageName")
  txtStageIdx.text = node.name or ""
  txtStageName:RefreshText(self._stage.name or "")
  local img = self:GetUIComponent("Image", "imgBG")
  self._atlas = self:GetAsset("UIDiscovery.spriteatlas", LoadType.SpriteAtlas)
  local sprite, texColor, descColor
  local discoverySection = self._data:GetDiscoverySectionByChapterId(chapterid)
  self._isBetween = discoverySection.isBetween
  if not self._isBetween then
    sprite = "map_juqing_di1"
    texColor = Color(0.17254901960784313, 0.17254901960784313, 0.17254901960784313, 1)
    descColor = Color(0.3843137254901961, 0.3843137254901961, 0.3843137254901961, 1)
  else
    sprite = "map_juqing_icon1"
    texColor = Color(0.611764705882353, 0.45098039215686275, 0.7254901960784313, 1)
    descColor = Color(0.6392156862745098, 0.6196078431372549, 0.6666666666666666, 1)
  end
  txtStageIdx.color = texColor
  txtStageNameTex.color = descColor
  img.sprite = self._atlas:GetSprite(sprite)
end

function UIPlotEnter:OnHide()
end

function UIPlotEnter:EnterPlot()
  local story = self._data:GetStoryByStageIdStoryType(self._stage.id, StoryTriggerType.Node)
  if not story then
    Log.error("### [UIPlotEnter] no story in stage:", self._stage.id)
    return
  end
  self:ShowDialog("UIStoryController", story.id, function()
    local isActive = self._module:IsPassMissionID(self._stage.id)
    if isActive then
      return
    end
    self:StartTask(function(TT)
      self._module:SetMissionStoryActive(TT, self._stage.id, ActiveStoryType.ActiveStoryType_BeforeBattle)
      local ret, award = self._module:CompleteStoryMission(TT, self._stage.id)
      if ret == MISSION_RESULT_CODE.MISSION_SUCCEED then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryFlushLines)
        self:ShowDialog("UIGetItemController", award, function()
          local trigger = false
          GameGlobal.EventDispatcher():Dispatch(GameEventType.GuidePlotEnterFinish, self._stage.id, function(_trigger)
            trigger = _trigger
          end)
          if not trigger then
          end
          GameGlobal.EventDispatcher():Dispatch(GameEventType.CheckPartUnlock)
        end)
      else
        ToastManager.ShowToast(self._module:GetErrorMsg(ret))
      end
    end, self)
  end)
  self:CloseDialog()
end

function UIPlotEnter:imgBGOnClick(go)
  self:EnterPlot()
end

function UIPlotEnter:btnEnterOnClick(go)
  self:EnterPlot()
end

function UIPlotEnter:bgOnClick(go)
  self:CloseDialog()
end
