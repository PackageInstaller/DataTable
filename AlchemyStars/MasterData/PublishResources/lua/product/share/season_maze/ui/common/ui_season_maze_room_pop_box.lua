_class("UISeasonMazeRoomPopBox", UIController)
UISeasonMazeRoomPopBox = UISeasonMazeRoomPopBox

function UISeasonMazeRoomPopBox:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomPopBox:OnShow(uiParams)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._type = uiParams[1]
  self._callBack = uiParams[2]
  self._asset = uiParams[3]
  self:InitWidget()
  self:_OnValue()
end

function UISeasonMazeRoomPopBox:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._emptyGO = self:GetGameObject("Empty")
  self._roundGO = self:GetGameObject("Round")
  self._roundImg = self:GetUIComponent("Image", "RoundImg")
  self._roundDesc = self:GetUIComponent("UILocalizationText", "RoundDesc")
  self._resourceGO = self:GetGameObject("Resource")
  self._resourceLeftValue = self:GetUIComponent("UILocalizationText", "ResourceLeftValue")
  self._resourceRightImg = self:GetUIComponent("Image", "ResourceRightImg")
  self._resourceRightValue = self:GetUIComponent("UILocalizationText", "ResourceRightValue")
  self._emptyGO:SetActive(false)
  self._roundGO:SetActive(false)
  self._resourceGO:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "UISeasonMazeRoomPopBox")
  self._resourceTitle = self:GetUIComponent("UILocalizationText", "ResourceTitle")
end

function UISeasonMazeRoomPopBox:_OnValue()
  local str
  if self._type == SeasonMazeRoomType.SMRT_Empty then
    str = "str_season_maze_room_name_empty"
    self._emptyGO:SetActive(true)
  elseif self._type == SeasonMazeRoomType.SMRT_Round then
    str = "str_season_maze_room_name_round"
    local value = self._asset.value_min
    self._roundImg.sprite = self._atlas:GetSprite("cn14_sjmj_pd_lzi0" .. value)
    self._roundDesc:SetText(StringTable.Get("str_season_maze_room_common_round", value))
    self._roundGO:SetActive(true)
  elseif self._type == SeasonMazeRoomType.SMRT_Resource then
    str = "str_season_maze_resource_room_title"
    local step = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
    self._resourceLeftValue:SetText(step)
    local spriteName = ""
    local titleStr = ""
    if self._asset.type == SeasonMazeEffectType.SMET_Pro then
      if self._asset.id == SeasonMazeAttrType.SMAT_Gold then
        spriteName = "cn14_sjmj_kdroom_icon01"
        titleStr = "str_season_maze_room_resource_title1"
      elseif self._asset.id == SeasonMazeAttrType.SMAT_Exp then
        spriteName = "cn14_sjmj_kdroom_icon02"
        titleStr = "str_season_maze_room_resource_title2"
      end
    elseif self._asset.type == SeasonMazeEffectType.SMET_Bead then
      spriteName = "cn14_sjmj_kdroom_icon03"
      titleStr = "str_season_maze_room_resource_title3"
    end
    self._resourceRightImg.sprite = self._atlas:GetSprite(spriteName)
    self._resourceRightValue:SetText(self._asset.value_min)
    self._resourceTitle:SetText(StringTable.Get(titleStr))
    self._resourceGO:SetActive(true)
  end
  if str then
    str = StringTable.Get(str)
  else
    str = ""
  end
  self._title:SetText(str)
  self:Lock("uieffanim_UISeasonMazeRoomPopBox_in")
  self._anim:Play("uieffanim_UISeasonMazeRoomPopBox_in")
  self._timer = GameGlobal.Timer():AddEvent(1600, function()
    self:UnLock("uieffanim_UISeasonMazeRoomPopBox_in")
  end)
end

function UISeasonMazeRoomPopBox:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:UnLock("uieffanim_UISeasonMazeRoomPopBox_out")
  self:UnLock("uieffanim_UISeasonMazeRoomPopBox_in")
end

function UISeasonMazeRoomPopBox:CloseBtnOnClick(go)
  self:Lock("uieffanim_UISeasonMazeRoomPopBox_out")
  self._anim:Play("uieffanim_UISeasonMazeRoomPopBox_out")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(333, function()
    self:UnLock("uieffanim_UISeasonMazeRoomPopBox_out")
    self:CloseDialog()
    if self._callBack then
      self._callBack()
    end
  end)
end
