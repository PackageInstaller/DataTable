local DormNetworkCtrl = class("DormNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local JumpManager = require("Game.Jump.JumpManager")

function DormNetworkCtrl:ctor()
  self.send_DormPurchase = {}
  self.send_DormHouseEdit = {}
  self.send_DormFntEdit = {}
  self.send_DormBindHero = {}
  self.send_RenameRoom = {}
  self.send_RoomExchangePos = {}
  self.send_SaveHeroTalk = {}
  self.send_ComfortReward = {}
  self.message = {}
  self.send_HouseRoomBindUnbind = {}
  self.send_Visit = {}
  self.send_VisitRandom = {}
  self.send_VisitFavor = {}
  self.send_VisitAvailSet = {}
end

function DormNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail, self, proto_csmsg.SC_DORM_GlobalDetail, self.SC_DORM_GlobalDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase, self, proto_csmsg.SC_DORM_DormPurchase, self.SC_DORM_DormPurchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit, self, proto_csmsg.SC_DORM_HouseEdit, self.SC_DORM_HouseEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition, self, proto_csmsg.SC_DORM_RoomDecomposition, self.SC_DORM_RoomDecomposition)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit, self, proto_csmsg.SC_DORM_RoomEdit, self.SC_DORM_RoomEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero, self, proto_csmsg.SC_DORM_BindUnbindHero, self.SC_DORM_BindUnbindHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RenameRoom, self, proto_csmsg.SC_DORM_RenameRoom, self.SC_DORM_RenameRoom)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomExchangePos, self, proto_csmsg.SC_DORM_RoomExchangePos, self.SC_DORM_RoomExchangePos)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_SaveHeroTalk, self, proto_csmsg.SC_DORM_SaveHeroTalk, self.SC_DORM_SaveHeroTalk)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_PickConfortRewards, self, proto_csmsg.SC_DORM_PickConfortRewards, self.SC_DORM_PickConfortRewards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_SystemOpenNtf, self, proto_csmsg.SC_DORM_SystemOpenNtf, self.SC_DORM_SystemOpenNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_OneKeyUnBindBindHeroes, self, proto_csmsg.SC_DORM_OneKeyUnBindBindHeroes, self.SC_DORM_OneKeyBindUnbindHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BriefDetailWhenUnlock, self, proto_csmsg.SC_DORM_BriefDetailWhenUnlock, self.SC_DORM_BriefDetailWhenUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseRoomBindUnbind, self, proto_csmsg.SC_DORM_HouseRoomBindUnbind, self.SC_DORM_HouseRoomBindUnbind)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_Visit, self, proto_csmsg.SC_DORM_Visit, self.SC_DORM_Visit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_VisitRandom, self, proto_csmsg.SC_DORM_VisitRandom, self.SC_DORM_VisitRandom)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_VisitFavor, self, proto_csmsg.SC_DORM_VisitFavor, self.SC_DORM_VisitFavor)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_VisitAvailSet, self, proto_csmsg.SC_DORM_VisitAvailSet, self.SC_DORM_VisitAvailSet)
end

function DormNetworkCtrl:CS_DORM_GlobalDetail(callBack)
  self.CS_DORM_GlobalDetailCallback = callBack
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail, proto_csmsg.CS_DORM_GlobalDetail, table.emptytable)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail, proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail)
end

function DormNetworkCtrl:SC_DORM_GlobalDetail(msg)
  local needEnterDorm = true
  if self.CS_DORM_GlobalDetailCallback ~= nil then
    needEnterDorm = self.CS_DORM_GlobalDetailCallback(msg)
    self.CS_DORM_GlobalDetailCallback = nil
  end
  if needEnterDorm then
    ControllerManager:GetController(ControllerTypeId.Dorm, true):RecvDormDetailData(msg)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function DormNetworkCtrl:CS_DORM_DormPurchase(houseId, callBack)
  self.send_DormPurchase.houseId = houseId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase, proto_csmsg.CS_DORM_DormPurchase, self.send_DormPurchase)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase)
  PlayerDataCenter.dormBriefData:SetDmHouseInUnlock(houseId, true)
end

function DormNetworkCtrl:SC_DORM_DormPurchase(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_DormPurchase error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    return
  end
  local dmCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dmCtrl then
    dmCtrl:RecvPurchaseHouse(self.send_DormPurchase.houseId)
  end
  local houseCfg = ConfigData.dorm_house[self.send_DormPurchase.houseId]
  local NoticeData = require("Game.Notice.NoticeData")
  NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.DormHouseUnlock, {
    jumpType = JumpManager.eJumpTarget.Dorm,
    argList = nil
  }, {
    houseCfg and LanguageUtil.GetLocaleText(houseCfg.name)
  }, nil))
  self:CS_DORM_BriefDetailWhenUnlock(function()
    PlayerDataCenter.dormBriefData:SetDmHouseInUnlock(self.send_DormPurchase.houseId, false)
    PlayerDataCenter.dormBriefData:CheckDmHouseUnlock()
  end)
end

function DormNetworkCtrl:CS_DORM_HouseEdit(editHouseData)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit, proto_csmsg.CS_DORM_HouseEdit, editHouseData)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit, proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit)
end

function DormNetworkCtrl:SC_DORM_HouseEdit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_HouseEdit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    success = true
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
    dormCtrl.houseCtrl:RecvHouseEdit(success, msg.data)
  end
  if PlayerDataCenter.dormBriefData ~= nil then
    PlayerDataCenter.dormBriefData:UpdateHistoryMaxComfort(msg.comfort)
  end
end

function DormNetworkCtrl:CS_DORM_RoomDecomposition(houseId, param, fromHouse)
  self.send_DormHouseEdit.houseId = houseId
  self.send_DormHouseEdit.param = param
  self.send_DormHouseEdit.pos = fromHouse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition, proto_csmsg.CS_DORM_RoomDecomposition, self.send_DormHouseEdit)
  CS.WaitNetworkResponse.Instance:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition)
end

function DormNetworkCtrl:SC_DORM_RoomDecomposition(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomDecomposition error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    success = true
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
    dormCtrl.houseCtrl:RecvHouseRoomDecompose(success, msg.data)
  end
end

function DormNetworkCtrl:CS_DORM_RoomEdit(houseId, roomPos, fntDataList, wallId, floorId, doorData, callBack)
  self.send_DormFntEdit.houseId = houseId
  self.send_DormFntEdit.roomPos = roomPos
  self.send_DormFntEdit.data = fntDataList
  self.send_DormFntEdit.wallId = wallId
  self.send_DormFntEdit.floorId = floorId
  self.send_DormFntEdit.door = doorData
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, proto_csmsg.CS_DORM_RoomEdit, self.send_DormFntEdit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit)
end

function DormNetworkCtrl:SC_DORM_RoomEdit(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomEdit erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, false)
    cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, true)
  if PlayerDataCenter.dormBriefData ~= nil then
    PlayerDataCenter.dormBriefData:UpdateHistoryMaxComfort(msg.comfort)
  end
end

function DormNetworkCtrl:CS_DORM_OneKeyBindUnbindHero(paramlist, callBack)
  self.message.data = paramlist
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes, proto_csmsg.CS_DORM_OneKeyUnBindBindHeroes, self.message)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_OneKeyUnBindBindHeroes)
end

function DormNetworkCtrl:SC_DORM_OneKeyBindUnbindHero(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_OneKeyBindUnbindHero erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes)
  end
end

function DormNetworkCtrl:CS_DORM_BindUnbindHero(heroId, bind, houseId, roomPos, elemIdx, callBack)
  self.send_DormBindHero.heroId = heroId
  self.send_DormBindHero.bindHero = bind
  self.send_DormBindHero.houseId = houseId
  self.send_DormBindHero.roomPos = roomPos
  self.send_DormBindHero.elemIdx = elemIdx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, proto_csmsg.CS_DORM_BindUnbindHero, self.send_DormBindHero)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero)
end

function DormNetworkCtrl:SC_DORM_BindUnbindHero(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_BindUnbindHero erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, false)
    cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, true)
end

function DormNetworkCtrl:CS_DORM_RenameRoom(houseId, roomPos, name, callBack)
  self.send_RenameRoom.houseId = houseId
  self.send_RenameRoom.roomPos = roomPos
  self.send_RenameRoom.name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom, proto_csmsg.CS_DORM_RenameRoom, self.send_RenameRoom)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RenameRoom)
end

function DormNetworkCtrl:SC_DORM_RenameRoom(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret == proto_csmsg_ErrorCode.None then
  elseif msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom)
  else
    local errorMsg = "DormNetworkCtrl SC_DORM_RenameRoom erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom)
  end
end

function DormNetworkCtrl:CS_DORM_RoomExchangePos(houseId, posA, posB, callBack)
  self.send_RoomExchangePos.houseId = houseId
  self.send_RoomExchangePos.posA = posA
  self.send_RoomExchangePos.posB = posB
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos, proto_csmsg.CS_DORM_RoomExchangePos, self.send_RoomExchangePos)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomExchangePos)
end

function DormNetworkCtrl:SC_DORM_RoomExchangePos(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomExchangePos erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos)
  end
end

function DormNetworkCtrl:CS_DORM_SaveHeroTalk(heroId, index)
  self.send_SaveHeroTalk.heroId = heroId
  self.send_SaveHeroTalk.index = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_SaveHeroTalk, proto_csmsg.CS_DORM_SaveHeroTalk, self.send_SaveHeroTalk)
end

function DormNetworkCtrl:SC_DORM_SaveHeroTalk(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_SaveHeroTalk erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  end
end

function DormNetworkCtrl:CS_DORM_PickConfortRewards(level, callBack)
  self.send_ComfortReward.id = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards, proto_csmsg.CS_DORM_PickConfortRewards, self.send_ComfortReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_PickConfortRewards)
end

function DormNetworkCtrl:SC_DORM_PickConfortRewards(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl:SC_DORM_PickConfortRewards erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards)
  else
    PlayerDataCenter.dormBriefData:RecordComfortPicked(self.send_ComfortReward.id)
  end
end

function DormNetworkCtrl:SC_DORM_SystemOpenNtf(msg)
  PlayerDataCenter:UpdateDormBriefData(msg.brief)
end

function DormNetworkCtrl:CS_DORM_BriefDetailWhenUnlock(callBack)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_BriefDetailWhenUnlock, proto_csmsg.CS_DORM_BriefDetailWhenUnlock, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_BriefDetailWhenUnlock, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_BriefDetailWhenUnlock)
end

function DormNetworkCtrl:SC_DORM_BriefDetailWhenUnlock(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter:UpdateDormBriefData(msg.brief)
  if not table.IsEmptyTable(msg.newUnlock) then
    MsgCenter:Broadcast(eMsgEventId.DmRoomUnlock, msg.newUnlock)
  end
end

function DormNetworkCtrl:CS_DORM_HouseRoomBindUnbind(houseId, opDic)
  self.send_HouseRoomBindUnbind.houseId = houseId
  self.send_HouseRoomBindUnbind.op = opDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind, proto_csmsg.CS_DORM_HouseRoomBindUnbind, self.send_HouseRoomBindUnbind)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind, proto_csmsg_MSG_ID.MSG_SC_DORM_HouseRoomBindUnbind)
end

function DormNetworkCtrl:SC_DORM_HouseRoomBindUnbind(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl:SC_DORM_HouseRoomBindUnbind erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind)
  end
end

function DormNetworkCtrl:CS_DORM_Visit(visiteeUserId, callBack)
  self.send_Visit.visitee = visiteeUserId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_Visit, proto_csmsg.CS_DORM_Visit, self.send_Visit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_Visit, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_Visit)
end

function DormNetworkCtrl:SC_DORM_Visit(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_OFTEN then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9358))
    elseif msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_NO_DATA then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9368))
    else
      local errorMsg = "DormNetworkCtrl:SC_DORM_Visit erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_Visit)
    local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
    if not dormCtrl:HasInDorm() then
      ControllerManager:DeleteController(ControllerTypeId.Dorm)
    end
    return
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, true)
  dormCtrl:RecvDormOtherDetailData(msg.rooms)
end

function DormNetworkCtrl:CS_DORM_VisitRandom()
  self.send_VisitRandom = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitRandom, proto_csmsg.CS_DORM_VisitRandom, self.send_VisitRandom)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitRandom, proto_csmsg_MSG_ID.MSG_SC_DORM_VisitRandom)
end

function DormNetworkCtrl:SC_DORM_VisitRandom(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_OFTEN then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9358))
    elseif msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_RANDOM_MAX then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9364))
    elseif msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_RANDOM_AIM_NO_DATA then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9364))
    else
      local errorMsg = "DormNetworkCtrl:SC_DORM_VisitRandom erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitRandom)
    return
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, true)
  dormCtrl:RecvDormOtherDetailData(msg.rooms)
end

function DormNetworkCtrl:CS_DORM_VisitFavor(aimUid, callback)
  self.send_VisitFavor.visitee = aimUid
  self.CS_DORM_VisitFavorCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitFavor, proto_csmsg.CS_DORM_VisitFavor, self.send_VisitFavor)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitFavor, proto_csmsg_MSG_ID.MSG_SC_DORM_VisitFavor)
end

function DormNetworkCtrl:SC_DORM_VisitFavor(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl:SC_DORM_VisitRandom erro:" .. tostring(msg.ret)
    if msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_FAVOR_MAX then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9363))
    else
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitFavor)
    end
    return
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm, true)
  dormCtrl.dormVisitCtrl:UpdateVisitFavor(msg)
  if self.CS_DORM_VisitFavorCallback ~= nil then
    self.CS_DORM_VisitFavorCallback()
    self.CS_DORM_VisitFavorCallback = nil
  end
end

function DormNetworkCtrl:CS_DORM_VisitAvailSet(houseId, pos, callback)
  self.send_VisitAvailSet.rooms = {}
  self.send_VisitAvailSet.rooms[houseId] = {}
  self.send_VisitAvailSet.rooms[houseId].pos = {}
  table.insert(self.send_VisitAvailSet.rooms[houseId].pos, pos)
  self.CS_DORM_VisitAvailSetCallback = callback
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitAvailSet, proto_csmsg.CS_DORM_VisitAvailSet, self.send_VisitAvailSet)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitAvailSet, nil, proto_csmsg_MSG_ID.MSG_SC_DORM_VisitAvailSet)
end

function DormNetworkCtrl:SC_DORM_VisitAvailSet(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.DORM_VISIT_AVAILSET_SAME then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(9360))
    else
      local errorMsg = "DormNetworkCtrl:SC_DORM_VisitAvailSet erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_VisitAvailSet)
    return
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dormCtrl ~= nil and dormCtrl.dormVisitCtrl ~= nil then
    dormCtrl.dormVisitCtrl:UpdateShowVisitRoomData(msg.msgCS.rooms)
  end
  if self.CS_DORM_VisitAvailSetCallback ~= nil then
    self.CS_DORM_VisitAvailSetCallback()
    self.CS_DORM_VisitAvailSetCallback = nil
  end
end

function DormNetworkCtrl:Reset()
end

return DormNetworkCtrl
