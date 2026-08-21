-- @FileName:   SandPlayMapPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-11 11:34:28
-- @Copyright:   (LY) 2023 雷焰网络

module("game.sandPlay.view.SandPlayMapPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayMapPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("")
    self:setBg("mainExplore_bg_02.jpg", false, "mainExploreMap")
end

--析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mScrollRect = self:getChildGO('Scroll View'):GetComponent(ty.RectTransform)

    self.mMapIconTypeGroup = self:getChildTrans('mMapIconTypeGroup')
    self.mMapIconTypeItem = self:getChildGO('MapIconTypeItem')

    self.mImgMap = self:getChildGO("mImgMap"):GetComponent(ty.AutoRefImage)
    self.mImgMapRect = self.mImgMap:GetComponent(ty.RectTransform)
    self.mImgPlaySign = self:getChildTrans("mImgPlaySign")
end

function initViewText(self)
end

function addAllUIEvent(self)
end

-- 设置货币栏
function setMoneyBar(self)

end

function active(self, args)
    super.active(self, args)

    self.mSceneConfigVo = sandPlay.SandPlaySceneController:getSceneConfigVo()
    self.mImgMap:SetImg(self.mSceneConfigVo:getMinMapPath())
    self.mImgMapRect.localEulerAngles = gs.Vector3(0, 0, self.mSceneConfigVo.camera_rotation[2])

    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    self.mPlayerTran = playThing:getTrans()

    local ImgMapRect = self.mImgMap:GetComponent(ty.RectTransform)
    self.m_MinMapSizeW = ImgMapRect.rect.width
    self.m_MinMapSizeH = ImgMapRect.rect.height

    self.m_LowerLeft_Point = gs.GameObject.Find("LowerLeft_Point")
    self.m_UpperRight_Point = gs.GameObject.Find("UpperRight_Point")
    self.m_mapSize_width = math.abs(self.m_UpperRight_Point.transform.position.x - self.m_LowerLeft_Point.transform.position.x)
    self.m_mapSize_height = math.abs(self.m_UpperRight_Point.transform.position.z - self.m_LowerLeft_Point.transform.position.z)

    GameDispatcher:addEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.refreshPlayerIcon, self)

    self.m_childGos["mImgNpcMinSign"]:SetActive(false)

    self:refreshPlayerIcon()
    self:createIconList()
    self:createMinMapIcon()
end

function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SANDPLAY_PLAYERSTATE_MOVE, self.refreshPlayerIcon, self)

    self:recoverListItem()
    self:clearMinMapIcon()
end

--更新主角移动
function refreshPlayerIcon(self)
    gs.TransQuick:MoveRotation(self.mImgPlaySign, 0, 0, self.mPlayerTran.eulerAngles.y * -1 + self.mSceneConfigVo.camera_rotation[2])

    local onMinMapPos_x, onMinMapPos_y = self:getOnMinMapPos(self.mPlayerTran.position)
    gs.TransQuick:UIPos(self.mImgPlaySign, onMinMapPos_x, onMinMapPos_y)
end

function createMinMapIcon(self)
    self:clearMinMapIcon()

    local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
    for npcId, npcThing in pairs(npcThingList) do
        local npcConfig = npcThing:getData().config
        local signPath = npcConfig.base_config:getSignPath()

        if signPath then
            local signItem = SimpleInsItem:create(self.m_childGos["mImgNpcMinSign"], self.mImgMap.transform, "sandPlayMapPanel_minMap_NpcSign")
            signItem.m_go.name = "npc_mapSign_" .. npcId
            self.mMinMapIconList[npcId] = signItem

            local minPos_x, minPos_y = self:getOnMinMapPos(npcThing:getPosition())
            signItem:setPos(minPos_x, minPos_y)
            signItem:getTrans().eulerAngles = gs.VEC3_ZERO

            signItem.m_go:GetComponent(ty.AutoRefImage):SetImg(signPath)
        end
    end
end

function clearMinMapIcon(self)
    if self.mMinMapIconList then
        for _, item in pairs(self.mMinMapIconList) do
            item:recover()
        end
    end

    self.mMinMapIconList = {}
end

function createIconList(self)
    self:recoverListItem()

    local isValue = function (tab, name)
        for _, val in pairs(tab) do
            if val.name == name then
                return true
            end
        end

        return false
    end

    local signList = {}

    local playeyLabel = _TT(160)
    table.insert(signList, {sign = "arts/ui/pack/sandPlay/activity_mapPlayerSign.png", name = playeyLabel})

    local npcThingList = sandPlay.SandPlaySceneController:getAllNPCList()
    for npcId, npcThing in pairs(npcThingList) do
        local npcConfig = npcThing:getData().config
        local path = npcConfig.base_config:getSignPath()
        if path then
            local fun_name = npcConfig.base_config.fun_name
            if not isValue(signList, fun_name) then
                table.insert(signList, {sign = path, name = fun_name})
            end
        end
    end

    for i = 1, #signList do
        local item = SimpleInsItem:create(self.mMapIconTypeItem, self.mMapIconTypeGroup, "SandPlay_MapPanel_icon")
        local mMapTxt = item:getChildGO("mMapTxt"):GetComponent(ty.Text)
        local mMapIcon = item:getChildGO("mMapIcon"):GetComponent(ty.AutoRefImage)

        mMapTxt.text = signList[i].name
        mMapIcon:SetImg(signList[i].sign)

        table.insert(self.mMapIconList, item)
    end
end

-- 回收项
function recoverListItem(self)
    if(self.mMapIconList)then
        if self.mMapIconList then
            for i, item in pairs(self.mMapIconList) do
                item:recover()
            end
        end
    end
    self.mMapIconList = {}
end

function getOnMinMapPos(self, scenePos)
    local distance_x = math.abs(scenePos.x - self.m_LowerLeft_Point.transform.position.x)
    local distance_z = math.abs(scenePos.z - self.m_LowerLeft_Point.transform.position.z)

    --算出当前位置在场景上的比例
    local offset_x = (distance_x / self.m_mapSize_width) - 0.5
    local offset_y = (distance_z / self.m_mapSize_height) - 0.5

    return offset_x * self.m_MinMapSizeW, offset_y * self.m_MinMapSizeH
end

return _M
