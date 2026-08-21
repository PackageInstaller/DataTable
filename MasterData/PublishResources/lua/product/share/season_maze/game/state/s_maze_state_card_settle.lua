require("s_maze_state_base")
_class("SMazeState_CardSettle", SMazeStateBase)
SMazeState_CardSettle = SMazeState_CardSettle

function SMazeState_CardSettle:OnEnter(card)
  self:StartTask(self._SettleTask, self, card)
end

function SMazeState_CardSettle:OnExit()
end

function SMazeState_CardSettle:_SettleTask(TT, card)
  local cpt = self._manager:GetMazeComponent()
  local res = AsyncRequestRes:New()
  self:Lock("SMazeState_CardSettle:_SettleTask")
  cpt:HandleSeasonMazeChooseHand(TT, res, card:ID())
  self:UnLock("SMazeState_CardSettle:_SettleTask")
  if not self._valid then
    return
  end
  if res:GetSucc() then
    local points = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
    card:SetData(cpt:GetComponentInfo().cur_hand, points)
    self:_Log("卡牌结算完成 行动力:", card:ActPoint())
    card:PlayCard(TT)
    local asset = card:AwardAsset()
    if asset then
      if asset:Type() == SeasonMazeEffectType.SMET_Pro then
        local attrId = asset:SubParam()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, attrId)
      end
      if asset:Type() == SeasonMazeEffectType.SMET_Bead then
        self:Lock("SMazeState_CardSettle:SettleSuccess")
        local ids = {}
        local effects = cpt:GetComponentInfo().cur_hand.effct
        if effects then
          for _, effect in ipairs(effects) do
            if effect.type == SeasonMazeEffectType.SMET_Bead then
              table.insert(ids, effect.id)
            end
          end
        end
        local isWait = true
        self:ShowDialog("UISeasonMazeBeadRewards", ids, function()
          isWait = false
        end)
        self:UnLock("SMazeState_CardSettle:SettleSuccess")
        while isWait do
          YIELD(TT)
          if not self._valid then
            return
          end
        end
      end
      if not self._valid then
        return
      end
      local goldCount = 0
      if asset:Type() == SeasonMazeEffectType.SMET_Pro and asset:SubParam() == SeasonMazeAttrType.SMAT_Gold then
        goldCount = goldCount + asset:Count()
      end
      if 0 < goldCount then
        self._manager:PlayGetGold(TT, goldCount)
      end
      self:PlayAssetToast(TT, {asset})
    else
      self:Lock("SMazeState_CardSettle:SettleSuccess")
      YIELD(TT, 1173)
      self:UnLock("SMazeState_CardSettle:SettleSuccess")
      if not self._valid then
        return
      end
      self:_Log("卡牌无特殊效果:", card:ID())
    end
    if not self._valid then
      return
    end
    local uiSeasonMazeScene = GameGlobal.UIStateManager():GetController("UISeasonMazeScene")
    if uiSeasonMazeScene then
      uiSeasonMazeScene:ShowCard(nil, true)
      uiSeasonMazeScene:HideActiveItemTip()
    end
    if cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
      self:_Log("行动卡结算完升级了")
      self._machine:ChangeStateTo(SMazeState_Levelup)
      return
    else
      self._machine:ChangeStateTo(SMazeState_PlayerMove, card:ActPoint())
      return
    end
  else
    self:_LogError("卡牌结算失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end
