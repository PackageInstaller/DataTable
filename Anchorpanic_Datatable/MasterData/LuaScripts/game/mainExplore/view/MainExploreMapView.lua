--[[ 
-----------------------------------------------------
@filename       : MainExploreMapView
@Description    : 主线探索地图View
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreMapView', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreMapView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function getAdaptaTrans(self)
    return self:getChildTrans("AdaptaGroup")
end

function initData(self)
    self.mVectorLeftBottom = {}
    self.mVectorRightTop = {}
    self.mWorldWidth = 0
    self.mWorldHeight = 0
    self.mMapRatioX = 0
    self.mMapRatioY = 0
    self.mMapHalfW = 0
    self.mMapHalfH = 0
    
    self.mPlayerIconDic = {}
    self.mStaticIconDic = {}
    self.mDynamicIconDic = {}

    self.mIsLookPlayer = nil
end

-- 初始化
function configUI(self)
    self.mUiRectTrans = self.UIObject:GetComponent(ty.RectTransform)

    self.mImgMap = self:getChildGO('mImgMap'):GetComponent(ty.AutoRefImage)
    self.mImgMapRect = self:getChildGO('mImgMap'):GetComponent(ty.RectTransform)
    self.mIconNode = self:getChildGO('mIconNode')

    local nodeLeftBottomPos = gs.GameObject.Find("LowerLeft_point").transform.position
    local nodeRightTopPos = gs.GameObject.Find("UpperRight_point").transform.position
    self.mVectorLeftBottom.x = nodeLeftBottomPos.x
    self.mVectorLeftBottom.y = nodeLeftBottomPos.z
    self.mVectorRightTop.x = nodeRightTopPos.x
    self.mVectorRightTop.y = nodeRightTopPos.z
    self.mWorldWidth = self.mVectorRightTop.x - self.mVectorLeftBottom.x
    self.mWorldHeight = self.mVectorRightTop.y - self.mVectorLeftBottom.y
    self.mMapRatioX = 0
    self.mMapRatioY = 0
    self.mMapHalfW = 0
    self.mMapHalfH = 0
end

--激活
function active(self)
    super.active(self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:addEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
    self:updateView()
    self:addUpdateFramSn()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.ADD_THING, self.onAddThingHandler, self)
    mainExplore.MainExploreSceneThingManager:removeEventListener(mainExplore.MainExploreSceneThingManager.REMOVE_THING, self.onRemoveThingHandler, self)
    self:removeUpdateFrameSn()
    self:recover()
end

function addUpdateFramSn(self)
    self:removeUpdateFrameSn()
    self.mUpdateFrameSn = LoopManager:addFrame(3, 0, self, self.onFrameUpdateHandler)
end

function removeUpdateFrameSn(self)
    if (self.mUpdateFrameSn) then
        LoopManager:removeFrameByIndex(self.mUpdateFrameSn)
        self.mUpdateFrameSn = nil
    end
end

-- 新增物件实体
function onAddThingHandler(self, thing)
    if(thing)then
        local function _clickFun()
        end
        local thingVo = thing:getThingVo()
        if (thingVo:getType() == mainExplore.ThingType.PLAYER or thingVo:getType() == mainExplore.ThingType.OTHER_PLAYER) then
            local playerConfigVo = thingVo:getPlayerConfigVo()
            if(not self.mPlayerIconDic[playerConfigVo])then
                local iconData = self:getIconData(thing, _clickFun)
                self.mPlayerIconDic[playerConfigVo] = iconData
                self:updateIcon(iconData, true)
            end
        else
            local eventConfigVo = thingVo:getEventConfigVo()
            local eventId = eventConfigVo.eventId
            if(eventConfigVo.miniIcon ~= "")then
                if(not self.mStaticIconDic[eventId] and not self.mDynamicIconDic[eventId])then
                    local iconData = self:getIconData(thing, _clickFun)
                    if (thingVo:getType() == mainExplore.ThingType.MONSTER) then
                        self.mDynamicIconDic[eventId] = iconData
                    else
                        self.mStaticIconDic[eventId] = iconData
                    end
                    self:updateIcon(iconData, true)
                end
            end
        end
    end
end

-- 移除物件实体
function onRemoveThingHandler(self, thing)
    if(thing)then
        local thingVo = thing:getThingVo()
        if (thingVo:getType() == mainExplore.ThingType.PLAYER or thingVo:getType() == mainExplore.ThingType.OTHER_PLAYER) then
            local playerConfigVo = thingVo:getPlayerConfigVo()
            local iconData = self.mPlayerIconDic[playerConfigVo]
            if(iconData)then
                iconData.item:recover()
                self.mPlayerIconDic[playerConfigVo] = nil
            end
        else
            local eventConfigVo = thingVo:getEventConfigVo()
            if(eventConfigVo.miniIcon ~= "")then
                local iconData = self.mStaticIconDic[eventConfigVo.eventId]
                if(iconData)then
                    iconData.item:recover()
                    self.mStaticIconDic[eventConfigVo.eventId] = nil
                end
            
                local iconData = self.mDynamicIconDic[eventConfigVo.eventId]
                if(iconData)then
                    iconData.item:recover()
                    self.mDynamicIconDic[eventConfigVo.eventId] = nil
                end
            end
        end
    end
end

function onFrameUpdateHandler(self, deltaTime)
    self:updateMapPos()
    self:updateIconDic()
end

function updateMapPos(self)
    if(self.mIsLookPlayer)then
        local playerPosX, playerPoxY = self:getPlayerPos()
        if(playerPosX and playerPoxY)then
            gs.TransQuick:UIPos(self.mUiRectTrans, playerPosX, playerPoxY)
        end
    end
end

function getPlayerPos(self)
    local thingVo = mainExplore.MainExplorePlayerProxy:getThingVo()
    if(thingVo)then
        local iconData = self.mPlayerIconDic[thingVo:getPlayerConfigVo()]
        if(iconData)then
            local uiPos = iconData.item:getTrans().anchoredPosition
            return -uiPos.x * (self.mMapScale or 1), -uiPos.y * (self.mMapScale or 1)
        end
    end
    return nil, nil
end

function updateIconDic(self)
    if(self.mDynamicIconDic)then
        for eventId, iconData in pairs(self.mDynamicIconDic) do
            self:updateIcon(iconData, false)
        end
    end
    if(self.mPlayerIconDic)then
        for _, iconData in pairs(self.mPlayerIconDic) do
            self:updateIcon(iconData, false)
        end
    end
end

function updateIcon(self, iconData, isInit)
    local thingVo = iconData.thing:getThingVo()
    local thingPos = thingVo:getPosition()
    gs.TransQuick:UIPos(iconData.item:getTrans(), (thingPos.x - self.mVectorLeftBottom.x) * self.mMapRatioX - self.mMapHalfW, (thingPos.z - self.mVectorLeftBottom.y) * self.mMapRatioY - self.mMapHalfH)
    if (thingVo:getType() == mainExplore.ThingType.PLAYER or thingVo:getType() == mainExplore.ThingType.OTHER_PLAYER) then
        local playerConfigVo = thingVo:getPlayerConfigVo()
        local cameraTrans = mainExplore.MainExploreCamera:getSceneCameraTrans()
        if(playerConfigVo.miniRangeEnable)then
            gs.TransQuick:SetLRotation(iconData.rotationRangeTrans, 0, 0, 360 - cameraTrans.localRotation.eulerAngles.y)
        end
        gs.TransQuick:SetLRotation(iconData.imgIconTrans, 0, 0, 360 - thingVo:getRotation().y)
        if(isInit)then
            if(playerConfigVo.miniRangeEnable)then
                local mapRatio = math.sqrt(self.mMapRatioX ^ 2 + self.mMapRatioY ^ 2)
                gs.TransQuick:SizeDelta(iconData.rectRange, playerConfigVo.findRange * mapRatio, playerConfigVo.findRange * mapRatio)
                gs.TransQuick:SetLRotation(iconData.rectRange, 0, 0, playerConfigVo.findAngle / 2)
                iconData.imgRange.fillAmount = playerConfigVo.findAngle / 360
            else
                gs.TransQuick:SizeDelta(iconData.rectRange, 0, 0)
                gs.TransQuick:SetLRotation(iconData.rectRange, 0, 0, 0)
                iconData.imgRange.fillAmount = 0
            end
            iconData.imgIcon:SetImg(UrlManager:getPackPath(playerConfigVo.miniIcon), true)
        end
    else
        local eventConfigVo = thingVo:getEventConfigVo()
        if(eventConfigVo.miniRangeEnable)then
            gs.TransQuick:SetLRotation(iconData.rotationRangeTrans, 0, 0, 360 - thingVo:getRotation().y)
        end
        -- 策划说不旋转图标了
        -- gs.TransQuick:SetLRotation(iconData.imgIconTrans, 0, 0, 360 - thingVo:getRotation().y)
        gs.TransQuick:SetLRotation(iconData.imgIconTrans, 0, 0, 0)
        if(isInit)then
            if(eventConfigVo.miniRangeEnable)then
                -- 显示交互范围
                local mapRatio = math.sqrt(self.mMapRatioX ^ 2 + self.mMapRatioY ^ 2)
                gs.TransQuick:SizeDelta(iconData.rectRange, eventConfigVo.interactRange * mapRatio, eventConfigVo.interactRange * mapRatio)
                gs.TransQuick:SetLRotation(iconData.rectRange, 0, 0, 0)
                iconData.imgRange.fillAmount = 1

                -- 显示触发视野范围
                -- local mapRatio = math.sqrt(self.mMapRatioX ^ 2 + self.mMapRatioY ^ 2)
                -- gs.TransQuick:SizeDelta(iconData.rectRange, eventConfigVo.findRange * mapRatio, eventConfigVo.findRange * mapRatio)
                -- gs.TransQuick:SetLRotation(iconData.rectRange, 0, 0, eventConfigVo.findAngle / 2)
                -- iconData.imgRange.fillAmount = eventConfigVo.findAngle / 360
            else
                gs.TransQuick:SizeDelta(iconData.rectRange, 0, 0)
                gs.TransQuick:SetLRotation(iconData.rectRange, 0, 0, 0)
                iconData.imgRange.fillAmount = 0
            end
            iconData.imgIcon:SetImg(UrlManager:getPackPath(eventConfigVo.miniIcon), true)
        end
    end
end

function updateView(self)
    local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    self.mImgMap:SetImg(UrlManager:getBgPath(mainExploreMapConfigVo.miniMap), true)
    local mapSize = self.mImgMapRect.sizeDelta
    gs.TransQuick:SizeDelta(self.mUiRectTrans, mapSize.x, mapSize.y)
    self.mMapRatioX = mapSize.x / self.mWorldWidth
    self.mMapRatioY = mapSize.y / self.mWorldHeight
    self.mMapHalfW = mapSize.x / 2
    self.mMapHalfH = mapSize.y / 2
    self:initAllEventThing()
end

function initAllEventThing(self)
    self:recover()
    local eventDic = mainExplore.MainExploreManager:getEventDic(false)
    for eventId, eventVo in pairs(eventDic) do
        local eventThingVo = mainExplore.MainExploreSceneManager:getThingVo(eventId)
        local thing = mainExplore.MainExploreSceneThingManager:getThing(eventThingVo)
        self:onAddThingHandler(thing)
    end
    self:onAddThingHandler(mainExplore.MainExplorePlayerProxy:getThing())
end

function getIconData(self, thing, clickFun)
    local item = SimpleInsItem:create(self.mIconNode, self.mImgMapRect, self.__cname .. "_point")
    local eventConfigVo = thing:getThingVo():getEventConfigVo()
    if(eventConfigVo and thing:getThingVo():getType() ~= mainExplore.ThingType.PLAYER and thing:getThingVo():getType() ~= mainExplore.ThingType.OTHER_PLAYER)then
        item:getGo().name = "icon_"  .. eventConfigVo.eventType .. "_" .. eventConfigVo.eventId
    else
        item:getGo().name = "icon_player"
    end
    local rotationRangeTrans = item:getChildTrans("mRotationRange")
    local rectRange = item:getChildGO("mImgRange"):GetComponent(ty.RectTransform)
    local imgRange = item:getChildGO("mImgRange"):GetComponent(ty.AutoRefImage)
    local imgIconTrans = item:getChildTrans("mImgIcon")
    local imgIcon = item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    item:addUIEvent("mImgClick", clickFun)

    local iconData = {}
    iconData.thing = thing
    iconData.item = item
    iconData.rotationRangeTrans = rotationRangeTrans
    iconData.rectRange = rectRange
    iconData.imgRange = imgRange
    iconData.imgIconTrans = imgIconTrans
    iconData.imgIcon = imgIcon
    return iconData
end

function forceLookPlayer(self)
    self.mIsLookPlayer = true
end

function setScale(self, scale)
    if(self.mUiRectTrans and not gs.GoUtil.IsTransNull(self.mUiRectTrans))then
        self.mMapScale = scale
        gs.TransQuick:Scale(self.mUiRectTrans, scale, scale, scale)
    end
end

function getSize(self)
    return self.mMapHalfW * 2 * (self.mMapScale or 1), self.mMapHalfH * 2 * (self.mMapScale or 1)
end

function recover(self)
    if(self.mPlayerIconDic)then
        for _, iconData in pairs(self.mPlayerIconDic) do
            iconData.item:recover()
        end
    end
    self.mPlayerIconDic = {}   

    if(self.mStaticIconDic)then
        for eventId, iconData in pairs(self.mStaticIconDic) do
            iconData.item:recover()
        end
    end
    self.mStaticIconDic = {}

    if(self.mDynamicIconDic)then
        for eventId, iconData in pairs(self.mDynamicIconDic) do
            iconData.item:recover()
        end
    end
    self.mDynamicIconDic = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
