require("s_maze_state_base")
_class("SMazeState_PlayCard", SMazeStateBase)
SMazeState_PlayCard = SMazeState_PlayCard

function SMazeState_PlayCard:OnEnter(node, needRequest)
  local cpt = self._manager:GetMazeComponent()
  local props = cpt:GetComponentInfo().m_bag_info.once_item_list
  self._props = {}
  for propid, count in pairs(props) do
    self._props[propid] = self._manager:Factory():CreateProp(propid, count)
  end
  self._node = node
  self._previewNodes = nil
  self._previewCard = nil
  self:_Log("开始选卡状态:", needRequest)
  self:StartTask(self._RandomCards, self, needRequest)
end

function SMazeState_PlayCard:OnExit()
end

function SMazeState_PlayCard:_RandomCards(TT, needRequest)
  local cpt = self._manager:GetMazeComponent()
  local cptInfo = cpt:GetComponentInfo()
  local cards
  if needRequest then
    self:_Log("请求随机卡牌")
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    self:Lock("SMazeState_PlayCard:_RandomCards")
    cpt:HandleSeasonMazeRandomHand(TT, res)
    self:UnLock("SMazeState_PlayCard:_RandomCards")
    if res:GetSucc() then
      cards = cptInfo.rand_hands
    else
      self:_LogError("请求随机卡牌失败:", res:GetResult())
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
    end
  else
    self:_Log("恢复选择卡牌状态 无需请求随机")
    cards = cptInfo.rand_hands
    if not cards or #cards == 0 then
      self:_LogError("无需请求随机 但是当前没有卡牌")
    end
  end
  if not self._manager then
    return
  end
  self._cards = {}
  local idList = {}
  for idx, id in ipairs(cards) do
    local card = self._manager:Factory():CreateCard(id)
    self._cards[id] = card
    idList[idx] = id
  end
  local uiSeasonMazeScene = GameGlobal.UIStateManager():GetController("UISeasonMazeScene")
  if uiSeasonMazeScene then
    uiSeasonMazeScene:ShowCard(idList)
  end
  local pastHand = cpt:GetComponentInfo().past_hand
  if pastHand and 0 < #pastHand and not GameGlobal.GetModule(GuideModule):IsGuideDone(900105) then
    self:Lock("SMazeState_PlayCard_ForGuide")
    self:StartTask(function(TT)
      YIELD(TT, 600)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeScene_2rd)
      self:UnLock("SMazeState_PlayCard_ForGuide")
    end)
  end
end

function SMazeState_PlayCard:PlayCard(id)
  local card = self._cards[id]
  if not card then
    self:_LogError("选择的卡牌不在列表中:", id)
  end
  self:_Log("选择卡牌 开始结算:", id)
  self:_TryCancelPreview()
  self._previewCard = nil
  self._machine:ChangeStateTo(SMazeState_CardSettle, card)
end

function SMazeState_PlayCard:UseProp(id)
  local prop = self._props[id]
  if not prop then
    self:_LogError("无此道具 不可以使用:", id)
  end
  if prop:Type() == SeasonMazeEffectType.SMET_Once_Bomb then
    self:_UseBomb(prop)
  else
    self:StartTask(self._UsePropTask, self, prop)
  end
  local ctl = GameGlobal.UIStateManager():GetController("UISeasonMazeScene")
  ctl:ReSetCards()
  self:_TryCancelPreview()
end

function SMazeState_PlayCard:_UseBomb(bombProp)
  self:_Log("使用炸弹:", bombProp:ID())
  self._curBomb = bombProp
  self._manager:StartSelectBombTarget()
end

function SMazeState_PlayCard:SelectBombTarget(node)
  self:_Log("选择炸弹目标:", node:ID())
  self._curBomb:SetTarget(node)
  self._manager:SelectBombTarget(node)
end

function SMazeState_PlayCard:CancelUseBomb()
  self:_Log("取消使用炸弹")
  self._curBomb:SetTarget(nil)
  self._curBomb = nil
  self._manager:CancelSelectBombTarget()
end

function SMazeState_PlayCard:ConfirmUseBomb()
  self._manager:CancelSelectBombTarget()
  self:StartTask(self._UsePropTask, self, self._curBomb)
  self._curBomb = nil
end

function SMazeState_PlayCard:_UsePropTask(TT, prop)
  self._manager:Lock("SMazeState_PlayCard.UseProp")
  local succ = prop:Use(TT)
  self._manager:UnLock("SMazeState_PlayCard.UseProp")
  if not succ then
    self:_LogError("道具使用失败")
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeItemUseEnd, prop:Type())
  if prop:Type() == SeasonMazeEffectType.SMET_Once_Retrun then
    local id = self._manager:GetMazeComponent():GetComponentInfo().cur_point
    local finalNode = self._manager:MapManager():GetNode(id)
    if finalNode:Room():Type() ~= SeasonMazeRoomType.SMRT_Camp then
      self:_LogError("最终路点不是营地:", finalNode:Room():Type())
    end
    
    local function changePos()
      self._machine:SetCurNode(finalNode)
      self._manager:Player():SetPos(finalNode:Position())
      self._manager:Player():MoveFollowerImmidiately()
      self._manager:SeasonMazeCameraManager():SeasonCamera():Focus(finalNode:Position())
      self._manager:SeasonMazeCameraManager():SeasonCamera():ChangePos(finalNode:Position())
      self._manager:MapManager():RefreshLinkState(finalNode:ID(), SMazeNodeState.StayTemp)
    end
    
    self:Lock("MovePlayerToCampPoint")
    local tl = self:_TransformPosEffect(changePos)
    while not tl:Over() do
      YIELD(TT)
    end
    self:UnLock("MovePlayerToCampPoint")
    if not self._valid then
      return
    end
    self:_TryCancelPreview()
    self._machine:ChangeStateTo(SMazeState_RoomSettle, finalNode, false)
    return
  elseif prop:Type() == SeasonMazeEffectType.SMET_Once_Shoe then
    if self._previewCard then
      self:PreviewTargetNode(self._previewCard, true)
    end
  elseif prop:Type() == SeasonMazeEffectType.SMET_Once_Sprint then
    local cpt = self._manager:GetMazeComponent()
    local points = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Round_Step_All)
    self:_TryCancelPreview()
    self:_Log("使用冲刺道具 行动力:", points)
    self._machine:ChangeStateTo(SMazeState_PlayerMove, points)
    return
  elseif prop:Type() == SeasonMazeEffectType.SMET_Once_Bomb then
    local cpt = self._manager:GetMazeComponent()
    if cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
      self:_TryCancelPreview()
      self:_Log("炸完升级了")
      self._machine:ChangeStateTo(SMazeState_Levelup)
      return
    elseif cpt:CurOperate() == SeasonMazeActionState.SMAS_Relic then
      self:_TryCancelPreview()
      self:_Log("炸完选圣物")
      self._machine:ChangeStateTo(SMazeState_ChooseRelic)
      return
    end
    self:PlayAssetToast(TT, bomb:RewardAsset())
  end
end

function SMazeState_PlayCard:PreviewTargetNode(id, preview)
  if not preview then
    self:_TryCancelPreview()
    return
  end
  self._previewCard = id
  local card = self._cards[id]
  local min, max = card:CfgActPoint()
  if min ~= max then
    self:_Log("卡牌行动力是随机的 不能预览目标点:", id)
    self:_TryCancelPreview()
    return
  end
  local actPoint = min
  if card:CopyedCard() then
    local cptInfo = self._manager:GetMazeComponent():GetComponentInfo()
    if #cptInfo.past_hand > 0 and 0 < cptInfo.past_hand[#cptInfo.past_hand].steps then
      local lastCardStep = cptInfo.past_hand[#cptInfo.past_hand]
      actPoint = lastCardStep.steps
    else
      actPoint = 1
    end
    self:_Log("预览复制牌:", actPoint)
  end
  local cpt = self._manager:GetMazeComponent()
  local bootStep = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_OnceShoesCnt)
  actPoint = actPoint + bootStep
  
  local function search(node, results, count)
    if node:Room():Type() == SeasonMazeRoomType.SMRT_Camp then
      results[node:ID()] = node
      return
    end
    if node:ForceSettle() and self:GetNodeState(node) < SeasonMazePointStateType.SMPST_Choose then
      results[node:ID()] = node
      return
    end
    if count <= 0 then
      results[node:ID()] = node
      return
    end
    if not node:NextPoints() or #node:NextPoints() == 0 then
      return
    end
    for _, next in ipairs(node:NextPoints()) do
      search(next, results, count - 1)
    end
  end
  
  local nodes = {}
  search(self._node, nodes, actPoint)
  self:_TryCancelPreview()
  self._previewNodes = nodes
  for _, node in pairs(self._previewNodes) do
    node:SetHighLight(true)
  end
end

function SMazeState_PlayCard:_TryCancelPreview()
  if self._previewNodes and next(self._previewNodes) then
    for _, node in pairs(self._previewNodes) do
      node:SetHighLight(false)
    end
    self._previewNodes = nil
    self._previewCard = nil
  end
end

function SMazeState_PlayCard:_TransformPosEffect(cb)
  local tls = {}
  local lock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():Lock("SMazeState_PlayCard:TransformPosEffect")
  end, "锁屏")
  table.insert(tls, lock)
  local para = EZTL_Parallel:New({
    EZTL_Sequence:New({
      EZTL_Wait:New(100, "等0.1秒"),
      EZTL_Callback:New(function()
        self._manager:Player():GetModelGameObject():SetActive(false)
      end, "隐藏")
    }),
    EZTL_Callback:New(function()
      local pos = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():Position()
      self._manager:Player():PlayEffect("TransStartPoint", pos)
    end, "加载资源"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransStartPoint", 0.7)
    end, "黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para)
  local callback = EZTL_Callback:New(function()
    if cb then
      cb()
    end
  end, "传送")
  table.insert(tls, callback)
  local para2 = EZTL_Parallel:New({
    EZTL_Callback:New(function()
      self._manager:Player():GetModelGameObject():SetActive(true)
      local pos = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():Player():Position()
      self._manager:Player():PlayEffect("TransEndPoint", pos)
    end, "显示特效"),
    EZTL_Callback:New(function()
      GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "TransEndPoint", 0.7)
    end, "取消黑屏"),
    EZTL_Wait:New(700, "等0.7秒")
  }, EZTL_EndTag.All, nil, "加载资源，黑屏")
  table.insert(tls, para2)
  local unlock = EZTL_Callback:New(function()
    GameGlobal.UIStateManager():UnLock("SMazeState_PlayCard:TransformPosEffect")
  end, "解锁")
  table.insert(tls, unlock)
  local seq = EZTL_Sequence:New(tls)
  self._manager:PlayEZTL(seq)
  return seq
end
