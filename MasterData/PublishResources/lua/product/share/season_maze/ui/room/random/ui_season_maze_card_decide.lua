_class("UISeasonMazeCardDecide", UIController)
UISeasonMazeCardDecide = UISeasonMazeCardDecide

function UISeasonMazeCardDecide:OnShow(uiParams)
  self:InitWidget()
  self.cardList = uiParams[1]
  self.point = uiParams[2]
  self.callback = uiParams[3]
  self:OnValue()
end

function UISeasonMazeCardDecide:InitWidget()
  self.lten = self:GetUIComponent("Image", "lten")
  self.lone = self:GetUIComponent("Image", "lone")
  self.rten = self:GetUIComponent("Image", "rten")
  self.rone = self:GetUIComponent("Image", "rone")
  self.cardpool = self:GetUIComponent("UISelectObjectPath", "cardpool")
  self.text = self:GetUIComponent("UILocalizationText", "text")
  self.colorImg = self:GetUIComponent("Image", "colorImg")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self.leftImageStr = "cn14_sjmj_pd_hzi0"
  self.rightImageBlueStr = "cn14_sjmj_pd_lzi0"
  self.rightImageRedStr = "cn14_sjmj_pd_rzi0"
end

function UISeasonMazeCardDecide:OnValue()
  if self.cardList then
    local totalPoint = 0
    self.cardpool:SpawnObjects("UISeasonMazeCardItem", #self.cardList)
    self.cardPoolList = self.cardpool:GetAllSpawnList()
    for i = 1, #self.cardList do
      local card = self.cardList[i]
      self.cardPoolList[i]:SetData(i, card.id)
      local Cfg = Cfg.cfg_component_season_maze_hand[card.id]
      if Cfg then
        local max = card.steps
        totalPoint = totalPoint + max
      else
        Log.exception("存在空的卡牌id", card.id)
      end
      self.cardPoolList[i]:RootAlpha(0)
    end
    self.point = self.point + 1
    local success = totalPoint >= self.point
    local lt = self.point // 10
    local lo = self.point % 10
    self.lten.gameObject:SetActive(lt ~= 0)
    self.lten.sprite = self.atlas:GetSprite(self.leftImageStr .. lt)
    self.lone.sprite = self.atlas:GetSprite(self.leftImageStr .. lo)
    local rt = totalPoint // 10
    local ro = totalPoint % 10
    self.rten.gameObject:SetActive(rt ~= 0)
    local str = success and self.rightImageBlueStr or self.rightImageRedStr
    self.rten.sprite = self.atlas:GetSprite(str .. rt)
    self.rone.sprite = self.atlas:GetSprite(str .. ro)
    local colorSpr = success and "cn14_sjmj_pd_di03" or "cn14_sjmj_pd_di02"
    self.colorImg.sprite = self.atlas:GetSprite(colorSpr)
    local titleStr = success and "str_season_maze_decide_win" or "str_season_maze_decide_lose"
    self.text:SetText(StringTable.Get(titleStr))
    self:StartTask(self.ShowAnim, self, success)
  else
    Log.exception("参数没有卡牌数据")
  end
end

function UISeasonMazeCardDecide:ShowAnim(TT, success)
  for i = 1, #self.cardList do
    self.cardPoolList[i]:RootAlpha(1)
    self.cardPoolList[i]:PlayAnim("uieff_UISeasonMazeCardItem_in")
    YIELD(TT, 20)
  end
  YIELD(TT, 500)
  for i = 1, #self.cardList do
    self.cardPoolList[i]:PlayAnim("uieff_UISeasonMazeCardItem_sprint")
    YIELD(TT, 100)
  end
  local animStr = success and "uieff_UISeasonMazeCardDecide_win" or "uieff_UISeasonMazeCardDecide_fail"
  self.anim:Play(animStr)
  YIELD(TT, 2500)
  if self.callback then
    self.callback()
  end
  self:CloseDialog()
end
