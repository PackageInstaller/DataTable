--[[ 
    爬塔副本
    @autor Jacob 
]]
module('dup.DupClimbTowerDeepPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('domainSurvey/ClimbTowerDeepPanel.prefab')
isAdapta = 1 --是否开启适配刘海
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52085))
    self:setBg("", false)
    self:setUICode(LinkCode.ChellengeDeepTower)
end

function initData(self)
    self.itemList = {}
    self.mChooseItem = 1
    self.mUpdateFrame = nil
    --最新解锁的副本
    self.newestUnlockIndex = 0
    self.scale = 1 --基础缩放 
    self.maxScale = 1--最大缩放
    self.minScale = 0.7--最小缩放
    self.oldPosition1 = { x = 0, y = 0 } --双指缩放  上一次手指1的位置
    self.oldPosition2 = { x = 0, y = 0 } --双指缩放  上一次手指2的位置 
    self.sensitivity = 0.1    -- 灵敏度

    self.mCameraTargetPos = {
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
        gs.Vector3(0, 0, 0),
    }

    self.scene = nil
    self.camera = nil

    self.cameraMovePerscent = 0.014
    self.mClickItemVo = nil

    self.closeForce = false
    self.mFxName = "arts/fx/ui/effect/fx_ui_domainSurvey_red.prefab"
    self.mNeedReshow = false
end

function configUI(self)
    self.mContent = self:getChildTrans("ContentDomain")
    self.mScrollerRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    self.mTitle = self:getChildTrans("mTitle"):GetComponent(ty.Text)
    self.mAni = self.UIObject:GetComponent(ty.Animator)

    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnFace = self:getChildGO("mBtnFace")
    self.mBtnDeep = self:getChildGO("mBtnDeep")
end

function active(self)
    super.active(self)

    if web.WebManager.platform ~= web.DEVICE_TYPE.WINDOWS then
        self:setGyroscopeWave(0.8)        --0-1越低越慢
    end
    if not self.isReshow and not dup.DupClimbTowerManager.isInElementFight then
        self.mAni:SetTrigger("enter01")
        self.mNeedReshow = false
    end
    MoneyManager:setMoneyTidList()
    self:updateItem()
    self:loadScene()
    self.mUpdateFrame = LoopManager:addFrame(2, 0, self, self.updateFrame)

    local function ChangeValue(vector2)
        if not dup.DupClimbTowerManager:getIsInDeepMainPanel() then
            return
        end
        local scrollerAnchord = self.mScrollerRect.content.anchoredPosition
        self.camera.transform.localPosition = gs.Vector3(-scrollerAnchord.x * self.cameraMovePerscent, -scrollerAnchord.y * self.cameraMovePerscent, self.camera.transform.localPosition.z)
        -- logAll(self.camera.transform.localPosition,"   4")
    end
    self.mScrollerRect.onValueChanged:AddListener(ChangeValue)

    if not dup.DupClimbTowerManager:getIsInDeepMainPanel() then
        self:updateBrain(false, false)
    end
    GameDispatcher:addEventListener(EventName.CLIMB_TOWER_CHANGE, self.updateBrain, self)
    GameDispatcher:addEventListener(EventName.CLOSE_ALL_CLIMB, self.forceCloseAll, self)
    GameDispatcher:addEventListener(EventName.FIVE_RESET, self.closeAll, self)
end

function forceCloseAll(self)
    dup.DupClimbTowerManager:setDeepPosIndex()
    dup.DupClimbTowerManager:setCameraPos()
    self.closeForce = true
    self:closeAll()
end

function loadScene(self)
    self.scene = gs.GameObject.Find("ui_main_11")
    if not self.scene then
        self.scene = UISceneBgUtil:create3DBg("arts/sceneModule/ui_main_11/prefabs/ui_main_11.prefab")
    end
    self.sceneBg = self.scene.transform:Find("nod/background2").gameObject
    self.scenePreBg = self.scene.transform:Find("nod/background").gameObject
    self.sceneBg:SetActive(true)
    self.scenePreBg:SetActive(false)
    self.mBgFxNode = self.scene.transform:Find("nod/fx")
    self.bgFx = gs.ResMgr:LoadGO("arts/fx/ui/effect/fx_ui_domainSurvey_red.prefab")
    self.bgFx.gameObject:SetActive(false)
    self.bgFx.transform:SetParent(self.mBgFxNode, false)
    self.camera = gs.CameraMgr:GetSceneCameraTrans()
    local scrollerAnchord = self.mScrollerRect.content.anchoredPosition
    self.camera.transform.localPosition = gs.Vector3(-scrollerAnchord.x * self.cameraMovePerscent, -scrollerAnchord.y * self.cameraMovePerscent, self.camera.transform.localPosition.z)
end

function deActive(self)
    super.deActive(self)
    self.sceneBg:SetActive(false)
    self.scenePreBg:SetActive(true)
    self.mScrollerRect.onValueChanged:RemoveAllListeners()
    self.camera.transform.localPosition = gs.Vector3(0, 0, 0)
    self:closeGyroscopeWave()
    self:removeItem()
    MoneyManager:setMoneyTidList()
    if self.mUpdateFrame then
        LoopManager:removeFrameByIndex(self.mUpdateFrame)
        self.mUpdateFrame = nil
    end

    UISceneBgUtil:reset()

    if (self.scene) then
        self.scene = nil
    end
    GameDispatcher:removeEventListener(EventName.CLIMB_TOWER_CHANGE, self.updateBrain, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_ALL_CLIMB, self.forceCloseAll, self)
    GameDispatcher:removeEventListener(EventName.FIVE_RESET, self.closeAll, self)
end

function initViewText(self)
    self.mTitle.text = _TT(52085)
    self:setBtnLabel(self.mBtnRank, nil, "排行榜单")
    self:setBtnLabel(self.mBtnDeep, nil, "意识表层")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnRank, self.onClickRank)
    self:addUIEvent(self.mBtnDeep, self.onClickDeep)
end

function onClickRank(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_CLIMBTOWER })
    self.mNeedReshow = true
end

function onClickDeep(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_PANEL)
    dup.DupClimbTowerManager:setInDeep(false)
end

function updateItem(self)
    if #self.itemList > 0 then
        return
    end
    self:removeItem()
    local datas = dup.DupClimbTowerManager:getDeepAreaData()
    self.newestUnlockIndex = 1
    for i, vo in pairs(datas) do
        local pos = self:getChildTrans("DomainSurveyItem_" .. i)
        local lock = not vo:getIsOpen(GameManager:getServerTime())
        local line = pos:Find("mLine")
        line.gameObject:SetActive(true)
        local lineUnlock = line:Find("mImgUnLock").gameObject
        local mImgLock = line:Find("mImgLock").gameObject

        local item = dup.DupClimbTowerDeepAreaItem:create(pos:Find("mItemGroup"), { areaVo = vo }, 1, false)
        local function clickItem()
            if vo.enterDup > dup.DupClimbTowerManager:maxDupId() then
                gs.Message.Show(_TT(121, vo.enterDup))
                gs.Message.Show("通关更高层数解锁")
            elseif dup.DupClimbTowerManager.isGmOpen == false and not vo:getIsOpen(GameManager:getServerTime()) then
                gs.Message.Show(string.substitute("该区域周{0}、{1}、{2}开放", vo.openDate[1], vo.openDate[2], vo.openDate[3]))
            elseif (dup.DupClimbTowerManager:getIsInDeepMainPanel()) then
                self.mClickItemVo = vo
                dup.DupClimbTowerManager:setDeepPosIndex(i)
                self:updateBrain(false)
            end
        end
        item:setCallBack(item, clickItem)
        table.insert(self.itemList, item)
        if (not lock) then
            self.newestUnlockIndex = self.newestUnlockIndex > i and self.newestUnlockIndex or i
        end
        lineUnlock:SetActive(not lock)
        mImgLock:SetActive(lock)
    end
    self:setGuideTrans("guide_DomainSurveyItem_1", self.itemList[1]:getTrans())
    local targetIndex = dup.DupClimbTowerManager:getDeepPosIndex()
    if (targetIndex == nil) then
        targetIndex = self.newestUnlockIndex
    end
    self:updateScrollerPos(targetIndex)
end

function updateScrollerPos(self, id)
    local pos = self:getChildTrans("DomainSurveyItem_" .. id):GetComponent(ty.RectTransform)
    local x = pos.anchoredPosition.x
    local y = pos.anchoredPosition.y
    local contentWidth = self.mScrollerRect.content.rect.width
    local contentHeigth = self.mScrollerRect.content.rect.height
    self.mScrollerRect.normalizedPosition = gs.Vector2(x / contentWidth, y / contentHeigth);
end

function updateFrame(self)
    self:checkFinger()
    -- self:checkUnlock()
    self:brainMovement()
end

function checkFinger(self)
    if gs.Application.isMobilePlatform then
        if gs.Input.touchCount == 1 then
            self.m_IsSingleFinger = true
            self.mScrollerRect.horizontal = true
            self.mScrollerRect.vertical = true
        elseif gs.Input.touchCount == 2 and (gs.Input.GetTouch(0).phase == gs.TouchPhase.Moved or gs.Input.GetTouch(1).phase == gs.TouchPhase.Moved) then
            self.mScrollerRect.horizontal = false
            self.mScrollerRect.vertical = false

            self.touch_1 = gs.Input.GetTouch(0)
            self.touch_2 = gs.Input.GetTouch(1)
            if self.m_IsSingleFinger then
                self.oldPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
                self.oldPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)

                self.oldPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
                self.oldPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)
            end

            local tempPosition1 = {}
            tempPosition1.x = gs.TransQuick:GetTouchPosition_X(self.touch_1)
            tempPosition1.y = gs.TransQuick:GetTouchPosition_Y(self.touch_1)

            local tempPosition2 = {}
            tempPosition2.x = gs.TransQuick:GetTouchPosition_X(self.touch_2)
            tempPosition2.y = gs.TransQuick:GetTouchPosition_Y(self.touch_2)

            local pos1Offset = (gs.Vector2(tempPosition1.x, tempPosition1.y) - gs.Vector2(self.oldPosition1.x, self.oldPosition1.y)).magnitude
            local pos2Offset = (gs.Vector2(tempPosition2.x, tempPosition2.y) - gs.Vector2(self.oldPosition2.x, self.oldPosition2.y)).magnitude
            local currentTouchDistance = (gs.Vector2(tempPosition1.x, tempPosition1.y) - gs.Vector2(tempPosition2.x, tempPosition2.y)).magnitude
            local lastTouchDistance = (gs.Vector2(self.oldPosition1.x, self.oldPosition1.y) - gs.Vector2(self.oldPosition2.x, self.oldPosition2.y)).magnitude

            local offset = (pos1Offset + pos2Offset) * self.sensitivity * gs.Time.deltaTime
            if currentTouchDistance > lastTouchDistance then
                offset = -offset
            end
            self.scale = self.scale - offset
            self.scale = gs.Mathf.Clamp(self.scale, self.minScale, self.maxScale)
            gs.TransQuick:Scale0(self.mContent, self.scale)

            --备份上一次触摸点的位置，用于对比
            self.oldPosition1 = tempPosition1
            self.oldPosition2 = tempPosition2
            self.m_IsSingleFinger = false
        end
    else
        if gs.UnityEngineUtil.GetMouseButton(1) == 1 and gs.UnityEngineUtil.GetMouseButton(0) == 0 then
            self.scale = self.scale + gs.Input.GetAxis("Mouse ScrollWheel") * self.sensitivity
            self.scale = gs.Mathf.Clamp(self.scale, self.minScale, self.maxScale)
            gs.TransQuick:Scale0(self.mContent, self.scale)
        end
    end

    -- 缩放大小适配
    if (dup.DupClimbTowerManager:getIsInDeepMainPanel()) then
        local pos = self.camera.transform.localPosition
        pos.z = -(1 - self.scale) * 50
        self.cameraMovePerscent = 0.014 + 0.0216 * (1 - self.scale)
        if (gs.Vector3.Distance(self.camera.transform.localPosition, pos) > 0.1) then
            self.camera.transform.localPosition = gs.Vector3.Lerp(self.camera.transform.localPosition, pos, 0.13)
        end
    end
end

function checkUnlock(self)
end

function brainMovement(self)
    if dup.DupClimbTowerManager:getCameraPos() ~= nil then
        local cameraPos = self.camera.transform.localPosition
        self.camera.transform.localPosition = gs.Vector3.Lerp(cameraPos, dup.DupClimbTowerManager:getCameraPos(), 0.1)
        if (gs.Vector3.Distance(cameraPos, dup.DupClimbTowerManager:getCameraPos()) < 0.9) then
            dup.DupClimbTowerManager:setCameraPos()
            if (not dup.DupClimbTowerManager:getIsInDeepMainPanel()) then --进入子界面 此时已经设置index
                GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_DUP_PANEL, { areaVo = self.mClickItemVo })
            end
        end
    end
end

function updateBrain(self, isMain, reset)
    local posIndex = dup.DupClimbTowerManager:getDeepPosIndex()
    if (posIndex == nil) then
        posIndex = dup.DupClimbTowerManager:maxAreaId()
        dup.DupClimbTowerManager:setCameraPos()
    end
    if not isMain then
        if (dup.DupClimbTowerManager:getDeepPosIndex() == nil) then
            dup.DupClimbTowerManager:setDeepPosIndex(posIndex)
        end
        local pos = self.mCameraTargetPos[posIndex]
        if (not reset or reset == nil) then
            dup.DupClimbTowerManager:setCameraPos(pos)
            self.mAni:SetTrigger("exit")
        else
            self.camera.transform.localPosition = pos
        end
        self:removeItem()
        for i = 1, 10 do       -- 隐藏线段
            local lineItem = self:getChildTrans("DomainSurveyItem_" .. i)
            local line = lineItem:Find("mLine")
            line.gameObject:SetActive(false)
        end
        self.bgFx.gameObject:SetActive(true)
    else
        self:updateItem()
        local scrollerAnchord = self.mScrollerRect.content.anchoredPosition
        dup.DupClimbTowerManager:setCameraPos(gs.Vector3(-scrollerAnchord.x * self.cameraMovePerscent, -scrollerAnchord.y * self.cameraMovePerscent, -(1 - self.scale) * 50))
        dup.DupClimbTowerManager:setDeepPosIndex()

        self.mAni:SetTrigger("enter01")
        self.bgFx.gameObject:SetActive(false)
    end
end

function removeItem(self)
    for i = #self.itemList, 1, -1 do
        local v = self.itemList[i]
        v:poolRecover()
        table.remove(self.itemList, i)
    end
    if self.uiGyro then
        self.uiGyro:removeGyro()
        self.uiGyro = nil
    end
end

function onClickClose(self)
    if (not dup.DupClimbTowerManager:getIsInDeepMainPanel()) then
        return
    end
    self:closeAll()
    GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, { type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE })
    -- dup.DupClimbTowerManager:setInDeep(false)
end

function closeAll(self)
    if (not dup.DupClimbTowerManager:getIsInDeepMainPanel() and not self.closeForce) then
        return
    end
    self.closeForce = false
    super.closeAll(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]