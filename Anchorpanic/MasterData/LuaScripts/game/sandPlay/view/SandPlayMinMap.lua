-- @FileName:   SandPlayMinMap.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-29 17:33:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayMinMap', Class.impl())

--可以调参数
function ctor(self)
end

function initData(self, go)
    self.m_go = go
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_go)

    local MaskMapRect = self.m_childTrans["mMaskMap"]:GetComponent(ty.RectTransform)
    self.m_MapShowW = MaskMapRect.rect.width
    self.m_MapShowH = MaskMapRect.rect.height

    self.mImgMap = self.m_childTrans["mImgMap"]
    local imgMapAutoImg = self.mImgMap:GetComponent(ty.AutoRefImage)

    self.mSceneConfigVo = sandPlay.SandPlaySceneController:getSceneConfigVo()
    imgMapAutoImg:SetImg(self.mSceneConfigVo:getMinMapPath())

    self.mImgMapRect = self.mImgMap:GetComponent(ty.RectTransform)
    self.mImgMapRect.localEulerAngles = gs.Vector3(0, 0, self.mSceneConfigVo.camera_rotation[2])

    self.m_MinMapSizeW = self.mImgMapRect.rect.width
    self.m_MinMapSizeH = self.mImgMapRect.rect.height

    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    self.mPlayerTran = playThing:getTrans()

    self.m_LowerLeft_Point = gs.GameObject.Find("LowerLeft_Point")
    self.m_UpperRight_Point = gs.GameObject.Find("UpperRight_Point")
    self.m_mapSize_width = math.abs(self.m_UpperRight_Point.transform.position.x - self.m_LowerLeft_Point.transform.position.x)
    self.m_mapSize_height = math.abs(self.m_UpperRight_Point.transform.position.z - self.m_LowerLeft_Point.transform.position.z)

    self.mNpcIconList = {}

    self:addEventListener()

    self:refreshMap()
    self:refreshNPCIcon()
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.refreshMap, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_NPC_ADD, self.onRefreshNPC, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_NPC_REMOVE, self.removeNPC, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.refreshMap, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_NPC_ADD, self.onRefreshNPC, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_NPC_REMOVE, self.removeNPC, self)
end

function refreshNPCIcon(self)
    local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
    for npcId, npcThing in pairs(npcThingList) do
        local signItem = self.mNpcIconList[npcId]
        if signItem then
            local minPos_x, minPos_y = self:getOnMinMapPos(npcThing:getPosition())
            signItem:setPos(minPos_x, minPos_y)

        end
    end
end

--更新检查NPC图标
function onRefreshNPC(self, npcThing)
    if npcThing:getData().config then
        local npcConfig = npcThing:getData().config.base_config
        local signPath = npcConfig:getSignPath()
        if signPath then
            local npc_id = npcConfig.npc_id
            local signItem = self:creatNPCSign(npc_id)

            local minPos_x, minPos_y = self:getOnMinMapPos(npcThing:getPosition())
            signItem:setPos(minPos_x, minPos_y)
            signItem:getTrans().eulerAngles = gs.VEC3_ZERO

            signItem.m_go:GetComponent(ty.AutoRefImage):SetImg(signPath)
        end
    end
end

function removeNPC(self, npc_id)
    if not self.mNpcIconList then
        return
    end

    local signItem = self.mNpcIconList[npc_id]
    if signItem then
        signItem:recover()
        self.mNpcIconList[npc_id] = nil
    end
end

function creatNPCSign(self, npc_id)
    local signItem = SimpleInsItem:create(self.m_childGos["mImgNpcMinSign"], self.mImgMap, "sandPlay_minMap_NpcSign")
    signItem.m_go.name = "npc_mapSign_" .. npc_id
    self.mNpcIconList[npc_id] = signItem

    return signItem
end

--更新主角移动
function refreshMap(self)
    gs.TransQuick:MoveRotation(self.m_childTrans["mImgPlaySign"], 0, 0, self.mPlayerTran.eulerAngles.y * -1 + self.mSceneConfigVo.camera_rotation[2])

    local offset_x, offset_y = self:getOnMapOffset(self.mPlayerTran.position)
    gs.TransQuick:Pivot(self.mImgMapRect, offset_x, offset_y)
    gs.TransQuick:UIPos(self.mImgMap, 0, 0)
end

function getOnMapOffset(self, scenePos)
    local distance_x = math.abs(scenePos.x - self.m_LowerLeft_Point.transform.position.x)
    local distance_z = math.abs(scenePos.z - self.m_LowerLeft_Point.transform.position.z)

    --算出当前位置在场景上的比例
    return distance_x / self.m_mapSize_width, distance_z / self.m_mapSize_height
end

function getOnMinMapPos(self, scenePos)
    local offset_x, offset_y = self:getOnMapOffset(scenePos)
    return offset_x * self.m_MinMapSizeW, offset_y * self.m_MinMapSizeH
end

function destroy(self)
    self:removeEventListener()
end

return _M
